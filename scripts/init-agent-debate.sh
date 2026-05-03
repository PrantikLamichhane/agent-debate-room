#!/usr/bin/env bash
set -euo pipefail

agent_name="${1:-}"
agent_role="${2:-}"

if [[ -z "$agent_name" || -z "$agent_role" ]]; then
  echo "Usage: ./scripts/init-agent-debate.sh <agent-name> <agent-role>"
  echo "Example: ./scripts/init-agent-debate.sh mira \"sales operator\""
  exit 1
fi

slug="$(echo "$agent_name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
upper="$(echo "$slug" | tr '[:lower:]-' '[:upper:]_')"
title="$(echo "$agent_name" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')"

root=".agents/$slug"
mkdir -p "$root/gpt" "$root/claude" "$root/shared"

render() {
  local src="$1"
  local dest="$2"
  sed \
    -e "s/{{AGENT_NAME}}/$title/g" \
    -e "s/{{AGENT_ROLE}}/$agent_role/g" \
    -e "s/{{AGENT_SLUG}}/$slug/g" \
    -e "s/{{AGENT_UPPER}}/$upper/g" \
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
