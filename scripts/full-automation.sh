#!/bin/bash
# 🤖 FULL AUTOMATION - COMPLETE PROJECT AUTOMATION PIPELINE
# Runs ALL automation steps in sequence for a project
# Steps: Competitor Analysis → Image Optimization → Validation → Deployment
# Called by: n8n workflow (WhatsApp "all" command), manual execution

PROJECT_ID=$1
SKIP_DEPLOY=${2:-false}  # Set to "skip-deploy" to run everything except deployment
REGISTRY_FILE="$HOME/.claude/templates/universal-project-automation/PROJECT_REGISTRY.json"
REPORTS_DIR="$HOME/.claude/templates/universal-project-automation/reports"
SCRIPTS_DIR="$HOME/.claude/templates/universal-project-automation/scripts"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

if [ -z "$PROJECT_ID" ]; then
  echo "❌ Usage: $0 <project-id> [skip-deploy]"
  echo ""
  echo "Examples:"
  echo "  $0 barukh-sagit-jewelry            # Full automation with deployment"
  echo "  $0 barukh-sagit-jewelry skip-deploy  # Skip deployment step"
  echo ""
  echo "Available projects:"
  cat "$REGISTRY_FILE" | jq -r '.projects[] | "  - \(.id): \(.name)"'
  echo ""
  exit 1
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🤖 FULL AUTOMATION PIPELINE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🎯 Project: $PROJECT_ID"
echo "⏰ Started: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# Extract project data from registry
PROJECT_DATA=$(cat "$REGISTRY_FILE" | jq -r ".projects[] | select(.id == \"$PROJECT_ID\")")

if [ -z "$PROJECT_DATA" ]; then
  echo "❌ Project ID not found in registry: $PROJECT_ID"
  echo ""
  echo "Available projects:"
  cat "$REGISTRY_FILE" | jq -r '.projects[] | "  - \(.id): \(.name)"'
  echo ""
  exit 1
fi

PROJECT_NAME=$(echo "$PROJECT_DATA" | jq -r '.name')
echo "📋 Project Name: $PROJECT_NAME"
echo ""

# Create master report directory
mkdir -p "$REPORTS_DIR/$PROJECT_ID/full-automation/$TIMESTAMP"
AUTOMATION_DIR="$REPORTS_DIR/$PROJECT_ID/full-automation/$TIMESTAMP"
MASTER_REPORT="$AUTOMATION_DIR/full-automation-report.md"

# Initialize master report
cat > "$MASTER_REPORT" << EOF
# Full Automation Report
**Project:** $PROJECT_NAME ($PROJECT_ID)
**Started:** $(date '+%Y-%m-%d %H:%M:%S')
**Pipeline:** Competitor Analysis → Image Optimization → Validation → Deployment

---

EOF

# Track overall success
OVERALL_SUCCESS=1
STEPS_COMPLETED=0
STEPS_FAILED=0

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# STEP 1: COMPETITOR ANALYSIS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔍 STEP 1/4: COMPETITOR ANALYSIS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

STEP1_START=$(date +%s)

# Check if project has competitors
COMPETITOR_COUNT=$(echo "$PROJECT_DATA" | jq -r '.competitors | length')

if [ "$COMPETITOR_COUNT" -gt 0 ]; then
  echo "📊 Analyzing $COMPETITOR_COUNT competitors..."
  echo ""

  bash "$SCRIPTS_DIR/competitor-analysis-auto.sh" "$PROJECT_ID"
  STEP1_EXIT=$?

  if [ $STEP1_EXIT -eq 0 ]; then
    echo ""
    echo "✅ Step 1: Competitor Analysis COMPLETED"
    ((STEPS_COMPLETED++))

    cat >> "$MASTER_REPORT" << EOF
## ✅ Step 1: Competitor Analysis - COMPLETED

- **Competitors Analyzed:** $COMPETITOR_COUNT
- **Status:** Success
- **Report:** See \`competitor-analysis-auto.sh\` output

EOF
  else
    echo ""
    echo "❌ Step 1: Competitor Analysis FAILED"
    ((STEPS_FAILED++))
    OVERALL_SUCCESS=0

    cat >> "$MASTER_REPORT" << EOF
## ❌ Step 1: Competitor Analysis - FAILED

- **Competitors:** $COMPETITOR_COUNT
- **Status:** Failed
- **Error:** Script exited with code $STEP1_EXIT

EOF
  fi
else
  echo "ℹ️  No competitors configured, skipping analysis"
  echo ""

  cat >> "$MASTER_REPORT" << EOF
## ⊘ Step 1: Competitor Analysis - SKIPPED

No competitors configured in PROJECT_REGISTRY.json

EOF
fi

STEP1_END=$(date +%s)
STEP1_DURATION=$((STEP1_END - STEP1_START))

echo ""
echo "⏱️  Duration: ${STEP1_DURATION}s"
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# STEP 2: IMAGE OPTIMIZATION
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🖼️  STEP 2/4: IMAGE OPTIMIZATION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

STEP2_START=$(date +%s)

# Check if project has a path
PROJECT_PATH=$(echo "$PROJECT_DATA" | jq -r '.path')

if [ ! -z "$PROJECT_PATH" ] && [ "$PROJECT_PATH" != "null" ]; then
  echo "🖼️  Optimizing all images in project..."
  echo ""

  bash "$SCRIPTS_DIR/image-optimization-auto.sh" "$PROJECT_ID"
  STEP2_EXIT=$?

  if [ $STEP2_EXIT -eq 0 ]; then
    echo ""
    echo "✅ Step 2: Image Optimization COMPLETED"
    ((STEPS_COMPLETED++))

    cat >> "$MASTER_REPORT" << EOF
## ✅ Step 2: Image Optimization - COMPLETED

- **Status:** Success
- **Report:** See \`image-optimization-auto.sh\` output

EOF
  else
    echo ""
    echo "⚠️  Step 2: Image Optimization had warnings/errors"
    # Don't fail overall pipeline for image optimization issues
    ((STEPS_COMPLETED++))

    cat >> "$MASTER_REPORT" << EOF
## ⚠️ Step 2: Image Optimization - WARNING

- **Status:** Completed with warnings
- **Exit Code:** $STEP2_EXIT

EOF
  fi
else
  echo "ℹ️  No project path configured, skipping image optimization"
  echo ""

  cat >> "$MASTER_REPORT" << EOF
## ⊘ Step 2: Image Optimization - SKIPPED

No project path configured in PROJECT_REGISTRY.json

EOF
fi

STEP2_END=$(date +%s)
STEP2_DURATION=$((STEP2_END - STEP2_START))

echo ""
echo "⏱️  Duration: ${STEP2_DURATION}s"
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# STEP 3: VALIDATION (4 LAYERS)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ STEP 3/4: VALIDATION (4 LAYERS)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

STEP3_START=$(date +%s)

echo "🔍 Running 4-layer validation..."
echo ""

bash "$SCRIPTS_DIR/validation-4layers.sh" "$PROJECT_ID"
STEP3_EXIT=$?

if [ $STEP3_EXIT -eq 0 ]; then
  echo ""
  echo "✅ Step 3: Validation PASSED (all 4 layers)"
  ((STEPS_COMPLETED++))

  cat >> "$MASTER_REPORT" << EOF
## ✅ Step 3: Validation - PASSED

All 4 validation layers passed successfully:
- Layer 1: Lighthouse Audit ✅
- Layer 2: WCAG AA Compliance ✅
- Layer 3: Visual Regression ✅
- Layer 4: Design System ✅

**Status:** Ready for deployment

EOF
elif [ $STEP3_EXIT -eq 1 ]; then
  echo ""
  echo "⚠️  Step 3: Validation WARNING (some issues detected)"
  ((STEPS_COMPLETED++))

  cat >> "$MASTER_REPORT" << EOF
## ⚠️ Step 3: Validation - WARNING

Some validation layers had warnings. Review before deployment.

**Status:** Deployment allowed with caution

EOF
else
  echo ""
  echo "❌ Step 3: Validation FAILED"
  ((STEPS_FAILED++))
  OVERALL_SUCCESS=0

  cat >> "$MASTER_REPORT" << EOF
## ❌ Step 3: Validation - FAILED

Validation did not pass. Deployment blocked.

**Status:** Fix issues before deployment

EOF
fi

STEP3_END=$(date +%s)
STEP3_DURATION=$((STEP3_END - STEP3_START))

echo ""
echo "⏱️  Duration: ${STEP3_DURATION}s"
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# STEP 4: DEPLOYMENT
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

if [ "$SKIP_DEPLOY" == "skip-deploy" ]; then
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "⊘ STEP 4/4: DEPLOYMENT - SKIPPED (user requested)"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  cat >> "$MASTER_REPORT" << EOF
## ⊘ Step 4: Deployment - SKIPPED

User requested to skip deployment.

**To deploy manually:**
\`\`\`bash
bash $SCRIPTS_DIR/deploy-auto.sh $PROJECT_ID
\`\`\`

EOF
elif [ $OVERALL_SUCCESS -eq 0 ]; then
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "🚫 STEP 4/4: DEPLOYMENT - BLOCKED (validation failed)"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  echo "❌ Deployment blocked due to validation failure"
  echo "🔧 Fix validation issues first, then run:"
  echo "   bash $SCRIPTS_DIR/deploy-auto.sh $PROJECT_ID"
  echo ""

  cat >> "$MASTER_REPORT" << EOF
## 🚫 Step 4: Deployment - BLOCKED

Deployment was blocked because validation failed.

**Action Required:** Fix validation issues then deploy manually:
\`\`\`bash
bash $SCRIPTS_DIR/deploy-auto.sh $PROJECT_ID
\`\`\`

Or force deploy (not recommended):
\`\`\`bash
bash $SCRIPTS_DIR/deploy-auto.sh $PROJECT_ID force
\`\`\`

EOF
else
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "🚀 STEP 4/4: DEPLOYMENT"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  STEP4_START=$(date +%s)

  echo "🚀 Deploying to production..."
  echo ""

  bash "$SCRIPTS_DIR/deploy-auto.sh" "$PROJECT_ID"
  STEP4_EXIT=$?

  if [ $STEP4_EXIT -eq 0 ]; then
    echo ""
    echo "✅ Step 4: Deployment COMPLETED"
    ((STEPS_COMPLETED++))

    # Try to get deployment URL
    DEPLOYMENT_URL=""
    if [ -f "$REPORTS_DIR/$PROJECT_ID/latest-deployment-url.txt" ]; then
      DEPLOYMENT_URL=$(cat "$REPORTS_DIR/$PROJECT_ID/latest-deployment-url.txt")
    fi

    cat >> "$MASTER_REPORT" << EOF
## ✅ Step 4: Deployment - COMPLETED

- **Status:** Successfully deployed to production
- **URL:** $DEPLOYMENT_URL

EOF
  else
    echo ""
    echo "❌ Step 4: Deployment FAILED"
    ((STEPS_FAILED++))
    OVERALL_SUCCESS=0

    cat >> "$MASTER_REPORT" << EOF
## ❌ Step 4: Deployment - FAILED

- **Status:** Deployment encountered errors
- **Exit Code:** $STEP4_EXIT

EOF
  fi

  STEP4_END=$(date +%s)
  STEP4_DURATION=$((STEP4_END - STEP4_START))

  echo ""
  echo "⏱️  Duration: ${STEP4_DURATION}s"
  echo ""
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# FINAL SUMMARY
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PIPELINE_END=$(date +%s)
TOTAL_DURATION=$((PIPELINE_END - $(date -d "$(head -1 "$MASTER_REPORT" | grep -o '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\} [0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}')" +%s 2>/dev/null || echo $(date +%s))))

# Calculate total duration more reliably
TOTAL_DURATION=$((STEP1_DURATION + STEP2_DURATION + STEP3_DURATION))
if [ ! -z "$STEP4_DURATION" ]; then
  TOTAL_DURATION=$((TOTAL_DURATION + STEP4_DURATION))
fi

# Format duration
DURATION_MINS=$((TOTAL_DURATION / 60))
DURATION_SECS=$((TOTAL_DURATION % 60))

cat >> "$MASTER_REPORT" << EOF

---

## 📊 Pipeline Summary

**Project:** $PROJECT_NAME ($PROJECT_ID)
**Completed:** $(date '+%Y-%m-%d %H:%M:%S')
**Total Duration:** ${DURATION_MINS}m ${DURATION_SECS}s

### Steps Overview

| Step | Name | Status | Duration |
|------|------|--------|----------|
| 1 | Competitor Analysis | $([ $COMPETITOR_COUNT -gt 0 ] && echo "✅" || echo "⊘") | ${STEP1_DURATION}s |
| 2 | Image Optimization | ✅ | ${STEP2_DURATION}s |
| 3 | Validation (4 Layers) | $([ $STEP3_EXIT -eq 0 ] && echo "✅" || ([ $STEP3_EXIT -eq 1 ] && echo "⚠️" || echo "❌")) | ${STEP3_DURATION}s |
| 4 | Deployment | $([ "$SKIP_DEPLOY" == "skip-deploy" ] && echo "⊘" || ([ $OVERALL_SUCCESS -eq 0 ] && echo "🚫" || ([ $STEP4_EXIT -eq 0 ] && echo "✅" || echo "❌"))) | ${STEP4_DURATION:-0}s |

### Overall Result

EOF

if [ $OVERALL_SUCCESS -eq 1 ] && [ "$SKIP_DEPLOY" != "skip-deploy" ]; then
  cat >> "$MASTER_REPORT" << EOF
**Status:** ✅ **SUCCESS**

All automation steps completed successfully. Project is deployed to production.

EOF

  FINAL_STATUS="✅ SUCCESS"
  FINAL_EMOJI="🎉"
elif [ $OVERALL_SUCCESS -eq 1 ] && [ "$SKIP_DEPLOY" == "skip-deploy" ]; then
  cat >> "$MASTER_REPORT" << EOF
**Status:** ✅ **READY FOR DEPLOYMENT**

All pre-deployment steps completed. Run deployment manually when ready.

\`\`\`bash
bash $SCRIPTS_DIR/deploy-auto.sh $PROJECT_ID
\`\`\`

EOF

  FINAL_STATUS="✅ READY FOR DEPLOYMENT"
  FINAL_EMOJI="🚀"
else
  cat >> "$MASTER_REPORT" << EOF
**Status:** ❌ **FAILED**

Some steps failed. Review errors above and fix issues.

- **Steps Completed:** $STEPS_COMPLETED
- **Steps Failed:** $STEPS_FAILED

EOF

  FINAL_STATUS="❌ FAILED"
  FINAL_EMOJI="🔧"
fi

cat >> "$MASTER_REPORT" << EOF

---

## 📚 Detailed Reports

For detailed information about each step, see:

1. **Competitor Analysis:** \`$REPORTS_DIR/$PROJECT_ID/competitors/\`
2. **Image Optimization:** \`$REPORTS_DIR/$PROJECT_ID/image-optimization/\`
3. **Validation:** \`$REPORTS_DIR/$PROJECT_ID/validation/\`
4. **Deployment:** \`$REPORTS_DIR/$PROJECT_ID/deployments/\`

---

## 🔄 Re-running Automation

To run full automation again:
\`\`\`bash
bash $SCRIPTS_DIR/full-automation.sh $PROJECT_ID
\`\`\`

To run individual steps:
\`\`\`bash
# Competitor analysis only
bash $SCRIPTS_DIR/competitor-analysis-auto.sh $PROJECT_ID

# Image optimization only
bash $SCRIPTS_DIR/image-optimization-auto.sh $PROJECT_ID

# Validation only
bash $SCRIPTS_DIR/validation-4layers.sh $PROJECT_ID

# Deployment only
bash $SCRIPTS_DIR/deploy-auto.sh $PROJECT_ID
\`\`\`

---

*Report generated by: Full Automation Pipeline*
*Timestamp: $(date '+%Y-%m-%d %H:%M:%S')*
EOF

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# TERMINAL OUTPUT SUMMARY
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "$FINAL_EMOJI FULL AUTOMATION PIPELINE COMPLETE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🎯 Project: $PROJECT_NAME"
echo "📊 Status: $FINAL_STATUS"
echo "⏱️  Total Duration: ${DURATION_MINS}m ${DURATION_SECS}s"
echo ""
echo "📄 Full Report: $MASTER_REPORT"
echo ""

if [ $OVERALL_SUCCESS -eq 1 ]; then
  if [ "$SKIP_DEPLOY" != "skip-deploy" ]; then
    # Get deployment URL
    if [ -f "$REPORTS_DIR/$PROJECT_ID/latest-deployment-url.txt" ]; then
      DEPLOYMENT_URL=$(cat "$REPORTS_DIR/$PROJECT_ID/latest-deployment-url.txt")
      echo "🌐 Live URL: $DEPLOYMENT_URL"
      echo ""
    fi
    echo "✅ All steps completed successfully!"
  else
    echo "✅ Pre-deployment steps completed successfully!"
    echo "🚀 Ready for deployment. Run:"
    echo "   bash $SCRIPTS_DIR/deploy-auto.sh $PROJECT_ID"
  fi
else
  echo "❌ Pipeline failed. Review errors above."
  echo "📋 Steps completed: $STEPS_COMPLETED"
  echo "❌ Steps failed: $STEPS_FAILED"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Exit with appropriate code
if [ $OVERALL_SUCCESS -eq 1 ]; then
  exit 0
else
  exit 1
fi
