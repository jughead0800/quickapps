# QuickAPPS

Simple, lightweight HTML-based applications that run entirely in your browser.

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

All apps are located in the `apps/` folder. The `index.html` landing page is automatically generated from the apps in this folder.

## Building the Index

The index page is automatically built when changes are pushed to the `main` branch. The build process:

1. Scans the `apps/` folder for HTML files
2. Extracts titles and generates app cards
3. Updates `index.html` with links to all apps

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

