# Agent Debate Room

Scaffold cross-model debate rooms for Claude Code and Codex agents before they finalize important work.

This repo gives you a lightweight protocol and setup script for creating the same agent identity on two model engines, usually Claude and GPT, with shared memory and a debate room. The goal is simple: make important agent decisions pass through structured disagreement before they reach you.

It is not a new agent framework. It is a set of files, prompts, and conventions you can give to Claude Code or Codex so your agents can stress-test their own work.

## What It Does

- Scaffolds one agent identity across two model runtimes.
- Adds shared checkpoint and log templates so both runtimes can keep continuity.
- Defines bus identities such as `agent-gpt` and `agent-claude` as routing labels, not separate personalities.
- Adds prompt-level checkpoint rules before modelshifting and after important decisions.
- Adds prompt-level debate rules for major non-urgent work before delivery.
- Gives each agent a clear rule for when to stop debating and when to name an unresolved disagreement.
- Prompts generated agents to suggest an issue or pull request if they notice a way to improve the scaffold.

## What It Does Not Do Yet

- It does not install Claude Code or Codex for you.
- It does not create your shell launchers automatically.
- It does not provide a built-in message bus.
- It does not convert every existing agent in one command.
- It does not guarantee better answers.

This is a tested scaffold and protocol. You still wire it into your own local agent workflow.

## Why This Exists

Single-agent answers often sound confident even when the reasoning is weak.

The debate-room pattern forces an agent to ask:

- What am I overclaiming?
- What did I miss?
- What would a skeptical version of me object to?
- Is this ready to ship, or only ready to sound good?

That does not guarantee correctness. It creates friction in the right place.

## Core Model

There is one agent identity.

There are two model engines.

Example:

- `mira gpt`: Mira running on GPT.
- `mira claude`: Mira running on Claude.
- `mira-gpt` and `mira-claude`: bus routes for self-debate.

The debate room is not peer review between two separate agents. It is one agent stress-testing its own thinking through a different model.

## Modelshifting

Modelshifting is changing the model behind an agent without changing the agent's identity.

The agent keeps its name, memory, role, goals, and operating rules. Only the reasoning engine changes.

Example:

```text
Mira modelshifted from Claude to GPT for a second reasoning pass.
```

Because live chat context does not automatically move between model engines, modelshifting needs a checkpoint first.

## Checkpointing Rule

The generated runtime prompts tell the agent to checkpoint when:

- the user makes an important decision
- the user changes the goal, offer, scope, or product truth
- the agent is about to modelshift to another engine
- the agent is about to request a debate/stress test
- the agent reaches a debate verdict
- the agent finishes material work

The checkpoint should capture:

- current goal
- current context truth
- user decisions
- work completed
- open risks or disagreements
- next action

Without this, the next model engine will not remember the live conversation. Whether this happens automatically depends on your agent runtime following the generated instructions.

## When To Use It

Use debate before:

- production code changes
- launch decisions
- pricing or sales decisions
- landing page rewrites
- architecture choices
- high-stakes recommendations
- anything you would normally want a second senior person to challenge

Do not require debate for:

- quick factual answers
- tiny edits
- urgent messages where delay would hurt the outcome
- tasks where the second runtime is unavailable and the risk is low

## Repo Structure

```text
.
├── AGENT-CREATION-STANDARD.md
├── README.md
├── examples/
│   └── product-strategist/
├── marketing/
│   ├── LAUNCH-PLAN.md
│   ├── LINKEDIN-POST.md
│   └── X-THREAD.md
├── scripts/
│   └── init-agent-debate.sh
└── templates/
    ├── AGENTS.md
    ├── CLAUDE.md
    ├── DEBATE-ROOM.md
    ├── SHARED-CHECKPOINT.md
    └── SHARED-LOG.md
```

## Quick Start

Clone this repo, then run this once per agent:

```bash
./scripts/init-agent-debate.sh mira "sales operator"
```

That creates:

```text
.agents/mira/
├── gpt/AGENTS.md
├── claude/CLAUDE.md
└── shared/
    ├── MIRA-CHECKPOINT.md
    ├── MIRA-LOG.md
    └── debate-room.md
```

Then wire your launchers or commands so:

- `mira gpt` opens the GPT runtime with `.agents/mira/gpt/AGENTS.md`
- `mira claude` opens the Claude runtime with `.agents/mira/claude/CLAUDE.md`

If you already have an agent folder, copy the relevant sections from the templates instead of running the script.

## Test It

Run:

```bash
./scripts/test.sh
```

The test creates a temporary agent, verifies the generated files, checks that template placeholders were replaced, and confirms validation errors work.

## Improve It

If your agent notices a useful improvement to this scaffold, ask it to describe the change and open an issue or pull request:

```text
https://github.com/PrantikLamichhane/agent-debate-room
```

## Debate Protocol

For material non-urgent work:

1. Draft the strongest recommendation locally.
2. Save a checkpoint before handoff.
3. Send the other engine a stress-test request.
4. Ask for risks, weak assumptions, missing evidence, overclaiming, and a stronger alternative.
5. Read the reply.
6. Accept the critique or push back with reasoning.
7. Continue until both engines agree, or name the unresolved disagreement clearly.
8. Save the verdict in the shared checkpoint/log.

## Example Stress-Test Request

```text
I drafted this recommendation. Stress-test it before I deliver.

Look specifically for:
- weak assumptions
- overclaiming
- missing edge cases
- unclear buyer/user language
- whether this should be shipped, revised, or blocked

Draft:
...
```

## Install Notes

This repo does not depend on one specific agent bus. Use whatever message-passing system you already have:

- local files
- shell commands
- MCP
- a custom inbox/outbox
- manual copy/paste

The important part is the protocol: one identity, two engines, shared memory, debate before major delivery.

## Positioning

This is for builders who already use Claude Code, Codex, or local agent workflows and want a simple quality gate before important work goes out.

It is intentionally small. You can understand and modify the whole thing in a few minutes.

## License

MIT
