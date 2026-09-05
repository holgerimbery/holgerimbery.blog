---
layout: post
canonical_url: https://holgerimbery.blog/multi-agent-orchestration-copilot-studio-harnesses
title: Multi-Agent Orchestration in Copilot Studio - Pick the Harness First
description: "Child agents, connected agents, A2A, MCP, and the new skills: which of them exist in which harness, why, and how I decide before a single agent gets built."
date: 26-09-05
author: admin
slug: multi-agent-orchestration-copilot-studio-harnesses
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/09/vitaly-gariev-Q3Y8kK1aV3M-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@silverkblack?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Vitaly Gariev</a> on <a href="https://unsplash.com/photos/people-looking-at-canvas-in-studio-Q3Y8kK1aV3M?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
tags:
  - a2a
  - agents
  - childagents
  - connectedagents
  - copilotstudio
  - githubcopilotharness
  - mcp
  - multiagent
  - orchestration
  - skills
  - standardharness
featured: true
toc: true
---

{: .q-left }
> The last article was about workflows and the agent node. This one goes one level up. Copilot Studio now runs three harnesses, and the harness you pick decides which multi-agent building blocks you are even allowed to use. Child agents, connected agents, A2A, and MCP are not four flavors of the same thing, and they are not all available everywhere.

## The one sentence that should govern the whole design

**Harness first, architecture second.** Not because it is elegant, but because Microsoft states plainly that agents "can't be transferred to the standard harness, and vice versa". There is no runtime toggle. A harness change is a rebuild, and every multi-agent mechanism you plan on depends on which runtime you started in.

Microsoft's own definition of a harness is deliberately narrow: it is "a runtime that exists between the two" — the model and the agent's configuration — and it "determines when to call the model, what components to send it". The white paper published on 1 September 2026 phrases it as "the operating layer between the model and the agent's configuration". The consequential sentence follows immediately: "The harness you use affects the billing, features, and capabilities."

Three harnesses, from the harnesses overview page (last updated 27 August 2026):

| Harness | Microsoft's framing | Built for | Billing |
|---|---|---|---|
| GitHub Copilot | "the most capable option, built for reasoning-heavy agents" | "Complex, multi-step business processes" | Copilot Credits, consumption-based |
| Standard | "a dependable option for rule-based agents" | "Rule-based agents and structured conversations" | Existing Copilot Studio licensing |
| Copilot chat | "allows you to extend Microsoft 365 Copilot Chat" | Enterprise knowledge in Chat | Consumption or included with M365 Copilot |

The GitHub Copilot harness reached general availability with the announcement on 2 September 2026: "The GitHub Copilot harness is now generally available". That is the status to plan against. Note what is *not* GA inside it — the same blog marks connected agents "(in preview)", along with Work IQ, memory, and user file upload, while skills, workflows-as-tools, and MCP-as-tool are GA. The Learn page for connected agents carries no preview banner, which is the first of two documentation conflicts worth knowing about.

## Read the banner, not the marketing

The most reliable capability map in Copilot Studio documentation is not a comparison table. It is the one-line banner at the top of each Learn article.

- **"This article describes features used in agents … powered by the standard harness."** appears on *Add a child agent*, *Agent-to-agent (A2A)*, *Connect to an existing agent*, and *Manage Entra Agent IDs*.
- **"Features in this article are used by agents or workflows powered by the GitHub Copilot harness."** appears on *Skills overview*, *Tools overview*, *Connected agents overview*, *Add an MCP server as a tool*, and *Files the agent creates*.

Read those two lists again. The classic multi-agent toolkit — child agents, A2A, connecting external agent types — sits under the standard banner. The new stack — skills, sandboxed files, MCP-as-tool, the new connected-agents surface — sits under the GitHub Copilot banner. That is not a rollout accident I expect to be corrected next month; it is the current architectural line.

## When do you need multi-agent orchestration at all

Before the harness question, the honest question: does this need more than one agent?

Microsoft's own guidance gives a usable threshold. Split the agent when it exceeds roughly "more than 30-40 choices of action". Below that, you are adding orchestration latency and a second thing to govern for no return. The multi-agent patterns page frames the benefit as modularity: one agent calling others makes solutions "more modular, scalable, and manageable".

My working rule, in the order I actually apply it:

1. **One agent, more instructions.** Cheapest. Works until the instruction file becomes a policy manual nobody re-reads.
2. **One agent, more skills** (GitHub Copilot harness). A procedure that belongs to this agent and loads only when relevant.
3. **One agent, child agents** (standard harness). An embedded specialist that needs its own tool budget, typed inputs, and trigger.
4. **Connected agents.** Separate ownership, separate lifecycle, separate security boundary, or multiple parents consuming the same specialist.
5. **A2A.** The specialist is not a Copilot Studio agent at all.

Steps 2 and 3 are in-agent complexity. Steps 4 and 5 are cross-agent work. Conflating those two categories is the single most expensive modeling mistake I see, and it produces either an unmaintainable god-agent or an org chart of agents nobody can trace a request through.

## Which element lives in which harness

| Element | Standard harness | GitHub Copilot harness | Why |
|---|---|---|---|
| Child agents | Yes | No | Documented only under the standard banner; skills absorb most of the use cases |
| Connected agents (Copilot Studio) | Yes | Yes | Both harnesses; new harness restricted to Copilot Studio-built agents |
| Connected agents (Foundry, Fabric Data, M365 Agents SDK) | Yes | No | Only the standard harness documents the external agent types |
| A2A | Yes | Not documented | The A2A article carries the standard-harness banner; no GitHub Copilot-harness A2A article exists |
| MCP servers as tools | Yes (needs generative orchestration) | Yes | Both, but the new-harness page is still marked prerelease |
| Workflows as tools | Classic agent flows | Yes, GA | "Workflows can give agents access to multistep deterministic automation" |
| Skills | No | Yes | Skills are a GitHub Copilot-harness construct |
| Sandbox/file generation | No | Yes | Native creation and editing of Word, Excel, PowerPoint, and PDF |
| Memory | No | Yes (preview) | New-harness capability |

The practical consequence is blunt. **If you need to reach a non-Copilot Studio agent today — Foundry, SAP, ServiceNow, a partner agent, your own framework — that work belongs in the standard harness.** The new-harness connected agents page states it directly: "you can currently only connect other agents built in Copilot Studio". A2A, Fabric, and M365 Agents SDK multi-agent support went GA back in April 2026 — on the standard side.

## Child agents: more than delegation

The child agent is routinely undersold as "a sub-agent". Read the *Add a child agent* page (updated 25 August 2026), and it is closer to a topic with an orchestrator inside it. Microsoft defines it as "a lightweight agent that exists within the context of your main agent", and inline agents "share context with the main agent" — a child always receives the parent's context, with no opt-out.

What you actually get, and what no skill offers:

**Triggers.** By default, "agents respond to users or triggers, based on their description". But you can bind explicit events: a message is received, a custom client event occurs, an activity occurs, the conversation changes, it's invoked, it's redirected to, the user is inactive for a while, a plan completes, an AI-generated response is about to be sent.

**Explicit invocation.** "It's redirected to" makes the child callable from inside a topic — deterministic hand-off, not description matching. You can also reference it with `/` from instructions.

**Typed inputs and outputs.** Each input carries a display name, description, and data type, with an optional "Make this input required". Outputs are typed the same way. This is a contract, not a prose hand-off.

**Validation and reprompting.** A "Should prompt user" toggle, a Condition with a "Condition not met prompt", up to two reprompts, and an "Action if no entity found" that escalates, sets a value, or leaves it empty.

**Power Fx.** Switch the condition builder to the formula editor, and the routing decision becomes an expression.

**Priority and ordering.** "A lower number indicates a higher priority"; ties are resolved "in the order of creation (oldest first)". Child agents and topics share the same trigger set, so priority is how you keep them from fighting.

**Post-completion behavior.** After running: don't respond (the default), write the response with generative AI, send a specific response, or send an adaptive card.

**Its own orchestration and its own tool limits.** "Because child agents have their own orchestration, they have their own limits for the number of tools." Microsoft calls that separate limit one of the benefits — it is how you partition a parent that has outgrown its tool budget. The stated price is latency, "added by the added layer of orchestration".

That last pair is the real reason child agents survive. They are a tool-budget partition with a typed interface and conversational control, inside one agent boundary.

## Skills: reusable behavior, not a reusable agent

A skill in the GitHub Copilot harness is a different species. Microsoft describes skills as "self-contained sets of instructions and logic", explicitly contrasted with tools "which connect to external services". Selection is by relevance: "The orchestration runtime invokes a skill when a user's request matches the skill's purpose."

The package is deliberately boring: a `SKILL.md` with "a YAML front matter (name, description) and instructions", plus "Optional supporting files, such as scripts, templates, and reference documents", zipped. Authoring is Build → Skills → Create from blank (the name takes "only lowercase letters, numbers, and hyphens") or drag-and-drop upload of a `.md` or a ZIP.

```text
invoice-reconciliation/
├── SKILL.md              # YAML front matter: name, description + Markdown instructions
├── scripts/
│   ├── compare_invoice.py
│   └── create_report.py
├── templates/
│   └── reconciliation-template.xlsx
└── references/
    └── matching-rules.md
```

Because it is Markdown in a ZIP, a skill goes in Git, gets reviewed in a pull request, gets versioned and released independently, and gets attached to several agents. That is the genuine advance over a child agent, which lives and dies inside its parent. It also means an existing GitHub Copilot or Claude-style skill is a plausible starting point, where its instructions and assets fit the Copilot Studio runtime.

The second advance is reviewed code. Instead of the model regenerating a transformation each run, the skill ships a script that was tested once and behaves the same way every time. For reconciliation logic, format validation, or document assembly, that is the difference between a demo and something finance will sign off.

## Child agent versus skill, side by side

| | Child agent (standard) | Skill (GitHub Copilot) |
|---|---|---|
| Boundary | Inside one parent agent | Inside one agent, but portable across agents |
| Reuse | Not reusable outside its parent | Created once, added to multiple agents, exported, source-controlled |
| Invocation | Description match, explicit redirect, or bound trigger | Description match by the orchestration runtime |
| Interface | Typed inputs and outputs, required flags, validation | Instructions in Markdown; no typed contract |
| Conversation control | Reprompts, conditions, priority, adaptive-card completion | None; the agent owns the conversation |
| Own tool limit | Yes — a separate orchestration budget | No — it uses the agent's tools |
| Executable assets | No | Scripts, templates, reference files in the sandbox |
| Versioning | Part of the parent agent's lifecycle | Independent — Git, review, release |

Read across the rows, and the trade is clear. **You give up the typed contract and the conversational controls, and you get portability, reviewed code, and file work.** A skill is not a drop-in replacement for every child agent, and anyone telling you the migration is mechanical has not tried it on a child agent with required inputs and two reprompts.

Where a skill wins: the behavior belongs to one agent, the capability is essentially instructions plus transformation logic plus templates, you want to attach it to several agents, and you do not need an independently governed identity.

Where a child agent still wins: you need an embedded specialist with its own knowledge and tools, you need explicit input/output variables, validation, event triggers, priority or conversational completion, and you want the child-specific tool limit while keeping everything inside one main agent.

## The two limitations of skills nobody reads until it hurts

This is the section I would put in front of any team that has just watched a skills demo.

### 1. A skill is not a connection

A skill does not authenticate. It does not hold a credential. It is not a connector, and it cannot become one. Microsoft's own framing separates the two categories precisely: skills are "self-contained", while tools "connect to external services".

So a skill can hold the classification logic, the HTML template assembly, the field validation, the draft body. It cannot read the shared mailbox. Reading or writing that mailbox is a Graph-backed tool, a workflow, a custom connector, or an MCP server — configured on the agent, governed by the platform, visible to the admin. The script inside the skill cannot obtain a token independently.

### 2. Skill code has no outbound network path

The widely reported behavior of the agent sandbox is that code running in it cannot call Microsoft Graph, cannot call an arbitrary REST API, cannot connect to a database, cannot send mail, cannot download a package at runtime, cannot write to SharePoint, and cannot reach an MCP server over HTTP from the script itself. Even where a networking library such as `requests` is present, the code cannot use it to leave the sandbox. The filesystem is a working area, not durable storage.

**Caveat, and I want to be precise about it:** these specifics — no egress, the Python version, the preinstalled library count, the temporary filesystem — are currently documented in Microsoft's community engineering blog, not on Microsoft Learn. Learn confirms only that tasks run "in a secure sandbox governed by Copilot Studio", plus concrete numbers on the output side: created files are capped at **10 MB per file** with **28-day retention**. Design for no egress, because that is what the runtime does, but do not quote it as a compliance control in an architecture board paper until it lands on Learn.

The pattern that follows from both limits:

```text
Agent reasoning
 |
 +-- Skill instructions
 |    |
 |    +-- Local script execution in the sandbox
 |    +-- Local file transformation
 |    +-- Validation and calculation
 |
 +-- Governed tool  <-- the ONLY way out
      |
      +-- Microsoft Graph
      +-- Dataverse / SharePoint / Dynamics 365
      +-- External REST API
      +-- MCP server
```

The restriction is a feature. No arbitrary egress means no arbitrary exfiltration path, and every external operation stays visible through Copilot Studio tooling, Power Platform data policies, connector controls, and DLP. It also breaks lifted-and-shifted skills. A GitHub Copilot CLI skill happily assumes it can `pip install`, clone a repo, hit an endpoint, read an environment variable, query a database, or start a local service. None of those assumptions transfer. Every network-dependent part has to be refactored into a formal tool before the skill is worth anything in Copilot Studio.

## MCP and A2A are not competitors

They answer different questions, and teams conflate them weekly.

**MCP connects an agent to tools.** It is "a standard for exposing tools to an agent". In the new harness you add one at Build → Tools → Add → Model Context Protocol, giving a name, description, server URL and authentication. On the standard side you must turn on generative orchestration to use MCP at all. Two limits worth planning around: "MCP servers count against the total number of tools", and the number of concurrent instances "is capped" — Microsoft states the cap exists but publishes no integer. Governance is inherited: blocking Power Platform connectors in DLP "also blocks access to tools in connected MCP servers".

**A2A connects an agent to another agent.** It is "an open standard for communication and collaboration between agents", and it lets Copilot Studio "delegate tasks to another agent, not just call APIs". Configuration is Agents → Add agent → A2A agent, where you supply the endpoint URL and the agent card is read from `.well-known` automatically. Authentication is none, API key, or OAuth 2.0. Two details that matter operationally: "A2A connections use the custom connector infrastructure", so your existing connector governance applies; and the payload carries "Full chat history, not just the latest user utterance" — read that sentence again before you delegate to a partner agent outside your tenant.

And once more, because it is the single most load-bearing constraint in this article: **A2A is documented for the standard harness only.** There is no GitHub Copilot-harness A2A article as of early September 2026.

## Connected agents in both harnesses

Connected agents exist on both sides, with different reach.

Definition is common: "separate agents with their own orchestration, tools, and knowledge", and they "can bypass plan limits" — which is the second tool-budget escape hatch after child agents.

On the **standard** harness you add one at Agents → Add an agent → Copilot Studio. The source agent must be in the same environment, published, and have "Let other agents connect to and use this one" enabled. You choose whether to hand over context with the "Pass conversation history to this agent" option — the contrast with a child agent, which always receives the parent's context, is exactly the security boundary you want when the specialist is owned by another team. Documented limits: an agent that has its own connected agents "can't also use the same agent as a connected agent" elsewhere, and "Redirecting to Fabric Data agents isn't currently supported".

On the **GitHub Copilot** harness, connected agents are the principal delegation mechanism, and the orchestrator does more with the result than fire-and-forget. It folds connected-agent output back into a broader working context alongside files, tool results, and intermediate artifacts, and then decides whether to continue, retry, take another path, or stop. That continued orchestration is the actual difference from a single delegated call. The price is the restriction already noted: Copilot Studio agents only.

## Vocabulary, because half the arguments are terminological

I use these five definitions on every engagement, and they end most of the debate:

- **Skill** — behavior belonging inside one agent.
- **Connected agent** — separately owned expertise, security boundary, lifecycle, or a reusable specialist with more than one consumer.
- **Child agent** — an embedded specialist with typed contracts and its own tool budget, inside one parent, standard harness only.
- **Workflow** — a deterministic multi-step process.
- **Tool** — access to an external capability or system. Including MCP. Including the only way out of the sandbox.
- **Knowledge** — information the agent may retrieve and reason over.

In-agent complexity becomes skills. Cross-agent work stays a connected agent. Everything that leaves the tenant boundary is a tool or A2A.

## Money and identity, before the design review

**Billing is the harness distinction with the sharpest edge.** On the GitHub Copilot harness, "All usage is billed based on consumption and measured in Copilot credits", covering "large language model (LLM) tokens, tools (including knowledge and MCPs), and the harness itself". The timing is what catches teams: "Billing starts when you start building", against the standard harness "which starts billing after publish". Building, testing, and evaluating are all metered. The Power Platform admin guidance is equally direct — GitHub Copilot-harness agents are not covered by a Microsoft 365 Copilot license, they are "Billed for all usage", the admin agent inventory now carries a Harness column, and developer and trial environments moved to usage-based billing on 1 September 2026.

**Identity is now automatic.** "Copilot Studio automatically creates a Microsoft Entra Agent ID for each new agent," and you "can no longer opt out". Connector permissions are "re-validated at runtime against Advanced Connector Policies (ACP) and DLP". A dating conflict to be aware of: Learn says this changed "After May 2026"; the September blog says "as of July 2026". Either way, plan for it rather than discovering it in a governance review.

**DLP reaches skills too.** Skills can be blocked wholesale at tenant level through the "Skills with Copilot Studio" connector classification, the same mechanism that governs HTTP, Power Platform connectors as tools, MCP, knowledge sources, channels, and event triggers.

## The architecture I actually recommend

Not a migration. A portfolio.

```text
Standard harness
 |
 +-- Front-door conversations, mandatory question sequences, validation
 +-- High-volume FAQ, intake, routing, support, case creation
 +-- Deterministic routing with topics, Power Fx, adaptive cards
 +-- A2A to Foundry, SAP, ServiceNow, partner and custom agents
 +-- Child agents where typed contracts and tool partitioning matter

GitHub Copilot harness
 |
 +-- Document-intensive and multi-file processing
 +-- Processes where every exception cannot be designed in advance
 +-- Multi-source research producing several deliverables
 +-- Iterative planning, retry, and recovery
 +-- Skills for reusable, reviewed operating procedures
 +-- Connected Copilot Studio agents for genuine cross-agent work

Shared layer
 |
 +-- Workflows for deterministic approvals, writes, notifications
 +-- MCP servers, connectors, REST tools for all governed external access
 +-- Dataverse, Microsoft Graph, Power Platform governance and DLP
```

Standard-harness agents are the responsive, controlled front door. Workflows own the approvals, the writes and the system updates, because that is where determinism is provable. GitHub-harness agents handle the heavy analysis, file processing, exception resolution, and curation. Skills encode the operating procedures. Connected agents represent independently owned domain specialists. Everything that touches an external system goes through a governed tool.

## What I would check before shipping

- **Did you pick the harness before the canvas?** It cannot be changed later without a rebuild.
- **Do you need an external agent?** If yes, it is the standard harness today. A2A is not documented in the new harness.
- **Is that thing a skill or a connection?** If it authenticates or leaves the sandbox, it is a tool. Always.
- **Have you refactored network-dependent skill code?** `pip install`, direct API calls, and database queries don't survive the move.
- **Where does the generated file go?** The sandbox is temporary; files are capped at 10 MB and expire after 28 days. Persist through a tool or hand it to the user.
- **Are you paying to build?** Usage-based billing on the new harness starts at authoring, not at publish.
- **Is the tool budget the actual problem?** If so, a child agent or a connected agent partitions it. A skill does not.
- **Did you confirm the preview status yourself?** Connected agents, memory, Work IQ, and user file upload are marked as preview in the blog; some Learn pages are still prerelease.

Neither harness supersedes the other. The standard harness owns deterministic conversation, mature channels, typed child agents, and documented interoperability. The GitHub Copilot harness owns reasoning, files, skills, and adaptive recovery. The interesting systems being built right now use both, connected by workflows and governed tools — and the teams that get it right are the ones who made the harness decision consciously, on day one, instead of discovering it in month three.

## Sources

- Microsoft Learn, [Harnesses overview](https://learn.microsoft.com/en-us/microsoft-copilot-studio/harnesses-overview), last updated 27 August 2026: the definition of a harness, the three harnesses, comparison guidance, the "secure sandbox governed by Copilot Studio" wording
- Microsoft Learn, [GitHub Copilot harness overview](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/overview), 26 August 2026: agents "can't be transferred" between harnesses
- Microsoft Learn, [Add a child agent](https://learn.microsoft.com/en-us/microsoft-copilot-studio/add-agent-child-agent), 25 August 2026: definition, triggers, typed inputs and outputs, validation and reprompts, Power Fx conditions, priority, after-running behavior, separate orchestration and tool limits, latency trade-off
- Microsoft Learn, [Skills overview](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/skills-overview), 26 August 2026, and [Create a skill](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/skills-create) / [Add an existing skill](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/skills-add-existing), 3 August 2026: skills as self-contained instructions versus tools, SKILL.md and YAML front matter, packaging, authoring and upload paths, runtime selection
- Microsoft Learn, [Connected agents overview](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/authoring-add-other-agents), 26 August 2026: new-harness connected agents, the Copilot Studio-only restriction
- Microsoft Learn, [Connect to an existing agent](https://learn.microsoft.com/en-us/microsoft-copilot-studio/add-agent-copilot-studio-agent), 3 August 2026: standard-harness configuration path, pass-conversation-history option, connected-agent limits
- Microsoft Learn, [Agent-to-agent (A2A)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/add-agent-agent-to-agent), 26 August 2026: standard-harness banner, endpoint and agent card configuration, authentication options, custom connector infrastructure, full chat history in the payload
- Microsoft Learn, [Add an MCP server as a tool](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/tools-add-mcp-server), 29 July 2026 (prerelease), and [Tools overview](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/tools-overview), 26 August 2026: configuration path, MCP counting against tool limits, concurrency cap, DLP inheritance
- Microsoft Learn, [Files the agent creates](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/created-files-overview), 29 July 2026: 10 MB per file, 28-day retention
- Microsoft Learn, [Multi-agent orchestration patterns and best practices](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/multi-agent-patterns), 22 May 2026: modularity rationale, inline agents also known as child agents, shared context, the 30-40 choices-of-action split threshold
- Microsoft Learn, [Copilot credits overview](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/billing-credit-overview), 31 August 2026, and [Manage usage for the GitHub Copilot harness](https://learn.microsoft.com/en-us/power-platform/admin/manage-usage-github-copilot-harness), 28 August 2026: consumption billing, what credits cover, billing at build time, the Harness column, 1 September 2026 change for dev and trial environments
- Microsoft Learn, [Manage Entra Agent IDs](https://learn.microsoft.com/en-us/microsoft-copilot-studio/admin-use-entra-agent-identities), 26 August 2026, and [Data loss prevention](https://learn.microsoft.com/en-us/microsoft-copilot-studio/admin-data-loss-prevention), 15 May 2026: automatic agent identity, runtime re-validation against ACP and DLP, the Skills with Copilot Studio connector classification
- Microsoft Copilot Studio Blog, [New and improved: GitHub Copilot harness, agent skills, and richer context](https://www.microsoft.com/en-us/microsoft-copilot/blog/copilot-studio/new-and-improved-github-copilot-harness-agent-skills-and-richer-context/), 2 September 2026: GA of the GitHub Copilot harness, preview markers on connected agents, memory, Work IQ and user file upload, workflows and MCP servers as tools
- Microsoft Copilot Studio Blog, [New and improved: multi-agent orchestration, connected experiences, and faster prompt iteration](https://www.microsoft.com/en-us/microsoft-copilot/blog/copilot-studio/new-and-improved-multi-agent-orchestration-connected-experiences-and-faster-prompt-iteration/), 1 April 2026: A2A, Fabric and M365 Agents SDK multi-agent GA, the Ask Microsoft sub-agent pattern, Coca-Cola Beverages Africa
- Microsoft TechCommunity, [White paper: choosing between the GitHub Copilot and standard harnesses in Copilot Studio](https://techcommunity.microsoft.com/blog/copilot-studio-blog/white-paper-choosing-between-the-github-copilot-and-standard-harnesses-in-copilo/4552385), September 2026: the harness as operating layer, decision guidance
- Microsoft CAT community blog, [The new Copilot Studio agent sandbox](https://microsoft.github.io/mcscatblog/posts/copilot-studio-agent-sandbox/): no outbound network path, Python runtime and preinstalled libraries, non-permanent storage, egress only through knowledge sources and tools. **Not Microsoft Learn** — treat the no-egress statement as community-sourced until it is published on Learn