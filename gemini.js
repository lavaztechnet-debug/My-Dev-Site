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
    clear: document.getElementById("clearGeminiOutput")
  };

  function getSaved() {
    try {
      return JSON.parse(localStorage.getItem(settingsKey)) || {};
    } catch {
      return {};
    }
  }

  function saveSettings() {
    const payload = {
      apiKey: refs.apiKey.value.trim(),
      model: refs.model.value.trim(),
      system: refs.system.value.trim()
    };
    localStorage.setItem(settingsKey, JSON.stringify(payload));
    setStatus("Settings saved");
  }

  function hydrate() {
    const saved = getSaved();
    refs.apiKey.value = saved.apiKey || "";
    refs.model.value = saved.model || "";
    refs.system.value = saved.system || "";
  }

  function setStatus(text) {
    refs.status.textContent = text;
  }

  async function runGemini() {
    const apiKey = refs.apiKey.value.trim();
    const model = refs.model.value.trim();
    const system = refs.system.value.trim();
    const prompt = refs.prompt.value.trim();

    if (!apiKey || !model || !prompt) {
      setStatus("Missing API key, model, or prompt");
      refs.output.textContent = "Fill in the API key, model name, and prompt.";
      return;
    }

    setStatus("Running...");
    refs.output.textContent = "Waiting for Gemini response...";

    try {
      const response = await fetch(
        `https://generativelanguage.googleapis.com/v1beta/models/${encodeURIComponent(model)}:generateContent?key=${encodeURIComponent(apiKey)}`,
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            contents: [
              {
                parts: [
                  {
                    text: system
                      ? `System instructions:
${system}

User request:
${prompt}`
                      : prompt
                  }
                ]
              }
            ]
          })
        }
      );

      const data = await response.json();

      if (!response.ok) {
        refs.output.textContent = JSON.stringify(data, null, 2);
        setStatus("Request failed");
        return;
      }

      const text =
        data?.candidates?.[0]?.content?.parts?.map((part) => part.text).join("
") ||
        "No text returned.";

      refs.output.textContent = text;
      setStatus("Done");
    } catch (error) {
      refs.output.textContent = error.message || "Unknown error";
      setStatus("Network error");
    }
  }

  refs.save.addEventListener("click", saveSettings);
  refs.clear.addEventListener("click", () => {
    refs.output.textContent = "Response will appear here.";
    setStatus("Idle");
  });
  refs.run.addEventListener("click", runGemini);

  hydrate();
});