# PowerShell build script to generate index.html from apps.yml
#
# Usage (from repo root):
#   pwsh -File .\build-index.ps1
#   .\build-index.ps1
#
# Reads metadata from apps.yml (title, emoji, summary per app) and emits
# a card for each entry into index.html, in the order listed.

# Run relative to this script's location so it works no matter where invoked.
Set-Location -Path $PSScriptRoot

$AppsDir   = "apps"
$AppsYml   = "apps.yml"
$OutputFile = "index.html"

if (-not (Test-Path $AppsYml)) {
    Write-Error "$AppsYml not found in $PSScriptRoot"
    exit 1
}

# Tiny line-based YAML parser - sufficient for the strict apps.yml format.
function Read-AppsYml {
    param([string]$Path)

    $entries = @()
    $current = $null
    $inApps  = $false

    foreach ($line in Get-Content -LiteralPath $Path -Encoding UTF8) {
        $trim = $line.Trim()
        if ($trim -eq "" -or $trim.StartsWith("#")) { continue }

        if ($trim -eq "apps:") { $inApps = $true; continue }
        if (-not $inApps) { continue }

        if ($line -match '^\s*-\s*file:\s*(.*)$') {
            if ($current) { $entries += ,$current }
            $current = [ordered]@{
                file    = $matches[1].Trim().Trim('"')
                title   = ""
                emoji   = ""
                summary = ""
            }
        }
        elseif ($current -and $line -match '^\s+title:\s*(.*)$') {
            $current.title = $matches[1].Trim().Trim('"')
        }
        elseif ($current -and $line -match '^\s+emoji:\s*(.*)$') {
            $current.emoji = $matches[1].Trim().Trim('"')
        }
        elseif ($current -and $line -match '^\s+summary:\s*(.*)$') {
            $current.summary = $matches[1].Trim().Trim('"')
        }
    }
    if ($current) { $entries += ,$current }
    return $entries
}

$apps = Read-AppsYml -Path $AppsYml

# HTML template - head
$html = @'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuickAPPS - Simple Tools for Simple Tasks</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #1a1a1a;
            color: #e0e0e0;
            min-height: 100vh;
            padding: 20px;
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        header {
            text-align: center;
            margin-bottom: 60px;
            padding-top: 40px;
        }

        h1 {
            color: #4a9eff;
            font-size: 3.5em;
            margin-bottom: 20px;
            font-weight: 700;
        }

        .tagline {
            color: #888;
            font-size: 1.3em;
            margin-bottom: 40px;
        }

        .intro-section {
            background: #2a2a2a;
            border: 1px solid #3a3a3a;
            border-radius: 8px;
            padding: 40px;
            margin-bottom: 50px;
            max-width: 900px;
            margin-left: auto;
            margin-right: auto;
        }

        .intro-section h2 {
            color: #4a9eff;
            font-size: 2em;
            margin-bottom: 20px;
        }

        .intro-section p {
            color: #e0e0e0;
            font-size: 1.1em;
            margin-bottom: 15px;
        }

        .intro-section .highlight {
            color: #4caf50;
            font-weight: 600;
        }

        .apps-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 50px;
        }

        .app-card {
            background: #2a2a2a;
            border: 1px solid #3a3a3a;
            border-radius: 8px;
            padding: 30px;
            transition: all 0.3s ease;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            display: block;
        }

        .app-card:hover {
            border-color: #4a9eff;
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(74, 158, 255, 0.2);
        }

        .app-card h3 {
            color: #4a9eff;
            font-size: 1.8em;
            margin: 0;
        }

        .app-card .app-icon {
            font-size: 3em;
            margin-bottom: 10px;
        }

        .app-card .app-summary {
            color: #b0b0b0;
            font-size: 1em;
            line-height: 1.5;
            margin-top: 12px;
        }


        .features {
            background: #1e1e1e;
            border-radius: 6px;
            padding: 20px;
            margin-top: 30px;
        }

        .features h3 {
            color: #4a9eff;
            margin-bottom: 15px;
            font-size: 1.3em;
        }

        .features ul {
            list-style: none;
            padding-left: 0;
        }

        .features li {
            color: #e0e0e0;
            margin-bottom: 10px;
            padding-left: 25px;
            position: relative;
        }

        .features li:before {
            content: "✓";
            position: absolute;
            left: 0;
            color: #4caf50;
            font-weight: bold;
        }

        footer {
            text-align: center;
            margin-top: 80px;
            padding: 40px 20px;
            color: #888;
            border-top: 1px solid #3a3a3a;
        }

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-top: 20px;
            flex-wrap: wrap;
        }

        .footer-links a {
            color: #4a9eff;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            border: 1px solid #3a3a3a;
            border-radius: 6px;
            background: #1e1e1e;
            transition: all 0.3s ease;
        }

        .footer-links a:hover {
            border-color: #4a9eff;
            background: #2a2a2a;
            transform: translateY(-2px);
        }

        .footer-links a .icon {
            font-size: 1.2em;
        }

        .privacy-note {
            background: #1e1e1e;
            border-left: 4px solid #4caf50;
            border-radius: 6px;
            padding: 20px;
            margin-top: 30px;
        }

        .privacy-note strong {
            color: #4caf50;
        }

        @media (max-width: 768px) {
            h1 {
                font-size: 2.5em;
            }

            .tagline {
                font-size: 1.1em;
            }

            .intro-section {
                padding: 25px;
            }

            .apps-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>⚡ QuickAPPS</h1>
            <p class="tagline">Simple Tools for Simple Tasks</p>
        </header>

        <div class="intro-section">
            <h2>What are QuickAPPS?</h2>
            <p>
                QuickAPPS are lightweight, HTML-based applications designed to run entirely in your web browser.
                Built with simplicity and privacy in mind, these tools provide essential functionality without
                the bloat, ads, or data harvesting found in many modern applications.
            </p>
            <p>
                Every QuickAPP operates <span class="highlight">100% client-side</span>, meaning all your data
                stays on your device. No servers, no cloud storage, no tracking—just pure functionality when
                and where you need it.
            </p>
            <p>
                Whether you're comparing files, generating invoices, or tracking expenses, QuickAPPS deliver
                the features you need without the fluff you don't.
            </p>

            <div class="features">
                <h3>Why Choose QuickAPPS?</h3>
                <ul>
                    <li>Works in any modern browser—no installation required</li>
                    <li>Complete privacy—all data stored locally on your device</li>
                    <li>No ads, no tracking, no data harvesting</li>
                    <li>Fast and lightweight—no unnecessary features</li>
                    <li>Offline capable—works without an internet connection</li>
                    <li>Open and transparent—view the source code anytime</li>
                </ul>
            </div>

            <div class="privacy-note">
                <strong>Privacy First:</strong> All QuickAPPS process data entirely in your browser.
                Files are never uploaded to servers, and settings are stored locally using your browser's
                built-in storage. Your data never leaves your device.
            </div>
        </div>

        <div class="apps-grid">
'@

# Generate app cards from apps.yml entries.
# Build cards as line-per-element so we control newlines explicitly
# (PowerShell here-strings don't preserve the trailing newline before the
# closing terminator, so concatenating multiple cards glues them together).
$html += "`n"
foreach ($app in $apps) {
    $appPath = Join-Path $AppsDir $app.file
    if (-not (Test-Path -LiteralPath $appPath)) {
        Write-Warning "$appPath listed in $AppsYml but not found - skipping"
        continue
    }

    $html += "            <a href=""apps/$($app.file)"" target=""_blank"" class=""app-card"">`n"
    $html += "                <div class=""app-icon"">$($app.emoji)</div>`n"
    $html += "                <h3>$($app.title)</h3>`n"
    $html += "                <p class=""app-summary"">$($app.summary)</p>`n"
    $html += "            </a>`n"
}

# HTML template - tail
$html += @'
        </div>

        <footer>
            <p>QuickAPPS - Simple, Private, Functional</p>
            <p style="margin-top: 10px; font-size: 0.9em; color: #666;">
                All applications run entirely in your browser. No data is collected or transmitted.
            </p>
            <div class="footer-links">
                <a href="https://discord.true-frontier.com" target="_blank" rel="noopener noreferrer">
                    <span class="icon">💬</span>
                    <span>Discord</span>
                </a>
                <a href="https://www.buymeacoffee.com/truefrontier" target="_blank" rel="noopener noreferrer">
                    <span class="icon">☕</span>
                    <span>Buy Me a Coffee</span>
                </a>
            </div>
        </footer>
    </div>
</body>
</html>
'@ + "`n"

# Write index.html as UTF-8 without BOM (works in both PS5.1 and PS7+)
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText((Join-Path $PSScriptRoot $OutputFile), $html, $utf8NoBom)

Write-Host "$OutputFile generated successfully ($($apps.Count) apps)."
