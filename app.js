const $ = (selector, root = document) => root.querySelector(selector);
const $$ = (selector, root = document) => [...root.querySelectorAll(selector)];

const store = {
  get(key, fallback) {
    try {
      const raw = localStorage.getItem(key);
      return raw ? JSON.parse(raw) : fallback;
    } catch {
      return fallback;
    }
  },
  set(key, value) {
    localStorage.setItem(key, JSON.stringify(value));
  }
};

const app = {
  notes: store.get("neuro_notes", []),
  theme: store.get("neuro_theme", "light")
};

function escapeHtml(value = "") {
  return String(value)
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}

function formatDate(ts) {
  try { return new Date(ts).toLocaleString(); } catch { return ""; }
}

function applyTheme(theme) {
  document.documentElement.setAttribute("data-theme", theme);
  app.theme = theme;
  store.set("neuro_theme", theme);
  const toggle = $("#themeToggle");
  if (toggle) toggle.textContent = theme === "dark" ? "â˜€ï¸ Light" : "ðŸŒ™ Dark";
}

function toggleTheme() { applyTheme(app.theme === "dark" ? "light" : "dark"); }

function syncStats() {
  const statsText = $("#statsText");
  const dashNotesCount = $("#dashNotesCount");
  if (statsText) statsText.textContent = `${app.notes.length} notes saved`;
  if (dashNotesCount) dashNotesCount.textContent = app.notes.length;
}

function saveNotes() {
  store.set("neuro_notes", app.notes);
  syncStats();
}

function renderNotes() {
  const list = $("#notesList");
  if (!list) return;
  const query = ($("#searchNotes")?.value || "").trim().toLowerCase();
  const filtered = app.notes.filter(note => `${note.title || ""} ${note.body || ""}`.toLowerCase().includes(query));
  if (!filtered.length) {
    list.innerHTML = `<article class="note-card"><h4>No notes found</h4><p>Create your first note or change the search text.</p></article>`;
    return;
  }
  list.innerHTML = filtered.map(note => `
    <article class="note-card">
      <h4>${escapeHtml(note.title)}</h4>
      <div class="note-meta">Updated ${escapeHtml(formatDate(note.updatedAt))}</div>
      <p>${escapeHtml(note.body)}</p>
      <div class="note-actions">
        <button class="neu-btn edit-note" data-id="${note.id}" type="button">Edit</button>
        <button class="neu-btn delete-note" data-id="${note.id}" type="button">Delete</button>
      </div>
    </article>
  `).join("");

  $$(".edit-note").forEach(btn => btn.addEventListener("click", () => {
    const note = app.notes.find(n => n.id === btn.dataset.id);
    if (note) {
      $("#noteTitle").value = note.title || "";
      $("#noteBody").value = note.body || "";
      $("#editingNoteId").value = note.id || "";
      window.scrollTo({ top: 0, behavior: "smooth" });
    }
  }));

  $$(".delete-note").forEach(btn => btn.addEventListener("click", () => {
    app.notes = app.notes.filter(n => n.id !== btn.dataset.id);
    saveNotes();
    renderNotes();
  }));
}

function exportNotes() {
  const blob = new Blob([JSON.stringify(app.notes, null, 2)], { type: "application/json" });
  const url = URL.createObjectURL(blob);
  const link = document.createElement("a");
  link.href = url;
  link.download = "neurostack-notes.json";
  link.click();
  URL.revokeObjectURL(url);
}

function clearAllData() {
  localStorage.removeItem("neuro_notes");
  localStorage.removeItem("gemini_settings");
  localStorage.removeItem("neuro_theme");
  app.notes = [];
  applyTheme("light");
  syncStats();
  renderNotes();
  ["#noteTitle", "#noteBody", "#editingNoteId", "#searchNotes", "#geminiApiKey", "#geminiModel", "#geminiSystem", "#geminiPrompt", "#pbRole", "#pbGoal", "#pbAudience", "#pbTone", "#pbContext", "#pbConstraints", "#pbFormat", "#promptOutput"].forEach(id => {
    const el = $(id);
    if (el) el.value = "";
  });
}

function buildPrompt() {
  const role = $("#pbRole")?.value.trim() || "";
  const goal = $("#pbGoal")?.value.trim() || "";
  const audience = $("#pbAudience")?.value.trim() || "";
  const tone = $("#pbTone")?.value.trim() || "";
  const context = $("#pbContext")?.value.trim() || "";
  const constraints = $("#pbConstraints")?.value.trim() || "";
  const format = $("#pbFormat")?.value.trim() || "";
  const lines = [
    role ? `You are ${role}.` : "",
    goal ? `Primary goal: ${goal}.` : "",
    audience ? `Target audience: ${audience}.` : "",
    tone ? `Tone: ${tone}.` : "",
    context ? `Context: ${context}` : "",
    constraints ? `Constraints: ${constraints}` : "",
    format ? `Output format: ${format}` : "",
    "Respond clearly, specifically, and with practical detail."
  ].filter(Boolean);
  const out = $("#promptOutput");
  if (out) out.value = lines.join("\n");
}

function clearPromptBuilder() {
  ["#pbRole", "#pbGoal", "#pbAudience", "#pbTone", "#pbContext", "#pbConstraints", "#pbFormat", "#promptOutput"].forEach(id => {
    const el = $(id);
    if (el) el.value = "";
  });
}

function renderPromptLibrary() {
  const root = $("#promptLibrary");
  const stats = $("#promptStats");
  if (!root || !window.PROMPT_LIBRARY) return;
  const labels = { Writing: 'writing', Research: 'research', Planning: 'planning', Creative: 'creative', Business: 'business', Systems: 'general', General: 'general' };
  if (stats) {
    stats.innerHTML = Object.entries(window.PROMPT_LIBRARY)
      .map(([cat, list]) => `<article class="mini-card neu-panel depth-md"><span class="mini-label">${escapeHtml(cat)}</span><strong>${(list || []).length}</strong><p>premium prompts</p></article>`)
      .join('');
  }
  root.innerHTML = Object.entries(window.PROMPT_LIBRARY)
    .map(([cat, list]) => {
      const chips = (list || [])
        .map(item => `<article class="prompt-chip ${labels[cat] || 'general'}"><strong>${escapeHtml(item.title)}</strong><small>${escapeHtml(item.description)}</small></article>`)
        .join('');
      return `<section class="prompt-section"><h3>${escapeHtml(cat)}</h3><div class="prompt-grid">${chips}</div></section>`;
    })
    .join('');
}

function initNotesPage() {
  const form = $("#noteForm");
  if (form) {
    form.addEventListener("submit", e => {
      e.preventDefault();
      const title = $("#noteTitle")?.value.trim() || "";
      const body = $("#noteBody")?.value.trim() || "";
      const editingId = $("#editingNoteId")?.value || "";
      if (!title || !body) return;
      if (editingId) {
        app.notes = app.notes.map(n => n.id === editingId ? { ...n, title, body, updatedAt: Date.now() } : n);
      } else {
        app.notes.unshift({ id: (window.crypto && crypto.randomUUID) ? crypto.randomUUID() : String(Date.now()), title, body, updatedAt: Date.now() });
      }
      saveNotes();
      clearNoteForm();
      renderNotes();
    });
  }
  $("#resetNote")?.addEventListener("click", clearNoteForm);
  $("#searchNotes")?.addEventListener("input", renderNotes);
  $("#exportNotes")?.addEventListener("click", exportNotes);
}

function clearNoteForm() {
  ["#noteTitle", "#noteBody", "#editingNoteId"].forEach(id => {
    const el = $(id);
    if (el) el.value = "";
  });
}

function initPromptBuilder() {
  $("#buildPrompt")?.addEventListener("click", buildPrompt);
  $("#clearPrompt")?.addEventListener("click", clearPromptBuilder);
  $("#copyPrompt")?.addEventListener("click", async () => {
    const text = $("#promptOutput")?.value || "";
    if (!text) return;
    await navigator.clipboard.writeText(text);
  });
}

function initThemeAndClear() {
  $("#themeToggle")?.addEventListener("click", toggleTheme);
  $("#clearAllData")?.addEventListener("click", clearAllData);
}

function initDashboardNav() {
  $$("[data-route]").forEach(btn => btn.addEventListener("click", () => {
    const target = btn.dataset.route;
    if (target === "notes") window.location.href = "notes.html";
    if (target === "gemini") window.location.href = "gemini.html";
    if (target === "prompts") window.location.href = "prompts.html";
  }));
  $$("[data-jump]").forEach(btn => btn.addEventListener("click", () => {
    const target = btn.dataset.jump;
    if (target === "notes") window.location.href = "notes.html";
    if (target === "gemini") window.location.href = "gemini.html";
    if (target === "prompts") window.location.href = "prompts.html";
  }));
}

function init() {
  applyTheme(app.theme || "light");
  syncStats();
  renderNotes();
  renderPromptLibrary();
  initNotesPage();
  initPromptBuilder();
  initThemeAndClear();
  initDashboardNav();
}

document.addEventListener("DOMContentLoaded", init);
