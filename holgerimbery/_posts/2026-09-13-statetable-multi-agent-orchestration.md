---
layout: post
title: "Long-Running Business Processes in Copilot Studio: State Tables, Agent Flows and Multi-Agent Orchestration"
description: "Building long-running business processes in Copilot Studio using standard harness, state tables, agent flows, and multi-agent orchestration. Boring but effective and save"
date: 26-09-13
author: "admin"
slug: statetable-multi-agent-orchestration
canonical_url: https://holgerimbery.blog/long-running-business-processes-copilot-studio-state-tables-agent-flows-multi-agent-orchestration
image: /images/2026/09/olena-kholina-MhqUBTxQ3Hw-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@sixtynice?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Olena Kholina</a> on <a href="https://unsplash.com/photos/two-people-reviewing-documents-at-a-table-MhqUBTxQ3Hw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
tags: [copilotstudio, standardharness, longrunningprocesses, statetables, agentflows, multiagentorchestration]
featured: true
toc: true
---

How I built long-running processes, like invoice processing or purchase order handling, with the standard harness — no custom middleware, no side platform.

## Why I stopped thinking in conversations

The first thing I had to unlearn in my projects was the idea that an agent is a conversation. A conversation is short, synchronous, and forgettable. A business process is none of those things. An invoice arrives on a Tuesday, sits in an approval queue for four days, gets rejected because a purchase order number is missing, comes back on Monday, and finally posts to the backend system (if there is any) two weeks after it first landed in the mailbox.

Nothing in that story fits into a chat turn. But it all fits into a **state table**.

My way of working is simple: the agent is not the process. The agent is a worker that picks up work, does one well-scoped thing, writes down what it did, and moves the item to the next state. The process lives in Dataverse. That single decision made long-running automation reliable for me — and I build everything I describe here with the standard harness: Copilot Studio, agent flows, Dataverse, connectors. No custom orchestration layer, no separate runtime to operate.

## The state table is the process

Every long-running process I run has one central Dataverse table. For invoice handling, I call it `Invoice Case`. It is deliberately boring:

| Column | Purpose |
|---|---|
| `CaseId` | Business key, used in every message and log line |
| `State` | Choice column — the only authority on where the item stands |
| `SubState` | Optional refinement inside a state (e.g. *waiting on supplier*) |
| `AssignedAgent` | Which specialized agent currently owns the item |
| `Attempts` | Retry counter, guards against loops |
| `NextActionAt` | When the item should be looked at again |
| `Payload` | Extracted structured data as JSON |
| `Confidence` | Extraction confidence, drives the human-in-the-loop branch |
| `LastError` | Plain-language reason for the last failure |
| `AuditTrail` | Append-only log of state transitions |

The state list for invoices, in the order I actually use it:

`Received → Classified → Extracted → Validated → Matched → PendingApproval → Approved → Posted → Closed`

plus the two states that carry all the real-world mess: `NeedsHuman` and `Failed`.

Two rules I do not break:

1. **Only one component may write `State` at a time** Transitions go through a single agent flow that takes the current state and the requested target state, validates the transition against an allowed-transition list, and writes the new row version. Everything else *reads* state and *proposes* transitions.
2. **Every transition is written before the side effect, and confirmed after it** If the backend system posting call dies halfway, I want the table to say `Posting` with an attempt count, not `Approved` forever.

That is idempotency in practice. Because the state table is the source of truth, a retry is never a duplicate — it is a re-read of a row that already knows how far it got.

## The orchestrator agent

An orchestrator sits on top of the table. It is a Copilot Studio agent with a deliberately thin job description: read the case, decide which specialist should handle the current state, hand over, and write the result back. It has no domain knowledge about VAT rules or supplier master data. It knows states and routing.

I give it exactly three kinds of tools:

- an agent flow **GetNextCases** — pulls cases whose `NextActionAt` is due, ordered by priority
- an agent flow **TransitionCase** — the guarded write described above
- connected **child agents**, one per specialist capability

The orchestrator's instructions are a routing table in prose, not a personality. Something like: *"If State is Received, hand the case to the Classification agent. If State is Classified and the document type is Invoice, hand it to the Invoice Extraction agent. If confidence is below the threshold, transition to NeedsHuman and notify the queue owner."* Short, testable sentences. When routing gets more complex than that, the complexity belongs in the flow, not the prompt.

The trigger side is equally boring and equally important. Three entry points cover almost everything I have built:

- **Event-driven** — a new mail with attachment, a file dropped into SharePoint, a Dataverse row created.
- **Scheduled** — a recurring agent flow that sweeps due cases. This heartbeat makes "long-running" work possible. A process that waits four days does not need a session that stays open for four days; it needs a table row with a date and a sweeper.
- **Human-driven** — an approver replies, a clerk fixes a field, someone asks the agent in Teams "where is invoice 4711?" and gets the state, the history, and the current blocker.

## The specialists

The specialist agents hold the domain knowledge, and each one is scoped small enough that I can describe its job in one sentence.

**Classifier.** Decides what the document is — Invoice, credit note, dunning letter, delivery note, something else entirely. Cheap, fast, and it keeps the expensive extraction work off documents that never needed it.

**Scanned-document extraction agent** This is the one people ask about most. Scanned PDFs and photographed invoices are a different problem from digital PDFs, and I treat them as such. The agent runs the document through OCR/document intelligence, then reasons over the recognized content to produce the structured payload: supplier, invoice number, invoice date, net, tax, gross, currency, PO number, line items, IBAN. It returns per-field confidence, not just values — and I persist that confidence, because it is the switch that decides whether a human ever sees the document.

**Digital PDF extraction agent** Same output contract, different path: text layer first, OCR only as fallback. Same JSON schema so that everything downstream is indifferent to how the data was obtained. Agreeing on one schema across all extraction paths is the single highest-leverage design decision in the whole solution.

**Validator** Arithmetic, tax plausibility, IBAN format, duplicate detection against previously posted invoices, supplier existence in master data. Deterministic checks belong in flows; judgment calls belong in the agent. I keep that line clean.

**Matcher** Purchase order and goods-receipt matching — two-way or three-way depending on the client. Produces a match result and a deviation list, never a decision on its own.

**Approval agent** Determines the approver from amount, cost center, and delegation rules, sends an adaptive card, and waits. "Waits" here means: writes `PendingApproval`, sets `NextActionAt` for the reminder, and stops. Nothing stays in memory.

**Posting agent** Talks to the backend system through a connector, with the write-before/confirm-after pattern.

**Communication and alerting agent** Manages SLAs, deadlines, and escalations. When a case breaches its SLA target or an approval sits unattended, it sends reminders via Teams or email, escalates to backup approvers, and records every notification in the state table.

**Supplier inquiry agent** triggers an email back to the invoice sender whenever essential data is missing or invalid — like an absent PO number, unverifiable tax ID, or mismatched line items. It specifies the exact issue, attaches the reference, transitions the case to `WaitingForSupplier`, and sets a deadline so the process parks cleanly until a reply arrives.

Each specialist gets the case ID and reads what it needs from the table. I deliberately avoid passing large context between agents. The state table is shared memory: queryable, auditable, and survives restarts—three things a conversation context does not.

## What the state table gives me beyond orchestration

Once the process lives in Dataverse, many things I used to build separately come for free.

**Observability.** A Power BI report over the state table is the process dashboard: how many invoices sit in each state, average dwell time per state, which supplier produces the most `NeedsHuman` cases, which extraction fields have the lowest confidence. That last one is my improvement backlog, generated automatically.

**Human-in-the-loop that scales** `NeedsHuman` is a queue, and a model-driven app over the same table is the clerk's workplace. The agent prepares, the human decides, the agent continues. No screenshots, no re-keying.

**Safe evolution** Adding a new step to the process means adding a state and a specialist. Nothing else changes, because nothing else knew the process shape to begin with.

**Explainability** When someone asks why invoice 4711 took eleven days, the audit trail answers with timestamps and reasons. That conversation used to be the hardest part of the project.

## What made the difference

- Design the state list on paper, with the business, before touching the maker portal. If the states are wrong, no amount of prompt engineering rescues the solution.
- Keep every agent's instruction short enough to read out loud. Long instructions are undebuggable.
- Put deterministic logic in agent flows, judgment in agents, and truth in Dataverse.
- Make every operation idempotent and every transition guarded.
- Store confidence and route on it. Automation that knows when to ask for help gets trusted; automation that is confidently wrong once does not.
- Start with one document type and one supplier group, run it in production, then widen.

**The technology stack here is unglamorous on purpose. The interesting engineering isn't in the agent—it is in the table that remembers what the agent did.**
