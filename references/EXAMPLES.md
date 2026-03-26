# Decision Trace Reference — Worked Examples

Load this reference when you need to verify the format of a trace you're about to write.

---

## Example 1: Mode A — Thinking with Claude (Resolved Decision)

**Context:** A founder is working through a go-to-market question with Claude.

### Thread file: `threads/2026-03-26-plg-vs-sales-led.json`

```json
{
  "id": "dt-2026-03-26-f7a1",
  "topic": "PLG vs. sales-led go-to-market for enterprise tier",
  "status": "resolved",
  "category": "market_strategy",
  "session_id": "sess-2026-03-26-gtm-strategy",
  "opened_at": "2026-03-26T10:15:00Z",
  "resolved_at": "2026-03-26T10:42:00Z",
  "resolution_summary": "Sales-led for enterprise ($50K+ ACV), PLG stays for mid-market. Hire first AE by April 15 for warm pipeline. Second AE contingent on demo environment readiness.",
  "revisit_trigger": "If enterprise pipeline is below $200K by end of Q2, revisit whether to pause AE hires and double down on PLG.",
  "outcome": null,
  "outcome_assessed_at": null,
  "nodes": [
    {
      "id": "dn-1",
      "node_type": "intent",
      "author_role": "founder",
      "author_name": "Priya",
      "content": "I want to move enterprise to a sales-led motion. PLG isn't converting above $50K ACV — we've had 3 deals stall in the last 6 weeks because there's no human in the loop. Thinking about hiring 2 AEs this quarter.",
      "context": {
        "source": "conversation",
        "session": "GTM strategy discussion",
        "related_topics": []
      },
      "sequence_order": 1,
      "created_at": "2026-03-26T10:15:00Z"
    },
    {
      "id": "dn-2",
      "node_type": "response",
      "author_role": "advisor",
      "author_name": "Claude",
      "content": "The conversion data supports moving enterprise to sales-led, but the timing risk is real. You don't have sales infrastructure yet — no demo environment, no handoff process from PLG trial to AE. Hiring AEs before that's built means 6-8 weeks of idle capacity. Consider staging: one AE now for the warm pipeline, build infrastructure in parallel, second AE when it's ready.",
      "context": {
        "source": "conversation",
        "session": "GTM strategy discussion",
        "related_topics": ["onboarding-infrastructure"]
      },
      "sequence_order": 2,
      "created_at": "2026-03-26T10:22:00Z"
    },
    {
      "id": "dn-3",
      "node_type": "resolution",
      "author_role": "founder",
      "author_name": "Priya",
      "content": "Good call on the staging. Decision: sales-led for enterprise ($50K+ ACV), PLG stays default for everything under $15K. Hire first AE by April 15 to work the warm pipeline. Second AE hire contingent on demo environment being ready — I'll have Marcus build that by May 30.",
      "context": {
        "source": "conversation",
        "session": "GTM strategy discussion",
        "related_topics": ["hiring-plan-q2", "enterprise-pricing"]
      },
      "sequence_order": 3,
      "created_at": "2026-03-26T10:42:00Z"
    }
  ],
  "created_at": "2026-03-26T10:15:00Z",
  "updated_at": "2026-03-26T10:42:00Z"
}
```

**What makes this a good trace:**
- Captures Claude's pushback as a proper `response` node — not just the user's monologue
- Resolution is specific and actionable (names, dates, dollar thresholds)
- Has a revisit trigger — you know when to reopen this
- Three months from now, the user can ask "why did I hire an AE?" and get the full reasoning

---

## Example 2: Mode A — Thinking with Claude (Deferred Decision)

### Thread file: `threads/2026-03-26-international-expansion.json`

```json
{
  "id": "dt-2026-03-26-b3c4",
  "topic": "International expansion — APAC vs. EMEA first",
  "status": "deferred",
  "category": "market_strategy",
  "session_id": "sess-2026-03-26-gtm-strategy",
  "opened_at": "2026-03-26T11:05:00Z",
  "resolved_at": null,
  "resolution_summary": null,
  "revisit_trigger": "After Q2 numbers are in (July board meeting). Need US ARR at $2M+ before international makes sense.",
  "outcome": null,
  "outcome_assessed_at": null,
  "nodes": [
    {
      "id": "dn-1",
      "node_type": "intent",
      "author_role": "founder",
      "author_name": "Priya",
      "content": "We've had inbound interest from 3 APAC companies. Should I start thinking about international?",
      "context": {
        "source": "conversation",
        "session": "GTM strategy discussion",
        "related_topics": []
      },
      "sequence_order": 1,
      "created_at": "2026-03-26T11:05:00Z"
    },
    {
      "id": "dn-2",
      "node_type": "response",
      "author_role": "advisor",
      "author_name": "Claude",
      "content": "With US ARR at $800K, international adds support complexity, timezone coverage, and potentially localization before you have a repeatable domestic playbook. Recommend deferring until US hits $2M.",
      "context": {
        "source": "conversation",
        "session": "GTM strategy discussion",
        "related_topics": ["us-revenue-target"]
      },
      "sequence_order": 2,
      "created_at": "2026-03-26T11:08:00Z"
    }
  ],
  "created_at": "2026-03-26T11:05:00Z",
  "updated_at": "2026-03-26T11:08:00Z"
}
```

**What makes this a good trace:**
- Captures the deferral *with a specific revisit condition*, not just "later"
- Claude's reasoning is preserved — when this gets reopened in July, the context is there

---

## Example 3: Mode B — Extracting from a Pasted Email Chain

**Context:** User pastes an email thread between themselves (CEO) and their VP Engineering.

When the user pastes text like:

> **From: Priya** — "James, I've been thinking about the migration. I want to move to Postgres by end of Q2. The current MySQL setup is blocking our analytics pipeline."
>
> **From: James** — "Q2 is tight given the API rewrite. We could do a partial migration — move the analytics tables first and leave transactional on MySQL until Q3. Less risk."
>
> **From: Priya** — "That works. Let's do the partial migration. Analytics tables to Postgres by June 30. Full migration deferred to Q3."

The skill should extract:

```json
{
  "id": "dt-2026-03-26-c5d6",
  "topic": "Database migration — MySQL to Postgres timeline",
  "status": "resolved",
  "category": "product_scope",
  "nodes": [
    {
      "id": "dn-1",
      "node_type": "intent",
      "author_role": "ceo",
      "author_name": "Priya",
      "content": "Move to Postgres by end of Q2. Current MySQL setup is blocking analytics pipeline.",
      "sequence_order": 1
    },
    {
      "id": "dn-2",
      "node_type": "response",
      "author_role": "vp_eng",
      "author_name": "James",
      "content": "Q2 is tight with the API rewrite. Proposed partial migration: analytics tables first, transactional stays on MySQL until Q3.",
      "sequence_order": 2
    },
    {
      "id": "dn-3",
      "node_type": "resolution",
      "author_role": "ceo",
      "author_name": "Priya",
      "content": "Agreed to partial migration. Analytics tables to Postgres by June 30. Full migration deferred to Q3.",
      "sequence_order": 3
    }
  ],
  "resolution_summary": "Partial migration: analytics tables to Postgres by June 30. Full migration deferred to Q3.",
  "revisit_trigger": null
}
```

After extracting, prompt the user: "Want to add a revisit trigger for the Q3 full migration?"

---

## Example 4: Contradiction Detection

If a user in a later session says: "Let's explore launching in Singapore next month" — and Example 2's trace exists — the skill should surface:

> **Possible contradiction detected.** On 2026-03-26, you deferred "International expansion — APAC vs. EMEA first" with the condition: *After Q2 numbers are in. Need US ARR at $2M+ before international makes sense.*
>
> Do you want to:
> 1. Reopen the thread and revise the decision?
> 2. Override the deferral with new reasoning?
> 3. Keep the deferral in place?

This is the core value of persistent decision traces — decisions don't just disappear.

---

## DECISIONS.md Rendering

After Examples 1 and 2, the DECISIONS.md should read:

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
| 2026-03-26 | PLG vs. sales-led go-to-market for enterprise tier | market_strategy | Sales-led for enterprise ($50K+), PLG for mid-market. Hire first AE by April 15. | Priya (Founder), Claude (Advisor) |

## Deferred Decisions

| Date | Decision | Category | Revisit Trigger | Participants |
|------|----------|----------|-----------------|--------------|
| 2026-03-26 | International expansion — APAC vs. EMEA first | market_strategy | After Q2 numbers — need US ARR at $2M+ | Priya (Founder), Claude (Advisor) |

---
*[Alignmink](https://alignmink.com) — the strategy operating system for scaling companies.*
```
