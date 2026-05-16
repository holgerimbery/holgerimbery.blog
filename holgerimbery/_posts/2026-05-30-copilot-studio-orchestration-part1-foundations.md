---
layout: post
title: "Multi-Agent Orchestration with Copilot Studio — Part 1: Foundations"
description: "A long-form, end-to-end foundation for building multi-agent systems in Microsoft Copilot Studio — when to split, the five surfaces, four patterns, and the two open standards (MCP and A2A) that make the whole thing composable."
date: 2026-05-30
author: admin
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/05/andy-kelly-0E_vhMVqL9g-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@askkell?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Andy Kelly</a> on <a href="https://unsplash.com/photos/photo-of-girl-laying-left-hand-on-white-digital-robot-0E_vhMVqL9g?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
      
tags: [agents, copilotstudio, multiagent, orchestration, mcp, a2a, foundations]
featured: true
toc: true
---

{: .q-left }
> **Summary lede.** This is the first of two articles on multi-agent orchestration in Microsoft Copilot Studio. Part 1 — Foundations — establishes the vocabulary, the decision criteria, and the configuration mechanics that every team needs before it touches a production design. It walks through five questions in order: why split a single agent into several, what a Copilot Studio agent is actually composed of, which orchestration patterns exist, how the Model Context Protocol (MCP) lets agents share tools, and how the Agent2Agent (A2A) protocol lets agents talk to other agents across platforms. The article closes with the concrete configuration steps for both standards as they exist in the product today, with the correct UI paths.

Nothing in this article is hypothetical. Every capability described — connected agents, inline (child) agents, MCP integration with Streamable HTTP transport, A2A integration, autonomous triggers, Entra Agent ID, Agent Registry, Copilot Hub, Microsoft Foundry Agent Service — is documented on Microsoft Learn and shipping in Copilot Studio as of May 2026.

{: .q-left }
> **Why read this**
Read this if you are responsible for the shape of an AI build that has either started to misbehave or is about to. The single-agent-with-everything pattern looks fine for the first quarter of a project and fails predictably in the second. The terms in this article are the ones a solution architect, platform owner, or senior maker needs to discuss the failure with the team and pick a better shape. Read it if you have heard "we will just add another tool" three times in the same week, if your instruction block now scrolls, or if two different teams are editing the same agent without coordinating. Read it especially if a vendor or an article elsewhere has promised that MCP or A2A will "solve" multi-agent work — they will not, but they do remove enough integration duplication that the architectural decisions become the bottleneck again, which is where this article picks up.

The Foundations article is also where the corrections from the original series are applied: the correct UI path for adding A2A agents (the Agents page, not the Tools page), the current name for the Foundry Agent Service, and the actual list of autonomous trigger types supported on Microsoft Learn. If you have been following the series and want the canonical version, this is it.

---

## 1. The drift that produces multi-agent work

Most enterprise AI projects start with a single agent and end with a support ticket. The agent grows, picks up more tools, more instructions, more knowledge sources, and eventually starts choosing the wrong action, citing the wrong document, or refusing perfectly valid requests. Teams add prompt fragments to patch individual failures, the instruction block grows past 8,000 tokens, and nobody on the team can say with confidence why a specific response came out the way it did.

Multi-agent orchestration is the architectural response to that drift. Instead of one general-purpose agent, the work is split across a small set of narrow agents, each with a clear scope, its own knowledge, and its own tools. An orchestrator chooses which specialist to call. This pattern is not new in distributed systems, but the tooling to apply it cleanly to conversational AI is new — and Microsoft Copilot Studio now provides it as a first-class capability.

Five capabilities make multi-agent orchestration practical in Copilot Studio today:

1. **Connected agents** — a separately published agent (another Copilot Studio agent, a Fabric Data Agent, an agent on the Microsoft Foundry Agent Service, or an agent built with the Microsoft 365 Agents SDK) added to another agent as a callable capability. Each connected agent has its own lifecycle, authentication, owner, and can be reused across multiple calling agents.
2. **Inline (child) agents** — lightweight sub-agents that live inside a parent agent and share its environment, tools, and knowledge. They are not independently published and are not intended for reuse outside the parent.
3. **MCP integration** — since 2025, Copilot Studio exposes a "Tools → Add a tool → New tool → Model Context Protocol" flow that takes a server URL, authentication settings, and automatically discovers the tools the server publishes.
4. **A2A protocol support** — Copilot Studio can connect to any agent that speaks the open Agent2Agent protocol, enabling orchestration with agents hosted on other frameworks.
5. **Autonomous agents** — event-triggered agents that act without a user turn, generally available since March 2025.

These capabilities are not roadmap items. They are documented, configurable, and in production use at organizations including ABN AMRO, Rabobank, Holland America Line, T-Mobile, the City of Montréal, La Trobe University, Nexi Group, and Singapore Civil Defence Force.

## 2. When to split a single agent

The question is not whether multi-agent systems are better. The question is at what point a single agent stops being the right shape for the work.

Copilot Studio gives makers a lot of room before that point is reached. A single agent can hold a substantial instruction block, dozens of knowledge sources, and a growing list of actions. For many use cases — an FAQ bot over a policy library, a contained IT assistant with five connectors — one agent is the correct answer and will stay the correct answer for the life of the deployment.

The problems begin when the agent's scope expands informally. A new department asks if the existing agent can "also" handle their intake. A manager attaches another SharePoint site "for context." An action is added because it was convenient. Each change is small; the cumulative effect is an agent with blurred responsibilities, inconsistent tone, and orchestration quality that degrades in ways that are hard to diagnose.

### Signals an agent has outgrown itself

Microsoft's guidance on multi-agent orchestration is explicit about the thresholds where quality starts to slip. The clearest signal is **tool count**. The orchestrator ranks candidate tools at each turn; as the list grows, the probability of selecting the right one falls. Microsoft Learn's *Add other agents overview* states this directly: "this degradation in performance can happen when your main agent has more than 30-40 choices of action (tools, topics, and other agents)." Other signals are softer but equally real:

- The instruction block contains rules that contradict each other because different requirements were bolted on over time.
- Knowledge sources cover unrelated domains, and retrieval surfaces HR articles to IT questions.
- Response latency varies wildly because one path calls a millisecond lookup and another generates a multi-page report.
- Multiple owners now edit the same agent, each with different mental models.
- Testing one change risks regressing a behavior owned by a different team.

When three or more of these are true, the agent is doing the work of what should be multiple agents.

### What splitting actually buys you

Decomposing an agent is not free. It introduces a second artifact to maintain, an orchestration layer, and a contract between components. The benefits must be worth that cost, and they usually are in three ways.

First, **bounded context**. Each specialist agent can have a short instruction block, a small number of tools, and a knowledge base scoped to one domain. The orchestrator's job is routing, not execution. Testing becomes possible because each agent has a well-defined input and output.

Second, **independent ownership**. HR owns the HR agent; IT owns the IT agent; Finance owns the invoice agent. When HR needs to change the parental-leave policy, they update one knowledge source and one agent, with no risk to the IT triage behavior.

Third, **reuse**. A connected "Knowledge Base Lookup" agent can serve the Service Desk, the Sales Assistant, and the Field Technician agent without three teams each rebuilding the same tool integrations, prompts, and error handling.

### A decision checklist

A practical rule for deciding whether to split:

- **Split when** the agent has multiple distinct owners, or the tool count is approaching 30, or two knowledge bases are pulling retrieval in conflicting directions, or SLA expectations differ between tasks.
- **Do not split when** the problem is really that one knowledge source is outdated, or when the instructions simply need rewriting, or when the "additional" use case is a one-off topic that belongs in a Power Automate flow rather than a new agent.

The cheapest intervention should always be tried first. A clean-up of instructions, a re-scoping of knowledge sources, or moving an over-loaded action into a Power Automate agent flow will often resolve what looked like a multi-agent problem.

### Inline or connected: a second decision

Once the decision to split is made, Copilot Studio offers two options, and they serve different purposes.

**Inline (child) agents** are the right choice when the sub-agent exists only to factor complexity inside one parent. They share the parent's environment, tools, and authentication. They are effectively named sub-routines. They do not need to be reused; they do not need to be independently owned; they simply make the parent easier to reason about.

**Connected agents** are the right choice when the specialist is an independent unit: it has its own owner, its own release cadence, its own authentication model, or it will be called from more than one calling agent. Connected agents can be other Copilot Studio agents, Fabric Data Agents for governed analytics, agents on the Microsoft Foundry Agent Service, or agents built with the Microsoft 365 Agents SDK.

The criteria often map to organizational structure. If the same team owns both the parent and the specialist and nobody else will ever call it, inline is simpler. If any of those three conditions changes, connected is the correct pattern.

ABN AMRO's published Copilot Studio work illustrates the discipline. Rather than building one large "bank agent," they segmented work by domain and used Copilot Studio together with Azure services to compose specialists. The combination — bounded agents plus governed data access — was what made the outcomes reproducible across customer and employee scenarios. A similar pattern shows up in the City of Montréal's citizen-engagement work, where the public-facing agent delegates to a specialist for service-request handling rather than trying to hold every city process inside one prompt.

## 3. Agent anatomy: the five configuration surfaces

Before multi-agent work begins, it helps to be precise about what a single Copilot Studio agent actually contains. Makers who started with Power Virtual Agents sometimes carry forward a mental model built around topics and dialogs; makers who came from Azure OpenAI Studio sometimes carry forward a mental model built around system prompts and function calls. A modern Copilot Studio agent is neither of those alone. It is a composition of five distinct surfaces, each with different runtime behavior and different design trade-offs.

1. **Instructions** — the natural-language description of the agent's role, constraints, tone, and output preferences. Instructions are injected into every turn.
2. **Knowledge** — the structured and unstructured data the agent can retrieve from, including SharePoint sites, Dataverse tables, uploaded files, public websites, Microsoft 365 Graph connectors, and enterprise search sources.
3. **Tools** — the executable capabilities the agent can invoke: connector actions, Power Automate flows, Dataverse actions, MCP-exposed tools, and other agents (inline or connected) used as tools.
4. **Topics** — deterministic, authored conversation paths triggered by phrases, events, or redirections from other topics. Topics are where you place behavior that must be reproducible.
5. **Triggers** — what causes the agent to run at all. Beyond user messages, Copilot Studio's documented event triggers include SharePoint, OneDrive, Planner, Recurrence (schedule), and Dataverse row-change triggers; Power Automate cloud flows can extend the catalog where a native trigger does not yet exist.

### Instructions: judgment-based behavior

Instructions are the place for behavior that depends on context and cannot be fully specified in advance. Good instructions describe the agent's purpose, its refusal rules, its preferred output format, and any constraints it must honor. They should not contain large tables of if-this-then-that logic; that is what topics are for.

A healthy instruction block is rarely more than a page. Once it grows past that, two things happen: the probability that the agent follows any individual rule drops, and the cost per turn rises. Copilot Studio's generative orchestration picks up the instructions automatically; no separate system prompt editing is required.

### Knowledge: scoped retrieval beats wide retrieval

Copilot Studio supports a long list of knowledge sources. The mistake that repeats in production is attaching too many. Retrieval quality on a tightly scoped SharePoint library is almost always better than retrieval across an entire tenant, because the signal-to-noise ratio is higher and ranking works against fewer near-duplicates.

A documented example is Dunaway, a firm whose Copilot Studio agent answers city-code questions. The published case study is explicit that they scoped knowledge to the specific regulatory libraries that mattered, rather than pointing the agent at every document the firm could access. The outcome — fast, accurate regulatory answers — depended on that scoping.

Graph connectors are the right choice when the source is not already in SharePoint or Dataverse. Websites work, but are best reserved for public reference material where currency matters more than precision. Uploaded files are fine for stable documents but awkward for anything that changes; preferable to store those in SharePoint and let the agent retrieve them from there.

### Tools: the surface that most affects orchestration quality

Every tool you add to an agent is a candidate the orchestrator must consider at every turn. Tools fall into several categories in Copilot Studio today:

- **Prebuilt connector actions** — from Microsoft's catalog of 1,000+ connectors, including Microsoft 365 services and major SaaS platforms.
- **Power Automate cloud flows** — any existing flow can be promoted to a tool, which keeps complex orchestration logic out of the agent.
- **Agent flows** — a visual, AI-assisted workflow designer that blends deterministic steps with generative reasoning, triggered by Dataverse events, schedules, or HTTP calls.
- **MCP tools** — tools exposed by an MCP server, discovered automatically once the server is connected.
- **Other agents as tools** — inline or connected agents added to the agent's list of callable specialists.

The practical guidance is to treat tool descriptions as first-class design artifacts. The orchestrator selects tools largely from their descriptions; a vague description produces vague routing. A one-sentence description that explains *when to use this tool, what it returns, and any side effects* is worth more than a long paragraph that describes the implementation.

### Topics: the place for reproducibility

Topics are the most under-used surface in modern Copilot Studio builds. Makers arriving from the LLM side sometimes treat everything as an instruction, and then are surprised when behavior they need to be deterministic — an escalation path, a compliance disclosure, a specific regulatory script — varies between conversations.

Topics execute as authored. They can include message nodes, condition nodes, generative AI nodes, and action calls. If a behavior must be reproducible for audit or compliance reasons, put it in a topic. Rabobank's published conversational banking work, for instance, relies on authored flows for regulated interactions while letting generative nodes handle the softer surrounding conversation.

### Triggers: what makes an agent autonomous

The default trigger is a user message. Since March 2025, Copilot Studio supports autonomous triggers — an agent can be woken by a Dataverse row change, a SharePoint document event, a OneDrive event, a Planner change, a scheduled (Recurrence) trigger, or an HTTP call. Where a native trigger does not exist for the desired source, a Power Automate cloud flow that subscribes to that source can write into Dataverse and let the Dataverse row-change trigger wake the agent. These triggers are what make "autonomous agents" possible: the agent is still described by the same five surfaces, but it does not need a user to start it.

Singapore Civil Defence Force's published case study includes autonomous processes that run without user interaction. The savings reported in that case study — described as multi-million-dollar in the published case study — come from that automation running continuously against existing business events, not from a human chatting with a bot.

### How these surfaces interact in a multi-agent system

When you split an agent, you are really deciding how each surface gets redistributed:

- **Instructions** shrink, because each specialist has a narrower role.
- **Knowledge** separates by domain, so retrieval becomes sharper.
- **Tools** concentrate in the specialists; the orchestrator holds few direct tools beyond the ability to call its agents.
- **Topics** tend to live in specialists, where reproducibility matters for specific business flows.
- **Triggers** vary: the orchestrator is typically user-triggered, while specialists are often called-only; autonomous triggers live on individual specialists.

## 4. The four orchestration patterns

With the building blocks clear, the next question is how to arrange them. There are four patterns that cover the vast majority of enterprise multi-agent work, and all four can be implemented today in Copilot Studio using generative orchestration together with connected agents, inline agents, and agent flows.

### Pattern 1 — Router-worker

A thin parent agent classifies each incoming request and delegates to a specialist. The parent does almost no execution itself; its job is routing. The specialists do the work and return results. The parent optionally reformulates the response into the conversational style the user expects.

Router-worker is the default pattern for internal service desks, multi-tenant assistants, and any situation where requests fall into a small, stable set of categories. The strength of this pattern is operational: each specialist is small enough to debug, and changes to one specialist do not risk regressing the others.

In Copilot Studio, the router is a standard agent with connected agents added on the Agents page. The orchestrator's built-in tool selection handles the routing, provided each connected agent has a clear, narrow description. No custom code is required.

Nexi Group's published case study describes exactly this shape: a front-end agent that delegates card-service queries to specialists, reducing contact-center workload while keeping the interaction consistent for the customer.

### Pattern 2 — Sequential pipeline

Agent A's output becomes Agent B's input, which becomes Agent C's input, and so on. Each stage applies a transformation that depends on the previous one.

Sequential pipelines are the natural shape for review workflows: intake → analysis → recommendation → approval. They are also common in content-generation workflows, where one agent drafts, another edits, and a third formats.

In Copilot Studio, sequential pipelines are typically built with agent flows, because agent flows give you explicit control over step order, conditional branching, and error handling. Individual steps can call connected agents, generative prompts, or deterministic actions. Agent flows also support human-in-the-loop approvals, which sequential pipelines frequently need at the decision point.

Sequential work is where the discipline of structured outputs matters most. If step three has to parse prose from step two, the pipeline breaks quietly the first time the phrasing changes. Each step should return a structured object — JSON or a typed record — rather than a narrative.

### Pattern 3 — Parallel fan-out / fan-in

The parent calls N specialists concurrently, waits for all of them, and then merges the results. This pattern is used when a single request needs enrichment from several independent sources, none of which depends on another.

Typical enterprise examples: enriching a customer record by calling a CRM lookup, an ERP balance check, and a support history lookup at the same time; running legal, finance, and risk review of a contract in parallel; pulling inventory, shipping, and pricing in parallel for a quoting workflow.

Agent flows in Copilot Studio support parallel branches explicitly. For cases where the parallelism is between full agents rather than actions, Power Automate remains a direct alternative: each branch calls an agent, and a final step aggregates the results. The parent agent then presents the merged output.

The complexity to watch for is timeout and partial-failure behavior. Parallel patterns fail well only if you decide, before the first implementation, what happens when one of the N branches times out or errors. "Return what we have and note what is missing" is a more robust default than "fail the whole request."

### Pattern 4 — Hierarchical (supervisor / sub-orchestrators)

A supervisor agent decomposes a goal into subgoals and delegates each to a sub-orchestrator, which in turn delegates to its own specialists. This pattern is used for long-running processes that span departments, such as employee onboarding, incident post-mortems, or multi-step audits.

The supervisor tracks state across time — usually in Dataverse — and is often an autonomous agent rather than a conversational one. Each sub-orchestrator updates its own step on completion, and the supervisor polls for progress or reacts to Dataverse events.

Copilot Studio supports the hierarchical pattern through the combination of connected agents (for delegation), autonomous triggers (for event-driven progress), and Dataverse tables (for shared state). The Microsoft-published Ignite 2025 guidance on long-running agentic processes specifically recommends storing orchestration state in Dataverse rather than in conversation history, which truncates.

### Choosing between the patterns

A short checklist:

- If requests split cleanly into categories and there is little cross-dependency, use **router-worker**.
- If work must happen in a specific order with each step depending on the previous, use **sequential pipeline** (agent flows).
- If several independent lookups or reviews can happen at once, use **parallel fan-out / fan-in**.
- If the process spans days, involves multiple departments, and needs state that outlives any single conversation, use **hierarchical**.

It is common for a real system to use more than one pattern. A customer-service agent might use router-worker at the top level, then have a sequential pipeline for complaint handling as one of its specialists, with a parallel enrichment step inside that pipeline. The goal is not architectural purity; it is picking the simplest pattern for each piece.

### Three pattern anti-patterns

1. **Circular delegation.** Agent A calls Agent B, which calls Agent A back. Copilot Studio does not prevent this structurally, and it leads to long, expensive conversations that loop until a timeout. Rule: child agents never call back into their parents.
2. **Fan-out without merge.** The parent fires five parallel requests but does not wait for all results before responding, so the conversation becomes out-of-order. In agent flows, always use a "join" step before the aggregation.
3. **Hierarchical without state.** A supervisor that tracks state in the conversation window will lose it the moment the conversation is truncated. Long-running processes must persist state outside the conversation.

Copilot Studio provides the runtime — generative orchestration, tool selection, topic execution, agent-flow execution, autonomous triggers. It does not choose the pattern for you. The choice of pattern, the decision of which agent owns which responsibility, the contract between steps, and the handling of partial failures are all design decisions.

## 5. The Model Context Protocol (MCP) in plain terms

Two problems surface in any organization that has built more than a few agents. First, every agent builder reimplements the same integrations — Jira search, SharePoint lookup, ticket creation — in their own style, with their own error handling. Second, when a backend API changes, every agent that depends on it has to be updated individually. These are not AI problems; they are classic enterprise integration problems that the rise of agents has made more visible.

MCP is the open standard that addresses both. It was originally published by Anthropic in late 2024, is now adopted by multiple agent platforms, and is supported natively in Microsoft Copilot Studio since 2025. For Copilot Studio makers, understanding MCP is less about protocol details and more about what the standard allows you to do.

### What MCP actually is

MCP is a specification for how an AI client (an agent) discovers and calls tools hosted on a separate server. The specification defines:

- A uniform way for the server to describe the tools it offers (name, description, input schema, output schema).
- A uniform way for the client to invoke a tool and receive a structured response.
- Support for authentication, including OAuth 2.0 flows.
- Support for streaming responses, which matters for long-running tools.

The practical consequence is that a single MCP server can expose a set of tools — search, create, update, delete against whatever backend — and any MCP-aware client can consume those tools without bespoke integration work.

Copilot Studio today supports the Streamable HTTP transport for MCP. (SSE, an earlier transport, was deprecated in mid-2025 and is no longer supported.) Authentication options include none, API key (either in a header or a query parameter), and OAuth 2.0 with three configuration modes: dynamic discovery, dynamic client registration, and manual.

### Why MCP matters for Copilot Studio

Before MCP, extending an agent with a custom backend required building a Power Platform custom connector — writing an OpenAPI definition, handling authentication, registering the connector, and then adding individual actions to the agent. Each action was defined at the connector level, which meant versioning, deprecation, and permissions were all managed per connector.

With MCP, the server owns the tool catalog. When you connect an MCP server to a Copilot Studio agent, the server's tools are discovered automatically. When the server adds a new tool, it becomes available to the agent without any change in Copilot Studio. When the server deprecates a tool, the change is visible server-side rather than scattered across agents.

For enterprises with many agents and many backends, this inverts a maintenance problem. Integration code moves to one server per domain, owned by the team that owns the backend. The agents consume it; they do not redefine it.

### What MCP is not

MCP is not an agent-to-agent protocol. It describes how agents call tools, not how agents call each other. For agent-to-agent communication, the relevant standard is A2A.

MCP is also not a replacement for Power Platform connectors. Connectors remain the right choice when the backend requires complex per-user licensing, deep Dataverse integration, or features that benefit from the Power Platform management surface. MCP is the right choice when the backend is a discrete service with a stable API surface that multiple agents need to share.

Finally, MCP is not, by itself, a security model. Any MCP server you connect must still enforce authentication and authorization; MCP defines the envelope, not the access rules. Recent public reporting on prompt-injection classes of vulnerability in agent platforms — including CVE-2026-21520, an indirect prompt-injection issue patched in Copilot Studio in January 2026 — underlines that adding tools of any kind, MCP or otherwise, expands an agent's attack surface. Tools that write data deserve particular scrutiny.

### A common pattern: the shared knowledge MCP

A frequent pattern in enterprise Copilot Studio deployments is a shared "knowledge retrieval" MCP server. It exposes tools such as:

- `search_policy(query, domain)` — returns matching policy passages with citations.
- `get_policy(policy_id)` — returns the full text of a policy.
- `list_policy_versions(policy_id)` — returns version history.

Each of the organization's agents — HR assistant, IT assistant, customer service assistant, compliance assistant — connects to this one MCP server and uses whichever tools it needs. When a new policy domain is added, it appears in all agents at once. When authentication is rotated, it rotates in one place. When a tool description is improved, every agent benefits.

### Configuring an MCP server in Copilot Studio — the wizard path

Microsoft Copilot Studio offers two paths to connect an MCP server. The native onboarding wizard, introduced in 2025, is the recommended path for most cases.

1. **Open the Tools page of your agent.** Every agent has a Tools tab alongside Knowledge, Topics, Instructions, and Agents.
2. **Select Add a tool → New tool → Model Context Protocol.** This opens the MCP onboarding wizard.
3. **Provide the server details.**
   - *Server name* — a short name; this is what makers see when they browse tools.
   - *Server description* — important. The description is what the orchestrator uses at runtime to decide whether to call this server. Be specific about what the server is for and what kinds of requests it handles.
   - *Server URL* — the base HTTPS endpoint of the MCP server. Streamable HTTP transport is current; SSE was deprecated in August 2025.
4. **Configure authentication.** Three options:
   - *None* — for read-only servers on trusted networks only.
   - *API key* — in a request header (commonly `Authorization` bearer token or `X-API-Key`) or as a query parameter. Each agent-server connection stores its own key, encrypted in the Copilot Studio connection manager.
   - *OAuth 2.0* — preferred for anything involving identity. Three sub-options: *dynamic discovery* (simplest; works when the server supports OAuth 2.0 dynamic client registration with discovery), *dynamic* (DCR without discovery), and *manual* (you supply authorization and token endpoints explicitly).
5. **Create the connection.** The wizard validates the server, pulls the tool catalog, and registers the tools as available to the agent. Each tool appears in the agent's tool list with its declared schema.

That is the entire configuration path for the common case. The effort goes into writing good tool descriptions on the server side, not into configuring the client.

### Configuring an MCP server — the custom connector path

Path 1 was not always available; before the native MCP integration, makers built a Power Apps custom connector with a specific `x-ms-agentic-protocol: mcp-streamable-1.0` annotation. This path still works and is the right choice when you need:

- Dynamic value lookups that feed MCP parameters from another API.
- Custom URL rewriting (for example, to route one connector to multiple regional MCP endpoints based on a catalog service).
- Fine-grained policy controls expressed at the Power Platform connector level, such as per-environment availability.

A Microsoft sample published in March 2026, "Dynamic MCP Routing in Copilot Studio," uses exactly this approach: a single connector that resolves an instance dropdown via a catalog service and rewrites the URL at runtime. It is a useful reference for multi-tenant or multi-region requirements.

Unless one of those requirements applies, the wizard path is simpler and has fewer moving parts.

### Tool descriptions are the production variable

One thing deserves emphasis, because it determines success in production more than any configuration detail: the description of each MCP tool, authored on the server. A tool description in MCP should state, clearly and concisely:

- What the tool does.
- When the agent should use it (which kinds of requests).
- What it returns.
- Any side effects (writes data, sends messages, charges money).

A description like "Search items" is nearly useless to the orchestrator. "Searches the internal policy library for HR, IT, and compliance policies; returns matching passages with citations; read-only" is specific enough that the orchestrator will route appropriately. When orchestration quality feels off — the agent is calling the wrong tool, or no tool at all — the first place to look is usually the descriptions.

## 6. The Agent2Agent (A2A) protocol

If MCP is how agents talk to tools, A2A is how agents talk to other agents. It is a separate open standard with its own specification, and — like MCP — it is supported natively in Microsoft Copilot Studio today. For multi-agent architectures that span platforms, teams, or vendors, A2A is the piece of the puzzle that keeps the system composable.

### When A2A is relevant

A Copilot Studio agent can already call another Copilot Studio agent as a connected agent — that works entirely inside the Microsoft stack. A2A becomes relevant when the other agent is *not* a Copilot Studio agent. For example:

- An agent built with the Microsoft 365 Agents SDK in code.
- An agent hosted on the Microsoft Foundry Agent Service.
- An agent built on a non-Microsoft framework (LangGraph, CrewAI, Google's own A2A-compliant agents).
- A partner's agent exposed to your organization as a service.

Before A2A, connecting to such an agent meant writing a custom HTTP integration — handling the request shape, interpreting streaming responses, mapping authentication, and dealing with session state. A2A standardizes the contract so that any A2A-compliant client can talk to any A2A-compliant agent with no custom code.

### What the protocol defines

Microsoft Learn describes A2A as "an open standard for communication and collaboration between agents." The specification covers:

- A standard contract for **sending tasks** to an external agent.
- A mechanism for providing **rich, structured metadata** with the request — context, user identity, task parameters.
- A predictable **response format**, including support for multi-turn interactions.
- **Interoperability across frameworks**, so an agent built on any A2A-compliant platform can be called the same way.

Compared to a traditional HTTP connector — which is generic and was not designed for agent workflows — A2A is explicitly designed for the shape of agent interactions: multi-turn interactions and rich contextual metadata work natively, where an HTTP connector requires you to build those capabilities yourself.

### Configuring an A2A agent in Copilot Studio — the correct path

External agents, including A2A-compliant agents, are added on the **Agents page** of the calling agent — not the Tools page. The Tools page is for MCP servers and connector-backed tools; the Agents page is where connected agents (Copilot Studio, Fabric Data Agent, Microsoft Foundry Agent Service, Microsoft 365 Agents SDK) and external A2A agents are registered.

The configuration steps:

1. Obtain the target agent's A2A endpoint URL and authentication requirements from whoever owns it.
2. In the calling agent, open the **Agents** page.
3. Select **Add an agent → Connect to an external agent → Agent2Agent**.
4. Provide the A2A endpoint URL and a description that tells the orchestrator when to delegate to this agent.
5. Configure authentication. OAuth 2.0 with Entra ID is the recommended default for enterprise scenarios; API key and None are also available.
6. Save.

Once registered, the A2A agent appears in the Agents list alongside connected Copilot Studio agents. The orchestrator invokes both kinds through the same delegation mechanism at runtime; only the configuration differs.

### When to use A2A versus connected agents

A useful rule:

- If both agents live in your Copilot Studio tenant, **connected agents** is the simpler choice. Lifecycle, authentication, and governance are all inside Power Platform.
- If the other agent is built outside Copilot Studio — in code with the Microsoft 365 Agents SDK, on the Microsoft Foundry Agent Service, on another platform, or by a partner — **A2A** is the way to call it without custom plumbing.
- If you want the same agent to be callable from Copilot Studio, from a custom app, and from another vendor's agent, **publishing it as an A2A agent** turns it into a reusable unit across clients.

The two are not mutually exclusive. Many production systems mix: the orchestrator in Copilot Studio calls connected agents for Copilot-native specialists and A2A agents for specialists hosted elsewhere.

### Three rules for robust agent-to-agent calls

These apply equally to connected agents and A2A agents.

1. **Return structured data, not prose.** The calling agent should not parse "I created ticket INC-12345 for you" to extract the ID. Design the called agent to return a structured result. Agent flows, connected agents, and A2A agents in Copilot Studio all support structured return types; use them.
2. **Make the called agent idempotent.** Retries must not create duplicate records. Every agent-to-agent call that writes data should accept an idempotency key and use it to deduplicate on the server side. This is particularly important for agents that create tickets, send email, or post messages, because retries are common under load.
3. **Bound the conversation.** A called agent should not call back into the calling agent. Structurally it is possible; in practice it produces loops that are expensive and hard to debug. Design the contract so the called agent has everything it needs as inputs, does its work, and returns.

### Multi-turn versus single-turn

A2A supports both. Some tasks are single-turn — "look up this policy and return the passage." Others are genuinely multi-turn — "help this user configure their integration, with clarifying questions as needed."

Single-turn is the default and should be preferred when it applies. Multi-turn introduces state, which then has to be tracked somewhere — usually by the caller. For long-running processes, the hierarchical pattern with state stored in Dataverse is usually a better fit than keeping multi-turn state inside the A2A exchange.

### Security considerations for A2A

The security model for A2A is the same concern that applies to any tool: the called agent is now part of your system's trust boundary. A few practical implications:

- The called agent's identity matters. In Entra-governed tenants, use Entra Agent ID (introduced at Ignite 2025) to give each agent a first-class identity with scoped permissions.
- Scopes should be narrow. An agent that exists to summarize documents does not need write access to email.
- Audit everything. Purview audit logs cover Copilot Studio activity; treat calls to external A2A agents the same way you would treat any outbound API call — logged, reviewed, and alertable.

## 7. Wiring inline, connected, and A2A agents — all three configuration paths

Agent-to-agent delegation in Copilot Studio uses one of three mechanisms depending on where the called agent lives. Getting the mechanism right is what keeps the design from leaking through the architecture.

### Configuring an inline (child) agent

Inline agents are authored inside the parent agent. In Copilot Studio they are usually expressed as topics that the orchestrator can invoke. Microsoft Learn describes them as "small, reusable workflows within the same agent… often just topics that the main agent uses as subroutines."

1. In the parent agent, create a topic named after the sub-agent's responsibility (e.g., "Translate Text," "Validate Expense Code," "Summarize Ticket").
2. Author the topic's logic — message nodes, condition nodes, generative AI nodes, action calls as needed.
3. Ensure the topic has a clear description so the orchestrator can route to it.
4. Save; the inline agent is immediately available within the parent.

Inline agents share the parent's tools, knowledge, and authentication. There is no separate lifecycle. If you later need to reuse the inline agent elsewhere, promote its logic into a connected agent.

### Configuring a connected agent

A connected agent is a separately-published Copilot Studio agent (or a Fabric Data Agent, an agent on the Microsoft Foundry Agent Service, or one built with the Microsoft 365 Agents SDK) that this agent calls.

1. Ensure the target agent is published in the same environment and that you have permissions to use it.
2. In the calling agent, open the **Agents** page → **Add an agent**.
3. Select the target agent from the list of available agents in the environment.
4. Provide a short description of *when* the calling agent should delegate to this agent. This description, distinct from the target agent's own description, is what the orchestrator uses to decide.
5. Define the input contract: what the calling agent will pass. Keep this to the minimum needed.
6. Define the expected return shape. Connected agents that return structured data are easier to compose; prefer structured returns to prose.
7. Save.

A typical example: a "master" agent that routes HR questions to an HR agent and IT questions to an IT agent. Each specialist is a connected agent in its own right. The master holds only routing logic and a short "what I am" instruction. Each specialist holds its own knowledge (HR policies versus IT runbooks), its own tools (Workday connector versus ServiceNow connector), and its own owner.

### Connecting to a Fabric Data Agent

Fabric Data Agents are a specific type of connected agent that brings governed, schema-aware analytics into a conversational flow. They are configured the same way as any other connected agent, but the target is a Fabric Data Agent published in your Fabric environment.

The practical value is that the agent can answer data questions with governed retrieval — row-level security, sensitivity labels, and column-level policies all apply — without the calling agent having to reimplement those controls.

### Configuring an A2A agent (the corrected path)

A2A is used when the target agent is hosted outside Copilot Studio. The configuration steps:

1. Obtain the target agent's A2A endpoint URL and authentication requirements from whoever owns it.
2. In the calling agent, open the **Agents** page.
3. Select **Add an agent → Connect to an external agent → Agent2Agent**.
4. Provide the endpoint URL and a description that tells the orchestrator when to use this agent.
5. Configure authentication (OAuth 2.0 with Entra ID is the recommended default for enterprise scenarios).
6. Save.

Once registered, the A2A agent appears in the Agents list alongside connected and inline agents. The orchestrator invokes all three through the same delegation mechanism at runtime; only the configuration differs.

### Contracts between agents

Whichever mechanism you use, the contract between the calling and called agent is where production reliability is won or lost.

- **Input contract.** Pass only what the child needs, and only structured values where possible. Passing the entire conversation history "in case it helps" reliably produces slower, less predictable calls.
- **Output contract.** Structured returns — typed records or JSON — are dramatically easier to compose than prose. Copilot Studio supports structured outputs from connected agents natively; define them explicitly rather than relying on the orchestrator to parse text.
- **Error contract.** Decide in advance what the called agent returns when it cannot complete the task. A common convention: return `{status: "not_found"}`, `{status: "unauthorized"}`, or `{status: "error", message: "..."}` rather than conversational refusals.
- **Idempotency.** Any called agent that writes data should accept an idempotency key from the caller. Retries, which happen under load more often than teams expect, must not create duplicate tickets, emails, calendar events, or database rows.

### Avoiding loops

Because Copilot Studio allows any agent to call any other agent, circular delegation is structurally possible: Agent A calls Agent B, which calls Agent A. The orchestrator will happily execute this until timeout or token exhaustion.

The architectural rule: **child agents do not call back into their parents.** If the specialist needs something the parent has, design the parent to pass it down as an input. If the specialist truly needs to coordinate with the parent, the design is not yet right — usually the work belongs in the parent, or the responsibility split is incorrect.

### Governance: who owns which connection

When the graph of agents grows beyond a handful, ownership matters. The Power Platform Admin Center (via Copilot Hub and the Agent Registry introduced at Ignite 2025) shows the full inventory of agents, their connections, their authentication modes, and their usage. Each connected or A2A relationship is visible in that inventory.

Practical governance steps:

- Assign a primary owner to every agent. Ownership is a Dataverse attribute; it also answers the question "who gets paged when this breaks."
- Use Entra Agent ID (Ignite 2025) to give each agent a first-class identity. Scoped permissions then apply per agent rather than per maker.
- Treat A2A connections to external agents as supply-chain dependencies. Document who operates them, review their security posture, and log calls through Purview.

## 8. What the combination of MCP and A2A enables

With MCP for tools and A2A for agents, a Copilot Studio tenant becomes a composition layer rather than a monolith. An orchestrator can call:

- Its own inline agents for low-complexity sub-routines inside the parent.
- Copilot Studio connected agents for specialists owned inside the tenant.
- MCP servers for shared tool catalogs owned by backend teams.
- A2A agents for specialists built in code or hosted on other platforms.

All four mechanisms are available today, documented on Microsoft Learn, and in production use.

This is the meaningful change MCP and A2A introduce: integration work moves from being duplicated per agent to being centralized per domain (for tools) and per agent (for cross-platform agents). The remaining decisions — what the specialists are, who owns them, how they are described, what contracts they expose — become the visible bottleneck again. That is a healthy state, because those decisions are the ones that actually determine whether a multi-agent system works.

## Conclusion

If you take five things away from this article, they are these.

First, **multi-agent orchestration is an architectural response to scope drift, not a fashion**. Splitting an agent is a decision with cost. Make it when you see the documented signals — tool counts approaching 30 to 40, multiple owners, conflicting knowledge, divergent SLAs — and avoid it when the cheaper fix (tighter instructions, scoped knowledge, a Power Automate flow) would do.

Second, **the five surfaces are not interchangeable**. Instructions hold judgment. Knowledge holds retrievable text. Tools hold actions. Topics hold reproducible flows. Triggers hold the answer to "when does this agent run." Putting behavior on the wrong surface — large rule tables in instructions, deterministic compliance flows in generative nodes — is the most common cause of unreliable agents.

Third, **the four patterns cover the work**. Router-worker, sequential pipeline, parallel fan-out, hierarchical. Most production systems mix two or three. None of them require features that do not exist in Copilot Studio today.

Fourth, **MCP and A2A are the two open standards that keep the system composable**. MCP centralizes tool integration per domain. A2A makes cross-platform agent calls portable. Neither is a replacement for the other, and neither is a security model on its own. Both expand the trust boundary; treat them accordingly.

Fifth, **the configuration paths are not interchangeable either**. MCP servers are added on the Tools page via the MCP wizard. Inline agents are topics inside the parent. Connected agents and A2A agents are added on the Agents page — connected agents from the available agents in the environment, A2A agents via *Add an agent → Connect to an external agent → Agent2Agent*. Getting the path right is mechanical, but it is also where teams lose hours when they assume the wrong starting point in the UI.

Part 2 picks up from here and works through the practical side: four end-to-end scenarios — IT incident triage, contract review, field service dispatch, employee onboarding — each on a different orchestration pattern, followed by a starter MCP server inventory and the ten anti-patterns that recur in production deployments. Read Part 1 to settle the architectural decisions; read Part 2 to see them executed.

## Sources

- Microsoft Learn — [Explore multi-agent orchestration patterns](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/multi-agent-patterns)
- Microsoft Learn — [Add other agents (overview)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/authoring-add-other-agents) — source of the documented 30–40 choices-of-action threshold
- Microsoft Learn — [Connect your agent to an existing Model Context Protocol (MCP) server](https://learn.microsoft.com/en-us/microsoft-copilot-studio/mcp-add-existing-server-to-agent)
- Microsoft Learn — [Connect an agent available over the Agent2Agent (A2A) protocol](https://learn.microsoft.com/en-us/microsoft-copilot-studio/add-agent-agent-to-agent)
- Microsoft Learn — [Design autonomous agent capabilities](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/autonomous-agents) — autonomous agents GA, March 2025
- Microsoft Learn — [Event trigger overview](https://learn.microsoft.com/en-us/microsoft-copilot-studio/authoring-triggers-about) — documented event triggers
- Microsoft Learn — [Copilot Studio real-world transformation stories](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/adoption-case-studies) — ABN AMRO, Rabobank, Dunaway, Nexi Group, City of Montréal, Singapore Civil Defence Force, T-Mobile, Holland America Line, La Trobe University, Signetic, A1 Inteligência em Viagens
- Microsoft Learn — [What's new at Ignite 2025 for Microsoft Entra](https://learn.microsoft.com/en-us/entra/fundamentals/whats-new-ignite-2025) — Entra Agent ID
- Microsoft Copilot Acceleration Team — [Copilot Studio resources hub](https://microsoft.github.io/agent-resources/copilot-studio/)
- Microsoft CopilotStudioSamples — [Dynamic MCP Routing in Copilot Studio](https://microsoft.github.io/mcscatblog/posts/dynamic-mcp-routing-copilot-studio/)
- Model Context Protocol — [Official specification and SDKs](https://modelcontextprotocol.io/)
- Agent2Agent protocol — [Open specification](https://a2aproject.github.io/A2A/)
- VentureBeat — [Microsoft patched a Copilot Studio prompt injection. The data exfiltrated anyway.](https://venturebeat.com/security/microsoft-salesforce-copilot-agentforce-prompt-injection-cve-agent-remediation-playbook) — CVE-2026-21520 coverage, April 2026
- Ariel Ibarra — [How to Connect Microsoft Copilot Studio with MCP Servers: A Complete Integration Guide](https://ariel-ibarra.medium.com/how-to-connect-microsoft-copilot-studio-with-mcp-servers-a-complete-integration-guide-506e0c96f843)
- Can Dedeoglu — [Connecting API-Protected MCP Servers to Copilot Studio](https://www.candede.com/articles/configuring-mcp-server-copilot-studio)
