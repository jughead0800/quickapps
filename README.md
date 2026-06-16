# QuickAPPS

Simple, lightweight HTML-based applications that run entirely in your browser.

see them live at quickapps.true-frontier.com

## What are QuickAPPS?

QuickAPPS are lightweight, HTML-based applications designed to run entirely in your web browser. Built with simplicity and privacy in mind, these tools provide essential functionality without the bloat, ads, or data harvesting found in many modern applications.

Every QuickAPP operates **100% client-side**, meaning all your data stays on your device. No servers, no cloud storage, no tracking—just pure functionality when and where you need it.

## Features

- Works in any modern browser—no installation required
- Complete privacy—all data stored locally on your device
- No ads, no tracking, no data harvesting
- Fast and lightweight—no unnecessary features
- Offline capable—works without an internet connection
- Open and transparent—view the source code anytime

## Available Apps

App HTML files live in the `apps/` folder. The set of cards rendered on the `index.html` landing page — along with each card's title and emoji — is defined in [`apps.yml`](apps.yml) at the repo root.

## Adding a New App

1. Drop the `.html` file into `apps/`.
2. Add an entry to `apps.yml` with the filename, title, emoji, and a one-line summary.
3. Run a build script (or push to `main` and let CI rebuild).

Apps that exist in `apps/` but are not listed in `apps.yml` will not appear on the landing page. Cards render in the order listed in `apps.yml`.

## Creating an App (Authoring Guide)

This is a self-contained spec for building a new QuickAPP — detailed enough that a person *or an LLM* can produce a compatible app from scratch. (The three steps above are the short version.)

### 1. Hard rules (non-negotiable)

- **One file.** Each app is a single `.html` file in `apps/`. Put all CSS in one `<style>` in the `<head>` and all JavaScript in one `<script>` just before `</body>`.
- **100% client-side.** No backend, no `fetch`/`XMLHttpRequest` to any server, no analytics or tracking. The app must work when opened directly via `file://` and while fully offline.
- **No external dependencies.** No CDN `<script>`s, no web-font or stylesheet `<link>`s, no remote images. Use vanilla JavaScript and built-in browser APIs only. For icons, use an emoji or inline SVG.
- **Persistence is optional and local.** If you need to save state, use `localStorage` with a namespaced key (e.g. `floorplan.state`). Data never leaves the device.
- **Don't edit `index.html`.** It is generated from `apps.yml` (see [Building the Index](#building-the-index)).

### 2. Required page skeleton

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>App Name</title>
  <style>/* all CSS here */</style>
</head>
<body>
  <div class="container">
    <h1>🧩 App Name</h1>  <!-- start with the same emoji used on the app's card -->
    <!-- UI here -->
  </div>
  <script>/* all JS here */</script>
</body>
</html>
```

### 3. Visual style — match the family

Most apps (and the landing page) share one dark theme. Declare it once in `:root` and use `var(--…)` so your app looks at home next to the others. A custom palette is allowed, but the canonical one is recommended.

| Variable | Value | Use |
|---|---|---|
| `--bg` | `#1a1a1a` | page background |
| `--panel` | `#2a2a2a` | cards / panels |
| `--inset` | `#1e1e1e` | inputs, tables, insets |
| `--border` | `#3a3a3a` | borders / dividers |
| `--text` | `#e0e0e0` | body text |
| `--muted` | `#888` | labels, secondary text |
| `--accent` | `#4a9eff` | headings, focus, primary buttons |
| `--success` | `#4caf50` | positive / totals |
| `--danger` | `#f44336` | destructive actions |

- Font: `'Segoe UI', Tahoma, Geneva, Verdana, sans-serif`.
- Panels: `border-radius: 8px`, `1px solid var(--border)`, `20–30px` padding.
- Inputs and tables sit on the `--inset` background; use `--accent` for the focus border.
- Center content in a `.container` with `max-width: ~1200px; margin: 0 auto`.
- Be responsive: collapse multi-column layouts under `@media (max-width: 768px)`.

### 4. Copy-paste starter template

A complete, working skeleton (it persists a note to `localStorage` and downloads it as a file). Save it as `apps/your-app.html`, then change the title and emoji and replace the panel contents with your app.

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My App</title>
  <style>
    :root {
      --bg: #1a1a1a; --panel: #2a2a2a; --inset: #1e1e1e; --border: #3a3a3a;
      --text: #e0e0e0; --muted: #888; --accent: #4a9eff;
      --success: #4caf50; --danger: #f44336;
      --font: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: var(--font); background: var(--bg); color: var(--text);
           min-height: 100vh; padding: 20px; line-height: 1.5; }
    .container { max-width: 1200px; margin: 0 auto; }
    h1 { text-align: center; color: var(--accent); font-size: 2em; margin-bottom: 24px; }
    .panel { background: var(--panel); border: 1px solid var(--border);
             border-radius: 8px; padding: 24px; margin-bottom: 20px; }
    .toolbar { display: flex; gap: 10px; flex-wrap: wrap; margin-bottom: 16px; }
    button { font-family: var(--font); font-size: 0.95em; background: var(--inset);
             color: var(--text); border: 1px solid var(--border); border-radius: 6px;
             padding: 10px 16px; cursor: pointer; transition: all 0.2s ease; }
    button:hover { border-color: var(--accent); }
    button.primary { background: var(--accent); color: #fff; border-color: var(--accent); font-weight: 600; }
    button.primary:hover { filter: brightness(1.1); }
    textarea { width: 100%; min-height: 240px; resize: vertical; background: var(--inset);
               color: var(--text); border: 1px solid var(--border); border-radius: 6px;
               padding: 12px; font-family: var(--font); font-size: 1em; outline: none; }
    textarea:focus { border-color: var(--accent); }
    .status { color: var(--muted); font-size: 0.9em; margin-top: 10px; }
    @media (max-width: 768px) {
      .toolbar { flex-direction: column; }
      .toolbar button { width: 100%; }
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>🧩 My App</h1>
    <div class="panel">
      <div class="toolbar">
        <button class="primary" id="saveBtn">Save</button>
        <button id="downloadBtn">Download .txt</button>
        <button id="clearBtn">Clear</button>
      </div>
      <textarea id="content" placeholder="Start typing…"></textarea>
      <div class="status" id="status"></div>
    </div>
  </div>

  <script>
    'use strict';
    const STORAGE_KEY = 'myapp.state';          // namespace this per app
    const $ = (id) => document.getElementById(id);

    function setStatus(msg) { $('status').textContent = msg; }

    function loadState() {
      try {
        const raw = localStorage.getItem(STORAGE_KEY);
        if (raw) $('content').value = JSON.parse(raw).text || '';
      } catch (e) { /* ignore corrupt or blocked storage */ }
    }
    function saveState() {
      try {
        localStorage.setItem(STORAGE_KEY, JSON.stringify({ text: $('content').value }));
        setStatus('Saved.');
      } catch (e) { setStatus('Could not save (storage blocked).'); }
    }
    function downloadBlob(blob, filename) {
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url; a.download = filename;
      document.body.appendChild(a); a.click(); document.body.removeChild(a);
      URL.revokeObjectURL(url);
    }

    $('saveBtn').addEventListener('click', saveState);
    $('downloadBtn').addEventListener('click', () =>
      downloadBlob(new Blob([$('content').value], { type: 'text/plain' }), 'my-app.txt'));
    $('clearBtn').addEventListener('click', () => { $('content').value = ''; saveState(); });

    loadState();
  </script>
</body>
</html>
```

### 5. Reusable patterns

**Persist to `localStorage`** (namespace the key per app):

```js
const STORAGE_KEY = 'myapp.state';
function saveState(state) {
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(state)); } catch (e) {}
}
function loadState() {
  try { return JSON.parse(localStorage.getItem(STORAGE_KEY)) || {}; } catch (e) { return {}; }
}
```

**Download a generated file** (CSV, JSON, text, image — anything):

```js
function downloadBlob(blob, filename) {
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url; a.download = filename;
  document.body.appendChild(a); a.click(); document.body.removeChild(a);
  URL.revokeObjectURL(url);
}
// e.g. downloadBlob(new Blob([csv], { type: 'text/csv' }), 'data.csv');
```

**Read an uploaded file** (nothing is uploaded — it is read locally):

```js
fileInput.addEventListener('change', (e) => {
  const file = e.target.files[0];
  if (!file) return;
  const reader = new FileReader();
  reader.onload = () => { /* reader.result holds the contents */ };
  reader.readAsText(file);        // or reader.readAsDataURL(file) for images
  e.target.value = '';            // allow re-selecting the same file
});
```

**Export a canvas (or drawing) as PNG** — e.g. for a floor-plan or diagram app:

```js
canvas.toBlob((blob) => downloadBlob(blob, 'plan.png'), 'image/png');
```

### 6. Register your app in `apps.yml`

Add a four-field entry. Cards render in the order listed.

```yaml
  - file: floor-plan-designer.html
    title: Floor Plan Designer
    emoji: "📐"
    summary: Draw walls, doors, and windows to scale and export the plan as a PNG.
```

The build script is a simple line parser (not a full YAML engine) and injects these values straight into HTML, so:

- Keep indentation exact: `  - file:` (2 spaces), then `title` / `emoji` / `summary` indented 4 spaces.
- **Always quote the emoji**: `emoji: "📐"`.
- One value per line — no multi-line or block (`>` / `|`) scalars.
- `title` and `summary` are plain text — avoid `<`, `>`, `&`, and `"`.
- The `file:` value is **case-sensitive** and must match the filename exactly. Spaces are allowed, but prefer lowercase-hyphenated names for new apps (e.g. `floor-plan-designer.html`).

Then build (see [Building the Index](#building-the-index)): run `./build-index.sh` (or `.\build-index.ps1`) to preview locally, or push to `main` and let CI rebuild.

### 7. Pre-publish checklist

- [ ] Single `.html` file; opens via `file://` with no console errors.
- [ ] Works fully offline — no requests in the browser's Network tab.
- [ ] No external/CDN scripts, fonts, stylesheets, or images.
- [ ] Dark theme matches the palette; layout is readable and responsive at ≤768px.
- [ ] `<h1>` starts with the same emoji used on the card.
- [ ] Any saved state uses a namespaced `localStorage` key.
- [ ] Added to `apps.yml` (exact filename, quoted emoji, plain-text title/summary).
- [ ] Ran the build script (or pushed) and the card shows up on `index.html`.

## Building the Index

The index page is automatically built when changes are pushed to the `main` branch. The build process:

1. Reads `apps.yml` for the ordered list of apps and their metadata
2. Generates a card per entry (skipping with a warning if the listed file is missing)
3. Writes the result to `index.html`

### Manual Build

To build the index manually:

**Using Bash:**
```bash
chmod +x build-index.sh
./build-index.sh
```

**Using PowerShell:**
```powershell
.\build-index.ps1
```

## Project Structure

```
QuickAPPS/
├── apps/              # Application HTML files
│   ├── file-compare.html
│   ├── invoiceapp.html
│   └── Recipt Calc.html
├── apps.yml           # App metadata (title, emoji, summary, order)
├── index.html         # Auto-generated landing page
├── build-index.sh     # Bash build script
├── build-index.ps1    # PowerShell build script
└── .gitea/
    └── workflows/
        └── build.yml  # Gitea Actions workflow
```

## CI/CD

The project uses Gitea Actions to automatically rebuild the index when:
- Files in the `apps/` folder are modified
- The build scripts are updated
- The workflow file is changed

The workflow runs on the `alpine:latest` container (smallest possible) and uses bash for the build process.

## Privacy

All QuickAPPS process data entirely in your browser. Files are never uploaded to servers, and settings are stored locally using your browser's built-in storage. Your data never leaves your device.

## Links

- [Discord](https://discord.true-frontier.com)
- [Buy Me a Coffee](https://www.buymeacoffee.com/truefrontier)

