---
layout: post
title: "Workflows in the New Copilot Studio: The Agent Node, the Deterministic Backbone, and Why Calling an Agent from a Flow Is a Real Evolution"
description: A long-form guide to the new workflows experience in Copilot Studio — how the redesigned canvas orchestrates deterministic actions and agentic reasoning together, what the agent node actually changes, and why calling an existing agent from inside a flow is the composition primitive the classic model was missing.
date: 26-09-29
author: admin
slug: copilot-studio-workflows-new-experience
canonical_url: https://holgerimbery.blog/copilot-studio-workflows-new-experience
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/08/c-shi-4L-XZM-Arqg-unsplash.jpg
image_caption: "Photo by <a href=\"https://unsplash.com/@sunnymoth?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText\">C. Shi</a> on <a href=\"https://unsplash.com/photos/messy-workspace-with-desk-papers-lamps-and-photos-on-wall-4L-XZM-Arqg?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText\">Unsplash</a>

  \ "
tags:
  - a2a
  - agentflows
  - agentnode
  - agents
  - automation
  - copilotstudio
  - mcp
  - orchestration
  - workflows
  - build2026
featured: false
toc: true
---


{: .q-left }
> **Summary lede.** The companion articles in this series built *agents* in the new Copilot Studio — the agentic orchestrator, the harness and loop, Skills as reusable behavior, Connected agents as delegation. This one turns to the other half of the platform: the **new workflows experience** (public preview), the **deterministic backbone**, and the **agent node** — the ability to drop an *existing* agent onto a workflow canvas as a first-class step. The headline claim is specific: **calling an agent from a flow is not a plumbing feature bolted onto Power Automate.** It is the composition primitive that ends the old either/or — fully structured *or* fully agentic — and lets a single canvas be deterministic where it must be and adaptive where it pays.

{: .q-left }
> **Capability status at publication.** Precision matters, because these surfaces sit at different maturity levels. The **new agent experience is a production-ready preview**; the **new workflows experience is public preview** and, per Microsoft, *"aren't meant for production use."* The **classic agent flows experience is generally available** (GA since 31 March 2025) and remains the supported automation experience. The **new orchestrator** (Microsoft reports *"improving evaluation performance by approximately 20% while decreasing net token usage by 50%"*) is rolling through **early release environments**, applied automatically. **Computer-using agents are GA**; embedding them into multi-step workflows is *"now moving into preview."* **A2A is GA** in Copilot Studio; **Work IQ** is **preview**, with usage-based billing at GA. Treat every "new experience" capability as preview unless noted, and re-check status before you commit a production design to it.

{: .q-left }
> **Why read this**
Read this if you built automation on the classic experience — an *agent flow*: a deterministic pipeline with a "call an agent" AI action buried among the steps — and then opened the new experience to find a rebuilt canvas, a first-class **agent node**, and Microsoft describing "deterministic orchestration with adaptive execution" as the point of the whole thing. Nothing about classic agent flows is wrong; they are GA and they keep working. But the compositional model changed, and the reasons to reach for a workflow versus an agent shifted with it. Read it before your next automation build, so the deterministic parts and the adaptive parts land in the right home from the first draft — not the third.

## The shift: from a flow that phones a bot to a canvas that hosts agents

![The forced choice between fully structured and fully agentic, converging into one canvas](/images/2026/08/2026-08-29-copilot-studio-workflows-fig3-end-of-either-or.png)

*Figure 1 — The end of the either/or: a binary choice between fully structured and fully agentic becomes one canvas that holds both.*

In the classic experience, a workflow was, at heart, a *deterministic pipeline*. Microsoft's own definition has not moved: *"workflows are step-by-step automation processes that complete actions or tasks in a deterministic, reliable way."* An **agent flow** consisted of a trigger and a sequence of actions, and its defining property was predictability — *"the same input always produces the same output, making them reliable and predictable."* You could already reach an agent from inside one, but you did it the way you did everything else in that pipeline: as one AI action among many, buried in a menu, prose in and prose out.

The new experience keeps the deterministic pipeline — and changes what sits on top of it. The redesigned workflows canvas treats an *existing agent* as a first-class building block you drop onto the flow, next to the deterministic actions, exactly where the rule-based path runs out of road. Microsoft frames the redesign as *"a more intuitive visual designer for building and orchestrating agentic automation in one place,"* and the load-bearing addition as this: *"the ability to add existing agents directly into workflows."*

That is the through-line of this article. The *architecture* — a reliable structured backbone with adaptive reasoning grafted onto it at controlled points — is not new; classic agent flows already blended "the predictability of workflows with the flexibility of agents." What changed is **where the adaptive part lives and how first-class it is**. In the classic model, calling an agent was a subordinate step inside a pipeline. In the new model, the agent node is a peer of the pipeline — and that promotion is the whole story.

## Two workflows experiences — and why the names are load-bearing

The single most common source of confusion in the new experience is naming, so pin it down before anything else. There are now **two** workflow authoring experiences, and Microsoft's documentation is explicit about the split.

| | **Agent flows** (classic) | **Workflows** (new experience) |
|---|---|---|
| Status | **Generally available** | **Public preview** — *"aren't meant for production use"* |
| Where you build it | Classic authoring experience | Redesigned unified canvas |
| Core property | Deterministic, rule-based path | Deterministic backbone **plus** agent nodes and AI actions |
| Calling an agent | A "call an agent" **AI action** | A first-class **agent node** |
| Designer | Established flow designer | New designer: inline config, node-level testing, version history |

Microsoft's Learn documentation states it plainly: *"Agent flows are the classic automation experience in Copilot Studio."* The new one is simply called **Workflows**, and the two are documented side by side precisely so makers do not conflate them. The distinction is not cosmetic: the classic agent flow is GA and safe for production today; the new workflows experience is a public preview you should treat as such. For the rest of this article, "workflow" means the new experience unless it says "agent flow."

## Anatomy of a workflow: trigger, actions, and the deterministic contract

Both experiences share the same skeleton, and understanding it is what makes the agent node's significance visible. A workflow is **a trigger plus at least one action.**

- **Triggers** start the flow. They are *instant* (run on demand), *scheduled*, or *event-based* — "when a new item is created in a SharePoint list," "when an email arrives from my manager."
- **Actions** are what the flow does in response. Copilot Studio groups them into four families that carry forward into the new experience:
  - **AI capabilities** — LLM-backed actions that *"generate text, process documents, run a prompt on a model, call an agent, and create a natural language reply to a calling agent."*
  - **Human in the loop** — approvals and requests for information, so a person retains authority at a decision point.
  - **Built-in tools** — control structures: looping, branching, data operations, date/time, child flows.
  - **Connectors** — Microsoft 365 services, third-party services, and custom connectors.

The property that makes all of this valuable is the **deterministic contract**: *"They execute actions or tasks following a rule-based path. The same input always produces the same output."* That predictability is the reason enterprises trust a flow to touch financial records or route a contract. It is also — and this is the subtle part — the exact property the agent node **deliberately relaxes at one controlled point**. Hold that thought; it is the crux of the governance discussion later.

## The agent node: calling an agent from a flow

![A Copilot Studio workflow with an agent node as an inline, first-class step among deterministic actions](/images/2026/08/2026-08-29-copilot-studio-workflows-fig1-agent-node-canvas.png)

*Figure 2 — Calling an agent from a flow: an existing agent — its knowledge, tools, and loop — dropped onto the canvas as a first-class step, beside the deterministic actions.*

Here is the feature the rest of the article is about, and the one the request behind this piece asks us to weigh honestly: is calling an agent from a flow *new*, and is it a *real* evolution? The intellectually honest answer is that the *capability* existed and the *primitive* did not — and the primitive is what matters.

### It existed before — as an AI action

Classic agent flows could already call an agent. The Learn action list is unambiguous: under **AI capabilities**, an agent flow can *"call an agent, and create a natural language reply to a calling agent."* So a flow reaching into an agent is not a 2026 invention. But look at *where it sat*: one line item in an AI-actions submenu, a subordinate step in a deterministic pipeline, wiring a request in and pulling a natural-language reply out. The flow was the star; the agent was a service it happened to call. In the classic mental model — and in Charles Lamanna's original framing — the point was that *"sometimes businesses need to combine the predictability of workflows with the flexibility of agents,"* but the combination was lopsided: structure on the canvas, intelligence in a drawer.

### What the node changes

The new experience promotes that buried capability to a first-class citizen. Microsoft's description is worth quoting in full, because every clause carries weight:

{: .q-left }
> *&quot;A core component of the new experience is the ability to add existing agents directly into workflows. These agent nodes allow you to create automated solutions that keep the scalable reliability of workflows while bringing in AI intelligence when you need it.&quot;*

Three things follow from "add **existing** agents … as **agent nodes**":

1. **The node is a peer of the deterministic action.** It sits on the canvas next to "read a SharePoint list" and "send an email," not inside a menu. Visually and conceptually, reasoning is now a step, not a special case.
2. **The node references a whole agent, not a prompt.** Because it calls an *existing* agent, everything that agent owns — its instructions, knowledge, tools, skills, connected agents, and its own orchestrator loop — becomes a callable unit inside the deterministic flow. You are not writing a prompt into a flow step; you are invoking a governed, tested, independently owned reasoning engine.
3. **It activates exactly where if-then logic fails.** Microsoft names the trigger condition precisely: *"when a workflow hits a decision that can't be captured in simple if-then logic — where it needs to use reasoning over context, orchestrate tools, or retrieve knowledge from multiple sources — an agent node can help bridge the gap."*

And crucially, the surrounding designer makes the non-deterministic step *tractable*: *"Inline configuration, simplified building blocks, and node-level testing help validate workflow behavior earlier."* Node-level testing turns "run the whole flow and read the logs" into "inspect this node's inputs, outputs, and the agent's reasoning in isolation."

### Why this is a real evolution

Put those pieces together and the case for "evolution, not rename" is concrete. Five reasons:

- **It ends the either/or.** The classic choice was binary: build a *fully structured* automation (Power Automate-style) or a *fully agentic* experience (a chat-first agent). Community coverage of the rebuild put it bluntly — the prior model *"forced a hard choice … Agent nodes eliminate that choice."* Microsoft's own framing is the productized version: *"combine deterministic orchestration with adaptive execution — structured where needed, adaptive where valuable."* The agent node is the seam that lets both live on one canvas.
- **It inverts and completes the composition.** In the agent-first model, the **loop carries the process** and workflows are the guardrails around it. The workflow-first model is the *inverse*: the **deterministic backbone carries the process**, and the agent node is where the loop plugs in — only at the reasoning point, only for as long as needed. Before the node, you had one direction (agent invokes flow-as-tool). Now you have both directions, and they interlock. That symmetry is the real architectural gain.
- **One agent, two consumption modes.** Because the node references an existing agent, the same reasoning engine that answers users in a chat surface can be a step in an unattended workflow. You do not rebuild the logic for batch; you *reference* it. That is reuse at the level of a whole agent, and it is new to the flow surface.
- **The reliability envelope stays deterministic.** The agent runs its adaptive loop, but the workflow keeps deterministic control of what happens *before* and *after* — validation, approvals, state writes, retries, filing. The non-deterministic step is bounded on both sides by structure. You get reasoning without surrendering the audit trail.
- **The step is debuggable.** A reasoning step you cannot inspect is a liability; node-level testing makes the agent node's inputs, outputs, and reasoning visible on its own, which is what makes an agentic workflow safe to iterate on.

None of this was *impossible* before. All of it was *awkward* before, because the primitive was a drawer, not a node. Promoting it to the canvas is the difference between "you can technically call an agent" and "calling an agent is how you build."

## Deterministic where you need it, adaptive where it adds value

![A deterministic backbone that detours up into an agent node and back](/images/2026/08/2026-08-29-copilot-studio-workflows-fig2-deterministic-backbone.png)

*Figure 3 — The flow stays reliable end-to-end; the agent node plugs in only where judgment is needed.*

The design principle the agent node serves is worth stating as a rule, because it is the one decision the platform will not make for you: **put determinism where correctness and audit demand it; put an agent node where the work needs judgment.**

| Put it in a **deterministic action** when… | Put it in an **agent node** when… |
|---|---|
| The rule is stable and expressible as if-then | The decision needs reasoning over unstructured context |
| The step writes to a system of record | The step must orchestrate several tools to decide |
| You need "same input → same output" | You must retrieve and synthesize from multiple sources |
| Compliance requires a fixed, provable path | The input varies too much for a fixed path (e.g., free-text email) |
| Latency and cost must be predictable | A human would apply judgment, not a lookup |

The Graebel case Microsoft published is this rule made real: relocation requests *"come in as unstructured emails filled with unique instructions, attachments, and edge cases,"* and the platform lacked APIs, so a purely structured automation was *"too rigid."* Their Service Order Agent uses reasoning to interpret the email and operate a legacy UI, and — the workflow half — can *"escalate exceptions through workflows when needed."* Judgment where the input is messy; structure where the process must be governed. That is the whole principle in one production system.

## Placing the new primitive: agent node vs connected agent vs skill vs A2A

![Four ways intelligence enters a system: agent node, connected agent, skill, and A2A](/images/2026/08/2026-08-29-copilot-studio-workflows-fig4-who-calls-whom.png)

*Figure 4 — Who calls whom: the agent node is the flow's way to reach an agent; connected agents are an agent's way.*

Because there are now several ways to bring "intelligence" into a system, teams conflate them — the same failure the previous article flagged for Skills versus Connected agents, now with one more piece on the board. The clean way to hold them apart is to ask **who is calling, whose loop runs, and who owns the thing being called.**

| Mechanism | Caller → callee | Whose loop runs | When to use |
|---|---|---|---|
| **Deterministic action** | Flow → connector/tool | No loop; rule-based | Stable, provable, rule-expressible steps |
| **Agent node** | **Workflow → existing agent** | The **called agent's** loop, bounded by the flow | A reasoning point inside a deterministic process |
| **Connected agent** | Agent → specialist agent | The **specialist's** loop | Delegation between agents inside the agent runtime |
| **Skill** | Agent → its own behavior | The **calling agent's** loop | Reusable behavior shared across agents |
| **A2A** | Agent → cross-platform agent | The **remote agent's** loop | Reaching Foundry / SDK / third-party agents |

The distinction that trips people up: **the agent node is the flow's way to reach an agent; connected agents are an agent's way to reach an agent.** Both call agents; the difference is the caller and the surrounding runtime. A workflow uses an agent node to inject reasoning into a structured process. An agent uses a connected agent to delegate a domain to a specialist. Choosing the wrong one rebuilds the classic "god" anti-pattern in a new place — either a workflow that tries to encode judgment as ever-branching if-then logic, or an agent stuffed with process logic that should have been a deterministic flow.

## What else is new in the designer

The agent node is the headline, but the redesigned workflows canvas ships a broader set of changes that make it usable:

- **A unified, end-to-end canvas.** Instead of *"stitching together disconnected tools and logic across multiple surfaces,"* you design the whole process in one place and see how *"actions, decisions, and AI-powered steps work together."*
- **AI actions inline.** Beyond agent nodes, *"AI-powered actions like classification, content generation, and decision support can now be incorporated directly into the workflow"* — lighter-weight intelligence for steps that do not warrant a whole agent.
- **MCP tools from the flow.** The workflow can call **Model Context Protocol** server tools directly, the same standardized tool layer agents use — Microsoft has added *"support for remote model context protocol (MCP) servers"* as a standardized way to connect to tools, services, and enterprise resources.
- **Computer-using agent nodes (preview).** Organizations can now *"embed computer-using agents directly into multi-step workflows,"* combining *"API-based actions, approvals, business logic, and adaptive UI interactions within the same automation system"* — reasoning-driven UI automation for systems that have no API.
- **Human review, node-level testing, and versioning.** Native human-review steps sit mid-workflow at decision points; node-level testing validates behavior *"earlier"* without running the whole flow; version history lets you compare and roll back. These are the boring capabilities that make an agentic workflow operable — and their absence is what made the classic experience painful for complex work.

## The orchestration patterns, expressed as workflows

The four orchestration patterns from the classic articles survive here too — but where the previous article expressed them mostly through connected agents and the agentic loop, the workflow canvas gives the *deterministic* shapes a direct home.

| Pattern | Workflow expression | Where the agent node fits |
|---|---|---|
| **Sequential pipeline** | Ordered nodes with human-review at decision points | One agent node at the single reasoning step |
| **Parallel fan-out / fan-in** | Parallel branches joined by an aggregation action | An agent node per branch; deterministic join |
| **Router-worker** | A classification action (or agent node) that branches | Agent node classifies; deterministic actions execute |
| **Hierarchical (supervisor)** | A supervising workflow invoking agent nodes, durable state in Dataverse | Agent nodes as the "workers"; flow holds the state machine |

Two practical notes. First, **the agentic loop absorbs the simplest cases**: a task that once needed a router plus two workers may now be a *single agent node* whose internal loop orchestrates its own tools — reach for multiple nodes when ownership, parallelism, or a hard determinism boundary demands it, not reflexively. Second, **the deterministic scaffolding is now clearly separated from the adaptive core**: approvals, state transitions, and compliance checks are workflow nodes; the reasoning is the agent node. The pattern you choose is still a design decision the platform will not make for you — but the boring parts and the adaptive parts finally have distinct homes.

## A worked example: unstructured intake, rebuilt as a workflow

![Unstructured intake rebuilt as a workflow with an agent node, a decision, and human review](/images/2026/08/2026-08-29-copilot-studio-workflows-fig5-intake-worked-example.png)

*Figure 5 — The flow owns the process and the writes; the agent node owns the one judgment; a person adjudicates exceptions.*

To make the mapping concrete, take an inbound-request intake — a relocation service order, an invoice, a vendor contract; the shape is the same — and build it on the new canvas.

```text
TRIGGER
  When an email arrives in the intake mailbox
     |
DETERMINISTIC ACTIONS  (the backbone — provable, auditable)
  - Save the message + attachments to the case store
  - Create a case record in Dataverse (status = "received")
     |
AGENT NODE  (the reasoning point — an existing "Intake Analyst" agent)
  - Reads the unstructured email and attachments
  - Classifies the request type across 30+ categories
  - Extracts fields, flags edge cases, orchestrates lookup tools
  - Returns a STRUCTURED result: {category, fields[], exceptions[], confidence}
     |
DETERMINISTIC BRANCH  (structure resumes)
  - If confidence high AND no exceptions -> file + advance case
  - Else -> HUMAN REVIEW node (a person adjudicates the exceptions)
     |
DETERMINISTIC ACTIONS
  - Write the outcome to the system of record (idempotent)
  - Notify the requester; close or route the case
```

Read the control flow: the flow **owns the process and the writes**; the **agent node owns the one judgment** that no if-then tree could hold — turning a messy email into a structured decision — and it hands a *structured* result back to the deterministic path. The agent is an *existing* one, reusable across other intake flows and callable from a chat surface too. The human-review node keeps a person on the consequential branch. This is the classic contract-intake shape from Part 2, but where that version bolted a flow onto a generative core, this one is a deterministic backbone with one clearly-bounded reasoning step — the inverse assembly, and a cleaner one.

## Governance and the new risks

Every discipline the earlier articles established still applies — least privilege, structured contracts, idempotency on writes, audit, treating imported agents and skills as supply-chain dependencies. The agent node adds a small set of *new* things a workflow design review must check explicitly.

- **The determinism boundary is real — do not paper over it.** A workflow with an agent node is only as deterministic as its deterministic parts. Do not claim "same input → same output" *across* the agent node; its output varies by design. Keep every side-effecting write (payments, record updates, external posts) in **deterministic actions with idempotency keys**, *after* the agent node has returned and — where it matters — after a human has reviewed. The node decides; the deterministic step commits.
- **Untrusted observations enter through the node.** The agent node ingests whatever the flow passes it — an email body, an uploaded document, a portal field. That is untrusted data the agent did not author, and it is the same prompt-injection surface the previous article flagged (the CVE-2026-21520 "ShareLeak" class, where instructions hidden in a form field were ingested as authoritative context). Validate payloads, never let free-text content override the agent's instructions, and keep human review on consequential branches.
- **Cost and capacity compound.** Every action consumes Copilot Studio capacity, and an agent node adds an agent's token cost on top of a flow's per-action cost. The new orchestrator's ~50% net token reduction helps, but budget for agent-node runs, monitor capacity, and remember that Work IQ moves to usage-based billing at GA. Do not put an agent node where a deterministic action would do.
- **Preview status is itself a risk input.** The new workflows experience is **public preview and not for production.** That is not a reason to avoid it — it is the best place to learn the model — but keep **classic agent flows (GA)** as the fallback for anything production-critical until the new experience reaches GA, and re-check status before you design against a preview surface.

## Conclusion

If you take five things away from this article, they are these.

First, **the surface changed, the architecture did not.** A workflow is still a deterministic backbone; an agent is still an adaptive loop. What is new is that the new experience puts them on **one canvas** and lets you compose *"deterministic orchestration with adaptive execution — structured where needed, adaptive where valuable."*

Second, **the agent node is the evolution — and it is real.** Calling an agent from a flow existed in classic agent flows as a buried AI action. The new experience promotes it to a **first-class canvas node that references an entire existing agent** — its knowledge, tools, skills, and loop — activated exactly where if-then logic runs out. That promotion, plus node-level testing, is the difference between "technically possible" and "how you build."

Third, **it ends the either/or and completes the composition.** The old choice was fully structured *or* fully agentic. Workflow-first (deterministic backbone, agent node for reasoning) is the **inverse and complement** of agent-first (the loop carries it, workflows are guardrails). With both directions available and interlocking, you finally compose the whole system instead of picking a side.

Fourth, **put each step in its right home.** Deterministic action, agent node, connected agent, skill, A2A — the boundary between them is the whole game, again. The agent node is the flow's way to reach an agent; connected agents are an agent's way. Confuse them and you rebuild the god-agent problem on the workflow canvas.

Fifth, **the node gives you reasoning and a new boundary to enforce.** Do not call a flow deterministic across an agent node; commit side effects in deterministic, idempotent steps around it; validate whatever the node ingests; keep humans on consequential branches; and keep classic agent flows as the GA fallback while the new experience is preview.

The classic articles settled how automation is shaped and showed it executed. The multi-agent article rebuilt the agent side on the new engine. This one rebuilt the *workflow* side — and found that the missing piece was never a bigger flow or a smarter bot, but a clean seam between them. The agent node is that seam. The backbone stays boring. The reasoning plugs in where it earns its place. That is the evolution.

## Sources

- Microsoft Learn — [Agents overview (preview): Microsoft Copilot Studio (new experience)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/overview) — the new agent experience (production-ready preview); the note that "the new workflows experience is in public preview" and "aren't meant for production use"; pointer to the two workflows experiences
- Microsoft Learn — [Agent flows overview: Microsoft Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/flows-overview) — the classic automation experience; trigger + action anatomy; the deterministic contract ("the same input always produces the same output"); the four action families including the "call an agent" AI capability; capacity consumption
- Microsoft Copilot Studio Blog — [New and improved: Computer-using agents, a new workflows experience, and real-time voice experiences](https://www.microsoft.com/en-us/microsoft-copilot/blog/copilot-studio/new-and-improved-computer-using-agents-a-new-workflows-experience-and-real-time-voice-experiences/) (Nitasha Chopra, May 2026) — the redesigned workflows canvas; agent nodes ("add existing agents directly into workflows"); the "decision that can't be captured in simple if-then logic" example; inline AI actions; node-level testing; the ~20% eval / ~50% token figures; remote MCP support; A2A GA; the Graebel Service Order Agent
- Microsoft Copilot Studio Blog — [New and improved: Agent governance, intelligent workflows, and connected app experiences](https://www.microsoft.com/en-us/microsoft-copilot/blog/copilot-studio/new-and-improved-agent-governance-intelligent-workflows-and-connected-app-experiences/) (Nitasha Chopra, April 2026) — "workflows are step-by-step automation processes that complete actions or tasks in a deterministic, reliable way"; "embedding Copilot Studio agents directly into them"; Agent 365 GA
- Microsoft Copilot Studio Blog — [Introducing agent flows: Transforming automation with AI-first workflows](https://www.microsoft.com/en-us/microsoft-copilot/blog/copilot-studio/introducing-agent-flows-transforming-automation-with-ai-first-workflows/) (Sangya Singh, April 2025) — the GA of agent flows; "agents and agent flows: better together"; deterministic workflow automation with AI actions
- LinkedIn — [Introducing deep reasoning and agent flows in Copilot Studio](https://www.linkedin.com/pulse/introducing-deep-reasoning-agent-flows-copilot-studio-charles-lamanna-n1zxc/) (Charles Lamanna, March 2025) — agent flows GA on 31 March 2025; "combine the predictability of workflows with the flexibility of agents"; flow-to-agent hand-off examples
- Community coverage (secondary, treat as commentary) — ChatForest, *Microsoft Rebuilt Copilot Studio's Engine* (July 2026), for the "agent nodes eliminate that choice" framing; candede.com, *Mastering Copilot Studio: 2026 Release Wave 1* (May 2026), and WindowsForum's April 2026 update thread, for designer-UX details (node notes, canvas search, human review, version diffs). Verify against Microsoft Learn before relying on any specific detail
- Prior articles in this series — *The Build 2026 Rebuild*, *Copilot Studio Reimagined*, and *Multi-Agent Orchestration in the New Copilot Studio* — for the agent-first model, the four orchestration patterns, and the Skills-versus-Connected-agents boundary this article builds on
