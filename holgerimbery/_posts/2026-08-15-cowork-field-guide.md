---
canonical_url: https://holgerimbery.blog/
title: "Microsoft Copilot Cowork: The Field Guide"
description: A living, frequently-updated field guide to Microsoft Copilot Cowork — what it is, how to enable it well (including EU data-boundary guidance), the skills, the limits, and what's next.
date: 26-08-15
author: admin
slug: cowork-field-guide
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/08/bluestonex-4uIRzJYYaOE-unsplash.jpg
featured: true
toc: true
image_caption: "Photo by <a href=\"https://unsplash.com/@bluestonex_apphaus?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText\">Bluestonex</a> on <a href=\"https://unsplash.com/photos/two-men-working-on-laptops-in-a-modern-office-4uIRzJYYaOE?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText\">Unsplash</a>

  \      "
tags:
  - copilot
  - cowork
  - governance
  - microsoft365copilot
  - recommended
---

{: .q-left }
> **Summary lede**
Microsoft Copilot Cowork has moved from preview to global production use, and the gap between launch headlines and day-to-day reality is now a governance problem. This field guide gives you a practical, current view of what Cowork is, how to enable it safely, what it can and cannot do yet, and how to make better decisions on rollout, controls, skills, and cost.

{: .q-left }
> **Why read this**
- You need a single, up-to-date source that replaces outdated preview-era guidance.
- You are responsible for rollout quality: licensing, admin enablement, policy, and spend guardrails.
- You need clear EU data-boundary context before wider adoption.
- You want practical operating guidance, not product marketing.


{: .warning }
**A living document.** Cowork moves fast — it went from a Frontier preview to worldwide general availability in three months. This guide is built to be updated. Each section is self-contained, every time-sensitive claim is dated. 


## How to use this guide

This is a **field guide**, not a one-time article. When you revise it: bump the version, add a changelog row, and update the "Last updated" date.


### Version history

| Version | Date | What changed |
|---|---|---|
| 1.0 | 15 Aug 2026 | First consolidated field guide. Folds in the original 14-part series and refreshes it to the GA release: general availability (16 Jun 2026), mobile support, usage-based billing, the model lineup, custom-skill cap corrected to **50**, the plugins ecosystem, and the current EU Data Boundary position. |



## What Cowork is

Most people have spent the last two years using AI to **assist** with work — drafting emails, summarising threads, sketching slides. Copilot Cowork is a different kind of product: it doesn't just help with a task, it **carries it out**. You describe an outcome, Cowork plans the steps, executes them across your Microsoft 365 environment, and asks for your approval before anything sensitive leaves your tenant.

Technically, Cowork is a cloud-hosted **agentic orchestration layer** embedded in your Microsoft 365 tenant and running inside Microsoft 365 Copilot. You describe a task in plain language; Cowork creates a plan, reasons across your calendar, email, files, and Teams content via Microsoft's Work IQ layer, and produces a finished result. Progress is visible at every step, and you can pause, resume, or cancel at any time.

{: .q-left }
> **The one-line mental model.** Cowork is the first Microsoft AI surface where the unit of output is a **finished task**, not a generated paragraph. Brief it well, approve carefully, audit honestly.

## Status, licensing & availability

**What changed since spring 2026.** **Copilot Cowork reached general availability worldwide on 16 June 2026**, after roughly three months in the Frontier preview. It is no longer preview-only. Any older guidance that calls it "Frontier opt-in only" is now out of date.

### How you get it

- **License** — a Microsoft 365 Copilot license is required.
- **Off by default** — admins decide when to enable Cowork in the tenant and who gets access. It's a deliberate, staged switch-on rather than an automatic rollout.
- **Billing** — at GA, Cowork uses usage-based billing through Copilot Credits (pay-as-you-go, on the order of $0.01/credit) with an option to pre-commit for a discount. Tenant, group, and user spending limits, alerts, and usage reporting are available.
- **Bundled route** — Cowork-class capability is also part of Microsoft 365 E7, the new Frontier Suite tier (see §12).

### Where it runs

- **Web** — in your browser at `m365.cloud.microsoft`
- **Desktop** — the Microsoft 365 Copilot app for Windows and Mac
- **Mobile** — the Microsoft 365 Copilot app for iPhone and Android *(new since the spring articles, which said mobile was unsupported)*

{: .q-left }
> **Acts on vs. runs on.** Cowork **acts on** Outlook and Teams — it sends mail and posts messages — but you **launch** it from the Microsoft 365 Copilot app, not as a standalone add-in inside Teams or Outlook. If earlier notes said Cowork &quot;runs in Teams and Outlook,&quot; read that as &quot;acts on.&quot;

### The models under the hood

Cowork is multi-model. At general availability it runs on **Anthropic Claude — Opus 4.8 and Sonnet 4.6** — with GPT 5.5 available in Frontier, and a secure, fine-tuned "Cowork 1" model announced as coming. Microsoft's orchestration selects the appropriate model for each task; for most users the choice is invisible. The Anthropic engagement and its data-residency implications are the subject of §5 — the most important section for European organizations.


## Enabling Cowork (admin path)

Enabling Cowork is a short, deliberate sequence. The most common rollout snag is skipping the account-level step.

1. **Confirm licensing.** Ensure target users hold a Microsoft 365 Copilot license and that billing (Copilot Credits / spending limits) is configured.
2. **Turn Cowork on for the tenant.** In the Microsoft 365 admin center, enable Cowork — it is off by default.
3. **Choose who gets access.** Scope Cowork to security groups. Pilot rings first, broad rollout later.
4. **Decide the Anthropic setting.** Confirm whether Anthropic models are enabled as a Microsoft subprocessor for your region (default in most commercial clouds; a deliberate opt-in for EU/EFTA/UK — see §5).
5. **Pre-decide governance.** Sensitivity labels and DLP policies that should apply before broad rollout; your approved-use matrix; and SIEM telemetry.
6. **Open Cowork.** Users go to `m365.cloud.microsoft`, the desktop app, or the mobile app and select Cowork.

{: .q-left }
> **First-run experience.** Users see a chat input, a side panel for files, suggested prompts (*Catch me up*, *Organize my inbox*, *Prep for a meeting*), a **Tasks** view in the navigation, and an output panel where generated files land.

**Turning it off for specific users.** Scope access through the security groups you used to grant it, or manage availability through Copilot settings in the admin center. Access is group-based and reversible — you stay in control of who has it.

## The Anthropic engine: what "subprocessor" means

Cowork uses Anthropic Claude models as part of its multi-model engine. For most tenants this is invisible plumbing. What matters for governance is the **contractual** arrangement behind it.

- **Subprocessor status.** Anthropic operates as a Microsoft **subprocessor** under Microsoft's Product Terms and Data Protection Addendum (DPA). Breach notification, incident response, and data-handling obligations flow through Microsoft's contractual framework — not through a separate Anthropic agreement.
- **Copyright cover.** Microsoft's Customer Copyright Commitment applies to Anthropic models used within products it covers, including Microsoft 365 Copilot and Copilot Studio.
- **One arrangement, not two.** An earlier "independent processor" route was decommissioned on 1 May 2026. Today, Anthropic access runs through the single subprocessor model.
- **Multi-model quality.** Pairing a drafting model with a reviewing model from a different provider is the same idea behind the Researcher agent's Critique capability (§12) — different models checking each other's work.

{: .q-left }
> **A date to verify before you quote it.** Some earlier write-ups cite a specific DPA effective date of *7 January 2026*. That exact date is **not confirmed in a primary Microsoft source** at the time of writing. The subprocessor relationship and the Product-Terms&#x2F;DPA framing are well documented; treat the precise date as &quot;verify against the Microsoft Product Terms revision history&quot; before repeating it externally.


## EU Data Boundary & Anthropic — enabling with confidence

For organizations in the EU, UK, or EFTA, the Anthropic setting is the single most important configuration decision before rollout. The good news: Microsoft has turned it into an **explicit, informed choice** rather than a hidden default. That is a governance *feature*, not a limitation — and it means European teams can adopt Cowork deliberately, on their own terms.

### The facts, plainly

*Microsoft's documented position, current as of 22 July 2026:*

- **Anthropic is a Microsoft subprocessor** under the Product Terms and DPA (see §4).
- Anthropic-processed requests are **currently excluded from the EU Data Boundary** and, where applicable, from in-country processing commitments.
- For **EU, EFTA, and UK tenants, Anthropic models are off by default**; an administrator explicitly opts in.
- At GA, Cowork itself runs on Anthropic models — so for a European organization that wants Cowork, **enabling Anthropic is the enabling step**, made as a conscious, documented decision.

### Where the setting lives

Microsoft 365 admin center → **Copilot → Settings → View all → "AI providers operating as Microsoft subprocessors."** Select Anthropic and save. You need the AI Administrator or Global Administrator role. *(Older notes labelled the sub-node "Data Access"; the current path is "View all.")*

### A positive, controlled-enablement playbook

Rather than leaving capability on the table, treat enablement as a **governed project**. Each step below is an **enabler**, not a blocker — do them once and you can switch Anthropic on with confidence and keep it auditable.

1. **Confirm the contractual position.** Ask your Microsoft account team for written confirmation that Anthropic is engaged as a subprocessor under the Product Terms and DPA, and record it in your vendor risk register. This is procurement done once.
2. **Document your lawful basis and transfer mechanism.** Because processing occurs outside the EU Data Boundary, record the data flow in your Records of Processing Activities (RoPA) and apply the same lawful-transfer discipline you already use for other well-governed, non-EUDB services.
3. **Define an approved-use matrix.** Decide which roles, business units, and data classifications may use Anthropic-routed features. Start where the value is high and the sensitivity is moderate — drafting, research, and summarising non-regulated content are ideal first use cases.
4. **Use sensitivity labels and DLP as guardrails.** Keep your most tightly regulated data on the paths that meet your residency needs, while letting everyday knowledge work benefit from the best model. Test end-to-end before broad rollout.
5. **Turn on telemetry.** Capture model ID, provider, user identity, and document sources in your SIEM so every Cowork session is auditable. Cowork actions are auditable by design within the tenant; validate your SIEM coverage during the ramp.
6. **Roll out in rings.** Pilot with an informed group, gather feedback, then expand. The opt-in is reversible and group-scoped — you stay in control at every stage.

{: .q-left }
> **The framing that works.** The Anthropic toggle is a **contractual and governance decision, not a technical one**. Handle the six steps above and you can say &quot;yes&quot; to Cowork with a clear compliance story — enabling the productivity gain deliberately, for the right people, with a full audit trail.

### Notes & nuances for European admins

> **What "off" actually means.** Copilot's default/base models are OpenAI GPT; Anthropic is an **opt-in layer on top**. Because Cowork runs on Anthropic models at GA, leaving Anthropic off tends to make Cowork features unavailable rather than silently swapping to GPT. Document this so users understand what the setting does — and so "enable in a controlled way" is understood as the path *to* Cowork, not a risk to avoid.

> **New EU app-level model setting (3 April 2026).** A distinct admin setting, "Copilot in M365 apps with Anthropic models in EU/EFTA and UK," lets Anthropic be the default model for Copilot in Word, Excel, and PowerPoint. It is on by default only for tenants created after 25 March 2026; older tenants should check the Message Center. It still routes data outside the EU Data Boundary — so fold it into the same governance story above.

{: .q-left }
> **Government cloud update (22 July 2026).** Non-federal customers in Government Community Cloud (GCC) can now enable Anthropic models — processed **outside** Microsoft&#39;s FedRAMP-authorized US Government cloud, and off by default. GCC High and DoD remain excluded, with no toggle shown.

## The 13 built-in skills

Cowork's behaviour is organised around **skills** — packaged capabilities the agent loads on demand, using the same open Agent Skills vocabulary as §7. You don't pick the skill; Cowork matches your prompt to a skill's description and loads it, streaming skill messages ("Preparing to create Word documents") and tool steps ("Composing your email") as it goes. Naming a skill explicitly also works: *"Use the Deep Research skill to compare these three proposals."*

| # | Skill | What it does |
|---|---|---|
| 1 | **Word** | Create and edit Word documents end-to-end. |
| 2 | **Excel** | Build and edit spreadsheets, including formulas. |
| 3 | **PowerPoint** | Generate decks from content or templates. |
| 4 | **PDF** | Produce PDFs, including from other formats; read PDFs as input. |
| 5 | **Email** | Read, draft, and send Outlook mail (with approval). |
| 6 | **Scheduling** | Find times, send invites, manage RSVPs. |
| 7 | **Calendar Management** | Review and reorganise calendar entries; defend focus time. |
| 8 | **Meetings** | Prep, summarise, and extract action items. |
| 9 | **Daily Briefing** | Assemble a personalised overview from email, calendar, and Teams. |
| 10 | **Enterprise Search** | Search across your Microsoft 365 environment, with citations. |
| 11 | **Communications** | Draft audience-tailored updates, announcements, and escalations. |
| 12 | **Deep Research** | Multi-step investigation across attached and indexed sources. |
| 13 | **Adaptive Cards** | Render structured output as visual cards, not plain text. |

**What is not built in today:**

- No native Power BI skill in Cowork.
- No local desktop file manipulation.
- Third-party tool integrations arrive through the growing **plugins** ecosystem (§12), not as built-in skills.

## Custom skills with SKILL.md

The 13 built-in skills are the floor, not the ceiling. Each user can create up to **50 custom skills** using `SKILL.md` files.


**Where they live.** In your OneDrive, under `/Documents/Cowork/Skills/`. Each skill is a subfolder containing a `SKILL.md` file. Cowork discovers them automatically at the start of each session — no admin toggle needed. Add one mid-session? Start a new task to pick it up.

**Anatomy of a SKILL.md.** YAML frontmatter with two fields — `name` and `description` — followed by Markdown instructions:

```markdown
---
name: weekly-report
description: Compiles a weekly status report from my calendar, email, and Teams
  activity. Use when I ask for "my weekly report" or "wrap up the week."
---

# Weekly Report

When invoked, do the following:

1. Pull all meetings I attended in the past 7 days from my calendar.
2. Identify action items I committed to, from meeting notes and follow-up emails.
3. List open items still awaiting my response.
4. Summarise key decisions made in Teams channels I own.

## Output
Produce a Word document titled "Weekly Report — [date range]" and save it to
/Documents/Reports/Weekly/. Cap each section at 6 bullets; use a direct tone.
```

{: .q-left }
> **Why the description matters most.** Cowork uses the &#x60;description&#x60; field to decide when to invoke a skill. A vague description (&quot;helps with reports&quot;) is ignored or misused; a specific one (&quot;Use when I ask for my weekly report or &#39;wrap up the week&#39;&quot;) triggers reliably. Write the trigger phrase into the description.

**The standard behind it.** `SKILL.md` is the open **Agent Skills standard**, originally developed by Anthropic and adopted broadly — the same format supported by Claude Code, VS Code Copilot, Gemini CLI, Cursor, JetBrains Junie, and 30+ other AI tools. Examples live at [github.com/anthropics/skills](https://github.com/anthropics/skills) and the spec at [agentskills.io](https://agentskills.io/home).

**Limits that still apply:**

- Custom skills are **not validated by Microsoft** — review their output, especially anything that sends external mail or edits shared content.
- Skills **cannot bypass approvals** — sensitive actions still prompt.
- Skills **cannot grant access** to data the user doesn't already have.


## Working the skills — prompts that work

Skills shine when you brief an **outcome** and let Cowork compose the steps. A few field-tested patterns:

### Email

*&quot;Read my unread emails from the past 24 hours. Group them by project. For anything from marketing about the spring campaign, draft a reply summarising the latest results from the attached CSV and propose a 30-minute review next Tuesday between 10 and 12. Show me each draft before sending.&quot;*

Cowork triages, drafts grounded in the thread plus attachments, and prompts before each send. *"Catch me up on the Acme account"* quietly composes Email + Enterprise Search + Meetings into a single narrative brief.

### Scheduling & Calendar Management

*"Find 30 minutes next week with Sarah, Tom, and me. Avoid Mondays. Book a room if available, send the invite 'Spring campaign review' with an agenda I'll dictate, and propose two backup times."*

*"Review next week's calendar. Flag back-to-backs longer than 3 hours, identify meetings without a clear agenda, and propose declines for anything I'm only optional on. Show me the proposals before acting."*

Use **Scheduling** for forward motion and **Calendar Management** for hygiene. Both respond better to explicit constraints. Private events are respected and never surfaced.

### Meetings & Daily Briefing

*"Prepare me for Monday's quarterly review with the CISO. Pull her last month of meetings with my team, open action items from those notes in Teams, and status updates sent via email. Produce a one-page briefing I can share 24 hours in advance."*

Daily Briefing is the canonical **scheduled prompt**: *"Every weekday at 7:00 AM, run my morning briefing and save it to /Documents/Briefings/."* It is the easiest automation to set up and the one with the largest compounding return.

### Documents (Word, Excel, PowerPoint, PDF)

*"Draft a 2-page board memo on Q1 results. Use the attached financial summary and the previous board memo as references. Direct tone, no jargon. Save to /Documents/Board/."*

Document skills generate finished files — not just inline content — and write them into OneDrive/SharePoint. They appear in the side panel during the conversation and persist afterward; use **Download All** to grab a session's outputs as a zip. Cross-skill chains are common: *"build the deck, save it to OneDrive, and post a link in #leadership"* invokes three skills, with each external action approved separately.

### Enterprise Search & Deep Research

*"Run a competitive analysis of our top three competitors using the product team's research files and the industry reports in /SharePoint/Industry. Produce a Word document with an executive summary and an Excel comparison matrix. Flag capability gaps. Use Critique."*

**Enterprise Search** is the broad sweep across mail, calendar, files, Teams, OneNote, and SharePoint — answers with citations, bounded strictly by your existing permissions. **Deep Research** is the multi-step synthesis, optionally routed through the Researcher agent's Critique capability (§12). Treat citations as the audit trail for anything you share externally.


## The control surface: approvals, pause/resume, Tasks

Cowork takes actions — so the safeguards are built into every conversation. This is what makes agentic AI safe to run at scale.

**Approvals.** Before any sensitive action — sending an email, posting in Teams, scheduling a meeting — Cowork shows:

- A **preview** of the content (recipients, subject, body, time, channel).
- A **risk-level indicator** for medium- and high-risk actions.
- A **Show parameters** option for full technical detail.

Your choices: the action button (Send / Post / Create) to proceed once; **Don't ask again** to skip the prompt for similar actions *in this conversation only*; or **Cancel**. Use "Don't ask again" sparingly, and only inside a conversation you trust.

**Pause, resume, and reconnect.**

- **Pause** finishes the current step then halts (a hard pause stops immediately); **Resume** continues; **Cancel** ends the task.
- Lose your network and Cowork **reconnects automatically** and picks up where it left off — progress is preserved.

**The Tasks view = your audit trail.** Open **Tasks** in the main navigation. Three views: **List** (conversations), **Board** (kanban by status), and **Scheduled** (visible once you have at least one scheduled prompt; edit, pause, resume, or delete each). Click any task to jump back in, inspect artifacts, or rerun. When Cowork needs input, it asks with selectable choices and the task reads *Needs user input* until you answer.


## Grounding Cowork with work context

Output quality is largely a function of context. A vague prompt against an empty workspace gives generic text; the same prompt with three well-chosen attachments gives something you can actually send.

**Three ways to add context:**

1. **Drag and drop** files from your device into the chat input.
2. **Add work context** to pull from OneDrive, SharePoint, or Teams via a picker — files, people, meetings, and chats.
3. **Reference by path** in the prompt ("use `/Documents/Brand/guide.pdf`").

**Patterns that noticeably lift quality:**

- **Brand & tone kit.** A folder with your style guide, a sample memo, and a glossary. *"Match the tone and structure of the attached memo."* Output reads like your team's.
- **Context pack for recurring work.** For a weekly report, assemble last period's deliverable, a definitions file, and the data source. Attach the whole folder for consistent output across cycles.
- **Source-of-truth pinning.** *"Only state facts from the attached document. Flag anything I need to verify separately."* This constrains hallucination risk significantly.

{: .q-left }
> **Rules to remember.** Each attachment must be under **200 MB**. Prompts can run up to **250,000 characters**. Files must live in OneDrive, SharePoint, or Teams — no local-drive access. Cowork **cannot read encrypted files**, even ones you can open. Work IQ grounds Cowork automatically and permission-bound across your M365 graph; explicit attachments are per-task and not re-read in later conversations — reattach or reference the path to reuse.

## Limits & known constraints

Knowing the boundaries is what makes a rollout credible. Lead with these in your enablement materials so users meet them in training, not on a Friday afternoon.

**By design:**

- **No local file access** — OneDrive and SharePoint only.
- **No file deletion** in OneDrive or SharePoint — Cowork creates and edits, but users delete manually.
- **Encrypted files cannot be read**, even when the user has access.
- **Custom skills are not Microsoft-validated** — review their output.
- **Attachments capped at 200 MB; prompts at 250,000 characters.**

**Regional & governance:**

- Anthropic models are off by default in the EU, EFTA, and UK and require admin opt-in (§5).
- Government/sovereign clouds: only non-federal GCC can now opt in (processed outside the US Gov cloud); GCC High and DoD remain excluded.
- Use is limited to Anthropic-supported countries and regions.
- Cowork actions are auditable by design within the tenant — but validate your specific SIEM/Compliance coverage during the ramp before relying on it for regulatory evidence.

{: .q-left }
> **The trade-off, stated honestly.** Cowork exchanges some autonomy and breadth for the certainty that AI-driven actions stay within an **auditable, policy-governed, compliance-covered** infrastructure. For most regulated enterprises, that trade is the whole point.

**Things that change quickly — re-check monthly:** the skill list and custom-skill cap · regional availability and EU/GCC settings · the model lineup and billing · the plugin catalogue and compliance-surface coverage (DLP was "coming soon" at GA).


## What's next: E7, Agent 365, Researcher, plugins

Cowork is one feature inside a larger shift toward governed, multi-agent enterprise AI.

**Microsoft 365 E7 — the Frontier Suite.** Generally available **1 May 2026 at $99 per user per month**. E7 bundles Microsoft 365 E5, the Microsoft Entra Suite, Microsoft 365 Copilot (including Cowork), and Agent 365 — positioned as a unified enterprise AI platform rather than a set of separate products. The pricing is a ~65% step up from E5; the value case rests on Cowork-class capability plus Agent 365 governance.

**Agent 365 — the control plane for AI agents.** Generally available **1 May 2026** ($15/user/month standalone, or included in E7). It extends Microsoft's user-management infrastructure to AI agents — central identity, security, and compliance for agents at scale, across Copilot Studio agents, custom agents, partner agents, and Cowork itself. Some sub-capabilities (e.g., shadow-agent discovery, Windows 365 for Agents) remain in preview. Model your agent inventory now, even if it's only Cowork plus a couple of Copilot Studio agents.

**Researcher with Critique.** The Researcher agent's Critique capability pairs one model's draft with a second model from a different provider that reviews for accuracy, completeness, and citation integrity. Microsoft reports a **DRACO benchmark score of 57.4 — a ~13.8% improvement over single-model approaches**.

{: .q-left }
> **Read the benchmark carefully.** The 57.4 &#x2F; 13.8% figures are **Microsoft&#39;s own evaluation and are not independently verified**; the baseline is described slightly differently across Microsoft&#39;s materials. Quote it as &quot;Microsoft-reported,&quot; not as a settled external result.

**Plugins & extensibility.** At GA, Cowork opened to partner **plugins** — nine live at launch (including Harvey, Miro, monday.com, Moody's, Morningstar, and S&P Global Energy) with more announced, plus Microsoft Fabric and Dynamics 365 integrations. Plugins are how third-party tools reach Cowork, built on the same Agent Skills standard as your custom `SKILL.md` files. Start a team `SKILL.md` library in OneDrive now; when organizational skill-sharing matures, you'll have curated content ready.

## Quick-start checklist

**For admins standing up Cowork:**

- [ ] Confirm Copilot licenses and configure Copilot Credits + spending limits.
- [ ] Enable Cowork for the tenant; scope access to a pilot security group.
- [ ] Make the Anthropic decision using the §5 playbook (EU/EFTA/UK: enable deliberately, documented).
- [ ] Test sensitivity labels and DLP end-to-end; wire up SIEM telemetry.
- [ ] Publish an approved-use matrix and a short user guide leading with the limits (§11).

**For the first two weeks as a user:**

- [ ] Set up one scheduled Daily Briefing and refine its format.
- [ ] Build one custom skill (start with `weekly-report`) and sharpen its description.
- [ ] Pilot one document workflow with grounding attachments end-to-end.
- [ ] Use the Tasks view as your audit trail; approve external actions deliberately.

{: .q-left }
> **Takeaway.** Start small. Build one custom skill. Run one scheduled briefing for two weeks. Pilot one document workflow with one team. Compound from there. Cowork rewards organizations that show up with real use cases — and, in Europe, those that **enable it thoughtfully rather than leave it on the shelf**.

## Conclusion

Microsoft 365 Copilot Cowork marks a genuine shift in enterprise AI — from reactive chat assistants to proactive, context-aware colleagues that plan, draft, and act on your behalf. It is not a feature tweak; it is a new operating model for knowledge work.

The opportunity is real. Cowork can compress the gap between intent and execution: a briefing that used to take thirty minutes of tab-switching arrives drafted before your first coffee; a weekly report that relied on one person's memory of scattered threads gets assembled, cited, and formatted by a scheduled skill. For teams that invest in deliberate setup — good skill descriptions, grounded attachments, clear approval habits — the compounding effect is significant.

The responsibilities are equally real. Every autonomous action Cowork takes carries your name and your organization's compliance posture. The Anthropic sub-processor decision, the DLP wiring, the sensitivity-label hygiene, the spending limits — none of these are optional governance theatre. They are the foundation that makes the capability trustworthy enough to scale.

For European organizations, the calculus has an extra dimension. The EU AI Act and GDPR do not block Cowork, but they demand documented intent. Enabling third-party models deliberately, maintaining audit trails, and communicating transparently with employees are not burdens — they are the proof that your organization takes AI governance seriously. That proof has competitive value as customers, regulators, and talent increasingly ask for it.

The practical path forward is clear: **start narrow, learn fast, govern from day one, and expand with evidence**. One team, one skill, one scheduled briefing, two weeks. Then review the Tasks log, refine the prompts, and add the next use case. Cowork is infrastructure — it rewards patience and punishes shortcuts.

The organizations that will look back at 2026 as a turning point are not the ones that rushed the broadest rollout. They are the ones that built the smallest trustworthy foundation first — and then compounded relentlessly on top of it.



## Sources & further reading

**Primary (Microsoft):**

- [Cowork overview & FAQ (Microsoft Learn)](https://learn.microsoft.com/en-us/microsoft-365/copilot/cowork/)
- [Copilot Cowork is now generally available (Microsoft 365 Blog, 16 Jun 2026)](https://www.microsoft.com/en-us/microsoft-365/blog/2026/06/16/copilot-cowork-is-now-generally-available/)
- [Connect to an AI subprocessor (Microsoft Learn)](https://learn.microsoft.com/en-us/microsoft-365/copilot/connect-to-ai-subprocessor)
- [Anthropic models in Copilot for Microsoft 365 apps (Microsoft Learn)](https://learn.microsoft.com/en-us/microsoft-365/copilot/copilot-anthropic-apps)
- [Introducing Microsoft 365 E7: The Frontier Suite](https://microsoftpartners.microsoft.com/abs/Blog/?title=Introducing%20Microsoft%20365%20E7:%20The%20Frontier%20Suite)
- [Microsoft Agent 365 now generally available (Microsoft Security Blog, 1 May 2026)](https://www.microsoft.com/en-us/security/blog/2026/05/01/microsoft-agent-365-now-generally-available-expands-capabilities-and-integrations/)
- [Build plugins & skills for Cowork (Microsoft Learn)](https://learn.microsoft.com/en-us/microsoft-365/copilot/cowork/cowork-plugin-development)

**Standards & background:**

- [Agent Skills standard — agentskills.io](https://agentskills.io/home) · [Anthropic Skills examples — github.com/anthropics/skills](https://github.com/anthropics/skills)
- The 14-part Cowork series (April–May 2026) by Holger Imbery — [holgerimbery.blog](https://holgerimbery.blog)

