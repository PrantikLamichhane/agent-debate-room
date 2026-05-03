#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_dir="$(mktemp -d)"

cleanup() {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT

cd "$tmp_dir"

"$repo_root/scripts/init-agent-debate.sh" "Sam Agent" "sales/operator & QA"

expected_files=(
  ".agents/sam-agent/gpt/AGENTS.md"
  ".agents/sam-agent/claude/CLAUDE.md"
  ".agents/sam-agent/shared/SAM_AGENT-CHECKPOINT.md"
  ".agents/sam-agent/shared/SAM_AGENT-LOG.md"
  ".agents/sam-agent/shared/debate-room.md"
)

for file in "${expected_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Missing expected file: $file"
    exit 1
  fi
done

if grep -R '{{AGENT_' .agents >/dev/null; then
  echo "Unrendered template placeholder found."
  exit 1
fi

grep -q "You are Sam Agent, sales/operator & QA, running on the GPT engine." .agents/sam-agent/gpt/AGENTS.md
grep -q "Sam Agent running on Claude" .agents/sam-agent/shared/SAM_AGENT-CHECKPOINT.md
grep -q "Automatic Checkpointing" .agents/sam-agent/gpt/AGENTS.md
grep -q "Pre-Handoff Checkpoint" .agents/sam-agent/shared/debate-room.md
grep -q "opening an issue or pull request" .agents/sam-agent/gpt/AGENTS.md
grep -q "https://github.com/PrantikLamichhane/agent-debate-room" .agents/sam-agent/claude/CLAUDE.md

if "$repo_root/scripts/init-agent-debate.sh" >/tmp/agent-debate-room-test-missing-args.log 2>&1; then
  echo "Missing-argument validation failed."
  exit 1
fi

if "$repo_root/scripts/init-agent-debate.sh" "!!!" "test role" >/tmp/agent-debate-room-test-invalid-name.log 2>&1; then
  echo "Invalid-name validation failed."
  exit 1
fi

echo "All tests passed."
