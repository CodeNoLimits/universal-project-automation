# 📢 MESSAGE POUR TOUS LES AGENTS (CURSOR + CLAUDE CODE)

> **Date:** 2025-11-17  
> **Priorité:** CRITIQUE  
> **À lire:** AVANT toute action sur les projets  
> **Emplacement:** `~/.claude/templates/universal-project-automation/MESSAGE_AGENTS.md`  
> **GitHub:** https://github.com/CodeNoLimits/universal-project-automation/blob/main/MESSAGE_AGENTS.md

---

## 🎯 NOUVEAU SYSTÈME D'AUTOMATION - RÈGLES ABSOLUES

Un système d'automation complet a été mis en place. **Vous DEVEZ suivre ces règles systématiquement.**

**COMMENT UTILISER CE DOCUMENT:**
1. **AVANT toute action** → Lire ce document en entier
2. **PENDANT le travail** → Référencer les sections pertinentes
3. **EN CAS DE DOUTE** → Revenir à ce document

---

## 🧠 1. CHECKPOINT MEMORY SYSTEM - FIN DES QUESTIONS RÉPÉTITIVES

### Localisation
```
/Users/codenolimits-dreamai-nanach/.claude-memory/
├── apis/           # API keys sauvegardées À VIE
├── patterns/       # Patterns design/architecture appris
├── screenshots/    # Screenshots de référence
└── benchmarks/     # Analyses sites world-class
```

### Script
```bash
/Users/codenolimits-dreamai-nanach/scripts/checkpoint-memory.sh
```

### RÈGLE #1: TOUJOURS CHECKER MEMORY AVANT DE DEMANDER

**AVANT de demander une API key, credentials, ou info déjà donnée:**

```bash
# Vérifier si API existe
bash /Users/codenolimits-dreamai-nanach/scripts/checkpoint-memory.sh get-api stripe
bash /Users/codenolimits-dreamai-nanach/scripts/checkpoint-memory.sh get-api vercel
bash /Users/codenolimits-dreamai-nanach/scripts/checkpoint-memory.sh get-api supabase-url
bash /Users/codenolimits-dreamai-nanach/scripts/checkpoint-memory.sh get-api supabase-key

# Lister toutes les APIs disponibles
bash /Users/codenolimits-dreamai-nanach/scripts/checkpoint-memory.sh recall-apis

# Lister tous les patterns appris
bash /Users/codenolimits-dreamai-nanach/scripts/checkpoint-memory.sh recall-patterns
```

**SI l'API existe → UTILISER directement**  
**SI l'API n'existe PAS → Demander UNE FOIS puis sauvegarder:**

```bash
# Sauvegarder pour toujours
bash /Users/codenolimits-dreamai-nanach/scripts/checkpoint-memory.sh save-api stripe "sk_test_xxx"
bash /Users/codenolimits-dreamai-nanach/scripts/checkpoint-memory.sh save-api vercel "token"
```

**Résultat:** Cette API ne sera PLUS JAMAIS redemandée.

---

## 🔍 2. DESIGN QA AUTOMATION - VALIDATION WORLD-CLASS OBLIGATOIRE

### Script
```bash
/Users/codenolimits-dreamai-nanach/scripts/design-qa-automation.sh
```

### RÈGLE #2: VALIDER DESIGN AVANT CHAQUE DÉPLOIEMENT

**AVANT de dire "site terminé" ou "déploiement prêt":**

```bash
# Tester design automatiquement
bash /Users/codenolimits-dreamai-nanach/scripts/design-qa-automation.sh https://url-du-site.com
```

**Critères obligatoires (Lighthouse):**
- ✅ Performance: > 90/100
- ✅ Accessibility: > 95/100
- ✅ Best Practices: > 95/100
- ✅ SEO: > 95/100
- ✅ WCAG 2.1 AA: 0 issues

**SI scores < seuils → AMÉLIORER avant déployer**  
**SI scores >= seuils → ✅ Approuver déploiement**

**JAMAIS déployer un site < 90 sur Performance ou < 95 sur les autres critères.**

---

## 🤖 3. AGENTS 26 SYSTEM - COORDINATION CURSOR ↔ CLAUDE CODE

### Template Installation
```bash
/Users/codenolimits-dreamai-nanach/.claude/templates/agents-26/install-agents.sh
```

### RÈGLE #3: UTILISER AGENTS/SYNC.MD POUR COORDINATION

**Si projet a dossier `agents/` → Système Agents 26 actif**

**Structure:**
```
projet/
└── agents/
    ├── AGENTS_INSTRUCTIONS.md  # Instructions complètes (copie de ce fichier)
    ├── SYNC.md                 # Communication temps réel
    ├── STATUS.md               # État actuel
    ├── cursor/                 # 13 agents Cursor
    └── claude-code/            # 13 agents Claude Code
```

**Workflow:**

1. **AVANT de travailler sur un fichier:**
   ```bash
   # Vérifier SYNC.md
   cat agents/SYNC.md | tail -20
   ```
   Si autre agent travaille sur même fichier → **ATTENDRE ou COORDONNER**

2. **PENDANT le travail:**
   ```bash
   # Annoncer dans SYNC.md
   echo "
   ## [$(date +%Y-%m-%d\ %H:%M)] Frontend Agent (Cursor/Claude)
   - 🔄 Currently working on: src/components/Hero.tsx
   - 🎯 Task: Adding animations to Hero component
   " >> agents/SYNC.md
   ```

3. **APRÈS commit:**
   ```bash
   # Update SYNC.md avec résumé
   echo "
   ## [$(date +%Y-%m-%d\ %H:%M)] Frontend Agent (Cursor/Claude)
   - ✅ Completed: Hero component animations
   - 📝 Files modified: src/components/Hero.tsx, styles/animations.css
   - 🔗 Other agents: Can now use <Hero /> with fade-in animation
   " >> agents/SYNC.md
   ```

**Convention Commits:**
```bash
feat(frontend): Add Hero component with animations
fix(backend): Resolve CORS issue on /api/products
style(design): Update Tailwind config luxury theme
test(payments): Add Stripe webhook tests
docs(api): Update API documentation
```

---

## 📊 4. DASHBOARD CENTRAL - MONITORING 47 PROJETS

### Localisation
```
/Users/codenolimits-dreamai-nanach/dashboard-central/
```

### RÈGLE #4: VÉRIFIER DASHBOARD AVANT DE COMMENCER

**Le dashboard montre l'état de tous les projets:**

```bash
# Lancer dashboard
cd /Users/codenolimits-dreamai-nanach/dashboard-central
npm start

# Ouvrir: http://localhost:3000
```

**Info disponible:**
- 47 projets actifs
- 8 projets urgents (priorité)
- Lighthouse scores si disponibles
- Agents 26 déployés
- Dernière activité Git

**Utiliser pour prioriser le travail sur projets urgents.**

---

## 🎯 5. WORKFLOW STANDARD POUR NOUVEAU PROJET

### Étapes Obligatoires

```bash
# 1. Créer projet
npx create-next-app@latest nom-projet --typescript --tailwind --app
cd nom-projet

# 2. Déployer Agents 26
bash /Users/codenolimits-dreamai-nanach/.claude/templates/agents-26/install-agents.sh .

# 3. Copier MESSAGE_AGENTS.md dans projet
cp ~/.claude/templates/universal-project-automation/MESSAGE_AGENTS.md agents/AGENTS_INSTRUCTIONS.md

# 4. Vérifier Memory pour APIs (ne pas redemander)
bash /Users/codenolimits-dreamai-nanach/scripts/checkpoint-memory.sh recall-apis

# 5. Développer (utiliser agents/SYNC.md pour coordination)

# 6. Build & Deploy
npm run build
vercel --prod  # ou netlify deploy --prod

# 7. Design QA OBLIGATOIRE
bash /Users/codenolimits-dreamai-nanach/scripts/design-qa-automation.sh https://url-deployée.com

# 8. Si Lighthouse >= 90/95 → ✅ Livrer
#    Sinon → Améliorer → Retester
```

---

## 🚨 6. RÈGLES NON-NÉGOCIABLES (ZÉRO EXCEPTION)

### A. AUTONOMIE TOTALE ✅

**NE PAS DEMANDER:**
- Choix de librairie (utiliser best practices connues)
- Structure de fichiers (suivre conventions projet)
- Naming (camelCase, PascalCase selon langage)
- Stack technique standard (Next.js, Tailwind, etc.)

**DEMANDER SEULEMENT SI:**
- Décision business critique (prix, tarifs, textes marketing)
- Intégration API externe nécessite credentials ET pas dans Memory
- Choix UX majeur affecte parcours utilisateur critique

### B. MEMORY FIRST ✅

**Workflow Memory:**
1. Check si info existe: `checkpoint-memory.sh get-api <service>`
2. Si existe → Utiliser
3. Si pas existe → Demander UNE FOIS → Sauvegarder immédiatement
4. Ne JAMAIS redemander info déjà sauvegardée

### C. QUALITY FIRST ✅

**Design QA obligatoire:**
- AVANT chaque déploiement
- AVANT de dire "projet terminé"
- AVANT de présenter au client

**Si Lighthouse < 90 → C'est un BLOCAGE, pas une suggestion.**

### D. COORDINATION ACTIVE ✅

**Si Agents 26 actif:**
- Toujours lire `agents/SYNC.md` avant de commencer
- Toujours updater `agents/SYNC.md` pendant et après travail
- Ne jamais modifier même fichier qu'un autre agent sans coordination

### E. API-FIRST TOUJOURS ✅

**JAMAIS dire:** "Va sur le dashboard cliquer ici"  
**TOUJOURS:** Faire via API ou CLI

Exemples:
```bash
# ❌ MAL: "Va sur Vercel dashboard ajouter env var"
# ✅ BIEN:
vercel env add STRIPE_KEY production

# ❌ MAL: "Crée manuellement un repo GitHub"
# ✅ BIEN:
gh repo create mon-projet --private --source=. --remote=origin --push

# ❌ MAL: "Ouvre Netlify et déploie"
# ✅ BIEN:
netlify deploy --prod --dir=dist
```

---

## 📖 7. DOCUMENTATION DISPONIBLE

### Localisation Principale
```
/Users/codenolimits-dreamai-nanach/Desktop/🚀 AUTOMATION SYSTEM/
```

### Fichiers Essentiels

1. **📖 LIRE EN PREMIER.md**
   - Guide complet d'utilisation
   - Exemples concrets
   - Workflows

2. **documentation/AUTOMATION_README.md**
   - Guide détaillé (100+ lignes)
   - Tous les outils expliqués

3. **documentation/MASTER_AUTOMATION_PLAN.md**
   - Plan complet (500+ lignes)
   - Architecture système
   - Tous les scripts avec code source

4. **documentation/SYSTEM_STATUS.md**
   - État actuel système
   - Ce qui est installé
   - Prochaines étapes

5. **💡 EXEMPLES.txt**
   - 7 exemples concrets d'utilisation
   - Workflows réels

---

## 🎓 8. PRINCIPES PHILOSOPHIQUES

### Les 3 Piliers

**1. AUTONOMIE TOTALE** 🤖
- Checkpoint Memory → Zéro question répétée
- Agents 26 → Coordination intelligente
- Scripts automation → Tout automatisé

**2. QUALITY WORLD-CLASS** 🏆
- Design QA systématique → Lighthouse > 90 obligatoire
- Benchmarks leaders → Tiffany, Cartier, Stripe
- Validation avant deploy → Jamais de sites "basiques"

**3. AUTOMATION FIRST** ⚡
- APIs, jamais manuel
- Scripts pour tout
- Dashboard monitoring

---

## 🔥 9. EXEMPLES CONCRETS

### Exemple 1: User Demande "Ajouter Paiements Stripe"

**AVANT (Mauvais):**
```
Agent: "Quelle est ta Stripe key?"
User: "sk_test_xxx"
Agent: "OK j'ajoute"
[30 min plus tard, autre session]
Agent: "Quelle est ta Stripe key?"
User: 😡
```

**MAINTENANT (Correct):**
```bash
# 1. Check Memory
STRIPE_KEY=$(bash ~/scripts/checkpoint-memory.sh get-api stripe 2>/dev/null)

# 2. Si existe → Utiliser
if [ ! -z "$STRIPE_KEY" ]; then
  # Utiliser directement
  echo "STRIPE_SECRET_KEY=$STRIPE_KEY" >> .env
else
  # 3. Si pas existe → Demander UNE FOIS
  echo "Stripe key non trouvée en mémoire."
  read -p "Stripe key (sera sauvegardée pour toujours): " key

  # 4. Sauvegarder immédiatement
  bash ~/scripts/checkpoint-memory.sh save-api stripe "$key"

  echo "STRIPE_SECRET_KEY=$key" >> .env
fi
```

### Exemple 2: User Demande "Finaliser Site Bijoux"

**AVANT (Mauvais):**
```
Agent: "Site terminé! Voici le lien"
User ouvre → Design médiocre, lent
User: 😡 "C'est pas niveau Tiffany"
```

**MAINTENANT (Correct):**
```bash
# 1. Build
npm run build

# 2. Deploy
vercel --prod

# 3. Attendre URL
URL=$(vercel --prod 2>&1 | grep -o 'https://[^ ]*')

# 4. Design QA AUTOMATIQUE
bash ~/scripts/design-qa-automation.sh "$URL"

# 5. Analyser résultat
# Si Lighthouse >= 90 → "✅ Site world-class, prêt à livrer"
# Si Lighthouse < 90 → "⚠️ Améliorations nécessaires: Performance 75/100..."
```

### Exemple 3: Coordination Cursor ↔ Claude Code

**Cursor Agent (Frontend):**
```bash
# 1. Avant de travailler
cat agents/SYNC.md | tail -10

# 2. Annoncer
echo "
## [2025-11-17 15:30] Frontend Agent (Cursor)
- 🔄 Working on: Hero component animations
- 📁 Files: src/components/Hero.tsx
" >> agents/SYNC.md

# 3. Travailler
# ... modifications ...

# 4. Commit
git add src/components/Hero.tsx
git commit -m "feat(frontend): Add Hero animations with framer-motion"

# 5. Update SYNC
echo "
## [2025-11-17 15:45] Frontend Agent (Cursor)
- ✅ Completed: Hero animations
- 🔗 Backend Agent: Can now test with /api/hero endpoint
" >> agents/SYNC.md
```

**Claude Code Agent (Backend):**
```bash
# 1. Lire SYNC
cat agents/SYNC.md | tail -20

# 2. Voir que Frontend a terminé Hero

# 3. Annoncer son travail
echo "
## [2025-11-17 15:50] Backend Agent (Claude Code)
- 🔄 Working on: /api/hero endpoint for Hero data
- 📁 Files: src/app/api/hero/route.ts
" >> agents/SYNC.md

# 4. Implémenter
# ... code ...

# 5. Commit & Update
git commit -m "feat(backend): Add /api/hero endpoint with caching"
echo "
## [2025-11-17 16:00] Backend Agent (Claude Code)
- ✅ Completed: /api/hero endpoint
- 📝 Returns: { title, subtitle, cta }
- 🔗 Frontend can call: fetch('/api/hero')
" >> agents/SYNC.md
```

**Résultat:** Coordination parfaite, zéro conflit, travail parallèle efficace.

---

## 🚀 10. QUICK START POUR AGENTS

### Checklist Début de Session

```bash
# 1. Lire ce document
cat ~/.claude/templates/universal-project-automation/MESSAGE_AGENTS.md

# 2. Vérifier Memory disponible
bash ~/scripts/checkpoint-memory.sh recall-apis

# 3. Si projet a Agents 26 → Lire SYNC
if [ -d "agents" ]; then
  cat agents/SYNC.md | tail -20
fi

# 4. Vérifier Dashboard pour priorités
# (mentalement noter projets urgents)

# 5. Commencer à travailler avec règles ci-dessus
```

### Checklist Avant Commit

```bash
# 1. Lint & Type check
npm run lint
npm run type-check

# 2. Tests (si applicable)
npm run test

# 3. Build test
npm run build

# 4. Update SYNC si Agents 26
if [ -d "agents" ]; then
  echo "[$(date)] <Agent>: Completed <task>" >> agents/SYNC.md
fi
```

### Checklist Avant Deploy

```bash
# 1. Build production
npm run build

# 2. Deploy
vercel --prod

# 3. DESIGN QA OBLIGATOIRE
URL="https://site.vercel.app"
bash ~/scripts/design-qa-automation.sh "$URL"

# 4. Vérifier scores
# Performance >= 90 ✅
# Accessibility >= 95 ✅
# Best Practices >= 95 ✅
# SEO >= 95 ✅

# 5. Si OK → ✅ Déploiement validé
#    Sinon → ⚠️ Améliorer d'abord
```

---

## 📞 11. SUPPORT & AIDE

**Questions système?** Vérifier dans cet ordre:

1. Ce message (`MESSAGE_AGENTS.md`)
2. `~/Desktop/🚀 AUTOMATION SYSTEM/📖 LIRE EN PREMIER.md`
3. `~/Desktop/🚀 AUTOMATION SYSTEM/documentation/AUTOMATION_README.md`
4. `agents/AGENTS_INSTRUCTIONS.md` (dans projets avec Agents 26)

**Problème technique?**
```bash
# Status système complet
bash ~/scripts/quick-start.sh all
```

---

## ⚠️ 12. AVERTISSEMENTS CRITIQUES

### ❌ NE JAMAIS:

1. **Redemander info dans Memory**
   - Check d'abord: `checkpoint-memory.sh get-api <service>`
   - Si existe → Utiliser

2. **Déployer sans Design QA**
   - TOUJOURS: `design-qa-automation.sh <URL>`
   - TOUJOURS vérifier Lighthouse >= 90/95

3. **Ignorer agents/SYNC.md**
   - Si dossier `agents/` existe → LIRE et UPDATER systématiquement

4. **Faire actions manuelles au lieu d'APIs**
   - TOUJOURS utiliser CLI/API (vercel, gh, netlify, etc.)

5. **Créer sites "basiques"**
   - SEULEMENT world-class (benchmark Tiffany, Stripe, etc.)

### ✅ TOUJOURS:

1. **Check Memory AVANT de demander**
2. **Design QA AVANT de déployer**
3. **Update SYNC.md SI Agents 26 actif**
4. **Utiliser APIs, jamais manuel**
5. **Viser Lighthouse > 90 sur tout**

---

## 🤝 13. COORDINATION AVEC CLAUDE DESKTOP

### Problème de Contexte Claude Desktop

**Claude Desktop** a un contexte limité et ne peut pas communiquer directement avec Claude Code (moi).

### Solution: SHARED_CONTEXT.md

**Workflow de coordination:**

```bash
# Emplacement du fichier de coordination
~/.claude/shared-context/SHARED_CONTEXT.md
```

**Structure:**

```markdown
# SHARED CONTEXT - Communication Claude Desktop ↔ Claude Code

## [2025-11-17 16:30] Claude Desktop → Claude Code
**Sujet:** TerraMind competitor analysis
**Données:**
- BetterHelp pricing: $60-90/week
- Talkspace: $65-99/week
- TerraMind target: $40-60/week (30% cheaper)
- Features to match: video sessions, chat 24/7, psychiatry option

**Action requise:**
- Integrate into PROJECT_REGISTRY.json
- Add to terramind-betterhelp-competitor project

## [2025-11-17 17:00] Claude Code → Claude Desktop
**Sujet:** TerraMind integration complete
**Résultat:**
- ✅ Added to PROJECT_REGISTRY.json
- ✅ Competitors benchmarked
- ✅ 3 pillars strategy defined
- 📄 See: ~/.claude/templates/universal-project-automation/PROJECT_REGISTRY.json

**Disponible pour:** Next steps (design, development)
```

### Règles de Coordination

1. **Claude Desktop écrit dans SHARED_CONTEXT.md** quand il a des infos importantes
2. **Claude Code (moi) lit SHARED_CONTEXT.md** au début de chaque session
3. **Format timestamp obligatoire:** `[YYYY-MM-DD HH:MM]`
4. **Direction explicite:** `Agent A → Agent B`
5. **Actions claires:** Toujours spécifier ce qui est attendu

### Vérifier Contexte Partagé

**AVANT chaque session:**

```bash
# Lire contexte partagé
cat ~/.claude/shared-context/SHARED_CONTEXT.md | tail -50

# Si nouvelles instructions → Agir dessus
```

### Créer Dossier si Inexistant

```bash
mkdir -p ~/.claude/shared-context
touch ~/.claude/shared-context/SHARED_CONTEXT.md
```

---

## 🛍️ 14. SHOPIFY LIQUID - CONVERSION STANDALONE ↔ SHOPIFY

### Pipeline Bidirectionnel

**Objectif:** Convertir sites standalone (React/Next.js) en thèmes Shopify (Liquid) et vice-versa.

### Scripts Disponibles

```bash
# Emplacement
~/.claude/templates/universal-project-automation/scripts/shopify-conversion/

# Standalone → Shopify
bash shopify-conversion/standalone-to-liquid.sh <project-path>

# Shopify → Standalone
bash shopify-conversion/liquid-to-standalone.sh <shopify-theme-path>
```

### Workflow: Standalone → Shopify Liquid

**Étapes automatiques:**

1. **Analyse composants React/Next.js**
   - Identifier structure pages
   - Extraire components réutilisables
   - Mapper sections Shopify

2. **Conversion en Liquid**
   ```javascript
   // React (Standalone)
   <ProductCard product={product} />

   // Liquid (Shopify)
   {% render 'product-card', product: product %}
   ```

3. **Génération structure Shopify**
   ```
   shopify-theme/
   ├── assets/
   │   ├── application.css (from Tailwind build)
   │   └── application.js (from build)
   ├── layout/
   │   └── theme.liquid (from _app.tsx)
   ├── sections/
   │   ├── hero.liquid (from Hero.tsx)
   │   └── products.liquid (from ProductGrid.tsx)
   ├── snippets/
   │   └── product-card.liquid (from ProductCard.tsx)
   └── templates/
       ├── index.liquid (from index page)
       └── product.liquid (from [id] page)
   ```

4. **Configuration Shopify**
   - Générer `config/settings_schema.json`
   - Créer sections customizables
   - Mapper Tailwind classes → Liquid variables

5. **Assets compilation**
   ```bash
   # Tailwind CSS → assets/application.css
   npm run build:css

   # JS bundle → assets/application.js
   npm run build:js
   ```

### Workflow: Shopify Liquid → Standalone

**Étapes automatiques:**

1. **Extraction Liquid en React**
   ```liquid
   <!-- Shopify Liquid -->
   {% for product in collections.all.products %}
     <div class="product">{{ product.title }}</div>
   {% endfor %}

   // React (généré)
   {products.map(product => (
     <div className="product">{product.title}</div>
   ))}
   ```

2. **Reconstruction architecture Next.js**
   - `/layout/theme.liquid` → `app/layout.tsx`
   - `/templates/*.liquid` → `app/*/page.tsx`
   - `/sections/*.liquid` → `components/sections/*`
   - `/snippets/*.liquid` → `components/*`

3. **APIs Shopify → API Routes**
   ```typescript
   // app/api/products/route.ts
   export async function GET() {
     // Remplace Liquid product loop
     const products = await shopifyClient.product.fetchAll();
     return Response.json(products);
   }
   ```

### Mapping Composants Courants

| React/Next.js | Shopify Liquid | Notes |
|---------------|----------------|-------|
| `<Image src={} alt={} />` | `{{ product \| image_url }}` | next/image → Liquid filters |
| `{products.map()}` | `{% for product in products %}` | Array iteration |
| `{condition && <Component />}` | `{% if condition %}` | Conditional rendering |
| `useState()`, `useEffect()` | Metafields + JS | State → Shopify metafields |
| Next.js routing | Liquid templates | `/products/[id]` → `product.liquid` |

### Configuration Automatique

**Settings Shopify (settings_schema.json):**

```json
{
  "name": "Theme Settings",
  "settings": [
    {
      "type": "color",
      "id": "primary_color",
      "label": "Primary Color",
      "default": "#3B82F6"
    },
    {
      "type": "font_picker",
      "id": "heading_font",
      "label": "Heading Font",
      "default": "inter"
    }
  ]
}
```

Auto-généré depuis Tailwind config.

### Déploiement Shopify

**Après conversion:**

```bash
# Install Shopify CLI
npm install -g @shopify/cli @shopify/theme

# Login
shopify auth login

# Push theme
cd shopify-theme
shopify theme push --unpublished

# Preview
shopify theme dev
```

### Règles de Conversion

1. **TOUJOURS préserver design** - Pixel-perfect conversion
2. **TOUJOURS optimiser assets** - WebP, compression, lazy loading
3. **TOUJOURS tester Lighthouse** - Shopify theme doit aussi avoir >90
4. **TOUJOURS créer sections customizables** - Clients doivent pouvoir éditer

---

## 📢 15. PIPELINE MARKETING AUTOMATIQUE

### Déclenchement Automatique

**Quand un projet est terminé** (validation 4 layers passée), le pipeline marketing se lance automatiquement.

### Workflow Marketing Complet

```bash
# Script principal
~/.claude/templates/universal-project-automation/scripts/marketing-automation.sh

# Usage
bash marketing-automation.sh <project-id>
```

### 4 Layers de Deep Research Marketing

**AVANT de créer contenu, recherche approfondie obligatoire:**

#### Layer 1: Analyse Concurrents Marketing

```bash
# WebSearch pour chaque concurrent
"How does [Competitor] market their product"
"[Competitor] marketing strategy analysis"
"[Competitor] social media presence"

# Exemple pour bijoux (Barukh Sagit):
- Tiffany marketing: Instagram luxury storytelling, influencers
- Cartier: Héritage, artisanat, exclusivité
- Mejuri: Direct-to-consumer, everyday luxury, UGC
```

**Résultat:** Document `marketing-research/competitors-strategy.md`

#### Layer 2: Best Practices Domaine

```bash
# WebSearch best practices
"Best marketing strategies for [industry] 2025"
"Organic growth tactics [industry]"
"Paid advertising benchmarks [industry]"

# Exemple bijoux:
- Instagram Reels: 3x engagement vs posts
- UGC (User Generated Content): 5x ROI
- Email marketing: 42:1 ROI
- Pinterest: 89% utilisateurs planifient achats
```

**Résultat:** Document `marketing-research/best-practices.md`

#### Layer 3: Plateformes & Outils

```bash
# WebSearch outils marketing
"Best social media management tools 2025"
"Metricool vs Hootsuite vs Buffer comparison"
"Organic reach strategies Instagram TikTok LinkedIn"

# Recommandations:
- Metricool: Scheduling, analytics, competitor tracking
- Canva: Visuels professionnels rapides
- CapCut: Vidéos TikTok/Reels
- Klaviyo/Mailchimp: Email marketing
- Google Analytics 4: Tracking conversions
```

**Résultat:** Document `marketing-research/tools-comparison.md`

#### Layer 4: ROI & Budget Optimization

```bash
# WebSearch ROI benchmarks
"Average ROI [industry] social media advertising"
"Cost per acquisition [industry] 2025"
"Organic vs paid social media ROI"

# Exemple bijoux:
- Instagram Ads: $5-15 CPA
- Google Shopping: $8-25 CPA
- Organic Instagram: $0 CPA, 2-3% conversion
- Email: $0.50 CPA (remarketing)
```

**Résultat:** Document `marketing-research/roi-budget.md`

### Génération Automatique de Contenu

**Après deep research, création contenu multi-plateforme:**

#### Instagram

```bash
# 30 posts générés automatiquement
marketing-content/instagram/
├── post-01-hero-product.md
├── post-02-behind-scenes.md
├── post-03-customer-testimonial.md
├── ...
└── post-30-special-offer.md

# Format chaque post:
---
Platform: Instagram
Type: Carousel/Reel/Static
Caption: [Text with emojis, hooks, CTA]
Hashtags: [30 hashtags stratégiques]
Schedule: [Optimal posting time]
Image/Video: [Specs + design brief]
---
```

**Hooks testés:**
- Questions: "Quel bijou reflète ta personnalité?"
- Social proof: "10,000+ clientes nous font confiance"
- Urgency: "Dernières 24h - 30% OFF"
- Storytelling: "L'histoire de ce diamant éthique..."

#### TikTok

```bash
# 20 vidéos TikTok concepts
marketing-content/tiktok/
├── video-01-unboxing.md
├── video-02-jewelry-styling.md
├── video-03-day-to-night.md
├── ...
└── video-20-customer-surprise.md

# Format:
---
Platform: TikTok
Duration: 15-30s
Hook (3s): [Text overlay + voiceover]
Body (20s): [Visual sequence]
CTA (5s): [Link in bio, promo code]
Sounds: [Trending audio suggestions]
Effects: [CapCut templates]
---
```

**Trends à exploiter:**
- Get Ready With Me (GRWM) + jewelry
- Transformation (before/after with accessories)
- Satisfying (jewelry making process)
- Duets/Stitches (customer reactions)

#### LinkedIn (B2B si applicable)

```bash
# 15 posts LinkedIn
marketing-content/linkedin/
├── post-01-company-story.md
├── post-02-industry-insights.md
├── post-03-case-study.md
├── ...
└── post-15-thought-leadership.md

# Format professionnel:
---
Platform: LinkedIn
Type: Text/Document/Video
Tone: Professional, storytelling
Target: [B2B decision makers / B2C if relevant]
Value proposition: [Clear benefit]
---
```

**Sujets B2B (exemple DreamNova):**
- "How AI transformed our consulting process"
- "McKinsey-as-a-Service: Case study with 50% cost reduction"
- "RAPID-IA methodology: Complete guide"

#### Pinterest

```bash
# 25 pins (si applicable - bijoux, déco, food)
marketing-content/pinterest/
├── pin-01-product-flat-lay.md
├── pin-02-style-guide.md
├── pin-03-gift-ideas.md
├── ...
└── pin-25-seasonal-collection.md

# Format:
---
Platform: Pinterest
Board: [Board name]
Title: [SEO optimized, 100 chars]
Description: [500 chars, keywords]
Link: [Product page URL]
Image specs: 1000x1500px vertical
---
```

#### Facebook

```bash
# 20 posts Facebook
marketing-content/facebook/
├── post-01-community-building.md
├── post-02-event-announcement.md
├── post-03-user-generated-content.md
├── ...
└── post-20-milestone-celebration.md
```

#### Email Marketing

```bash
# 10 email campaigns
marketing-content/email/
├── welcome-series-01.md (Welcome)
├── welcome-series-02.md (Education)
├── welcome-series-03.md (Offer)
├── abandoned-cart.md
├── post-purchase-01.md
├── post-purchase-02.md (Review request)
├── re-engagement.md
├── vip-exclusive.md
├── seasonal-promotion.md
└── newsletter-template.md

# Chaque email:
---
Subject line: [A/B test variants]
Preview text: [Mobile-optimized]
Body: [HTML + Plain text]
CTA: [Primary action]
Personalization: [Dynamic fields]
---
```

### Metricool Integration

**Configuration automatique:**

```bash
# Setup Metricool API
export METRICOOL_API_KEY="your-key"

# Script scheduling
bash marketing-automation.sh --schedule <project-id>

# Actions automatiques:
# 1. Upload tous les posts générés
# 2. Schedule selon meilleurs horaires
# 3. Track analytics
# 4. Générer rapports hebdomadaires
```

**Meilleurs horaires (auto-détectés par Metricool):**

- Instagram: Lun-Ven 10h-11h, 19h-21h
- TikTok: Mar-Jeu 18h-20h
- LinkedIn: Mar-Jeu 8h-9h, 12h-13h
- Facebook: Mer-Ven 13h-16h
- Pinterest: Sam-Dim 20h-22h

### Paid Advertising Automatique

**Génération automatique de campagnes:**

#### Facebook/Instagram Ads

```json
{
  "campaign": "Barukh Sagit - Product Launch",
  "budget": "$500/month",
  "targeting": {
    "age": "25-45",
    "gender": "Women",
    "interests": ["Jewelry", "Luxury", "Fashion"],
    "locations": ["France", "Israel"]
  },
  "creatives": [
    {
      "type": "carousel",
      "images": ["product-1.jpg", "product-2.jpg", "..."],
      "headline": "Bijoux Éthiques Faits Main",
      "description": "30% OFF - Première Commande",
      "cta": "Shop Now"
    }
  ],
  "pixel_events": ["ViewContent", "AddToCart", "Purchase"]
}
```

**Fichier généré:** `marketing-content/ads/facebook-campaign.json`

#### Google Ads (Shopping + Search)

```json
{
  "campaign_type": "Shopping",
  "products": "All jewelry products",
  "budget": "$30/day",
  "target_roas": "400%",
  "bid_strategy": "Maximize conversion value",
  "locations": ["France", "Belgium", "Switzerland"],
  "negative_keywords": ["cheap", "fake", "replica"]
}
```

**Fichier généré:** `marketing-content/ads/google-shopping.json`

### Reporting Automatique

**Génération rapports hebdomadaires:**

```bash
# Rapport complet
bash marketing-automation.sh --report <project-id>

# Contenu:
# - Reach organique vs payant
# - Engagement rate par plateforme
# - CPA (Cost Per Acquisition)
# - ROI campagnes payantes
# - Top performing posts
# - Recommandations optimisation
```

**Envoi automatique par email (Resend/SendGrid):**

```javascript
// Destinataires: User + stakeholders
// Fréquence: Hebdomadaire (lundi 9h)
// Format: PDF + Dashboard link
```

### Checklist Avant Lancement Marketing

```bash
# 1. Deep research 4 layers terminée ✅
# 2. Contenu 100+ posts généré ✅
# 3. Metricool configuré ✅
# 4. Pixels installés (Facebook, GA4) ✅
# 5. Email automation configurée ✅
# 6. Budget alloué ✅
# 7. KPIs définis ✅
```

---

## 🌐 16. DREAMNOVA ECOSYSTEM INTEGRATION

### Vision Ecosystem

**DreamNova est un ÉCOSYSTÈME**, pas des projets isolés:

1. **Formation en ligne** → Enseigner l'IA aux entreprises/individus
2. **Consulting DreamNova** → Appliquer IA pour transformer businesses
3. **4 Sites Web** → Outils et showcases du consulting

### Les 4 Sites DreamNova

#### 1. Dream Nova Consult
**URL:** tmptroeq.gensparkspace.com
**Type:** Site vitrine consulting IA
**Mission:** "RAPID-IA" methodology - Transformer entreprises avec IA

**Services:**
- Audit IA Express (1.5K€)
- Intégration IA Basique (7.5K€)
- Transformation IA Complète (50-100K€)

**Tech Stack:** Tailwind CSS, GA4, Lead forms

**Rôle ecosystem:** Point d'entrée consulting

#### 2. PrimaPAC
**URL:** primapac.netlify.app
**Type:** Lead generation panneaux solaires
**Mission:** Générer leads qualifiés pour installateurs

**Fonctionnalités:**
- Simulateur économies énergétiques
- Formulaire multi-étapes
- Aides jusqu'à 11,000€

**Tech Stack:** React, Netlify Forms, WhatsApp integration

**Rôle ecosystem:** Démo d'automatisation lead gen pour consulting

#### 3. Dream Nova Global
**URL:** katkzhby.gensparkspace.com
**Type:** Plateforme B2B partenariats
**Mission:** "McKinsey-as-a-Service" - Consulting accessible

**Services:**
- Starter (499€/mois): 2 sessions, analyses IA
- Professional (1,997€/mois): 4 sessions, stratégie complète
- Enterprise (4,997€/mois): Illimité, équipe dédiée

**Tech Stack:** Claude 3.5 Sonnet, Tailwind, PayPal, GA4

**Rôle ecosystem:** Offre consulting récurrente

#### 4. Dream Nova Social
**URL:** keeunzii.gensparkspace.com
**Type:** Plateforme communautaire
**Mission:** "LinkedIn for dreams" - Communauté entraide

**Fonctionnalités:**
- Profils utilisateurs
- Partage rêves/projets
- IA coaching (freemium)
- Communauté support

**Tech Stack:** React, Community features, IA integration

**Rôle ecosystem:** Acquisition utilisateurs + upsell vers consulting

### Stratégie Marketing Ecosystem

**Funnel unifié:**

```
1. Acquisition (Organic + Paid)
   ↓
2. Entry Points:
   - Dream Nova Social (gratuit) → Community
   - PrimaPAC (lead magnet) → Simulation gratuite
   - Articles/Formations → Lead magnets gratuits
   ↓
3. Nurturing:
   - Email sequences éducatives
   - Webinars gratuits IA
   - Case studies DreamNova
   ↓
4. Conversion:
   - Dream Nova Consult (projets one-shot)
   - Dream Nova Global (abonnements récurrents)
   ↓
5. Retention:
   - Dream Nova Social (communauté)
   - Formations continues
   - Success stories
```

### Positionnement Unifié

**Message principal:**
> "DreamNova transforme votre business avec l'IA - Sans les prix McKinsey"

**Différenciateurs:**
- **Prix:** 50-70% moins cher que McKinsey/BCG
- **Rapidité:** RAPID-IA methodology (résultats en semaines, pas mois)
- **Accessibilité:** From 499€/mois (vs 50K€+ traditionnels)
- **Technologie:** Claude 3.5 Sonnet, outils IA propriétaires
- **Communauté:** Pas juste consulting, écosystème support

### Marketing Cross-Platform

**Chaque site DreamNova partage:**

1. **Blog central** (SEO)
   - Articles "How to use AI for [industry]"
   - Case studies clients
   - Guides gratuits téléchargeables

2. **Social media unifié**
   - Instagram: @dreamnova.ai (storytelling, behind-scenes)
   - LinkedIn: DreamNova (thought leadership, B2B)
   - TikTok: @dreamnovaai (IA explained simply, viral)
   - YouTube: DreamNova (tutorials, webinars)

3. **Email marketing centralisé**
   - Newsletter hebdomadaire IA insights
   - Drip campaigns par segment
   - Remarketing cross-sites

4. **Paid ads centralisés**
   - Google Ads: Keywords "consulting IA", "transformation digitale"
   - LinkedIn Ads: Targeting CEOs, CTOs, Digital Managers
   - Facebook/Instagram: Retargeting visiteurs tous sites

### Content Marketing Strategy

**Piliers contenu (4 layers research déjà fait):**

#### Pilier 1: Éducation IA
- "IA pour les nuls" series
- "ChatGPT vs Claude vs Gemini - Lequel choisir?"
- "5 façons d'utiliser IA dans votre business aujourd'hui"

**Distribution:** Blog, YouTube, LinkedIn, Email

#### Pilier 2: Case Studies
- "Comment [Client] a automatisé 60% tâches avec IA - ROI 300%"
- "De 10K€/mois à 50K€/mois grâce à l'IA"
- "Transformation complète [Industry] - 90 jours"

**Distribution:** Site web, LinkedIn, Sales materials

#### Pilier 3: Thought Leadership
- "L'avenir du consulting - Pourquoi McKinsey a tort"
- "IA et emploi: La vérité que personne ne dit"
- "RAPID-IA: Notre méthodologie open-source"

**Distribution:** LinkedIn, Medium, Guest posts

#### Pilier 4: Community & UGC
- Témoignages clients vidéo
- Success stories Dream Nova Social
- "Member of the month" spotlight

**Distribution:** Instagram, TikTok, Community platform

### KPIs Ecosystem

**Tracking unifié (Google Analytics 4 + Metricool):**

| Métrique | Target Mois 1 | Target Mois 6 | Target An 1 |
|----------|---------------|---------------|-------------|
| Visiteurs uniques (tous sites) | 5,000 | 25,000 | 100,000 |
| Leads qualifiés | 50 | 300 | 1,500 |
| Conversions consulting | 2 | 15 | 60 |
| MRR (Monthly Recurring Revenue) | 2K€ | 20K€ | 100K€ |
| Membres community | 100 | 1,000 | 10,000 |

### Automation Cross-Sites

**Scripts partagés:**

```bash
# Deploy ALL DreamNova sites
bash ~/.claude/templates/universal-project-automation/scripts/dreamnova-deploy-all.sh

# Marketing ALL DreamNova sites
bash ~/.claude/templates/universal-project-automation/scripts/marketing-automation.sh dreamnova-ecosystem

# Analytics report ALL sites
bash ~/.claude/templates/universal-project-automation/scripts/dreamnova-analytics.sh
```

### Règles Ecosystem

1. **TOUJOURS** mentionner les autres sites DreamNova (cross-promotion)
2. **TOUJOURS** partager analytics entre sites (attribution cross-site)
3. **TOUJOURS** unifier brand identity (couleurs, fonts, tone)
4. **TOUJOURS** synchroniser campagnes marketing (cohérence message)

---

## 🎯 17. RÉSUMÉ ULTRA-CONDENSÉ

**3 Règles à Mémoriser:**

1. **MEMORY FIRST** 🧠
   → Check `checkpoint-memory.sh` avant TOUTE question

2. **DESIGN QA OBLIGATOIRE** 🔍
   → `design-qa-automation.sh` avant TOUT déploiement

3. **COORDINATION VIA SYNC.md** 🤖
   → Lire + Updater `agents/SYNC.md` si dossier existe

**+ 3 Nouvelles Règles:**

4. **SHARED CONTEXT pour Claude Desktop** 🤝
   → Lire `~/.claude/shared-context/SHARED_CONTEXT.md` chaque session

5. **MARKETING AUTOMATIQUE après validation** 📢
   → Deep research 4 layers + contenu multi-plateforme + Metricool

6. **DREAMNOVA = ECOSYSTEM** 🌐
   → 4 sites interconnectés, marketing unifié, KPIs partagés

**Si tu respectes ces 6 règles, tu es un agent parfait.**

---

## 📍 LOCALISATIONS IMPORTANTES À RETENIR

```bash
# Document principal (CE FICHIER)
~/.claude/templates/universal-project-automation/MESSAGE_AGENTS.md

# Scripts automation
~/scripts/checkpoint-memory.sh
~/scripts/design-qa-automation.sh
~/scripts/quick-start.sh

# Template Agents 26
~/.claude/templates/agents-26/install-agents.sh

# Memory permanente
~/.claude-memory/

# Dashboard
~/dashboard-central/

# Documentation complète
~/Desktop/🚀 AUTOMATION SYSTEM/
```

---

## ✅ CONFIRMATION DE LECTURE

**Chaque agent (Cursor + Claude Code) DOIT:**

1. ✅ Avoir lu ce message en entier
2. ✅ Comprendre les 3 règles principales
3. ✅ Savoir utiliser checkpoint-memory.sh
4. ✅ Savoir utiliser design-qa-automation.sh
5. ✅ Savoir coordonner via agents/SYNC.md

**Si un agent ne respecte pas ces règles → Il est défaillant.**

---

## 📋 COMMENT UTILISER CE DOCUMENT

### Pour Cursor:
```bash
# Lire au démarrage
cat ~/.claude/templates/universal-project-automation/MESSAGE_AGENTS.md
```

### Pour Claude Code:
```bash
# Lire au démarrage
cat ~/.claude/templates/universal-project-automation/MESSAGE_AGENTS.md
```

### Pour Projets avec Agents 26:
```bash
# Copier dans projet
cp ~/.claude/templates/universal-project-automation/MESSAGE_AGENTS.md agents/AGENTS_INSTRUCTIONS.md
```

### Emplacement GitHub:
```
https://github.com/CodeNoLimits/universal-project-automation/blob/main/MESSAGE_AGENTS.md
```

---

**FIN DU MESSAGE**

**Date de création:** 2025-11-17  
**Version:** 1.0  
**Statut:** ACTIF PERMANENT  
**Source unique de vérité pour tous les agents**

🚀 **AGISSEZ EN CONSÉQUENCE. ZÉRO EXCEPTION.**
