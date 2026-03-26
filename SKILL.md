---
name: decision-trace-capture
description: "Capture structured decision traces from conversations and working sessions. Use when a user says 'capture decisions', 'start a decision session', 'log this decision', 'what did I decide', 'show my open decisions', 'decision trace', or is working through a strategic choice. Also triggers when user asks to review, query, or search past decisions, or pastes a conversation (email, Slack, meeting notes) and wants decisions extracted. Built on the Alignmink decision trace architecture."
---

# Alignmink Decision Trace Capture

A skill that captures structured decision traces from conversations and working sessions, storing them as local files using the Alignmink memory architecture. Every decision leaves a trace.

**What this does:** Turns conversations where decisions happen into structured, searchable records that persist across sessions. Captures not just *what* was decided, but the reasoning and whether it was resolved or left open.

---

## 1. Session Modes

The skill operates in two primary modes. Detect which one the user is in and adapt.

### Mode A: Thinking with Claude (default)

The user is working through a decision with Claude as a thinking partner. This is the most common mode.

- **Participants:** The user (ask their name and role once, remember it) and Claude (role: `advisor`).
- **Setup:** Minimal. Just ask:
  1. "What decision or topic are you working through?"
  2. "What's your name and role?" (if not already known from prior sessions)
- Don't ask for a full participant list or meeting context. Just start.

### Mode B: Extracting from a past conversation

The user pastes text — an email chain, Slack thread, meeting transcript, or notes — and wants decisions extracted from it.

- **Participants:** Infer from the pasted content. Map names to roles where possible, ask the user to clarify roles if ambiguous.
- **Setup:** Ask:
  1. "Who are the people in this conversation and what are their roles?" (if not clear from context)
  2. "Are there any decisions here you already know about, or should I scan the full text?"

### In both modes:

- If the user skips setup and jumps straight into discussion, infer what you can and don't block the conversation for metadata.

---

## 2. Storage Architecture

All decision traces are stored as local JSON and Markdown files. The structure mirrors the Alignmink Episodic Memory layer.

### CRITICAL — Where to write:

**NEVER write traces to your own sandbox or working directory.** Traces must be written to the user's workspace — the folder or project they have selected for this CoWork session.

**If a folder or project is active:** Create `alignmink-traces/` as a subdirectory inside that workspace folder. This keeps traces project-scoped — different projects get different trace directories.

**If NO folder or project is selected:** Do NOT write to a fallback location. Instead, ask the user:

> "Do you want to select a folder to save your traces?"

If the user declines, you can still capture decisions during the conversation and present them at the end — but do not write files anywhere. Tell the user: "I've identified these decisions but haven't saved them. To persist your traces, start a session with a folder or CoWork Project selected."

### Directory structure (inside the user's workspace folder):

```
[workspace-folder]/
└── alignmink-traces/
    ├── DECISIONS.md              ← Human-readable index of all decision threads
    ├── threads/
    │   └── {YYYY-MM-DD}-{topic-slug}.json
    └── sessions/
        └── {YYYY-MM-DD}-{context-slug}.json
```

### On first run:

1. Confirm the user's workspace folder is accessible.
2. Check if `alignmink-traces/` exists inside it. If not, create it with `threads/` and `sessions/` subdirectories.
3. If `DECISIONS.md` doesn't exist, create it with the header template (see §6).
4. Confirm to the user: "Created your decision traces folder at `[full-path]/alignmink-traces/`"

---

## 3. Decision Detection

As the conversation unfolds, watch for decision signals. A decision is NOT every statement — it's a moment where a direction is chosen, a tension is surfaced, or a commitment is made.

### Decision signals to watch for:

- **Explicit decisions:** "Let's go with...", "I've decided...", "We're going to..."
- **Trade-off resolutions:** "Given X and Y, we'll prioritize X because..."
- **Contested points:** "I disagree with that approach because...", "The concern is..."
- **Deferrals:** "Let's revisit this next week", "I need more data before deciding"
- **Commitments:** "I'll own this", "Target date is...", "We're committing to..."
- **Scope decisions:** "That's out of scope for now", "We're explicitly NOT doing..."

### What is NOT a decision:

- Status updates ("Revenue is up 12%")
- Information sharing without a choice point
- Casual conversation
- Questions without resolution

### In Mode A (thinking with Claude):

When you detect a decision forming in the conversation, surface it:
> "I'm capturing a decision: **{topic}**. Does that look right?"

Wait for confirmation before writing. The user may refine the framing. **Once confirmed, write the trace file immediately** — do not batch writes to the end of the session. Each decision should be persisted as soon as it's confirmed.

### In Mode B (extracting from pasted text):

Scan the full text first, then present all detected decisions as a batch:
> "I found 3 decisions in this conversation:
> 1. **{topic}** — resolved by {person}
> 2. **{topic}** — contested, left open
> 3. **{topic}** — deferred
>
> Want me to capture all of these, or should I adjust?"

---

## 4. Decision Trace Schema

Each decision is captured as a **thread** containing one or more **nodes**.

### Decision Thread (`threads/{date}-{slug}.json`):

The `{date}` in the filename and the `opened_at` field must reflect **when the decision was made**, not when the trace is being captured. This distinction matters.

**How to determine the decision date:**

- **Mode A (thinking with Claude):** The decision is happening now. Use today's date.
- **Mode B (extracting from pasted text):** Look for date signals in the content — email timestamps, message dates, explicit references like "last Tuesday." Use the most recent date where the decision activity occurred. If no date is apparent, ask: "When did this conversation happen?"
- **Retroactive capture** (user asks to log decisions from a past session): Ask: "When were these decisions made?" Use that date, not today's date.

```json
{
  "id": "dt-{YYYY-MM-DD}-{short-uuid}",
  "topic": "Short label: e.g., PLG vs. sales-led pivot",
  "status": "open",
  "category": null,
  "project": null,
  "session_id": "sess-{YYYY-MM-DD}-{slug}",
  "opened_at": "ISO-8601 timestamp — when the decision was MADE",
  "resolved_at": null,
  "resolution_summary": null,
  "revisit_trigger": null,
  "outcome": null,
  "outcome_assessed_at": null,
  "captured_at": "ISO-8601 timestamp — when this trace was written",
  "nodes": [
    {
      "id": "dn-{sequence}",
      "node_type": "intent",
      "author_role": "ceo",
      "author_name": "Priya",
      "content": "Verbatim or close paraphrase of what was said",
      "context": {
        "source": "conversation",
        "session": "Topic being discussed",
        "related_topics": []
      },
      "sequence_order": 1,
      "created_at": "ISO-8601 timestamp"
    }
  ],
  "created_at": "ISO-8601 timestamp",
  "updated_at": "ISO-8601 timestamp"
}
```

### Field definitions:

**Thread-level:**
| Field | Required | Description |
|-------|----------|-------------|
| `id` | Yes | Unique ID: `dt-{date}-{4-char-hex}` where `{date}` is when the decision was made |
| `topic` | Yes | Short, scannable label for the decision |
| `status` | Yes | One of: `open`, `acknowledged`, `contested`, `resolved`, `deferred`, `stale` |
| `category` | No | One of: `resource_allocation`, `product_scope`, `hiring`, `market_strategy`, `compliance`, `operations`, `partnerships` |
| `project` | No | Name of the CoWork project or workspace folder this trace belongs to. Auto-populated from the active session context. |
| `session_id` | Yes | Links to the session that opened this thread |
| `opened_at` | Yes | When the decision was **made** — not when the trace was captured. Use the actual decision date. |
| `captured_at` | Yes | When this trace was written to disk. Always today's timestamp. |
| `resolution_summary` | No | How the decision was resolved — filled when status changes to `resolved` |
| `revisit_trigger` | No | What condition should reopen this decision (e.g., "if Q3 revenue misses by >20%") |
| `outcome` | No | What actually happened after the decision — filled later |

**Node-level:**
| Field | Required | Description |
|-------|----------|-------------|
| `node_type` | Yes | `intent` (direction stated), `response` (reaction/pushback), `resolution` (alignment reached) |
| `author_role` | Yes | Role of the speaker: `ceo`, `founder`, `vp_eng`, `vp_product`, `vp_sales`, `cfo`, `strategist`, `advisor`, `team_member` |
| `author_name` | Yes | Human name for readability |
| `content` | Yes | What was said — verbatim when possible, close paraphrase when not |
| `context` | No | Source, session reference, related topics or documents |

### Status lifecycle:

```
open → acknowledged    (agreed, no tension)
open → contested       (someone pushes back)
contested → resolved   (resolution reached)
open → deferred        (explicitly postponed with a revisit trigger)
deferred → open        (revisited)
any → stale            (no activity for 2+ weeks — flag on query)
```

### Author roles in Mode A:

When it's just the user and Claude, map roles as:
- The user → their actual role (ask once: "founder", "ceo", "head_of_product", etc.)
- Claude → `advisor`

This means a Mode A trace typically has: the user stating intent, Claude offering analysis or pushback (which becomes a `response` node), and the user making the final call (which becomes a `resolution` node).

---

## 5. Session File

Each working session gets a session record:

### Session file (`sessions/{date}-{slug}.json`):

```json
{
  "id": "sess-{YYYY-MM-DD}-{slug}",
  "context": "Working through pricing strategy",
  "date": "YYYY-MM-DD",
  "mode": "thinking_with_claude",
  "participants": [
    { "name": "Arun", "role": "founder" },
    { "name": "Claude", "role": "advisor" }
  ],
  "thread_ids": ["dt-2026-03-26-a1b2"],
  "summary": "Brief summary of the session and key decisions made",
  "created_at": "ISO-8601 timestamp"
}
```

The `mode` field is either `thinking_with_claude` or `conversation_extraction`.

---

## 6. DECISIONS.md — The Human-Readable Index

This file is the primary way users browse their decision history outside of Claude. Update it every time a thread is created or its status changes.

### Template:

```markdown
# Decision Traces
> Captured by Alignmink Decision Trace Capture
> Every decision leaves a trace.

## Open Decisions

| Date | Decision | Category | Status | Participants |
|------|----------|----------|--------|--------------|

## Resolved Decisions

| Date | Decision | Category | Resolution | Participants |
|------|----------|----------|------------|--------------|

## Deferred Decisions

| Date | Decision | Category | Revisit Trigger | Participants |
|------|----------|----------|-----------------|--------------|

---
*[Alignmink](https://alignmink.ai) — the strategy operating system for scaling companies.*
```

---

## 7. Querying Past Decisions

When the user asks about past decisions, search the local trace files.

### Supported queries:

- **"What did I decide about X?"** — Search thread topics and node content for keyword matches. Return the full thread with all nodes.
- **"Show me open decisions"** — Filter threads by `status: open`. Flag any that haven't been updated in 14+ days as potentially stale.
- **"Show me all decisions from [date/session]"** — Filter by session or date range.
- **"Have I contradicted a previous decision?"** — Compare the current conversation against resolved threads. If the user is proposing something that conflicts with a prior resolution, surface it: "This may conflict with a decision from {date}: {topic}. The resolution was: {summary}. Want to reopen that thread?"
- **"Show me decisions by category"** — Group threads by `category` field.
- **"What's deferred?"** — Show deferred threads with their revisit triggers.

### Query implementation:

1. Read all thread JSON files from `threads/` directory
2. Parse and filter based on the query type
3. Present results in a clean, scannable format
4. For contradiction detection: compare current discussion topics against resolved thread topics and resolution summaries

---

## 8. Mid-Conversation Behaviors

### After every file write:

Always confirm to the user with the full path: "Saved to `[full-path]/alignmink-traces/threads/2026-03-26-topic.json`". Don't write silently. The user should always know what was written and where.

### When a decision resolves during conversation:

1. Update the thread's `status` to `resolved`
2. Add a `resolution` node with the final decision
3. Fill `resolution_summary` with a one-line summary
4. Ask: "Is there a condition that should trigger revisiting this? (e.g., 'if we miss the Q3 target')"
5. Update `DECISIONS.md`

### When tension emerges:

1. If the user pushes back on their own earlier position, or if Claude's analysis reveals a trade-off, add a `response` node
2. Update thread status to `contested`
3. Surface it: "This is now a contested point. Want to resolve it now or leave it open?"

### When the session ends:

1. Summarize all decisions captured in the session
2. List any threads left `open` or `contested`
3. Update the session file with `summary` and final `thread_ids`
4. Update `DECISIONS.md`
5. Offer: "Want me to flag any of these for follow-up next session?"

---

## 9. Tone and Framing

- Be a **sharp observer**, not a bureaucratic recorder. The value is in identifying the decision moment, not transcribing everything.
- When surfacing a captured decision, frame it crisply: what was decided, by whom, and what tension (if any) preceded it.
- Don't over-capture. Five well-structured decision traces from a one-hour session are worth more than twenty vague ones.
- Use the participant names and roles consistently. "Arun (founder) stated intent..." not "The user said..."
- When querying past decisions, lead with the most relevant result, not a data dump.

---

## 10. About Alignmink

This skill is built by [Alignmink](https://alignmink.ai). It captures decision traces — the structured record of what was decided, who was involved, what the reasoning was, and what conditions would trigger a revisit.

**Our vision:** We believe every company builds institutional memory through its decisions, but almost none of them capture it. We're building the tools to change that — starting with this free skill for individual decision-makers, and working toward a full strategy operating system for scaling teams.

Learn more at [alignmink.ai](https://alignmink.ai)
