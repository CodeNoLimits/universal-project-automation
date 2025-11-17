# 🤖 Universal Project Automation - "Fronde de David"

> **Système d'automation complet pour gérer 10+ projets web avec qualité world-class**
>
> Contrôle total depuis WhatsApp/Telegram • Validation 4 couches • Stratégie 3 piliers • Déploiement automatique

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![n8n](https://img.shields.io/badge/n8n-workflow-FF6D5A.svg)](https://n8n.io/)
[![Vercel](https://img.shields.io/badge/deploy-vercel-black.svg)](https://vercel.com)

---

## 🎯 Qu'est-ce que c'est ?

**Universal Project Automation** est un système d'automation complet qui permet de gérer plusieurs projets web avec la qualité des leaders mondiaux (Tiffany, Stripe, Notion, BetterHelp, etc.).

### Fonctionnalités Principales

- ✅ **Analyse Concurrentielle Automatique** : Screenshots + Lighthouse + benchmarks
- ✅ **Optimisation Images** : WebP + compression + responsive variants
- ✅ **Validation 4 Couches** : Lighthouse (>90) + WCAG AA + Visual Regression + Design System
- ✅ **Déploiement Automatique** : Vercel/Netlify avec quality gates
- ✅ **Contrôle WhatsApp/Telegram** : Envoie un message → automation se déclenche
- ✅ **Pipeline Complet** : 1 commande = analyse + optimisation + validation + déploiement

### Stratégie 3 Piliers

Chaque projet bat TOUS ses concurrents sur :

1. **💰 Coût** : 20-50% moins cher
2. **⚡ Fonctionnalité** : Features égales ou supérieures
3. **🎨 Design** : Niveau world-class (98+/100)

---

## 🚀 Quick Start

### Installation (5 minutes)

```bash
# Clone le repo
git clone https://github.com/davidamor/universal-project-automation.git
cd universal-project-automation

# Run installation
bash install.sh
```

L'installation configure :
- n8n (workflow automation)
- Vercel CLI, Netlify CLI
- Lighthouse, Pa11y, Playwright
- sharp-cli, imagemin
- Aliases terminal
- Hardcoding dans .bashrc/.zshrc

### Utilisation

```bash
# Liste tous les projets
projects

# Automation complète (4 étapes)
automate barukh-sagit-jewelry

# Par étape
analyze barukh-sagit-jewelry    # Analyse concurrents
optimize esther-ifra-breslev    # Optimise images
validate keren-rabbi-israel     # Valide 4 couches
deploy dreamnova-v2             # Déploie production
```

---

## 📋 Projets Configurés

Le système gère actuellement 10 projets :

| Projet | Domaine | Concurrents | Status |
|--------|---------|-------------|--------|
| **barukh-sagit-jewelry** | Bijoux | Tiffany, Cartier, Mejuri | 🔴 Urgent |
| **esther-ifra-breslev** | Contenu Religieux | Sefaria, Chabad.org | 🔴 Urgent |
| **keren-rabbi-israel** | Fundraising | JGive, Charidy | 🔴 Urgent |
| **dreamnova-v2** | Document Digitization | DocuWare, M-Files, Box | 🟢 Active |
| **rabbi-nachman-rag** | RAG/Knowledge Base | Sefaria API | 🟢 Active |
| **primapac-kavkom** | Solar Energy | Aurora Solar, SolarEdge | 🟢 Active |
| **terramind-betterhelp-competitor** | Online Therapy | BetterHelp, Talkspace, 7Cups | 🟡 Planned |
| **pizza-plus-social-automation** | Social Media | Buffer, Hootsuite | 🟡 Planned |
| **jahenco** | Website | TBD | 🟢 Active |

Chaque projet a :
- Concurrents identifiés avec benchmark scores
- Targets Lighthouse configurés (90/95/95/95+)
- Stratégie 3 piliers définie
- Stack technique documenté

---

## 🏗️ Architecture

```
┌─────────────────────────────────┐
│  WhatsApp/Telegram (User)       │
│  "deploy barukh"                 │
└────────────┬────────────────────┘
             │
             ↓
┌─────────────────────────────────┐
│  n8n (Workflow Engine)           │
│  - Webhook Trigger               │
│  - Message Parser                │
│  - Action Router                 │
│  - Script Executor               │
└────────────┬────────────────────┘
             │
             ↓
┌─────────────────────────────────┐
│  Automation Scripts              │
│  - competitor-analysis-auto.sh   │
│  - image-optimization-auto.sh    │
│  - validation-4layers.sh         │
│  - deploy-auto.sh                │
│  - full-automation.sh            │
└────────────┬────────────────────┘
             │
             ↓
┌─────────────────────────────────┐
│  PROJECT_REGISTRY.json           │
│  (Single Source of Truth)        │
│  - 10 projects metadata          │
│  - Competitors benchmarks        │
│  - Target requirements           │
└─────────────────────────────────┘
```

---

## 📊 Validation 4+4 Couches

### 4 Couches PRE (Avant d'agir)

1. **Deep Research** : Best practices internet
2. **Competitor Analysis** : Tous les concurrents
3. **Design Benchmarking** : Leaders du domaine
4. **Feasibility Check** : Tech, budget, délais

### 4 Couches POST (Après avoir agi)

1. **Lighthouse** : Performance ≥90, Accessibility ≥95, Best Practices ≥95, SEO ≥95
2. **WCAG AA** : 0 violations accessibilité
3. **Visual Regression** : < 10% changement vs baseline
4. **Design System** : < 3 violations hardcoded values

**Déploiement bloqué** si couches POST échouent.

---

## 📱 WhatsApp Integration

### Setup

1. Créer compte Twilio : https://www.twilio.com/try-twilio
2. Activer WhatsApp Sandbox
3. Démarrer n8n avec tunnel :
   ```bash
   n8n-tunnel
   ```
4. Configurer webhook Twilio → URL n8n
5. Envoyer message test :
   ```
   deploy barukh
   ```

### Commandes WhatsApp

| Message | Action |
|---------|--------|
| `deploy barukh` | Déploie Barukh Sagit Jewelry |
| `analyze esther` | Analyse concurrents Esther Ifrah |
| `optimize keren` | Optimise images Keren |
| `validate dreamnova` | Valide DreamNova |
| `all rabbi` | Pipeline complet Rabbi Nachman |

**Fallback Telegram** : Gratuit, pas besoin de Twilio.

---

## 🔧 Scripts d'Automation

### 1. competitor-analysis-auto.sh

Analyse automatique des concurrents :

- Screenshots desktop (1920x1080) + mobile (375x812)
- Lighthouse audits complets
- Benchmark comparison
- Gap analysis
- Rapport markdown

**Usage :**
```bash
analyze barukh-sagit-jewelry
```

### 2. image-optimization-auto.sh

Optimisation automatique des images :

- Conversion WebP (85% plus léger)
- Compression PNG (pngquant) + JPEG (mozjpeg)
- Génération variants responsive (1920, 1280, 640)
- Auto-commit git
- Rapport espace économisé

**Usage :**
```bash
optimize esther-ifra-breslev
```

### 3. validation-4layers.sh

Validation 4 couches POST :

- **Layer 1** : Lighthouse (compare vs targets)
- **Layer 2** : Pa11y WCAG AA (0 violations requis)
- **Layer 3** : Screenshots + visual regression
- **Layer 4** : Design system compliance

**Exit codes :**
- `0` : ✅ Toutes couches passées
- `1` : ⚠️ Warnings
- `2` : ❌ Échec (bloque déploiement)

**Usage :**
```bash
validate keren-rabbi-israel
```

### 4. deploy-auto.sh

Déploiement automatique avec quality gates :

- Pre-flight validation (appelle validation-4layers.sh)
- Build npm/pnpm
- Deploy Vercel/Netlify CLI
- Post-deployment verification
- Désactive password protection automatiquement

**Usage :**
```bash
deploy dreamnova-v2
```

### 5. full-automation.sh

Pipeline master (toutes les étapes) :

1. Competitor Analysis (~5-10 min)
2. Image Optimization (~2-5 min)
3. Validation 4 Layers (~3-7 min)
4. Deployment (~5-10 min)

**Durée totale :** ~15-32 minutes

**Usage :**
```bash
automate barukh-sagit-jewelry

# Ou shortcut
barukh-deploy
```

---

## 📚 Documentation

### Pour Agents/Développeurs

**📄 MESSAGE_AGENTS.md** (À lire en PREMIER)
- Instructions claires pour tous les agents
- Cas d'usage fréquents
- Erreurs à éviter
- Checklist avant action

### Pour Utilisateurs

**📖 GUIDE_COMPLET_BETON_ARME.md** (175 pages)
- Installation pas-à-pas
- Utilisation WhatsApp/Telegram
- Toutes les commandes expliquées
- Architecture technique
- Résolution de problèmes
- Ajouter nouveaux projets

### Quick Reference

```bash
automation-help    # Liste toutes les commandes
projects           # Liste les projets
automation-status  # Check processus actifs
```

---

## 🎯 Exemples Concrets

### Exemple 1 : Barukh Sagit Jewelry

**Concurrents :**
- Tiffany & Co. (Design 98, Fonctionnalité 96, Prix 70)
- Cartier (Design 99, Fonctionnalité 95, Prix 65)
- Mejuri (Design 94, Fonctionnalité 97, Prix 85)

**Targets (3 Piliers) :**
- 💰 Coût : 20% cheaper than Cartier/Tiffany
- ⚡ Fonctionnalité : Match or exceed Mejuri
- 🎨 Design : Level Tiffany (98+/100)

**Résultat :**
```bash
automate barukh-sagit-jewelry
```

Génère :
- Rapport analyse concurrents avec screenshots
- Images optimisées (WebP + responsive)
- Validation Lighthouse 95/98/98/98
- Déploiement Vercel avec URL live

### Exemple 2 : TerraMind (BetterHelp Competitor)

**Concurrents :**
- BetterHelp ($65/semaine, Design 94, Fonctionnalité 97)
- Talkspace ($69-109/semaine, Design 92, Fonctionnalité 96)

**Targets :**
- 💰 Coût : $52/semaine (20% cheaper)
- ⚡ Fonctionnalité : Match + insurance integration
- 🎨 Design : 95+/100

**Commande :**
```bash
automate terramind-betterhelp-competitor
```

---

## 🔐 Sécurité

### Secrets Management

**JAMAIS commiter :**
- `.env` files
- `credentials.json`
- Twilio tokens
- Vercel/Netlify tokens

**Template fourni :**
```
credentials-template.txt
```

À remplir et garder en local (ignoré par git).

### Quality Gates

**Déploiement bloqué si :**
- Lighthouse < targets
- WCAG AA violations > 0
- Visual regression > 10%
- Design system violations > 3

**Impossible de bypass** (sauf force mode, non recommandé).

---

## 🤝 Contributing

### Ajouter un Nouveau Projet

1. **Éditer PROJECT_REGISTRY.json :**
```json
{
  "id": "nouveau-projet",
  "name": "Nouveau Projet",
  "path": "/path/to/projet",
  "competitors": [...],
  "target_pillars": {...},
  "lighthouse_target": {...}
}
```

2. **Tester :**
```bash
projects  # Doit apparaître
analyze nouveau-projet
```

### Ajouter un Nouveau Script

1. Créer dans `scripts/`
2. Rendre exécutable : `chmod +x scripts/nouveau-script.sh`
3. Ajouter dans `automation-aliases.sh`
4. Documenter dans README

---

## 📄 License

MIT License - Voir [LICENSE](LICENSE)

---

## 🙏 Remerciements

Créé avec rigueur et foi pour battre les Goliath de chaque domaine.

**Pour l'honneur de Dieu et d'Israël - Système BÉTON ARMÉ**

---

## 📞 Support

### Documentation
- **Guide complet (175 pages)** : `GUIDE_COMPLET_BETON_ARME.md`
- **Message pour agents** : `MESSAGE_AGENTS.md`
- **README technique** : Ce fichier

### Commandes Aide
```bash
automation-help
automation-status
```

### n8n Support
- Docs : https://docs.n8n.io/
- Forum : https://community.n8n.io/

### Twilio Support
- Docs WhatsApp : https://www.twilio.com/docs/whatsapp

---

**Version :** 1.0.0 - BÉTON ARMÉ Edition
**Dernière mise à jour :** 17 novembre 2025
**Créé par :** Claude Code (Anthropic) + David Amor

---

**⭐ Si ce système t'aide, laisse une star sur GitHub !**

**🚀 Prêt à battre les géants ? Lance :**
```bash
bash install.sh && automate ton-premier-projet
```
