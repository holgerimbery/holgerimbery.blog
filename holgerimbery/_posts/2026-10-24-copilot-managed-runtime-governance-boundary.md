---
layout: post
canonical_url: https://holgerimbery.blog/copilot-managed-runtime-governance-boundary
title: "Copilot Managed Runtime: The Runtime Becomes the Governance Boundary"
description: "Microsoft now hosts the code that Copilot and other AI tools build. For architects, that moves governance from the build tool to the runtime. Here is what that changes, what it does not solve, and what to design before the first AI-built app goes viral."
date: 2026-10-24
author: admin
slug: copilot-managed-runtime-governance-boundary
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/10/khaleelah-ajibola-3TlpZl0_Y5w-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@akt_?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Khaleelah Ajibola</a> on <a href="https://unsplash.com/photos/a-close-up-of-a-person-typing-on-a-laptop-3TlpZl0_Y5w?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
tags:
  - agent365
  - alm
  - copilotcowork
  - copilotmanagedruntime
  - copilotstudio
  - dlp
  - finops
  - governance
  - m365copilot
  - powerplatform
featured: true
toc: true
---

{: .q-left }
> Microsoft now runs the code that Copilot, Copilot Studio, and third-party AI tools produce, inside your Microsoft 365 tenant. I think that is the right answer to a problem we can no longer solve at the build side. But a runtime is only as good as the policies behind it, and this one sits on top of the Power Platform estate you already have, with its environments, DLP, and routing rules. This article explains what was announced, where I would place it, and what I would set up in the next 90 days.

## Introduction: the tracker that 200 people now depend on

Every enterprise I work with has a version of this story. Someone in operations gets tired of a shared Excel file. They build a small tracker in an afternoon. It works. They share the link in a Teams channel. Three weeks later, 200 colleagues depend on it, it talks to a SharePoint list and a line-of-business system, and nobody in IT knows it exists. The owner is going on parental leave next month.

Five years ago that tracker was a canvas app, and the Power Platform CoE had at least a fighting chance to find it. Today the same person can describe the tracker in a chat and get working code back. Soon an agent may build it unasked.

That is the context for Microsoft Copilot Managed Runtime. My thesis is simple. Copilot Managed Runtime shifts enterprise governance from the tools people build with to the place their code runs. That is the right move, because we can no longer control who builds apps with AI. But the runtime is only as good as the policies behind it, and it arrives on top of an existing Power Platform estate. Architects should treat it as a landing zone to design deliberately, before the first AI-built app goes viral.

## What Microsoft announced, and what it did not

On 25 September 2026, Microsoft put Copilot Managed Runtime into public preview. The [Copilot blog announcement](https://www.microsoft.com/en-us/copilot/blog/copilot-studio/build-where-you-want-run-with-confidence-now-microsoft-hosts-and-manages-the-code-created-by-copilot/) describes it as a platform "to run code within the Microsoft 365 tenant boundary that's governed by IT." According to the same post, it already powers the apps built in Copilot Cowork, Copilot Code, and Copilot Studio. Microsoft is also opening it to third-party tools and professional developers. Lovable is the named third-party example.

For developers, the way in is an SDK (`@microsoft/managed-apps`) and a CLI (`@microsoft/managed-apps-cli`) invoked as `ms`. The [SDK overview on Microsoft Learn](https://learn.microsoft.com/en-us/microsoft-365/managed-apps/developer/?view=o365-worldwide) lists the documented capabilities:

* Microsoft Entra authentication and authorization out of the box
* More than 1,500 connectors, callable from JavaScript and TypeScript
* A native Git inner loop, with either a platform-managed repository or your own GitHub repository (owned by an organization on GitHub Enterprise Cloud)
* Adherence to sharing limits, Conditional Access, Advanced Connector Policies, and Data Loss Prevention
* A GitHub Copilot plugin for coding agents
* A central inventory in the Microsoft 365 admin center (**Apps > All apps**), with usage analytics and health metrics with alerting

Users open their apps at `managedapps.cloud.microsoft`. The [overview page](https://learn.microsoft.com/en-us/microsoft-365/managed-apps/?view=o365-worldwide) now lists four build paths: Cowork, Copilot Studio, Copilot Code, and the SDK with its CLI. All four produce an app that inherits the tenant's default governance policy: approved connectors, sharing rules, and content security policy.

One detail was easy to miss at launch and matters a lot: there is a Power Platform environment behind every app. According to the [admin FAQ](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/apps/faq-about-apps?view=o365-worldwide), apps are created in personal developer environments, and environment routing creates those environments for makers. They are always managed environments. Each one sits in an environment group, and that group carries the connector, sharing, and content security rules. Most of the governance discussion below comes back to this.

**Licensing.** Users need either a Power Apps Premium license or Copilot Credits to run an app. The [licensing FAQ](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/apps/licensing-faq?view=o365-worldwide) is now clear on how credits are counted. The runtime measures usage in API calls. Launching an app, reading or writing data through a connector, and publishing an app each count as an API call, and each call costs 0.1 credits. Specialized services such as Work IQ APIs are charged separately at their own rates. The October 2026 [Copilot Credits Guide](https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/bade/documents/products-and-services/en-us/ai/Copilot-Credits-Guide.pdf) lists pay-as-you-go credits at $0.01 each (USD list price), so one launch costs a tenth of a cent. Users without enough credits first get a warning. During preview they are then blocked after 20 app operations or five minutes of use, whichever comes first.

Power Apps Premium is not quite "free" either. Premium users don't consume credits when they run apps, but their API calls count toward the daily Power Platform request limits of their license, and usage above those limits is billed in credits. The Power Apps use rights that come with Microsoft 365 or Dynamics 365 licenses do not cover these apps at all.

Building and running are billed separately. Building in Cowork is charged through the maker's Cowork spending policy in the Microsoft 365 admin center. Building in Copilot Studio is charged through Copilot Studio billing per environment in the Power Platform admin center, and billing starts during creation, not at publication. Running an app is billed per user and managed in the Microsoft 365 admin center. So the cost of one app can show up in two admin centers.

**Availability.** All eligible commercial tenants get the runtime automatically, and no admin action is needed. But each creation path has its own default. According to the [admin overview](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/apps/?view=o365-worldwide), Copilot Studio app creation is on by default, CLI app creation is off by default and has to be enabled per environment or environment group, and Cowork app building depends on the tenant being onboarded to the Frontier program.

**Repositories.** The repository type is chosen when an app is created and cannot be changed later. If you bring your own repository, it must be owned by an organization on GitHub Enterprise Cloud, on github.com or a ghe.com data residency host. Personal accounts, GitHub Enterprise Server, and other providers such as Azure DevOps are not supported. Repository visibility is not set in the runtime. You manage it with GitHub Enterprise Cloud repository policies.

On the same day, Microsoft [launched the new Copilot](https://blogs.microsoft.com/blog/2026/09/25/introducing-the-new-copilot-with-home-code-and-autopilot/) with Home, Code, and Autopilot. It split pricing into a user subscription for everyday AI and usage-based billing for Cowork, Code, Autopilot, and frontier models. Microsoft said cost management in Agent 365 would expand to cover Code and Copilot Managed Runtime, with Copilot Studio agents planned for October. A week earlier, on 17 September, the [Power Platform September update](https://www.microsoft.com/en-us/power-platform/blog/power-apps/whats-new-in-power-platform-september-2026-feature-update/) made the model app-builder skill and the canvas authoring agent plugin (with MCP support) generally available.

{: .warning }
Everything above about the runtime is preview. Microsoft Learn marks it as prerelease documentation subject to change, and the Copilot Credits Guide lists it as a paid public preview, so usage is billed even though the product is not generally available. The Cowork build path also requires the Frontier program. Do not bet production workloads on today's details.

When I started this article, two of my biggest questions were the credit cost of a launch and how existing Power Platform DLP applies. Microsoft has since documented both. What it still has not documented is an export path to another platform, what happens to an app when its owner leaves, and which events reach Microsoft Purview. I come back to those below.

## Why it matters: governing the runtime instead of the builder

For about a decade, citizen-development governance has worked on the build side. We controlled who got a maker license, which environments existed, which connectors a maker could combine, and which templates people started from. That model assumed building was the hard part, done in a small number of tools we owned.

That assumption is gone. A business user can now produce an app in Cowork, in Copilot Studio, in Lovable, or with a coding agent in Visual Studio Code. You cannot put a gate in front of every one of those tools. Trying to do so creates the shadow IT you wanted to prevent.

The runtime is the one place all of those paths converge. Identity, connectors, sharing, and inventory are enforced there, regardless of who wrote the code. Microsoft frames it as "central governance should not require centralized creation." I agree with that sentence. It is overdue.

I'd push back on the next step in Microsoft's argument, though. The blog says enterprise readiness "becomes the default path." A default is not readiness. A default policy decides which connectors an app may call. It does not decide who supports the app at 8 a.m. on a Monday, whether the data model will survive a second department, or what happens when the owner leaves. The runtime removes the platform work. It does not remove the operating model work, and that is the part most customers underinvest in.

What gets better: one inventory across build tools, Entra sign-in everywhere, real Git history instead of opaque app packages, and a policy layer that applies to code you did not write. What gets harder: a new kind of app now lives in your Power Platform environment groups but is governed from the Microsoft 365 admin center, with its own licensing logic. Two admin centers share one set of rules. That overlap is the architect's problem, not Microsoft's.

## Architecture implications: where an app should live

The first question in every workshop will be: should this app run in Copilot Managed Runtime, in Power Apps, or in Azure? There are clear criteria.

| Criterion | Managed Runtime | Power Apps | Azure |
|---|---|---|---|
| Audience size | Team to department | Department to enterprise | Enterprise or external |
| Data sources | Connectors, Graph, SharePoint | Dataverse plus connectors | Anything, you build it |
| Dataverse | Through the Dataverse connector | Native | Via API |
| Licensing you own | Premium or credits | Premium already paid | Azure consumption |
| ALM maturity | Git, own repos on GitHub Enterprise Cloud only | Solutions, pipelines | Full DevOps |
| Expected lifetime | Weeks to months | Years | Years |
| Pro-dev ownership | Optional | Optional | Required |

I read the table like this. Managed Runtime is the right default for small, AI-built, connector-backed tools with a limited audience and an uncertain future. Power Apps stays the home for apps that need a real Dataverse data model, security roles, business process flows, and the solution-based ALM that many enterprises have spent years building. Azure remains the answer when you need custom infrastructure, external users, or an engineering team that owns the service end to end.

**Connectors.** The 1,500+ connectors are the headline, but the defaults are much tighter. The [default governance settings](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/apps/governance?view=o365-worldwide) allow 18 Microsoft first-party connectors that authenticate only through Entra ID, plus 12 Microsoft MCP servers. Third-party, custom, and preview connectors are excluded. Even on allowed connectors, actions that open the door wide, such as "Send an HTTP request", Office Scripts, or freeform DAX queries in Power BI, are blocked by default. That is a sensible starting point. The risk now sits in two places: when you widen the list, and in tenants that already have environment groups and data policies (more on that below). If you switch the connector policy to full control, Microsoft stops adding new connectors automatically, and the list is yours to maintain from then on.

**Git and versioning.** The Git inner loop is a real improvement over what most citizen-built apps ever had. Builds and deploys come from real commits, and bring-your-own GitHub means branch policies and pull-request reviews still apply. But the repository choice is permanent per app, your own repositories must sit in a GitHub Enterprise Cloud organization, and Azure DevOps is not supported. Decide the repository pattern before people start creating apps, not after. There is also a setting that allows developers to deploy artifacts built outside Microsoft's build system. It is off by default. Keep it off unless you have a build pipeline you trust, because the supply-chain checks then become your job.

**When an app outgrows the runtime.** This is the question I would ask Microsoft first. The blog describes a developer pulling code down and continuing to build without standing up a separate runtime. That covers growth in code. It does not cover growth in audience, data volume, or criticality. I have seen too many "temporary" tools become business-critical to accept "we'll move it later" as a plan. Because the code is a TypeScript or JavaScript single-page app in Git, moving to Azure is at least technically plausible. Moving to Power Apps is not documented. A Power Apps code app looks like the closest target, but until Microsoft describes a path, I would plan for a rebuild. Treat that as a design input, not a surprise.

{: .note }
Power Platform is also moving toward code. Microsoft Learn already has guidance on converting a vibe app to a Power Apps code app, and the model app-builder skill now builds Dataverse artifacts from natural language. The overlap between the two platforms will grow before it shrinks.

## Governance implications: the default policy is the real control

Because the runtime is on automatically, and Copilot Studio app creation is on by default, the default governance policy is not a setting you will get to eventually. It is the control that already applies to every app built today. The defaults live in a default environment group, which you find in the Microsoft 365 admin center under **Apps > Settings > Environment groups**. It has four rules: routing, connectors and MCP servers, sharing, and content security policy. Review them this week.

{: .warning }
Some routing decisions cannot be undone. The service initializes Copilot Managed Runtime governance when the first app is created, or earlier when an administrator opens the app governance experience. After that, an existing "Everyone" catch-all routing rule can no longer be deleted or changed, and the routing rule created for the runtime is permanent. Makers who match no routing rule cannot create apps at all. Plan your routing in the Power Platform admin center first. If someone in Copilot Studio has already built an app, governance is already initialized in your tenant.

**Connector policy overlap.** At launch I could not find how existing Power Platform DLP applies to these apps. That is now documented. For an existing environment group, it depends on two things: whether the group has an advanced connector policy (ACP), and whether the "Advanced connector policies only" switch is on.

| Existing ACP | ACP only | What applies |
|---|---|---|
| No | Off | Classic data policies. If none applies, connectors are not restricted. |
| No | On | Nothing. Data policies are ignored and connectors are not restricted. |
| Yes | Off | Both. The most restrictive result wins. |
| Yes | On | Only the ACP. Data policies stay configured but are ignored. |

Two of those four cases leave connectors unrestricted. There is also a display trap. For an existing group without an ACP, the Microsoft 365 admin center may report that no connectors are allowed, even when far more is possible. In mixed mode, it shows the ACP allow list but may not show restrictions from data policies. Check the effective policy in the Power Platform admin center before you tell your security team the answer.

**Ownership and orphaned apps.** The inventory is better than I expected. It shows the current owner (which can differ from the original creator), status, hosting region, and environment group, and Global Administrators and Power Platform Administrators can block or delete an app from there. The apps also appear in the Power Platform admin center inventory. What I still cannot find is an action to reassign ownership, or documented behavior when the owner's account is removed. Copilot Studio has an ownership reassignment API for orphaned agents; I found nothing equivalent for runtime apps. Until Microsoft documents it, assume you need your own process.

Two smaller details belong in that process. Sharing an app does not grant access to its data; recipients still need their own permissions. And the reverse is also true: revoking someone's access to an app does not remove their permissions on the underlying data. No single action does both.

**Audit.** The blog lists auditing among the organizational policies. The runtime documentation I read does not yet say which events reach Microsoft Purview, or at what level of detail. Verify before you rely on it for compliance.

**Cost as a governance signal.** I like the credit model more than most people will. Every launch and every connector call is a metered API call at 0.1 credits, so usage shows up as spend, and spend is something finance will actually look at. A chatty app that calls APIs in a loop becomes visible. The block after 20 operations or five minutes is a hard, early signal that a user is not licensed.

I'd push back on a common assumption here: that users with Power Apps Premium make the cost question go away. For them, normal use does not consume credits. That is good for the budget, but it also removes the signal, at least until they hit their daily request limits. For those users, use the usage analytics and the Monitor tab in the admin center instead, which show open success rate, session counts, and latency, and let you set alert rules.

{: .caution }
One app, two places for cost. For apps built in Copilot Studio, build costs are managed per environment in the Power Platform admin center, while runtime costs are managed per user in the Microsoft 365 admin center. Microsoft also said Copilot Studio agents would come to Agent 365 cost management in October. Check that this has actually reached your tenant, and connect both views, before you publish a FinOps baseline.

The open questions I would put to Microsoft are now shorter. How do apps move to another platform when they outgrow the runtime? What happens to an app, its repository, and its connections when the owner is deprovisioned? Which runtime events reach Purview? When does preview end, and does the 20-operation grace period survive general availability?

## Practical recommendations: the next 30 to 90 days

This is what I am recommending to customers right now, in rough order.

1. **Decide routing before governance initializes.** Look at environment routing in the Power Platform admin center now. Decide between an Everyone catch-all and security-group scoped rules, knowing that parts of this become permanent.
2. **Review the default environment group and limit who can create.** Copilot Studio app creation is on by default, and you can restrict it to specific Entra security groups. Leave CLI creation off until you have a defined developer audience. Keep external artifact deployment off.
3. **Check the effective connector policy for existing environment groups.** Look at the "Advanced connector policies only" switch and the data policies in the Power Platform admin center. Do not trust the Microsoft 365 admin center view alone.
4. **Decide who owns the admin inventory.** Apps > All apps is a new surface, but the Power Platform Administrator role already has full rights there. Give it to the team that owns the Power Platform inventory, with a weekly review and health alerts set up in Monitor.
5. **Define a graduation path.** Write down when an app must move to Power Apps or Azure: audience size, data sensitivity, need for a real Dataverse model, or business criticality.
6. **Set the repository standard.** Platform-managed Git or bring-your-own GitHub, decided centrally, because the choice cannot be changed per app later. If you bring your own, use a GitHub Enterprise Cloud organization and enforce repository visibility there.
7. **Set up runtime billing deliberately.** Users without Premium cannot run apps beyond the grace period until you turn on usage-based billing and create a spending policy for managed applications. Set per-user limits, decide whether "Auto-apply new services" (on by default) should stay on, and route credit requests into your existing approval workflow.
8. **Check which users already hold Power Apps Premium.** They run apps without consuming credits up to their request limits. The Power Apps rights included in Microsoft 365 do not count. That changes both your cost forecast and your pilot audience.
9. **Pilot with one department.** Pick one with a real backlog of small tools and a manager willing to own the outcome. Measure launches, API calls, and support requests for eight weeks.
10. **Align with the Power Platform CoE.** These apps live in Power Platform environment groups, so this is not a separate estate. Same connectors, same DLP intent, same orphaned-app process. Two governance teams with two rulebooks is the failure mode I would most like to avoid.

## Conclusion: design the landing zone before the traffic arrives

I think Microsoft made the right architectural choice. You cannot govern every build tool when every employee, and soon every agent, can write code. Governing the place code runs is the only boundary that scales. Copilot Managed Runtime gives us that boundary inside Microsoft 365, with Entra, connectors, Git, and an inventory in one place.

But a boundary is not a design. The defaults are sensible but generic, the preview will change, costs are split across two admin centers, and the runtime is built on the same environments and routing rules as your Power Platform estate. Treat it as a landing zone: routing, policies, ownership, graduation rules, and cost controls, agreed before the first app gets popular.

The consequence I would plan for is not the business user with a tracker. It is Autopilot and similar agents building small tools for themselves, on the same runtime, under the same policies. When the builder is an agent with its own identity, the runtime is the only place left to govern. Better to get it right while the builders are still human.

## Sources

* Microsoft Copilot Blog, [Build where you want, run with confidence: Now Microsoft hosts and manages the code created by Copilot](https://www.microsoft.com/en-us/copilot/blog/copilot-studio/build-where-you-want-run-with-confidence-now-microsoft-hosts-and-manages-the-code-created-by-copilot/), 25 September 2026: public preview, "governed by IT" wording, build experiences covered, Lovable example, admin center inventory, "central governance should not require centralized creation", auditing listed as a policy area
* Microsoft Learn, [What is Microsoft Copilot Managed Runtime (preview)](https://learn.microsoft.com/en-us/microsoft-365/managed-apps/?view=o365-worldwide), last updated 15 October 2026: four build paths, Frontier requirement for Cowork, inherited default governance policy, managedapps.cloud.microsoft portal, Apps > All apps
* Microsoft Learn, [Microsoft Copilot Managed Runtime SDK overview (preview)](https://learn.microsoft.com/en-us/microsoft-365/managed-apps/developer/?view=o365-worldwide), last updated 30 September 2026: SDK and CLI, 1,500+ connectors, GitHub Copilot plugin, repository options and limits, policy adherence, licensing, warning and block limits, automatic availability
* Microsoft Learn, [Copilot Managed Runtime overview and key concepts for admins (preview)](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/apps/?view=o365-worldwide), last updated 13 October 2026: defaults per creation path, admin roles, security group scoping for Copilot Studio, external artifacts setting, build and runtime billing
* Microsoft Learn, [Copilot Managed Runtime default governance settings (preview)](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/apps/governance?view=o365-worldwide), last updated 29 September 2026: default environment group, 18 connectors and 12 MCP servers, blocked actions, content security policy, permanent routing rule, connector policy evaluation for existing environment groups
* Microsoft Learn, [FAQ about Microsoft Copilot Managed Runtime (preview)](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/apps/faq-about-apps?view=o365-worldwide), last updated 25 September 2026: personal developer environments, governance initialization, Everyone catch-all rule, sharing and data access, mixed-mode connector display
* Microsoft Learn, [Copilot Managed Runtime licensing FAQ (preview)](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/apps/licensing-faq?view=o365-worldwide), last updated 7 October 2026: what counts as an API call, 0.1 credits per call, Premium request limits, Microsoft 365 and Dynamics 365 Power Apps rights not covered, spending policy setup
* Microsoft Learn, [View and oversee apps in Copilot Managed Runtime across your tenant (preview)](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/apps/inventory?view=o365-worldwide), last updated 25 September 2026: inventory columns, block and delete, Monitor tab and alerts, roles
* Microsoft, [Copilot Credits Guide](https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/bade/documents/products-and-services/en-us/ai/Copilot-Credits-Guide.pdf), October 2026: Copilot Managed Runtime as paid public preview, API call metering, pay-as-you-go price per credit in USD, Power Apps Premium request limits
* Official Microsoft Blog, [Introducing the new Copilot with Home, Code and Autopilot](https://blogs.microsoft.com/blog/2026/09/25/introducing-the-new-copilot-with-home-code-and-autopilot/), 25 September 2026: new Copilot, split pricing (user subscription and usage-based billing), Agent 365 cost management scope and October plan for Copilot Studio agents, Autopilot
* Microsoft Tech Community, [New FinOps for AI capabilities: Control spend, measure value, and optimize for impact](https://techcommunity.microsoft.com/blog/ai-finops-blog/new-finops-for-ai-capabilities-control-spend-measure-value-and-optimize-for-impa/4559660), September 2026: FinOps for AI context
* Microsoft Power Platform Blog, [What's new in Power Platform: September 2026 feature update](https://www.microsoft.com/en-us/power-platform/blog/power-apps/whats-new-in-power-platform-september-2026-feature-update/), 17 September 2026: model app-builder skill and canvas authoring agent plugin with MCP support generally available

