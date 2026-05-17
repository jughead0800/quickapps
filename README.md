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

