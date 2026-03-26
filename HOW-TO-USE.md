# How to Use Decision Trace Capture

A practical guide to capturing decisions that actually stick.

---

## Your First 5 Minutes

Let's get you from zero to your first captured decision. No setup talk, just do this:

**Step 1.** Open Claude Cowork and say:

```
Start a decision capture session. I'm [your name], [your role].
I'm working through [whatever's on your mind].
```

That's it. No forms. No config. Just tell Claude what you're thinking about.

**Step 2.** Talk through your decision the way you normally would. Think out loud. Weigh the trade-offs. Change your mind. Claude is listening for the moment a direction emerges.

**Step 3.** When Claude spots a decision, it'll check with you:

> "I'm capturing a decision: **Whether to raise prices before or after the product launch.** Does that look right?"

Say yes, tweak the framing, or wave it off. Your call.

**Step 4.** When you're done, Claude writes the trace to your local files and updates your decision index. You now have a structured record of what you decided, why, and what would make you revisit it.

That's the whole thing. Everything below is just more ways to use it.

---

## Scenarios

### "I just talked myself into something and I want to remember why."

You've been going back and forth on a decision — maybe for days — and you finally landed somewhere. But you know that in two weeks, you'll forget the reasoning. You'll just remember the outcome.

**What to do:** Open Cowork and walk Claude through the decision. Don't worry about being structured. Start with "I've been going back and forth on X, and here's where I landed..." Claude will pull out the decision, your reasoning, and the alternatives you rejected.

**What you get:** A trace that says: "On March 26, you decided to delay the rebrand until after Series A because splitting focus during fundraising was the bigger risk than brand confusion." Future you will thank present you.

---

### "I just said no to something and I need that on the record."

Someone pitched you an idea — a partnership, a feature request, a new hire — and you turned it down. Saying no is a decision, but it rarely gets documented. Two months later, the same idea comes back with a different hat on.

**What to do:** Tell Claude: "I just decided not to do X. Here's why." Be specific about what you turned down and the reasoning. Claude will capture it and ask if there's a condition that would make you revisit — like "unless we hit $2M ARR" or "unless a second customer asks for it."

**What you get:** The next time someone brings it up (or you start second-guessing yourself), you can ask Claude: "Why did I say no to this?" and get the full context back. And if the revisit condition has been met, Claude will tell you that too.

---

### "I just got out of a Slack thread where a decision got buried."

A 30-message thread. Three people. Somewhere around message 17, a decision happened. But good luck finding it without re-reading the entire chain. And the reasoning? Scattered across half a dozen messages from different people.

**What to do:** Copy the thread. Paste it into Cowork. Say: "Can you extract the decisions from this?"

Claude will scan the text, identify who said what, and pull out the decisions with the back-and-forth intact — who proposed what, who pushed back, how it resolved.

**What you get:** A clean trace with names, roles, and the full reasoning arc. Way more useful than a Slack bookmark you'll never look at again.

---

### "I just committed to a deadline and I want to track what I actually promised."

You sent an email saying "we'll have the beta ready by June 15." Or you told the board you'd hit 50 customers by Q3. These commitments are decisions — and they tend to drift.

**What to do:** Tell Claude what you committed to, who you committed it to, and what's riding on it. Claude captures it as a decision trace with the commitment specifics.

**What you get:** A searchable record of your commitments. When things shift (and they will), you can ask Claude: "What did I promise about the beta timeline?" and get the exact commitment plus the context that produced it — not a vague memory.

---

### "I just realized I might be contradicting myself."

You're about to make a decision, and something feels off. Like maybe you already decided the opposite of this a month ago. But you can't quite remember.

**What to do:** Just keep talking with Claude. If your decision traces are building up, the skill will catch it:

> "This may conflict with a decision from February 12: you decided to hold off on enterprise pricing until after 10 pilot customers. The reasoning was: premature pricing signals desperation. Want to reopen that?"

**What you get:** A system that holds you accountable to your own past reasoning — not to punish you, but to make sure you're changing course deliberately rather than accidentally.

---

### "I just finished a strategy session and the notes don't capture what actually happened."

You had a great working session. Real decisions were made. But the notes are a bulleted list of topics discussed, not the actual choices and trade-offs. The messy, useful stuff — the pushback, the reasoning, the "we'll revisit if X happens" — didn't make it in.

**What to do:** Paste your notes, transcript, or even your rough recollection into Cowork. Say: "We covered a lot. Can you pull out the actual decisions?"

Claude will separate the decisions from the discussion, identify what's resolved vs. still open, and capture each with the reasoning that led to it.

**What you get:** Decision traces instead of meeting notes. Three months from now, you won't re-read the notes. But you will search "what did we decide about the hiring plan?"

---

### "I need to brief someone on why we made a past decision."

A new team member, a board member, an advisor — someone needs to understand a decision that was made before they were in the room. And the answer is currently "let me dig through my email and try to reconstruct it."

**What to do:** Ask Claude: "What did we decide about X?" or "Show me decisions from the Q1 planning sessions."

Claude pulls the trace — not just the outcome, but who was involved, what the alternatives were, and why this path was chosen.

**What you get:** A briefing in 30 seconds instead of a 20-minute archaeology expedition through your inbox.

---

### "I just inherited a project and I don't understand the decisions behind it."

You've taken over something — a product line, a team, a partnership — and the decisions that shaped it are locked in someone else's head. Or scattered across docs you don't have context for.

**What to do:** If the previous owner used this skill, the traces are already there. Ask Claude: "Show me all decisions related to [project name]" or "What's the history of decisions about [topic]?"

If the traces don't exist yet, start building them now. Paste in whatever context you have — emails, docs, your own notes from handoff conversations — and let Claude extract the decisions.

**What you get:** A decision history you can actually work with. Instead of guessing why things are the way they are, you can see the reasoning — and decide whether it still holds.

---

## Tips

**You don't have to use this in real-time.** The most common pattern is: have the conversation (meeting, email, thinking session), then come to Claude afterward and capture the decisions. Don't let the tool slow down the actual work.

**Be specific about "why."** When Claude asks for your reasoning, give it. "Because it's cheaper" is a decision. "Because at our current burn rate, we have 14 months of runway and the cheaper option buys us 3 extra months to find product-market fit" is a decision trace. The second one is what future-you actually needs.

**Revisit triggers are the most underused feature.** When you defer or resolve a decision, Claude will ask: "What condition would make you revisit this?" Take 10 seconds to answer. It's the difference between a decision that's truly closed and one that quietly rots.

**Check for contradictions periodically.** Every few weeks, ask Claude: "Have any of my recent decisions contradicted earlier ones?" It's a quick sanity check that catches drift before it compounds.

---

*Built by [Alignmink](https://alignmink.com). Every decision leaves a trace.*
