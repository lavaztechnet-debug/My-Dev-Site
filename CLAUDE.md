# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

NeuroStack Mobile is a framework-free, no-build-step static web app (vanilla HTML/CSS/JS) wrapped with Capacitor 6 for Android APK builds. There are no tests and no linter. All data (notes, saved prompts, theme) lives in browser localStorage; there is no backend.

## Commands

```bash
npm install                # installs Capacitor only (the web app has no dependencies)
npm run build              # copies web files into dist/ (webDir for Capacitor)
npm run cap:sync           # npx cap sync android — copies dist/ into android/app/src/main/assets/public/
cd android && ./gradlew assembleDebug   # builds the debug APK (requires Java 17)
```

For local development just open `index.html` in a browser or serve the repo root (e.g. `python3 -m http.server`) — no build step needed; the files at the repo root ARE the app.

## Architecture

Five standalone pages linked by plain anchor tags (multi-page, despite the "SPA" name): `index.html` (dashboard), `notes.html`, `prompts.html`, `gemini.html`, and `nexus-vault.html`. The first four share `styles.css` and load `app.js` (index and prompts also load `prompt-library.js` first). `nexus-vault.html` is a fully self-contained page (own inline CSS/JS, own prompt database, own localStorage keys prefixed `nexus_vault_*`/`powerpad_*`) — it does not use `styles.css`, `app.js`, or the shared theme toggle; it links back to `index.html` from its tab bar.

- **`app.js`** — the entire app logic in one IIFE. It runs every `bind*Page()` function on every page; each binder no-ops by returning early if its element IDs aren't present. To add behavior to a page, follow this pattern rather than branching on the page name. All user content rendered via `innerHTML` must go through the local `escapeHtml()` helper.
- **localStorage keys are versioned** (`neurostack_notes_v5`, `neurostack_prompts_v5`, `neurostack_theme_v3`). Bump the version suffix only when the stored shape changes incompatibly — it silently orphans users' existing data.
- **`prompt-library.js`** — a large generated data file (~1700 lines) that assigns `window.NEUROSTACK_PROMPT_LIBRARY` (array of `{id, category, title, body}`). `app.js` reads it through `libraryData()`, which also falls back to `window.NEUROSTACKPROMPTLIBRARY`. The source material it was generated from lives in `output/` (JSON/text extracted from PDFs); edit `prompt-library.js` directly for changes, `output/` is not wired into anything.
- **Theming** — `styles.css` defines a dark "blue noir" theme via CSS custom properties on `:root` and a light theme via `:root[data-theme="light"]` overrides. The toggle in `app.js` stamps `data-theme` on `<html>` and persists it. New colors/shadows should be custom properties defined in both themes.
- **`gemini.js`** — near-empty metadata stub; the Gemini page just copies prompt text and opens gemini.google.com externally. There is no API call.

## File-list gotcha (important)

The set of deployable files is hardcoded in three places that must be kept in sync when adding/renaming a top-level web file:

1. `package.json` `build` script (cp list → `dist/`)
2. `.github/workflows/pages.yml` "Prepare clean site folder" step (cp list → `_site/`)
3. Nothing else — `capacitor.config.json` points at `dist/`, so Android picks up whatever `build` copies.


## Android / Capacitor

- `android/` is the checked-in Capacitor-generated Gradle project. `android/app/src/main/assets/public/` is a synced copy of `dist/` — never edit it by hand; run `npm run build && npm run cap:sync` instead.
- App id: `com.lavaztechnet.neurostack`.

## CI

Both workflows trigger on push to `main` (plus manual dispatch):

- `.github/workflows/build-apk.yml` — builds the debug APK and uploads it as an artifact.
- `.github/workflows/pages.yml` — deploys the static site to GitHub Pages.

## Legacy scripts — do not run

`rebuild-neurostack-walnut.sh` and `fix-neurostack-pages-and-library.sh` are historical Termux generator scripts that overwrite the app files wholesale with older versions (hardcoded `/data/data/com.termux/...` paths). They are kept as history only.
