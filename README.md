# ai — terminal command helper

Turn natural language into a best-effort Linux shell command.

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
