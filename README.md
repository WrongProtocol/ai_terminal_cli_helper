# ai — terminal command helper

Turn natural language into a best-effort Linux shell command.

As a long-time linux user, I really didn't want to make a "cheat app" and lose my CLI dignity. However, I've given in, and it's amazing. 

Configuration supports ollama, openai, or openclaw as the ai provider. It's a single-file app, easy to edit. 

## Install

```bash
cd ~/ai_terminal_cli_helper
./install.sh
```

This will symlink `ai` into `~/.local/bin/ai` and create a default config at `~/.config/ai/config.json`.

## Usage

```bash
ai search running processes for python
# ps -A | grep -i python

ai --run find what is listening on port 8000

ai --explain show disk usage by directory
# COMMAND: df -h

# Shows free/used space for all mounted filesystems in human-readable units.
# Look at the “Avail” column for available space and “Use%” for utilization.
# If you only care about a specific path, you can use: df -h /path/to/check
```

## Providers

Configured in `~/.config/ai/config.json`:

- `openclaw` (recommended if your OpenClaw Gateway is configured with Claude Opus 4.6)
- `openai` (requires `OPENAI_API_KEY` or configured env var)
- `ollama` (defaults to `http://localhost:11434`)

Override per call:

```bash
ai --provider ollama list files bigger than 1GB
```

## Notes

- Biased toward read-only commands.
- If the request seems destructive/unsafe, it returns `UNKNOWN`.
