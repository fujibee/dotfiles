#!/usr/bin/env bash
set -euo pipefail

# usage: ai <claude|codex|gemini> [-c|continue|-r|resume] [args...]
ENGINE="${1:-}"
shift || true

if [[ -z "${ENGINE}" ]]; then
  echo "Usage: ai <claude|codex|gemini> [-c|continue|-r|resume] [--safe] [args...]"
  exit 2
fi

# Resolve engine by prefix match
resolve_engine() {
  local input="$1"
  local matches=()
  for e in claude codex gemini; do
    [[ "$e" == "$input"* ]] && matches+=("$e")
  done
  if [[ ${#matches[@]} -eq 1 ]]; then
    echo "${matches[0]}"
  elif [[ ${#matches[@]} -gt 1 ]]; then
    echo "Ambiguous engine: $input (matches: ${matches[*]})" >&2
    return 1
  else
    echo "Unknown engine: $input (expected: claude|codex|gemini)" >&2
    return 1
  fi
}

ENGINE="$(resolve_engine "$ENGINE")" || exit 2

# Parse subcommands and flags
SUBCMD=""
TARGET=""
SAFE_MODE=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    continue|-c)
      SUBCMD="continue"; shift ;;
    resume|-r)
      SUBCMD="resume"; shift
      # Capture optional target argument
      if [[ -n "${1:-}" ]] && [[ ! "$1" =~ ^- ]]; then
        TARGET="$1"; shift
      fi
      ;;
    --safe)
      SAFE_MODE=true; shift ;;
    *)
      break ;;
  esac
done

# Find repo root (prefer git), else current dir
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

# For continue/resume, skip AGENT.md loading — it's already in the session
if [[ -z "$SUBCMD" ]]; then
  AGENTS_PATH="$REPO_ROOT/AGENTS.md"

  if [[ ! -f "$AGENTS_PATH" ]]; then
    echo "AGENTS.md not found: $AGENTS_PATH"
    echo "Hint: put AGENTS.md at repo root ($REPO_ROOT)"
    exit 1
  fi

  AGENT_TEXT="$(cat "$AGENTS_PATH")"

  # A robust injection prefix (works for codex/gemini as initial prompt)
  INJECT_PROMPT=$(
    cat <<'EOF'
You must follow the repository instructions below (AGENTS.md). If there is any conflict with my request, ask a clarifying question before proceeding.

--- BEGIN AGENTS.md ---
EOF
    printf "%s\n" "$AGENT_TEXT"
    cat <<'EOF'
--- END AGENTS.md ---
EOF
  )
fi

case "$ENGINE" in
  claude)
    cd "$REPO_ROOT"
    # Default: --dangerously-skip-permissions; use --safe to disable
    CLAUDE_ARGS=()
    if [[ "$SAFE_MODE" == false ]]; then
      CLAUDE_ARGS+=(--allow-dangerously-skip-permissions)
    fi
    # For continue/resume, skip system prompt — it's already in the session
    if [[ "$SUBCMD" == "continue" ]]; then
      exec claude --continue "${CLAUDE_ARGS[@]}"
    elif [[ "$SUBCMD" == "resume" ]]; then
      if [[ -n "$TARGET" ]]; then
        exec claude --resume "$TARGET" "${CLAUDE_ARGS[@]}"
      else
        exec claude --resume "${CLAUDE_ARGS[@]}"
      fi
    else
      exec claude --append-system-prompt "$AGENT_TEXT" "${CLAUDE_ARGS[@]}" "$@"
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
    # Should not reach here due to resolve_engine above
    echo "Unknown engine: $ENGINE" >&2
    exit 2
    ;;
esac

