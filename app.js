(function () {
  const NOTES_KEY = 'neurostack_notes_v3';
  const PROMPTS_KEY = 'neurostack_prompts_v3';
  const THEME_KEY = 'neurostack_theme_v1';

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

  function applyTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme);
    const btn = document.getElementById('themeToggle');
    if (btn) btn.textContent = theme === 'light' ? 'Walnut theme' : 'Light theme';
    localStorage.setItem(THEME_KEY, theme);
  }

  function bindThemeToggle() {
    const stored = localStorage.getItem(THEME_KEY) || 'dark';
    applyTheme(stored);
    const btn = document.getElementById('themeToggle');
    if (!btn) return;
    btn.addEventListener('click', () => {
      const current = document.documentElement.getAttribute('data-theme') || 'dark';
      applyTheme(current === 'dark' ? 'light' : 'dark');
    });
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
        notesList.innerHTML = '<div class="item-card"><p class="empty-copy">No notes saved yet.</p></div>';
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
    const library = Array.isArray(window.NEUROSTACK_PROMPT_LIBRARY) ? window.NEUROSTACK_PROMPT_LIBRARY : [];
    if (!promptTitle || !promptBody || !promptsList || !promptLibraryList || !promptSearch || !saveBtn || !clearBtn) return;

    function renderSaved() {
      const prompts = readStore(PROMPTS_KEY);
      if (!prompts.length) {
        promptsList.innerHTML = '<div class="item-card"><p class="empty-copy">No saved prompts yet.</p></div>';
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
          renderDashboardCounts();
        });
      });
    }

    function renderLibrary() {
      const q = promptSearch.value.trim().toLowerCase();
      const filtered = library.filter(item => !q || `${item.category} ${item.title} ${item.body}`.toLowerCase().includes(q));

      if (!filtered.length) {
        promptLibraryList.innerHTML = '<div class="item-card"><p class="empty-copy">No prompt library matches found.</p></div>';
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
            <button class="mini-btn" data-library-save="${index}">Save</button>
          </div>
        </article>
      `).join('');

      document.querySelectorAll('[data-library-load]').forEach(btn => {
        btn.addEventListener('click', () => {
          const item = filtered[Number(btn.dataset.libraryLoad)];
          if (!item) return;
          promptTitle.value = item.title || '';
          promptBody.value = item.body || '';
          window.scrollTo({ top: 0, behavior: 'smooth' });
        });
      });

      document.querySelectorAll('[data-library-copy]').forEach(btn => {
        btn.addEventListener('click', async () => {
          const item = filtered[Number(btn.dataset.libraryCopy)];
          if (!item) return;
          await navigator.clipboard.writeText(item.body || '');
        });
      });

      document.querySelectorAll('[data-library-save]').forEach(btn => {
        btn.addEventListener('click', () => {
          const item = filtered[Number(btn.dataset.librarySave)];
          if (!item) return;
          const prompts = readStore(PROMPTS_KEY);
          prompts.unshift({ title: item.title || 'Library prompt', body: item.body || '', createdAt: Date.now() });
          writeStore(PROMPTS_KEY, prompts);
          renderSaved();
          renderDashboardCounts();
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
      renderDashboardCounts();
    });

    clearBtn.addEventListener('click', () => {
      promptTitle.value = '';
      promptBody.value = '';
    });

    promptSearch.addEventListener('input', renderLibrary);

    renderSaved();
    renderLibrary();
  }

  function renderDashboardCounts() {
    const noteCount = document.getElementById('noteCount');
    const promptCount = document.getElementById('promptCount');
    if (noteCount) noteCount.textContent = String(readStore(NOTES_KEY).length);
    if (promptCount) promptCount.textContent = String(readStore(PROMPTS_KEY).length);
  }

  function bindDashboardPage() {
    renderDashboardCounts();
    const libraryPreview = document.getElementById('libraryPreview');
    if (libraryPreview && Array.isArray(window.NEUROSTACK_PROMPT_LIBRARY)) {
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
        : '<div class="item-card"><p class="empty-copy">No saved prompts yet.</p></div>';
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

  bindThemeToggle();
  bindDashboardPage();
  bindNotesPage();
  bindPromptsPage();
  bindGeminiPage();
})();
