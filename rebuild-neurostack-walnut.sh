#!/data/data/com.termux/files/usr/bin/bash
set -e

cd /data/data/com.termux/files/home/neurostack-mobile-spa || exit 1

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
        <h1>NeuroStack</h1>
      </div>
      <button id="themePulseBtn" class="icon-btn" aria-label="Pulse interface">◐</button>
    </header>

    <main class="main-stack">
      <section class="hero walnut-panel">
        <p class="eyebrow">Mobile knowledge system</p>
        <h2>Write, collect, prompt, and move fast.</h2>
        <p class="hero-copy">A responsive offline-first shell for notes, prompts, and Gemini-assisted drafting.</p>
      </section>

      <nav class="tabbar walnut-panel" aria-label="Primary">
        <button class="tab-btn active" data-view="dashboard">Dashboard</button>
        <button class="tab-btn" data-view="notes">Notes</button>
        <button class="tab-btn" data-view="prompts">Prompts</button>
        <button class="tab-btn" data-view="gemini">Gemini</button>
      </nav>

      <section id="view-dashboard" class="view active">
        <div class="grid two-up">
          <article class="walnut-panel metric-card">
            <p class="eyebrow">Saved notes</p>
            <h3 id="noteCount">0</h3>
          </article>
          <article class="walnut-panel metric-card">
            <p class="eyebrow">Saved prompts</p>
            <h3 id="promptCount">0</h3>
          </article>
        </div>

        <article class="walnut-panel quick-actions">
          <p class="eyebrow">Quick actions</p>
          <div class="action-row">
            <button class="pill-btn" data-jump="notes">New note</button>
            <button class="pill-btn" data-jump="prompts">New prompt</button>
            <button class="pill-btn" data-jump="gemini">Open Gemini</button>
          </div>
        </article>

        <article class="walnut-panel">
          <p class="eyebrow">Recent note</p>
          <div id="recentNoteCard" class="empty-state">No notes yet.</div>
        </article>
      </section>

      <section id="view-notes" class="view">
        <article class="walnut-panel form-panel">
          <p class="eyebrow">Notes</p>
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
      </section>

      <section id="view-prompts" class="view">
        <article class="walnut-panel form-panel">
          <p class="eyebrow">Prompts</p>
          <label class="field-label" for="promptTitle">Prompt name</label>
          <input id="promptTitle" class="walnut-input" type="text" placeholder="Style DNA extractor" />

          <label class="field-label" for="promptBody">Prompt content</label>
          <textarea id="promptBody" class="walnut-input walnut-textarea" placeholder="Write your prompt..."></textarea>

          <div class="action-row">
            <button id="savePromptBtn" class="pill-btn">Save prompt</button>
            <button id="clearPromptBtn" class="ghost-btn" type="button">Clear</button>
          </div>
        </article>

        <article class="walnut-panel">
          <p class="eyebrow">Prompt library</p>
          <div id="promptsList" class="stack-list"></div>
        </article>
      </section>

      <section id="view-gemini" class="view">
        <article class="walnut-panel form-panel">
          <p class="eyebrow">Gemini workspace</p>
          <label class="field-label" for="geminiPrompt">Draft prompt</label>
          <textarea id="geminiPrompt" class="walnut-input walnut-textarea tall" placeholder="Draft your Gemini request here..."></textarea>

          <div class="action-row">
            <button id="copyGeminiBtn" class="pill-btn">Copy prompt</button>
            <button id="openGeminiBtn" class="ghost-btn" type="button">Open Gemini</button>
          </div>
        </article>

        <article class="walnut-panel">
          <p class="eyebrow">Usage note</p>
          <div class="info-card">
            This local shell drafts and stores your prompts on-device. Open Gemini in-browser for live model interaction.
          </div>
        </article>
      </section>
    </main>
  </div>

  <script src="./app.js"></script>
</body>
</html>
EOF

cat > notes.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="refresh" content="0; url=./index.html#notes" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Notes Redirect</title>
</head>
<body></body>
</html>
EOF

cat > prompts.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="refresh" content="0; url=./index.html#prompts" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Prompts Redirect</title>
</head>
<body></body>
</html>
EOF

cat > gemini.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="refresh" content="0; url=./index.html#gemini" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Gemini Redirect</title>
</head>
<body></body>
</html>
EOF

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
  --shadow-dark: rgba(12, 7, 6, 0.52);
  --shadow-soft: rgba(0,0,0,0.22);
  --glow: rgba(255,255,255,0.07);
  --success: #b79278;
  --radius-xl: 32px;
  --radius-lg: 24px;
  --radius-md: 18px;
  --radius-pill: 999px;
  --space-1: 6px;
  --space-2: 10px;
  --space-3: 14px;
  --space-4: 18px;
  --space-5: 24px;
  --space-6: 32px;
  --space-7: 40px;
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

button, input, textarea {
  font: inherit;
}

.app-shell {
  width: 100%;
  max-width: 860px;
  margin: 0 auto;
  padding: calc(env(safe-area-inset-top, 0px) + 18px) 16px calc(env(safe-area-inset-bottom, 0px) + 24px);
}

.main-stack {
  display: grid;
  gap: var(--space-4);
}

.walnut-panel {
  background: linear-gradient(180deg, rgba(94,75,67,0.76), rgba(58,40,36,0.94));
  border: 1px solid var(--line);
  border-radius: var(--radius-xl);
  box-shadow:
    0 22px 38px var(--shadow-dark),
    inset 0 1px 0 var(--glow),
    inset 0 -1px 0 rgba(0,0,0,0.18);
  padding: var(--space-5);
}

.topbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: var(--space-4);
}

h1, h2, h3, p { margin: 0; }

h1 {
  font-size: clamp(1.9rem, 5vw, 2.6rem);
  letter-spacing: 0.08em;
  text-transform: uppercase;
}

h2 {
  font-size: clamp(1.45rem, 4vw, 2rem);
  margin-top: 6px;
  line-height: 1.15;
}

h3 {
  font-size: clamp(1.8rem, 5vw, 2.4rem);
}

.eyebrow {
  text-transform: uppercase;
  letter-spacing: 0.34em;
  font-size: 0.72rem;
  color: var(--muted);
  margin-bottom: 10px;
}

.hero-copy {
  margin-top: 14px;
  color: var(--muted);
  line-height: 1.6;
}

.icon-btn,
.pill-btn,
.ghost-btn,
.tab-btn {
  appearance: none;
  border: 0;
  cursor: pointer;
  transition: transform .18s ease, opacity .18s ease, background .18s ease;
}

.icon-btn:hover,
.pill-btn:hover,
.ghost-btn:hover,
.tab-btn:hover {
  transform: translateY(-1px);
}

.icon-btn:active,
.pill-btn:active,
.ghost-btn:active,
.tab-btn:active {
  transform: translateY(0);
}

.icon-btn {
  width: 52px;
  height: 52px;
  border-radius: 50%;
  color: var(--text);
  background: linear-gradient(180deg, #5d4942, #3f2d29);
  box-shadow:
    inset 0 1px 0 rgba(255,255,255,0.08),
    0 12px 24px rgba(0,0,0,0.28);
}

.tabbar {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 10px;
  padding: 12px;
}

.tab-btn {
  min-height: 46px;
  padding: 12px 10px;
  border-radius: var(--radius-pill);
  color: var(--muted);
  background: transparent;
}

.tab-btn.active {
  color: var(--text);
  background: linear-gradient(180deg, rgba(255,255,255,0.08), rgba(0,0,0,0.1));
  box-shadow: inset 0 1px 0 rgba(255,255,255,0.06);
}

.view {
  display: none;
  gap: var(--space-4);
}

.view.active {
  display: grid;
}

.grid.two-up {
  display: grid;
  grid-template-columns: repeat(2, minmax(0,1fr));
  gap: var(--space-4);
}

.metric-card {
  min-height: 140px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.quick-actions .action-row,
.form-panel .action-row {
  margin-top: 16px;
}

.action-row {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
}

.pill-btn,
.ghost-btn {
  min-height: 48px;
  padding: 0 18px;
  border-radius: var(--radius-pill);
}

.pill-btn {
  color: var(--text);
  background: linear-gradient(180deg, #6c574f, #4b3933);
  box-shadow:
    inset 0 1px 0 rgba(255,255,255,0.08),
    0 12px 24px rgba(0,0,0,0.22);
}

.ghost-btn {
  color: var(--muted);
  background: rgba(255,255,255,0.03);
  border: 1px solid rgba(255,255,255,0.1);
}

.field-label {
  display: block;
  margin: 16px 0 8px;
  color: var(--muted);
  text-transform: uppercase;
  letter-spacing: 0.18em;
  font-size: 0.74rem;
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

.walnut-input::placeholder {
  color: var(--faint);
}

.walnut-textarea {
  min-height: 170px;
  resize: vertical;
}

.walnut-textarea.tall {
  min-height: 220px;
}

.stack-list {
  display: grid;
  gap: 14px;
  margin-top: 10px;
}

.item-card {
  padding: 16px;
  border-radius: 24px;
  background: linear-gradient(180deg, rgba(255,255,255,0.04), rgba(0,0,0,0.08));
  border: 1px solid rgba(255,255,255,0.08);
  box-shadow: inset 0 1px 0 rgba(255,255,255,0.04);
}

.item-card h4 {
  margin: 0 0 8px;
  color: var(--text);
  font-size: 1rem;
}

.item-card p {
  margin: 0;
  color: var(--muted);
  line-height: 1.5;
  white-space: pre-wrap;
  word-break: break-word;
}

.item-tools {
  display: flex;
  gap: 10px;
  margin-top: 14px;
}

.mini-btn {
  min-height: 38px;
  padding: 0 12px;
  border-radius: var(--radius-pill);
  border: 0;
  color: var(--text);
  background: #5a463f;
}

.empty-state,
.info-card {
  color: var(--muted);
  line-height: 1.6;
}

@media (max-width: 740px) {
  .grid.two-up {
    grid-template-columns: 1fr;
  }

  .tabbar {
    grid-template-columns: repeat(2, 1fr);
  }

  .walnut-panel {
    padding: 18px;
    border-radius: 28px;
  }
}

@media (max-width: 480px) {
  .app-shell {
    padding-left: 12px;
    padding-right: 12px;
  }

  .tabbar {
    gap: 8px;
    padding: 10px;
  }

  .tab-btn,
  .pill-btn,
  .ghost-btn {
    font-size: 0.92rem;
  }
}
EOF

cat > app.js <<'EOF'
(function () {
  const NOTES_KEY = 'neurostack_notes_v2';
  const PROMPTS_KEY = 'neurostack_prompts_v2';

  const views = {
    dashboard: document.getElementById('view-dashboard'),
    notes: document.getElementById('view-notes'),
    prompts: document.getElementById('view-prompts'),
    gemini: document.getElementById('view-gemini')
  };

  const tabButtons = Array.from(document.querySelectorAll('.tab-btn'));
  const jumpButtons = Array.from(document.querySelectorAll('[data-jump]'));

  const noteTitle = document.getElementById('noteTitle');
  const noteBody = document.getElementById('noteBody');
  const promptTitle = document.getElementById('promptTitle');
  const promptBody = document.getElementById('promptBody');
  const geminiPrompt = document.getElementById('geminiPrompt');

  const noteCount = document.getElementById('noteCount');
  const promptCount = document.getElementById('promptCount');
  const notesList = document.getElementById('notesList');
  const promptsList = document.getElementById('promptsList');
  const recentNoteCard = document.getElementById('recentNoteCard');

  function readStore(key) {
    try {
      return JSON.parse(localStorage.getItem(key) || '[]');
    } catch (e) {
      return [];
    }
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

  function activateView(name) {
    Object.entries(views).forEach(([key, node]) => {
      if (!node) return;
      node.classList.toggle('active', key === name);
    });

    tabButtons.forEach(btn => {
      btn.classList.toggle('active', btn.dataset.view === name);
    });

    location.hash = name;
  }

  function renderNotes() {
    const notes = readStore(NOTES_KEY);
    noteCount.textContent = String(notes.length);

    if (!notes.length) {
      notesList.innerHTML = '<div class="empty-state">No notes saved yet.</div>';
      recentNoteCard.textContent = 'No notes yet.';
      return;
    }

    recentNoteCard.innerHTML = `
      <div class="item-card">
        <h4>${escapeHtml(notes[0].title || 'Untitled note')}</h4>
        <p>${escapeHtml(notes[0].body || '')}</p>
      </div>
    `;

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
        const idx = Number(btn.dataset.noteLoad);
        const note = notes[idx];
        if (!note) return;
        noteTitle.value = note.title || '';
        noteBody.value = note.body || '';
        activateView('notes');
      });
    });

    document.querySelectorAll('[data-note-delete]').forEach(btn => {
      btn.addEventListener('click', () => {
        const idx = Number(btn.dataset.noteDelete);
        const updated = readStore(NOTES_KEY);
        updated.splice(idx, 1);
        writeStore(NOTES_KEY, updated);
        renderAll();
      });
    });
  }

  function renderPrompts() {
    const prompts = readStore(PROMPTS_KEY);
    promptCount.textContent = String(prompts.length);

    if (!prompts.length) {
      promptsList.innerHTML = '<div class="empty-state">No prompts saved yet.</div>';
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
        const idx = Number(btn.dataset.promptLoad);
        const item = prompts[idx];
        if (!item) return;
        promptTitle.value = item.title || '';
        promptBody.value = item.body || '';
        activateView('prompts');
      });
    });

    document.querySelectorAll('[data-prompt-copy]').forEach(btn => {
      btn.addEventListener('click', async () => {
        const idx = Number(btn.dataset.promptCopy);
        const item = prompts[idx];
        if (!item) return;
        await navigator.clipboard.writeText(item.body || '');
      });
    });

    document.querySelectorAll('[data-prompt-delete]').forEach(btn => {
      btn.addEventListener('click', () => {
        const idx = Number(btn.dataset.promptDelete);
        const updated = readStore(PROMPTS_KEY);
        updated.splice(idx, 1);
        writeStore(PROMPTS_KEY, updated);
        renderAll();
      });
    });
  }

  function renderAll() {
    renderNotes();
    renderPrompts();
  }

  document.getElementById('saveNoteBtn').addEventListener('click', () => {
    const title = noteTitle.value.trim();
    const body = noteBody.value.trim();
    if (!title && !body) return;

    const notes = readStore(NOTES_KEY);
    notes.unshift({
      title,
      body,
      createdAt: Date.now()
    });
    writeStore(NOTES_KEY, notes);
    noteTitle.value = '';
    noteBody.value = '';
    renderAll();
    activateView('dashboard');
  });

  document.getElementById('clearNoteBtn').addEventListener('click', () => {
    noteTitle.value = '';
    noteBody.value = '';
  });

  document.getElementById('savePromptBtn').addEventListener('click', () => {
    const title = promptTitle.value.trim();
    const body = promptBody.value.trim();
    if (!title && !body) return;

    const prompts = readStore(PROMPTS_KEY);
    prompts.unshift({
      title,
      body,
      createdAt: Date.now()
    });
    writeStore(PROMPTS_KEY, prompts);
    promptTitle.value = '';
    promptBody.value = '';
    renderAll();
    activateView('dashboard');
  });

  document.getElementById('clearPromptBtn').addEventListener('click', () => {
    promptTitle.value = '';
    promptBody.value = '';
  });

  document.getElementById('copyGeminiBtn').addEventListener('click', async () => {
    const text = geminiPrompt.value.trim();
    if (!text) return;
    await navigator.clipboard.writeText(text);
  });

  document.getElementById('openGeminiBtn').addEventListener('click', () => {
    window.open('https://gemini.google.com/', '_blank');
  });

  tabButtons.forEach(btn => {
    btn.addEventListener('click', () => activateView(btn.dataset.view));
  });

  jumpButtons.forEach(btn => {
    btn.addEventListener('click', () => activateView(btn.dataset.jump));
  });

  document.getElementById('themePulseBtn').addEventListener('click', () => {
    document.body.classList.toggle('pulse-mode');
  });

  window.addEventListener('hashchange', () => {
    const target = location.hash.replace('#', '') || 'dashboard';
    if (views[target]) activateView(target);
  });

  const initial = location.hash.replace('#', '') || 'dashboard';
  activateView(views[initial] ? initial : 'dashboard');
  renderAll();
})();
EOF

cat > gemini.js <<'EOF'
window.NeuroStackGemini = {
  name: 'NeuroStack Gemini Helper',
  version: '2.0.0',
  note: 'Gemini interactions are launched externally from the local shell.'
};
EOF

echo "== REBUILD WEB DIST =="
npm install
npm run build

echo "== SYNC CAPACITOR =="
npx cap sync android

echo "== DONE =="
