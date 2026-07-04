const $ = (selector, root = document) => root.querySelector(selector);
const $$ = (selector, root = document) => [...root.querySelectorAll(selector)];
const store = { get(k, f){ try { const r = localStorage.getItem(k); return r ? JSON.parse(r) : f; } catch { return f; } }, set(k,v){ localStorage.setItem(k, JSON.stringify(v)); } };
const app = { notes: store.get("neuro_notes", []), theme: store.get("neuro_theme", "light") };
function escapeHtml(value = "") { return String(value).replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll('"', "&quot;").replaceAll("'", "&#039;"); }
function formatDate(ts) { try { return new Date(ts).toLocaleString(); } catch { return ""; } }
function syncStats() { const statsText = $("#statsText"); const dashNotesCount = $("#dashNotesCount"); if (statsText) statsText.textContent = `${app.notes.length} notes saved`; if (dashNotesCount) dashNotesCount.textContent = app.notes.length; }
function saveNotes() { store.set("neuro_notes", app.notes); syncStats(); }
function applyTheme(theme) { document.documentElement.setAttribute("data-theme", theme); app.theme = theme; store.set("neuro_theme", theme); const toggle = $("#themeToggle"); if (toggle) toggle.textContent = theme === "dark" ? "â˜€ï¸ Light" : "ðŸŒ™ Dark"; }
function toggleTheme() { applyTheme(app.theme === "dark" ? "light" : "dark"); }
function resetNoteForm() { ["#noteTitle", "#noteBody", "#editingNoteId"].forEach(id => { const el = $(id); if (el) el.value = ""; }); }
function fillNoteForm(note) { const title = $("#noteTitle"), body = $("#noteBody"), editing = $("#editingNoteId"); if (title) title.value = note.title || ""; if (body) body.value = note.body || ""; if (editing) editing.value = note.id || ""; window.scrollTo({ top: 0, behavior: "smooth" }); }
function deleteNote(id) { app.notes = app.notes.filter(note => note.id !== id); saveNotes(); renderNotes(); }
function renderNotes() { const list = $("#notesList"); const search = $("#searchNotes"); if (!list) return; const query = (search?.value || "").trim().toLowerCase(); const filtered = app.notes.filter(note => (`${note.title || ""} ${note.body || ""}`).toLowerCase().includes(query)); if (!filtered.length) { list.innerHTML = `<article class="note-card"><h4>No notes found</h4><p>Create your first note or change the search text.</p></article>`; return; } list.innerHTML = filtered.map(note => `<article class="note-card"><h4>${escapeHtml(note.title)}</h4><div class="note-meta">Updated ${escapeHtml(formatDate(note.updatedAt))}</div><p>${escapeHtml(note.body)}</p><div class="note-actions"><button class="neu-btn edit-note" data-id="${note.id}" type="button">Edit</button><button class="neu-btn delete-note" data-id="${note.id}" type="button">Delete</button></div></article>`).join(""); $$(".edit-note").forEach(btn => btn.addEventListener("click", () => { const note = app.notes.find(item => item.id === btn.dataset.id); if (note) fillNoteForm(note); })); $$(".delete-note").forEach(btn => btn.addEventListener("click", () => deleteNote(btn.dataset.id))); }
function exportNotes() { const blob = new Blob([JSON.stringify(app.notes, null, 2)], { type: "application/json" }); const url = URL.createObjectURL(blob); const link = document.createElement("a"); link.href = url; link.download = "neurostack-notes.json"; link.click(); URL.revokeObjectURL(url); }
function buildPrompt() { const role = $("#pbRole")?.value.trim() || ""; const goal = $("#pbGoal")?.value.trim() || ""; const audience = $("#pbAudience")?.value.trim() || ""; const tone = $("#pbTone")?.value.trim() || ""; const context = $("#pbContext")?.value.trim() || ""; const constraints = $("#pbConstraints")?.value.trim() || ""; const format = $("#pbFormat")?.value.trim() || ""; const lines = [ role ? `You are ${role}.` : "", goal ? `Primary goal: ${goal}.` : "", audience ? `Target audience: ${audience}.` : "", tone ? `Tone: ${tone}.` : "", context ? `Context: ${context}` : "", constraints ? `Constraints: ${constraints}` : "", format ? `Output format: ${format}` : "", "Respond clearly, specifically, and with practical detail." ].filter(Boolean); const out = $("#promptOutput"); if (out) out.value = lines.join("\n"); }
function clearPromptBuilder() { ["#pbRole", "#pbGoal", "#pbAudience", "#pbTone", "#pbContext", "#pbConstraints", "#pbFormat", "#promptOutput"].forEach(id => { const el = $(id); if (el) el.value = ""; }); }
function clearAllData() { localStorage.removeItem("neuro_notes"); localStorage.removeItem("gemini_settings"); localStorage.removeItem("neuro_theme"); app.notes = []; saveNotes(); renderNotes(); resetNoteForm(); applyTheme("light"); }
function renderPromptLibrary() {
  const root = $("#promptLibrary");
  if (!root || !window.PROMPT_LIBRARY) return;
  const labels = { Writing: 'writing', Research: 'research', Planning: 'planning', Creative: 'creative', Business: 'business', General: 'general' };
  root.innerHTML = Object.entries(window.PROMPT_LIBRARY).map(([cat, list]) => {
    const chips = (list || []).map(item => `<article class="prompt-chip ${labels[cat] || 'general'}"><strong>${escapeHtml(item)}</strong><small>${escapeHtml(cat)}</small></article>`).join('');
    return `<section class="prompt-section"><h3>${escapeHtml(cat)}</h3><div class="prompt-grid">${chips}</div></section>`;
  }).join('');
}
function initNotesPage() {
  const form = $("#noteForm");
  if (form) form.addEventListener("submit", e => { e.preventDefault(); const title = $("#noteTitle")?.value.trim() || ""; const body = $("#noteBody")?.value.trim() || ""; const editingId = $("#editingNoteId")?.value || ""; if (!title || !body) return; if (editingId) { app.notes = app.notes.map(n => n.id === editingId ? { ...n, title, body, updatedAt: Date.now() } : n); } else { app.notes.unshift({ id: (window.crypto && crypto.randomUUID) ? crypto.randomUUID() : String(Date.now()), title, body, updatedAt: Date.now() }); } saveNotes(); resetNoteForm(); renderNotes(); });
  $("#resetNote")?.addEventListener("click", resetNoteForm);
  $("#searchNotes")?.addEventListener("input", renderNotes);
  $("#exportNotes")?.addEventListener("click", exportNotes);
}
function initPromptBuilder() {
  $("#buildPrompt")?.addEventListener("click", buildPrompt);
  $("#clearPrompt")?.addEventListener("click", clearPromptBuilder);
  $("#copyPrompt")?.addEventListener("click", async () => { const text = $("#promptOutput")?.value || ""; if (!text) return; await navigator.clipboard.writeText(text); });
}
function initCommon() {
  $("#themeToggle")?.addEventListener("click", toggleTheme);
  $("#clearAllData")?.addEventListener("click", clearAllData);
}
document.addEventListener("DOMContentLoaded", () => { applyTheme(app.theme || "light"); syncStats(); renderNotes(); renderPromptLibrary(); initNotesPage(); initPromptBuilder(); initCommon(); });
