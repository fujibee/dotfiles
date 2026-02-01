#!/usr/bin/env bash
set -euo pipefail

# usage: ai <claude|codex|gemini> [continue|resume] [args...]
ENGINE="${1:-}"
shift || true

if [[ -z "${ENGINE}" ]]; then
  echo "Usage: ai <claude|codex|gemini> [continue|resume] [args...]"
  exit 2
fi

# Check for continue/resume subcommand
SUBCMD=""
TARGET=""
if [[ "${1:-}" == "continue" ]] || [[ "${1:-}" == "resume" ]]; then
  SUBCMD="$1"
  shift || true
  # For resume, capture optional target argument
  if [[ "$SUBCMD" == "resume" ]] && [[ -n "${1:-}" ]] && [[ ! "$1" =~ ^- ]]; then
    TARGET="$1"
    shift || true
  fi
fi

# Find repo root (prefer git), else current dir
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
AGENT_PATH="$REPO_ROOT/AGENT.md"

if [[ ! -f "$AGENT_PATH" ]]; then
  echo "AGENT.md not found: $AGENT_PATH"
  echo "Hint: put AGENT.md at repo root ($REPO_ROOT)"
  exit 1
fi

AGENT_TEXT="$(cat "$AGENT_PATH")"

# A robust injection prefix (works for codex/gemini as initial prompt)
INJECT_PROMPT=$(
  cat <<'EOF'
You must follow the repository instructions below (AGENT.md). If there is any conflict with my request, ask a clarifying question before proceeding.

--- BEGIN AGENT.md ---
EOF
  printf "%s\n" "$AGENT_TEXT"
  cat <<'EOF'
--- END AGENT.md ---
EOF
)

case "$ENGINE" in
  claude)
    cd "$REPO_ROOT"
    # Claude Code supports system prompt append directly
    if [[ "$SUBCMD" == "continue" ]]; then
      exec claude --continue --append-system-prompt "$AGENT_TEXT"
    elif [[ "$SUBCMD" == "resume" ]]; then
      if [[ -n "$TARGET" ]]; then
        exec claude --resume "$TARGET" --append-system-prompt "$AGENT_TEXT"
      else
        exec claude --resume --append-system-prompt "$AGENT_TEXT"
      fi
    else
      exec claude --append-system-prompt "$AGENT_TEXT" "$@"
    fi
    ;;

  codex)
    cd "$REPO_ROOT"
    if [[ "$SUBCMD" == "continue" ]]; then
      exec codex resume --last
    elif [[ "$SUBCMD" == "resume" ]]; then
      # target無しは --last、latest も --last に寄せる
      if [[ -z "$TARGET" ]] || [[ "$TARGET" == "latest" ]]; then
        exec codex resume --last
      else
        exec codex resume "$TARGET"
      fi
    else
      # Codex CLI: no system flag shown -> inject as the initial user prompt
      # If user provided prompt args, keep them appended after the injection.
      if [[ $# -gt 0 ]]; then
        exec codex "$INJECT_PROMPT"$'\n\n'"User request:"$'\n'"$*"
      else
        exec codex "$INJECT_PROMPT"
      fi
    fi
    ;;

  gemini)
    cd "$REPO_ROOT"
    if [[ "$SUBCMD" == "continue" ]]; then
      exec gemini -r latest
    elif [[ "$SUBCMD" == "resume" ]]; then
      # target無しは latest
      if [[ -z "$TARGET" ]]; then
        exec gemini -r latest
      else
        exec gemini -r "$TARGET"
      fi
    else
      # Gemini CLI: use interactive with an initial prompt injection.
      # If args exist, treat them as an initial query.
      if [[ $# -gt 0 ]]; then
        exec gemini -i "$INJECT_PROMPT"$'\n\n'"User request:"$'\n'"$*"
      else
        exec gemini -i "$INJECT_PROMPT"
      fi
    fi
    ;;

  *)
    echo "Unknown engine: $ENGINE (expected: claude|codex|gemini)"
    exit 2
    ;;
esac

