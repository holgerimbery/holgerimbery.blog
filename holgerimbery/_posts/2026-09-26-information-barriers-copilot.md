---
layout: post
canonical_url: https://holgerimbery.blog/information-barriers-copilot
title: "Information Barriers and Copilot - The Control Nobody Checks"
description: "Information Barriers decide what Copilot can see, before any sensitivity label or DLP policy gets a chance. Here is where they hold, and where agents walk straight through them."
date: 26-09-26
author: admin
slug: information-barriers-copilot
image: /images/2026/09/shane-monarc-RH-lqMBPYiM-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@calowaii?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Shane Monarc</a> on <a href="https://unsplash.com/photos/wire-fence-on-grassy-hill-RH-lqMBPYiM?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
tags:
  - agentbuilder
  - compliance
  - copilot
  - copilotstudio
  - cowork
  - governance
  - informationbarriers
  - purview
  - sharepoint
featured: true
toc: true
---

{: .q-left }
> Most Copilot readiness work starts with sensitivity labels and DLP. Information Barriers rarely come up, and that is backwards. A label protects a file Copilot already found. An Information Barrier decides whether Copilot finds it at all. This article covers what Information Barriers really do for Copilot, the gap Microsoft documents but nobody reads, and the three places in the agent stack where the barrier does not apply.

## The usual answer is incomplete

Ask whether Copilot can expose information a user should never see, and you get this:

{: .q-left }
> Copilot can only access what the user can access.

True, but not the whole story. Copilot has no Information Barriers filter inside it. It answers from an index trimmed by the user's permissions, and Information Barriers shape those permissions in Teams, SharePoint, and OneDrive. The barrier is inherited, not enforced.

That distinction decides everything below.

## What Information Barriers actually do

Information Barriers is a Microsoft Purview feature that "restricts two-way communication and collaboration between groups and users" in Teams, SharePoint, and OneDrive ([Learn about Information Barriers](https://learn.microsoft.com/en-us/purview/information-barriers)). It was built for conflict-of-interest walls: Research and Trading in a bank, two teams representing competing clients in a law firm.

You build it from three things. An attribute on the user account that says who someone is, such as department. Segments built from that attribute, such as Research and Trading. Policies that block two segments from each other, or allow only specific pairs.

Four things surprise most people:

* **Email is not covered.** Information Barriers "can't restrict communication and collaboration between groups and users in email messages including Exchange Online." Attachments travel with mail.
* **Only Microsoft 365 Groups count.** Distribution lists and security groups "are treated as non-IB groups" ([Get started with Information Barriers](https://learn.microsoft.com/en-us/purview/information-barriers-policies)). If your segmentation lives in security groups, the barrier cannot see it.
* **Barriers are always two-way.** You cannot let Marketing see Trading without the reverse.
* **Viva Engage support is a notice, not a barrier.** It shows the author a reminder that their post is visible to everyone ([Information barriers in Viva Engage](https://learn.microsoft.com/en-us/viva/engage/manage-security-and-compliance/engage-information-barriers)). It blocks nothing.

## Only one SharePoint site mode is a real wall

Every SharePoint site in a barriered tenant carries a mode ([Use Information Barriers with SharePoint](https://learn.microsoft.com/en-us/purview/information-barriers-sharepoint)).

| Mode | Who gets in |
|---|---|
| Open | Site permissions only. The barrier adds nothing |
| Owner Moderated | Site permissions, and only the owner can share |
| Implicit | Membership of the connected Microsoft 365 group |
| Explicit | Your segment must match the site, and you need permission |

Explicit is the only mode where Information Barriers add anything on top of normal permissions.

{: .warning }
Sites and teams created before you enabled Information Barriers default to Open mode. So do existing private channel sites. Microsoft says you "must update mode of your existing teams to Implicit." Skip that sweep and you will switch the feature on, tell the board you have barriers, and Copilot will keep surfacing the old estate.

## The one sentence Microsoft writes about barriers and Copilot

There is exactly one authoritative statement connecting the two, in a section titled "Tenant wide search and Copilot experience":
{: .q-left }
> If the user had access to the site and content prior to the policy application, they continue to see the site and its contents in search and Copilot results.
>
> <cite>– Microsoft Learn, Use Information Barriers with SharePoint</cite>

The same paragraph adds that opening the content is denied.

So enforcement happens when someone opens a file, not when the index is built. A newly barriered user is blocked on the file but may still get titles, snippets, and Copilot summaries from it. The file is closed. The content is not.

For a conflict-of-interest case that is the wrong failure mode. Microsoft does not say how long the window lasts, so measure it in your own tenant rather than assuming it is short.

Everywhere else, the documentation is quiet. The semantic index article and the Copilot data protection architecture article never mention Information Barriers. Neither does the Purview capability list for Microsoft 365 Copilot, for Copilot Studio, or for Cowork.

{: .important }
Treat Information Barriers as a precondition for Copilot readiness, not as a Copilot guardrail.

## The trade is real, and it is yours to make

Information Barriers genuinely reduce oversharing. If M&A documents sit somewhere Corporate Finance can read them, Copilot will surface them to Corporate Finance, and an Explicit-mode site stops that for anyone who never had access.

They also do something less discussed. Copilot is the business case that finally funds the permission cleanup IT has wanted for a decade. Fix permissions, then set up the barriers, then enable Copilot. The other order means discovering your permission model through user complaints.

The cost is equally real.

| What you gain | What it costs |
|---|---|
| Less AI-driven oversharing | A smaller knowledge surface for Copilot |
| Regulatory boundaries enforced | Deliberate silos |
| Confidential projects protected | Answers that legitimately look incomplete |
| Better governance posture | Serious design and operations effort |
| Forced permission cleanup | No reach into the agent layer |

The last row is the one that changed recently.

## Where the wall breaks: three agent surfaces

### 1. Agent Builder, documented and by design

Agent Builder lets a user attach uploaded files as agent knowledge. Microsoft is blunt about what that means:

> Microsoft Purview Information Barriers (IB) isn't supported on embedded files. Any user who can access the agent can see responses grounded in the embedded file content.
>
> <cite>– Microsoft Learn, Add knowledge sources to your declarative agent</cite>

Someone in Segment A uploads a restricted document, shares the agent with Segment B, and Segment B gets answers grounded in it. Nothing malfunctioned. This is documented behavior.

{: .caution }
If you run Information Barriers for regulatory reasons, restrict file upload in Agent Builder and govern agent sharing as strictly as file sharing.

### 2. Copilot Studio, where authentication decides

Copilot Studio's documentation describes permission trimming and never mentions Information Barriers. The load-bearing sentence is this: when you publish an agent, "the calls that use generative answers are made on behalf of the user who is chatting with the agent" ([Configure user authentication](https://learn.microsoft.com/en-us/microsoft-copilot-studio/configuration-end-user-authentication)).

So the barrier is inherited only when the agent runs as the user. That makes authentication mode the real control.

| Mode | What it means for your barriers |
|---|---|
| No authentication | Public content only, and you cannot control who chats with the agent |
| Authenticate with Microsoft | The safe option. The agent runs as the user, so barriers apply |
| Authenticate manually | Workable, but this is the path that drifts toward app-only access |

Teams and Microsoft 365 channels accept only "Authenticate with Microsoft," which is a useful safety rail. Two more points worth knowing: Dataverse has no Information Barriers support, and Power Platform data policies can force authentication across the tenant. Use them.

### 3. Copilot Cowork, undocumented

Cowork became generally available on 16 June 2026. Automated tasks run "with the user's permissions," files are processed inside the Microsoft 365 service boundary, and Purview covers auditing, sensitivity labels, Insider Risk Management, Communication Compliance, eDiscovery, and Data Lifecycle Management ([Purview for Copilot Cowork](https://learn.microsoft.com/en-us/purview/ai-copilot-cowork)).

Not covered: data loss prevention, data classification, and Compliance Manager. Cowork activity also "doesn't display in the Apps and agents dashboard or the AI observability page."

Information Barriers appear nowhere in any Cowork documentation. Not as supported, not as unsupported.

Do not read "runs with the user's permissions" as coverage. Permissions are not the same thing. Information Barriers sit on top of permissions in Explicit-mode sites, and their known gaps land exactly where Cowork's multi-tool retrieval operates. The absence of documentation is not the absence of enforcement, but "probably fine" is not something you take to a regulator.

A spending policy controls Cowork access, so exclusion is easy. Leave segmented users out of every policy that selects Cowork until Microsoft publishes a statement.

## Three more gaps outside the agent layer

**Copilot connectors.** External content is indexed with the source system's own access list. There is no Information Barriers model for it at all. A Confluence page with broad access surfaces regardless of segment. This is the largest blind spot in most deployments.

**App-only access.** A tenant setting explicitly allows applications running in app-only mode to reach barriered sites. Anything running as a service principal falls into that category. Check the setting before any agent rollout.

**Teams meetings.** View-only overflow participants are not checked, and federated external users "aren't restricted by IB policies" ([Information Barriers in Microsoft Teams](https://learn.microsoft.com/en-us/purview/information-barriers-teams)).

## What does enforce at the AI layer

One thing does. The DSPM for AI policy "blocks Microsoft 365 Copilot and agents from processing items with the sensitivity labels selected" ([DSPM for AI considerations](https://learn.microsoft.com/en-us/purview/dspm-for-ai-considerations)). It works on labels, not segments.

That implies a pattern the documentation does not suggest: mirror your segments into sensitivity labels and enforce at both layers. Information Barriers handle collaboration. Labels and DLP handle AI processing.

Restricted Content Discovery is the useful companion. It removes a site from org-wide search and Copilot answers and strips the AI entry points, though it "doesn't change existing permissions" and does not remove content from the index ([Restrict discovery of SharePoint sites and content](https://learn.microsoft.com/en-us/sharepoint/restricted-content-discovery)). It is a good bridge during that grandfathering window.

## What I would check before shipping

Run these in your own tenant. The documentation predicts a gap in most of them.

1. Prompt Copilot as a cross-segment user who never had access. Expect nothing.
2. Prompt as a user who previously had access. Expect leakage, and time how long it lasts.
3. Upload a restricted file into an Agent Builder agent and share it across a barrier. Expect it to leak.
4. Query connector content with broad source access as a cross-segment user. Expect it to surface.
5. Confirm the app-only bypass setting is off.
6. Check the people picker, org chart, and People tab for blocked users.
7. Move every pre-existing team and private channel site out of Open mode.

My position: Information Barriers remain one of the strongest controls for making Copilot safe in a regulated environment, and anyone telling a regulator "we have barriers, so Copilot cannot cross the wall" is overstating what Microsoft documents. The feature was built around 2019 for communication walls. Copilot is a retrieval system. Microsoft never rewrote the barrier as a retrieval-time filter; it let the barrier shape the permission surface Copilot reads. That works where the two line up and fails where they drift apart.

Every barrier you create also reduces what Copilot knows. The skill is not building as many as possible. It is building only the ones a regulation demands, then closing the agent-layer gaps those barriers never reach.

Watch for one signal: the day Information Barriers appears as a row in the Purview capability lists for AI. That is when this article needs rewriting.

## Sources

* Microsoft Learn, [Learn about Information Barriers](https://learn.microsoft.com/en-us/purview/information-barriers), last updated 17 September 2026: two-way restriction scope, the Exchange exclusion
* Microsoft Learn, [Use Information Barriers with SharePoint](https://learn.microsoft.com/en-us/purview/information-barriers-sharepoint): site modes, the search and Copilot grandfathering statement, the app-only bypass setting
* Microsoft Learn, [Get started with Information Barriers](https://learn.microsoft.com/en-us/purview/information-barriers-policies): segments, policies, the non-IB group limitation
* Microsoft Learn, [Information Barriers in Microsoft Teams](https://learn.microsoft.com/en-us/purview/information-barriers-teams), last updated 1 June 2026: people discovery, Open-mode remediation, meeting overflow and federation gaps
* Microsoft Learn, [Information barriers in Viva Engage](https://learn.microsoft.com/en-us/viva/engage/manage-security-and-compliance/engage-information-barriers), last updated 24 May 2026: the publisher notice
* Microsoft Learn, [Semantic indexing for Microsoft Copilot](https://learn.microsoft.com/en-us/microsoftsearch/semantic-index-for-copilot): permission-based grounding, and no mention of Information Barriers
* Microsoft Learn, [Microsoft Copilot data protection architecture](https://learn.microsoft.com/en-us/microsoft-365/copilot/microsoft-365-copilot-architecture-data-protection-auditing), last updated 18 August 2026: label enforcement, and no mention of Information Barriers
* Microsoft Learn, [Add knowledge sources to your declarative agent](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/agent-builder-add-knowledge): the embedded-file exclusion
* Microsoft Learn, [Configure user authentication in Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/configuration-end-user-authentication), last updated 1 May 2026: authentication modes, on-behalf-of grounding, the Teams channel constraint
* Microsoft Learn, [Add SharePoint as a knowledge source](https://learn.microsoft.com/en-us/microsoft-copilot-studio/knowledge-add-sharepoint), last updated 4 August 2026: permission trimming for agent knowledge
* Microsoft Learn, [Purview for Microsoft Copilot Studio](https://learn.microsoft.com/en-us/purview/ai-copilot-studio), last updated 1 May 2026: the capability list, which has no Information Barriers row
* Microsoft Learn, [Purview for Microsoft 365 Copilot Cowork](https://learn.microsoft.com/en-us/purview/ai-copilot-cowork), last updated 22 June 2026: supported and unsupported Purview capabilities for Cowork
* Microsoft Learn, [Manage Copilot Cowork for your organization](https://learn.microsoft.com/en-us/microsoft-365/copilot/cowork/cowork-admin-governance), last updated 14 September 2026: spending policy as access control, user-permission execution, the dashboard blind spot
* Microsoft 365 Blog, [Copilot Cowork is now generally available](https://www.microsoft.com/en-us/copilot/blog/2026/06/16/copilot-cowork-is-now-generally-available/), 16 June 2026: the GA date
* Microsoft Learn, [Copilot connectors overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/connectors/overview), last updated 4 August 2026: source-system access trimming
* Microsoft Learn, [Considerations for deploying DSPM for AI](https://learn.microsoft.com/en-us/purview/dspm-for-ai-considerations), last updated 1 May 2026: the label-based Copilot processing block
* Microsoft Learn, [Restrict discovery of SharePoint sites and content](https://learn.microsoft.com/en-us/sharepoint/restricted-content-discovery), last updated 15 September 2026: what Restricted Content Discovery does and does not do
* Microsoft Learn, [Secure and govern Microsoft 365 Copilot agents](https://learn.microsoft.com/en-us/purview/deploymentmodels/depmod-sc-agents-deployment), last updated 3 April 2026: the agent security blueprint, which does not mention Information Barriers

**One thing to verify yourself:** everything marked undocumented above — Cowork, Copilot Notebooks, Copilot Pages, and custom engine agents — should be tested in your own tenant rather than assumed, in either direction. I found no source saying these enforce Information Barriers, and none saying they do not.
