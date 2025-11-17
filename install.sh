#!/bin/bash
# 🚀 UNIVERSAL PROJECT AUTOMATION - MASTER INSTALLATION
# Installs and configures the complete automation system
# Run this ONCE to set up everything: n8n, WhatsApp, scripts, PATH, terminal hardcoding

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 UNIVERSAL PROJECT AUTOMATION - INSTALLATION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "This script will install and configure:"
echo "  1. n8n (workflow automation)"
echo "  2. Required CLI tools (Vercel, Netlify, Lighthouse, etc.)"
echo "  3. Automation scripts in PATH"
echo "  4. Terminal hardcoding (bash/zsh profiles)"
echo "  5. WhatsApp + Telegram integration setup"
echo ""
echo "⏱️  Estimated time: 5-10 minutes"
echo ""

# Confirm installation
read -p "Continue with installation? (y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "❌ Installation cancelled"
  exit 1
fi

INSTALL_DIR="$HOME/.claude/templates/universal-project-automation"
SCRIPTS_DIR="$INSTALL_DIR/scripts"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📦 STEP 1/7: INSTALLING NODE.JS DEPENDENCIES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
  echo "❌ Node.js not found. Please install Node.js first:"
  echo "   https://nodejs.org/"
  exit 1
fi

echo "✅ Node.js $(node -v) found"
echo ""

# Install global packages
echo "📦 Installing global npm packages..."
echo ""

PACKAGES=(
  "n8n"
  "vercel"
  "netlify-cli"
  "lighthouse"
  "pa11y"
  "sharp-cli"
  "imagemin-cli"
  "imagemin-webp"
  "imagemin-mozjpeg"
  "imagemin-pngquant"
  "playwright"
)

for package in "${PACKAGES[@]}"; do
  if npm list -g "$package" &> /dev/null; then
    echo "  ✅ $package (already installed)"
  else
    echo "  📦 Installing $package..."
    npm install -g "$package" --quiet
  fi
done

# Install Playwright browsers
echo ""
echo "📦 Installing Playwright browsers..."
npx playwright install chromium --quiet

echo ""
echo "✅ All npm packages installed"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔧 STEP 2/7: CONFIGURING PATH & ALIASES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Create automation aliases file
ALIASES_FILE="$INSTALL_DIR/automation-aliases.sh"

cat > "$ALIASES_FILE" << 'ALIASES_EOF'
#!/bin/bash
# 🤖 UNIVERSAL PROJECT AUTOMATION - ALIASES & SHORTCUTS
# Auto-loaded in terminal via .bashrc/.zshrc

# Base directory
export AUTOMATION_DIR="$HOME/.claude/templates/universal-project-automation"
export AUTOMATION_SCRIPTS="$AUTOMATION_DIR/scripts"
export AUTOMATION_REGISTRY="$AUTOMATION_DIR/PROJECT_REGISTRY.json"

# Add scripts to PATH
export PATH="$AUTOMATION_SCRIPTS:$PATH"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# PROJECT AUTOMATION ALIASES
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# List all projects
alias projects='cat $AUTOMATION_REGISTRY | jq -r ".projects[] | \"\(.id): \(.name) (\(.status))\""'

# Quick automation shortcuts
alias analyze='bash $AUTOMATION_SCRIPTS/competitor-analysis-auto.sh'
alias optimize='bash $AUTOMATION_SCRIPTS/image-optimization-auto.sh'
alias validate='bash $AUTOMATION_SCRIPTS/validation-4layers.sh'
alias deploy='bash $AUTOMATION_SCRIPTS/deploy-auto.sh'
alias automate='bash $AUTOMATION_SCRIPTS/full-automation.sh'

# Project-specific shortcuts (examples - customize as needed)
alias barukh-deploy='automate barukh-sagit-jewelry'
alias esther-deploy='automate esther-ifra-breslev'
alias keren-deploy='automate keren-rabbi-israel'

# n8n shortcuts
alias n8n-start='cd $AUTOMATION_DIR && n8n start'
alias n8n-tunnel='cd $AUTOMATION_DIR && n8n start --tunnel'

# Utility shortcuts
alias automation-logs='tail -f $AUTOMATION_DIR/n8n/.n8n/logs/n8n.log'
alias automation-status='echo "🤖 Universal Project Automation Status:" && echo "" && projects && echo "" && ps aux | grep -E "n8n|vercel|netlify" | grep -v grep'

# Help command
alias automation-help='cat << EOF
🤖 Universal Project Automation - Available Commands

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 PROJECT MANAGEMENT:
  projects                  List all projects in registry

🔧 AUTOMATION COMMANDS:
  analyze <project-id>      Run competitor analysis
  optimize <project-id>     Optimize all images
  validate <project-id>     Run 4-layer validation
  deploy <project-id>       Deploy to production
  automate <project-id>     Run full automation pipeline

🚀 QUICK SHORTCUTS:
  barukh-deploy            Full automation for Barukh Sagit
  esther-deploy            Full automation for Esther Ifrah
  keren-deploy             Full automation for Keren

📱 n8n WORKFLOWS:
  n8n-start                Start n8n locally
  n8n-tunnel               Start n8n with webhook tunnel
  automation-logs          View n8n logs

📊 STATUS:
  automation-status        Check running processes

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

For more info: https://github.com/n8n-io/n8n
EOF
'

echo "✅ Universal Project Automation loaded"
echo "   Type 'automation-help' for available commands"
ALIASES_EOF

chmod +x "$ALIASES_FILE"

echo "✅ Aliases file created: $ALIASES_FILE"
echo ""

# Add to shell profiles
PROFILES=(
  "$HOME/.bashrc"
  "$HOME/.zshrc"
  "$HOME/.bash_profile"
  "$HOME/.zprofile"
)

PROFILE_LINE="source $ALIASES_FILE  # Universal Project Automation"

for profile in "${PROFILES[@]}"; do
  if [ -f "$profile" ]; then
    if grep -q "Universal Project Automation" "$profile"; then
      echo "  ✅ Already in $profile"
    else
      echo "$PROFILE_LINE" >> "$profile"
      echo "  ✅ Added to $profile"
    fi
  fi
done

echo ""
echo "✅ Terminal profiles updated"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔗 STEP 3/7: CONFIGURING GIT & GITHUB"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
  echo "📦 Installing GitHub CLI (gh)..."
  if command -v brew &> /dev/null; then
    brew install gh
  else
    echo "⚠️  Homebrew not found. Please install gh CLI manually:"
    echo "   https://cli.github.com/"
  fi
else
  echo "✅ GitHub CLI already installed"
fi

# Check if authenticated
if gh auth status &> /dev/null; then
  echo "✅ GitHub CLI authenticated"
else
  echo "🔐 GitHub CLI not authenticated"
  echo "   Run: gh auth login"
fi

echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🤖 STEP 4/7: SETTING UP N8N"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Initialize n8n directory
N8N_DIR="$INSTALL_DIR/n8n"
mkdir -p "$N8N_DIR"

# Create n8n environment file
N8N_ENV="$N8N_DIR/.env"

if [ ! -f "$N8N_ENV" ]; then
  cat > "$N8N_ENV" << 'N8N_ENV_EOF'
# n8n Configuration
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=change_this_password

# Webhook URL (will be set after first run)
WEBHOOK_URL=http://localhost:5678

# Timezone
GENERIC_TIMEZONE=Europe/Paris

# Encryption key (generate with: openssl rand -hex 32)
N8N_ENCRYPTION_KEY=GENERATE_ME

# Database (using SQLite for simplicity)
DB_TYPE=sqlite
DB_SQLITE_VACUUM_ON_STARTUP=true

# Editor URL
N8N_EDITOR_BASE_URL=http://localhost:5678
N8N_ENV_EOF

  echo "📝 n8n environment file created: $N8N_ENV"
  echo "⚠️  IMPORTANT: Edit $N8N_ENV and change the default password!"
  echo ""
else
  echo "✅ n8n environment file already exists"
  echo ""
fi

# Import n8n workflow
WORKFLOW_FILE="$INSTALL_DIR/n8n-workflows/universal-project-workflow.json"

if [ -f "$WORKFLOW_FILE" ]; then
  mkdir -p "$N8N_DIR/.n8n/workflows"
  cp "$WORKFLOW_FILE" "$N8N_DIR/.n8n/workflows/"
  echo "✅ n8n workflow imported"
  echo ""
else
  echo "⚠️  Workflow file not found: $WORKFLOW_FILE"
  echo ""
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📱 STEP 5/7: WHATSAPP + TELEGRAM SETUP"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "📱 WhatsApp Integration (via Twilio):"
echo ""
echo "1. Create Twilio account: https://www.twilio.com/try-twilio"
echo "2. Enable WhatsApp Sandbox: https://console.twilio.com/us1/develop/sms/try-it-out/whatsapp-learn"
echo "3. Get your credentials:"
echo "   - Account SID"
echo "   - Auth Token"
echo "   - WhatsApp number (sandbox: +1 415 523 8886)"
echo ""
echo "4. Configure webhook in Twilio:"
echo "   Webhook URL: [n8n webhook URL]/universal-automation"
echo "   Method: POST"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📱 Telegram Integration (Fallback):"
echo ""
echo "1. Create Telegram bot: https://t.me/BotFather"
echo "2. Get bot token"
echo "3. Configure in n8n workflow"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Save credentials template
CREDENTIALS_FILE="$INSTALL_DIR/credentials-template.txt"

cat > "$CREDENTIALS_FILE" << 'CREDS_EOF'
# 🔐 CREDENTIALS TEMPLATE
# Fill in your credentials and keep this file secure (DO NOT COMMIT)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TWILIO (WhatsApp):
  Account SID: ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  Auth Token: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  WhatsApp Number: +14155238886 (sandbox) or your number

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TELEGRAM:
  Bot Token: 123456789:ABCdefGHIjklMNOpqrsTUVwxyz

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

VERCEL:
  API Token: (get from https://vercel.com/account/tokens)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NETLIFY:
  API Token: (get from https://app.netlify.com/user/applications)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Add these to n8n credentials in the UI after starting n8n.
CREDS_EOF

echo "📝 Credentials template created: $CREDENTIALS_FILE"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎨 STEP 6/7: TESTING AUTOMATION SCRIPTS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "🧪 Verifying script executability..."
echo ""

SCRIPTS=(
  "competitor-analysis-auto.sh"
  "image-optimization-auto.sh"
  "validation-4layers.sh"
  "deploy-auto.sh"
  "full-automation.sh"
)

for script in "${SCRIPTS[@]}"; do
  SCRIPT_PATH="$SCRIPTS_DIR/$script"
  if [ -x "$SCRIPT_PATH" ]; then
    echo "  ✅ $script"
  else
    echo "  ⚠️  $script (not executable, fixing...)"
    chmod +x "$SCRIPT_PATH"
  fi
done

echo ""
echo "✅ All scripts verified"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📚 STEP 7/7: CREATING DOCUMENTATION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

README_FILE="$INSTALL_DIR/README.md"

cat > "$README_FILE" << 'README_EOF'
# 🤖 Universal Project Automation

> Automation complète pour 25+ projets web - Déclenchée par WhatsApp/Telegram
> Système "Fronde de David" - Pour l'honneur de Dieu et d'Israël

---

## 🚀 Quick Start

### 1. Start n8n

```bash
n8n-start
# Or with public webhook:
n8n-tunnel
```

### 2. Configure Credentials in n8n

1. Open http://localhost:5678
2. Go to Credentials
3. Add Twilio credentials (WhatsApp)
4. Add Telegram credentials (fallback)
5. Add Vercel/Netlify tokens (for deployment)

### 3. Send WhatsApp Message

Send to your Twilio WhatsApp number:

```
deploy barukh
analyze esther
optimize keren
validate dreamnova
all rabbi
```

---

## 📋 Available Commands

### List Projects
```bash
projects
```

### Run Automation Steps

```bash
# Competitor analysis
analyze barukh-sagit-jewelry

# Image optimization
optimize esther-ifra-breslev

# Validation (4 layers)
validate keren-rabbi-israel

# Deploy
deploy dreamnova-v2

# Full automation (all steps)
automate rabbi-nachman-rag
```

### Quick Shortcuts

```bash
barukh-deploy    # Full automation for Barukh Sagit
esther-deploy    # Full automation for Esther Ifrah
keren-deploy     # Full automation for Keren
```

---

## 🎯 Automation Pipeline

When you run `automate <project-id>` or send "all" via WhatsApp:

1. **Competitor Analysis** 🔍
   - Screenshots of all competitors (desktop + mobile)
   - Lighthouse audits
   - Benchmark comparison
   - Gap analysis

2. **Image Optimization** 🖼️
   - Convert to WebP
   - Compress PNG/JPEG
   - Generate responsive variants
   - Auto-commit optimized images

3. **Validation (4 Layers)** ✅
   - Layer 1: Lighthouse (Performance, A11y, Best Practices, SEO)
   - Layer 2: WCAG AA Compliance (Pa11y)
   - Layer 3: Visual Regression (screenshot comparison)
   - Layer 4: Design System Compliance

4. **Deployment** 🚀
   - Pre-flight validation
   - Build project
   - Deploy to Vercel/Netlify
   - Post-deployment verification

---

## 📱 WhatsApp Integration

### Setup Twilio WhatsApp

1. Twilio Account: https://www.twilio.com/try-twilio
2. WhatsApp Sandbox: https://console.twilio.com/us1/develop/sms/try-it-out/whatsapp-learn
3. Configure webhook in n8n workflow
4. Send test message

### Message Commands

| Command | Project Keyword | Action |
|---------|----------------|--------|
| `deploy` | barukh, sagit, bijoux | Deploy Barukh Sagit |
| `analyze` | esther, ifra, breslev | Analyze Esther Ifrah |
| `optimize` | keren, rabbi, israel | Optimize Keren images |
| `validate` | dreamnova, document | Validate DreamNova |
| `all` | (any project) | Run full automation |

---

## 🏗️ Architecture

```
~/.claude/templates/universal-project-automation/
├── PROJECT_REGISTRY.json        # All projects metadata
├── scripts/
│   ├── competitor-analysis-auto.sh
│   ├── image-optimization-auto.sh
│   ├── validation-4layers.sh
│   ├── deploy-auto.sh
│   └── full-automation.sh
├── n8n-workflows/
│   └── universal-project-workflow.json
├── reports/                     # All automation reports
│   ├── barukh-sagit-jewelry/
│   ├── esther-ifra-breslev/
│   └── ...
└── n8n/                        # n8n instance
```

---

## 🎯 3 Pillars Strategy

Every project is optimized to beat ALL competitors on:

1. **Cost** 💰 - 20-50% cheaper than market leaders
2. **Functionality** ⚡ - Match or exceed competitor features
3. **Design** 🎨 - World-class (Tiffany, Stripe, Notion level)

---

## 📊 Quality Gates (4+4 Layers)

### PRE (4 Layers):
1. Deep research on internet
2. Competitor analysis
3. Design benchmarking
4. Feasibility check

### POST (4 Layers):
1. Lighthouse > 90 (all metrics)
2. WCAG AA compliance
3. Visual regression
4. Design system compliance

---

## 🔧 Troubleshooting

### n8n not starting
```bash
cd ~/.claude/templates/universal-project-automation/n8n
rm -rf .n8n/database.sqlite  # Reset database
n8n start
```

### WhatsApp webhook not working
1. Check Twilio webhook URL matches n8n webhook
2. Ensure n8n is running with public URL (use `n8n-tunnel`)
3. Test with Postman first

### Scripts not in PATH
```bash
source ~/.zshrc  # or source ~/.bashrc
automation-help
```

---

## 📚 Resources

- **n8n Docs**: https://docs.n8n.io/
- **Twilio WhatsApp**: https://www.twilio.com/docs/whatsapp
- **Lighthouse**: https://developer.chrome.com/docs/lighthouse/
- **WCAG Guidelines**: https://www.w3.org/WAI/WCAG21/quickref/

---

## 🤖 Pour l'honneur de Dieu et d'Israël

Ce système est créé avec la rigueur du béton armé.
Chaque détail compte. Chaque projet est world-class.

**Version:** 1.0.0 - BÉTON ARMÉ Edition
**Last Updated:** $(date '+%Y-%m-%d')
README_EOF

echo "✅ Documentation created: $README_FILE"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ INSTALLATION COMPLETE!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🎉 Universal Project Automation installed successfully!"
echo ""
echo "📚 Documentation: $README_FILE"
echo "🔐 Credentials Template: $CREDENTIALS_FILE"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 NEXT STEPS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "1. Reload your terminal:"
echo "   source ~/.zshrc  # or source ~/.bashrc"
echo ""
echo "2. Edit n8n configuration:"
echo "   vi $N8N_ENV"
echo "   (Change default password!)"
echo ""
echo "3. Start n8n:"
echo "   n8n-start"
echo ""
echo "4. Configure credentials in n8n UI:"
echo "   http://localhost:5678"
echo "   - Add Twilio credentials (WhatsApp)"
echo "   - Add Telegram bot token"
echo "   - Add Vercel/Netlify tokens"
echo ""
echo "5. Set up Twilio WhatsApp webhook:"
echo "   - Get n8n webhook URL from workflow"
echo "   - Configure in Twilio console"
echo ""
echo "6. Test automation:"
echo "   automation-help"
echo "   projects"
echo "   automate barukh-sagit-jewelry"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🤖 Pour l'honneur de Dieu et d'Israël - Système BÉTON ARMÉ"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
