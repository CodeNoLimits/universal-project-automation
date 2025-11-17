# 🤖 MESSAGE POUR TOUS LES AGENTS - SYSTÈME AUTOMATION UNIVERSELLE

> **INSTRUCTIONS PERMANENTES - À LIRE AVANT TOUTE ACTION**
>
> Ce document doit être lu par TOUS les agents (Claude Code, Cursor, Claude Desktop, tous les terminaux)

---

## 🎯 QU'EST-CE QUE CE SYSTÈME ?

Tu as accès à un **système d'automation COMPLET** qui gère 10+ projets web avec qualité world-class.

**Emplacement :**
```
~/.claude/templates/universal-project-automation/
```

**Ce que le système fait :**
- ✅ Analyse automatique des concurrents (screenshots + Lighthouse + benchmarks)
- ✅ Optimisation automatique des images (WebP + compression + responsive)
- ✅ Validation 4 couches (Lighthouse >90, WCAG AA, Visual Regression, Design System)
- ✅ Déploiement automatique Vercel/Netlify avec quality gates
- ✅ Contrôle WhatsApp/Telegram (envoie message → automation se déclenche)
- ✅ Pipeline complet en une commande

---

## 📋 COMMANDES DISPONIBLES (TOUJOURS)

### Lister les Projets

```bash
projects
```

Affiche les 10 projets configurés :
- barukh-sagit-jewelry (bijoux - bat Tiffany/Cartier)
- esther-ifra-breslev (contenu religieux - bat Sefaria)
- keren-rabbi-israel (fundraising - bat Charidy)
- dreamnova-v2 (document digitization - bat DocuWare)
- rabbi-nachman-rag (RAG system)
- primapac-kavkom (solar - bat Aurora Solar)
- terramind-betterhelp-competitor (thérapie - bat BetterHelp)
- pizza-plus-social-automation (social media)
- jahenco (site web)

### Automation Complète (1 Commande)

```bash
automate <project-id>
```

**Exemple :**
```bash
automate barukh-sagit-jewelry
```

**Ce qui se passe :**
1. ✅ Analyse concurrents (Tiffany, Cartier, Mejuri)
2. ✅ Optimise toutes les images du projet
3. ✅ Valide 4 couches (Lighthouse, WCAG, Visual, Design)
4. ✅ Déploie sur Vercel/Netlify
5. ✅ Génère rapport complet

**Durée :** ~15-32 minutes

### Automation Par Étape

```bash
# Analyse concurrents seulement
analyze barukh-sagit-jewelry

# Optimisation images seulement
optimize esther-ifra-breslev

# Validation seulement
validate keren-rabbi-israel

# Déploiement seulement
deploy dreamnova-v2
```

### Shortcuts Projets Urgents

```bash
barukh-deploy   # automate barukh-sagit-jewelry
esther-deploy   # automate esther-ifra-breslev
keren-deploy    # automate keren-rabbi-israel
```

### Aide & Status

```bash
automation-help    # Liste toutes les commandes
automation-status  # Processus actifs
automation-logs    # Logs n8n
```

---

## 🚨 RÈGLES CRITIQUES (NON-NÉGOCIABLES)

### Règle 1 : Toujours Vérifier PROJECT_REGISTRY.json

Avant toute action sur un projet, LIS :
```bash
cat ~/.claude/templates/universal-project-automation/PROJECT_REGISTRY.json
```

Ce fichier contient pour CHAQUE projet :
- `id` : Identifiant unique
- `name` : Nom du projet
- `path` : Chemin absolu vers le code
- `competitors` : Liste des concurrents avec benchmark scores
- `target_pillars` : Stratégie 3 piliers (Coût, Fonctionnalité, Design)
- `stack` : Technologies utilisées
- `lighthouse_target` : Scores Lighthouse requis

**JAMAIS modifier un projet sans consulter ce fichier d'abord.**

### Règle 2 : Respecter la Stratégie 3 Piliers

CHAQUE projet doit battre TOUS ses concurrents sur 3 piliers :

1. **💰 Coût** : 20-50% moins cher que le market leader
2. **⚡ Fonctionnalité** : Features égales ou supérieures aux concurrents
3. **🎨 Design** : Niveau world-class (98+/100 Lighthouse Design)

**Exemple Barukh Sagit :**
- Concurrents : Tiffany (Design 98, Fonc 96, Prix 70), Cartier (99/95/65), Mejuri (94/97/85)
- Targets : Coût 20% < Cartier, Fonc ≥ Mejuri, Design ≥ Tiffany (98+)

**TOUJOURS vérifier** que les changements respectent ces 3 piliers.

### Règle 3 : 4+4 Couches de Vérification OBLIGATOIRES

#### 4 Couches PRE (Avant d'agir) :

1. **Deep Research** : Recherche internet approfondie sur best practices
2. **Competitor Analysis** : Analyse tous les concurrents configurés
3. **Design Benchmarking** : Compare design systems avec leaders
4. **Feasibility Check** : Vérifie que c'est réalisable (tech, budget, délais)

#### 4 Couches POST (Après avoir agi) :

1. **Lighthouse** : Performance ≥ 90, Accessibility ≥ 95, Best Practices ≥ 95, SEO ≥ 95
2. **WCAG AA** : 0 violations accessibilité (Pa11y)
3. **Visual Regression** : Différence < 10% vs baseline (screenshots)
4. **Design System** : < 3 violations (pas de hardcoded values)

**Script de validation :**
```bash
validate <project-id>
```

**Exit codes :**
- `0` : Toutes couches passées ✅ → Déploiement autorisé
- `1` : Warnings ⚠️ → Déploiement avec prudence
- `2` : Échec ❌ → Déploiement BLOQUÉ

**JAMAIS déployer si exit code = 2.**

### Règle 4 : TOUJOURS Utiliser les Scripts (Pas de Réinvention)

Si besoin de :
- Analyser concurrents → `analyze <project-id>` (PAS de scripts custom)
- Optimiser images → `optimize <project-id>` (PAS de npm scripts custom)
- Valider qualité → `validate <project-id>` (PAS de lighthouse manuel)
- Déployer → `deploy <project-id>` (PAS de vercel/netlify direct)

**Pourquoi ?**
- Scripts intègrent les 4+4 couches automatiquement
- Génèrent rapports standardisés
- Appliquent la stratégie 3 piliers
- Évitent les erreurs humaines

### Règle 5 : Rapports TOUJOURS Générés

Chaque automation génère rapports dans :
```
~/.claude/templates/universal-project-automation/reports/<project-id>/
```

Structure :
```
reports/
├── barukh-sagit-jewelry/
│   ├── competitors/
│   │   └── 20251117-160000/
│   │       ├── analysis-report.md
│   │       ├── screenshots/
│   │       └── lighthouse-*.json
│   ├── image-optimization/
│   │   └── 20251117-161000/
│   │       └── report-*.md
│   ├── validation/
│   │   └── 20251117-162000/
│   │       └── validation-report.md
│   ├── deployments/
│   │   └── 20251117-163000/
│   │       └── deployment-report.md
│   └── full-automation/
│       └── 20251117-160000/
│           └── full-automation-report.md
```

**TOUJOURS consulter ces rapports** avant de prendre une décision.

---

## 📚 DOCUMENTATION COMPLÈTE

### Pour Usage Rapide

```bash
automation-help
```

Affiche toutes les commandes avec exemples.

### Pour Installation

```bash
cd ~/.claude/templates/universal-project-automation
bash install.sh
```

Installe :
- n8n, Vercel CLI, Netlify CLI
- Lighthouse, Pa11y, Playwright
- sharp-cli, imagemin
- Configure aliases terminal
- Hardcode dans .bashrc/.zshrc

### Pour Documentation Complète (175 pages)

```bash
open ~/.claude/templates/universal-project-automation/GUIDE_COMPLET_BETON_ARME.md
```

Contient TOUT :
- Installation pas-à-pas
- Utilisation WhatsApp/Telegram
- Toutes les commandes expliquées
- Architecture technique détaillée
- Résolution de problèmes
- Comment ajouter un nouveau projet
- Garanties et promesses

### Pour Architecture Technique

```bash
open ~/.claude/templates/universal-project-automation/README.md
```

Vue technique :
- Stack utilisé
- Flow des scripts
- n8n workflow
- API intégrations

---

## 🎯 CAS D'USAGE FRÉQUENTS

### Cas 1 : User Demande "Déploie Barukh Sagit"

**✅ CORRECT :**
```bash
# Option 1 : Pipeline complet (recommandé)
automate barukh-sagit-jewelry

# Option 2 : Déploiement seul (si déjà validé)
deploy barukh-sagit-jewelry
```

**❌ INCORRECT :**
```bash
cd /path/to/barukh-sagit-jewelry
vercel --prod  # ❌ PAS DE VALIDATION !
```

**Pourquoi ?**
- `automate` ou `deploy` incluent validation 4 couches
- Bloquent si qualité insuffisante
- Génèrent rapport complet
- Appliquent stratégie 3 piliers

### Cas 2 : User Demande "Analyse les Concurrents"

**✅ CORRECT :**
```bash
analyze barukh-sagit-jewelry
```

**Ce qui se passe :**
1. Lit concurrents depuis PROJECT_REGISTRY.json
2. Prend screenshots desktop + mobile
3. Lance Lighthouse sur chaque concurrent
4. Génère rapport comparatif avec benchmark scores
5. Identifie gaps vs nos targets

**❌ INCORRECT :**
- Faire recherche manuelle sur Google
- Prendre screenshots manuellement
- Lancer Lighthouse manuellement

**Pourquoi ?**
- Script automatise TOUT
- Standardise les métriques
- Compare systématiquement avec targets
- Génère rapport exploitable

### Cas 3 : User Demande "Optimise les Images"

**✅ CORRECT :**
```bash
optimize esther-ifra-breslev
```

**Ce qui se passe :**
1. Trouve TOUTES les images (.jpg, .png, .gif)
2. Crée versions WebP (85% plus légères)
3. Optimise originaux (pngquant/mozjpeg)
4. Génère variants responsive si > 1920px
5. Auto-commit dans git
6. Rapport avec espace économisé

**❌ INCORRECT :**
```bash
npm install sharp
# Puis scripts custom...
```

**Pourquoi ?**
- Script est déjà optimisé et testé
- Gère tous les cas (PNG, JPEG, GIF)
- Auto-commit avec message clair
- Rapport standardisé

### Cas 4 : User Demande "Vérifie si le Site est Bon"

**✅ CORRECT :**
```bash
validate keren-rabbi-israel
```

**Ce qui se passe :**
1. **Layer 1** : Lighthouse (Performance, A11y, Best Practices, SEO)
2. **Layer 2** : WCAG AA compliance (Pa11y)
3. **Layer 3** : Visual regression (screenshots vs baseline)
4. **Layer 4** : Design system compliance

**Exit code :**
- `0` = Toutes couches ✅ → "Site est parfait, prêt pour production"
- `1` = Warnings ⚠️ → "Site a des warnings, review avant deploy"
- `2` = Échec ❌ → "Site a des problèmes critiques, fix avant deploy"

**❌ INCORRECT :**
```bash
lighthouse https://site.com --view  # Seulement Layer 1
```

**Pourquoi ?**
- Lighthouse seul ne suffit pas
- Besoin des 4 couches pour garantie qualité
- Script bloque déploiement si problème

### Cas 5 : User Demande "Crée un Nouveau Projet"

**✅ CORRECT :**

1. **Ajouter dans PROJECT_REGISTRY.json :**
```bash
vi ~/.claude/templates/universal-project-automation/PROJECT_REGISTRY.json
```

Ajouter :
```json
{
  "id": "nouveau-projet",
  "name": "Nouveau Projet",
  "path": "/path/to/nouveau-projet",
  "domain": "e-commerce",
  "competitors": [
    {
      "name": "Concurrent 1",
      "url": "https://concurrent1.com",
      "benchmark_scores": {
        "design": 92,
        "functionality": 95,
        "price": 80
      }
    }
  ],
  "target_pillars": {
    "cost": "25% cheaper than Concurrent 1",
    "functionality": "Match features",
    "design": "World-class (95+/100)"
  },
  "stack": {
    "frontend": "Next.js 14 + Tailwind",
    "backend": "Express",
    "database": "PostgreSQL",
    "deployment": "Vercel"
  },
  "status": "active",
  "lighthouse_target": {
    "performance": 93,
    "accessibility": 97,
    "best_practices": 97,
    "seo": 96
  }
}
```

2. **Tester :**
```bash
projects  # Doit apparaître dans la liste
analyze nouveau-projet  # Lance première analyse
```

**❌ INCORRECT :**
- Créer projet sans l'ajouter au registry
- Commencer à coder sans définir concurrents
- Ignorer la stratégie 3 piliers

---

## 🔄 WORKFLOW RECOMMANDÉ

### Pour TOUS les Projets (Sans Exception)

```
1. Research (4 Couches PRE)
   ↓
   analyze <project-id>  # Analyse concurrents
   ↓
   [Review rapport competitors/]
   ↓
2. Development (User ou Agent code)
   ↓
   optimize <project-id>  # Optimise images pendant dev
   ↓
3. Validation (4 Couches POST)
   ↓
   validate <project-id>  # Avant TOUT déploiement
   ↓
   [Review rapport validation/]
   ↓
   Si exit code = 0 ou 1 → Continue
   Si exit code = 2 → FIX issues puis re-validate
   ↓
4. Deployment
   ↓
   deploy <project-id>  # Déploie avec quality gates
   ↓
   [Review rapport deployments/]
   ↓
5. Post-Deployment
   ↓
   [Check live URL]
   [Monitor analytics]
```

**OU Pipeline Complet en 1 Commande :**
```bash
automate <project-id>
```

Fait les étapes 1-4 automatiquement (sauf development).

---

## 📱 WHATSAPP/TELEGRAM (Optionnel)

Si configuré, user peut envoyer messages :

| Message | Action |
|---------|--------|
| `deploy barukh` | `deploy barukh-sagit-jewelry` |
| `analyze esther` | `analyze esther-ifra-breslev` |
| `optimize keren` | `optimize keren-rabbi-israel` |
| `validate dreamnova` | `validate dreamnova-v2` |
| `all rabbi` | `automate rabbi-nachman-rag` |

**Setup (si user demande) :**
```bash
n8n-tunnel  # Démarre n8n avec webhook public
```

Puis configure Twilio WhatsApp webhook vers l'URL n8n.

**Détails complets dans :**
```bash
open ~/.claude/templates/universal-project-automation/GUIDE_COMPLET_BETON_ARME.md
```

Section "Utilisation WhatsApp" (page 15-25).

---

## 🚨 ERREURS FRÉQUENTES À ÉVITER

### ❌ Erreur 1 : Déployer Sans Validation

**JAMAIS faire :**
```bash
cd /path/to/project
vercel --prod  # ❌ PAS DE VALIDATION
```

**TOUJOURS faire :**
```bash
deploy <project-id>  # Inclut validation automatique
```

### ❌ Erreur 2 : Ignorer les Exit Codes

Si `validate <project-id>` retourne exit code 2 :

**JAMAIS faire :**
```bash
deploy <project-id> force  # ❌ Contourne validation
```

**TOUJOURS faire :**
1. Consulter rapport validation
2. Fixer les issues
3. Re-run `validate <project-id>`
4. Déployer seulement si exit code 0 ou 1

### ❌ Erreur 3 : Modifier PROJECT_REGISTRY.json Sans Comprendre

**JAMAIS faire :**
- Changer `lighthouse_target` à la baisse (ex: 80 au lieu de 95)
- Supprimer des concurrents
- Modifier `target_pillars` sans raison valable

**TOUJOURS faire :**
- Consulter David avant changements majeurs
- Comprendre impact sur stratégie 3 piliers
- Tester après modifications

### ❌ Erreur 4 : Créer Scripts Custom au Lieu d'Utiliser Existants

Si user demande "optimise les images" :

**JAMAIS faire :**
```javascript
// custom-image-optimizer.js
const sharp = require('sharp');
// ... réinventer la roue
```

**TOUJOURS faire :**
```bash
optimize <project-id>  # Utilise script existant optimisé
```

### ❌ Erreur 5 : Oublier de Consulter les Rapports

Après chaque automation :

**JAMAIS faire :**
- Continuer sans lire rapport
- Ignorer warnings
- Supposer que tout est OK

**TOUJOURS faire :**
```bash
# Après analyze
open ~/.claude/templates/universal-project-automation/reports/<project-id>/competitors/latest/

# Après validate
open ~/.claude/templates/universal-project-automation/reports/<project-id>/validation/latest/

# Après deploy
open ~/.claude/templates/universal-project-automation/reports/<project-id>/deployments/latest/
```

---

## 💡 TIPS & BEST PRACTICES

### Tip 1 : Utilise les Shortcuts

Au lieu de :
```bash
automate barukh-sagit-jewelry
```

Utilise :
```bash
barukh-deploy  # Plus rapide !
```

Shortcuts disponibles :
- `barukh-deploy` → automate barukh-sagit-jewelry
- `esther-deploy` → automate esther-ifra-breslev
- `keren-deploy` → automate keren-rabbi-israel

### Tip 2 : Automatise Régulièrement

Recommandations :

**Competitor analysis :** Weekly (tous les vendredis)
```bash
# Cron job possible
0 9 * * 5 analyze barukh-sagit-jewelry
```

**Image optimization :** On commit (git hook)
```bash
# .git/hooks/pre-commit
optimize $(basename $(pwd))
```

**Validation :** Avant CHAQUE déploiement (déjà inclus dans deploy script)

**Full automation :** Après features majeures
```bash
automate <project-id>
```

### Tip 3 : Monitore les Concurrents

Si Tiffany améliore son Lighthouse score de 95 à 98 :

1. `analyze barukh-sagit-jewelry` détecte le changement
2. Rapport montre nouveau benchmark
3. Ajuste targets si nécessaire
4. Re-deploy pour rester compétitif

### Tip 4 : Utilise les Rapports pour Décisions

Avant toute décision majeure (refonte design, nouvelle feature, changement stack) :

1. `analyze <project-id>` → Vois ce que font concurrents
2. Consulte rapports précédents → Trend analysis
3. Identifie gaps → Priorise features
4. Valide avant deploy → Garantie qualité

---

## 🎯 RÉSUMÉ ULTRA-CONDENSÉ (Pour Référence Rapide)

**3 Commandes Essentielles :**

```bash
# 1. Liste projets
projects

# 2. Automation complète
automate <project-id>

# 3. Aide
automation-help
```

**3 Règles d'Or :**

1. **Toujours utiliser les scripts** (pas de custom)
2. **Toujours valider avant deploy** (4 couches POST)
3. **Toujours respecter 3 piliers** (Coût, Fonctionnalité, Design)

**3 Fichiers Clés :**

1. `PROJECT_REGISTRY.json` → Source of truth
2. `GUIDE_COMPLET_BETON_ARME.md` → Documentation complète
3. `reports/<project-id>/` → Tous les rapports

**3 Exit Codes :**

- `0` → ✅ Parfait, deploy
- `1` → ⚠️ Warnings, review
- `2` → ❌ Échec, fix

---

## 🔗 LIENS RAPIDES

**Installation :**
```bash
cd ~/.claude/templates/universal-project-automation && bash install.sh
```

**Documentation Complète (175 pages) :**
```bash
open ~/.claude/templates/universal-project-automation/GUIDE_COMPLET_BETON_ARME.md
```

**Registry Projets :**
```bash
cat ~/.claude/templates/universal-project-automation/PROJECT_REGISTRY.json | jq
```

**Rapports :**
```bash
ls -lah ~/.claude/templates/universal-project-automation/reports/
```

**Aide :**
```bash
automation-help
```

---

## 🤖 POUR LES AGENTS CURSOR, CLAUDE DESKTOP, ETC.

Si tu es Cursor, Claude Desktop, ou autre agent :

**AVANT toute action sur un projet web :**

1. ✅ Vérifie si projet existe dans `projects`
2. ✅ Lis PROJECT_REGISTRY.json pour targets
3. ✅ Utilise scripts automation (pas custom)
4. ✅ Respecte stratégie 3 piliers
5. ✅ Valide avec 4 couches POST avant deploy
6. ✅ Consulte rapports générés

**JAMAIS :**

- ❌ Déployer sans validation
- ❌ Modifier targets à la baisse
- ❌ Ignorer concurrents
- ❌ Créer scripts custom au lieu d'utiliser existants
- ❌ Oublier de générer/consulter rapports

---

## ✅ CHECKLIST AVANT TOUTE ACTION

Avant de répondre à une demande user sur un projet :

- [ ] Le projet existe-t-il dans `projects` ?
- [ ] Ai-je lu PROJECT_REGISTRY.json pour ce projet ?
- [ ] Ai-je identifié l'action requise (analyze/optimize/validate/deploy/automate) ?
- [ ] Vais-je utiliser les scripts automation (pas custom) ?
- [ ] Vais-je respecter les 3 piliers (Coût, Fonctionnalité, Design) ?
- [ ] Vais-je consulter les rapports après action ?
- [ ] Si déploiement : ai-je validé (4 couches POST) d'abord ?

Si TOUTES les cases cochées → Procède

Si UNE SEULE case non cochée → Demande clarification à user

---

**🤖 Pour l'honneur de Dieu et d'Israël - Système BÉTON ARMÉ**

**Ce message est LA source de vérité pour tous les agents.**

**Version :** 1.0.0
**Dernière mise à jour :** 17 novembre 2025
**Auteur :** Claude Code (Anthropic) + David Amor

---

**Si doute, consulte :**
1. Ce message (MESSAGE_AGENTS.md)
2. GUIDE_COMPLET_BETON_ARME.md (documentation exhaustive)
3. automation-help (commandes disponibles)
4. David (si vraiment bloqué)

**Dans cet ordre. TOUJOURS.**
