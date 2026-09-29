---
layout: post
canonical_url: https://holgerimbery.blog/agent-finops-microsoft-ecosystem
title: Agent FinOps in the Microsoft Ecosystem - Where the Costs Show Up and How to Control Them
description: Part two of the series on Copilot and agent costs. Where Copilot, Cowork, Copilot Studio, and Foundry agents show their costs, which controls actually stop spending, how to charge costs back, and what Microsoft has announced for October 2026.
date: 26-10-10
author: admin
slug: agent-finops-microsoft-ecosystem
image: /images/2026/10/sasun-bughdaryan-Z6fNpLI_-mc-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@sasun1990?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Sasun Bughdaryan</a> on <a href="https://unsplash.com/photos/hands-protectively-holding-an-orange-piggy-bank-Z6fNpLI_-mc?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
tags:
  - agent365
  - agentfinops
  - chargeback
  - copilotcowork
  - copilotcredits
  - copilotstudio
  - costmanagement
  - finops
  - microsoft365copilot
  - microsoftfoundry
  - powerplatform
featured: true
toc: true
---

{: .q-left }
> This is the second post in the series on Copilot and agent costs. [Part one](https://holgerimbery.blog/copilot-pricing-licenses-and-credits) was the price list: the Copilot license for everyday AI, and Copilot Credits for agentic work. This post is about what happens after you buy. Agent costs show up in four places - Copilot, Cowork, Copilot Studio, and Foundry - spread over three consoles, and each one has different controls. For each, I cover where you see the cost, what actually stops spending, and how to bring it down. Everything comes from Microsoft's own pages, checked at the end of September 2026.

## What FinOps means when you run agents

FinOps comes down to three habits: make spending visible, give it an owner, then reduce it.

That works well for cloud costs, because they have a clear unit: an hour of a virtual machine, a gigabyte, a request. Agents don't. One user question can start a plan, several model calls, a search through company data, a few tool calls, some retries, and sometimes other agents. It all happens in seconds, usually before any dashboard updates.

So you keep the three habits and count something else. A useful number is the cost of one agent session. A better one, if you can get it, is the cost of one result: one ticket solved, one document checked, one invoice cleared. Finance can work with that.

Three things make agents harder than normal cloud costs.

* **Costs can start before you go live.** On one Copilot Studio harness, building, previewing, and testing an agent already use credits.
* **Without a person in the loop, nothing slows an agent down.** Costs then follow how often the agent is triggered, not how many people use it.
* **The numbers are spread out.** Copilot and Cowork report in the Microsoft 365 admin center, Copilot Studio in the Power Platform admin center, and Foundry in Azure. Nothing shows all of them together.

## Four meters, three consoles

| Where agents run | What you pay for | Where you see the cost | Can you set a hard stop? |
|---|---|---|---|
| Microsoft 365 Copilot | A license per user; agents are billed per use for people without one | Microsoft 365 admin center | Yes, a monthly limit per user |
| Copilot Cowork | Copilot Credits per task, always | Microsoft 365 admin center | Yes, a monthly limit per user |
| Copilot Studio | Copilot Credits per agent action | Power Platform admin center | Yes, a monthly limit per agent |
| Foundry agents | Model tokens, tools, storage, compute | Azure Cost Management | No, budgets only warn |

Credit use in the first three comes out of one pool per tenant. Foundry is billed through Azure and is completely separate.

## Copilot and Cowork: the Microsoft 365 admin center

### Where it is and what it covers

The cost screen for Copilot Credits is in the Microsoft 365 admin center under **Copilot > Cost management**. Microsoft's [usage-based billing overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-overview-copilot-credits) (updated 25 September 2026) calls it "a centralized place to govern and monitor AI experiences". You can see usage by spending policy, user, group, agent, service, and funding source.

It covers fewer services than you might expect. The overview lists Cowork, apps built with Cowork, and the Work IQ API (for third-party agents). The [admin page on managing usage-based billing](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-manage-copilot-credits) (updated 10 September 2026) says the same: "This feature is currently available for Cowork and Work IQ API." Copilot Studio isn't in there yet. More on that in the section on October.

Before any of this can run, someone has to switch it on. The Configuration tab is where you turn on usage-based billing, pick how you pay (pay-as-you-go, pre-purchase, or capacity packs), and link an Azure subscription. The [USL and UBB page](https://learn.microsoft.com/en-us/microsoft-365/copilot/user-subscription-license-usage-based-billing) is clear: "Admins must set up a billing policy before a user can use" these experiences.

### How spending policies work

Spending policies are the main control. The rules are simple once you've read them, but a few of them surprise people.

* Policies can apply to the tenant, to groups, or to users. Individual users can only be added through security groups.
* The default policy sets the tenant limit. Every other policy has its own limit and "doesn't inherit the tenant-level limit."
* If a user is in several policies, only one applies: the one with the highest per-user limit, then the largest policy limit, then the newest. "The chosen policy applies in full and settings from other policies aren't combined."
* When a user reaches the limit, "they lose access to agents and services for the rest of the month". Moving them to another group doesn't help: "Moving a user between groups or spending policies doesn't reset the user's consumption."
* Policies cap spending. They "don't reserve or allocate Copilot Credits".
* Credits are used in a fixed order: capacity packs first, then the pre-purchase plan, then pay-as-you-go.
* You can't change the billing method of a policy later: "After you set a billing method for a spending policy and create the policy, you can't change it." You delete it and start again.

For Cowork, a spending policy does more than cap money. The [Cowork admin page](https://learn.microsoft.com/en-us/microsoft-365/copilot/cowork/cowork-admin-governance) puts it plainly: "A spending policy is an access control, not only a budget." If someone isn't in a policy, they can't use Cowork.

{: .warning }
The setting "Auto-apply new services" is on by default. Every new service Microsoft adds to usage-based billing is then covered by your existing policies without anyone deciding it should be. Microsoft's own advice: "Turn off the setting if you want to review and add future services manually."

### Who can do what

The admin page splits the work across roles, which helps if finance and IT share the job.

| Role | What they can do |
|---|---|
| Global admin, Billing admin | Set up how you pay |
| AI admin, License admin | Create spending policies, limits, and alerts |
| AI Reader, Global Reader | Read-only access, good for finance |

### What users see

In Cowork, a user can type `/cost` to see what a task used and how many credits they have left this month. The [/cost page](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-copilot-credits-cost) (updated 13 August 2026) also says what it doesn't do: "It does not provide month-over-month trends, usage history". Microsoft says more is coming, including "new ways to view their credit consumption or request credits from their admin", but gives no date.

Users can also ask for more credits. Admins can send those requests to their own IT portal or a ServiceNow workflow instead of handling them in the admin center.

### The adoption report is not a cost report

The [Microsoft Copilot Agents usage report](https://learn.microsoft.com/en-us/microsoft-365/admin/activity-reports/microsoft-365-copilot-agents-new) (preview, updated 18 August 2026) shows active users (licensed and unlicensed), active agents, responses, and who built each agent. Data shows up "within an hour". It has no cost or credit figures, covers only the last 7 or 30 days, hides user names by default, and leaves out two things: "SharePoint agents used in Teams aren't currently included", and "Cowork usage is not included". Use it to see which agents people really use. Don't use it to charge anyone.

{: .caution }
If a user goes over their limit in the middle of a task, the extra use "isn't billed (at Microsoft's sole discretion), and doesn't appear as consumed credits in the Cost Management dashboards." So the dashboard can show less than what was actually used, right when you're trying to understand a spike.

### How to keep costs down

**Decide license or pay-per-use for each group, with real numbers.** For licensed users, employee-facing agent use in Copilot Chat, Teams, and SharePoint is largely free (see part one for the exceptions). For heavy agent users a license can be cheaper than credits. For light users it's the other way round. This is a buying decision, and it's the biggest lever you have here.

**Turn on per-user limits from day one.** Cowork work has no natural end. Someone who finds it useful will use it more next week.

**Use approvals instead of raising everyone's limit.** A request for more credits tells you which work people think is worth paying for.

**Set one policy per Entra group.** Groups give you units you can compare, and comparing is how you spot the outlier.

**Get the billing method right the first time**, and check Auto-apply before Microsoft adds the next service.

## Copilot Studio: the Power Platform admin center

Part one covers the credit rates for each agent action. Here I only repeat what you need to control them.

### When the meter starts

The [harnesses overview](https://learn.microsoft.com/en-us/microsoft-copilot-studio/harnesses-overview) (updated 22 September 2026) says: "The harness you use affects the billing, features, and capabilities of what you build."

| Harness | What it's for | When charging starts |
|---|---|---|
| Standard | Agents with topics and agent flows | When the agent is used, at the standard rates |
| Copilot Chat | Copilot Chat extended with your own knowledge | Billed per use, or included in the Copilot license |
| GitHub Copilot | Multi-step agents that reason and work with documents | With your first build action, before anyone publishes |

The GitHub Copilot harness "charges credits from the moment you start building", according to the [billing overview for that harness](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/billing-credit-overview) (updated 28 September 2026). Previewing, testing, and creating evaluations all use credits. Credits cover model tokens, tools (including knowledge and MCP servers), and the harness itself. Places people assume are free aren't either: "Developer environments and trial environments move to usage-based billing September 1, 2026."

Four more rules from the [billing rates page](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-messages-management) (updated 3 August 2026) matter for control:

* **Reasoning models cost more.** You pay the feature rate plus the premium AI tools rate of 10 credits per 1,000 tokens.
* **Agent flows are only free one way.** For licensed users, "the 'No charge' inclusion applies only to runs triggered via the 'When an agent calls the flow' trigger". A flow started by a schedule or an event is billed.
* **Computer use isn't included.** "Computer-Using Agents (CUA) usage is not included in the Microsoft 365 Copilot USL."
* **Power Automate cloud flows are separate.** They "use Power Automate licensing, not Copilot Credits" and aren't affected by Copilot Studio limits.

### Where you see the cost

In the Power Platform admin center, go to **Licensing > Products > Copilot Studio**. The [capacity page](https://learn.microsoft.com/en-us/power-platform/admin/manage-copilot-studio-copilot-credits-capacity) (updated 21 September 2026) describes:

* credits from the tenant pool that you assign to environments;
* reports you can download by environment, agent, or user, including "the count of billed versus nonbillable credits" (the non-billed part is what your licensed users get free);
* daily data for the current month and the last two full months, and monthly data for the past 12 months.

If you pay as you go, a billing plan links environments to an Azure subscription and creates a Power Platform account resource there. It's hidden in the Azure portal by default; choose "View hidden types" to find it.

One limit matters for chargeback. For the GitHub Copilot harness, Microsoft [says](https://learn.microsoft.com/en-us/power-platform/admin/manage-usage-github-copilot-harness): "Discrete costs aren't attributed to individual makers or end users." You see costs per environment and per agent, not per person.

### What stops spending

**Per-agent limits.** Each agent can have a monthly credit limit, with the status "Within limit", "Nearing limit", or "Over limit". With the hard stop on, "The agent is automatically turned off once it hits the defined limit." This is the setting to rely on when money matters. Azure budgets won't do it: they "send notifications but don't stop Copilot Studio consumption."

**The 125% rule on prepaid capacity.** "Enforcement is triggered when a tenant reaches 125% of their prepaid capacity." Custom agents are then switched off, and users see "This agent is currently unavailable. It has reached its usage limit." Agent flows behave differently: once prepaid capacity is fully used, new flow runs are blocked while the agent keeps answering. So an agent can look fine and quietly stop doing its work. An email goes to the tenant admin.

**Pay-as-you-go has no cutoff.** Extra use is billed to Azure: "With pay-as-you-go, enforcement doesn't apply". No outage, but no ceiling either. Choose which risk you'd rather have.

### How to keep costs down

**Look at how often agents ground in company data.** Grounding costs 10 credits, a classic answer 1. An agent that searches SharePoint or Exchange on every turn costs about ten times as much as a simple one. This is often the biggest number in a Copilot Studio estimate, and often the easiest to cut.

**Pick the harness on purpose.** The GitHub Copilot harness is right for real multi-step work, and it charges you to build as well as to run. Use the Standard harness where that isn't needed.

**Set a monthly limit with a hard stop on every production agent.**

**Keep environments contained.** Give each environment its own credits and clear the option "Draw from the available capacity in my tenant". This doesn't stop use through a pay-as-you-go plan linked to the same environment. With environment groups, you can enforce it for a whole group through a rule called "Cost controls - Draw from tenant credit pool"; the environment setting then becomes read-only and can't be overridden by scripts.

**Move flows to the agent trigger where you can.** Not every scheduled flow has to be scheduled.

## One credit pool, two admin centers, one Azure bill

This is easy to miss because each side describes it in different words.

Credits are pooled for the whole tenant. Credits you assign to environments in the Power Platform admin center come out of the same pool that Cowork and the Work IQ API use. The Microsoft 365 admin page says this "reduces the prepaid capacity available for Cowork and Work IQ API services". What the Microsoft 365 admin center shows as available is what you bought minus what's already been given to environments.

So two teams take from one pool, usually without talking to each other. If your Power Platform admin hands out a lot of capacity, your Microsoft 365 admin sees available credits drop for no obvious reason. Put both people in the same monthly review.

Azure adds a third view. According to the [page comparing the two views](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-compare-dashboard-views) (updated 25 September 2026):

* Cowork, Work IQ, and Copilot Studio all show up on the Azure bill "under the Microsoft Copilot Studio service rather than separate services".
* "Azure Cost Management doesn't show consumption against Prepaid Capacity packs."
* To tell services apart on the bill today, put them in separate Azure subscriptions or resource groups. Microsoft says to "use service tags as they become available", with no date.
* Admin center totals and Azure totals won't match. Microsoft: "Use the monthly billing record for reconciliation, not the usage dashboards."

## Foundry agents: Azure

### What you pay for

Foundry works the opposite way to Copilot Studio. A credit hides a whole workflow behind one number. Foundry charges every resource separately, which is harder to forecast but much easier to assign to a team.

The [Foundry Agent Service pricing page](https://azure.microsoft.com/en-us/pricing/details/foundry-agent-service/) says there is "no additional charge for creating or running Foundry-native agents using prompts and workflows". You pay for what the agent uses.

| What the agent uses | How it's charged |
|---|---|
| Models | Tokens, input and output priced separately |
| File Search (knowledge) | $0.11 per GB of vector storage per day, first GB free |
| Code Interpreter | $0.033 per session |
| Web Search and Custom Search | $14 per 1,000 requests |
| Hosted agents (Agent Framework, LangGraph) | The container compute they run on, per hour |
| Fabric, SharePoint, Bing grounding, Foundry IQ, Logic Apps connectors | Charged separately, on top of tokens |

The [cost planning page](https://learn.microsoft.com/en-us/azure/foundry/concepts/manage-costs) (updated 27 August 2026) adds three things that catch teams in the second month:

* Fine-tuning is charged three times, for training, hosting, and inference. A fine-tuned deployment costs money while it exists, even if nobody uses it.
* Failed calls aren't automatically free: "HTTP status codes alone don't determine whether usage is billed."
* There's no emergency brake. OpenAI offers hard spending limits; Azure OpenAI "doesn't currently provide this functionality."

### Where you see the cost

**Azure Cost Management is the official record.** Azure OpenAI sits inside the wider Cognitive Services group, so filter by service tier. Meters are named `model-name-GUID`. Partner and community models show up at resource group level, and some under "Global resources", so look at the whole resource group, not only the Foundry resource.

**The Foundry portal shows estimates.** There's an estimated cost per project and in the agent list. Use it for quick checks, and use Cost Management and the invoice for real numbers. The estimates leave out prompt agents, non-Foundry agents, and provisioned throughput.

**Anomaly alerts are slower than agents.** Azure compares each day with a forecast based on the last 60 days, and "Anomaly detection runs 36 hours after the end of the day (UTC)". Alert rules work only per subscription, you get five per subscription, and each alert email is sent once. For normal workloads that's fine. For an agent stuck in a loop, 36 hours is the whole incident.

### How to keep costs down

**Match the deployment type to the work.** Standard pay-per-token for development and uneven traffic. Provisioned throughput for steady production that needs predictable speed, but you can't pause it: "Billing stops only when the deployment is deleted." Provisioned quota is shared across supported models in a region and deployment type. If you buy a reservation, create the deployments first and buy after. A reservation doesn't guarantee capacity.

**Move bulk work to Batch.** Jobs that can wait up to 24 hours run at "50% less cost than global standard". It's the most overlooked discount for bulk summarizing and classifying.

**Use prompt caching, and check both sides.** Cached input is cheaper on Standard deployments and up to 100% cheaper on provisioned ones. On GPT-5.6 models and newer, writing to the cache can cost extra. The prompt needs at least 1,024 tokens with an identical start, and caches aren't shared between Azure subscriptions.

**Treat the model router mode as a cost setting.** Balanced picks cheaper models that stay within about 1–2% of the best quality. Cost mode allows about 5–6%. Quality mode ignores cost. The usable context window is limited by the smallest model behind the router.

## What changes in October

On 25 September Microsoft [announced](https://blogs.microsoft.com/blog/2026/09/25/introducing-the-new-copilot-with-home-code-and-autopilot/) that cost management will cover more services:

> Cost management in Agent 365 is expanding beyond Cowork and Work IQ APIs to include Code and Copilot Managed Runtime, with support for agents built in Microsoft Copilot Studio planned for October.
>
> <cite>– Official Microsoft Blog, 25 September 2026</cite>

If it arrives as announced, Copilot Studio costs will show up next to Cowork in the Microsoft 365 admin center. That would be the first real step toward one view of the credit pool.

A note on the name. The blog calls it "cost management in Agent 365". Agent 365 has been generally available since 1 May 2026, at $15 per user or included in E7, and it's managed in the admin center under **Agents**. But on Microsoft's documentation pages, cost management sits under **Copilot > Cost management**, and the [Agent 365 service description](https://learn.microsoft.com/en-us/office365/servicedescriptions/microsoft-agent-365/microsoft-agent-365) (updated 15 September 2026) lists no cost features. I read "Agent 365" here as the name of the direction, and the Copilot area of the admin center as the place where you actually find the settings.

The same post announced more controls. Here is where each one stands as of 29 September:

| Announced | Status |
|---|---|
| Code and Copilot Managed Runtime in cost management | Not yet on Microsoft's list of covered services; Managed Runtime is in public preview |
| Copilot Studio agents | "Planned for October"; not documented yet |
| Managing spending policies through an API | Announced; no API documentation yet |
| Sending credit requests to your own approval workflow | Already available and documented |
| Choosing model families per user group, which also limits what Auto picks | Only an on/off setting for Anthropic models per user or group is documented |
| Users see usage, remaining credits, and history in Copilot | Remaining credits yes; history not yet |
| Insights on which Cowork tasks pay off | Available in the [Insights consumption dashboard](https://learn.microsoft.com/en-us/viva/insights/org-team-insights/ai-cost-dashboard), for Cowork and the Work IQ API only |

What I couldn't find anywhere yet:

* whether "agents built in Copilot Studio" means all three harnesses or only the GitHub Copilot harness;
* whether per-agent limits, environment allocation, and the 125% rule stay in the Power Platform admin center, move over, or are replaced by spending policies;
* how user- and group-based policies will apply to autonomous agents and to people without a license, since Copilot Studio is managed per environment and agent today;
* whether Auto-apply will put Copilot Studio agents under your existing Cowork policies automatically;
* how capacity packs, the pre-purchase plans, and existing Power Platform billing plans carry over;
* whether it starts as a preview, and the roadmap or Message Center ID.

{: .important }
Before October, check whether Auto-apply is still on for your broad policies. If it is and Copilot Studio agents join, they may land under a limit that was sized for Cowork.

Microsoft's own pages also disagree in places:

* the blog says "Agent 365", the documentation says Copilot > Cost management;
* the blog says Code and Managed Runtime are covered, while the documentation page updated the same day doesn't list them;
* the [Copilot Credits Guide](https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/bade/documents/products-and-services/en-us/ai/Copilot-Credits-Guide-September-2026.pdf) (September 2026) says credit usage "is centrally managed through the Microsoft 365 admin center", while the documentation still sends Copilot Studio to the Power Platform admin center;
* the blog says users can see their usage history, while the /cost page says it shows none.

The documentation seems to lag the announcements. Check your own tenant.

## How to charge costs back

Each platform gives you a different handle.

**Copilot and Cowork: the spending policy.** One policy per Entra group is your department unit, with per-user limits inside it. These are the only places with real per-user cost data.

**Copilot Studio: the environment and the billing plan.** The Power Platform account resource created by a pay-as-you-go billing plan can be tagged like any Azure resource. That's how Copilot Studio costs get into your normal Azure cost model. Deleting the billing policy doesn't delete that resource. Since there's no per-user view, the way you lay out environments is your chargeback model.

**Foundry: the project tag.** The best handle of the four, and still in preview. "Every Foundry project is automatically tagged with a project tag on its underlying usage." You don't tag anything yourself; filter Cost Analysis by `project`. The preview covers models sold by Azure, including Azure OpenAI, but not models bought through Azure Marketplace.

And Azure itself: because Cowork, Work IQ, and Copilot Studio all appear as "Microsoft Copilot Studio" on the bill, use separate subscriptions or resource groups if you need them apart. For pre-purchase plans, use the amortized cost view to spread the cost over the year.

Here's a pattern that works. This part is my advice, not Microsoft's: one environment and one billing plan per business unit in Copilot Studio, with the account resource tagged to that unit; one spending policy per Entra group for Copilot and Cowork, with per-user limits; one Foundry project per use case, in a resource group that belongs to the business unit. Then one place where you bring it all together.

## Bringing it all into one view

Can anything connect the four? Partly, and you have to build it.

### Microsoft's FinOps guidance

Microsoft's FinOps guidance on Learn follows three phases - Inform, Optimize, Operate - and is "largely based on the FinOps Framework with a few enhancements". It's good guidance, but it doesn't cover agents or Copilot Credits. The [unit economics page](https://learn.microsoft.com/en-us/cloud-computing/finops/framework/quantify/unit-economics) comes closest to "what does one agent session cost", and it points you to your own telemetry. Nobody hands you a cost-per-conversation number.

### The FinOps toolkit and FinOps hubs

The [FinOps toolkit](https://learn.microsoft.com/en-us/cloud-computing/finops/toolkit/finops-toolkit-overview) is open source and released monthly. It includes FinOps hubs, Power BI reports, workbooks (including cost optimization and governance), the Azure Optimization Engine, PowerShell and Bicep modules, and open data. If you only need better Azure reporting for Foundry, the workbooks and Power BI reports may be enough.

[FinOps hubs](https://learn.microsoft.com/en-us/cloud-computing/finops/toolkit/hubs/finops-hubs-overview) are Microsoft's "virtual command centers for leaders throughout the organization to report on, monitor, and optimize cost". Deploying one gives you a Data Lake Storage account, Data Factory for loading, Key Vault, and optionally Azure Data Explorer or Microsoft Fabric for analysis. The benefits that matter for agents: reporting across separate tenants, discount savings for EA and MCA accounts (where Foundry reservations show up), fast year-over-year queries, the FOCUS cost format, and room to add your own business data.

Microsoft publishes the cost: from $120 a month plus about $10 a month per $1 million of spend monitored. Most of that is the analysis engine: about $120 for a single-node Data Explorer cluster, or $300 for F2 Fabric capacity. Without either, it's about $5 per $1 million monitored. For a large agent estate that's small. For a small one, start with the workbooks and reports.

### What a hub doesn't see on its own

A hub loads Cost Management exports, so it sees what Azure bills. That covers all of Foundry, and Copilot Studio if you pay as you go. It doesn't cover capacity packs, which Azure doesn't show, or the per-user and per-policy detail from the Microsoft 365 admin center. So the realistic target is three feeds, not one screen:

| Feed | What it covers | How it gets into the hub |
|---|---|---|
| Cost Management exports (FOCUS) | Foundry, plus Copilot Studio and Cowork billed through Azure | Built in |
| Power Platform consumption reports | Copilot Studio per environment and agent, including capacity packs | Your own export and Data Factory pipeline |
| Microsoft 365 Cost management views | Copilot and Cowork per policy, group, and user | Your own export and pipeline |

Microsoft expects you to extend a hub this way. One rule: don't change the built-in pipelines or the data in the `msexports` container, and give your own pipelines a clear prefix.

Sort out permissions early, because they cross teams. Exports need Cost Management Contributor (or the matching EA or MCA billing roles). Deploying the template needs Owner, or Contributor plus Role-Based Access Control Administrator.

Microsoft also shows how to [put an agent on top of a hub](https://learn.microsoft.com/en-us/cloud-computing/finops/toolkit/hubs/configure-ai), through a Kusto Query MCP server published to Teams or Microsoft 365 Copilot. It's handy for quick questions like which agent grew most this month. It has the same gaps as the hub, and it's an agent itself, so give it a spending limit too.

{: .note }
Cost Management exports usually run every 24 hours. Anything built on top inherits that delay. No hub gives you a live agent bill.

### Why bother

For "what did this agent cost last month", the admin center screens are enough. To run a portfolio, one data store helps in a few ways:

* **One total that finance accepts**, instead of three reports pasted into a spreadsheet.
* **Chargeback that survives a reorganization**, because costs follow environments, policies, projects, and tags, not someone's spreadsheet.
* **Reporting across tenants**, if you have an acquisition or a regional tenant.
* **Evidence for commitments** like provisioned throughput, reservations, and pre-purchase plans.
* **A place for business numbers**, so you can get from spend to cost per result.

## Where to start

This order is mine, not Microsoft's. It starts with what pays off fastest and leaves the building work for later.

1. **Turn on the controls you already have.** Per-agent monthly limits with a hard stop in the Power Platform admin center. Per-user limits and alerts in the Microsoft 365 admin center, with Auto-apply off until you've decided. Budgets and anomaly alerts on the Azure subscriptions that carry Foundry, knowing they only warn.
2. **Give every agent and environment an owner.** A cost nobody owns is a cost nobody reduces.
3. **Set up the structure before volume arrives.** One environment and billing plan per business unit, one spending policy per Entra group, one Foundry project per use case, and the Power Platform account resource tagged to a cost center.
4. **Agree how the pool is shared.** Decide how much capacity goes to Power Platform environments and how much stays for Cowork, and review it monthly with both admins.
5. **Turn on Azure reporting.** Create a FOCUS export, then use the toolkit's Power BI reports and workbooks. For many companies, that's enough.
6. **Build a hub when several teams need the same data**, then add the Power Platform and Microsoft 365 feeds.
7. **Add business numbers, then an agent on top.**

Steps one to four cost attention, not money. Steps five to seven are engineering with a real bill. Teams often jump to step six because it's the interesting part, and find out months later that they have great reporting for agents that still have no limits and no owners.

In October, check Microsoft's list of services covered by usage-based billing. When Copilot Studio shows up there, this post gets an update.

## Sources

- Official Microsoft Blog, [Introducing the new Copilot with Home, Code and Autopilot](https://blogs.microsoft.com/blog/2026/09/25/introducing-the-new-copilot-with-home-code-and-autopilot/), 25 September 2026: the cost management expansion, Copilot Studio planned for October, the other announced controls
- Microsoft Learn, [Usage-Based Billing and Cost Management for Copilot Credits](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-overview-copilot-credits), last updated 25 September 2026: where cost management is, which services it covers, Auto-apply on by default
- Microsoft Learn, [Managing AI experiences enabled by usage-based billing](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-manage-copilot-credits), last updated 10 September 2026: spending policy rules, roles, order of credit use, fixed billing method, unbilled use above a limit, request routing, the shared pool
- Microsoft Learn, [View Copilot Credit consumption in the Microsoft 365 admin center and on your Azure bill](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-compare-dashboard-views), last updated 25 September 2026: one Azure service name, capacity packs missing from Azure, reconciliation, service tags
- Microsoft Learn, [Understanding the user subscription license (USL) and usage-based billing (UBB)](https://learn.microsoft.com/en-us/microsoft-365/copilot/user-subscription-license-usage-based-billing), last updated 25 September 2026: billing policy required, more user views coming
- Microsoft Learn, [Check your credit usage for Cowork tasks with /cost](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-copilot-credits-cost), last updated 13 August 2026: what users see, no usage history
- Microsoft Learn, [Manage Copilot Cowork for your organization](https://learn.microsoft.com/en-us/microsoft-365/copilot/cowork/cowork-admin-governance), last updated 14 September 2026: spending policy as access control
- Microsoft Learn, [Microsoft Copilot Agents usage report (Preview)](https://learn.microsoft.com/en-us/microsoft-365/admin/activity-reports/microsoft-365-copilot-agents-new), last updated 18 August 2026: what the adoption report shows and leaves out
- Microsoft, [Microsoft Copilot Plans and Pricing – Enterprise](https://www.microsoft.com/en-us/copilot/pricing/enterprise), read 29 September 2026: employee-facing and API footnotes, Azure subscription for agents
- Microsoft Learn, [Harnesses in Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/harnesses-overview), last updated 22 September 2026: the three harnesses and how they're billed
- Microsoft Learn, [Overview of usage-based billing for the GitHub Copilot harness](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/billing-credit-overview), last updated 28 September 2026: charging from the first build action, what credits cover
- Microsoft Learn, [Manage costs for agents powered by the GitHub Copilot harness](https://learn.microsoft.com/en-us/power-platform/admin/manage-usage-github-copilot-harness), last updated 28 August 2026: no per-user attribution, budgets don't stop use, developer and trial environments, the environment group rule
- Microsoft Learn, [Billing rates and management – Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-messages-management), last updated 3 August 2026: reasoning surcharge, flow trigger rule, computer use, Power Automate flows, the 125% rule
- Microsoft Learn, [Manage Copilot Credits and capacity for Copilot Studio](https://learn.microsoft.com/en-us/power-platform/admin/manage-copilot-studio-copilot-credits-capacity), last updated 21 September 2026: reports, data retention, per-agent limits and hard stop, environment allocation
- Microsoft Learn, [Set up a pay-as-you-go plan](https://learn.microsoft.com/en-us/power-platform/admin/pay-as-you-go-set-up), last updated 16 December 2025: billing plans, the hidden Power Platform account resource, tagging it for cost allocation
- Microsoft Learn, [Microsoft Agent 365 – Service Description](https://learn.microsoft.com/en-us/office365/servicedescriptions/microsoft-agent-365/microsoft-agent-365), last updated 15 September 2026: no cost features listed
- Microsoft Learn, [Agent management in Microsoft 365 admin center](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/agent-365-overview), last updated 20 August 2026: the Agents area of the admin center
- Microsoft Security Blog, [Microsoft Agent 365, now generally available](https://www.microsoft.com/en-us/security/blog/2026/05/01/microsoft-agent-365-now-generally-available-expands-capabilities-and-integrations/), 1 May 2026: general availability and price
- Microsoft Licensing, [Copilot Credits Guide – September 2026](https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/bade/documents/products-and-services/en-us/ai/Copilot-Credits-Guide-September-2026.pdf): credits pooled per tenant, central management statement
- Microsoft Learn, [How to use the Consumption Dashboard in Insights](https://learn.microsoft.com/en-us/viva/insights/org-team-insights/ai-cost-dashboard), last updated 8 September 2026: Cowork and Work IQ consumption in Insights
- Microsoft Copilot Blog, [Copilot Managed Runtime public preview](https://www.microsoft.com/en-us/copilot/blog/copilot-studio/build-where-you-want-run-with-confidence-now-microsoft-hosts-and-manages-the-code-created-by-copilot/), 25 September 2026: Managed Runtime in public preview
- Microsoft Azure, [Foundry Agent Service pricing](https://azure.microsoft.com/en-us/pricing/details/foundry-agent-service/), read 29 September 2026: no charge for Foundry-native agents, tool prices, hosted agents
- Microsoft Learn, [Plan and manage costs for Microsoft Foundry](https://learn.microsoft.com/en-us/azure/foundry/concepts/manage-costs), last updated 27 August 2026: fine-tuning, failed calls, no hard limits, meter names, portal estimates, project tag chargeback
- Microsoft Learn, [Provisioned throughput billing and cost management](https://learn.microsoft.com/en-us/azure/foundry/openai/concepts/provisioned-throughput-billing), last updated 26 May 2026: no pause, shared quota, reservation order
- Microsoft Learn, [Getting started with Azure OpenAI batch deployments](https://learn.microsoft.com/en-us/azure/foundry/openai/how-to/batch), last updated 5 June 2026: 50% less than global standard
- Microsoft Learn, [Prompt caching with Azure OpenAI](https://learn.microsoft.com/en-us/azure/foundry/openai/how-to/prompt-caching), last updated 11 August 2026: read discounts, write charges, 1,024-token rule
- Microsoft Learn, [Model router for Microsoft Foundry](https://learn.microsoft.com/en-us/azure/foundry/openai/concepts/model-router), last updated 1 September 2026: routing modes and the context window limit
- Microsoft Learn, [Identify anomalies and unexpected changes in cost](https://learn.microsoft.com/en-us/azure/cost-management-billing/understand/analyze-unexpected-charges), last updated 26 June 2025: 36-hour delay, subscription scope, five rules, one-time email
- Microsoft Learn, [FinOps Framework overview](https://learn.microsoft.com/en-us/cloud-computing/finops/framework/finops-framework), last updated 8 May 2025: the three phases
- Microsoft Learn, [Unit economics](https://learn.microsoft.com/en-us/cloud-computing/finops/framework/quantify/unit-economics), last updated 2 April 2025: measuring cost per unit yourself
- Microsoft Learn, [FinOps toolkit overview](https://learn.microsoft.com/en-us/cloud-computing/finops/toolkit/finops-toolkit-overview), last updated 11 February 2026: toolkit parts and monthly releases
- Microsoft Learn, [FinOps hubs overview](https://learn.microsoft.com/en-us/cloud-computing/finops/toolkit/hubs/finops-hubs-overview), last updated 1 April 2026: components, benefits, cost estimate, permissions, `msexports` rule
- Microsoft Learn, [Configure AI agents for FinOps hubs](https://learn.microsoft.com/en-us/cloud-computing/finops/toolkit/hubs/configure-ai), last updated 18 May 2026: agent on top of a hub, 24-hour exports
- Previous article in this series: [Copilot Pricing After 25 September 2026 - The License for Everyday AI, Credits for Agentic Work](https://holgerimbery.blog/copilot-pricing-licenses-and-credits)
