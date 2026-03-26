# ai — terminal command helper

Turn natural language into a best-effort Linux shell command.

## Install

```bash
cd ~/ai_terminal_cli_helper
./install.sh
```

This symlinks `ai` into `~/.local/bin/ai` and creates a default config at `~/.config/ai/config.json`.

**Requires:** Python 3.10+ (stdlib only, no pip dependencies).

## Usage

```bash
# Get a command (prints to stdout)
ai search running processes for python
# ps -A | grep -i python

# Show, confirm, then execute
ai --run find what is listening on port 8000

# Execute without confirmation prompt
ai --run -y show free memory

# Get explanation + command
ai --explain show disk usage by directory

# Combine: explain, then offer to run
ai --run --explain find large log files

# Override provider for one call
ai --provider ollama list files bigger than 1GB
```

### Quotes and special characters

Quotes and apostrophes in your request are handled naturally:

```bash
ai what's my public IP
ai find files named "hello world.txt"
ai grep for lines containing single quote in /etc/passwd
```

## Providers

Set the default in `~/.config/ai/config.json`:

| Provider | Best for | Requires |
|----------|----------|----------|
| `openclaw` | Local Gateway with a strong model (default) | `openclaw` CLI on PATH |
| `openai` | Cloud API, fast | `OPENAI_API_KEY` env var |
| `ollama` | Fully local/offline | Ollama server running |

Override per call with `--provider`.

## Config

Default config (`~/.config/ai/config.json`):

```json
{
  "provider": "openclaw",
  "openclaw": {
    "session_id": "ai-cli",
    "agent": null,
    "thinking": "low"
  },
  "openai": {
    "api_key_env": "OPENAI_API_KEY",
    "base_url": "https://api.openai.com/v1",
    "model": "gpt-5.2"
  },
  "ollama": {
    "base_url": "http://localhost:11434",
    "model": "qwen3:14b"
  },
  "behavior": {
    "shell": "bash",
    "max_tokens": 256,
    "temperature": 0.1,
    "confirm_before_run": true,
    "timeout": 60
  }
}
```

You only need to set the fields you want to change; missing keys fall back to defaults.

### Behavior options

- **`shell`** — Shell used to execute commands with `--run` (default: `bash`).
- **`max_tokens`** — Max response length from the model.
- **`temperature`** — Lower = more deterministic commands.
- **`confirm_before_run`** — Show the command and ask before executing (default: `true`). Skip per-call with `-y`.
- **`timeout`** — HTTP request timeout in seconds.

## Safety

- Biased toward read-only, non-destructive commands.
- Destructive requests (rm, dd, mkfs, etc.) return `UNKNOWN` unless the intent is explicit.
- `--run` shows the command and asks for confirmation before executing (unless `-y` is passed).
- Commands are executed via your configured shell (default: bash), so pipes and redirects work.

## Scripting

The command is printed to **stdout**, status messages go to **stderr**. This means you can pipe/capture cleanly:

```bash
# Capture just the command
CMD=$(ai list all docker containers)
echo "Got: $CMD"

# Pipe into clipboard (Linux)
ai show my git remotes | xclip -sel clip
```

Exit codes:
- `0` — success
- `1` — provider error (network, auth, etc.)
- `2` — bad usage / no query
- `3` — model returned UNKNOWN (could not produce a command)
- `130` — interrupted (Ctrl+C)
