#!/bin/bash
# 🚀 DEPLOY AUTOMATION - AUTOMATED DEPLOYMENT WITH VALIDATION
# Deploys project to Vercel/Netlify after validation gates
# Called by: n8n workflow, manual, or full-automation.sh

PROJECT_ID=$1
FORCE_DEPLOY=${2:-false}  # Set to "force" to skip validation
REGISTRY_FILE="$HOME/.claude/templates/universal-project-automation/PROJECT_REGISTRY.json"
REPORTS_DIR="$HOME/.claude/templates/universal-project-automation/reports"
SCRIPTS_DIR="$HOME/.claude/templates/universal-project-automation/scripts"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

if [ -z "$PROJECT_ID" ]; then
  echo "❌ Usage: $0 <project-id> [force]"
  echo ""
  echo "Examples:"
  echo "  $0 barukh-sagit-jewelry          # Deploy with validation"
  echo "  $0 barukh-sagit-jewelry force    # Skip validation"
  exit 1
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 DEPLOY AUTOMATION"
echo "Project: $PROJECT_ID"
echo "Timestamp: $TIMESTAMP"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Extract project data from registry
PROJECT_DATA=$(cat "$REGISTRY_FILE" | jq -r ".projects[] | select(.id == \"$PROJECT_ID\")")

if [ -z "$PROJECT_DATA" ]; then
  echo "❌ Project ID not found in registry: $PROJECT_ID"
  exit 1
fi

PROJECT_NAME=$(echo "$PROJECT_DATA" | jq -r '.name')
PROJECT_PATH=$(echo "$PROJECT_DATA" | jq -r '.path')
DEPLOYMENT_PLATFORM=$(echo "$PROJECT_DATA" | jq -r '.stack.deployment')

echo "📋 Project: $PROJECT_NAME"
echo "📂 Path: $PROJECT_PATH"
echo "🌐 Platform: $DEPLOYMENT_PLATFORM"
echo ""

# Check if project path exists
if [ -z "$PROJECT_PATH" ] || [ "$PROJECT_PATH" == "null" ]; then
  echo "❌ No project path configured in registry"
  echo "ℹ️  Update PROJECT_REGISTRY.json with correct path"
  exit 1
fi

if [ ! -d "$PROJECT_PATH" ]; then
  echo "❌ Project directory does not exist: $PROJECT_PATH"
  exit 1
fi

# Create deployment report directory
mkdir -p "$REPORTS_DIR/$PROJECT_ID/deployments/$TIMESTAMP"
DEPLOY_DIR="$REPORTS_DIR/$PROJECT_ID/deployments/$TIMESTAMP"
REPORT_FILE="$DEPLOY_DIR/deployment-report.md"

# Initialize report
cat > "$REPORT_FILE" << EOF
# Deployment Report
**Project:** $PROJECT_NAME
**Date:** $(date '+%Y-%m-%d %H:%M:%S')
**Platform:** $DEPLOYMENT_PLATFORM

---

EOF

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# STEP 1: PRE-FLIGHT VALIDATION
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

if [ "$FORCE_DEPLOY" != "force" ]; then
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "🔍 STEP 1: PRE-FLIGHT VALIDATION"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  echo "Running 4-layer validation..."
  echo ""

  # Run validation script
  bash "$SCRIPTS_DIR/validation-4layers.sh" "$PROJECT_ID"
  VALIDATION_EXIT_CODE=$?

  if [ $VALIDATION_EXIT_CODE -eq 0 ]; then
    echo ""
    echo "✅ Validation passed - proceeding with deployment"
    echo ""

    cat >> "$REPORT_FILE" << EOF
## ✅ Pre-Flight Validation: PASSED

All 4 validation layers passed successfully.

EOF
  elif [ $VALIDATION_EXIT_CODE -eq 1 ]; then
    echo ""
    echo "⚠️  Validation warnings detected"
    echo "🤔 Do you want to proceed with deployment? (y/n)"
    read -r PROCEED

    if [ "$PROCEED" != "y" ] && [ "$PROCEED" != "Y" ]; then
      echo "❌ Deployment cancelled by user"

      cat >> "$REPORT_FILE" << EOF
## ❌ Deployment Cancelled

Pre-flight validation had warnings. User chose to cancel deployment.

EOF
      exit 1
    else
      echo "⚠️  Proceeding with deployment despite warnings..."

      cat >> "$REPORT_FILE" << EOF
## ⚠️ Pre-Flight Validation: WARNING

Validation had warnings but user chose to proceed.

EOF
    fi
  else
    echo ""
    echo "❌ Validation failed - deployment blocked"
    echo "🚫 Fix validation issues before deployment"
    echo ""
    echo "To force deployment (not recommended):"
    echo "  $0 $PROJECT_ID force"

    cat >> "$REPORT_FILE" << EOF
## ❌ Deployment Blocked

Pre-flight validation failed. Deployment not allowed.

**Action Required:** Fix validation issues and try again.

EOF
    exit 1
  fi
else
  echo "⚠️  FORCE mode: Skipping validation"
  echo ""

  cat >> "$REPORT_FILE" << EOF
## ⚠️ Pre-Flight Validation: SKIPPED (FORCE MODE)

Validation was skipped. Use with caution.

EOF
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# STEP 2: BUILD & PREPARE
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🏗️  STEP 2: BUILD & PREPARE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

cd "$PROJECT_PATH" || exit 1

# Check git status
if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "📊 Git Status:"
  git status --short
  echo ""

  # Check for uncommitted changes
  if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  You have uncommitted changes"
    echo "🤔 Commit changes before deployment? (y/n)"
    read -r COMMIT_CHANGES

    if [ "$COMMIT_CHANGES" == "y" ] || [ "$COMMIT_CHANGES" == "Y" ]; then
      echo "📝 Committing changes..."
      git add .
      git commit -m "🚀 Pre-deployment commit - $TIMESTAMP

Automated commit before deployment to $DEPLOYMENT_PLATFORM

🤖 Generated with Deploy Automation
"
      echo "✅ Changes committed"
    else
      echo "⚠️  Proceeding without committing changes"
    fi
  else
    echo "✅ Working tree clean"
  fi

  # Push to remote if needed
  CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
  echo ""
  echo "📤 Pushing to remote ($CURRENT_BRANCH)..."
  git push origin "$CURRENT_BRANCH" 2>&1 || echo "⚠️  Push failed or not needed"
  echo ""
else
  echo "⚠️  Not a git repository - deploying local files"
  echo ""
fi

# Install dependencies if needed
if [ -f "package.json" ]; then
  if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    npm install
    echo ""
  else
    echo "✅ Dependencies already installed"
    echo ""
  fi
fi

# Build project
if [ -f "package.json" ]; then
  if grep -q "\"build\"" package.json; then
    echo "🏗️  Building project..."
    npm run build

    if [ $? -eq 0 ]; then
      echo "✅ Build successful"
      echo ""

      cat >> "$REPORT_FILE" << EOF
## ✅ Build: SUCCESS

Project built successfully.

EOF
    else
      echo "❌ Build failed"
      echo ""

      cat >> "$REPORT_FILE" << EOF
## ❌ Build: FAILED

Build process encountered errors. Deployment cancelled.

EOF
      exit 1
    fi
  else
    echo "ℹ️  No build script found, skipping build"
    echo ""
  fi
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# STEP 3: DEPLOY TO PLATFORM
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🌐 STEP 3: DEPLOY TO $DEPLOYMENT_PLATFORM"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

DEPLOYMENT_URL=""

# Determine deployment platform and deploy
if [[ "$DEPLOYMENT_PLATFORM" == *"vercel"* ]] || [[ "$DEPLOYMENT_PLATFORM" == *"Vercel"* ]]; then
  # ─────────────────────────────────────────
  # VERCEL DEPLOYMENT
  # ─────────────────────────────────────────

  echo "🚀 Deploying to Vercel..."
  echo ""

  # Check if vercel CLI is installed
  if ! command -v vercel &> /dev/null; then
    echo "📦 Installing Vercel CLI..."
    npm install -g vercel
  fi

  # Deploy to production
  DEPLOY_OUTPUT=$(vercel --prod --yes 2>&1)
  DEPLOY_EXIT_CODE=$?

  echo "$DEPLOY_OUTPUT"
  echo ""

  if [ $DEPLOY_EXIT_CODE -eq 0 ]; then
    # Extract deployment URL
    DEPLOYMENT_URL=$(echo "$DEPLOY_OUTPUT" | grep -o 'https://[^ ]*' | head -1)

    if [ -z "$DEPLOYMENT_URL" ]; then
      # Fallback: try to get from vercel inspect
      DEPLOYMENT_URL=$(vercel inspect --json | jq -r '.url' 2>/dev/null)
    fi

    echo "✅ Vercel deployment successful"
    echo "🌐 URL: $DEPLOYMENT_URL"
    echo ""

    # Remove password protection if enabled (per CLAUDE.md rules)
    echo "🔓 Removing password protection (ensuring public access)..."
    vercel env rm PASSWORD_PROTECTION production --yes 2>/dev/null || true
    echo ""

    cat >> "$REPORT_FILE" << EOF
## ✅ Deployment: SUCCESS (Vercel)

- **URL:** $DEPLOYMENT_URL
- **Platform:** Vercel
- **Status:** Production deployment successful
- **Access:** Public (no password protection)

EOF
  else
    echo "❌ Vercel deployment failed"
    echo ""

    cat >> "$REPORT_FILE" << EOF
## ❌ Deployment: FAILED (Vercel)

Deployment to Vercel encountered errors.

**Error Output:**
\`\`\`
$DEPLOY_OUTPUT
\`\`\`

EOF
    exit 1
  fi

elif [[ "$DEPLOYMENT_PLATFORM" == *"netlify"* ]] || [[ "$DEPLOYMENT_PLATFORM" == *"Netlify"* ]]; then
  # ─────────────────────────────────────────
  # NETLIFY DEPLOYMENT
  # ─────────────────────────────────────────

  echo "🚀 Deploying to Netlify..."
  echo ""

  # Check if netlify CLI is installed
  if ! command -v netlify &> /dev/null; then
    echo "📦 Installing Netlify CLI..."
    npm install -g netlify-cli
  fi

  # Determine build directory
  BUILD_DIR="dist"
  if [ -d ".next" ]; then
    BUILD_DIR=".next"
  elif [ -d "out" ]; then
    BUILD_DIR="out"
  elif [ -d "build" ]; then
    BUILD_DIR="build"
  fi

  # Deploy to production
  DEPLOY_OUTPUT=$(netlify deploy --prod --dir="$BUILD_DIR" 2>&1)
  DEPLOY_EXIT_CODE=$?

  echo "$DEPLOY_OUTPUT"
  echo ""

  if [ $DEPLOY_EXIT_CODE -eq 0 ]; then
    # Extract deployment URL
    DEPLOYMENT_URL=$(echo "$DEPLOY_OUTPUT" | grep -o 'https://[^ ]*' | grep netlify | head -1)

    echo "✅ Netlify deployment successful"
    echo "🌐 URL: $DEPLOYMENT_URL"
    echo ""

    cat >> "$REPORT_FILE" << EOF
## ✅ Deployment: SUCCESS (Netlify)

- **URL:** $DEPLOYMENT_URL
- **Platform:** Netlify
- **Build Directory:** $BUILD_DIR
- **Status:** Production deployment successful

EOF
  else
    echo "❌ Netlify deployment failed"
    echo ""

    cat >> "$REPORT_FILE" << EOF
## ❌ Deployment: FAILED (Netlify)

Deployment to Netlify encountered errors.

**Error Output:**
\`\`\`
$DEPLOY_OUTPUT
\`\`\`

EOF
    exit 1
  fi

else
  # ─────────────────────────────────────────
  # UNKNOWN/UNSUPPORTED PLATFORM
  # ─────────────────────────────────────────

  echo "❌ Deployment platform not supported: $DEPLOYMENT_PLATFORM"
  echo ""
  echo "Supported platforms:"
  echo "  - Vercel"
  echo "  - Netlify"
  echo ""

  cat >> "$REPORT_FILE" << EOF
## ❌ Deployment: UNSUPPORTED PLATFORM

Platform \`$DEPLOYMENT_PLATFORM\` is not yet supported.

**Supported Platforms:**
- Vercel
- Netlify

EOF
  exit 1
fi

# Save deployment URL for future validation
if [ ! -z "$DEPLOYMENT_URL" ]; then
  echo "$DEPLOYMENT_URL" > "$REPORTS_DIR/$PROJECT_ID/latest-deployment-url.txt"
  echo "$DEPLOYMENT_URL" > "$DEPLOY_DIR/deployment-url.txt"
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# STEP 4: POST-DEPLOYMENT VERIFICATION
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

if [ ! -z "$DEPLOYMENT_URL" ]; then
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "✅ STEP 4: POST-DEPLOYMENT VERIFICATION"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  # Wait for deployment to be ready
  echo "⏳ Waiting for deployment to be ready (30s)..."
  sleep 30
  echo ""

  # Check if site is accessible
  echo "🌐 Checking site accessibility..."
  HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$DEPLOYMENT_URL" 2>/dev/null)

  if [ "$HTTP_STATUS" == "200" ]; then
    echo "✅ Site is accessible (HTTP $HTTP_STATUS)"
    echo ""

    cat >> "$REPORT_FILE" << EOF
## ✅ Post-Deployment Check: PASSED

- **HTTP Status:** $HTTP_STATUS (OK)
- **Site is live and accessible**

EOF
  elif [ "$HTTP_STATUS" == "401" ] || [ "$HTTP_STATUS" == "403" ]; then
    echo "⚠️  Site is password protected (HTTP $HTTP_STATUS)"
    echo "🔓 Attempting to remove password protection..."
    echo ""

    # Try to remove protection via Vercel API
    if [[ "$DEPLOYMENT_PLATFORM" == *"vercel"* ]]; then
      vercel env rm PASSWORD_PROTECTION production --yes 2>/dev/null || true
      echo "ℹ️  Removed PASSWORD_PROTECTION env var"
      echo "ℹ️  You may need to manually disable Vercel Protection in dashboard"
    fi

    cat >> "$REPORT_FILE" << EOF
## ⚠️ Post-Deployment Check: WARNING

- **HTTP Status:** $HTTP_STATUS (Password Protected)
- **Action Required:** Disable password protection in platform dashboard

EOF
  else
    echo "⚠️  Unexpected HTTP status: $HTTP_STATUS"
    echo ""

    cat >> "$REPORT_FILE" << EOF
## ⚠️ Post-Deployment Check: WARNING

- **HTTP Status:** $HTTP_STATUS
- **Site may not be fully accessible**

EOF
  fi

  # Quick Lighthouse check (optional, just performance)
  if command -v lighthouse &> /dev/null; then
    echo "🔦 Running quick Lighthouse check..."
    lighthouse "$DEPLOYMENT_URL" \
      --only-categories=performance \
      --output json \
      --output-path "$DEPLOY_DIR/post-deploy-lighthouse.json" \
      --chrome-flags="--headless --no-sandbox" \
      --quiet 2>/dev/null

    if [ -f "$DEPLOY_DIR/post-deploy-lighthouse.report.json" ]; then
      PERF_SCORE=$(cat "$DEPLOY_DIR/post-deploy-lighthouse.report.json" | jq -r '.categories.performance.score * 100' | awk '{print int($1+0.5)}')
      echo "📊 Performance Score: $PERF_SCORE/100"
      echo ""

      cat >> "$REPORT_FILE" << EOF

**Quick Performance Check:** $PERF_SCORE/100

EOF
    fi
  fi
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# FINAL REPORT
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

cat >> "$REPORT_FILE" << EOF

---

## 🎉 Deployment Summary

**Project:** $PROJECT_NAME
**Platform:** $DEPLOYMENT_PLATFORM
**URL:** $DEPLOYMENT_URL
**Timestamp:** $TIMESTAMP

**Status:** ✅ Deployment completed successfully

### Next Steps

1. **Test the live site:** Open $DEPLOYMENT_URL and verify functionality
2. **Monitor analytics:** Check Vercel/Netlify dashboard for traffic
3. **Update baseline:** Run validation again to update baseline screenshots
4. **Notify stakeholders:** Share deployment URL with team/client

---

*Report generated by: Deploy Automation*
*Timestamp: $TIMESTAMP*
EOF

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ DEPLOYMENT COMPLETE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🎉 Project: $PROJECT_NAME"
echo "🌐 URL: $DEPLOYMENT_URL"
echo "📄 Report: $REPORT_FILE"
echo ""
echo "🚀 Deployment successful!"
echo ""

exit 0
