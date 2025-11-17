export default function Home() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 via-blue-50 to-indigo-50">
      {/* Hero */}
      <div className="container mx-auto px-4 py-16">
        <div className="text-center mb-16">
          <h1 className="text-6xl font-bold mb-4 bg-gradient-to-r from-blue-600 to-indigo-600 bg-clip-text text-transparent">
            🤖 Universal Project Automation
          </h1>
          <p className="text-2xl text-slate-600 mb-2">Système &quot;Fronde de David&quot;</p>
          <p className="text-xl text-slate-500 max-w-3xl mx-auto">
            Automation complète pour 10+ projets web avec qualité world-class
          </p>
          <div className="flex gap-4 justify-center mt-8">
            <a
              href="https://github.com/CodeNoLimits/universal-project-automation"
              target="_blank"
              className="bg-slate-900 text-white px-8 py-3 rounded-lg hover:bg-slate-800 transition-colors font-medium"
            >
              ⭐ GitHub
            </a>
            <a
              href="#quick-start"
              className="border-2 border-slate-900 text-slate-900 px-8 py-3 rounded-lg hover:bg-slate-900 hover:text-white transition-colors font-medium"
            >
              🚀 Quick Start
            </a>
          </div>
        </div>

        {/* Features */}
        <div className="grid md:grid-cols-3 gap-6 mb-16">
          <div className="bg-white p-6 rounded-xl shadow-lg border border-slate-200">
            <div className="text-4xl mb-4">📊</div>
            <h3 className="text-xl font-bold mb-2">Analyse Concurrentielle</h3>
            <p className="text-slate-600">Screenshots + Lighthouse + benchmarks automatiques</p>
          </div>
          <div className="bg-white p-6 rounded-xl shadow-lg border border-slate-200">
            <div className="text-4xl mb-4">🖼️</div>
            <h3 className="text-xl font-bold mb-2">Optimisation Images</h3>
            <p className="text-slate-600">WebP + compression + responsive (40-60% économisés)</p>
          </div>
          <div className="bg-white p-6 rounded-xl shadow-lg border border-slate-200">
            <div className="text-4xl mb-4">✅</div>
            <h3 className="text-xl font-bold mb-2">Validation 4 Couches</h3>
            <p className="text-slate-600">Lighthouse >90 + WCAG AA + Visual + Design System</p>
          </div>
        </div>

        {/* Quick Start */}
        <div id="quick-start" className="bg-white rounded-xl shadow-lg p-8 mb-16">
          <h2 className="text-3xl font-bold mb-6">🚀 Quick Start</h2>
          <div className="bg-slate-900 text-slate-100 p-4 rounded-lg font-mono text-sm overflow-x-auto">
            <code>{`git clone https://github.com/CodeNoLimits/universal-project-automation.git
cd universal-project-automation
bash install.sh`}</code>
          </div>
          <div className="mt-6">
            <a href="https://github.com/CodeNoLimits/universal-project-automation/blob/main/GUIDE_COMPLET_BETON_ARME.md" target="_blank" className="text-blue-600 hover:underline">
              📖 Guide Complet (175 pages) →
            </a>
          </div>
        </div>

        {/* Footer */}
        <div className="text-center py-8 border-t border-slate-200">
          <p className="text-lg font-semibold mb-2">🤖 Pour l&apos;honneur de Dieu et d&apos;Israël</p>
          <p className="text-slate-600">Système BÉTON ARMÉ - Version 1.0.0</p>
        </div>
      </div>
    </div>
  );
}
