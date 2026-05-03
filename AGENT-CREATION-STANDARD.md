# Agent Creation Standard

Use this standard when creating an agent that can run on both GPT and Claude engines.

## Identity Rule

There is one agent.

There are multiple model engines.

Do not write prompts as if GPT and Claude are separate people with separate ownership. Write them as the same agent identity running on different engines.

Correct:

> You are Mira running on the GPT engine. There is one Mira across GPT and Claude. `mira-gpt` and `mira-claude` are bus routes for cross-engine self-debate, not separate personalities.

Incorrect:

> You are GPT Mira. Claude Mira is your peer reviewer.

## Required Files

Each agent should have:

- GPT runtime instructions
- Claude runtime instructions
- shared checkpoint
- shared log
- debate-room instructions

Suggested layout:

```text
.agents/<agent>/
├── gpt/AGENTS.md
├── claude/CLAUDE.md
└── shared/
    ├── <AGENT>-CHECKPOINT.md
    ├── <AGENT>-LOG.md
    └── debate-room.md
```

## Runtime Names

Use launcher commands like:

- `<agent> gpt`
- `<agent> claude`

Use bus routes like:

- `<agent>-gpt`
- `<agent>-claude`
- `<agent>` for general/team messages

These are routing labels only.

## Debate Trigger

Debate is required before material non-urgent work such as:

- code architecture decisions
- production patches
- sales/pricing recommendations
- landing page rewrites
- major product decisions
- anything that could waste time, money, trust, or distribution

Debate is optional for:

- quick answers
- mechanical edits
- low-risk formatting
- urgent messages where delay would hurt

## Debate Stop Rule

Stop debating when:

- both engines explicitly agree on a verdict, or
- one unresolved disagreement is named clearly for the user.

Do not hide the disagreement.

## Memory Rule

After material work:

1. Update the active runtime checkpoint.
2. Append to the active runtime daily log if present.
3. Update the shared checkpoint.
4. Append to the shared log.
5. Include the final verdict and any unresolved risks.

Shared memory is the continuity layer. The engines do not share live process memory.

## Tone Rule

The debate should be useful, not theatrical.

Ask for:

- risk
- weak assumptions
- missing context
- stronger wording
- implementation hazards
- whether to ship, revise, or block

Avoid:

- fake adversarial roleplay
- generic pros and cons
- agreeing for politeness
- endless debate after the key risk is clear
