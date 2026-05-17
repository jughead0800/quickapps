#!/bin/sh
# Build script to generate index.html from apps.yml
# Uses only basic POSIX shell commands - no external dependencies (no yq required)

APPS_DIR="apps"
APPS_YML="apps.yml"
OUTPUT_FILE="index.html"

if [ ! -f "$APPS_YML" ]; then
    echo "Error: $APPS_YML not found in current directory" >&2
    exit 1
fi

# Start building index.html
cat > "$OUTPUT_FILE" << 'EOF'
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
EOF

# Emit a card for the currently buffered entry, then reset the buffer.
emit_card() {
    [ -z "$file" ] && return
    if [ ! -f "$APPS_DIR/$file" ]; then
        echo "Warning: $APPS_DIR/$file listed in $APPS_YML but not found - skipping" >&2
        file=""; title=""; emoji=""; summary=""
        return
    fi
    cat >> "$OUTPUT_FILE" << EOF
            <a href="apps/$file" target="_blank" class="app-card">
                <div class="app-icon">$emoji</div>
                <h3>$title</h3>
                <p class="app-summary">$summary</p>
            </a>
EOF
    file=""; title=""; emoji=""; summary=""
}

# Strip a leading "key: " prefix and surrounding double quotes from a value.
strip_value() {
    # $1 = full line, $2 = key (e.g. "file", "title")
    echo "$1" | sed "s/^[[:space:]]*-\{0,1\}[[:space:]]*$2:[[:space:]]*//; s/^\"//; s/\"$//"
}

in_apps=0
file=""; title=""; emoji=""; summary=""

# Parse apps.yml line by line (POSIX sh, no external YAML dependency)
while IFS= read -r line || [ -n "$line" ]; do
    # Skip comments and blank lines
    case "$line" in
        \#*) continue ;;
        "") continue ;;
    esac

    # Toggle into the apps: section
    case "$line" in
        apps:*) in_apps=1; continue ;;
    esac
    [ "$in_apps" -eq 0 ] && continue

    case "$line" in
        *-*file:*)
            # New entry - flush the previous one first
            emit_card
            file=$(strip_value "$line" "file")
            ;;
        *title:*)
            title=$(strip_value "$line" "title")
            ;;
        *emoji:*)
            emoji=$(strip_value "$line" "emoji")
            ;;
        *summary:*)
            summary=$(strip_value "$line" "summary")
            ;;
    esac
done < "$APPS_YML"

# Flush final entry
emit_card

# Close the apps grid and add footer
cat >> "$OUTPUT_FILE" << 'EOF'
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
EOF

echo "Index.html generated successfully!"
