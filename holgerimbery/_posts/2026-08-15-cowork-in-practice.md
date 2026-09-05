---
canonical_url: https://holgerimbery.blog/
title: "Microsoft Copilot Cowork in Practice"
description: "What I have learned running Copilot Cowork in real tenants: how to enable it (including the EU data-boundary decision), what the skills actually do, where the limits bite, and what is coming."
date: 26-08-15
author: admin
slug: cowork-in-practice
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/08/bluestonex-4uIRzJYYaOE-unsplash.jpg
featured: false
toc: false
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
> **In short**
Cowork went from preview to worldwide general availability in about three months, and most of the guidance still circulating is from the preview era. This is what I have run into since then: the enablement path, the Anthropic decision European tenants have to make, what the skills do well, and where they stop.

{: .warning }
**I keep this post updated.** Cowork changes monthly. Sections stand on their own and time-sensitive claims carry a date, so you can see what is stale.

### Version history

| Version | Date | What changed |
|---|---|---|
| 1.0 | 15 Aug 2026 | Consolidates my 14-part series and updates it to GA: general availability (16 Jun 2026), mobile support, usage-based billing, the model lineup, custom-skill cap corrected to **50**, plugins, and the current EU Data Boundary position. Re-checked against Microsoft docs: Sonnet 5 replaces Sonnet 4.6, GPT 5.5 is in the general model picker, enablement now runs through usage-based billing, Tasks has two views, DLP is still unsupported for Cowork, preview models with data retention added, plus image generation, browser use, the Customize page, and event-driven tasks. |

## What Cowork actually is

For two years we used AI to help with work: draft the mail, summarise the thread, sketch the deck. Cowork does the task instead. You describe an outcome, it plans the steps, executes them across your tenant, and stops for your approval before anything leaves it.

Under the hood it is an agentic orchestration layer inside Microsoft 365 Copilot. It reasons across calendar, mail, files, and Teams content through Work IQ, shows its progress step by step, and lets you pause, resume, or cancel mid-run.

{: .q-left }
> **The mental model I use with customers.** Brief it like a colleague, approve like an auditor. The output is a finished task, not text.

## Status, licensing, availability

**Copilot Cowork reached worldwide general availability on 16 June 2026.** Anything you read that calls it "Frontier opt-in only" predates that.

### How you get it

- **License.** A Microsoft 365 Copilot license is required.
- **Off by default.** Admins decide when to switch it on and for whom. Staged, not automatic.
- **Billing.** Usage-based via Copilot Credits (pay-as-you-go, roughly $0.01 per credit), with a pre-commit discount option. Tenant, group, and user spending limits, alerts, and usage reporting are available.
- **Bundled route.** Cowork-class capability is also in Microsoft 365 E7, the Frontier Suite tier (see below).

### Where it runs

- **Web:** `m365.cloud.microsoft`
- **Desktop:** the Microsoft 365 Copilot app for Windows and Mac
- **Mobile:** the Microsoft 365 Copilot app for iPhone and Android (new since spring, when mobile was unsupported)

{: .q-left }
> **Acts on, not runs in.** Cowork sends Outlook mail and posts to Teams, but you launch it from the Microsoft 365 Copilot app, not as an add-in inside Teams or Outlook. Older notes saying it "runs in Teams and Outlook" mean "acts on".

### The models

Cowork is multi-model and the lineup has already moved since GA. Today the picker offers **Claude Opus 4.8**, **Claude Sonnet 5** (which replaced Sonnet 4.6 at GA as the efficient everyday choice), the **Sonnet+Opus Advisor** pairing, **GPT 5.5**, and **Claude Fable 5** in preview. Image generation runs on ChatGPT Images 2.0. The fine-tuned "Cowork 1" model was announced as coming soon in June and has not shipped yet, so do not build a business case on it.

Leave the picker on Auto and Cowork chooses. Two things deserve an admin's attention: Fable 5 is off by default and has to be turned on in Copilot settings, and it is one of the preview models that require data retention by the model provider, which is a different contractual track from the subprocessor arrangement (next section). The residency consequence of the Anthropic dependency is the section after that, and for European tenants it is the one that decides the project.

## Enabling it

Short sequence, but the mechanism changed at GA and this is where preview-era runbooks now fail. Cowork is no longer managed under All Agents > Cowork, and the agent-based access control from the preview no longer governs who can use it. Access hangs off billing instead: admins enable usage-based billing, and that is what opens Cowork to users.

1. **Licensing.** Target users hold a Microsoft 365 Copilot license.
2. **Enable usage-based billing** in the Microsoft 365 admin center, with Copilot Credits and spending limits configured before anyone starts. This is the step that grants access, not a Cowork on/off switch.
3. **Set discoverability and scope access.** Decide whether Cowork is discoverable to end users, and scope through security groups. If you make it discoverable without enabling billing, users can request access from inside the app and you approve or decline on policy, cost, and compliance. Pilot rings first.
4. **Decide the Anthropic setting.** Default in most commercial clouds, a deliberate opt-in for EU, EFTA, and UK.
5. **Pre-decide governance:** sensitivity labels, your approved-use matrix, audit and SIEM telemetry. Note what is not yet on the menu: Purview data loss prevention is still not supported for Cowork, so do not plan a control around it.
6. **Open Cowork.** Web, desktop, or mobile app, then select Cowork.

{: .q-left }
> **First run.** A chat input, a side panel for files, suggested prompts (*Catch me up*, *Organize my inbox*, *Prep for a meeting*), a **Tasks** view in the navigation, and an output panel where generated files land.

To take it away again, scope through the same security groups or manage availability in Copilot settings. Group-based and reversible.

## What "subprocessor" means here

For most tenants the Anthropic dependency is invisible plumbing. What your legal team cares about is the contract behind it.

- **Subprocessor status.** Anthropic operates as a Microsoft subprocessor under Microsoft's Product Terms and Data Protection Addendum. Breach notification, incident response, and data-handling obligations run through Microsoft, not through a separate Anthropic agreement.
- **Copyright cover.** Microsoft's Customer Copyright Commitment applies to Anthropic models inside the products it covers, including Microsoft 365 Copilot and Copilot Studio.
- **There is a second track, and it matters.** Some newer Anthropic models are offered as "preview models with data retention". For those, Anthropic acts as an **independent data processor, not a Microsoft subprocessor**, under Anthropic's own commercial terms and DPA. They are off by default everywhere, including in regions where the other Anthropic models are on by default, and they have to be enabled separately. Claude Fable 5 in Cowork's picker is one of them, so this is live, not theoretical.
- **What retention means there.** Anthropic, not Microsoft, stores most inputs and outputs for up to 30 days. Content flagged by Anthropic's trust and safety classifiers can be held for up to two years, and classification scores for up to seven. Cowork shows a banner while such a model is selected. Anthropic does not use retained data for training without your express permission. If your legal position rests on the Product Terms and DPA, that position does not cover these models.
- **Why two providers.** Pairing a drafting model with a reviewing model from another vendor is the same idea behind Researcher's Critique capability.

## EU Data Boundary and the Anthropic switch

In every EU project I have run, this is the decision that sets the timeline. Microsoft made it an explicit, informed choice rather than a hidden default, which is helpful, because you can document it.

### The facts, current as of August 2026

- Anthropic is a Microsoft subprocessor under the Product Terms and DPA.
- Anthropic-processed requests are **currently excluded from the EU Data Boundary** and, where applicable, from in-country processing commitments.
- For **EU, EFTA, and UK tenants, Anthropic models are off by default**. An administrator opts in. The setting appears, but it is set to "No users".
- If you opted in previously under Anthropic's separate commercial terms, **you have to opt in again**. The toggle went back to off.
- Preview models with data retention stay off even after you opt in. They are a separate switch and a separate contract.
- Cowork does most of its reasoning, drafting, and tool work on Anthropic models. So for a European organisation, enabling Anthropic is in practice the enabling step.

### Where the setting lives

Microsoft 365 admin center → **Copilot → Settings → View all → "AI providers operating as Microsoft subprocessors"**. Select Anthropic and save. You need the AI Administrator or Global Administrator role. (Older notes call the sub-node "Data Access". The current path is "View all".)

### How I run the enablement

Treat it as a governed project with six steps. Done once, they hold for the life of the rollout.

1. **Confirm the contractual position.** Ask your Microsoft account team for written confirmation that Anthropic is engaged as a subprocessor under the Product Terms and DPA, and file it in the vendor risk register.
2. **Document lawful basis and transfer mechanism.** Processing happens outside the EU Data Boundary, so record the data flow in your RoPA and apply the same transfer discipline you use for other non-EUDB services.
3. **Define an approved-use matrix.** Which roles, business units, and data classifications may use Anthropic-routed features. Start where value is high and sensitivity is moderate: drafting, research, summarising non-regulated content.
4. **Use the controls that actually exist.** Sensitivity labels are supported and are inherited by the documents Cowork creates, with the highest-priority label winning when several sources are used. So are DSPM for AI, auditing, Insider Risk Management, communication compliance, eDiscovery, and data lifecycle management. **Data loss prevention, data classification, and Compliance Manager are not supported for Cowork.** Build the guardrail out of labels and detection, not DLP, and test it end-to-end before you widen the ring.
5. **Turn on telemetry.** Prompts and responses land in the unified audit log, along with events like starting a conversation, adding or sharing a skill or plugin, running a scheduled prompt, starting a browser task, uploading a file, and Cowork writing an artifact to OneDrive. Pull those into your SIEM and validate coverage during the ramp.
6. **Roll out in rings.** Informed pilot, feedback, expand. The opt-in is reversible and group-scoped.

{: .q-left }
> **The framing that gets a yes.** The Anthropic toggle is a contractual and governance decision, not a technical one. Once those six steps are done, you can approve Cowork with a compliance story you can defend and an audit trail to back it.

### Two things European admins get wrong

**What "off" actually means.** Copilot's base models are OpenAI GPT and Anthropic sits on top as an opt-in layer. Microsoft's wording is that some features are only available when Anthropic models are enabled, and that certain features may no longer be accessible if you turn Anthropic off. Since Cowork does most of its work on Anthropic models, expect it to be unavailable or badly degraded rather than quietly falling back to GPT 5.5. Tell your users that before they file the ticket.

**The EU app-level setting (3 April 2026).** A separate switch, "Copilot in M365 apps with Anthropic models in EU/EFTA and UK", makes Anthropic the default model for Copilot in Word, Excel, and PowerPoint. It is on by default only for tenants created after 25 March 2026; older tenants should check the Message Center. It still routes data outside the EU Data Boundary, so it belongs in the same governance story.


## The 13 built-in skills

Cowork's behaviour is packaged as **skills** the agent loads on demand, using the open Agent Skills format. You do not pick one. Cowork matches your prompt against each skill's description, then streams what it is doing ("Preparing to create Word documents", "Composing your email"). Naming a skill works too: *"Use the Deep Research skill to compare these three proposals."*

| # | Skill | What it does |
|---|---|---|
| 1 | **Word** | Create and edit Word documents end-to-end. |
| 2 | **Excel** | Build and edit spreadsheets, including formulas. |
| 3 | **PowerPoint** | Generate decks from content or templates. |
| 4 | **PDF** | Produce PDFs, including from other formats; read PDFs as input. |
| 5 | **Email** | Read, draft, and send Outlook mail, with approval. |
| 6 | **Scheduling** | Find times, send invites, manage RSVPs. |
| 7 | **Calendar Management** | Review and reorganise calendar entries, defend focus time. |
| 8 | **Meetings** | Prep, summarise, extract action items. |
| 9 | **Daily Briefing** | Assemble an overview from email, calendar, and Teams. |
| 10 | **Enterprise Search** | Search your Microsoft 365 environment, with citations. |
| 11 | **Communications** | Draft audience-tailored updates, announcements, escalations. |
| 12 | **Deep Research** | Multi-step investigation across attached and indexed sources. |
| 13 | **Adaptive Cards** | Render structured output as visual cards. |

Beyond that list, Cowork also generates images (ChatGPT Images 2.0, saved to your session and your OneDrive output folder) and, in Frontier, can drive a local Edge browser to finish web tasks using the sign-ins you already have. The browser tab runs on your machine, so your existing conditional access, DLP, and browsing policies apply, a tenant setting called Cowork Browsing turns the capability on or off, and every browser task is written to the unified audit log.

Still not there: no built-in Power BI skill, though the Fabric IQ plugin brings Power BI and Fabric data into Cowork. No access to files on your local disk. Third-party tools arrive through plugins rather than as built-in skills.

## Custom skills with SKILL.md

The 13 are the floor. Each user can add up to **50 custom skills** as `SKILL.md` files.

**Where they live.** OneDrive, under `/Documents/Cowork/skills/`, one subfolder per skill with a `SKILL.md` inside, for example `/Documents/Cowork/skills/weekly-report/SKILL.md`. Cowork picks them up at the start of each session, no admin toggle. Added one mid-session? Start a new task.

**The file is no longer the only route.** Since GA there is a Customize page that hosts your skills and your plugins in one place. You can build a skill through a guided conversation, upload one as `.md`, `.zip`, or `.skill`, and share a skill or plugin with specific people, re-sharing to push updates. I still author in the file and use the page for distribution, because a file in Git is reviewable and a guided conversation is not.

**Anatomy.** YAML frontmatter with `name` and `description`, then Markdown instructions:

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
Produce a Word document titled "Weekly Report, [date range]" and save it to
/Documents/Reports/Weekly/. Cap each section at 6 bullets; use a direct tone.
```

{: .q-left }
> **The description does the work.** Cowork decides when to invoke a skill from the `description` field alone. "Helps with reports" gets ignored or fires at the wrong moment. "Use when I ask for my weekly report or 'wrap up the week'" fires reliably. Put the trigger phrase in the description. This is the single most common fix I make to other people's skills.

**The standard behind it.** `SKILL.md` is the open Agent Skills standard, originally from Anthropic and now supported by Claude Code, VS Code Copilot, Gemini CLI, Cursor, JetBrains Junie, and 30 or more other tools. Examples at [github.com/anthropics/skills](https://github.com/anthropics/skills), spec at [agentskills.io](https://agentskills.io/home).

Limits worth knowing: custom skills are **not validated by Microsoft**, so review their output, especially anything that mails externally or edits shared content. They cannot bypass approvals, and they cannot reach data the user could not already open.

## Prompts that hold up

Skills work best when you brief an outcome and let Cowork assemble the steps. Patterns I keep reusing:

### Email

*"Read my unread emails from the past 24 hours. Group them by project. For anything from marketing about the spring campaign, draft a reply summarising the latest results from the attached CSV and propose a 30-minute review next Tuesday between 10 and 12. Show me each draft before sending."*

It triages, drafts from the thread plus attachments, and prompts before each send. *"Catch me up on the Acme account"* quietly combines Email, Enterprise Search, and Meetings into one brief.

### Scheduling and calendar hygiene

*"Find 30 minutes next week with Sarah, Tom, and me. Avoid Mondays. Book a room if available, send the invite 'Spring campaign review' with an agenda I'll dictate, and propose two backup times."*

*"Review next week's calendar. Flag back-to-backs longer than 3 hours, identify meetings without a clear agenda, and propose declines for anything I'm only optional on. Show me the proposals before acting."*

Scheduling moves things forward, Calendar Management cleans up. Both improve sharply with explicit constraints. Private events are respected and never surfaced.

### Meetings and briefings

*"Prepare me for Monday's quarterly review with the CISO. Pull her last month of meetings with my team, open action items from those notes in Teams, and status updates sent via email. Produce a one-page briefing I can share 24 hours in advance."*

Daily Briefing is the obvious scheduled prompt: *"Every weekday at 7:00 AM, run my morning briefing and save it to /Documents/Briefings/."* Easiest automation to set up, best return per minute invested.

Since July there is a second kind of automation worth knowing: **event-driven tasks** that fire when a matching email arrives or a Teams message is posted, including when you are @mentioned. You describe what to watch for, Cowork proposes the automation, you confirm it. Both kinds run with your permissions, still ask for approval before sending or posting unless you pre-authorise, carry rate limits and loop protection, and show up on the same Scheduled page.

### Documents

*"Draft a 2-page board memo on Q1 results. Use the attached financial summary and the previous board memo as references. Direct tone, no jargon. Save to /Documents/Board/."*

Document skills produce real files in OneDrive or SharePoint, not inline text. They show up in the side panel and persist afterwards; **Download All** grabs a session's outputs as a zip. Chains are common: *"build the deck, save it to OneDrive, and post a link in #leadership"* touches three skills, and each external action is approved separately.

### Search and research

*"Run a competitive analysis of our top three competitors using the product team's research files and the industry reports in /SharePoint/Industry. Produce a Word document with an executive summary and an Excel comparison matrix. Flag capability gaps. Use Critique."*

Enterprise Search is the broad sweep across mail, calendar, files, Teams, OneNote, and SharePoint, answering with citations and bounded by existing permissions. Deep Research is the multi-step synthesis, optionally routed through Researcher's Critique. Treat the citations as your audit trail for anything you forward outside the company.

## Approvals, pause, and the Tasks view

**Approvals.** Before sending mail, posting in Teams, or scheduling a meeting, Cowork shows a preview of the content (recipients, subject, body, time, channel), a risk-level indicator for medium and high risk actions, and a **Show parameters** option for the technical detail.

You then hit the action button, open the dropdown next to it to approve and skip similar prompts for the rest of the session, or cancel. For mail and Teams messages the dropdown is scoped: skip only for one recipient, only for a domain, or always for that action. Use the narrowest scope that gets you through the task, and never widen it in a conversation touching external recipients.

**Pause and resume.** Pause finishes the current step and halts, a hard pause stops immediately, resume continues, cancel ends the task. Lose the network and it reconnects and picks up where it stopped.

**Tasks is your working record.** Two views: Recent, in reverse chronological order with filters for In progress, Needs input, Done, and Failed, and Scheduled, which appears once you have at least one scheduled prompt or event-driven task and lets you edit, pause, resume, or delete each. Click any task to jump back into its session. When Cowork needs something from you, the status reads *Needs user input* until you answer. For the actual audit trail, go to the unified audit log, not this view.

## Grounding it properly

Output quality tracks context almost linearly. A vague prompt against an empty workspace gives generic text. The same prompt with three well-chosen attachments gives something you can send.

Three ways to add context: drag and drop from your device, use **Add work context** to pull files, people, meetings, and chats from OneDrive, SharePoint, or Teams, or reference a path in the prompt ("use `/Documents/Brand/guide.pdf`").

What has measurably lifted quality for my customers:

- **A brand and tone kit.** One folder with the style guide, a sample memo, and a glossary. *"Match the tone and structure of the attached memo."* The output starts reading like your team.
- **A context pack per recurring task.** For a weekly report: last period's deliverable, a definitions file, the data source. Attach the folder and the output stays consistent across cycles.
- **Source pinning.** *"Only state facts from the attached document. Flag anything I need to verify separately."* This is the cheapest hallucination control available.

{: .q-left }
> **Hard numbers.** Attachments under **200 MB** each. Prompts up to **250,000 characters**. Files must sit in OneDrive, SharePoint, or Teams, with no local-drive access. Cowork **cannot read encrypted files**, even ones you can open yourself. Work IQ grounds it automatically and within permissions, but explicit attachments are per-task and are not re-read later, so reattach or reference the path.

## Limits

Lead with these in your enablement material. Users should meet the boundaries in training, not on a Friday afternoon.

By design: no local file access, no file deletion in OneDrive or SharePoint (Cowork creates and edits, users delete), no reading encrypted files, no Microsoft validation of custom skills, 200 MB per attachment and 250,000 characters per prompt.

Regional and governance: Anthropic off by default in EU, EFTA, and UK with admin opt-in, and a fresh opt-in required if you had enabled it under Anthropic's own terms before; preview models with data retention off everywhere until separately enabled; only non-federal GCC can opt in among government clouds, processed outside the FedRAMP-authorised US Government cloud, with federal GCC, GCC High, DoD, and other sovereign clouds excluded and no toggle shown; use limited to Anthropic-supported countries and regions.

Compliance surface: supported today are DSPM and DSPM for AI, auditing, sensitivity labels including inheritance, encryption without labels, Insider Risk Management, communication compliance, eDiscovery, and data lifecycle management. **Not supported: data loss prevention, data classification, and Compliance Manager.** Cowork interactions also show in activity explorer but not on the Apps and agents dashboard or the AI observability page. Validate your own coverage before you rely on any of it as regulatory evidence.

{: .q-left }
> **The trade honestly stated.** Cowork gives up some autonomy and breadth in exchange for keeping AI-driven actions inside auditable, policy-governed, compliance-covered infrastructure. For regulated enterprises that trade is the reason to buy it.

**Re-check monthly:** the model lineup, which turned over inside two months at GA; the skill list and custom-skill cap; regional availability and the EU, preview-model, and GCC settings; billing; the plugin catalogue; and whether DLP support for Cowork has landed. It was announced as coming at GA and as of mid-August it still has not.

## What is coming: E7, Agent 365, Researcher, plugins

**Microsoft 365 E7, the Frontier Suite.** Generally available **1 May 2026 at $99 per user per month**. It bundles E5, the Entra Suite, Microsoft 365 Copilot including Cowork, and Agent 365. Microsoft's own pitch is that the suite costs less than buying those parts separately, so the business case rests on whether you would have bought Agent 365 governance and Cowork-class capability anyway.

**Agent 365, the control plane for agents.** Generally available **1 May 2026**, $15 per user per month standalone or included in E7. It extends Microsoft's user-management stack to AI agents: central identity, security, and compliance across Copilot Studio agents, custom agents, partner agents, and Cowork itself. Some parts, including shadow-agent discovery and Windows 365 for Agents, are still preview. Start your agent inventory now, even if it is Cowork plus two Copilot Studio agents.

**Researcher with Critique.** One model drafts, a second model from a different provider reviews for accuracy, completeness, and citation integrity. Microsoft reports a **DRACO score of 57.4, about 13.8% above single-model approaches**.

{: .q-left }
> **Read that benchmark carefully.** Those figures are Microsoft's own evaluation, not independently verified, and I could not trace them to a current primary Microsoft source when I last checked. The baseline is also described slightly differently across Microsoft's materials. If you quote it, say "Microsoft-reported" and do not hang a decision on it.

**Plugins.** At GA, Cowork opened to partner plugins with nine live: Enosix, Harvey, LSEG, Miro, monday.com, Moody's, Morningstar, S&P Global Energy, and TeamsMaestro. Adobe, Atlassian, Box, Canva, CB Insights, Databricks, MoneyForward, and Templafy were announced as next. On the Microsoft side, Fabric IQ and the Dynamics 365 Sales, Customer Service, and ERP plugins are GA, with Sales and Customer Service enabled by default and disableable in the admin center. The catalogue moves, so check the App Store rather than any list, including this one. Plugins are how third-party tools reach Cowork, built on the same package format and skill standard as your own `SKILL.md` files, and admins control which ones are visible. Since June you can also upload your own plugin package and share skills and plugins with named colleagues, so a curated team library is worth starting now.

## Checklist

**Admins standing up Cowork:**

- Confirm Copilot licenses, then enable usage-based billing with Copilot Credits, spending limits, and alerts in place first.
- Set discoverability, scope access to a pilot security group, and decide how you handle access requests.
- Make the Anthropic decision using the six steps above, documented, and decide separately whether preview models with data retention are allowed at all.
- Test sensitivity labels and their inheritance end-to-end, wire the audit log into your SIEM, and note that DLP does not yet cover Cowork.
- Publish an approved-use matrix and a short user guide that leads with the limits.

**Your first two weeks as a user:**

- Set up one scheduled Daily Briefing and refine its format.
- Build one custom skill, starting with `weekly-report`, and sharpen its description.
- Run one document workflow with grounding attachments end-to-end.
- Use the Tasks view as your audit trail and approve external actions deliberately.

## Where this leaves you

Cowork closes the gap between deciding something needs doing and it being done. The briefing that cost thirty minutes of tab-switching is drafted before your first coffee. The weekly report that depended on one person remembering scattered threads gets assembled, cited, and formatted by a scheduled skill. That payoff shows up for teams that invest in the setup: sharp skill descriptions, grounded attachments, disciplined approvals.

The obligations come with it. Every action Cowork takes goes out under your name and your organisation's compliance posture. The subprocessor decision, the DLP wiring, the label hygiene, the spending limits: none of that is governance theatre, it is what makes the capability safe to scale.

In Europe there is one more layer. The EU AI Act and GDPR do not block Cowork, they require documented intent. Enabling third-party models deliberately, keeping audit trails, and telling employees what is happening is work you can show to customers, regulators, and candidates.

So: start narrow, learn fast, govern from day one, expand on evidence. One team, one skill, one scheduled briefing, two weeks. Then read the Tasks log, fix the prompts, add the next use case. The organisations that will look back at 2026 as a turning point are not the ones with the broadest rollout. They are the ones that built the smallest trustworthy foundation first.

## Sources

**Microsoft:**

- [Cowork overview & FAQ (Microsoft Learn)](https://learn.microsoft.com/en-us/microsoft-365/copilot/cowork/)
- [Copilot Cowork is now generally available (Microsoft 365 Blog, 16 Jun 2026)](https://www.microsoft.com/en-us/microsoft-365/blog/2026/06/16/copilot-cowork-is-now-generally-available/)
- [Connect to an AI subprocessor (Microsoft Learn)](https://learn.microsoft.com/en-us/microsoft-365/copilot/connect-to-ai-subprocessor)
- [Anthropic models in Copilot for Microsoft 365 apps (Microsoft Learn)](https://learn.microsoft.com/en-us/microsoft-365/copilot/copilot-anthropic-apps)
- [Introducing Microsoft 365 E7: The Frontier Suite](https://microsoftpartners.microsoft.com/abs/Blog/?title=Introducing%20Microsoft%20365%20E7:%20The%20Frontier%20Suite)
- [Microsoft Agent 365 now generally available (Microsoft Security Blog, 1 May 2026)](https://www.microsoft.com/en-us/security/blog/2026/05/01/microsoft-agent-365-now-generally-available-expands-capabilities-and-integrations/)
- [Build plugins & skills for Cowork (Microsoft Learn)](https://learn.microsoft.com/en-us/microsoft-365/copilot/cowork/cowork-plugin-development)

**Standards and background:**

- [Agent Skills standard, agentskills.io](https://agentskills.io/home) · [Anthropic Skills examples, github.com/anthropics/skills](https://github.com/anthropics/skills)
- My 14-part Cowork series (April to May 2026) at [holgerimbery.blog](https://holgerimbery.blog)
