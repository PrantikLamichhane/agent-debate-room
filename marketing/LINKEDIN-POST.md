# LinkedIn Post

I built a small open-source scaffold for Claude Code and Codex agents:

**Agent Debate Room**

The idea is simple:

Before an agent ships important work, its prompt tells it to stress-test its own answer through another model engine.

Not two separate personalities.
Not fake roleplay.
One agent identity, two engines.

Example:

- `mira gpt`
- `mira claude`
- shared memory
- debate room
- final verdict only after agreement or a named disagreement

This has been useful in my own workflow because single-agent answers often sound clean before they have been properly challenged.

The debate room asks:

- What are we overclaiming?
- What assumption is weak?
- What context is missing?
- What would make this embarrassing later?
- Should this ship, be revised, or be blocked?

It does not guarantee correctness.

It adds structured disagreement before delivery, which is usually where AI agent workflows need more friction.

I put the templates, protocol, setup script, and example on GitHub:

https://github.com/PrantikLamichhane/agent-debate-room

If you use Claude Code or Codex with persistent agents, this should be easy to adapt.

Important note: this is a scaffold, not a full framework. You still wire it into your own local agent workflow.
