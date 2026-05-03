#!/usr/bin/env bash
set -euo pipefail

agent_name="${1:-}"
agent_role="${2:-}"

if [[ -z "$agent_name" || -z "$agent_role" ]]; then
  echo "Usage: ./scripts/init-agent-debate.sh <agent-name> <agent-role>"
  echo "Example: ./scripts/init-agent-debate.sh mira \"sales operator\""
  exit 1
fi

slug="$(echo "$agent_name" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//')"
upper="$(echo "$slug" | tr '[:lower:]-' '[:upper:]_')"
title="$(echo "$agent_name" | awk '{for (i=1; i<=NF; i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1')"

if [[ -z "$slug" ]]; then
  echo "Agent name must contain at least one letter or number."
  exit 1
fi

escape_sed() {
  printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'
}

title_escaped="$(escape_sed "$title")"
role_escaped="$(escape_sed "$agent_role")"
slug_escaped="$(escape_sed "$slug")"
upper_escaped="$(escape_sed "$upper")"

root=".agents/$slug"
mkdir -p "$root/gpt" "$root/claude" "$root/shared"

render() {
  local src="$1"
  local dest="$2"
  sed \
    -e "s/{{AGENT_NAME}}/$title_escaped/g" \
    -e "s/{{AGENT_ROLE}}/$role_escaped/g" \
    -e "s/{{AGENT_SLUG}}/$slug_escaped/g" \
    -e "s/{{AGENT_UPPER}}/$upper_escaped/g" \
    "$src" > "$dest"
}

template_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/templates"

render "$template_dir/AGENTS.md" "$root/gpt/AGENTS.md"
render "$template_dir/CLAUDE.md" "$root/claude/CLAUDE.md"
render "$template_dir/SHARED-CHECKPOINT.md" "$root/shared/$upper-CHECKPOINT.md"
render "$template_dir/SHARED-LOG.md" "$root/shared/$upper-LOG.md"
cp "$template_dir/DEBATE-ROOM.md" "$root/shared/debate-room.md"

echo "Created $root"
echo
echo "Next:"
echo "1. Wire '$slug gpt' to open $root/gpt/AGENTS.md"
echo "2. Wire '$slug claude' to open $root/claude/CLAUDE.md"
echo "3. Use $slug-gpt and $slug-claude as debate routes"
