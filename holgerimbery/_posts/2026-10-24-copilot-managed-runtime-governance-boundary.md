---
layout: post
canonical_url: https://holgerimbery.blog/copilot-managed-runtime-governance-boundary
title: Copilot Managed Runtime - The Runtime Becomes the Governance Boundary
description: "Microsoft now hosts the code that Copilot and other AI tools build. For architects, that moves governance from the build tool to the runtime. Here is what that changes, what it does not solve, and what to design before the first AI-built app goes viral."
date: 26-10-24
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
> Microsoft now runs the code that Copilot, Copilot Studio, and third-party AI tools produce, inside your Microsoft 365 tenant. I think that is the right answer to a problem we can no longer solve at the build side. But a runtime is only as good as the policies behind it, and this one lands next to a Power Platform estate that already has its own licensing, DLP, and ALM. This article explains what was announced, where I would place it, and what I would set up in the next 90 days.

## Introduction - the tracker that 200 people now depend on

Every enterprise I work with has a version of this story. Someone in operations gets tired of a shared Excel file. They build a small tracker in an afternoon. It works. They share the link in a Teams channel. Three weeks later, 200 colleagues depend on it, it talks to a SharePoint list and a line-of-business system, and nobody in IT knows it exists. The owner is going on parental leave next month.

Five years ago that tracker was a canvas app, and the Power Platform CoE had at least a fighting chance to find it. Today the same person can describe the tracker in a chat and get working code back. Soon an agent may build it unasked.

That is the context for Microsoft Copilot Managed Runtime. My thesis is simple. Copilot Managed Runtime shifts enterprise governance from the tools people build with to the place their code runs. That is the right move, because we can no longer control who builds apps with AI. But the runtime is only as good as the policies behind it, and it arrives next to an existing Power Platform estate. Architects should treat it as a landing zone to design deliberately, before the first AI-built app goes viral.

## What Microsoft announced - and what it did not

On 25 September 2026, Microsoft put Copilot Managed Runtime into public preview. The [Copilot blog announcement](https://www.microsoft.com/en-us/copilot/blog/copilot-studio/build-where-you-want-run-with-confidence-now-microsoft-hosts-and-manages-the-code-created-by-copilot/) describes it as a platform "to run code within the Microsoft 365 tenant boundary that's governed by IT." According to the same post, it already powers the apps built in Copilot Cowork, Copilot Code, and Copilot Studio. Microsoft is also opening it to third-party tools and professional developers. Lovable is the named third-party example.

For developers, the way in is an SDK (`@microsoft/managed-apps`) and a CLI invoked as `ms`. The [SDK overview on Microsoft Learn](https://learn.microsoft.com/en-us/microsoft-365/managed-apps/developer/?view=o365-worldwide) lists the documented capabilities:

* Microsoft Entra authentication and authorization out of the box
* More than 1,500 connectors, callable from JavaScript and TypeScript
* A native Git inner loop, with either a platform-managed repository or your own GitHub repository — public GitHub repositories are disallowed by default
* Adherence to sharing limits, Conditional Access, Advanced Connector Policies, and Data Loss Prevention
* A central inventory in the Microsoft 365 admin center (**Apps > All apps**), with usage analytics and health metrics

Users open their apps at `managedapps.cloud.microsoft`. The [overview page](https://learn.microsoft.com/en-us/microsoft-365/managed-apps/?view=o365-worldwide) states that all three build paths — Cowork, Copilot Studio, and the SDK — produce an app that inherits the tenant's default governance policy: approved connectors, sharing rules, and content security policy.

Licensing is where it gets concrete. Users need either a Power Apps Premium plan or Managed Application Copilot Credits. With credits, each app launch is charged and each API call consumes 0.1 credits. Users without enough credits first get a warning. They are then blocked after 20 app operations or five minutes of use, whichever comes first.

Two details on the SDK page matter more than the headline. First, all eligible commercial tenants get the runtime automatically, with no admin action required. Second, the repository type is chosen when an app is created and cannot be changed later. Only GitHub.com and GitHub Enterprise Cloud are supported; Azure DevOps is not.

On the same day, Microsoft [launched the new Copilot](https://blogs.microsoft.com/blog/2026/09/25/introducing-the-new-copilot-with-home-code-and-autopilot/) with Home, Code, and Autopilot. It split pricing into a user subscription for everyday AI and usage-based billing for Cowork, Code, Autopilot, and frontier models. Agent 365 cost management now covers Code and Copilot Managed Runtime, with Copilot Studio agents planned for October. A week earlier, on 17 September, the [Power Platform September update](https://www.microsoft.com/en-us/power-platform/blog/power-apps/whats-new-in-power-platform-september-2026-feature-update/) made the model app-builder skill and the canvas authoring agent plugin (with MCP support) generally available.

{: .warning }
Everything above about the runtime is preview. Microsoft Learn marks it as prerelease documentation subject to change. The Cowork build path also requires enrollment in the Frontier program. Do not bet production workloads on today's details.

What Microsoft has not said is just as important. I found no published price per credit for a launch, no documented export path out of the runtime, and no documented behavior for apps whose owner leaves the company. I come back to those below.

## Why it matters - governing the runtime instead of the builder

For about a decade, citizen-development governance has worked on the build side. We controlled who got a maker license, which environments existed, which connectors a maker could combine, and which templates people started from. That model assumed building was the hard part, done in a small number of tools we owned.

That assumption is gone. A business user can now produce an app in Cowork, in Copilot Studio, in Lovable, or with a coding agent in Visual Studio Code. You cannot put a gate in front of every one of those tools. Trying to do so creates the shadow IT you wanted to prevent.

The runtime is the one place all of those paths converge. Identity, connectors, sharing, and inventory are enforced there, regardless of who wrote the code. Microsoft frames it as "central governance should not require centralized creation." I agree with that sentence. It is overdue.

I'd push back on the next step in Microsoft's argument, though. The blog says enterprise readiness "becomes the default path." A default is not readiness. A default policy decides which connectors an app may call. It does not decide who supports the app at 8 a.m. on a Monday, whether the data model will survive a second department, or what happens when the owner leaves. The runtime removes the platform work. It does not remove the operating model work, and that is the part most customers underinvest in.

What gets better: one inventory across build tools, Entra sign-in everywhere, real Git history instead of opaque app packages, and a policy layer that applies to code you did not write. What gets harder: you now have a second app platform in the tenant, with its own licensing logic and its own admin surface, next to Power Platform. That overlap is the architect's problem, not Microsoft's.

## Architecture implications - where an app should live

The first question in every workshop will be: should this app run in Copilot Managed Runtime, in Power Apps, or in Azure? There are clear criteria.

| Criterion | Managed Runtime | Power Apps | Azure |
|---|---|---|---|
| Audience size | Team to department | Department to enterprise | Enterprise or external |
| Data sources | Connectors, Graph, SharePoint | Dataverse plus connectors | Anything, you build it |
| Licensing you own | Premium or credits | Premium already paid | Azure consumption |
| ALM maturity | Git, GitHub only | Solutions, pipelines | Full DevOps |
| Needs Dataverse | Not documented | Native | Via API |
| Expected lifetime | Weeks to months | Years | Years |
| Pro-dev ownership | Optional | Optional | Required |

I read the table like this. Managed Runtime is the right default for small, AI-built, connector-backed tools with a limited audience and an uncertain future. Power Apps stays the home for apps that need Dataverse, security roles, business process flows, and the solution-based ALM that many enterprises have spent years building. Azure remains the answer when you need custom infrastructure, external users, or an engineering team that owns the service end to end.

**Connectors.** The 1,500+ connectors are the strongest reason to use the runtime. They are also the biggest risk. A generated app can reach a lot of enterprise data with very little code. The default connector policy is therefore your most important architecture decision.

**Git and versioning.** The Git inner loop is a real improvement over what most citizen-built apps ever had. Builds and deploys come from real commits, and bring-your-own GitHub means branch policies and pull-request reviews still apply. But the repository choice is permanent per app. If your organization standardizes on Azure DevOps, that is not supported today. Decide the repository pattern before people start creating apps, not after.

**When an app outgrows the runtime.** This is the question I would ask Microsoft first. The blog describes a developer pulling code down and continuing to build without standing up a separate runtime. That covers growth in code. It does not cover growth in audience, data volume, or criticality. I have seen too many "temporary" tools become business-critical to accept "we'll move it later" as a plan. Because the code is editable and Git-backed, moving to Azure is at least technically plausible. Moving to Power Apps is a rebuild. Treat that as a design input, not a surprise.

{: .note }
Power Platform is also moving toward code. Microsoft Learn already has guidance on converting a vibe app to a Power Apps code app, and the model app-builder skill now builds Dataverse artifacts from natural language. The overlap between the two platforms will grow before it shrinks.

## Governance implications - the default policy is the real control

Because the runtime is on automatically for eligible commercial tenants, the default governance policy is not a setting you will get to eventually. It is the control that already applies to every app built today. Administrators can review those defaults in the Apps experience in the Microsoft 365 admin center. Do that this week.

**Ownership and orphaned apps.** The inventory shows what exists. It does not, from what I have read, define what happens when an owner leaves. Power Platform CoE teams have built years of process around orphaned apps. I expect the same problem here, faster, because building is cheaper. Until Microsoft documents deprovisioning behavior, assume you need your own process.

**Connector policy overlap.** The SDK page says apps adhere to Advanced Connector Policies and DLP. What I cannot find documented is exactly how an existing Power Platform DLP policy scoped to environments maps to a Managed Runtime app. Is there an environment behind the app? Which policy wins when two apply? Test this in your tenant before you tell your security team the answer.

**Audit.** The blog lists auditing among the organizational policies. The documentation I read does not yet say which events reach Microsoft Purview, or at what level of detail. Verify before you rely on it for compliance.

**Cost as a governance signal.** I like the credit model more than most people will. Charging per launch and 0.1 credits per API call means usage shows up as spend, and spend is something finance will actually look at. A chatty app that calls APIs in a loop becomes visible. The block after 20 operations or five minutes is a hard, early signal that a user is not licensed.

I'd push back on a common assumption here: that users with Power Apps Premium make the cost question go away. Premium covers all app operations without consuming credits. That is good for the budget, but it also removes the signal. For those users, you lose the cheapest usage telemetry you would otherwise get. Use the admin center usage analytics instead.

{: .caution }
Agent 365 cost management covers Code and Copilot Managed Runtime now, but Copilot Studio agents only from October. If your apps call Copilot Studio agents, part of the cost picture will be missing for a few weeks. Do not publish a FinOps baseline until both sides are visible.

The open questions I would put to Microsoft are short. What does one launch cost in credits? How do apps get exported or retired? What happens to an app, its repository, and its connections when the owner is deprovisioned? How do Power Platform DLP scopes map to the runtime? When does preview end, and what changes at general availability?

## Practical recommendations - the next 30 to 90 days

This is what I am recommending to customers right now, in rough order.

1. **Review the default governance policy before Frontier users arrive.** Cowork app building requires the Frontier program, and Code is rolling out there first. Your early adopters will build on whatever the defaults are. Tighten approved connectors and sharing rules now.
2. **Decide who owns the admin inventory.** Apps > All apps in the Microsoft 365 admin center is a new surface. Name an owner — ideally the same team that owns the Power Platform inventory — and give them a weekly review rhythm.
3. **Define a graduation path.** Write down when an app must move to Power Apps or Azure: audience size, data sensitivity, need for Dataverse, or business criticality.
4. **Set the repository standard.** Platform-managed Git or bring-your-own GitHub, decided centrally, because the choice cannot be changed per app later. Keep public repositories blocked.
5. **Set credit policies deliberately.** Use Agent 365 spending policies and route credit requests into your existing approval workflow. Decide who gets credits by default and who has to ask.
6. **Check which users already hold Power Apps Premium.** They run apps without consuming credits. That changes both your cost forecast and your pilot audience.
7. **Pilot with one department.** Pick one with a real backlog of small tools and a manager willing to own the outcome. Measure launches, API calls, and support requests for eight weeks.
8. **Align with the Power Platform CoE.** Same connectors, same DLP intent, same orphaned-app process. Two governance teams with two rulebooks is the failure mode I would most like to avoid.

## Conclusion - design the landing zone before the traffic arrives

I think Microsoft made the right architectural choice. You cannot govern every build tool when every employee, and soon every agent, can write code. Governing the place code runs is the only boundary that scales. Copilot Managed Runtime gives us that boundary inside Microsoft 365, with Entra, connectors, Git, and an inventory in one place.

But a boundary is not a design. The defaults are generic, the preview will change, pricing is not fully clear, and the overlap with Power Platform is real. Treat the runtime as a landing zone: policies, ownership, graduation rules, and cost controls, agreed before the first app gets popular.

The consequence I would plan for is not the business user with a tracker. It is Autopilot and similar agents building small tools for themselves, on the same runtime, under the same policies. When the builder is an agent with its own identity, the runtime is the only place left to govern. Better to get it right while the builders are still human.

## Sources

* Microsoft Copilot Blog, [Build where you want, run with confidence: Now Microsoft hosts and manages the code created by Copilot](https://www.microsoft.com/en-us/copilot/blog/copilot-studio/build-where-you-want-run-with-confidence-now-microsoft-hosts-and-manages-the-code-created-by-copilot/), 25 September 2026: public preview, "governed by IT" wording, build experiences covered, Lovable example, admin center inventory, "central governance should not require centralized creation", auditing listed as a policy area
* Microsoft Learn, [What is Microsoft Copilot Managed Runtime (preview)](https://learn.microsoft.com/en-us/microsoft-365/managed-apps/?view=o365-worldwide), last updated 25 September 2026: three build paths, Frontier requirement for Cowork, inherited default governance policy, managedapps.cloud.microsoft portal, Apps > All apps
* Microsoft Learn, [Microsoft Copilot Managed Runtime SDK overview (preview)](https://learn.microsoft.com/en-us/microsoft-365/managed-apps/developer/?view=o365-worldwide), last updated 28 September 2026: SDK and CLI, 1,500+ connectors, Git options and limits, policy adherence, licensing, 0.1 credits per API call, warning and block limits, automatic availability
* Official Microsoft Blog, [Introducing the new Copilot with Home, Code and Autopilot](https://blogs.microsoft.com/blog/2026/09/25/introducing-the-new-copilot-with-home-code-and-autopilot/), 25 September 2026: new Copilot, split pricing (user subscription and usage-based billing), Agent 365 cost management scope and October plan for Copilot Studio agents, Autopilot
* Microsoft Tech Community, [New FinOps for AI capabilities: Control spend, measure value, and optimize for impact](https://techcommunity.microsoft.com/blog/ai-finops-blog/new-finops-for-ai-capabilities-control-spend-measure-value-and-optimize-for-impa/4559660), September 2026: FinOps for AI context [TODO: verify details — page content could not be loaded when drafting]
* Microsoft Power Platform Blog, [What's new in Power Platform: September 2026 feature update](https://www.microsoft.com/en-us/power-platform/blog/power-apps/whats-new-in-power-platform-september-2026-feature-update/), 17 September 2026: model app-builder skill and canvas authoring agent plugin with MCP support generally available

**Open questions as of publication:** Microsoft has not yet documented the credit cost per app launch, the export or retirement path for apps, owner deprovisioning behavior, or how environment-scoped Power Platform DLP maps to Managed Runtime apps. Verify each in your own tenant before relying on it.
