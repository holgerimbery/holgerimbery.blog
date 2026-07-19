---
layout: post
title: "Multi-Agent Orchestration with Copilot Studio — Part 3: The Build 2026 Rebuild"
description: "Microsoft rebuilt Copilot Studio at Build 2026: a four-surface agent model, Skills as Markdown, a Memory surface, a new agentic orchestrator, a new workflow designer, and convergence with Microsoft Foundry. What changed, what it means for the patterns in Parts 1 and 2, and how to think about the move."
date: 2026-07-18
author: admin
slug: copilot-studio-orchestration-part3
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/05/andy-kelly-0E_vhMVqL9g-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@askkell?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Andy Kelly</a> on <a href="https://unsplash.com/photos/photo-of-girl-laying-left-hand-on-white-digital-robot-0E_vhMVqL9g?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
      
tags: [agents, copilotstudio, Multi-Agent, orchestration, skills, memory, workiq, build2026]
featured: true
toc: true
---

{: .q-left }
> **Summary lede.** This is the third of three articles in the multi-agent orchestration series. Where Parts 1 and 2 cover the released, generally available Copilot Studio — the classic model built on generative orchestration — Part 3 turns to the rebuilt experience Microsoft introduced at Build 2026. At Build 2026 (June 2–3) and in the *"Meet the new Copilot Studio"* post that followed on June 9, Microsoft shipped a rebuilt Copilot Studio: a streamlined four-surface agent model (Skills, Tools, Knowledge, Connected agents) plus a Memory surface, a new agentic orchestrator built on a coding-harness and CLI layer, a redesigned workflow designer, and a deeper convergence with Microsoft Foundry under a shared knowledge layer called Microsoft IQ. Parts 1 and 2 describe the *classic* model — the five surfaces, child agents, the four patterns — which still ships and is fully supported. Part 3 describes what replaces it as the default forward path, what is genuinely new, and what carries over unchanged.

{: .q-left }
> **About this series.** This is Part 3 of three. **Part 1 — Foundations** establishes the vocabulary, when to split a single agent, the five configuration surfaces, the four orchestration patterns, and how MCP and A2A are configured. **Part 2 — In Practice** turns those decisions into four end-to-end scenarios, a starter MCP server inventory, and ten production anti-patterns. Parts 1 and 2 describe the **released, generally available feature set** — the "classic" Copilot Studio experience, built on **generative orchestration**, which is GA and fully supported. **Part 3 — The Build 2026 Rebuild** (this article) describes the new four-surface model (Skills, Memory, a new orchestrator); those features are **in public preview and subject to change** before general availability. Read Part 3 as forward-looking: surface names, behaviors, and availability may be adjusted before GA, so verify the current status before committing a production design to it.

{: .q-left }
> **Status, stated plainly.** The new experience is in **public preview**. It is available in production environments worldwide, and Microsoft's own post says it is "ready to create agents for production use." Still, the same post includes an explicit correction: the features are in public preview, not generally available. The new and classic experiences **coexist** — you opt into the new one with "Try now" on the Copilot Studio homepage, and your classic agents keep working. Treat everything in this article as a preview unless noted, and re-check the status before committing a production design to it.

{: .q-left }
> **Update since Parts 1 & 2 were published.** A few developments since those articles went out, re-verified against Microsoft Learn as of mid-July 2026. The **Windows 365 for Agents MCP server** is now **generally available**, giving an agent full operational control over a Windows 365 cloud PC — desktop interaction, browser automation, and semantic UI inspection — extending the Computer Use / computer-using-agent thread from Part 2's IT-triage scenario. The **classic experience remains fully supported, and nothing in the rebuild is deprecated**, so Parts 1 and 2 remain the accurate reference for classic agents. And the two time-sensitive facts those articles turn on still hold: **A2A reached general availability in April 2026**, and **CVE-2026-21520 ("ShareLeak," CVSS 7.5)** remains the relevant indirect-prompt-injection disclosure — patched in January 2026, publicly disclosed in April 2026 — with no newer CVE superseding it.

{: .q-left }
> **Why read this**
Read this if you read Parts 1 and 2, opened Copilot Studio, and found a different product than the one those articles described — four tabs instead of nine, "Skills" where you expected child agents, a "Memory" surface that wasn't there before, and a chat that references Markdown files. Nothing in Parts 1 and 2 is wrong for the classic experience, but the vocabulary has moved. This article reconciles the two: it maps the classic five surfaces onto the new four-plus-Memory model, explains what "Skills" now means (and the naming trap that comes with it), and shows that the four orchestration patterns survive the change intact. Read it before you start a new build in the new experience, so you pick the right surface for each piece from the start.

---

## 1. What changed, in one paragraph

Copilot Studio used to present an agent as nine configuration tabs and a mental model of five surfaces — Instructions, Knowledge, Tools, Topics, Triggers — with child agents and connected agents as the two ways to compose with it. The rebuilt experience collapses that to **four surfaces — Skills, Tools, Knowledge, Connected agents — plus a Memory surface in preview**, driven by a new orchestrator that behaves much more like a coding agent than a dialog engine. "Skills" is the headline change: agent behavior is now authored as **reusable Markdown that loads on demand**, in the same `SKILL.md` style used by GitHub Copilot and Claude Code — and Copilot Studio can import those existing skills directly. Child agents, as a distinct surface, are absent from the new model; their two jobs are absorbed by Skills (factoring behavior into a single agent) and Connected agents (collaboration across agents). Underneath, Copilot Studio and Microsoft Foundry are converging on a single runtime and knowledge layer (Microsoft IQ), so a low-code Copilot Studio agent and a pro-code Foundry agent can act as peers.

The rest of this article unpacks each of those, with the classic-to-new mapping made explicit.

## 2. From nine tabs to four surfaces

The most visible change is the reduction from nine configuration tabs to four, with the essential configuration brought to the front. The new agent surfaces are:

1. **Skills** — define behaviors through structured instructions, authored as Markdown and loaded on demand. (This is new; see §3.)
2. **Tools** — connect the agent to external systems and actions: connectors, Power Automate flows, MCP servers, and now Work IQ MCP tools.
3. **Knowledge** — provide trusted context to guide decisions: SharePoint, Dataverse, files, Graph connectors, and so on. In the new experience, **Microsoft IQ** sources plug in here too — **Work IQ** (Microsoft 365 org data), **Fabric IQ** (Fabric business data and analytics), and **Foundry IQ** *(preview)*, which ground the agent on enterprise knowledge bases indexed by Azure AI Search in Azure AI Foundry. (See §5.)
4. **Connected agents** — collaborate across agents to complete work (Copilot Studio agents, plus external agents over A2A, and Microsoft Foundry / Fabric / M365 Agents SDK agents in preview).

Plus, in preview, a fifth surface:

5. **Memory (preview)** — remember interactions, workflows, and context for improved results across sessions. (See §5.)

Mapping this back to the classic five surfaces from Part 1:

| Classic surface (Parts 1–2) | Where it lives in the new model |
|---|---|
| **Instructions** | Largely subsumed by **Skills** — base instructions remain, but reusable behavior moves into load-on-demand markdown skills |
| **Knowledge** | **Knowledge** — unchanged in concept |
| **Tools** | **Tools** — unchanged in concept, now including Work IQ MCP tools |
| **Topics** | De-emphasized — the new orchestrator reduces the need for hand-authored topic trees; deterministic logic moves into **workflows** (see §6). Topics remain in the classic experience |
| **Triggers** | Still present for autonomous/event-driven runs; less prominent in the streamlined surface set |
| **Child agents** | **Removed as a surface** — folded into Skills (in-agent behavior) and Connected agents (cross-agent) |
| **Connected agents** | **Connected agents** — unchanged in concept |
| *(new)* | **Memory (preview)** — persistent cross-session understanding |

The practical effect is that the new model pushes you toward two clean compositional choices — **Skills** for what one agent should know how to do, and **Connected agents** for handing work to another agent — instead of the older three-way split that included child agents.

## 3. Skills: behavior as load-on-demand markdown

In the rebuilt experience, **Skills** are *"reusable instructions in Markdown that can load on demand for completing specific tasks,"* and — importantly — you can *"import skills you already have, including existing GitHub Copilot or Claude Code skills."* That single sentence is the most consequential change in the release.

### What this actually is

A skill in this sense is the **`SKILL.md` pattern**: a Markdown file with light frontmatter (a `name` and a `description` of when to use it) and a Markdown body of instructions, examples, and guidelines. The orchestrator reads the descriptions and **loads the full skill body only when a task needs it** — progressive disclosure, rather than stuffing every rule into one always-on instruction block. This is the same convention that GitHub Copilot and Claude Code use for agent skills, and Copilot Studio now supports it natively, including the ability to import skills authored for those tools. You author a skill once, add it to multiple agents, and can export it as a Markdown file or package to share — the reusable-library model those coding tools already use.

### Why it matters for everything in Parts 1 and 2

Two of the recurring lessons in the earlier articles were "keep the instruction block small" (Part 1's 8,000-character limit) and "factor complexity into child agents." Skills address both more directly:

- **The instruction-bloat problem.** Instead of one monolithic instruction block bumping the 8,000-character ceiling, behavior is split into focused skills that load only when relevant. The "god agent" anti-pattern (Part 2, anti-pattern 1) gets a native remedy at the instruction layer, not only at the agent layer.
- **The child-agent use case.** Part 1 used child agents to "factor complexity inside one parent." That job is now a **skill**, not a sub-agent. You no longer create a child agent named "Validate Expense Code"; you write a `validate-expense-code` skill that loads when needed.

### The naming trap — two different "skills"

Be careful: Copilot Studio now has **two unrelated things called "skills." ** ****

1. **Classic skills** (still on Microsoft Learn) — a deployed Bot Framework / Microsoft 365 Agents SDK *bot*, registered as an agent via a **manifest URL**, used for complex multi-turn server-side scenarios. Pro-code, registered under Settings → Skills.
2. **New skills** (the rebuilt experience) — ** Markdown instruction modules** (`SKILL.md` style) that load on demand—Low-code, authored or imported as files.

These are different concepts with the same name. When you read "skills" in the documentation, check whether it means a manifest-registered bot or a Markdown behavior module. This article uses the **new markdown** format unless it says otherwise.

### Design guidance for skills

The Part 1 guidance about tool descriptions transfers almost verbatim to skill descriptions: the **description is what the orchestrator routes on**. A skill described as "Expense logic" will be loaded unpredictably; a skill described as "Validates an expense code against the FY26 policy matrix; use when the user submits or questions an expense line" will load when it should. Keep each skill narrow, name it for one job, and write the description for the router, not for a human reader.

## 4. The new agentic orchestrator

The surface changes sit atop a new engine. Microsoft describes a **new agentic orchestrator** *"built on a new coding harness and CLI layer,"* with:

- **Stronger instruction adherence** — agents follow their instructions and skills more reliably.
- **Long-horizon task execution** and **recursive task execution** — the orchestrator can work through multi-step, dynamic problems that decompose into sub-tasks, rather than a single planning pass.
- **Large-content handling** and **rich file outputs** — it can process large volumes of content and produce documents and data files, opening up document-generation and data scenarios that were awkward before.

For readers of Part 2, this matters in two concrete ways. First, the **sequential pipeline** and **hierarchical** patterns get easier, because the orchestrator itself now does long-horizon, recursive decomposition — some of what you previously assembled out of multiple agents and a Dataverse state table, the orchestrator can carry within a single agent's run. Second, the **"specialists are boring"** principle still holds, but the threshold for when you *need* to split shifts: a single new-orchestrator agent can reliably do more before it hits the limits that forced decomposition in the classic model. The Part 1 signals for splitting (tool count, owners, conflicting knowledge, divergent SLAs) remain the right criteria; the tool-count number is just less likely to be the first wall you hit.

The harness-and-CLI framing is deliberate. It is the same shape as a modern coding agent — which is also why importing GitHub Copilot and Claude Code skills works at all: the runtime is built to consume that ecosystem's conventions.

On the model side, the new experience lets you pick the orchestrator's primary model directly: **Claude Sonnet 5** and **GPT-5.5 Chat** are now generally available choices. Hence, the instruction-adherence gains come from both the new harness and a current-generation model underneath it.

## 5. Memory and Microsoft IQ

The new **Memory** surface (preview) — *"remember interactions, workflows and context for improved results"* — is the agent-facing edge of a larger platform layer.

### Work IQ and its three layers

On Microsoft Learn, **Work IQ (preview)** is described as *"the intelligence layer that grounds Microsoft 365 Copilot and your agents in real-time, shared context across your organization."* It is built on three layers:

- **Data** — unifies signals from files, emails, meetings, chats, and business systems across Microsoft 365 to capture how work actually happens.
- **Memory** — *"builds persistent understanding of how people and teams work, enabling Agent 365–managed agents to stay aligned to priorities and remain consistent across tasks, apps, and sessions."* This is the layer behind the agent **Memory** surface.
- **Inference** — brings together models, skills, and tools so agents can reason and act, using Work IQ MCP tools, under the Agent 365 control plane.

You add Work IQ to an agent as **Work IQ MCP tools** (Tools → Add tool → Model Context Protocol → e.g., *Work IQ Mail*, *Work IQ Calendar*, *Work IQ Teams*). It requires a Microsoft 365 Copilot license. Work IQ in Copilot Studio is **preview-only today, with general availability "coming soon"**; Microsoft's documentation states that once Work IQ reaches GA, the **Work IQ API transitions to a usage-based (consumptive) billing model** — so that billing is not yet in effect. Governance runs through Agent 365 and the Microsoft 365 admin center (admins allow or block servers tenant-wide), with tool-call tracing in Microsoft Defender Advanced Hunting.

### Microsoft IQ — the umbrella

Work IQ is one of three "IQ" layers under the broader **Microsoft IQ** banner introduced around Build 2026. In the new Copilot Studio experience, Microsoft Learn documents Microsoft IQ as a context layer with **three sources**: **Work IQ** (Microsoft 365 org data — emails, chats, files, calendar, people — routed through the Agent 365 MCP gateway), **Fabric IQ** (business data and analytics in Microsoft Fabric), and **Foundry IQ** *(preview)*, which grounds the agent on enterprise knowledge bases indexed by Azure AI Search in Azure AI Foundry. Turning on a Microsoft IQ source gives the agent both read access (knowledge) and actions (tools), always within the signed-in user's permissions. Both Copilot Studio and Foundry draw on the same Microsoft IQ layer, which is part of what enables the convergence in §7. (Some Build 2026 community write-ups group the family differently — e.g., Work IQ / Foundry IQ / Web IQ; the Copilot Studio documentation itself lists Work IQ / Fabric IQ / Foundry IQ.)

### How Memory changes the hierarchical pattern

Part 2's employee-onboarding scenario leaned on a Dataverse `OnboardingCase` table because "if the process outlives the conversation, so should the state." Memory does not replace that — durable, queryable business state still belongs in Dataverse — but it changes what you have to encode by hand. Memory carries *understanding of how people and teams work* across sessions, so the agent retains continuity (priorities, prior interactions) without you modeling every bit of it as a table column. The rule of thumb: **structured process state → Dataverse; learned context and continuity → Memory.**

## 6. The new workflow designer

Part 2 built its pipeline and fan-out scenarios on **agent flows**. The rebuilt experience replaces that with a **new workflow designer**: a single, unified visual canvas with **node-by-node testing** and **robust versioning**, intended to combine deterministic steps with agent intelligence in one place.

The pieces that matter for the orchestration patterns:

- **Agent nodes** — call an existing agent directly inside a workflow, so you get deterministic workflow execution for the predictable parts and hand off to an agent for the open-ended parts. This is the cleanest expression yet of Part 2's "structured where needed, adaptive where valuable."
- **MCP servers in workflows (preview)** — workflows can call MCP-server tools directly, staying within Microsoft security, permission, and compliance boundaries.
- **AI-powered actions** — classification, content generation, and decision-support actions drop into a workflow as nodes, alongside a **Microsoft 365 Copilot action node** (send a prompt to Microsoft 365 Copilot or a specific agent) and **human review/approval** actions.

In practice, the four patterns from Part 2 now have a more direct home:

- **Router-worker** → a workflow that classifies (classification action) and routes to agent nodes.
- **Sequential pipeline** → a workflow with ordered nodes, each an agent node or AI action, with human-review nodes at decision points.
- **Parallel fan-out / fan-in** → parallel branches of agent nodes joined by an aggregation step.
- **Hierarchical** → a supervisor workflow that invokes agent nodes and persists durable state in Dataverse, now with Memory carrying cross-session continuity.

The patterns did not change. The surface you build them on did.

## 7. Foundry and Copilot Studio converge

The strategic frame from Build 2026 is that **Microsoft Foundry and Copilot Studio are two front doors over one agent runtime** — Foundry, the pro-code platform (Python/.NET, SDKs, managed runtime); Copilot Studio, the low-code platform (visual designer, same governance and protocols underneath). They share three things:

- **The A2A protocol**, so a Foundry agent and a Copilot Studio agent can talk to each other as peers (exactly the cross-platform case Part 1 introduced A2A for).
- **The Microsoft IQ knowledge layer** (Work IQ, Foundry IQ, Web IQ).
- **The Microsoft Agent Framework (MAF)** — the unification of Semantic Kernel and AutoGen into one agent harness — which can host agents that either front door builds.

For a platform team, the takeaway is the one Part 1 hinted at and this release makes literal: **standardize on the protocol and the knowledge layer, not the build tool.** Let pro-code teams use Foundry and low-code teams use Copilot Studio, knowing the agents interoperate over A2A and share Microsoft IQ. The multi-agent architecture you designed in Parts 1 and 2 does not need to be re-decided for each tool; it is decided once at the protocol and knowledge layers.

{: .q-left }
> A sourcing note:
The new-experience surfaces, Skills-as-markdown, the new orchestrator, the workflow designer, and Work IQ/Memory are documented on first-party Microsoft sources (the Copilot Studio Blog and Microsoft Learn). The broader Foundry⇄Copilot Studio convergence details — Foundry IQ, Web IQ, and the Microsoft Agent Framework's role — are drawn from Build 2026 engineering analysis, citing Microsoft DevBlogs and Learn; treat the specific convergence mechanics as directionally confirmed and verify the parts that matter to your design. Since first drafting, two of those pieces firmed up: **Microsoft IQ and Foundry IQ now have their own Microsoft Learn pages** (*Microsoft IQ overview for agents (preview)* and *Connect to Foundry IQ from an agent (preview)*), which document Microsoft IQ's sources as **Work IQ, Fabric IQ, and Foundry IQ** — so the **Web IQ** grouping and the **Microsoft Agent Framework's** exact role are the parts that still rest on the community analysis.

## 8. What to do now

The new experience is a preview and coexists with the classic, which makes the right posture straightforward:

- **New builds you intend to keep:** start in the new experience and the four-surface model. Author behavior as **Skills** (narrow, well-described markdown), use **Connected agents** for cross-agent work, reserve **Tools/Knowledge** for actions and context, and turn on **Memory** where cross-session continuity helps. Build orchestration in the **new workflow designer** with agent nodes.
- **Existing classic agents:** leave them. They keep working, and Parts 1 and 2 remain the accurate reference for them. Migrate when you have a reason — a redesign, a new requirement, or the new orchestrator's reliability gains — not reflexively.
- **Skills you already have** for GitHub Copilot or Claude Code: you can import them, which makes the new model a low-friction on-ramp if your teams already author `SKILL.md` files.
- **Governance:** the Part 2 disciplines do not change — Entra Agent ID per agent, least privilege, audit through Purview/Defender, idempotency on writes, structured contracts. Work IQ and the new tools route through Agent 365 governance in the Microsoft 365 admin center; fold that into the same review process.
- **Watch the status.** This is preview. Reconfirm GA timing and any surface renames before you bet on a production rollout on the new model, and keep classic as the fallback until the new experience reaches GA for the capabilities you depend on.

## Conclusion

Parts 1 and 2 settled the architecture of multi-agent systems in Copilot Studio and showed it in execution. Part 3 is the reminder that the platform underneath an architecture moves, and that the durable parts are the ideas, not the tabs. The Build 2026 rebuild changes the surfaces — **Skills** instead of sprawling instructions and child agents, a **Memory** surface, a new orchestrator, a new workflow designer — but it does not change the load-bearing decisions: narrow agents with clear ownership, behavior factored into small, well-described units, structured contracts between components, state that outlives the conversation, and least-privilege governance. Skills are the new home for "factor the complexity"; Connected agents and A2A are still how agents collaborate; the four patterns still cover the work. The names on the tabs changed. The discipline did not.

## Sources

- Microsoft Copilot Studio Blog — [Meet the new Copilot Studio: rebuilt for more complex, multi-step work](https://techcommunity.microsoft.com/blog/copilot-studio-blog/meet-the-new-copilot-studio-rebuilt-for-more-complex-multi-step-work/4526488) (June 9, 2026) — four-surface model, nine-to-four tabs, new agentic orchestrator, Skills as markdown (import GitHub Copilot / Claude Code skills), new workflow designer with agent nodes and MCP servers; **public preview**, coexisting with classic
- Microsoft Learn — [Work IQ MCP overview (preview)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/use-work-iq) — Work IQ's Data / Memory / Inference layers, Work IQ MCP tools, Agent 365 governance; Work IQ is in preview with GA "coming soon" and usage-based Work IQ API billing taking effect at GA
- Microsoft Learn — [Microsoft IQ overview for agents (preview)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/use-microsoft-iq) — Microsoft IQ as a context layer with three sources (Work IQ, Fabric IQ, Foundry IQ *(preview)*); see also *Connect to Foundry IQ from an agent (preview)* and *Turn on Microsoft IQ for an agent (preview)*
- Microsoft Learn — [What's new in Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/whats-new) — the new agent experience as "Production-ready preview" (June 2026); **Windows 365 for Agents MCP server (GA)**; **Foundry IQ** knowledge source *(preview)*; **Claude Sonnet 5** / **GPT-5.5 Chat** primary models (GA); workflow nodes (Microsoft 365 Copilot node, prompt node, classification); Computer Use GA (May 2026); A2A GA (April 2026)
- Microsoft Copilot Studio Blog — [What's new in Copilot Studio: May 2026](https://www.microsoft.com/en-us/microsoft-copilot/blog/copilot-studio/new-and-improved-computer-using-agents-a-new-workflows-experience-and-real-time-voice-experiences/) — redesigned workflows experience, agent nodes, AI-powered actions
- Microsoft Learn — [Use skills in Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-use-skills) and [Configure skills](https://learn.microsoft.com/en-us/microsoft-copilot-studio/configuration-add-skills) — the *classic* (manifest-registered) meaning of "skills," for disambiguation
- GitHub Docs — [Adding agent skills for GitHub Copilot](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-cloud-agent/add-skills) and [Custom skills (Copilot SDK)](https://docs.github.com/en/copilot/how-tos/copilot-sdk/features/skills) — the `SKILL.md` Markdown skill format Copilot Studio now imports
- Redmond Magazine — [Microsoft Unveils Redesigned Copilot Studio for Complex AI Agent Workflows](https://redmondmag.com/blogs/redmond-dispatch/2026/06/microsoft-unveils-redesigned-copilot-studio.aspx) (June 9, 2026) — independent coverage of the rebuild
- Build 2026 engineering analysis (community, citing Microsoft DevBlogs/Learn) — [Microsoft Foundry & Copilot Studio at Build 2026](https://www.linkedin.com/pulse/microsoft-foundry-copilot-studio-build-2026-satyanarayana-padidapu-2djfc) — one-runtime / two-front-doors convergence, Microsoft IQ (Work IQ / Foundry IQ / Web IQ), Microsoft Agent Framework; treat convergence mechanics as directionally confirmed
- Parts 1 and 2 of this series — the classic five-surface model and the four orchestration patterns this article maps forward
