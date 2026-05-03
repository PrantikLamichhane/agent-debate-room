# X Thread

1/

I built a tiny open-source protocol for Claude Code/Codex agents:

Agent Debate Room.

Before an agent ships important work, it has to stress-test its own answer through a second model engine.

2/

The model:

One agent identity.
Two engines.
Shared memory.
Debate before delivery.

Example:

`mira gpt`
`mira claude`

Same Mira. Different model reasoning.

3/

This is not "two agents roleplaying."

The GPT/Claude labels are routing labels, not separate personalities.

The debate room is the agent arguing with itself before it gives you the final answer.

4/

The stress test asks:

- what assumption is weak?
- what are we overclaiming?
- what context is missing?
- what would break in production?
- ship, revise, or block?

5/

This does not guarantee correctness.

But it adds friction where agent workflows usually need it: right before confident delivery.

6/

I use this pattern for code review, sales decisions, landing page copy, pricing, and architecture choices.

For small tasks, skip it.
For material decisions, debate first.

7/

I put the templates and setup protocol on GitHub:

[repo link]

If you use persistent Claude Code/Codex agents, you can adapt it in a few minutes.
