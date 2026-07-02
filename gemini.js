document.addEventListener("DOMContentLoaded", () => {
  const settingsKey = "gemini_settings";
  const refs = {
    apiKey: document.getElementById("geminiApiKey"),
    model: document.getElementById("geminiModel"),
    system: document.getElementById("geminiSystem"),
    prompt: document.getElementById("geminiPrompt"),
    output: document.getElementById("geminiOutput"),
    status: document.getElementById("geminiStatus"),
    run: document.getElementById("runGemini"),
    save: document.getElementById("saveGeminiSettings"),
    clear: document.getElementById("clearGeminiOutput"),
    themeToggle: document.getElementById("themeToggle"),
    clearAllData: document.getElementById("clearAllData")
  };

  function getSaved() {
    try { return JSON.parse(localStorage.getItem(settingsKey)) || {}; } catch { return {}; }
  }

  function setStatus(text) { if (refs.status) refs.status.textContent = text; }
  function showOutput(text) { if (refs.output) refs.output.textContent = text; }

  function saveSettings() {
    const payload = {
      apiKey: refs.apiKey?.value.trim() || "",
      model: refs.model?.value.trim() || "",
      system: refs.system?.value.trim() || ""
    };
    localStorage.setItem(settingsKey, JSON.stringify(payload));
    setStatus("Settings saved");
  }

  function hydrate() {
    const saved = getSaved();
    if (refs.apiKey) refs.apiKey.value = saved.apiKey || "";
    if (refs.model) refs.model.value = saved.model || "";
    if (refs.system) refs.system.value = saved.system || "";
  }

  function buildPayload(system, prompt) {
    return { contents: [{ parts: [{ text: system ? `System instructions:
${system}

User request:
${prompt}` : prompt }] }] };
  }

  function extractText(data) {
    return data?.candidates?.[0]?.content?.parts?.map((part) => part.text).join("
") || "No text returned.";
  }

  async function runGemini() {
    const apiKey = refs.apiKey?.value.trim() || "";
    const model = refs.model?.value.trim() || "";
    const system = refs.system?.value.trim() || "";
    const prompt = refs.prompt?.value.trim() || "";
    if (!apiKey || !model || !prompt) {
      setStatus("Missing API key, model, or prompt");
      showOutput("Fill in the API key, model name, and prompt.");
      return;
    }
    setStatus("Running...");
    showOutput("Waiting for Gemini response...");
    try {
      const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/${encodeURIComponent(model)}:generateContent?key=${encodeURIComponent(apiKey)}`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(buildPayload(system, prompt))
      });
      const data = await response.json();
      if (!response.ok) {
        showOutput(JSON.stringify(data, null, 2));
        setStatus("Request failed");
        return;
      }
      showOutput(extractText(data));
      setStatus("Done");
    } catch (error) {
      showOutput(error?.message || "Unknown error");
      setStatus("Network error");
    }
  }

  function clearOutput() { showOutput("Response will appear here."); setStatus("Idle"); }

  refs.save?.addEventListener("click", saveSettings);
  refs.clear?.addEventListener("click", clearOutput);
  refs.run?.addEventListener("click", runGemini);
  [refs.apiKey, refs.model, refs.system, refs.prompt].forEach((el) => {
    el?.addEventListener("keydown", (event) => {
      if (event.key === "Enter" && !event.shiftKey && el !== refs.system && el !== refs.prompt) {
        event.preventDefault();
        runGemini();
      }
    });
  });
  refs.clearAllData?.addEventListener("click", () => localStorage.removeItem(settingsKey));
  hydrate();
});
