---
layout: post
title: "Multi-Agent Orchestration with Copilot Studio — Part 2: In Practice"
description: "Four end-to-end scenarios on different orchestration patterns, a starter MCP server inventory, and the ten anti-patterns that recur in production Copilot Studio deployments."
date: 2026-07-11
author: admin
slug: copilot-studio-orchestration-part2
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/05/andy-kelly-0E_vhMVqL9g-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@askkell?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Andy Kelly</a> on <a href="https://unsplash.com/photos/photo-of-girl-laying-left-hand-on-white-digital-robot-0E_vhMVqL9g?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
      
tags: [agents, copilotstudio, multi-agent, orchestration, scenarios, anti-patterns]
featured: false
toc: true
---

{: .q-left }
> **Summary lede.** This is the second of three articles on multi-agent orchestration in Microsoft Copilot Studio. Part 1 settled the architecture: when to split a single agent, what a Copilot Studio agent is composed of, which orchestration patterns exist, and how the Model Context Protocol (MCP) and Agent2Agent (A2A) protocol keep the system composable. Part 2 — In Practice — takes those decisions and works through what they look like in production. Four end-to-end scenarios, each built on a different orchestration pattern, show how the architectural pieces fit together. A starter MCP server inventory makes the platform team's role explicit. The article closes with ten anti-patterns from real deployments and the corrections that teams have actually applied.

{: .q-left }
> **About this series.** This is Part 2 of three. **Part 1 — Foundations** establishes the vocabulary, when to split a single agent, the five configuration surfaces, the four orchestration patterns, and how MCP and A2A are configured. **Part 2 — In Practice** (this article) turns those decisions into four end-to-end scenarios, a starter MCP server inventory, and ten production anti-patterns. Parts 1 and 2 describe the **released, generally available feature set** — the "classic" Copilot Studio experience, built on **generative orchestration**, which is GA and fully supported. **Part 3 — The Build 2026 Rebuild** describes the new four-surface model (Skills, Memory, a new orchestrator); those features are **in public preview and subject to change** before general availability, so treat Part 3 as forward-looking and re-check status before relying on it.

Every scenario uses features documented on Microsoft Learn and either generally available or in public preview as of mid-2026: connected agents, autonomous triggers, agent flows with parallel branches and approval gates, Dataverse as a state store, MCP integration with Streamable transport, and Purview audit logging. Where a capability is in preview (for example, connecting to Microsoft Foundry, Fabric, or Microsoft 365 Agents SDK agents), this article says so. The scenarios pair with named, published case studies — T-Mobile, Nexi Group, Dunaway, Holland America Line, Signetic, Singapore Civil Defense Force, La Trobe University — whose architectural shape matches the patterns described.

{: .q-left }
> **Capability status at publication**
> Two capabilities directly reinforce these scenarios. **A2A connections are generally available**, so cross-platform delegation is not a preview dependency. **Computer Use (computer-using agents) is generally available** — the CUA extension mentioned in Scenario 1 is a shipping capability, with embedding into multi-step workflows in preview. A **redesigned Workflows experience** (early release) introduces a unified visual canvas with **agent nodes** that drop existing agents into a flow, plus AI-powered actions for classification and content generation; **asynchronous responses** *(preview)* let agent-flow steps exceed the two-minute limit, which the onboarding scenario benefits from. And **per-agent Microsoft Entra agent identities** can be auto-created *(preview)*, which is the concrete mechanism behind the "Entra Agent ID per agent" recommendation in the anti-patterns section.

{: .q-left }
> **Why read this**
Read this if Part 1 left you convinced that multi-agent orchestration is the right response to scope drift, and you now need to see four working shapes. The four scenarios — IT incident triage, contract review, field service dispatch, employee onboarding — are not picked for variety; they are picked because they map cleanly onto the four orchestration patterns introduced in Part 1, and because each exposes a different production failure mode that teams are most likely to encounter. Read it if you have ever drawn a multi-agent architecture on a whiteboard, sent it to a senior maker, and watched them rebuild it in a way you did not expect. The MCP inventory section exists to answer the most common follow-up question — "okay, but who owns what?" — with a starting catalog. The anti-patterns section exists to answer the second-most-common follow-up — "what is most likely to bite us first?" — with ten patterns that recur often enough to be predictable.

Read Part 1 if you need the vocabulary; read Part 2 if you have the vocabulary and need the working examples. Each scenario is small enough to read in one sitting and concrete enough to reproduce in your own tenant. The point is not that any of these scenarios is the right one for your organization — the point is that the patterns underneath them are.

---

## 1. The four scenarios and what they exercise

Four scenarios appear below. They are deliberately ordered by complexity, from the simplest pattern (router-worker) to the most demanding (hierarchical with persistent state). Each builds on the surfaces introduced in Part 1 — instructions, knowledge, tools, topics, triggers — and uses one of the four orchestration patterns.

| Scenario | Pattern | What it exercises |
|---|---|---|
| IT incident triage | Router-worker | Classification, delegation, structured outputs between agents |
| Contract review | Parallel fan-out / fan-in | Concurrent specialists, scoped knowledge, merged outputs |
| Field service dispatch | Router-worker with autonomous trigger | Event-driven autonomy, bounded decision trees, no user in the loop |
| Employee onboarding | Hierarchical with persistent state | Long-running supervision, Dataverse as state store, SLA monitoring |

The scenarios are sized to be read end to end. Each one names the agents, provides instructions, walks through the expected runtime behavior, and points to a published case study whose architectural shape matches. The published shape — not the exact numbers — is the part to import.

---

## 2. Scenario one — IT incident triage (router-worker)

The first scenario takes a concrete, widespread problem — tier-one IT service desk volume — and shows how a multi-agent design resolves it using only features available in Copilot Studio today.

### The problem

A large share of tier-one service desk tickets are mechanical: password resets, VPN issues, access requests, known application errors. In many IT organizations, this mechanical work accounts for a substantial fraction of the total ticket volume. Each of these tickets, when routed to a human analyst, consumes several minutes — read the ticket, look up the user, open the runbook, apply the fix, update the record.

The pattern is tedious for analysts and slow for users. It is also unnecessary: the runbooks already exist, the ticketing system already has APIs, and the retrieval work is well inside the capability of current language models.

### The design

Three agents, with clear responsibilities.

**Triage Orchestrator (user-facing).** Classifies the incoming ticket into one of a small set of categories, delegates to the appropriate specialist, and returns the response to the user.

**Runbook Specialist (connected agent).** Retrieves the matching runbook from the IT knowledge base (SharePoint) and returns resolution steps or a "not found" result.

**Ticket Writer (connected agent).** Writes outcomes back to the ticketing system (ServiceNow, via the existing connector). Idempotent — retries do not create duplicates.

The split is deliberate. The Runbook Specialist is read-only; it never writes. The Ticket Writer writes but does not reason about runbooks. The Orchestrator owns the conversation and the classification but has no direct access to connectors.

### Agent configurations

**Triage Orchestrator — instructions:**

```
You are the IT service desk triage agent. When a user
describes a technical problem; your job is to classify it
And route it to the correct specialist.

Classify the request into exactly one of:
  password_reset, vpn, hardware, application, other

Then:
  1. Call RunbookSpecialist with the classification and the
     user's original message.
  2. If RunbookSpecialist returns resolution_steps, present
     the steps to the user in a numbered list and ask if
     they want the ticket closed as resolved.
  3. If the user confirms, call TicketWriter with
     status="resolved" and the applied steps.
  4. If RunbookSpecialist returns no match, call
     TicketWriter with status="routed" and
     assignment_group derived from classification.

Never attempt to resolve a problem yourself.
Never write to the ticketing system directly.
Never mention specialist agents to the user.
```

**Runbook Specialist — instructions:**

```
You look up runbooks from the internal IT knowledge base
and return resolution steps.

Inputs:
  classification (string)
  problem_statement (string)

Behavior:
  Search the IT knowledge base scoped to the given
  classification. Return the single best-matching runbook.

Output (structured):
  { runbook_id: string | null,
    resolution_steps: string[] | null,
    confidence: number }

You do not create, update, or delete tickets.
You do not reason about user intent beyond runbook matching.
```

Knowledge source: a specific SharePoint library, `IT Knowledge Base / Runbooks`. Nothing else.

**Ticket Writer — instructions:**

```
You write outcomes to the ticketing system.

Inputs:
  ticket_id (string)
  status (enum: "resolved", "routed", "escalated")
  applied_steps (string[], optional)
  assignment_group (string, optional)
  idempotency_key (string)

Behavior:
  Call the ServiceNow Update Incident action with the
  mapped fields. Use idempotency_key to deduplicate.

Output (structured):
  { ok: boolean, ticket_url: string }

You do not reason about whether the status is correct.
You do not retrieve runbooks.
```

Tools: the ServiceNow connector's `Update Incident` action. Nothing else.

### Orchestration pattern

Router-worker. The Orchestrator routes; specialists execute. No parallelism, no hierarchy, no callbacks from specialists to the Orchestrator.

### Expected runtime behavior

A user writes: "I can't connect to the VPN from home since this morning."

1. The Orchestrator classifies the request as `vpn`.
2. It calls the Runbook Specialist with `{classification: "vpn", problem_statement: "..."}`.
3. The Runbook Specialist searches the runbook library, finds a match, returns `{runbook_id: "RB-0187", resolution_steps: ["Verify your network...", "Re-register the VPN client...", ...], confidence: 0.91}`.
4. The Orchestrator presents the steps to the user.
5. The user replies that the steps worked.
6. The Orchestrator calls the Ticket Writer with `status: "resolved"`.
7. The Ticket Writer updates ServiceNow and returns `{ok: true, ticket_url: "..."}`.

If the Runbook Specialist had returned no match, the Orchestrator would have called the Ticket Writer with `status: "routed"` and an assignment group derived from the classification.

### Expected outcomes

The scenario mirrors the shape of several published Copilot Studio case studies. T-Mobile equipped customer service representatives with a Power Apps + Copilot Studio agent that provides accurate device information and improves customer experiences. Nexi Group modernized card-service customer support with Copilot Studio, with the explicit outcome of reduced contact-center workload. A1 Inteligência em Viagens used Power Automate and Copilot Studio to boost team efficiency and customer experience.

The exact numbers depend on ticket mix and runbook quality, but the shape is consistent across published reports: a meaningful share of tier-one volume auto-resolves, a larger share auto-routes with enriched context, and escalation volume drops.

### What this scenario makes obvious

The value of the split is not the number of agents. It is the clarity of ownership. When the knowledge base team updates a runbook, only the Runbook Specialist is affected. When the ticketing team rotates a credential, only the Ticket Writer is affected. When the user experience changes, only the Orchestrator is affected. Each change is small and independent, which is what allows the overall system to be maintained over time.

The extensions to consider once the base is working: add an autonomous trigger (a Dataverse row-change event that fires when a new ticket is written to a queue table) so the Orchestrator runs on new tickets, not only when a user chats. Replace the ServiceNow connector with an MCP server to share ticketing tools across multiple agents in your tenant. Add a Computer-Using Agent (CUA) specialist — now generally available in Copilot Studio (May 2026) — for the narrow set of cases where the fix requires clicking through a legacy admin UI without an API.

---

## 3. Scenario two — Contract review pipeline (parallel fan-out)

The second scenario exercises a different orchestration pattern — parallel fan-out — and a different kind of specialist agent. Contract review is a good test because the work splits cleanly across independent review domains, each domain has its own policy library, and the outcome is a merged memo rather than a single-agent response.

### The problem

Inbound vendor contracts typically pass through three gates before signature: legal review (indemnity, liability cap, governing law, dispute resolution), finance review (payment terms, auto-renewal clauses, price escalators), and risk review (data processing, subprocessors, breach notification, subcontracting). Each review is conducted by email serially, and the combined cycle frequently spans two weeks for contracts that are not particularly complex.

The serial nature is the problem. Each reviewer waits for the previous one. Each reviewer reads the full contract, even though their concerns are narrow. The end state — signature — is delayed by the sum of the waits, not the sum of the work.

### The design

Five agents, one parallel step.

**Intake Orchestrator (user-facing).** Receives the contract PDF, extracts clauses into a structured clause map, triggers the review fan-out, composes the final memo.

**Clause Extractor (tool, not a separate agent).** A PDF extraction action backed by an MCP server or Power Automate flow. Returns clauses as a structured list.

**Legal Reviewer (connected agent).** Reviews the clause map against a legal policy library. Returns legal issues with severity and citations.

**Finance Reviewer (connected agent).** Reviews the clause map against finance policy. Returns finance issues with severity and citations.

**Risk Reviewer (connected agent).** Reviews the clause map against risk and data-protection policy. Returns risk issues with severity and citations.

The three Reviewers run in parallel. Each has a narrow, owned knowledge source. None of them depends on the others' output.

### Agent configurations

**Intake Orchestrator — instructions:**

```
You own the contract review process.

When a user uploads a contract:
  1. Call the Clause Extractor to get a structured clause
     map from the document.
  2. In parallel, call LegalReviewer, FinanceReviewer, and
     RiskReviewer with the full clause map.
  3. When all three return, aggregate findings into a single
     review memo organized by severity.
  4. Present the memo to the user with the contract
     reference, the number of issues found, and a link to
     the full findings.

Do not perform legal, financial, or risk analysis yourself.
Do not reformulate reviewer findings; present them verbatim.
```

**Legal Reviewer — instructions:**

```
You review contracts for legal risk.

Inputs:
  clause_map (structured list of clauses with text and type)

Behavior:
  Check each clause against the Legal Policy library.
  Flag issues only where the clause conflicts with policy
  or is missing from a required category.

Output (structured):
  { issues: [{ clause_type: string,
               severity: "high" | "medium" | "low",
               citation: string,
               suggested_redline: string }] }

Knowledge source: SharePoint "Legal Policy Library" only.
You do not review payment terms, pricing, or data
processing — those belong to Finance and Risk Reviewers.
```

Finance Reviewer and Risk Reviewer follow the same shape, each scoped to its own policy library.

### Orchestration pattern

Parallel fan-out / fan-in. The Intake Orchestrator fires three calls at once and joins when all three return. In Copilot Studio, this is typically built as an agent flow with parallel branches — one branch per reviewer — followed by an aggregation step. (In the redesigned Workflows experience now in early release, those reviewer agents can be dropped onto the canvas as agent nodes.)

### Human-in-the-loop

Copilot Studio agent flows support approval gates. In this design, the memo is delivered to a human reviewer (usually the deal owner or general counsel) who decides what to act on. The system does not automatically redline the contract; it surfaces issues and suggests redlines for human judgment.

This is the right default for regulated workflows. The published case study from Dunaway — a firm that uses Copilot Studio for city-code research — is explicit that the value of the agent is surfacing accurate information quickly, with the compliance professional retaining decision authority.

### Expected runtime behavior

A user uploads a vendor agreement to the Intake Orchestrator.

1. The Orchestrator calls the Clause Extractor, which returns `{clauses: [{type: "indemnity", text: "..."}, {type: "payment_terms", text: "..."}, ...]}`.
2. The Orchestrator triggers three parallel branches:
   - Legal Reviewer returns two issues (one high, one medium).
   - Finance Reviewer returns one issue (medium: auto-renewal without notification).
   - Risk Reviewer returns three issues (one high: subprocessor not listed; two medium).
3. The Orchestrator aggregates the six issues into a memo organized by severity.
4. The user receives the memo and decides what to negotiate.

The time from upload to memo is effectively the slowest of the three parallel branches plus the extractor and the aggregator — in practice, single-digit minutes, versus single-digit business days in the serial model.

### What makes this work reliably

**Scoped knowledge.** Each Reviewer's knowledge source is its own policy library and nothing else. Cross-contamination — a Legal Reviewer surfacing finance concerns — produces noisy memos and erodes trust. The narrower the library, the sharper the output.

**Structured outputs.** Every reviewer returns the same issue shape. The aggregator does not have to parse three different prose styles.

**Citations.** Every issue includes a citation back to the policy passage that grounds it. Reviewers without citations are not trusted by their human counterparts, and correctly so. (Bear in mind Part 1's caveat: citations are not always preserved when outputs pass back from a connected agent, so carry the citation explicitly as a field in the structured output rather than relying on the platform to thread it through.)

**Explicit severity.** Three levels (high, medium, low), defined in each reviewer's instructions. The aggregator can sort consistently across reviewers.

### What to watch out for

**Partial failure.** If the Finance Reviewer times out, what does the memo say? Decide before you build: a "partial review" memo that notes the missing section is more useful than a failed run.

**Policy drift.** The quality of the reviewers depends on the currency of the policy. Assign ownership of each policy library to a named team and review quarterly.

**Scope creep.** It is tempting, once the Legal Reviewer works, to add "intellectual property" and "export control" to its scope. Resist. New domains are new reviewers.

Two published case studies anchor this shape. Dunaway transformed compliance workflows with a conversational agent that delivers instant, accurate regulatory answers from scoped knowledge — the scoping makes the answers trustworthy. Signetic uses Power Platform and Copilot Studio across healthcare operational workflows, including review-style patterns that merge multiple specialist inputs into operational decisions. Neither describes this pipeline exactly, but the architectural pattern — bounded specialists over scoped knowledge, merged by an orchestrator — is what both rely on.

---

## 4. Scenario three — Field service dispatch (autonomous trigger)

The third scenario exercises an autonomous trigger — the system reacts to an event from the field, not to a user typing into a chat window. This is where Copilot Studio's March 2025 autonomous-agents GA materially changes what is buildable.

### The problem

A field technician arrives at a customer site to service equipment and finds that a required part is missing from the van stock. The resolution today is a phone call. The technician calls dispatch. Dispatch puts the customer call on hold, checks inventory in SAP, calls a nearby warehouse, reschedules the appointment in Dynamics 365 Field Service, calls the customer back, and notifies the technician. The technician waits through all of it — often 30 to 45 minutes of paid idle time, per incident, multiplied by however many incidents happen that day.

The problem has obvious parts that should be automatic: inventory lookup, rescheduling, and customer notification. None of it is novel; the delay is the cost of humans doing mechanical work.

### The design

Four agents. Three are called on-demand; one is autonomous.

**Dispatch Orchestrator (autonomous).** Triggered by an event from the field app — "technician reports missing part." Drives the resolution. In Copilot Studio, this is implemented as a Dataverse row-change trigger: the field app writes a row to a `FieldIncident` table, and the trigger wakes the agent. Where the source system does not write directly to Dataverse, a Power Automate cloud flow subscribes to the source and writes to Dataverse on its behalf.

**Inventory Specialist (connected agent).** Queries SAP for part availability at the current site and at nearby warehouses.

**Scheduler Specialist (connected agent).** Proposes and books appointment slots in Dynamics 365 Field Service.

**Notification Specialist (connected agent).** Sends an SMS and an email to the customer and a Teams message to the technician.

The Dispatch Orchestrator does almost no reasoning about parts, scheduling, or customer preference. Its job is to call the three specialists in the correct order and handle the cases.

### Agent configurations

**Dispatch Orchestrator — instructions (autonomous):**

```
You run automatically when the field app emits a
"missing_part" event (written to the FieldIncident table).

Event payload includes:
  technician_id, customer_site_id, part_number,
  appointment_id, current_time

Behavior:
  1. Call InventorySpecialist with part_number and
     customer_site_id. You get back either:
     - available_locally: true, eta_minutes
     - available_nearby: true, warehouse_id,
       eta_minutes
     - available: false, earliest_date

  2. If available_locally within 30 minutes:
       Call NotificationSpecialist with mode="wait" and
       eta_minutes. Exit.

  3. If available_nearby and eta_minutes <= 120:
       Call NotificationSpecialist with mode="delay".
       Exit.

  4. Otherwise:
       Call SchedulerSpecialist to propose a new
       appointment at or after earliest_date.
       Call NotificationSpecialist with mode="reschedule"
       and the new appointment.
       Exit.

You never book inventory or rearrange stock yourself.
You never modify appointments directly.
```

**Inventory Specialist — instructions:**

```
You check SAP inventory for parts.

Inputs:
  part_number (string)
  site_id (string)

Behavior:
  Query the SAP connector for stock at the given site and
  at warehouses within the configured proximity radius.

Output (structured):
  { available_locally: bool, eta_minutes: number?,
    available_nearby: bool, warehouse_id: string?,
    available: bool, earliest_date: date? }

You do not reserve parts. You do not reschedule.
```

Scheduler Specialist and Notification Specialist follow the same shape, each with its own scoped tools.

### Orchestration pattern

Router-worker with an autonomous trigger. The Orchestrator is event-driven, not user-driven. The specialists are standard connected agents. Microsoft Learn's *Event trigger overview* documents Dataverse row-change, SharePoint, OneDrive, Planner, and Recurrence triggers — exactly the surfaces an event-driven agent runs on (an HTTP request trigger and Power Automate flows extend the catalog where a native trigger does not exist).

### Expected runtime behavior

The field app emits a `missing_part` event at 10:15 AM, written as a row to the `FieldIncident` table.

1. The row-change trigger wakes the Orchestrator. It calls the Inventory Specialist.
2. Inventory returns `{available_locally: false, available_nearby: true, warehouse_id: "WH-17", eta_minutes: 75}`.
3. The Orchestrator calls the Notification Specialist with `mode: "delay", eta_minutes: 75`.
4. The technician receives a Teams message; the customer receives an SMS and an email: "Your technician has been delayed 75 minutes to retrieve a part. New estimated arrival: 11:30 AM."
5. Everything above happens in under a minute.

If inventory had been unavailable for two days, step three would have called the Scheduler Specialist instead, who would have proposed a slot and booked it in Dynamics 365 Field Service, followed by the notifications.

### What makes the autonomous trigger the right shape

Three properties justify autonomy here:

1. **The signal is clean.** The field app writes a well-defined row with a known schema. There is no ambiguity to clarify with a human.
2. **The reasoning is bounded.** The decision tree is small. Nothing about the workflow requires open-ended judgment.
3. **The latency matters.** A human-in-the-loop step would defeat the point. The whole value is in removing the 30-minute phone call.

Where any of those is not true, a conversational trigger with a human in the loop is in a better shape.

### A trigger-security note

Autonomous triggers run with the agent maker's credentials, and the payload that wakes the agent is untrusted input that is then added to the agent's context. This is precisely the surface that CVE-2026-21520 exploited: an indirect prompt injection inserted into a SharePoint form field was concatenated into a Copilot Studio agent's instructions, which then exfiltrated data via a legitimate Outlook action (Microsoft patched it in January 2026; it was publicly disclosed in April 2026). For a `FieldIncident` row, the practical lessons are the same as Microsoft's autonomous-agent guidance: validate required fields before acting, narrow the conditions that trigger the action, and never let free-text payload fields override the agent's instructions.

### Real anchor points

Several published Copilot Studio case studies touch adjacent patterns. The Holland America Line virtual concierge uses Copilot Studio to resolve customer requests with backend integrations without requiring a human operator for standard cases. Signetic uses Power Platform and Copilot Studio to automate healthcare operational workflows that would otherwise require coordination calls between departments. Singapore Civil Defence Force reports automating manual processes that previously required significant staff time, with savings described as multi-million-dollar in the published case study. Field service dispatch fits the same mold: a bounded workflow with clear inputs and a clear success state.

### Safeguards for autonomous agents

Microsoft's guidance on autonomous agents is explicit about the safeguards that matter, and they apply directly here:

- **Least-privileged access.** The Inventory Specialist should have read-only access to SAP. The Scheduler Specialist should have write access only to the specific entities it books. Neither has broader scope. Per-agent Entra agent identities — now auto-creatable in Copilot Studio *(preview)* — make this scoping concrete.
- **Input validation.** The field app's row write is authenticated; the Orchestrator validates required fields before acting, and treats free-text fields as data, not instructions.
- **Audit logging.** Every decision and every action is logged to Purview. Field Service dispatch is a regulated area in some industries (medical device servicing, for example), and auditable logs are non-negotiable there.
- **Human escalation path.** If the Orchestrator cannot resolve the event — for example, the customer has no contact method on file — it escalates to a human dispatcher rather than failing silently.

---

## 5. Scenario four — Employee onboarding (hierarchical with persistent state)

The fourth and final scenario exercises the hierarchical pattern: a long-running process that spans departments, persists state over days, and requires coordination across multiple specialist agents. Employee onboarding is a good example because the work is well-defined, the owners are clear, and the measurable outcome — day-one readiness — is something every HR organization already tracks.

### The problem

Between a candidate accepting an offer and their first day, a long list of things must happen: HR creates the employment record, legal sends contracts for signature, IT provisions the Entra account and assigns licenses, procurement orders hardware, facilities allocates a desk and issues a badge request, the hiring manager drafts a 30-day plan and sets up 1:1s, the new hire is added to Teams channels and mailing lists.

None of this is intellectually hard. It is coordination work across four or five systems and three or four departments, and it often fails. In many organizations, a meaningful share of new hires arrive on day one with at least one blocker — a missing laptop, no email account, no desk assignment. Each blocker creates friction that is remembered long after it is resolved.

### The design

One supervisor agent, four specialists, and one shared state store. All live in Copilot Studio, using connected agents and autonomous triggers.

**Onboarding Supervisor (autonomous).** Owns the case from offer acceptance to day 30. Orchestrates the specialists. Escalates when any step is overdue.

**HR Specialist (connected agent).** Creates the Workday record and sends the contract through DocuSign.

**IT Specialist (connected agent).** Provisions the Entra ID account, assigns licenses, orders hardware.

**Facilities Specialist (connected agent).** Allocates a desk and issues a badge request.

**Manager Specialist (connected agent).** Drafts the 30-day plan from a template, schedules 1:1s, and adds the new hire to Teams channels.

**Shared state.** A Dataverse table, `OnboardingCase`, with one row per new hire and columns for each step's status, timestamps, and artifact links.

### Why Dataverse and not conversation history

The process spans days or weeks. Conversation history in Copilot Studio is not the right place for state that must outlive a session. The durable design principle is the same: persistent state for a long-running process belongs in Dataverse, not in conversation history, which truncates.

Every specialist updates its own step's status in the `OnboardingCase` row when it completes. The Supervisor reads the row periodically (or reacts to Dataverse row-change events) to decide what to do next. Where a specialist step legitimately runs long, asynchronous responses for agent flows *(preview)* let it exceed the two-minute limit and return its result when it finishes.

### Agent configurations

**Onboarding Supervisor — instructions (autonomous):**

```
You run when a new row is created in the OnboardingCase
table (status = "offer_accepted") or when a row is updated
(status changes).

For each case:
  1. If no HR step has started, call HRSpecialist.
  2. When HR step completes, call IT and Facilities in
     parallel.
  3. When IT step completes, call ManagerSpecialist to
     draft the 30-day plan and schedule 1:1s.
  4. If any step exceeds its SLA (HR: 1 business day, IT:
     3 business days, Facilities: 2 business days,
     Manager: 5 business days), post a Teams message to
     the HR coordinator channel with the overdue step
     and the case ID.

Update OnboardingCase.overall_status after every change.

Never perform steps yourself. Always delegate.
```

**IT Specialist — instructions:**

```
You handle IT provisioning for a new hire.

Inputs:
  case_id (string)
  first_name, last_name, start_date, job_title, cost_center

Behavior:
  1. Create the Entra ID user via the Microsoft Graph
     connector.
  2. Assign licenses based on job_title via the configured
     license-mapping table.
  3. Order standard hardware via the IT procurement
     connector (the specific package is determined by
     job_title).
  4. Update OnboardingCase.it_status = "complete" when
     all three succeed.

Output (structured):
  { ok: boolean, entra_user_id: string,
    hardware_order_id: string }

You do not create HR records.
You do not draft the 30-day plan.
```

Other specialists follow the same shape — each scoped to its own domain, each writing only to its own columns in `OnboardingCase`.

### Orchestration pattern

Hierarchical. The Supervisor runs autonomously, triggered by changes to Dataverse rows. It invokes specialists in a documented order with some parallelism (IT and Facilities can happen concurrently). Each specialist's work is bounded, owned, and auditable. Agent flows provide the mechanism for the Supervisor. Triggers on Dataverse table changes are a first-class feature.

### Expected runtime behavior

Day 0: HR enters a new row in `OnboardingCase` with `status = "offer_accepted"`.

1. The Supervisor wakes and calls the HR Specialist. HR Specialist creates the Workday record and initiates the DocuSign flow. `hr_status` moves to `in_progress`, then to `complete` when the contract is signed.
2. On HR completion, the Supervisor calls IT and Facilities in parallel. IT provisions Entra, licenses, and hardware. Facilities allocates a desk and issues a badge request.
3. On IT completion, the Supervisor calls the Manager Specialist, who schedules 1:1s in the hiring manager's calendar, generates a 30-day plan draft in Word, saves it to the manager's OneDrive, and adds the new hire to the appropriate Teams channels.
4. On day 1, the `overall_status` column reflects the readiness of the new hire. If any step is overdue, the HR coordinator's Teams channel has been notified.

### Expected outcomes

Publicly available data on Copilot Studio onboarding use cases points in a consistent direction. Pragmatiq's published use-case list identifies "Guiding employee onboarding" as one of the top Copilot Studio patterns: "HR teams use Copilot Studio to guide new hires through IT setup, policies, and training materials, helping them get up to speed faster." La Trobe University's published case study describes academic onboarding and student-facing processes handled with Copilot Studio; the pattern generalizes to employee onboarding in its coordination shape.

Organizations measuring before-and-after on this pattern commonly report day-one readiness improving substantially, with the remaining gap being cases with unusual requirements that still need human routing. The gains come from the coordination being mechanical, not from any single step being faster. (Treat any specific percentage as illustrative unless your own baseline supports it — the published case studies describe the shape of the improvement, not a universal number.)

### What this scenario makes obvious

Three things stand out in the hierarchical pattern.

**State is the architecture.** The `OnboardingCase` Dataverse table is not an implementation detail; it is the source of truth. Every decision the Supervisor makes depends on the state it reads. Every specialist writes back to it. If that table is modeled carelessly, the whole system is fragile.

**Specialists are boring.** None of the specialists does anything clever. They do one thing each, reliably. That is the point. Cleverness in the wrong place is a reliability problem.

**The Supervisor is small.** The instruction block is short. The logic is explicit. There is no "decide the best onboarding strategy" reasoning — there is a process, and the Supervisor executes it.

### Where the pattern commonly goes wrong

1. **Treating the Supervisor as a chatbot.** Someone wants to "ask the onboarding agent how things are going." Don't. Build a report on top of the Dataverse table instead. The Supervisor's job is execution, not Q&A.
2. **Overloading `OnboardingCase`.** Adding every possible detail to the row makes it slower and harder to change. Keep it to status, timestamps, and references; put the details in the relevant specialist's own storage.
3. **Missing the SLA side of the Supervisor.** Without the overdue logic, the system looks like it is working until someone realizes a specific step has been stuck for a week. The SLA rule is not optional.

---

## 6. A practical MCP inventory for enterprise Copilot Studio deployments

The four scenarios above all assume the existence of well-described tools. In Part 1, MCP was introduced as the standard that lets those tools be defined once and consumed by many agents. This section proposes a starter catalog of MCP servers and tools that most enterprises need. Everything listed here is either a real, shipping MCP server from Microsoft or a major vendor, or a thin wrapper around an existing, documented enterprise API that any team can build using the official MCP SDK.

### Why start from an inventory

Makers tend to build MCP servers reactively — one per immediate need — and end up with an ecosystem that overlaps, duplicates, and ages unevenly. An inventory, maintained by the platform team, makes the design choices explicit: what domains exist, who owns each, and where a new capability should go.

A practical inventory answers three questions for every proposed tool:

1. Which domain does it belong to? (Only one.)
2. Who owns the server that hosts it?
3. Is it read-only or does it write, and if it writes, is it idempotent?

### Microsoft-published MCP servers

- **Microsoft Learn MCP server.** Exposes Microsoft documentation as searchable tools. Useful for internal developer agents and customer support agents who need up-to-date Microsoft product guidance.
- **Microsoft Dataverse MCP** — platform-level surfaces that expose Dataverse queries to agents, documented in the Microsoft Copilot Studio sample repositories.
- **Azure MCP servers** from the Microsoft Azure organization on GitHub, exposing administrative surfaces for Azure resources.

The Microsoft Copilot Acceleration Team publishes working samples in the CopilotStudioSamples repository on GitHub, including the dynamic MCP routing sample referenced in Part 1. Remember that Copilot Studio also supports registering an existing MCP server as a bring-your-own asset through Agents 365, for organizations that want central governance of servers.

### Third-party MCP servers with public presence

- **GitHub MCP server** — official server from GitHub for repository, issue, and pull-request operations.
- **Atlassian MCP servers** — for Jira and Confluence.
- **Notion, Linear, Asana** — community- and vendor-provided servers for common SaaS work.

For many enterprises, these third-party servers are the starting point because the backend APIs are stable and the servers are maintained by the vendors.

### Enterprise-internal domains that typically need an MCP server

The categories below are ones most enterprises either build themselves or expect to. Each can be implemented as a thin MCP wrapper over the existing backend's REST API using the official MCP SDKs (available in TypeScript, Python, C#, and others).

| Domain | Typical tools exposed | Owner |
|---|---|---|
| IT service management | search_incidents, get_incident, create_incident, update_incident, search_knowledge | IT Operations |
| Inventory / ERP | check_stock, list_warehouses, get_material | Supply Chain |
| HR / workforce | get_employee, list_open_requisitions, create_hire_record | HR Tech |
| Field service | list_slots, book_appointment, cancel_appointment | Field Service |
| Policy / knowledge | search_policy, get_policy, list_policy_versions | Legal / Compliance |
| Identity | create_user, assign_license, add_to_group | IT Security |
| Procurement | order_hardware, get_order_status, list_catalog | IT Procurement |
| Digital signature | send_envelope, get_envelope_status | Legal Operations |
| Document operations | extract_text, extract_tables, split, merge | Shared Services |
| Collaboration | create_channel, add_member, post_message | Collaboration / M365 |

Each row is a server, not a tool. The reason is ownership: when the ServiceNow team rotates credentials, they do it once in the ITSM server, and every agent continues to work.

For domains that already have excellent Power Platform connectors (many of these do — ServiceNow, SAP, Workday, Dynamics 365 Field Service, DocuSign, Microsoft Graph), the decision between "use the connector directly" and "wrap it in an MCP server" comes down to reuse. If only one agent needs these tools, the connector is simpler. If three or more agents need them, an MCP server is usually the right investment.

### Cross-cutting concerns

A few principles apply to every server in the inventory.

**Read-only versus write separation.** When a single server mixes read and write tools, a broader scope of credentials is required to use it. A cleaner pattern is to split — `itsm-read` and `itsm-write` — and to grant the write server's credentials only to agents that actually need them.

**Idempotency on every write.** Retries happen. Every write tool should accept an idempotency key and use it on the backend to deduplicate.

**Structured outputs.** Tools should return structured data with explicit schemas. The MCP protocol supports this natively; use it. An agent parsing prose is a fragile agent.

**Tool descriptions as products.** The description is what the orchestrator reads to decide whether to call a tool. Treat tool descriptions like API documentation — specific, accurate, and up to date. Include: what the tool does, when to use it, what it returns, and any side effects.

**Authentication.** OAuth 2.0 with Entra ID is the default for enterprise tenants. API keys are acceptable for internal network-scoped servers; the connection manager in Copilot Studio encrypts them at rest. Unauthenticated MCP endpoints should not exist in a business tenant. (Because MCP connectivity rides on Power Platform connectors, connector-level data policies also govern MCP access.)

**Audit and observability.** Every MCP server should log every call with the calling agent identity, the tool name, the inputs, the outputs, and the latency. Emit these logs to Sentinel or your SIEM of choice. Purview already captures the agent-side record.

### Governance at the tenant level

The Power Platform Admin Center's **Copilot Hub** and the **agent inventory** (now queryable as a schema from the admin center, API, or Azure Resource Graph *(preview)*) provide the tenant-level surface for seeing which agents use which MCP servers; **Microsoft Agent 365** with the **Entra agent registry** (Ignite 2025) extends that view across platforms. Combine that with:

- **Environment strategy.** Development, test, and production environments for MCP servers and their consuming agents. Pipelines promote both together.
- **DLP policies.** Apply Data Loss Prevention policies to the connectors backing MCP servers. A write-capable MCP server is business data; treat it that way.
- **Entra Agent ID.** Each agent gets a first-class identity, and permissions are scoped per identity (auto-creatable per agent in Copilot Studio *(preview)*). An IT triage agent does not need credentials to create employment records.
- **Global Secure Access for agent traffic.** Where available, routing agent outbound calls through Microsoft's network security enforcement layer is worth considering for regulated tenants.

### A starter prioritization

If an organization is beginning from zero, the order that tends to work:

1. Stand up one read-only domain MCP server first — usually policy or knowledge. Let agents consume it. Prove the integration pattern works.
2. Add one write-capable server (ITSM or HR). Impose idempotency and audit discipline from day one.
3. Adopt the vendor-provided servers (GitHub, Atlassian, etc.) for domains you already use.
4. Expand to the rest of the inventory as agent demand justifies.

Trying to build all 10 servers at once results in an inventory with no consumers. Each server should exist because a specific agent needs it.

### What to resist

**Mega-servers that expose everything.** A single MCP server with 200 tools recreates the god-agent problem at the tool layer. Split by domain.

**Servers that replicate connector logic that already exists.** If the Power Platform connector is already good and only one agent needs it, skip the MCP wrapper. MCP is a sharing mechanism; sharing is only worth it when there is something to share.

**Custom protocols on top of MCP.** If a team is tempted to add their own message shapes or non-standard tool conventions, they have probably drifted from the standard. MCP-compliant clients will not understand them, and the portability value is lost.

---

## 7. Ten anti-patterns that recur in production

The previous sections have covered the architecture, the scenarios, and the inventory. This last section collects what does not fit neatly into any of those categories: the patterns that look reasonable on paper and fail in production, and the corresponding lessons that stick. Each anti-pattern reflects a failure mode teams report in real Copilot Studio deployments, and the corrections are the ones teams have actually applied.

### Anti-pattern 1 — The god agent

A single agent acquires, over months, fifty tools, nine knowledge sources, and an instruction block that bumps up against the 8,000-character limit and that nobody can fully read in one sitting. Orchestration quality degrades: the agent selects the wrong tools, cites the wrong documents, and occasionally rejects valid requests. The team adds more rules to the instructions to patch the symptoms.

**Why it happens.** Each addition seemed small at the time. Ownership was never explicit. Nobody had the authority to say no.

**Correction.** Split by domain into specialists. Apply the criteria in Part 1: tool count approaching 30-40, instruction length relative to the 8,000-character ceiling, number of owners, and SLA variance. The first split is the hardest; subsequent ones are routine.

**Lesson.** One agent, one domain, one owner. Enforce it at design review.

### Anti-pattern 2 — Prose contracts between agents

The Orchestrator calls the Ticket Writer, which returns "I created ticket INC-12345 for you." The Orchestrator then tries to extract the ticket ID with string matching. For six months, it works. Then someone rewrites the Ticket Writer's output to be more conversational, and every downstream integration breaks quietly.

**Correction.** Every called agent returns structured data. Copilot Studio supports this natively; both connected and A2A agents allow structured outputs. Make this mandatory at the design-review stage.

**Lesson.** Structured in, structured out. Prose is for users, not for agents.

### Anti-pattern 3 — Silent retries

The calling agent retries a failed call after a timeout. The called agent had actually succeeded; the failure was a network blip. The result: two tickets, two emails, two meeting invitations. Over a quarter, thousands of duplicate issues accumulate, and nobody notices until the project management tool begins to degrade under the volume.

**Correction.** Every write-capable tool accepts an idempotency key, and the backend uses it to deduplicate. The calling agent generates a stable key per logical operation (typically based on the conversation ID and the step name) and passes it on retries.

**Lesson.** Retries are a first-class design concern. Idempotency is not optional for writes.

### Anti-pattern 4 — Unscoped credentials

Every MCP server, every connector, and every agent uses the same service principal. First breach compromises everything. Rotation is impossible without downtime.

**Correction.** Entra Agent ID (introduced May 2025; expanded to public preview at Ignite 2025) gives each agent a first-class identity, and Copilot Studio can now auto-create one per agent *(preview)*. Grant permissions per agent, scoped to exactly what that agent needs. Use managed identities where supported. Rotate credentials per connection, not per tenant.

**Lesson.** Least privilege is a design input, not a post-deployment cleanup.

### Anti-pattern 5 — No state store

A multi-step orchestration relies on conversation history to remember where it is. Conversation history truncates. The orchestration loses its place, and the Orchestrator either restarts the process (producing duplicates) or abandons it (producing incomplete work).

**Correction.** Persist state in Dataverse. The `OnboardingCase` pattern from scenario four is the generalization: one row per case, columns for each step's status, with row-change events driving the Supervisor. Every specialist writes in their own columns.

**Lesson.** If the process outlives the conversation, so should the state.

### Anti-pattern 6 — Knowledge source overload

An agent is attached to 12 SharePoint sites, 6 uploaded files, 2 website URLs, and a Graph connector. Retrieval produces irrelevant passages. Cited answers are confidently wrong. Adding more sources makes it worse, not better. (Generative orchestration also caps SharePoint knowledge at 25 site URLs per agent, which is a hard reminder that more is not better.)

**Correction.** Scope knowledge tightly. One domain, one library. The case studies that cite retrieval quality as the winning factor — Dunaway, ABN AMRO, La Trobe University — all scoped narrowly. Where a second domain matters, that is usually a second specialist with their own knowledge.

**Lesson.** Retrieval quality is a function of signal-to-noise, not of source count.

### Anti-pattern 7 — Circular delegation

Agent A calls Agent B, who calls Agent A, who calls Agent B. The orchestrator executes until a timeout or token exhaustion. The bill arrives.

**Correction.** Specialists never call their parents back. If a specialist appears to need something the parent has, the parent should pass it down as an input. (Copilot Studio's one-level nesting rule — an agent with connected agents can't itself be a connected agent — limits but does not eliminate the risk.)

**Lesson.** Delegation is a tree, not a graph. Trees have no cycles.

### Anti-pattern 8 — Conversational autonomy

An autonomous agent is built as a chatbot that also runs on a schedule. The chatbot surface and the autonomous surface have different failure modes, and the team maintains both. When a user interrupts the autonomous run through chat, the state becomes inconsistent.

**Correction.** Autonomous agents have no chat surface. If users want visibility, build a report on top of the state store. Chat is a separate agent if it is needed at all.

**Lesson.** Autonomy is a different product shape from conversation. Do not combine them in one agent.

### Anti-pattern 9 — Ignoring the security posture of inputs and called agents

Two failure modes share one root cause: trusting content the agent did not author. In the first, an A2A agent from a partner is added to the tool list; six months later, a vulnerability in the partner's agent lets its conversation context leak through its outputs. In the second — the one Microsoft assigned a CVE to — an attacker placed instructions in a SharePoint form field that an autonomous agent ingested as authoritative context. Microsoft assigned **CVE-2026-21520** (CVSS 7.5) to that indirect prompt-injection issue, patched it in January 2026, and publicly disclosed it in April 2026. Notably, the injected instruction exfiltrated data through a *legitimate* Outlook action, so DLP never fired. Both cases prove the same point: every input an agent trusts — a partner agent's output, a form field, a retrieved document — expands the attack surface.

**Correction.** Treat external agents as supply chain dependencies: review their security posture, scope their access narrowly, log their calls, and rotate credentials. Treat trigger and retrieval inputs as untrusted: validate payloads, and never let free-text content override the agent's instructions.

**Lesson:** Defense-in-depth is necessary; agent composition is not safe by default. The LLM cannot reliably tell trusted instructions from untrusted data — so the boundary has to be enforced around it.

### Anti-pattern 10 — Measuring the wrong thing

A team reports "the agent answered 10,000 questions this month." That is a count, not an outcome. The team does not know how many answers were correct, how many resolved the user's underlying need, or how many caused follow-up work.

**Correction.** Measure outcomes: auto-resolution rate, user confirmation of correctness, downstream ticket creation, time-to-resolution. Copilot Studio's analytics surface, combined with data in the relevant business systems, supports these measurements.

**Lesson.** Volume is not value.

### Recommendations that follow

Pulling the corrections together:

- **Architecture.** One agent per domain. Separate read from write. Tree, not graph.
- **Contracts.** Structured inputs and outputs. Explicit error contracts. Idempotency keys on writes.
- **Security.** Scoped credentials. Entra Agent ID per agent. Validate untrusted inputs. Audit everything. Review external agents like you review external vendors.
- **Operations.** State in Dataverse. Outcome metrics, not volume metrics. Ownership per agent, reviewed quarterly.
- **Standards.** MCP for tools. A2A for agents across platforms (GA since April 2026). Connected agents for Copilot Studio–native specialists. Child agents for subroutines inside a parent.

---

## 8. What Copilot Studio gives you today, one more time

Every capability used across Parts 1 and 2 of this series is available now, with preview status noted where it applies:

- Generative orchestration with tool selection.
- Child, connected, and A2A agents (A2A generally available since April 2026; connections to Microsoft Foundry, Fabric, and M365 Agents SDK agents in public preview).
- MCP server integration with Streamable transport (SSE no longer supported after August 2025).
- Autonomous agents with documented Dataverse, SharePoint, OneDrive, Planner, and Recurrence triggers; an HTTP request trigger and cloud flows extend the catalog where a native trigger does not yet exist.
- Agent flows with parallel branches and approval gates — and a redesigned Workflows experience in early release, with agent nodes and asynchronous responses *(preview)*.
- Computer Use (computer-using agents), generally available since May 2026.
- Dataverse as a governed state store.
- Entra Agent ID (per-agent auto-creation in preview), Copilot Hub, the agent inventory schema *(preview)*, Microsoft Agent 365, and the Copilot Control System for governance.
- Purview audit across agent activity.

Nothing in this series required features that do not exist. The gap between "possible today" and "in production somewhere" is smaller than the marketing noise suggests. The gap between "possible" and "in production well" is larger — and the anti-patterns above are the ones that close it.

## Conclusion

If you take five things away from this article, they are these.

First, **the four patterns are not abstractions; they have concrete shapes you can copy**. Router-worker is the IT triage scenario: classification, delegation, structured returns. Parallel fan-out is the contract review scenario: independent specialists with scoped knowledge, merged outputs. Router-worker with an autonomous trigger is the field service scenario: a clean event, a bounded decision tree, no human in the loop. Hierarchical with persistent state is the employee onboarding scenario: a supervisor that reads from a Dataverse table, specialists that update their own columns, and SLA monitoring that escalates when work is stuck.

Second, **state is the architecture for anything long-running**. Dataverse is the right place for it. Conversation history is not. Every hierarchical and event-driven design in this article depends on a state table whose columns are the contract between the agents. Model it carelessly, and the whole system is fragile; model it well, and the supervisor becomes trivial.

Third, **MCP is a platform decision, not an agent decision**. The inventory in section 6 is a starting point because the question of which server owns which domain must be answered once by the platform team, with the consuming agents in mind. Mega-servers and one-off wrappers both recreate the problems MCP exists to solve. Domain ownership and read/write separation are the load-bearing rules.

Fourth, **the ten anti-patterns are observations, not predictions**. Each reflects a failure mode teams hit in shipping deployments. The god agent, prose contracts, silent retries, unscoped credentials, no state store, knowledge overload, circular delegation, conversational autonomy, ignored security posture, and measuring volume instead of outcomes — these are the failure modes a design review should explicitly check for.

Fifth, **the measure of a multi-agent system is not how clever any single agent is — it is how boring each agent can become**. Boring agents — narrow, owned, tested, well-described — compose into systems that deliver outcomes reliably. The four scenarios above each succeed because their specialists do one thing, do it well, and stop. The inventory and the anti-patterns exist to keep them that way.

Multi-agent orchestration is not a novelty. It is the shape enterprise AI takes when it grows beyond a single use case. Copilot Studio is one of the platforms where that shape is now routine to build, with two open standards (MCP and A2A) that keep it composable and a governance surface that keeps it safe to operate. Part 1 settled the architectural decisions; Part 2 worked through what they look like when executed. The rest is the discipline of doing it well — and that, as it turns out, is the part that takes practice.

## Sources

- Microsoft Learn — [Explore multi-agent orchestration patterns](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/multi-agent-patterns)
- Microsoft Learn — [Add other agents (overview)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/authoring-add-other-agents) — child vs connected agents; preview status of Foundry/Fabric/M365 Agents SDK connections
- Microsoft Learn — [Quotas and limits](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-quotas) — 8,000-character instruction limit; 25 SharePoint sites under generative orchestration
- Microsoft Learn — [Design autonomous agent capabilities](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/autonomous-agents) — autonomous agents GA, March 2025
- Microsoft Learn — [Event trigger overview](https://learn.microsoft.com/en-us/microsoft-copilot-studio/authoring-triggers-about) — documented event triggers (SharePoint, OneDrive, Planner, Recurrence, Dataverse row-change)
- Microsoft Learn — [What's new in Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/whats-new) — A2A GA (April 2026), Computer Use GA (May 2026), new Workflows experience, async agent-flow responses (preview), per-agent Entra identities (preview), agent inventory schema (preview)
- Microsoft Learn — [Connect your agent to an existing Model Context Protocol (MCP) server](https://learn.microsoft.com/en-us/microsoft-copilot-studio/mcp-add-existing-server-to-agent)
- Microsoft Learn — [Connect an agent available over the Agent2Agent (A2A) protocol](https://learn.microsoft.com/en-us/microsoft-copilot-studio/add-agent-agent-to-agent)
- Microsoft Learn — [Copilot Studio real-world transformation stories](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/adoption-case-studies) — T-Mobile, Nexi Group, A1 Inteligência em Viagens, Dunaway, Signetic, Holland America Line, Singapore Civil Defence Force, La Trobe University, ABN AMRO, Rabobank
- Microsoft Learn — [ServiceNow connector reference](https://learn.microsoft.com/en-us/connectors/service-now/)
- Microsoft Learn — [Power Platform connectors reference](https://learn.microsoft.com/en-us/connectors/connector-reference/)
- Microsoft Learn — [Copilot Hub in the Power Platform Admin Center](https://learn.microsoft.com/en-us/power-platform/admin/copilot/copilot-hub)
- Microsoft Learn — [Copilot Control System overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/copilot-control-system/overview)
- Microsoft CopilotStudioSamples — [Dynamic MCP Routing in Copilot Studio](https://microsoft.github.io/mcscatblog/posts/dynamic-mcp-routing-copilot-studio/)
- Model Context Protocol — [Official specification and SDKs](https://modelcontextprotocol.io/)
- Agent2Agent protocol — [Open specification](https://a2aproject.github.io/A2A/)
- VentureBeat — [Microsoft patched a Copilot Studio prompt injection. The data exfiltrated anyway.](https://venturebeat.com/security/microsoft-salesforce-copilot-agentforce-prompt-injection-cve-agent-remediation-playbook) — CVE-2026-21520 (CVSS 7.5, "ShareLeak"), patched January 2026, disclosed April 2026
- Pragmatiq — [12 Practical Use Cases for Microsoft Copilot Studio](https://www.pragmatiq.co.uk/12-practical-use-cases-for-microsoft-copilot-studio/)
- Holger Imbery — [Copilot Studio Multi-Agent Orchestration (original 14-part series)](https://holgerimbery.blog/multi-agent-orchestration)
