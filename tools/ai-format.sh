#!/bin/zsh
set -euo pipefail

# Load environment variables from ~/.env.local if it exists
[[ -f ~/.env.local ]] && source ~/.env.local

# Model configuration (can be overridden via environment variable)
MODEL="${AI_FORMAT_MODEL:-gpt-5-nano}"

# System prompt for natural English formatting
SYSTEM_PROMPT="Reformulate messages for casual yet professional business communication (Slack, Telegram, etc.). Maintain the original meaning while enhancing grammar for clarity. Avoid overly formal expressions like \"delve deeper\" — keep a relaxed but professional tone. Output ONLY the rewritten text with no explanations, quotes, or commentary."

# Read input from STDIN
INPUT=$(cat)

# Exit silently if input is empty
if [[ -z "${INPUT// /}" ]]; then
  exit 0
fi

# Ensure API key is set
if [[ -z "${OPENAI_API_KEY:-}" ]]; then
  echo "Error: OPENAI_API_KEY is not set" >&2
  exit 1
fi

# Build JSON payload using jq (handles escaping safely)
# gpt-5 models require reasoning parameter, gpt-4 models don't support it
if [[ "$MODEL" == gpt-5* ]]; then
  PAYLOAD=$(jq -n \
    --arg model "$MODEL" \
    --arg instructions "$SYSTEM_PROMPT" \
    --arg input "$INPUT" \
    '{
      model: $model,
      instructions: $instructions,
      input: $input,
      reasoning: { effort: "minimal" }
    }')
else
  PAYLOAD=$(jq -n \
    --arg model "$MODEL" \
    --arg instructions "$SYSTEM_PROMPT" \
    --arg input "$INPUT" \
    '{
      model: $model,
      instructions: $instructions,
      input: $input
    }')
fi

# Call OpenAI Responses API
RESPONSE=$(curl -s -X POST "https://api.openai.com/v1/responses" \
  -H "Authorization: Bearer ${OPENAI_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD")

# Extract the output text from the response
# Responses API returns message output with content array
OUTPUT=$(printf '%s' "$RESPONSE" | jq -r '.output[] | select(.type == "message") | .content[0].text // empty' 2>/dev/null)

# Handle API errors
if [[ -z "$OUTPUT" ]]; then
  ERROR=$(printf '%s' "$RESPONSE" | jq -r '.error.message // empty' 2>/dev/null)
  if [[ -n "$ERROR" ]]; then
    echo "API Error: $ERROR" >&2
  else
    echo "Error: Failed to extract response" >&2
  fi
  exit 1
fi

# Output only the formatted text (no trailing newline issues)
printf '%s' "$OUTPUT"
