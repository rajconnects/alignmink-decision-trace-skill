# Alignmink Decision Trace Capture

**Every decision leaves a trace. This skill makes sure of it.**

A free skill for Claude Cowork that captures structured decision traces from your conversations and working sessions — and stores them locally so you can search, query, and learn from your decision history.

---

## The Problem

You make dozens of strategic decisions every month. In conversations with advisors. While thinking through trade-offs. In email chains and Slack threads. Almost none of them are captured with the context that produced them — what the alternatives were, why the trade-off was made, what condition would trigger a revisit.

Six months later, you're relitigating the same decision because you don't remember *why* you chose this path.

## What This Skill Does

When you're working in Claude Cowork — whether you're thinking through a decision with Claude, or processing a conversation you had elsewhere — this skill:

1. **Detects decisions** as they emerge from the conversation
2. **Captures the full trace** — not just the outcome, but the reasoning, the alternatives considered, and the resolution
3. **Stores locally** as structured JSON files on your machine
4. **Maintains a readable index** (`DECISIONS.md`) you can browse anytime
5. **Enables querying** — ask Claude "what did I decide about pricing?" and get the full trace back, across sessions
6. **Catches contradictions** — if you're about to make a decision that conflicts with a previous one, the skill surfaces it

### Two Modes

**Thinking with Claude** — You're working through a decision in conversation. Claude captures the trace as you go: your reasoning, Claude's analysis, your final call.

**Extracting from a past conversation** — You paste an email chain, Slack thread, or meeting notes. Claude scans the text, identifies the decisions, and structures them into traces.

### The Trace Structure

Every decision is a **thread** containing **nodes**:

```
Thread: "Hire a Head of Sales vs. promote internally"
├── Node 1: Intent (Founder) — "I want to hire externally..."
├── Node 2: Response (Advisor) — "Consider the ramp time..."
└── Node 3: Resolution (Founder) — "Promote Sarah, hire externally for Q3..."
```

This captures the **reasoning arc** — not just the final answer.

---

## Installation

### Prerequisites
- Claude Desktop with Cowork enabled
- Pro, Max, Team, or Enterprise plan

### Steps

1. Download the `decision-trace-capture/` folder
2. Copy it to your Claude skills directory:
   - **Personal skill** (all projects): `~/.claude/skills/decision-trace-capture/`
   - **Project skill** (one project): `.claude/skills/decision-trace-capture/`
3. Start a Cowork session and say: **"Start a decision capture session"**
4. Claude will initialize the storage directory and guide you through setup

---

## Usage

### Starting a session

```
Start a decision capture session. I'm working through our pricing strategy.
```

Claude will ask your name and role (once), then you're off.

### Extracting from a past conversation

```
Here's an email chain between me and my VP Eng about the migration timeline.
Can you extract the decisions from this?

[paste email text]
```

### Querying past decisions

```
What did we decide about pricing?
Show me all open decisions.
What decisions are deferred?
Have I contradicted any previous decisions?
```

### Reviewing outside Claude

Open `~/alignmink-traces/DECISIONS.md` in any Markdown viewer for a clean table of all your decisions, organized by status.

---

## Storage

All data stays on your machine. Nothing is sent anywhere.

```
~/alignmink-traces/
├── DECISIONS.md              ← Human-readable index
├── threads/
│   └── 2026-03-26-pricing-strategy.json
└── sessions/
    └── 2026-03-26-pricing-discussion.json
```

Trace files are plain JSON — portable, version-controllable, and yours.

---

## About Alignmink

This skill is built by [Alignmink](https://alignmink.com).

We believe every company builds institutional memory through its decisions, but almost none of them capture it. We're building the tools to change that — starting with this free skill for individual decision-makers, and working toward a full strategy operating system for scaling teams.

**Learn more:** [alignmink.com](https://alignmink.com)

---

*Built on the Alignmink decision trace architecture. Every decision leaves a trace.*
