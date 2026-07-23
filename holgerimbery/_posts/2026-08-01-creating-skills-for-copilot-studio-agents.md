---
layout: post
title: "Creating Skills for Copilot Studio Agents: A Practical Guide to SKILL.md and Behavior-as-Code"
description: A hands-on, deep-researched guide to building reusable Skills for the new Copilot Studio agent experience — the SKILL.md format, bundling scripts and resources, authoring and uploading, how the orchestrator invokes them, best practices, and governance. Deliberately kept separate from the legacy Bot Framework skill model. Fact-checked against Microsoft Learn and the Copilot Studio CAT blog.
date: 26-08-01
author: admin
slug: creating-skills-copilot-studio-agents
canonical_url: https://holgerimbery.blog/creating-skills-copilot-studio-agents
image: /images/2026/08/swello-ly8NZU7Nsdg-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@getswello?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Swello</a> on <a href="https://unsplash.com/photos/people-working-on-laptops-with-notebooks-and-notebooks-ly8NZU7Nsdg?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
      

tags:
    - agents
    - copilotstudio
    - microsoftcopilotstudio
    - skills
    - skillmd
    - agentskills
    - orchestration
    - behavior-as-code
featured: false
toc: false
---

{: .q-left }
> **Summary Lede**: In the new Copilot Studio agent experience, a **Skill** is the cleanest place to put the situational, procedural know-how your organization can't expect a model to invent on its own. A Skill is a small, portable unit — a **name**, a **description**, and a set of **Markdown instructions** — that the orchestrator loads *on demand*, only when a task matches. When behavior needs more than prose, a Skill can also bundle **scripts, templates, and reference files** in a package.

This article is a build guide. It walks through what a Skill is, how to write a `SKILL.md`, how to add code and resources, how the orchestrator decides to invoke it, how to author and manage Skills in Copilot Studio, and how to govern them. It stays strictly on the **new, Markdown-based Skills** and keeps them separate from the older Bot Framework "skill," which is an unrelated mechanism that shares only a name.

{: .q-left }
> **Why read this**
- Read this if you want to **author your first "SKILL.md"** for a Copilot Studio agent and ship it correctly the first time.
- Read it if you keep pouring procedural guidance into one ever-growing instruction block and want a **modular, reusable home** for it instead.
- Read it if you need to bundle **scripts and resources** ("skill + code") and want to know what actually runs, and where.
- And read it if the word **"skill"** keeps colliding in your head with the *old* Bot Framework skill — because §11 pulls the two cleanly apart.

## What a Skill is — and what it isn't

A Skill is a **reusable capability that extends what your agent can do** by teaching it *how* to approach a class of tasks. It is defined by three things: a **name**, a **description**, and **Markdown instructions**.

The cleanest way to place it is against the other components you assemble inside an agent:

- Unlike a **tool**, a Skill does **not** connect to an external service.
- Unlike **knowledge**, a Skill does **not** supply reference facts.
- A Skill provides **procedural expertise and reusable behavior** — the step-by-step way *your* organization does something that the model cannot infer on its own.

```text
Knowledge  ->  facts the agent can look up
Tools      ->  actions the agent can take
Skills     ->  the situational know-how to use both well
```

Two properties make this more than a tidy abstraction. First, the format is **not** a Copilot Studio invention — Copilot Studio Skills are based on the **Agent Skills open format**, an open standard originally developed by Anthropic and now shared with GitHub Copilot and Claude Code. Second, a Skill **guides** the agent; it does not straitjacket it. The model still reads the situation and decides whether to follow the Skill to the letter or adapt — which is the entire reason to use an LLM in the first place. The Skill just makes sure the right expertise is in the room when the task shows up.

## Why factor behavior into a Skill

A Skill is "just instructions," so the honest question is why break instructions out into a discrete Skill at all. It comes down to four things — two structural, two conditional.

- **Manageability.** Instead of one ever-growing instruction blob, each Skill is a focused, self-contained unit you can reason about, review, and version one at a time.
- **Context management.** Skills load on demand. The agent keeps only names and descriptions in view by default and pulls full instructions into context only when a task matches. *Ten Skills cost you ten short descriptions, not ten full sets of instructions, on every turn* — so the context window stays lean.
- **Accuracy.** A Skill can carry precise tool-use guidance — which tool to reach for, which parameters matter, how to shape a query, what to validate before calling, what to do when a tool returns nothing — brought into context only when relevant. With large or overlapping toolsets this can make the agent call tools more reliably. It is *use-case dependent*, so evaluate it rather than assume it.
- **Speed and cost.** Nudging the agent toward the right approach means fewer knowledge searches, tool calls, and reasoning loops — fewer round-trips before it answers. Also use-case dependent; measure it.

{: .note }
**Reality check.** Manageability and context management are structural and apply almost everywhere. Accuracy and speed depend on your agent — and every Skill you load still has a context-window and cost footprint. "Modular" is not the same as "free."


## Anatomy of a SKILL.md

Every Skill reduces to the same portable shape: **YAML front matter** (name and description) followed by a **Markdown body** (the instructions).

```markdown
---
name: architecture-review
description: Reviews solution designs for compliance with enterprise
  architecture standards. Use when the user asks for architecture
  validation, design critique, platform fit, or governance review.
  Do not use for cost estimation or licensing questions.
---

# Objective
Review a solution architecture and identify risks, gaps, and recommendations.

# Process
1. Identify the business goal.
2. Extract the proposed architecture.
3. Check integration, security, data, and governance concerns.
4. Identify missing decisions.
5. Produce a concise review with risks and recommendations.

# Rules
- Do not assume undocumented requirements.
- Separate facts from recommendations.
- Highlight open questions.
- Prefer enterprise platform standards where applicable.
```

**Naming rules.** Use only lowercase letters, numbers, and hyphens; don't start or end the name with a hyphen (e.g. `customer-support-escalation`). Pick a descriptive, kebab-case name — when you download a Skill, the file is named after it, so a clean name doubles as a clean filename. In the wider open format, the practical limits are a **name of ≤64 characters** and a **description of ≤1024 characters**.

**The description is the load-bearing field.** It is **routing metadata for the runtime, not a human-facing comment.** The orchestrator reads it to decide whether the Skill is relevant to a request. A vague description ("Helps with architecture") produces unpredictable activation; a precise one — stating *what* the Skill does *and when to use it (and when not to)* — helps the orchestrator pick the right capability at the right moment.


## Adding code: bundling scripts and resources

Instructions alone cover many Skills. When a Skill needs to travel with more than prose, you package it as a **ZIP** whose required entry point is a `SKILL.md` at the root, alongside optional supporting files. The open format's full folder shape looks like this, and **Copilot Studio supports it today**:

```text
my-skill/
├── SKILL.md        # required: metadata + instructions
├── scripts/        # optional executable code (e.g. Python)
├── references/     # optional documentation the Skill can consult
└── assets/         # optional templates and other resources
```

Two things about the "code" part are worth being precise about:

- **Bundled scripts run in the agent's sandbox, on demand.** A Skill can carry Python scripts and reference them from its instructions; they are loaded when the Skill is selected. A concrete public example is the CAT gallery's **PowerPoint Deck Designer**, which builds decks from a JSON spec using `python-pptx` running natively in the agent's Python container — **no external Azure Function required**. (Microsoft's CAT team notes a dedicated walkthrough of scripts-and-resources is coming in a follow-up post, so treat runtime specifics as still firming up and validate behavior in **Preview**.)
- **Skills can *soft-point* at the agent's own tools, not just bundled scripts.** A Skill's instructions can say "use the `order-lookup` action here," referencing the agent's existing actions, flows, connectors, or MCP servers. It is a **soft pointer**: the Skill references the capability but does not bind to or grant it. If the agent doesn't already have that tool, the instruction simply can't be fulfilled — and even when it does, the orchestrator still decides whether to follow the pointer.

{: .note }
**Be precise about "skill + code."** Package your scripts, templates, and reference material with the Skill and have the instructions **reference** them explicitly. But remember a Skill *guides* — it does not guarantee a tool exists or that a script will be run a particular way. Verify the end-to-end behavior in the reasoning view before trusting it.

## How the orchestrator finds and runs your Skill

You don't "call" a Skill directly. The orchestrator **selects** it — based on its name and description — when the conversation matches, then follows its instructions step by step, including reaching for the right tool at the right moment.

This works because Copilot Studio registers knowledge, tools, and Skills the same way: **only their metadata — names and descriptions — sits in context by default**, and the full content is pulled in **on demand** when a prompt matches. (The agent's own top-level instructions are the exception: they are always loaded in full.) This pattern is often called **progressive disclosure** or **dynamic loading**, and it is what keeps large agents manageable.

```text
Agent context (always):   general instructions
In view by default:       metadata for Knowledge A,B,C · Tools A,B,C · Skills A,B,C
User prompt  ->  orchestrator evaluates: which Skill matches?
Match: Skill B  ->  load Skill B's full instructions (+ optional scripts/resources)
Agent acts on:   general instructions + Skill B + the knowledge/tools it needs
```

**The reasoning view is your main debugging surface.** You can watch the orchestrator load a matching Skill and follow it. Use it to tune activation:

- If a Skill **fires too often**, its description is probably **too broad**.
- If it **never fires**, the description is **too narrow** — or it doesn't match the words your users actually use.


## Creating a Skill in Copilot Studio — three paths

**Prerequisite for all paths:** an agent created in the new experience. Skills live in the **Skills** area of the agent's **Build** tab.

### Path A — create from blank
1. Open your agent and select the **Build** tab.
2. In the components panel, select **Skills**.
3. In **Add skill**, select **Create from blank**.
4. Define the three pieces that matter: **Name** (kebab-case), **Description** (what it does and when to activate — and when not to), and **Instructions** (Markdown: steps, response formats, constraints, edge cases).
5. Select **Create**. The Skill appears in the components panel.

Then **test in the Preview tab** to confirm it activates and behaves as expected. Skills created from blank remain editable at any time.

### Path B — with chat assistance
The new experience also lets you draft a Skill **conversationally** as an alternative to starting from blank. The result is the same portable Skill; the assisted flow simply helps you shape the name, description, and instructions. Refine it afterward in the configuration panel.

### Path C — author externally and upload
Prefer your own editor and source control? Author the Skill as a file and upload it:
1. In the components panel, select **Skills**, then **Add skill → Upload a skill**.
2. Drag and drop the file onto the upload box, or browse to it. The system **validates** the file and adds the Skill.

| Accepted upload format | Contents |
|---|---|
| **Markdown file (`.md`)** | Skill name and description in YAML front matter, plus Markdown instructions. |
| **ZIP package (`.zip`)** | Must include a `SKILL.md` (front matter + instructions). May optionally include supporting files: scripts, templates, reference documents. |

**Scope, today.** Once added, a Skill becomes part of **that agent**. It is scoped to the agent and travels with it: add the agent to a Power Platform solution and the Skill moves with it through your ALM lifecycle. As of mid-2026 there is no shared, cross-product catalog inside the product — distribution is **per-agent** — but a more catalog-like way to share Skills is being worked on.


## Writing instructions that actually work

Write the body in Markdown and cover, at minimum, five things:

1. **The task or scenario** the Skill handles — stated clearly up front.
2. **Step-by-step guidance** for how the agent should respond.
3. **Formatting requirements** for the response (length, structure, what to emphasize).
4. **Edge cases** and how to handle them.
5. **References to tools** the agent should use, where applicable.

**Write the description like routing metadata.** This is the part makers most often get wrong.

- **Name specifically:** `HR Leave Eligibility Triage`, not `HR Help`.
- **Say when to use it — and when not to:** *"Use for leave eligibility and required documentation. Do not use for payroll or benefits enrollment."*
- The litmus test: **if two reasonable makers would disagree on when the Skill applies, the description is not specific enough yet.**

**Pick the shape the job needs.** A Skill can take whatever form fits the task — a useful menu when you're deciding what to write:

| Think of a Skill as a… | Useful when the job is… | Example |
|---|---|---|
| **Reference manual** | Understanding a proprietary data model or schema the model doesn't know | Documenting your data model so a data tool returns the right thing |
| **Specialist you call in** | A narrow area of expertise needed only occasionally | Region-specific tax rules, applied only when that region comes up |
| **Playbook** | There's a known set of plays for a recurring situation | Triaging a support request: classify, then route by category |
| **Standard operating procedure** | A task must be done the same, compliant way every time | Handling a refund within policy windows and approval limits |
| **Briefing pack** | The agent needs background before it can act well | Onboarding context read before answering HR questions |
| **Checklist** | Certain validations must not be skipped | Pre-submission validation before a record is created |
| **Protocol** | There are firm rules for a sensitive case | What to do when a user reports a suspected security incident |
| **Runbook** | An operational task has defined steps and failure handling | Run a pipeline: discover, analyze, add an ROI pre-scan, format the result |
| **Template** | Output must follow a fixed structure or house style | Generating a standardized report to a fixed format |

Start simple and refine based on Preview testing. Small and correct beats large and vague — you can always add edge cases once the core path is solid.

## A worked example, end to end (illustrative)

The following is an **illustrative** package that follows the documented format. Treat the content as an example pattern, not official sample text.

`SKILL.md`:

```markdown
---
name: customer-support-escalation
description: >-
  Use when a customer reports an issue a previous reply did not resolve,
  requests a refund or credit above the standard threshold, or explicitly
  asks for a supervisor, manager, or human agent. Do not use for general
  product questions or order-status lookups.
---

# Customer support escalation

## When to use this skill
Activate when the user:
- Reports an issue a prior response did not resolve
- Requests a refund or credit above the standard threshold
- Explicitly asks for a supervisor, manager, or human agent

## Steps
1. Acknowledge the concern and apologize briefly.
2. Collect the order or case number, a one-line summary, and the desired outcome.
3. Use the **Create Ticket** action to open a ticket with priority = High.
4. Confirm the ticket number and the expected response window.

## Response format
- Keep responses under 120 words.
- End every response with the ticket number in **bold**.

## Edge cases
- If no order number is available, ask once, then proceed with the email on file.
- Never promise a specific refund amount; state that a specialist will confirm.
```

Package it as a ZIP with `SKILL.md` at the root and any resources the instructions refer to:

```text
customer-support-escalation.zip
├── SKILL.md
├── scripts/
│   └── format_ticket.py       # optional helper the instructions can reference
├── assets/
│   └── escalation_reply.md     # optional response template
└── references/
    └── refund_policy.md        # optional reference document
```

Note the two "code" mechanisms at play: step 3 **soft-points** at the agent's `Create Ticket` action (a tool the agent must already have), while `scripts/format_ticket.py` is a **bundled script** the Skill can carry and reference directly.


## Managing Skills across their lifecycle

From the **Build** tab, the **Skills** section lists every Skill on the agent. From there:

- **View** — the Skills section shows everything you've added.
- **Edit** (Skills created from blank) — select the Skill, update **Name**, **Description**, or **Instructions**, then **Save** and re-test in Preview.
- **Download** — open the Skill's panel; for a blank-created Skill use the **Download** icon, for an uploaded Skill use **… → Download**. It downloads as a Markdown file (name + description in YAML front matter plus instructions), with the **filename matching the Skill's name**.
- **Replace** (uploaded Skills) — edit the file in your preferred editor, then **… → Replace** and browse to the updated file. You can also replace a Skill with a different one.
- **Delete** — select the **X** next to the Skill and confirm. Deletion is **permanent for that agent** — download it first if you might need it later.


## Skill, instruction, or a new agent?

Two decisions come up constantly.

**Instruction, or a Skill?** By the time you're weighing this, one thing is settled: there's something the agent can't infer on its own. The only question is *where it goes*.

```text
Is it something the agent can infer from tool/knowledge descriptions?
        └─ Yes ->  leave it to the agent; don't write it down
        └─ No  ->  Is it true in EVERY conversation, for every scenario?
                     └─ Yes ->  put it in the agent's INSTRUCTIONS
                     └─ No  ->  make it a SKILL (situational, loaded on demand)
```

Tone, the agent's role, and always-on guardrails are valid 100% of the time — those belong in instructions. Anything that only applies to specific scenarios belongs in a Skill.

**A Skill, or a new agent?** Before Skills, the instinct for every distinct task was to build another specialized agent. But three tasks that share the **same audience and knowledge boundary** are often **one agent with three Skills**, not three agents. Two things still point to a *separate* agent:

- **It would stand on its own.** An HR assistant and an IT support agent serve different audiences and sit behind different security boundaries — build the agent.
- **One agent has taken on too many tools.** Accuracy can degrade as more is loaded into context, and past some point more Skills won't save it. When you hit that wall, split the work into a separate agent and **delegate** to it. (Evaluate this for your own agent rather than assume it.)


## The naming trap: this is NOT a Bot Framework skill

This is the distinction to keep clean. Copilot Studio has used the word **skill** before, and the two meanings are **unrelated**.

| Term | Legacy (classic) meaning | New-experience meaning |
|---|---|---|
| **Skill** | An externally registered bot capability (Bot Framework / Microsoft 365 Agents SDK), added via a **manifest URL** | A **Markdown-based** reusable instruction module (`SKILL.md`) |
| **Format** | Manifest / registration-based; hosted bot endpoint | `SKILL.md` — YAML front matter + Markdown package |
| **Where it runs** | An external Azure Bot Service bot | Inside the Copilot Studio agent (new experience) |
| **How it's invoked** | Trigger phrases + an allow-listed skill call | The orchestrator matches the Skill's description |
| **Primary value** | Integration with external, pro-code bot logic | Modular, reusable behavior and instruction reuse |

The classic sense is still real and still documented: you can convert a bot into a skill and register it via a **manifest**, and Copilot Studio supports skills built on **Bot Framework SDK 4.12.0+** and **Microsoft 365 Agents SDK v1.0.0+**. Microsoft's own guidance on using a *classic chatbot as a skill* is explicit that it **applies to classic chatbots only and isn't available for Copilot Studio agents.**

**How to tell which one a document means:** if it mentions a `SKILL.md`, YAML front matter, or a ZIP package, it's the **new** model. If it mentions a **skill manifest**, an allow list, an **Azure Bot Service** bot, or "classic chatbot," it's the **legacy** model — and it does not apply to the agents in this guide. Throughout this article, **skill** means the new Markdown-based format.


## Treat Skills as a trust surface — and a governed asset

Because a Skill shapes how the agent behaves — and can now bundle scripts — it is a **trust surface**. Treat any Skill you did not write (a community source, one generated by AI, or one reused from another environment) the way you'd treat untrusted code: **review it before adding it.** Check for prompt injection, instructions to misuse tools, and anything that doesn't match what the Skill claims to do.

Because the same Skill can influence many agents, reuse is powerful — but a poorly written Skill can propagate flawed behavior widely. Governance must scale with that reach:

- Store shared Skills in **version-controlled repositories**; use **pull requests** for changes to important ones.
- Define an **owner** for each Skill and keep a **changelog** for production-relevant Skills.
- Keep descriptions **precise and testable** — they are routing metadata (§3, §7).
- Avoid **broad, overlapping** Skills that compete for activation.
- **Separate policy knowledge** (→ Knowledge) from procedural guidance (→ Skill).
- **Test** with realistic user requests, and review high-impact Skills with **security, compliance, legal, or architecture** stakeholders.

Because Skills are just Markdown files, they become **version-controlled, Git-native, reviewable through pull requests, portable between agents** — behavior maintained as a long-lived, inspectable enterprise asset. This is what many now call **Behavior as Code**: a Center of Excellence maintains approved Skills, an architecture board owns review Skills, legal publishes controlled guidance, and delivery teams own documentation Skills — all reviewed and versioned.

## You don't have to start from scratch — the CAT Agent Skills gallery

You don't have to author every Skill from a blank file. Microsoft's Customer Advisory Team (CAT) publishes **[CAT Agent Skills](https://microsoft.github.io/cat-agent-skills/)** — *"the gallery of skills for your AI agents"*: community-contributed, drop-in instruction and script bundles you can download as Markdown (and scripts) and add to **Cowork, Copilot Studio, or Scout**. The gallery filters by platform (Copilot Studio has ~42 entries at the time of writing) and by type (**Skills, Plugins, Automations**), with tags such as *productivity, documents, automation, governance,* and *presentations*.

A few entries are as useful for **learning to author** as they are to drop in:

| Skill | What it does | Why it's a good example |
|---|---|---|
| **Skill Authoring Coach** | Helps makers design concise, reusable Skills with clear triggers, instructions, resources, and packaging | A meta-skill — use it to write better Skills |
| **PowerPoint Deck Designer** | Builds decks from a JSON spec with `python-pptx`, running natively in the agent's Python container | Shows a Skill that **bundles a script and runs code in the sandbox** |
| **Knowledge Source Router** | Routes searches to the right region-specific source so answers stay locally accurate | A pure **procedural** Skill — behavior, not data or actions |
| **Iterative File Editing** | Version-numbers each edited file so every update actually lands | A tiny Skill fixing one specific behavior — the ideal narrow scope |
| **Universal Document Converter** | Converts between Markdown, HTML, PDF, Word, PowerPoint, and Excel offline with sandbox libraries | Demonstrates self-contained, no-external-dependency packaging |
| **Brand Voice Pass** | Rewrites drafts to a house style | A classic Center-of-Excellence governance Skill, reused across agents |

The point isn't any single entry — it's the **operating model**. Because these are just Markdown packages on the open Agent Skills format, a gallery like this behaves like a **package registry for behavior**: browse, download, drop in, and adapt. Treat an imported Skill the way you'd treat any third-party dependency — **read it, test it, and version it** before trusting it in production (§12).


## A creating-skills checklist

- Agent created in the **new experience**; you're working in the **Build → Skills** area.
- Skill name is **kebab-case**, no leading/trailing hyphen, ≤64 characters.
- Description reads as an **activation contract** — what it does, when to use it, **and when not to** (≤1024 characters).
- Instructions cover **task, steps, formatting, edge cases, and tool references**.
- Any **scripts/templates/reference files** are bundled in a ZIP with `SKILL.md` at the root; the body references them explicitly.
- Tool usage is via **soft-pointers** to capabilities the agent actually has.
- Validated in **Preview**, and inspected in the **reasoning view** for correct activation (not too broad, not too narrow).
- A copy is kept in **source control** for versioning, review, and reuse.
- Confirmed you are building a **`SKILL.md` skill**, not a legacy Bot Framework skill manifest.

## Conclusion

Creating a Skill is deliberately simple: write a `SKILL.md`, describe *when* it applies as if you were programming a router, add scripts or resources only if the job needs them, upload it, and watch it fire in the reasoning view. The discipline is in the description and the scope — a precise trigger and a narrow job — and in treating each Skill as a reviewable, versioned asset rather than a throwaway prompt.

Do that, and you get the payoff the new model is built for: instructions stay lean because situational behavior lives in modules the orchestrator pulls in on demand. And because Skills sit on the **open Agent Skills format** shared with Claude and GitHub Copilot, the behavior you write once can travel — the reason `SKILL.md` is becoming a foundational building block well beyond Copilot Studio.

{: .important }
**The rule to pin above your desk:** keep instructions for what's true in *every* conversation, and move everything *situational* into Skills the agent can pull in on demand — a reference manual, a checklist, a runbook, or a playbook.


## Sources

- Microsoft Learn — [Skills overview for agents (preview)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/skills-overview)
- Microsoft Learn — [Create a skill for an agent (preview)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/skills-create)
- Microsoft Learn — [Add an existing skill to an agent (preview)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/skills-add-existing)
- Microsoft Learn — [Manage and delete skills in an agent (preview)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/skills-manage)
- The Custom Engine (Microsoft CAT) — [Modern Agents Have Skills Now — Here's How They Work in Copilot Studio](https://microsoft.github.io/mcscatblog/posts/modern-mcs-agent-skills/)
- Microsoft CAT — [CAT Agent Skills gallery](https://microsoft.github.io/cat-agent-skills/)
- Microsoft Learn — [Use a classic chatbot as a skill in a Bot Service bot (legacy Bot Framework skills — classic only)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-use-pva-as-a-skill)
- Anthropic — [Agent Skills overview (SKILL.md, YAML front matter, progressive disclosure)](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview)
