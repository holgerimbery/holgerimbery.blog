---
layout: post
canonical_url: https://holgerimbery.blog/information-barriers-copilot
title: "Information Barriers and Copilot - The Control Nobody Checks"
description: "Information Barriers shape what Copilot can find before any sensitivity label or DLP policy is involved. Here is where they hold, where agents step around them, and what to put in place for the gaps."
date: 26-10-17
author: admin
slug: information-barriers-copilot
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/09/shane-monarc-RH-lqMBPYiM-unsplash.jpg
image_caption: "Photo by <a href=\"https://unsplash.com/@calowaii?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText\">Shane Monarc</a> on <a href=\"https://unsplash.com/photos/wire-fence-on-grassy-hill-RH-lqMBPYiM?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText\">Unsplash</a>"
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
> Most Copilot readiness projects start with sensitivity labels and DLP. Information Barriers rarely come up, and I think that is the wrong way round. A label protects a file that Copilot has already found. An Information Barrier helps decide whether Copilot finds it at all. This article explains what Information Barriers really do for Copilot, the one sentence Microsoft writes about it, the gaps in the agent layer, and the controls I would add to close them.

## The usual answer is only half right

Ask whether Copilot can show a user something they should never see, and you usually hear this:

**Copilot can only access what the user can access.**

That is true. But it is not the whole story. Copilot has no Information Barriers filter of its own. It answers from content that is trimmed to the user's permissions. Information Barriers change those permissions in Teams, SharePoint, and OneDrive. So Copilot inherits the barrier. It does not enforce it.

That difference drives everything in this article. Where the barrier has shaped the permissions, Copilot respects it. Where content reaches Copilot by another route, the barrier is not there.

## What Information Barriers actually do

Information Barriers is a Microsoft Purview feature that "restricts two-way communication and collaboration between groups and users in Microsoft Teams, SharePoint, and OneDrive" ([Learn about Information Barriers](https://learn.microsoft.com/en-us/purview/information-barriers)). It exists for conflict-of-interest walls. Microsoft names the financial services industry as the main driver, with FINRA reviewing these walls inside member firms ([Information Barriers in Microsoft Teams](https://learn.microsoft.com/en-us/purview/information-barriers-teams)). Think of Research and Trading in a bank, or two lawyers in one firm who represent competing clients.

You build it from three parts:

* **Attributes.** A value on the user account in Microsoft Entra ID, such as department, job title, or group membership.
* **Segments.** Groups of users defined by those attributes, such as Research and Trading. A tenant can have up to 5,000 segments, and a user can be in up to 10 of them, unless the tenant is still in the older Legacy mode (250 segments, one per user) ([Get started with Information Barriers](https://learn.microsoft.com/en-us/purview/information-barriers-policies)).
* **Policies.** Rules that either block one segment from another, or allow a segment to talk only to specific other segments.

Five facts surprise most people.

**Email is not covered.** Microsoft says Information Barriers policies "can't restrict communication and collaboration between groups and users in email messages including Exchange Online". A Trading user who cannot chat with Research in Teams can still email them a file. Once it is in their mailbox, Copilot can read it for them.

**Only Microsoft 365 Groups count as groups.** Distribution lists and security groups "are treated as non-IB groups" ([Get started with Information Barriers](https://learn.microsoft.com/en-us/purview/information-barriers-policies)). You can still use group membership to define a segment. But when people share with a distribution list or a security group, the barrier does not police that group the way it polices a Microsoft 365 Group.

**Barriers are always two-way.** Microsoft supports only two-way restrictions. You cannot let Marketing reach Trading while blocking the reverse. In practice you still write two block policies, one for each direction, and you need both.

**It takes time to switch on.** You must turn on scoped directory search in Teams and wait at least 24 hours before you define policies. Once applied, policies start after about 30 minutes and then process "about 5,000 user accounts per hour". For a tenant of 50,000 users, that is roughly ten hours before every account is covered.

**Viva Engage gets a notice, not a barrier.** Users in a segment see a bar on the publisher that reminds them their post is visible to everyone in the network ([Information barriers in Viva Engage](https://learn.microsoft.com/en-us/viva/engage/manage-security-and-compliance/engage-information-barriers)). It blocks nothing. It also needs Microsoft 365 E5, and the toggle is off by default.

## Teams policies do not protect SharePoint until you say so

This is the step I see missed most often. When you create a team, Microsoft also creates a SharePoint site for its files. Microsoft is clear that Information Barriers policies "don't apply to this SharePoint site and its files by default" ([Information Barriers in Microsoft Teams](https://learn.microsoft.com/en-us/purview/information-barriers-teams)).

SharePoint and OneDrive have their own switch. You turn both on together, with one PowerShell command, and Microsoft says to allow about one hour for it to take effect ([Use Information Barriers with SharePoint](https://learn.microsoft.com/en-us/purview/information-barriers-sharepoint)).

```powershell
Set-SPOTenant -InformationBarriersSuspension $false
```

If you only configure the Teams side, chat and calls are walled off. The files are not. Copilot reads the files.

## Site modes decide how much the barrier adds

Every SharePoint site in a tenant with Information Barriers has a mode ([Use Information Barriers with SharePoint](https://learn.microsoft.com/en-us/purview/information-barriers-sharepoint)). The mode decides who gets in.

| Mode | Who gets in | What the barrier adds |
|---|---|---|
| Open | Anyone with site permissions | Nothing on access |
| Owner Moderated | Site permissions, or group membership on group sites | Only the owner can share. Built to let incompatible users in on purpose |
| Implicit | Members of the connected Microsoft 365 group | Keeps the group membership compliant |
| Explicit | Users whose segment matches the site, and who have permission | A segment check on every access |

Open is the default for any site without segments. That includes sites a SharePoint admin creates in the admin center and sites created by users who are not in a segment. When a segmented user creates a site, it becomes Explicit automatically.

Implicit is a real control, but an indirect one. Access follows group membership, and Microsoft's compliance assistant removes users who should not be in the group. If the membership is right, the site is right.

Explicit is the only mode that checks the segment itself at the moment of access. It is the strongest wall you can build in SharePoint.

{: .warning }
Teams created before you turned on Information Barriers start in Open mode, where "no IB policies apply". Microsoft says you "must update mode of your existing teams to Implicit" and then update the connected SharePoint sites as well. Private channel sites that already exist also stay Open until you change them. Skip this sweep, and you will tell the board you have barriers while Copilot keeps searching the old estate.

OneDrive follows similar rules. When you turn on the SharePoint and OneDrive switch, the OneDrive of a user in a segment becomes Explicit within 24 hours. A OneDrive of a user without a segment stays Open. There is also a Mixed mode that lets a segmented OneDrive be shared with users who have no segment ([Use Information Barriers with OneDrive](https://learn.microsoft.com/en-us/purview/information-barriers-onedrive)).

## The one sentence Microsoft writes about barriers and Copilot

The SharePoint article has a section called "Tenant wide search and Copilot experience". It lists when users see results. For sites with segments, like Explicit sites, results appear when the user's segment matches the site and the user has permission. For Open, Implicit, and Owner Moderated sites, results appear when the user has existing access. Then comes this:

> If the user had access to the site and content prior to the policy application, they continue to see the site and its contents in search and Copilot results.
>
> <cite>– Microsoft Learn, Use Information Barriers with SharePoint</cite>

The next sentence says that when they try to open the content, access is denied if they don't comply with the site's policy.

So the check happens when someone opens a file, not when the result is shown. A user who is newly placed behind a barrier cannot open the document. But they may still get the title, a snippet, or a Copilot summary of it. The file is locked. The content is not.

For a conflict-of-interest wall, that is the wrong way to fail. Two things are not clear from the documentation. First, Microsoft does not say how long this window lasts. Second, because the sentence sits right after the Implicit and Owner Moderated item, it is not clear whether it also applies to Explicit sites. Do not assume either answer. Test both in your own tenant.

Everywhere else, the documentation is quiet. The [semantic index](https://learn.microsoft.com/en-us/microsoftsearch/semantic-index-for-copilot) article says the index "respects all organizational boundaries within your tenant", but never names Information Barriers. The [Copilot data protection architecture](https://learn.microsoft.com/en-us/microsoft-365/copilot/microsoft-365-copilot-architecture-data-protection-auditing) article does not mention them. The Purview capability tables for Copilot Studio and for Cowork have no Information Barriers row. Neither does Microsoft's deployment guide for [securing Microsoft 365 Copilot agents](https://learn.microsoft.com/en-us/purview/deploymentmodels/depmod-sc-agents-deployment).

{: .important }
Treat Information Barriers as a precondition for Copilot readiness, not as a Copilot guardrail.

## The trade is real, and it is yours to make

Information Barriers really do reduce oversharing. Say M&A documents sit on a site that Corporate Finance can read. Copilot will show them to Corporate Finance. An Explicit site stops that for anyone outside the segment who never had access.

They also help in a less obvious way. Copilot is the business case that finally pays for the permission cleanup IT has wanted for years. My order is simple: fix permissions, then set up the barriers, then turn on Copilot. Do it the other way round, and you learn about your permission model from user complaints.

The cost is just as real.

| What you gain | What it costs |
|---|---|
| Less oversharing through AI | Copilot knows less |
| Regulatory walls enforced | Silos you create on purpose |
| Confidential projects protected | Answers that look incomplete, correctly |
| A stronger governance story | Real design and operations effort |
| A forced permission cleanup | No reach into the agent layer |

The last row is the one that matters most now.

## Where the wall breaks: three agent surfaces

### 1. Agent Builder, documented and by design

Agent Builder lets a user upload up to 20 files from their device as knowledge for an agent. Microsoft is direct about what that means:

> Microsoft Purview Information Barriers (IB) isn't supported on embedded files. Any user who can access the agent can see responses grounded in the embedded file content.
>
> <cite>– Microsoft Learn, Add knowledge sources to your declarative agent in Microsoft 365 Copilot</cite>

A user in Segment A uploads a restricted document. They share the agent with Segment B. Segment B now gets answers based on that document. Nothing is broken. This is how it is documented to work. The builder can share the agent with anyone in the organization, with specific users, or only with themselves.

There is one control that does reach this path: sensitivity labels. The embedded content takes the highest-priority label of the uploaded files. Only users with extract rights to that label can use the agent. Everyone else can see the listing but cannot install or use it. So a label that encrypts content for one segment only also limits the agent to that segment. A label without encryption does not.

Other Agent Builder sources behave better. SharePoint and OneDrive knowledge "respects existing permissions and sensitivity labels". Email knowledge is never shared: users you share the agent with don't get access to your mailbox.

{: .caution }
If you run Information Barriers for regulatory reasons, restrict file upload in Agent Builder and govern agent sharing as strictly as file sharing. Where upload must stay on, make sure restricted files carry an encrypting label.

### 2. Copilot Studio, where the identity decides

Copilot Studio documents permission trimming and never mentions Information Barriers. The key sentence is in the SharePoint knowledge article: when you publish an agent, "the calls that use generative answers are made on behalf of the user who is chatting with the agent" ([Add SharePoint as a knowledge source](https://learn.microsoft.com/en-us/microsoft-copilot-studio/knowledge-add-sharepoint)).

So SharePoint knowledge inherits the barrier because it runs as the user. The agent "surfaces only content that the user has permission to access". That makes the user's identity the real control. Here is how the authentication options play out ([Configure user authentication in Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/configuration-end-user-authentication)).

| Option | What it means for your barriers |
|---|---|
| No authentication | The agent can't read SharePoint at all. But anyone with the link can chat, and you can't limit who |
| Authenticate with Microsoft | The default. Runs as the signed-in user, so barriers carry through |
| Authenticate manually (Entra ID) | Still runs as the user. The required scopes "don't give users increased permissions" |
| Authenticate manually (Generic OAuth) | Not supported for SharePoint knowledge. You can't limit which users chat with the agent |

Teams and Microsoft 365 channels accept only "Authenticate with Microsoft". That is a useful safety rail.

The guarantee covers generative answers. It does not automatically cover everything else an agent can do. My own reading: any tool, flow, or connector that calls SharePoint with a fixed account, instead of the user's own sign-in, sits outside this promise. Review those one by one.

Dataverse is a separate case. Dataverse knowledge follows Dataverse security settings. Information Barriers cover Teams, SharePoint, and OneDrive, so segments play no part there.

You can enforce a lot at tenant level. Power Platform data policies can block unauthenticated usage, individual channels, knowledge sources, and connectors across all environments ([Implement a zoned governance strategy](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/sec-gov-phase2)). When a data policy requires authentication, makers can't pick "No authentication". Use it.

### 3. Copilot Cowork, mostly undocumented

Microsoft made Cowork generally available on 16 June 2026 ([Copilot Cowork is now generally available](https://www.microsoft.com/en-us/copilot/blog/2026/06/16/copilot-cowork-is-now-generally-available/)). The admin guide says automated tasks run "with the user's permissions" and each one "sees only the data that user can see". Files are processed in a temporary environment inside the Microsoft 365 service boundary ([Manage Copilot Cowork for your organization](https://learn.microsoft.com/en-us/microsoft-365/copilot/cowork/cowork-admin-governance)).

The Purview page for Cowork lists what is supported ([Use Microsoft Purview with Copilot Cowork](https://learn.microsoft.com/en-us/purview/ai-copilot-cowork)).

| Supported | Not supported |
|---|---|
| DSPM and DSPM for AI (classic) | Data classification |
| Auditing | Data loss prevention |
| Sensitivity labels | Compliance Manager |
| Encryption without sensitivity labels | |
| Insider Risk Management | |
| Communication compliance | |
| eDiscovery | |
| Data Lifecycle Management | |

The GA announcement listed DLP as "coming soon". The Purview page still shows it as not supported. Cowork activity also "doesn't display in the Apps and agents dashboard or the AI observability page", although it does show in activity explorer.

Information Barriers appear in exactly one Cowork article. The plugin developer guide says Information Barriers "aren't currently supported for plugin or skill management and sharing". In tenants with barriers turned on, uploads of embedded knowledge files for plugins and skills are blocked for the whole tenant ([Build plugins for Copilot Cowork](https://learn.microsoft.com/en-us/microsoft-365/copilot/cowork/cowork-plugin-development)). That is the safe way to fail: blocked, not leaked.

For the core of Cowork, the part that searches your files, mail, and chats across many steps, there is still no statement. Not supported, not unsupported.

Do not read "runs with the user's permissions" as full coverage. Permissions and barriers are not the same thing. Barriers add a segment check on top of permissions in Explicit sites. Their known gaps are email, old access, and content from outside Microsoft 365. Those are exactly the places Cowork reaches when it works across many tools. And plugin connectors pull live data from outside systems, where barriers have no reach at all. Missing documentation does not mean missing enforcement. But "probably fine" is not an answer you give a regulator.

Access to Cowork comes only from a spending policy that selects Cowork. Microsoft is explicit: a very low credit limit still grants access, so to keep someone out, leave them out of every such policy. That makes exclusion easy. Keep segmented users out of every Cowork spending policy until you have tested the scenarios below, or until Microsoft publishes a statement.

## Four more gaps outside the agent layer

**Email.** Covered above, but it bears repeating. Barriers do not apply to Exchange. Copilot grounds on the user's mailbox. Anything that crosses the wall by email is inside the wall for Copilot.

**Copilot connectors.** Content from outside Microsoft 365 is indexed with the source system's own access list. "Search and Copilot only show items to users who have access in the source system" ([Copilot connectors overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/connectors/overview)). There is no segment model for this content. A Confluence page that everyone can read shows up for every segment. Federated connectors fetch live data from the source instead of indexing it, with the same result. In most deployments this is the largest blind spot.

**App-only access.** SharePoint has an opt-in setting that lets applications running in app-only mode reach sites protected by barriers. It is `Set-SPOTenant -AppBypassInformationBarriers $true`. Anything running as a service principal is in this category. Check the setting before any agent rollout, and write down why if it is on.

**Teams meetings.** When a meeting overflows, extra people join as view-only attendees, and "view-only participants aren't subject to IB policy checks". Users from federated external organizations "aren't restricted by IB policies" either ([Information Barriers in Microsoft Teams](https://learn.microsoft.com/en-us/purview/information-barriers-teams)). Meeting transcripts and recaps then feed Copilot.

## What does enforce at the AI layer

The control that works directly at the AI layer is DLP for the Microsoft 365 Copilot and Copilot Chat location. A rule with the "Content contains > Sensitivity labels" condition stops Copilot from using files and emails with that label when it writes a response ([DLP for Microsoft 365 Copilot and Copilot Chat](https://learn.microsoft.com/en-us/purview/dlp-microsoft365-copilot-location-learn-about)). DSPM for AI offers the same thing as a one-click policy that "blocks Microsoft 365 Copilot and agents from processing items with the sensitivity labels selected" ([DSPM for AI considerations](https://learn.microsoft.com/en-us/purview/dspm-for-ai-considerations)).

Know its limits before you rely on it:

* It works on labels, not segments.
* The labeled item can still appear in the citations. Its content is not used.
* Policy changes can take up to four hours to reach Copilot.
* Files that users upload directly into a prompt are not scanned.
* For Copilot Studio, it applies only when the knowledge source is SharePoint ([Purview for Copilot Studio](https://learn.microsoft.com/en-us/purview/ai-copilot-studio)).
* For Cowork, DLP is not supported today.

Label encryption goes further. When a label encrypts content, the user needs both the VIEW and EXTRACT usage rights before Copilot returns the data. Microsoft documents this for Microsoft 365 Copilot, for Copilot Studio, and for Cowork. In Agent Builder, users without extract rights cannot even use the agent.

That leads to a pattern the documentation does not spell out: mirror your segments into sensitivity labels, and enforce at both layers. Information Barriers handle collaboration. Labels with encryption, scoped to the right people, travel with the file into every AI surface. DLP adds a second block where it is supported.

Restricted Content Discovery is a useful companion for the old-access window. It keeps a site out of organization-wide search and Copilot answers, and removes AI entry points such as the Copilot button from the site ([Restrict discovery of SharePoint sites and content](https://learn.microsoft.com/en-us/sharepoint/restricted-content-discovery)). But read the small print:

* It "doesn't change existing permissions" and doesn't remove content from the search index.
* Users "can still discover content they own or have recently interacted with". That is exactly the user who had access before the barrier.
* It needs a Copilot license and SharePoint Advanced Management.
* On sites with more than 500,000 items, a change can take more than a week to show up.

If you need a harder stop, you can take a site out of search completely. Setting "Allow this site to appear in search results" to No removes it from both Microsoft Search and the semantic index ([Semantic indexing for Microsoft Copilot](https://learn.microsoft.com/en-us/microsoftsearch/semantic-index-for-copilot)). It is a blunt tool. Use it for a few sites, not as a strategy.

## What I would check before shipping

Run these tests in your own tenant. The documentation predicts a gap in several of them.

1. Confirm that Information Barriers are switched on for SharePoint and OneDrive, not only for Teams.
2. Move every team created before the barrier out of Open mode, then update the connected sites and existing private channel sites.
3. Ask Copilot, as a user from another segment who never had access, about content on an Explicit site. Expect nothing.
4. Ask the same question as a user who had access before the policy. Do it for an Explicit site and for an Implicit site. Expect leakage on at least one, and time how long it lasts.
5. Upload a restricted file into an Agent Builder agent and share it across a barrier. Expect it to leak. Repeat with an encrypting label and confirm the other segment is locked out.
6. Email a restricted file across the barrier, then ask Copilot about it as the recipient. Expect an answer.
7. Query connector content with broad source access as a user from another segment. Expect it to show up.
8. Confirm that the app-only bypass setting is off, or documented.
9. Check the people picker, org chart, and People tab for blocked users.
10. Put segmented test users in a Cowork spending policy in a test environment, and repeat tests 3, 4, and 6 with a multi-step task.

My position is this. Information Barriers are still one of the strongest controls for making Copilot safe in a regulated environment. But anyone who tells a regulator "we have barriers, so Copilot cannot cross the wall" is claiming more than Microsoft documents. The feature was built for communication walls. Copilot is a retrieval system. Microsoft did not rebuild the barrier as a filter at retrieval time. It lets the barrier shape the permissions that Copilot reads. That works where the two line up. It fails where they drift apart: old access, email, uploaded files, connectors, and app-only access.

Every barrier you create also reduces what Copilot knows. The skill is not building as many as you can. It is building only the ones a regulation demands, backing them with encrypting labels, and then closing the agent-layer gaps the barriers never reach.

Watch for one signal: the day Information Barriers appear as a row in the Purview capability tables for AI. The Cowork plugin note shows Microsoft has started to write about it. When the tables change, this article needs a rewrite.

## Sources

* Microsoft Learn, [Learn about Information Barriers](https://learn.microsoft.com/en-us/purview/information-barriers), last updated 17 September 2026: the two-way scope across Teams, SharePoint, and OneDrive, the Exchange exclusion, two-way-only restrictions
* Microsoft Learn, [Get started with Information Barriers](https://learn.microsoft.com/en-us/purview/information-barriers-policies), last updated 22 April 2026: attributes, segments, and policies, segment limits, non-IB groups, the 24-hour wait, the policy application rate
* Microsoft Learn, [Information Barriers in Microsoft Teams](https://learn.microsoft.com/en-us/purview/information-barriers-teams), last updated 1 June 2026: the FINRA background, Open mode for existing teams, team sites not covered by default, people discovery, meeting overflow and federation gaps
* Microsoft Learn, [Use Information Barriers with SharePoint](https://learn.microsoft.com/en-us/purview/information-barriers-sharepoint), last updated 30 March 2026: the switch for SharePoint and OneDrive, site modes and defaults, private channel sites, the search and Copilot statement, the app-only bypass setting
* Microsoft Learn, [Use Information Barriers with OneDrive](https://learn.microsoft.com/en-us/purview/information-barriers-onedrive), last updated 30 March 2026: OneDrive modes, including Mixed
* Microsoft Learn, [Information barriers in Viva Engage](https://learn.microsoft.com/en-us/viva/engage/manage-security-and-compliance/engage-information-barriers), last updated 24 May 2026: the publisher notice and its E5 prerequisite
* Microsoft Learn, [Semantic indexing for Microsoft Copilot](https://learn.microsoft.com/en-us/microsoftsearch/semantic-index-for-copilot), last updated 23 April 2026: permission-based grounding, the search exclusion setting, and no mention of Information Barriers
* Microsoft Learn, [Microsoft Copilot data protection architecture](https://learn.microsoft.com/en-us/microsoft-365/copilot/microsoft-365-copilot-architecture-data-protection-auditing), last updated 18 August 2026: label and encryption enforcement, and no mention of Information Barriers
* Microsoft Learn, [Add knowledge sources to your declarative agent in Microsoft 365 Copilot](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/agent-builder-add-knowledge), last updated 25 September 2026: the embedded-file exclusion, sharing options, extract rights for embedded content, Dataverse security
* Microsoft Learn, [Add SharePoint as a knowledge source](https://learn.microsoft.com/en-us/microsoft-copilot-studio/knowledge-add-sharepoint), last updated 4 August 2026: on-behalf-of grounding, permission trimming, manual authentication scopes
* Microsoft Learn, [Configure user authentication in Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/configuration-end-user-authentication), last updated 1 May 2026: authentication options, the Teams channel constraint, data policies that require authentication
* Microsoft Learn, [Implement a zoned governance strategy](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/sec-gov-phase2), last updated 20 January 2026: tenant-level data policies for Copilot Studio
* Microsoft Learn, [Use Microsoft Purview to manage data security & compliance for Microsoft Copilot Studio](https://learn.microsoft.com/en-us/purview/ai-copilot-studio), last updated 1 May 2026: the capability table with no Information Barriers row, DLP limited to SharePoint knowledge
* Microsoft Learn, [Use Microsoft Purview to manage data security & compliance for Microsoft 365 Copilot Cowork](https://learn.microsoft.com/en-us/purview/ai-copilot-cowork), last updated 22 June 2026: supported and unsupported Purview capabilities for Cowork, the dashboard gap
* Microsoft Learn, [Manage Copilot Cowork for your organization](https://learn.microsoft.com/en-us/microsoft-365/copilot/cowork/cowork-admin-governance), last updated 14 September 2026: the spending policy as access control, automated tasks running as the user, processing inside the service boundary
* Microsoft Learn, [Build plugins for Copilot Cowork](https://learn.microsoft.com/en-us/microsoft-365/copilot/cowork/cowork-plugin-development), last updated 21 September 2026: the Information Barriers note for plugins and skills
* Microsoft AI at Work Blog, [Copilot Cowork is now generally available](https://www.microsoft.com/en-us/copilot/blog/2026/06/16/copilot-cowork-is-now-generally-available/), 16 June 2026: the GA date, DLP listed as coming soon
* Microsoft Learn, [Copilot connectors overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/connectors/overview), last updated 22 September 2026: access lists from the source system, synced and federated connectors
* Microsoft Learn, [Learn about using Microsoft Purview Data Loss Prevention to protect interactions with Microsoft 365 Copilot and Copilot Chat](https://learn.microsoft.com/en-us/purview/dlp-microsoft365-copilot-location-learn-about), last updated 17 September 2026: the label condition, citations, the four-hour delay, uploaded files not scanned
* Microsoft Learn, [Considerations for deploying DSPM for AI (classic)](https://learn.microsoft.com/en-us/purview/dspm-for-ai-considerations), last updated 1 May 2026: the one-click policy that blocks Copilot from processing labeled items
* Microsoft Learn, [Restrict discovery of SharePoint sites and content](https://learn.microsoft.com/en-us/sharepoint/restricted-content-discovery), last updated 22 September 2026: what Restricted Content Discovery does and does not do, prerequisites, propagation time
* Microsoft Learn, [Secure and govern Microsoft 365 Copilot agents](https://learn.microsoft.com/en-us/purview/deploymentmodels/depmod-sc-agents-deployment), last updated 3 April 2026: the agent security blueprint, which does not mention Information Barriers

**Three open conflicts as of publication:** The Cowork GA announcement lists DLP as coming soon, while the Purview page for Cowork still marks it as not supported. The Restricted Content Discovery article says in one place that it limits recently interacted files and in another that users can still discover them. And the SharePoint article does not make clear whether the old-access sentence for search and Copilot also covers Explicit sites. Verify all three in your own tenant.
