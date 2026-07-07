#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOT="/data/data/com.termux/files/home/neurostack-mobile-spa"
cd "$ROOT" || exit 1

echo "== WRITE PROMPT LIBRARY FILE =="
cat > prompt-library.js <<'EOF'
window.NEUROSTACK_PROMPT_LIBRARY = [
  {
    category: "Android Development",
    title: "Production-ready Room database schema",
    body: "Act as a senior Android architect. Build a production-ready Room database schema with DAO, migrations, and offline-first sync strategy using WorkManager."
  },
  {
    category: "Android Development",
    title: "Jetpack Compose bottom navigation",
    body: "Act as a senior Android architect. Implement a Jetpack Compose bottom navigation system with animated transitions, deep link support, and state restoration."
  },
  {
    category: "Android Development",
    title: "MVVM architecture with Hilt",
    body: "Act as a senior Android architect. Design a clean MVVM architecture with UseCases, Repository pattern, and Hilt dependency injection for a multi-module project."
  },
  {
    category: "Android Development",
    title: "Retrofit networking layer",
    body: "Act as a senior Android architect. Build a robust Retrofit + OkHttp networking layer with interceptors, auth token refresh, and exponential backoff retry logic."
  },
  {
    category: "Android Development",
    title: "Compose UI component system",
    body: "Act as a senior Android architect. Create a custom Compose UI component library with theming tokens, dark mode support, and accessibility semantics."
  },
  {
    category: "Android Development",
    title: "Offline-first sync queue",
    body: "Act as a senior Android architect. Build a full offline-capable app using Room, DataStore, and a sync queue that resolves conflicts on reconnect."
  },
  {
    category: "Android Development",
    title: "Biometric authentication",
    body: "Act as a senior Android architect. Implement biometric authentication with fingerprint and face unlock fallback using BiometricPrompt API."
  },
  {
    category: "Android Development",
    title: "CameraX document scanner",
    body: "Act as a senior Android architect. Create a file picker and document scanner using CameraX with ML Kit document detection and PDF export."
  },
  {
    category: "Cinematic Prompting",
    title: "Moody dystopian cityscape",
    body: "Act as a cinematic prompt engineer. Design a moody dystopian cityscape at golden hour — crumbling brutalist towers, neon reflections on rain-slicked streets, long shadows, volumetric smog."
  },
  {
    category: "Cinematic Prompting",
    title: "Underwater throne room",
    body: "Act as a cinematic prompt engineer. Create a hyper-detailed underwater throne room — bioluminescent coral, shafts of pale light from above, a silhouetted figure on a throne of shipwrecks."
  },
  {
    category: "Cinematic Prompting",
    title: "Alien mesa astronaut",
    body: "Act as a cinematic prompt engineer. Design a lone astronaut standing on a desolate alien mesa — twin moons rising, dust storm on the horizon, visor reflecting a dying star."
  },
  {
    category: "Cinematic Prompting",
    title: "Abandoned Victorian greenhouse",
    body: "Act as a cinematic prompt engineer. Create an abandoned Victorian greenhouse overrun by jungle growth — cracked glass ceiling, dappled sunlight, exotic flowers blooming through decay."
  },
  {
    category: "Cinematic Prompting",
    title: "Cyberpunk street market",
    body: "Act as a cinematic prompt engineer. Design a cyberpunk street market — holographic vendor signs, rain-soaked crowds, wok fire sparks, drone shadows overhead."
  },
  {
    category: "Horror",
    title: "Interactive horror ARG",
    body: "You are a horror narrative content creator. Using a Galaxy S24+ main camera in RAW mode and NFC tag reading capability, design an interactive horror ARG with physical NFC triggers and RAW photo clues delivered through a Progressive Web App."
  },
  {
    category: "Horror",
    title: "Found-footage escalation arc",
    body: "Act as an elite found-footage horror analyst. Design a slow-burn escalation arc for a found-footage film where every ten minutes introduces one stronger layer of evidence without breaking realism."
  },
  {
    category: "Music",
    title: "Mobile podcast production system",
    body: "Act as a mobile podcast production expert. Design a complete mobile podcast setup using Android recording apps, mic positioning, gain staging, and noise floor management."
  },
  {
    category: "Music",
    title: "Country production breakdown",
    body: "Act as a Nashville producer. Break down a modern country song arrangement, vocal layering plan, acoustic rhythm bed, steel guitar placement, and mix bus strategy."
  },
  {
    category: "Creative",
    title: "Dark neumorphic UI concept prompts",
    body: "You are an AI image prompt engineer. Design 10 ultra-specific prompts for dark neumorphic UI mockups optimized for a high-PPI AMOLED display with HDR color depth."
  },
  {
    category: "Creative",
    title: "Brand identity mobile review workflow",
    body: "You are a brand identity designer. Design a mobile-first brand asset review workflow for color calibration, typography approval, and icon QA on a wide-gamut phone display."
  },
  {
    category: "Utility",
    title: "Prompt vault architecture",
    body: "Design a local-first prompt vault system with notes, tags, quick filters, copy actions, pinned prompts, and offline persistence for an Android-friendly Progressive Web App."
  }
];
EOF

echo "== WRITE INDEX PAGE =="
cat > index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover" />
  <title>NeuroStack Mobile</title>
  <link rel="stylesheet" href="./styles.css" />
</head>
<body>
  <div class="app-shell">
    <header class="topbar walnut-panel">
      <div>
        <p class="eyebrow">Walnut Noir</p>
        <h1>Lavaz NeuroStack</h1>
      </div>
      <a class="icon-btn link-btn" href="./prompts.html" aria-label="Open prompts">LN</a>
    </header>

    <main class="main-stack">
      <section class="hero walnut-panel">
        <p class="eyebrow">Dashboard</p>
        <h2>Dedicated pages. Real prompt library. Responsive shell.</h2>
        <p class="hero-copy">This rebuild separates Notes, Prompts, and Gemini into their own pages and keeps the walnut-noir interface consistent throughout the app.</p>
      </section>

      <section class="grid two-up">
        <article class="walnut-panel metric-card">
          <p class="eyebrow">Saved notes</p>
          <h3 id="noteCount">0</h3>
        </article>
        <article class="walnut-panel metric-card">
          <p class="eyebrow">Saved prompts</p>
          <h3 id="promptCount">0</h3>
        </article>
      </section>

      <section class="walnut-panel quick-actions">
        <p class="eyebrow">Launch</p>
        <div class="action-row">
          <a class="pill-btn link-btn" href="./notes.html">Open Notes</a>
          <a class="pill-btn link-btn" href="./prompts.html">Open Prompts</a>
          <a class="pill-btn link-btn" href="./gemini.html">Open Gemini</a>
        </div>
      </section>

      <section class="walnut-panel">
        <p class="eyebrow">Prompt library</p>
        <div id="libraryPreview" class="stack-list"></div>
      </section>
    </main>

    <nav class="bottom-nav walnut-panel">
      <a class="nav-link active" href="./index.html">Home</a>
      <a class="nav-link" href="./notes.html">Notes</a>
      <a class="nav-link" href="./prompts.html">Prompts</a>
      <a class="nav-link" href="./gemini.html">Gemini</a>
    </nav>
  </div>

  <script src="./prompt-library.js"></script>
  <script src="./app.js"></script>
</body>
</html>
EOF

echo "== WRITE NOTES PAGE =="
cat > notes.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover" />
  <title>NeuroStack Notes</title>
  <link rel="stylesheet" href="./styles.css" />
</head>
<body data-page="notes">
  <div class="app-shell">
    <header class="topbar walnut-panel">
      <div>
        <p class="eyebrow">Notes</p>
        <h1>Capture</h1>
      </div>
      <a class="ghost-btn link-btn" href="./index.html">Home</a>
    </header>

    <main class="main-stack">
      <article class="walnut-panel form-panel">
        <label class="field-label" for="noteTitle">Title</label>
        <input id="noteTitle" class="walnut-input" type="text" placeholder="Neural capture title" />
        <label class="field-label" for="noteBody">Body</label>
        <textarea id="noteBody" class="walnut-input walnut-textarea" placeholder="Write your note..."></textarea>
        <div class="action-row">
          <button id="saveNoteBtn" class="pill-btn">Save note</button>
          <button id="clearNoteBtn" class="ghost-btn" type="button">Clear</button>
        </div>
      </article>

      <article class="walnut-panel">
        <p class="eyebrow">Saved notes</p>
        <div id="notesList" class="stack-list"></div>
      </article>
    </main>

    <nav class="bottom-nav walnut-panel">
      <a class="nav-link" href="./index.html">Home</a>
      <a class="nav-link active" href="./notes.html">Notes</a>
      <a class="nav-link" href="./prompts.html">Prompts</a>
      <a class="nav-link" href="./gemini.html">Gemini</a>
    </nav>
  </div>
  <script src="./app.js"></script>
</body>
</html>
EOF

echo "== WRITE PROMPTS PAGE =="
cat > prompts.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover" />
  <title>NeuroStack Prompts</title>
  <link rel="stylesheet" href="./styles.css" />
</head>
<body data-page="prompts">
  <div class="app-shell">
    <header class="topbar walnut-panel">
      <div>
        <p class="eyebrow">Prompts</p>
        <h1>Library</h1>
      </div>
      <a class="ghost-btn link-btn" href="./index.html">Home</a>
    </header>

    <main class="main-stack">
      <article class="walnut-panel form-panel">
        <label class="field-label" for="promptSearch">Search library</label>
        <input id="promptSearch" class="walnut-input" type="text" placeholder="Search Android, horror, cinematic, utility..." />

        <label class="field-label" for="promptTitle">Prompt title</label>
        <input id="promptTitle" class="walnut-input" type="text" placeholder="Prompt title" />

        <label class="field-label" for="promptBody">Prompt body</label>
        <textarea id="promptBody" class="walnut-input walnut-textarea" placeholder="Prompt content..."></textarea>

        <div class="action-row">
          <button id="savePromptBtn" class="pill-btn">Save prompt</button>
          <button id="clearPromptBtn" class="ghost-btn" type="button">Clear</button>
        </div>
      </article>

      <article class="walnut-panel">
        <p class="eyebrow">Saved prompts</p>
        <div id="promptsList" class="stack-list"></div>
      </article>

      <article class="walnut-panel">
        <p class="eyebrow">Document library</p>
        <div id="promptLibraryList" class="stack-list"></div>
      </article>
    </main>

    <nav class="bottom-nav walnut-panel">
      <a class="nav-link" href="./index.html">Home</a>
      <a class="nav-link" href="./notes.html">Notes</a>
      <a class="nav-link active" href="./prompts.html">Prompts</a>
      <a class="nav-link" href="./gemini.html">Gemini</a>
    </nav>
  </div>

  <script src="./prompt-library.js"></script>
  <script src="./app.js"></script>
</body>
</html>
EOF

echo "== WRITE GEMINI PAGE =="
cat > gemini.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover" />
  <title>NeuroStack Gemini</title>
  <link rel="stylesheet" href="./styles.css" />
</head>
<body data-page="gemini">
  <div class="app-shell">
    <header class="topbar walnut-panel">
      <div>
        <p class="eyebrow">Gemini</p>
        <h1>Workspace</h1>
      </div>
      <a class="ghost-btn link-btn" href="./index.html">Home</a>
    </header>

    <main class="main-stack">
      <article class="walnut-panel form-panel">
        <label class="field-label" for="geminiPrompt">Draft prompt</label>
        <textarea id="geminiPrompt" class="walnut-input walnut-textarea tall" placeholder="Draft your Gemini request here..."></textarea>
        <div class="action-row">
          <button id="copyGeminiBtn" class="pill-btn">Copy prompt</button>
          <button id="openGeminiBtn" class="ghost-btn" type="button">Open Gemini</button>
        </div>
      </article>

      <article class="walnut-panel">
        <p class="eyebrow">Saved prompts preview</p>
        <div id="geminiPromptPreview" class="stack-list"></div>
      </article>
    </main>

    <nav class="bottom-nav walnut-panel">
      <a class="nav-link" href="./index.html">Home</a>
      <a class="nav-link" href="./notes.html">Notes</a>
      <a class="nav-link" href="./prompts.html">Prompts</a>
      <a class="nav-link active" href="./gemini.html">Gemini</a>
    </nav>
  </div>
  <script src="./app.js"></script>
</body>
</html>
EOF

echo "== WRITE SHARED STYLES =="
cat > styles.css <<'EOF'
:root {
  --bg: #2e1f1b;
  --bg-2: #392723;
  --panel: #4a3934;
  --panel-2: #5e4b43;
  --panel-3: #6d5850;
  --text: #f1e7de;
  --muted: #ccb8ad;
  --faint: #a88f84;
  --line: rgba(255,255,255,0.16);
  --shadow-dark: rgba(12,7,6,0.52);
  --glow: rgba(255,255,255,0.07);
  --radius-xl: 32px;
  --radius-lg: 24px;
  --radius-pill: 999px;
}
* { box-sizing: border-box; }
html, body { margin: 0; padding: 0; min-height: 100%; }
body {
  font-family: Inter, "Segoe UI", sans-serif;
  background:
    radial-gradient(circle at top, rgba(255,255,255,0.05), transparent 28%),
    linear-gradient(180deg, #3a2824 0%, #2e1f1b 100%);
  color: var(--text);
  min-height: 100dvh;
}
a, button, input, textarea { font: inherit; }
.app-shell {
  width: 100%;
  max-width: 900px;
  margin: 0 auto;
  padding: calc(env(safe-area-inset-top, 0px) + 16px) 14px calc(env(safe-area-inset-bottom, 0px) + 100px);
}
.main-stack, .stack-list { display: grid; gap: 16px; }
.walnut-panel {
  background: linear-gradient(180deg, rgba(94,75,67,0.76), rgba(58,40,36,0.94));
  border: 1px solid var(--line);
  border-radius: var(--radius-xl);
  box-shadow: 0 22px 38px var(--shadow-dark), inset 0 1px 0 var(--glow), inset 0 -1px 0 rgba(0,0,0,0.18);
  padding: 20px;
}
.topbar { display: flex; align-items: center; justify-content: space-between; margin-bottom: 16px; gap: 12px; }
h1,h2,h3,h4,p { margin: 0; }
h1 { font-size: clamp(1.7rem, 5vw, 2.4rem); letter-spacing: .08em; text-transform: uppercase; }
h2 { font-size: clamp(1.3rem, 4vw, 1.9rem); line-height: 1.15; }
h3 { font-size: clamp(1.8rem, 5vw, 2.2rem); }
.eyebrow { text-transform: uppercase; letter-spacing: .34em; font-size: .72rem; color: var(--muted); margin-bottom: 10px; }
.hero-copy { margin-top: 14px; color: var(--muted); line-height: 1.6; }
.grid.two-up { display: grid; grid-template-columns: repeat(2, minmax(0,1fr)); gap: 16px; }
.metric-card { min-height: 130px; display: flex; flex-direction: column; justify-content: center; }
.action-row { display: flex; flex-wrap: wrap; gap: 12px; margin-top: 16px; }
.pill-btn, .ghost-btn, .icon-btn, .link-btn, .nav-link, .mini-btn {
  min-height: 46px;
  padding: 0 16px;
  border-radius: var(--radius-pill);
  text-decoration: none;
  border: 0;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}
.pill-btn, .icon-btn, .link-btn.pill-btn {
  color: var(--text);
  background: linear-gradient(180deg, #6c574f, #4b3933);
  box-shadow: inset 0 1px 0 rgba(255,255,255,0.08), 0 12px 24px rgba(0,0,0,0.22);
}
.ghost-btn, .link-btn.ghost-btn {
  color: var(--muted);
  background: rgba(255,255,255,0.03);
  border: 1px solid rgba(255,255,255,0.1);
}
.icon-btn {
  width: 52px;
  height: 52px;
  padding: 0;
  font-weight: 700;
  letter-spacing: .08em;
}
.link-btn { color: var(--text); }
.field-label {
  display: block;
  margin: 16px 0 8px;
  color: var(--muted);
  text-transform: uppercase;
  letter-spacing: .18em;
  font-size: .74rem;
}
.walnut-input {
  width: 100%;
  border: 1px solid rgba(255,255,255,0.12);
  background: linear-gradient(180deg, rgba(32,21,18,0.56), rgba(84,64,58,0.34));
  color: var(--text);
  border-radius: 22px;
  padding: 16px 18px;
  outline: none;
  box-shadow: inset 0 1px 0 rgba(255,255,255,0.05);
}
.walnut-input::placeholder { color: var(--faint); }
.walnut-textarea { min-height: 170px; resize: vertical; }
.walnut-textarea.tall { min-height: 220px; }
.item-card {
  padding: 16px;
  border-radius: 24px;
  background: linear-gradient(180deg, rgba(255,255,255,0.04), rgba(0,0,0,0.08));
  border: 1px solid rgba(255,255,255,0.08);
  box-shadow: inset 0 1px 0 rgba(255,255,255,0.04);
}
.item-card h4 { margin: 0 0 8px; color: var(--text); font-size: 1rem; }
.item-card p { margin: 0; color: var(--muted); line-height: 1.55; white-space: pre-wrap; word-break: break-word; }
.item-tools { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 14px; }
.mini-btn {
  color: var(--text);
  background: #5a463f;
  min-height: 38px;
}
.bottom-nav {
  position: fixed;
  left: 14px;
  right: 14px;
  bottom: calc(env(safe-area-inset-bottom, 0px) + 10px);
  max-width: 900px;
  margin: 0 auto;
  padding: 10px;
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 8px;
}
.nav-link {
  color: var(--muted);
  background: transparent;
}
.nav-link.active {
  color: var(--text);
  background: linear-gradient(180deg, rgba(255,255,255,0.08), rgba(0,0,0,0.1));
}
@media (max-width: 740px) {
  .grid.two-up { grid-template-columns: 1fr; }
  .walnut-panel { padding: 18px; border-radius: 28px; }
}
@media (max-width: 520px) {
  .app-shell { padding-left: 12px; padding-right: 12px; }
  .bottom-nav {
    left: 12px;
    right: 12px;
    grid-template-columns: repeat(2, 1fr);
  }
}
EOF

echo "== WRITE SHARED APP LOGIC =="
cat > app.js <<'EOF'
(function () {
  const NOTES_KEY = 'neurostack_notes_v3';
  const PROMPTS_KEY = 'neurostack_prompts_v3';

  function readStore(key) {
    try { return JSON.parse(localStorage.getItem(key) || '[]'); } catch (e) { return []; }
  }

  function writeStore(key, value) {
    localStorage.setItem(key, JSON.stringify(value));
  }

  function escapeHtml(value) {
    return String(value)
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;')
      .replaceAll("'", '&#039;');
  }

  function bindNotesPage() {
    const noteTitle = document.getElementById('noteTitle');
    const noteBody = document.getElementById('noteBody');
    const notesList = document.getElementById('notesList');
    const saveBtn = document.getElementById('saveNoteBtn');
    const clearBtn = document.getElementById('clearNoteBtn');
    if (!noteTitle || !noteBody || !notesList || !saveBtn || !clearBtn) return;

    function render() {
      const notes = readStore(NOTES_KEY);
      if (!notes.length) {
        notesList.innerHTML = '<div class="item-card"><p>No notes saved yet.</p></div>';
        return;
      }
      notesList.innerHTML = notes.map((item, index) => `
        <article class="item-card">
          <h4>${escapeHtml(item.title || 'Untitled note')}</h4>
          <p>${escapeHtml(item.body || '')}</p>
          <div class="item-tools">
            <button class="mini-btn" data-note-load="${index}">Load</button>
            <button class="mini-btn" data-note-delete="${index}">Delete</button>
          </div>
        </article>
      `).join('');

      document.querySelectorAll('[data-note-load]').forEach(btn => {
        btn.addEventListener('click', () => {
          const note = notes[Number(btn.dataset.noteLoad)];
          if (!note) return;
          noteTitle.value = note.title || '';
          noteBody.value = note.body || '';
          window.scrollTo({ top: 0, behavior: 'smooth' });
        });
      });

      document.querySelectorAll('[data-note-delete]').forEach(btn => {
        btn.addEventListener('click', () => {
          const updated = readStore(NOTES_KEY);
          updated.splice(Number(btn.dataset.noteDelete), 1);
          writeStore(NOTES_KEY, updated);
          render();
        });
      });
    }

    saveBtn.addEventListener('click', () => {
      const title = noteTitle.value.trim();
      const body = noteBody.value.trim();
      if (!title && !body) return;
      const notes = readStore(NOTES_KEY);
      notes.unshift({ title, body, createdAt: Date.now() });
      writeStore(NOTES_KEY, notes);
      noteTitle.value = '';
      noteBody.value = '';
      render();
    });

    clearBtn.addEventListener('click', () => {
      noteTitle.value = '';
      noteBody.value = '';
    });

    render();
  }

  function bindPromptsPage() {
    const promptTitle = document.getElementById('promptTitle');
    const promptBody = document.getElementById('promptBody');
    const promptsList = document.getElementById('promptsList');
    const promptLibraryList = document.getElementById('promptLibraryList');
    const promptSearch = document.getElementById('promptSearch');
    const saveBtn = document.getElementById('savePromptBtn');
    const clearBtn = document.getElementById('clearPromptBtn');
    const library = window.NEUROSTACK_PROMPT_LIBRARY || [];
    if (!promptTitle || !promptBody || !promptsList || !promptLibraryList || !promptSearch || !saveBtn || !clearBtn) return;

    function renderSaved() {
      const prompts = readStore(PROMPTS_KEY);
      if (!prompts.length) {
        promptsList.innerHTML = '<div class="item-card"><p>No saved prompts yet.</p></div>';
        return;
      }
      promptsList.innerHTML = prompts.map((item, index) => `
        <article class="item-card">
          <h4>${escapeHtml(item.title || 'Untitled prompt')}</h4>
          <p>${escapeHtml(item.body || '')}</p>
          <div class="item-tools">
            <button class="mini-btn" data-prompt-load="${index}">Load</button>
            <button class="mini-btn" data-prompt-copy="${index}">Copy</button>
            <button class="mini-btn" data-prompt-delete="${index}">Delete</button>
          </div>
        </article>
      `).join('');

      document.querySelectorAll('[data-prompt-load]').forEach(btn => {
        btn.addEventListener('click', () => {
          const item = prompts[Number(btn.dataset.promptLoad)];
          if (!item) return;
          promptTitle.value = item.title || '';
          promptBody.value = item.body || '';
          window.scrollTo({ top: 0, behavior: 'smooth' });
        });
      });

      document.querySelectorAll('[data-prompt-copy]').forEach(btn => {
        btn.addEventListener('click', async () => {
          const item = prompts[Number(btn.dataset.promptCopy)];
          if (!item) return;
          await navigator.clipboard.writeText(item.body || '');
        });
      });

      document.querySelectorAll('[data-prompt-delete]').forEach(btn => {
        btn.addEventListener('click', () => {
          const updated = readStore(PROMPTS_KEY);
          updated.splice(Number(btn.dataset.promptDelete), 1);
          writeStore(PROMPTS_KEY, updated);
          renderSaved();
        });
      });
    }

    function renderLibrary() {
      const q = promptSearch.value.trim().toLowerCase();
      const filtered = library.filter(item => {
        return !q || `${item.category} ${item.title} ${item.body}`.toLowerCase().includes(q);
      });

      if (!filtered.length) {
        promptLibraryList.innerHTML = '<div class="item-card"><p>No prompt library matches found.</p></div>';
        return;
      }

      promptLibraryList.innerHTML = filtered.map((item, index) => `
        <article class="item-card">
          <p class="eyebrow">${escapeHtml(item.category || 'Library')}</p>
          <h4>${escapeHtml(item.title || 'Untitled')}</h4>
          <p>${escapeHtml(item.body || '')}</p>
          <div class="item-tools">
            <button class="mini-btn" data-library-load="${index}">Load</button>
            <button class="mini-btn" data-library-copy="${index}">Copy</button>
          </div>
        </article>
      `).join('');

      const ref = filtered;
      document.querySelectorAll('[data-library-load]').forEach(btn => {
        btn.addEventListener('click', () => {
          const item = ref[Number(btn.dataset.libraryLoad)];
          if (!item) return;
          promptTitle.value = item.title || '';
          promptBody.value = item.body || '';
          window.scrollTo({ top: 0, behavior: 'smooth' });
        });
      });

      document.querySelectorAll('[data-library-copy]').forEach(btn => {
        btn.addEventListener('click', async () => {
          const item = ref[Number(btn.dataset.libraryCopy)];
          if (!item) return;
          await navigator.clipboard.writeText(item.body || '');
        });
      });
    }

    saveBtn.addEventListener('click', () => {
      const title = promptTitle.value.trim();
      const body = promptBody.value.trim();
      if (!title && !body) return;
      const prompts = readStore(PROMPTS_KEY);
      prompts.unshift({ title, body, createdAt: Date.now() });
      writeStore(PROMPTS_KEY, prompts);
      promptTitle.value = '';
      promptBody.value = '';
      renderSaved();
    });

    clearBtn.addEventListener('click', () => {
      promptTitle.value = '';
      promptBody.value = '';
    });

    promptSearch.addEventListener('input', renderLibrary);

    renderSaved();
    renderLibrary();
  }

  function bindDashboardPage() {
    const noteCount = document.getElementById('noteCount');
    const promptCount = document.getElementById('promptCount');
    const libraryPreview = document.getElementById('libraryPreview');
    if (noteCount) noteCount.textContent = String(readStore(NOTES_KEY).length);
    if (promptCount) promptCount.textContent = String(readStore(PROMPTS_KEY).length);
    if (libraryPreview && window.NEUROSTACK_PROMPT_LIBRARY) {
      libraryPreview.innerHTML = window.NEUROSTACK_PROMPT_LIBRARY.slice(0, 4).map(item => `
        <article class="item-card">
          <p class="eyebrow">${escapeHtml(item.category || 'Library')}</p>
          <h4>${escapeHtml(item.title || 'Untitled')}</h4>
          <p>${escapeHtml((item.body || '').slice(0, 180))}${item.body && item.body.length > 180 ? '…' : ''}</p>
        </article>
      `).join('');
    }
  }

  function bindGeminiPage() {
    const geminiPrompt = document.getElementById('geminiPrompt');
    const copyGeminiBtn = document.getElementById('copyGeminiBtn');
    const openGeminiBtn = document.getElementById('openGeminiBtn');
    const geminiPromptPreview = document.getElementById('geminiPromptPreview');
    if (geminiPromptPreview) {
      const prompts = readStore(PROMPTS_KEY).slice(0, 3);
      geminiPromptPreview.innerHTML = prompts.length
        ? prompts.map(item => `<article class="item-card"><h4>${escapeHtml(item.title || 'Untitled')}</h4><p>${escapeHtml(item.body || '')}</p></article>`).join('')
        : '<div class="item-card"><p>No saved prompts yet.</p></div>';
    }
    if (copyGeminiBtn && geminiPrompt) {
      copyGeminiBtn.addEventListener('click', async () => {
        const text = geminiPrompt.value.trim();
        if (!text) return;
        await navigator.clipboard.writeText(text);
      });
    }
    if (openGeminiBtn) {
      openGeminiBtn.addEventListener('click', () => {
        window.open('https://gemini.google.com/', '_blank');
      });
    }
  }

  bindDashboardPage();
  bindNotesPage();
  bindPromptsPage();
  bindGeminiPage();
})();
EOF

echo "== WRITE GEMINI HELPER FILE =="
cat > gemini.js <<'EOF'
window.NeuroStackGemini = {
  name: 'Lavaz NeuroStack Gemini Helper',
  version: '3.0.0',
  note: 'Gemini actions open externally while local drafting remains in-app.'
};
EOF

echo "== DOWNLOAD LN ICON =="
mkdir -p android/app/src/main/res/mipmap-mdpi
mkdir -p android/app/src/main/res/mipmap-hdpi
mkdir -p android/app/src/main/res/mipmap-xhdpi
mkdir -p android/app/src/main/res/mipmap-xxhdpi
mkdir -p android/app/src/main/res/mipmap-xxxhdpi

curl -L "https://user-gen-media-assets.s3.amazonaws.com/gpt4o_images/c3e0b389-2cc6-4f03-8a21-f221a2940543.png" -o /tmp/neuro-ln-icon.png

cp /tmp/neuro-ln-icon.png android/app/src/main/res/mipmap-mdpi/ic_launcher.png
cp /tmp/neuro-ln-icon.png android/app/src/main/res/mipmap-hdpi/ic_launcher.png
cp /tmp/neuro-ln-icon.png android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
cp /tmp/neuro-ln-icon.png android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
cp /tmp/neuro-ln-icon.png android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png

echo "== ENSURE BUILD DIST =="
npm install
npm run build
npx cap sync android

echo "== DONE =="
