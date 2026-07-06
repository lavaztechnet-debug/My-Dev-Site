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
