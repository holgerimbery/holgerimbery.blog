---
layout: post
title: "Multi-Agent Orchestration in the New Copilot Studio: The Agent Harness, the Agentic Loop, Skills, and Connected Agents"
description: A long-form guide to building multi-agent systems in the rebuilt Copilot Studio — how the new agentic orchestrator's coding harness and agentic loop change the work, how Skills become the shared behavior layer, and how Connected agents, A2A, and MCP compose a fleet in the new experience.
date: 2026-08-22
author: admin
slug: copilot-studio-orchestration-new-experience
canonical_url: https://holgerimbery.blog/copilot-studio-orchestration-new-experience
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/08/nasik-lababan-pKbePv-7V10-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@nasik?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Nasik Lababan</a> on <a href="https://unsplash.com/photos/people-work-at-computers-under-a-decorative-shelf-pKbePv-7V10?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
tags:
  - agents
  - copilotstudio
  - multiagent
  - orchestration
  - mcp
  - a2a
  - skills
  - agentharness
  - build2026
featured: false
toc: true
---

{: .q-left }
> **Summary lede.** The earlier articles in this series built multi-agent systems on the *classic* Copilot Studio — generative orchestration, the five surfaces, child agents, and the four orchestration patterns. This one rebuilds the same subject on the *new* Copilot Studio experience from Build 2026: the **new agentic orchestrator**, its **coding harness and agentic loop**, **Skills** as a reusable behavior layer, **Connected agents** as the delegation surface, and the two open standards — **A2A** for agents and **MCP** for tools — that keep the whole thing composable. The load-bearing architectural ideas do not change. Where they live, how the orchestrator combines them at runtime, and where the *first* wall you hit moves to — those do.

{: .q-left }
> **Capability status at publication.** Precision matters here, because the new-experience surfaces sit at different maturity levels. The **new agent experience is a production-ready preview**; the **new workflows experience is public preview** and, per Microsoft, not for production. Within the new agent experience today, **Connected agents currently supports only other Copilot Studio agents** (Microsoft Learn, *Connected agents overview (preview)*). Separately, in the broader Copilot Studio multi-agent stack, **A2A, Microsoft Fabric, and Microsoft 365 Agents SDK connections reached general availability** in the April 2026 wave, and **A2A itself has been GA since April 2026**. **Work IQ** and **Memory** are **preview**; **Claude Sonnet 5** and **GPT-5.5 Chat** are **GA** model choices. Treat every "new experience" capability as preview unless noted, and re-check status before committing a production design to it.

{: .q-left }
> **Why read this**
Read this if you designed a multi-agent system on the classic experience — a router with connected agents, a Dataverse-backed supervisor, an MCP tool catalog — and then opened the new experience to find four tabs, a "Skills" surface where child agents used to be, and an orchestrator that plans instead of routes. Nothing in the classic articles is wrong for classic agents. But the compositional choices are different now, and the reasons to split an agent have shifted. Read it before you start a new multi-agent build in the new experience, so you put behavior in Skills, delegation in Connected agents, actions in Tools and MCP, and cross-platform reach in A2A — from the first design review, not the third.

---

## 1. The shift: from routing tables to an agentic loop

In the classic experience, a multi-agent system was, at heart, a routing problem. A thin parent agent classified each request and handed it to a specialist; generative orchestration ranked the candidate tools and agents and picked one; the specialist did its work and returned. The architecture the earlier articles describe — router-worker, sequential pipeline, parallel fan-out, hierarchical — is a taxonomy of *how requests move between agents*.

The new experience keeps every one of those shapes, but it changes the engine underneath them. The classic model asked the maker to design the movement. The new model hands a goal to an orchestrator that **plans, acts, observes the result, and revises** — an *agentic loop* rather than a routing table. The consequence for multi-agent work is specific and worth stating up front: the orchestrator can now carry more of a multi-step task inside a *single* agent's run before you need to decompose it into several. The reasons to split are the same ones the earlier articles named — distinct owners, conflicting knowledge, divergent SLAs, reuse across parents — but **tool count is less likely to be the first wall you hit**, because the loop, not a flat tool-ranking pass, is doing the work.

That is the through-line of this article. Multi-agent orchestration in the new experience is still about narrow agents with clear ownership, structured contracts between them, and state that outlives the conversation. What changed is the *runtime* they compose on. So this article starts with the runtime.

## 2. The agent harness and the agentic loop

Microsoft describes the new experience as being built on a **new agentic orchestrator** — in its own words, on *"a new coding harness and CLI layer,"* with *"stronger instruction adherence and long-horizon task execution,"* support for **recursive task execution**, the ability to *"process large volumes of content,"* and to *"produce rich file outputs."* Microsoft Learn frames it as an **enhanced orchestration runtime** that improves reasoning and response quality, *particularly over Microsoft 365 data* — and, unlike the classic experience, this runtime is **not configurable**: every agent in the new experience uses it. What *is* configurable is the primary model beneath it (**Claude Sonnet 5** and **GPT-5.5 Chat** are GA choices).

Two words in that description carry most of the weight — *harness* and *loop* — and they come straight from how modern coding agents are built. It is worth being precise about what they mean, because the whole multi-agent design rests on them.

### What a "harness" is

A **harness** is the scaffolding around the model that turns a next-token predictor into something that can act. It holds the tool definitions, injects the results of tool calls back into context, manages the context window, and decides when a run is finished. The model reasons and chooses actions; the harness *executes* those actions against the real world and feeds back real observations. Anthropic's Claude Code and GitHub Copilot's agent mode are the reference implementations of this shape — which is exactly why Copilot Studio can **import existing GitHub Copilot and Claude Code skills**: the new orchestrator is built to consume that ecosystem's conventions.

### The loop at a glance

Every agentic runtime, Copilot Studio's included, runs a variation of the same cycle. Anthropic's own description of the Claude Code agent loop is the clearest statement of it: the agent *"evaluates your prompt, calls tools to take action, receives the results, and repeats until the task is complete."* Generalized:

```text
receive goal   ->  the orchestrator gets the user goal, instructions,
                   skill/tool/agent descriptions, and history
reason         ->  it decides the next step (respond, call a tool,
                   load a skill, or delegate to a connected agent)
act            ->  the harness executes that step
observe        ->  the real result feeds back into context
repeat         ->  reason/act/observe cycle continues...
return         ->  ...until the orchestrator produces a response with
                   no further actions, then returns the result
```

![The agentic loop inside the harness: a goal enters, then a Reason–Act–Observe cycle repeats until the run returns.](images/2026/08/01-agentic-loop.png)
*Figure 1 — The agentic loop. A goal enters the harness; the orchestrator reasons, acts (through tools, skills, and connected agents), and observes the real result, repeating until nothing remains to do and it returns.*

Each full reason-act-observe round trip is a **turn**. A quick question resolves in a turn or two; a long-horizon task — "review these three contracts, draft the memo, and file the exceptions" — can chain many turns, the orchestrator adjusting after each observation. This is the same *observe → plan → act → verify* pattern the wider industry calls the **agentic loop**, formalized by the ReAct approach (interleaving reasoning and acting) and its Plan-Act-Reflect descendants. The power of the loop is that observations are *real*: the orchestrator is reasoning over what actually happened, not what it guessed would happen.

### Why long-horizon and recursive execution matter for multi-agent

Two of Microsoft's stated gains — **long-horizon** and **recursive task execution** — are the ones that reshape multi-agent design. "Long-horizon" means the loop can sustain a coherent multi-step task across many turns without losing the thread. "Recursive" means it can decompose a task into sub-tasks and work each one, rather than committing to a single up-front plan. In the classic model, you often reached for a second agent — or a Dataverse-backed supervisor and an agent-flow — precisely because a single generative-orchestration pass could not hold a long, branching task together. In the new model, some of that decomposition happens *inside one agent's loop*. You still split for ownership, isolation, and reuse; you split less often merely to fit the work.

### The failure modes come with the loop

A loop that can act repeatedly can also loop *wrongly*. The failure modes are well understood and they are the same ones any harness engineer worries about: **infinite loops** (the orchestrator never decides it is done), **derailment** (an early wrong action sends the run down an unrecoverable path), **spurious tool calls** (acting without a real need), and **context growth** (each turn adds tokens). These are not reasons to avoid the loop — they are the reasons the classic-article disciplines still apply, and apply *more*: structured contracts so an agent knows when a step truly succeeded, idempotency so a retried action does not double-fire, and bounded delegation so agents do not call each other in a cycle. Section 10 returns to this; for now, the point is that the harness gives you power *and* a new class of thing to get wrong.

## 3. The four surfaces as a multi-agent toolkit

The new experience assembles an agent from a small set of capability components — **Skills, Tools, Knowledge, Connected agents**, complemented by **Memory** (preview) — and the orchestrator decides at runtime how to combine them. For multi-agent work, the useful move is to read each surface as a distinct *role in a system of agents*:

| Surface | Multi-agent role | The question it answers |
|---|---|---|
| **Skills** | The **shared behavior layer** — reusable procedural expertise loaded on demand, portable across many agents | *How* should any agent approach this class of task? |
| **Tools** | The **action layer** — connectors, Power Automate flows, and **MCP servers** (including Work IQ MCP tools) | What can an agent *do* to external systems? |
| **Knowledge** | The **grounding layer** — SharePoint, Dataverse, files, and **Microsoft IQ** sources | What can an agent *retrieve* to ground its decisions? |
| **Connected agents** | The **delegation layer** — hand work to another agent that runs its own loop | Which *specialist* owns this domain? |
| **Memory** *(preview)* | The **continuity layer** — per-user, per-agent learned context across sessions | What should an agent *remember* about how this person works? |

The classic articles taught that "the five surfaces are not interchangeable" — putting deterministic compliance flows in generative nodes, or large rule tables in the instruction block, was the most common cause of unreliable agents. The same discipline holds, sharpened by one addition: **Skills** now give procedural behavior a dedicated home it never had in the classic model, and **Connected agents** are the only cross-agent surface you need to reason about, because child agents are gone as a distinct concept. The clean question for any behavior becomes: *general identity* → Instructions; *task-specific procedure* → Skill; *reference information* → Knowledge; *external action* → Tool; *specialist ownership* → Connected agent; *learned continuity* → Memory.

![Five capability surfaces around one agent: Skills, Tools, Knowledge, Connected agents, and Memory.](images/2026/08/02-five-surfaces.png)
*Figure 2 — Five capability surfaces, read as roles in a system of agents: Skills (behavior), Tools (action), Knowledge (grounding), Connected agents (delegation), and Memory (continuity).*

## 4. Skills: the shared behavior layer for a fleet of agents

In a single-agent build, Skills solve instruction bloat. In a *multi-agent* build, they do something more strategically important: they become the **reusable expertise layer shared across the fleet**. Multiple agents — HR, finance, procurement, service desk — can all load the same `executive-summary` skill, the same `risk-classification` skill, the same `policy-compliance-review` skill. Behavior written once travels to every agent that needs it.

### The mechanics, briefly

A Skill is a Markdown file — YAML front matter (`name`, `description`) plus a Markdown body of instructions, examples, and rules — packaged, when it needs more than instructions, as a ZIP containing a `SKILL.md` and optional scripts, templates, and reference files. Copilot Studio's format is the **Agent Skills open format, an open standard originally developed by Anthropic**, and the same anatomy appears in Claude and in GitHub Copilot / Visual Studio 2026 (the `agentskills.io` spec). That is why skills are portable across runtimes, and why Copilot Studio can import the ones your teams already have.

The runtime keeps only the **name and description** of each skill in context by default and loads the full body **on demand** when a request matches — *progressive disclosure*. Ten skills cost you ten short descriptions per turn, not ten full instruction sets. In a multi-agent system, that context economy compounds: a shared skill library can be large without any single agent paying for the skills it never uses.

### A skill is routing metadata, twice over

The classic articles' rule about tool descriptions transfers verbatim, and then applies a second time. A skill's **description is routing metadata for the orchestrator**, not a human comment — a vague description loads unpredictably; a precise one ("Validates an expense code against the FY26 policy matrix; use when the user submits or questions an expense line") loads when it should. In a multi-agent build there is a second routing decision layered on top: the *primary* agent's orchestrator decides whether to handle a request itself (loading a skill) or delegate to a connected agent. Well-scoped skills and well-scoped connected-agent descriptions are what keep those two decisions from fighting each other.

A representative shared skill:

```markdown
---
name: incident-summary
description: Writes a customer-facing incident summary from an internal
  timeline. Use when an agent must turn raw incident notes into a concise,
  non-technical summary with impact, cause, and next steps.
---

# Objective
Produce a short, factual incident summary a non-technical customer can read.

# Process
1. Extract the impact window and who/what was affected.
2. State the cause in one plain sentence; separate cause from speculation.
3. List remediation already done and next steps with owners.
4. Keep it under 150 words; no internal jargon, no blame.

# Rules
- Never invent a root cause. If cause is unconfirmed, say "under investigation."
- Never include internal system names or ticket IDs.
- Lead with impact, not chronology.
```

Any agent in the fleet — the service desk orchestrator, the major-incident supervisor, the customer-comms agent — can load this one skill. When the house style changes, it changes in one file. That is the payoff, and the risk: **a poorly written skill propagates flawed behavior across every agent that uses it**, so shared skills belong in version control, behind pull requests, with named owners — the *Behavior as Code* operating model the reimagined article describes. Microsoft's Customer Advisory Team ships a public **CAT Agent Skills** gallery of drop-in examples for exactly this; treat an imported skill like any third-party dependency — read it, test it, version it before you trust it.

### Skills versus connected agents — the boundary that matters most

Because both are ways to "add capability," teams conflate them. The distinction is the single most important one in a multi-agent build:

- A **Skill** is *reusable behavior* with **no ownership boundary**. It runs *inside the calling agent's loop*, in that agent's context, under that agent's identity and permissions.
- A **Connected agent** is a *specialist with an ownership boundary*. It runs its **own loop**, in its **own orchestration context**, with its own instructions, knowledge, tools, and — critically — its own owner and lifecycle.

The rule of thumb: **Skills define reusable behavioral patterns; Connected agents define ownership boundaries.** If two teams must independently own, publish, and secure a capability, it is a connected agent. If it is a way of doing something that many agents should share, it is a skill. Getting this wrong is the new-experience version of the classic "god agent": either everything collapses into one agent stuffed with skills, or every skill becomes a needless connected agent with its own governance surface.

![Skills run inside the calling agent's loop; a connected agent runs its own loop across an ownership boundary.](images/2026/08/03-skills-vs-connected-agents.png)
*Figure 3 — The boundary that matters most. A Skill is reusable behavior that runs inside the calling agent's loop, with no separate owner; a Connected agent is a specialist with its own loop, its own owner, and its own tools and knowledge.*

## 5. Connected agents in the new experience

Connected agents are the delegation surface. Microsoft Learn's *Connected agents overview (preview)* describes the runtime precisely, and it is worth reading closely because the mechanics differ in one important way from the classic experience.

**How it works.** The primary agent's **orchestration runtime evaluates each user message**. When a request aligns with a connected agent's domain, the primary **delegates**. The connected agent then **runs in its own orchestration context, with its own instructions, knowledge, and tools** — its own loop, in other words. The primary sends the **relevant conversation history and the user message**; the connected agent processes the request and **returns a response to the primary**, which presents it to the user. This is the classic articles' "each connected agent runs its own orchestration layer" principle, now made explicit in the new-experience documentation.

**What it buys you** is exactly what the earlier articles argued: **specialization** (each agent focuses on one domain), **reusability** (a specialist can be connected to multiple primaries), **separation of concerns** (different teams own different agents), and **scalability** (add a capability by connecting an agent rather than swelling one agent's instructions).

**The current constraint — state it plainly.** In the new agent experience today, *"you can currently only connect other agents built in Copilot Studio."* That is a meaningful limit and a moving target: reaching a Foundry agent, a Fabric agent, an M365 Agents SDK agent, or a third-party agent over A2A is done through Copilot Studio's broader multi-agent stack (Section 6), and those connection types are GA there — but the new-experience *Connected agents* surface itself currently lists Copilot Studio agents only. Design for it, and re-check the status before you assume a cross-platform specialist can be wired in as a new-experience connected agent.

**Configuring one.** On the primary agent, open **Connected agents → Add**, select the target Copilot Studio agent, and — this is the load-bearing step — write a description of *when the primary should delegate to it*. That description, distinct from the target agent's own description, is what the orchestrator routes on. Keep the input minimal and prefer structured returns to prose, for the same reason the classic articles gave: an orchestrator parsing "I created ticket INC-12345 for you" breaks the first time the wording changes.

A minimal router-style primary, expressed as instructions plus delegation:

```text
You are the service desk front door. You do not resolve issues yourself
and you never mention specialist agents to the user.

Delegate:
  - Password, VPN, and access problems  -> IT Support agent
  - Expense and reimbursement questions -> Finance agent
  - Anything about hardware orders       -> Procurement agent

Load the "incident-summary" skill only when the user asks for a
customer-facing write-up of an issue.
Present each specialist's structured result to the user in plain language.
```

Note what is *not* here: no runbook logic, no connector calls, no policy text. The primary holds routing and a short identity; each specialist holds its own knowledge, tools, and owner. That is the whole discipline — the front door stays thin, and each connected agent stays boring.

## 6. Reaching beyond Copilot Studio: A2A, Foundry, Fabric, and the M365 Agents SDK

A fleet that lives entirely inside one Copilot Studio tenant rarely stays that way. Data teams build Fabric agents; platform teams build pro-code agents with the Microsoft 365 Agents SDK or on Microsoft Foundry; partners expose agents as services. The April 2026 multi-agent wave is what makes those reachable, and Microsoft framed it directly: *"several multi-agent capabilities are rolling out to general availability,"* covering **Microsoft Fabric integration**, **Microsoft 365 Agents SDK orchestration**, and **Agent-to-Agent (A2A) communication** — *"all designed to help your agents operate together as a coordinated system rather than in isolated silos."*

### A2A in one paragraph

If MCP is how agents call *tools*, **A2A is how agents call other agents**. Microsoft's summary: *"With A2A support, Copilot Studio agents can directly communicate with and delegate work to other agents — first-party, second-party, or third-party — using an open protocol that allows universal access."* Compared with a generic HTTP connector, A2A is *more opinionated* (the contract is designed for agents, so multi-turn exchanges work natively), *more interoperable* (any framework that implements A2A can participate), and *richer in context* (the payload carries metadata — context IDs, identity, task parameters — the receiving agent can use for routing, personalization, and logging). As the Custom Engine team's A2A quickstart puts it, instead of *"calling an API,"* you are *"delegating a task to another agent."*

### Where A2A fits against connected agents

The decision rule from Part 1 still holds, updated for the new landscape:

- Both agents inside your Copilot Studio tenant → **connected agents** (the new-experience surface, Copilot Studio agents today).
- The other agent is a **Fabric** agent, a **Foundry** agent, an **M365 Agents SDK** agent, or a partner/third-party agent → reach it through Copilot Studio's **multi-agent connections**, with **A2A** as the open path for anything outside the Microsoft-native set.
- You want *your* agent callable from Copilot Studio, a custom app, *and* another vendor's orchestrator → **publish it as an A2A agent** and it becomes a reusable unit across clients.

They are not mutually exclusive. A realistic production system mixes them: a new-experience primary delegates to Copilot Studio connected agents for native specialists and reaches a Foundry- or SDK-built agent over A2A for the pro-code ones.

![A primary agent connects to Copilot Studio specialists, reaches external agents over A2A, and shared tools over MCP.](images/2026/08/04-composing-a-fleet.png)
*Figure 4 — Composing a fleet. A primary agent delegates to Copilot Studio connected agents in-tenant, reaches Foundry, Fabric, M365 Agents SDK, and partner agents over A2A, and calls shared tools — including Work IQ — over MCP.*

### The pro-code peer: Microsoft Agent Framework

The reason a Foundry or SDK agent slots in as a peer rather than a foreign object is convergence at the runtime and protocol layers. The **Microsoft Agent Framework (MAF)** — the unification of **Semantic Kernel and AutoGen** into one open, multi-language (.NET and Python) framework — is the pro-code harness on the other side of the A2A boundary. Its four pillars are **open standards** (MCP, A2A, OpenAPI), **research-grade orchestration patterns**, **extensibility**, and **production readiness** (OpenTelemetry, Entra ID, CI/CD). Its orchestration patterns — **sequential, concurrent, group chat, handoff,** and **magentic** (the MagenticOne pattern from AutoGen, where a manager dynamically assigns specialists to an open-ended task) — are the pro-code expression of the same shapes this article describes for Copilot Studio. The platform-team takeaway from the reimagined article is the one that matters: **standardize on the architecture — the protocols (MCP, A2A) and the grounding layer (Microsoft IQ) — not the authoring tool.** Let low-code teams use Copilot Studio and pro-code teams use Foundry/MAF, knowing the agents interoperate over A2A.

## 7. Tools and MCP in the new experience

Delegation moves work between *agents*; MCP moves *tools* between agents. In the new experience, MCP servers are added on the **Tools** surface, and everything the classic articles said about MCP still applies: one server per domain owned by the team that owns the backend, discovered automatically, consumed by many agents, with the tool *description* as the production variable the orchestrator routes on. The Streamable transport is current; write-capable servers get idempotency keys and audit; read and write are best split into separate servers with separately scoped credentials.

What the new experience adds is **Microsoft IQ as a first-class tool and knowledge source**, delivered as MCP. You add **Work IQ MCP tools** — *Work IQ Mail*, *Work IQ Calendar*, *Work IQ Teams* — via **Tools → Add tool → Model Context Protocol**, giving an agent real-time Microsoft 365 work context (files, emails, meetings, chats) routed through the Agent 365 MCP gateway, always within the signed-in user's permissions. Work IQ requires a Microsoft 365 Copilot license, is **preview** today with GA "coming soon," and moves to **usage-based billing at GA** — so budget for that before you lean on it. Alongside Work IQ sit **Fabric IQ** (business data and analytics) and **Foundry IQ** *(preview)* (enterprise knowledge bases indexed by Azure AI Search). For a multi-agent fleet, Microsoft IQ is the shared grounding layer that keeps every agent's answers consistent with the same organizational context — the knowledge-and-tools analogue of a shared skill library.

MCP also reaches into the **new workflows experience** (public preview): a workflow can call MCP-server tools directly, and drop existing agents onto the canvas as **agent nodes** — the cleanest expression of "deterministic where you need it, agentic where it adds value."

## 8. The orchestration patterns, revisited

The four patterns from the classic articles survive the rebuild intact — the reimagined and rebuild articles both say so — but they now have a more direct home, and it is worth seeing how each maps onto the new surfaces (and onto the MAF patterns on the pro-code side).

| Pattern | New-experience expression | MAF analogue |
|---|---|---|
| **Router-worker** | A thin primary agent that delegates to **connected agents** by description; the orchestrator does the routing | **Handoff** |
| **Sequential pipeline** | A **workflow** of ordered nodes — agent nodes and AI actions — with human-review nodes at decision points | **Sequential** |
| **Parallel fan-out / fan-in** | Parallel workflow branches of agent nodes joined by an aggregation step | **Concurrent** |
| **Hierarchical (supervisor)** | A supervisor **workflow** invoking agent nodes, persisting durable state in **Dataverse**, with **Memory** carrying cross-session continuity | **Magentic** / **Group chat** |

![Four orchestration patterns: router-worker, sequential, parallel fan-out, and hierarchical.](images/2026/08/05-four-orchestration-patterns.png)
*Figure 5 — The four orchestration patterns, unchanged by the rebuild: router-worker (handoff), sequential (pipeline), parallel fan-out (concurrent), and hierarchical (supervisor).*

Two things change in practice. First, the **agentic loop absorbs the simplest cases**: a request that once needed a router plus two specialists may now be one agent that loads two skills and calls two tools within a single run — split it into agents only when ownership or reuse demands it, not reflexively. Second, **deterministic control moves to workflows**. In the classic model, deterministic logic often *carried* the conversation (topics, agent-flows). In the new model, deterministic logic becomes the **guardrail and execution backbone around an agentic core** — approvals, state transitions, and compliance checks live in workflows, while the reasoning lives in the loop. The pattern you choose is still a design decision the platform does not make for you; what changed is that the boring parts are more clearly separated from the adaptive parts.

## 9. A worked example: contract intake, rebuilt in the new experience

To make the mapping concrete, take the parallel-fan-out contract-review scenario from Part 2 and rebuild it natively. The goal is unchanged — turn an inbound vendor contract into a merged review memo — but the assembly is new.

- **Primary agent (front door).** A new-experience agent whose Instructions say only "you own contract intake; you do not perform legal, financial, or risk analysis yourself." It loads a shared **`clause-extraction`** skill and a shared **`review-memo`** skill (both reusable across other legal-ops agents), and it delegates the three reviews.
- **Three connected agents** — **Legal**, **Finance**, **Risk** — each a separately owned Copilot Studio agent with its **own scoped Knowledge** (its policy library and nothing else) and its own loop. Each returns a structured issue list (`clause_type`, `severity`, `citation`, `suggested_redline`).
- **A workflow** (new workflows designer) runs the three reviewers as **parallel agent nodes**, joins them, and routes the merged memo to a **human review/approval node** — the deal owner decides what to act on. The system surfaces issues; a person retains authority.
- **Tools via MCP.** Clause extraction is backed by a document-operations **MCP server** shared across the tenant; the memo is filed via a connector. If a reviewer needs live deal context — the counterparty's recent emails, the meeting where terms were discussed — **Work IQ MCP tools** supply it within the user's permissions.
- **Memory and state.** Durable case state — which contracts are in flight, each review's status — lives in **Dataverse**, exactly as before ("if the process outlives the conversation, so should the state"). **Memory** carries the lighter, learned continuity: this reviewer prefers high-severity items first, that business unit always asks about auto-renewal.

The shape is identical to the classic version; the difference is that the shared behavior (`clause-extraction`, `review-memo`) is now portable across every legal-ops agent instead of duplicated, the reviewers are cleanly owned, and the deterministic join-and-approve lives in a workflow rather than an agent-flow bolted onto a generative core.

## 10. Governance and the harness's new risks

Every governance discipline the earlier articles established still applies — **Entra Agent ID per agent** (auto-creatable, so permissions are scoped per agent, not per maker), **least privilege**, **structured contracts**, **idempotency on writes**, **audit through Purview**, and treating external agents as **supply-chain dependencies**. The rebuild routes new capabilities through **Agent 365** governance in the Microsoft 365 admin center, with tool-call tracing available in **Microsoft Defender** Advanced Hunting; the **Agent 365 SDK is GA**, though several surrounding capabilities remain preview, so don't blanket-label all of Agent 365 as GA. What the agentic loop adds is a small set of *new* risks that a multi-agent design review should check for explicitly.

- **Runaway loops and cost.** A harness that acts until it decides it is done can, misconfigured, not decide. Bound it: cap turns and budget where the platform allows, keep delegation a **tree, not a graph** (a connected agent never delegates back into its caller), and prefer single-turn delegation to open-ended multi-turn exchanges unless the task genuinely needs them.
- **Untrusted observations.** The loop's power is that observations are real — which means a *poisoned* observation is real input, too. A retrieved document, an A2A partner's response, or a Work IQ mail body is data the agent did not author. This is precisely the surface that **CVE-2026-21520 ("ShareLeak," CVSS 7.5)** exploited: an instruction placed in a SharePoint form field was ingested as authoritative context and exfiltrated data through a *legitimate* Outlook action, so DLP never fired (patched January 2026, disclosed April 2026, and still the relevant disclosure). The loop does not change the lesson; it raises the stakes, because an agent that acts on every observation has more places to be misled. Validate payloads; never let free-text content override instructions.
- **Skills as a propagation surface.** A shared skill is reusable behavior — and reusable *misbehavior*. In the classic world, bad logic was trapped in one topic or one bot; in the new world it scales to every agent that loads the skill. Version-control shared skills, review high-impact ones with security and compliance, keep descriptions precise and testable, and avoid broad overlapping skills that compete for activation.
- **The new-experience status itself is a risk input.** The agent experience is a production-ready preview; the **workflows** experience is public preview and *not* for production; connected agents in the new experience currently reach only Copilot Studio agents; Work IQ moves to consumptive billing at GA. None of these is a reason to avoid the new model — but each is a reason to keep classic as a fallback for the capabilities you depend on until they reach GA.

## Conclusion

If you take five things away from this article, they are these.

First, **the runtime changed, the architecture did not.** Multi-agent orchestration in the new experience is still narrow agents with clear ownership, structured contracts, state that outlives the conversation, and least-privilege governance. The **agentic loop** — plan, act, observe, repeat — replaces the routing table, and the practical effect is that a single agent can carry more before you split it. You split for ownership, isolation, and reuse; you split less often just to fit the work.

Second, **Skills and Connected agents are the two compositional choices, and the boundary between them is the whole game.** Skills are reusable *behavior* with no ownership boundary, running inside the calling agent's loop. Connected agents are *specialists* with an ownership boundary, running their own loop. Behavior that many agents share is a skill; a capability two teams must independently own is a connected agent. Confusing the two rebuilds the god-agent problem in a new place.

Third, **A2A and MCP are still the two open standards that keep the system composable.** MCP centralizes tools per domain — now including Work IQ MCP for Microsoft 365 context. A2A makes cross-platform agent calls portable, and is GA. The honest nuance: within the new agent experience today, Connected agents reaches Copilot Studio agents only, so cross-platform reach runs through Copilot Studio's broader multi-agent stack — verify the surface before you design against it.

Fourth, **the four patterns survive, and deterministic control moves to workflows.** Router-worker, sequential, parallel fan-out, hierarchical — each maps onto connected agents plus the new workflow designer, and onto the Microsoft Agent Framework's handoff, sequential, concurrent, and magentic patterns on the pro-code side. Deterministic logic is no longer the thing carrying the conversation; it is the guardrail and backbone around an agentic core.

Fifth, **the loop gives you power and a new class of thing to get wrong.** Runaway loops, untrusted observations, and skills that propagate misbehavior are the harness-specific risks a design review must check — on top of every classic discipline, which all still hold. CVE-2026-21520 is the reminder that composition is not safe by default: the boundary between trusted instructions and untrusted data has to be enforced around the loop, because the loop will act on whatever it observes.

The classic articles settled how multi-agent systems are shaped and showed them executed. This one rebuilt that same discipline on the new engine. The names on the surfaces changed — Skills for behavior, Connected agents for delegation, a harness and a loop underneath — but the load-bearing decisions did not. Narrow agents, clear ownership, structured contracts, durable state, least privilege. The orchestrator got more capable. The discipline stayed the same.

## Sources

- Microsoft Learn — [Connected agents overview (preview): Microsoft Copilot Studio (new experience)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/authoring-add-other-agents) — how the primary agent's orchestration runtime routes to connected agents; "you can currently only connect other agents built in Copilot Studio"; production-ready preview status
- Microsoft Learn — [Agents overview (preview): Microsoft Copilot Studio (new experience)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/overview) — the four-surface model and the enhanced orchestration runtime
- Microsoft Learn — [Skills overview for agents (preview)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/skills-overview) — Agent Skills open format (originated by Anthropic), progressive disclosure, importing GitHub Copilot / Claude Code skills
- Microsoft Learn — [Memory (preview) for agents](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/memory-overview) — per-user, per-agent, tenant-scoped store; 28-day inactivity deletion
- Microsoft Learn — [Work IQ MCP overview (preview)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/use-work-iq) — Work IQ MCP tools; preview with GA "coming soon"; usage-based billing at GA; Agent 365 governance
- Microsoft Learn — [Microsoft IQ overview for agents (preview)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/use-microsoft-iq) — Work IQ, Fabric IQ, Foundry IQ as context sources
- Microsoft Learn — [What's new in Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/whats-new) — new agent experience (production-ready preview); Claude Sonnet 5 / GPT-5.5 Chat (GA); A2A GA (April 2026); Computer Use GA (May 2026)
- Microsoft Copilot Studio Blog — [New and improved: Multi-agent orchestration, connected experiences, and faster prompt iteration](https://www.microsoft.com/en-us/microsoft-copilot/blog/copilot-studio/new-and-improved-multi-agent-orchestration-connected-experiences-and-faster-prompt-iteration/) (Nitasha Chopra) — GA of multi-agent support for Fabric, the M365 Agents SDK, and A2A; the "Ask Microsoft" customer-zero example
- Microsoft Copilot Studio Blog — [Meet the new Copilot Studio: rebuilt for more complex, multi-step work](https://techcommunity.microsoft.com/blog/copilot-studio-blog/meet-the-new-copilot-studio-rebuilt-for-more-complex-multi-step-work/4526488) — new agentic orchestrator "built on a new coding harness and CLI layer"; long-horizon and recursive task execution; rich file outputs
- Anthropic — [How the agent loop works (Claude Agent SDK)](https://code.claude.com/docs/en/agent-sdk/agent-loop) — the reference shape of a coding-agent loop: evaluate, call tools, observe, repeat until no tool calls; turns and budget caps
- Anthropic — [Agent Skills overview (SKILL.md, YAML front matter, progressive disclosure)](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview) — the open Agent Skills format Copilot Studio imports
- Microsoft Developer Blogs — [Semantic Kernel: Multi-agent Orchestration](https://devblogs.microsoft.com/agent-framework/semantic-kernel-multi-agent-orchestration/) and Microsoft Learn — [Semantic Kernel Agent Orchestration](https://learn.microsoft.com/en-us/semantic-kernel/frameworks/agent/agent-orchestration/) — the sequential, concurrent, group chat, handoff, and magentic patterns
- GitHub — [microsoft/agent-framework](https://github.com/microsoft/agent-framework) — the Microsoft Agent Framework (Semantic Kernel + AutoGen), graph-based orchestration, A2A/MCP support, HarnessAgent
- The Custom Engine (Microsoft) — [Quickstart: Connect an A2A Agent to Copilot Studio](https://microsoft.github.io/mcscatblog/posts/copilot-studio-a2a-multi-agents/) — A2A as task delegation with rich metadata; connecting Foundry, M365 SDK, and third-party agents
- Microsoft CAT — [CAT Agent Skills gallery](https://microsoft.github.io/cat-agent-skills/) — drop-in, open-format skills for Copilot Studio, Cowork, and Scout
- Microsoft Security Blog — [Microsoft Build 2026: securing code, agents, and models](https://www.microsoft.com/en-us/security/blog/2026/06/02/microsoft-build-2026-securing-code-agents-and-models-across-the-development-lifecycle/) — Agent 365, Entra, Purview, Defender for agent governance
- VentureBeat — [Microsoft patched a Copilot Studio prompt injection. The data exfiltrated anyway.](https://venturebeat.com/security/microsoft-salesforce-copilot-agentforce-prompt-injection-cve-agent-remediation-playbook) — CVE-2026-21520 ("ShareLeak," CVSS 7.5), patched January 2026, disclosed April 2026
- Parts 1–3 of this series and *Copilot Studio Reimagined* — the classic five-surface model, the four orchestration patterns, and the Build 2026 rebuild this article builds on
