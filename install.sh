#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.local/bin"
ln -sf "$HOME/ai_terminal_cli_helper/bin/ai" "$HOME/.local/bin/ai"

# create default config if missing
"$HOME/.local/bin/ai" --init >/dev/null

echo "Installed: $HOME/.local/bin/ai"
echo "Config:    $HOME/.config/ai/config.json"
