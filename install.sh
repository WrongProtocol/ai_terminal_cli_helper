#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_SRC="$SCRIPT_DIR/bin/ai"
BIN_DST="$HOME/.local/bin/ai"
CONFIG="$HOME/.config/ai/config.json"

if [[ ! -f "$BIN_SRC" ]]; then
    echo "Error: $BIN_SRC not found" >&2
    exit 1
fi

# Ensure the script is executable
chmod +x "$BIN_SRC"

# Symlink into ~/.local/bin
mkdir -p "$HOME/.local/bin"
ln -sf "$BIN_SRC" "$BIN_DST"

# Create default config if missing
"$BIN_DST" --init >/dev/null 2>&1 || true

echo "Installed: $BIN_DST -> $BIN_SRC"
echo "Config:    $CONFIG"

# Check if ~/.local/bin is in PATH
if ! echo "$PATH" | tr ':' '\n' | grep -qx "$HOME/.local/bin"; then
    echo ""
    echo "Warning: $HOME/.local/bin is not in your PATH."
    echo "Add this to your ~/.bashrc or ~/.zshrc:"
    echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
fi
