---
layout: post
canonical_url: https://holgerimbery.blog/agent-finops-microsoft-ecosystem
title: Agent FinOps in the Microsoft Ecosystem - Where the Costs Are and How to Control Them
description: A plain guide to agent costs across Microsoft 365 Copilot, Copilot Cowork, Copilot Studio, and Foundry agents - what each one charges you for, which screen shows the number, and what you can do to lower it.
date: 26-10-03
author: admin
slug: agent-finops-microsoft-ecosystem
image: /images/2026/10/immo-wegmann-lLRm3S-7Kfw-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@tinkerman?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Immo Wegmann</a> on <a href="https://unsplash.com/photos/silver-and-gold-round-coins-lLRm3S-7Kfw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
tags:
  - agentfinops
  - chargeback
  - copilotcredits
  - copilotcowork
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
> With agents, you no longer buy seats. A meter runs. On the Microsoft stack, that meter runs in four places - Microsoft 365 Copilot, Copilot Cowork, Copilot Studio, and Foundry agents - and each one charges differently, reports in a different admin center, and reacts to different settings. This article walks through all four. For each one: what you pay for, where you can see the number, and how to reduce it. Every fact comes from Microsoft's own documentation, and I give each page's "last updated" date so you can see how current it is.

## What FinOps means when you run agents

FinOps is three simple habits. Make spending visible. Give it an owner. Then reduce it.

That has worked well for cloud costs, because cloud costs have a clear unit you can point at: an hour of a virtual machine, a gigabyte, a request.

Agents break that. One user question can start a plan, several model calls, a search through your company data, a few tool calls, some retries, and sometimes other agents. All of it happens in seconds, usually before any dashboard updates. Counting tokens only shows you one part of it.

So with agents, you keep the three habits and change what you count. The useful number is the cost of one agent session. Even better, you can get it: the cost of one result - one ticket solved, one document checked, one invoice cleared. That is the number your finance team can work with.

Three things make this harder than normal cloud cost work.

**Cost can start before you go live.** In one part of Copilot Studio, building an agent already uses credits. Previewing and testing count too.

**Without a person in the loop, nothing slows the agent down.** A human is a natural brake. Take the human out, and the cost follows how often the agent is triggered, not how many people use it.

**The meters are not on one screen.** Copilot and Cowork report in the Microsoft 365 admin center. Copilot Studio reports in the Power Platform admin center. Foundry reports in Azure. Nothing shows all four together.

## The four places you pay

This is the map. Each row has its own section below.

| Surface | What it charges for | Where you see the cost | Can you set a hard stop |
|---|---|---|---|
| Microsoft 365 Copilot | A seat per user, plus metered agent use for people without a seat | Microsoft 365 admin center, Cost Management | Yes, a limit per user |
| Copilot Cowork | Copilot Credits per task, always metered | Microsoft 365 admin center, Cost Management | Yes, a limit per user |
| Copilot Studio | Copilot Credits per agent activity | Power Platform admin center | Yes, a monthly limit per agent |
| Foundry agents | Model tokens, tools, storage, compute | Azure Cost Management | No, budgets only send warnings |

The first three share one pool of credits. The fourth is billed through Azure and is completely separate.

## Microsoft 365 Copilot

### What you pay for

A seat costs 30 US dollars per user per month on a yearly subscription. What that seat really buys you, cost-wise, is free agent use: for a user with a seat, agents that give classic answers, generative answers, or ground answers in your company data through Microsoft Graph cost nothing extra in Copilot Chat, Teams, or SharePoint.

Without a seat, people can still use Copilot Chat. In that case, the pricing page marks agent use, connectors to outside data, and Cowork as metered. The ready-made agents - Researcher, Analyst, and Facilitator - only come with the seat. One sentence on that page belongs in every licensing discussion: "An Azure subscription is required to use agents."

Two footnotes make "included" smaller than people expect. It "Refers to employee-facing usage scenarios", and it "Does not include cost of API calls, including Work IQ API calls." So agents that serve customers, and anything driven by APIs, are not covered - no matter who holds the seat.

{: .note }
Included use is subject to fair-use limits, and Microsoft says it can update those limits as the product changes. "Included" is a commercial promise, not a technical one.

### Where you see the cost

Two screens answer different questions.

**Microsoft 365 admin center, Cost Management.** This is the money screen. The [admin guidance](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-manage-copilot-credits) (last updated 10 September 2026) shows usage by spending policy, group, user, agent, service, and funding source.

**The Microsoft Copilot Agents usage report (preview).** This one shows adoption, not money. It lists active users split into licensed and unlicensed, active agents, responses sent, and who created the agent, with data visible about an hour after use. It has no cost or credit column. It only covers the last 7 or 30 days, excludes SharePoint agents used in Teams, excludes Cowork, and hides user names by default. Use it to find out which agents people really use. Do not use it to charge costs back.

### How to save money

**Decide seat or meter for each group of people, with real numbers.** For people who use agents a lot, a seat that makes employee-facing use free can be cheaper than credits. For light users, it is the other way round. This is the biggest lever here, and it is a buying decision, not a setting.

**Switch on spending limits per user.** You can set monthly limits for the whole organization and per user, send warnings to admins and to users, and route requests for more credits through an approval.

**Switch off auto-apply for new services.** That setting is on by default, so any newly supported Copilot service is automatically covered by an existing budget. Microsoft itself suggests turning it off if you want to review new services first.

**Get the billing method right the first time.** Once a spending policy exists, you cannot change its billing method. You have to delete it and create a new one. Two more things to know: the policy always spends prepaid credits first, before pay-as-you-go, and moving a user to another group or policy does not reset what they already used.

## Copilot Cowork

### What you pay for

Cowork is the place where a user hands over a whole piece of work instead of a single prompt. The pricing follows from that. You need a Microsoft 365 license to get in, and all Cowork use is metered. The license is the door, not the fuel. Use is charged in Copilot Credits.

The [usage-based billing overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-overview-copilot-credits) lists what this billing model covers today: Cowork, apps built with Copilot Cowork, and the Work IQ API. It is worth re-reading that list now and then, because it grows.

### Where you see the cost

The Cost Management screen looks the same as Microsoft 365 Copilot, split by spending policy, group, user, agent, service, and funding source. Cowork is one of the few places where you can really see cost per user. That is lucky, because it is also a place where one person can use a lot.

One thing the adoption report will not help with: Cowork isn't included. The money screen is your only view.

{: .warning }
If a user goes over a per-user limit mid-task, Microsoft may not bill the extra use, and it won't show up as used credits in the Cost Management dashboards. So the dashboard shows less than real use at exactly the moment you want to understand it.

### How to save money

**Start with per-user limits switched on.** Handing over work has no natural end. Someone who finds Cowork useful will use it more next week.

**Use approvals instead of raising budgets for everyone.** Routing credit requests through an approval turns an open budget into a short conversation, and the request itself tells you which work is worth paying for.

**Set policies per group, not for the whole tenant.** One spending policy per Entra group gives you units you can compare. Comparing is how you spot the outlier.

**Watch which pot pays first.** Prepaid credits are used before pay-as-you-go across the whole pool. So Cowork quietly draws from the same prepaid capacity your Copilot Studio environments use. More on that below.

## Copilot Studio

### What you pay for

Copilot Studio charges in Copilot Credits. The billing page says it plainly: "Copilot Credits are the unit that measures agent usage." Credits are shared across the whole tenant, and pay-as-you-go costs 0.01 US dollars per credit.

What you spend depends on what the agent does, not on how much text it writes. From the [billing rates page](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-messages-management) (last updated 3 August 2026):

| Agent feature | Copilot Credits | User with an M365 Copilot seat |
|---|---|---|
| Classic answer | 1 | No charge |
| Generative answer | 2 | No charge |
| Agent action | 5 | No charge |
| Grounding in your tenant data | 10 | No charge |
| Agent flow actions (per 100) | 13 | No charge |
| Text and generative AI tools (basic) | 0.1 per 10 responses | No charge |
| Text and generative AI tools (standard) | 1.5 per 10 responses | No charge |
| Text and generative AI tools (premium) | 10 per 10 responses | No charge |
| Content processing | 8 per page | No charge |

Voice is charged per minute and sits much higher: 10 credits for classic voice, 35 for generative AI voice, 75 for premium generative AI voice. If you build a voice agent, that is your main cost line, not the table above.

Four details matter more than the rates themselves.

**Reasoning models are charged twice.** You pay the feature rate, plus the premium tools rate of 100 credits per 1,000 tokens. Your cost is the sum of both, not the higher of the two.

**Agent flows are only free through one door.** For a user with a seat, the free inclusion applies to flows started by the "When an agent calls the flow" trigger. Flows with any other trigger cost credits at the normal rate. That is exactly the scheduled or event-driven pattern you build once an agent becomes useful.

**Computer-using agents are not included** in the Microsoft 365 Copilot seat.

**Power Automate cloud flows are billed separately.** They use Power Automate licensing, are not paid in credits, and are not affected by Copilot Studio limits.

Then there is the harness, which decides *when* the meter starts. The [harnesses overview](https://learn.microsoft.com/en-us/microsoft-copilot-studio/harnesses-overview) (last updated 27 August 2026) says that "The harness you use affects the billing, features, and capabilities of what you build."

| Harness | What it is for | When charging starts |
|---|---|---|
| Standard | Rule-based agents, topics, agent flows | After you publish, at the rates above |
| Copilot chat | Copilot Chat extended with your own knowledge | Metered, or included in the M365 Copilot seat |
| GitHub Copilot | Multi-step agents that reason and work with documents | With your first build action, before anyone publishes |

On the GitHub Copilot harness, credits cover model tokens, tools including knowledge and MCP servers, and the harness itself. It "charges credits from the moment you start building", and that includes previewing, testing, and creating evaluations. It also covers the places people assume are free: "Developer environments and trial environments move to usage-based billing September 1, 2026."

{: .caution }
Prepaid capacity does not run out gently. "Enforcement is triggered when a tenant reaches 125% of their prepaid capacity", and then custom agents are switched off. Users see "This agent is currently unavailable. It has reached its usage limit." Agent flows behave differently: new runs are blocked while the agent itself keeps answering, so the agent looks fine and quietly stops doing work.

### Where you see the cost

**Power Platform admin center.** Usage is reported for the tenant, per environment, and per agent, and you can download the report. The environment view shows the product, the feature, and how many credits were billed versus free. That free-versus-billed split is easy to miss, and it shows what your licensed users get at no cost. The capacity summary keeps daily data for three months and monthly data for a year.

**Azure, if you use pay-as-you-go.** A billing plan creates a Power Platform account resource in the linked Azure subscription, and all Azure meters for Power Platform bill to it. It is hidden in the portal by default - choose "View hidden types" to find it.

There is a hard limit here, and Microsoft states it: "Discrete costs aren't attributed to individual makers or end users." Copilot Studio bills per environment and per agent. There is no per-user view to build a chargeback model on.

### How to save money

**Check how often you ground in tenant data.** Grounding costs 10 credits against 1 for a classic answer. An agent that searches SharePoint or Exchange on every turn costs roughly ten times as much as a simple one. This is usually the biggest number in a Copilot Studio estimate, and often the easiest one to cut in half.

**Choose the harness on purpose.** The GitHub Copilot harness is right for genuinely autonomous, multi-step work, and it charges you to build as well as to run. Use it where the autonomy is worth it, and the standard harness where it is not.

**Set a monthly limit per agent, with a hard stop.** Under Licensing in the Power Platform admin center, each agent can have a monthly credit limit with a status of within limit, nearing limit, or over limit - and a hard stop that switches the agent off when it reaches the number. Where the money really matters, this setting is your control, not a budget warning.

**Keep environments contained.** Give each environment its own credits and clear the "Draw from the available capacity in my tenant" option. One catch: this does not stop use through a pay-as-you-go plan linked to the same environment. Environment groups can enforce the rule across a whole group with a setting called "Cost controls - Draw from tenant credit pool". After that, the environment setting is read-only and cannot be overridden programmatically.

**Choose your failure mode: prepaid or pay-as-you-go.** With prepaid, you risk the 125% cut-off, and unused credits do not move to the next month. With pay-as-you-go, there is no cut-off, because extra use is billed to your Azure subscription - so no outage, and no ceiling either. Pick the problem you can live with.

**Move flows to the free trigger where the design allows.** Not every scheduled flow has to be scheduled.

## One credit pool, two admin centers

This one changes how you design things, and it is easy to miss, because each side describes it in different words.

Capacity you give to Power Platform environments, or that Copilot Studio uses, reduces the prepaid capacity left for Microsoft 365 experiences such as Cowork and Work IQ. From the Microsoft 365 side, available credits are the credits you bought minus the credits already given to environments in the Power Platform admin center.

One pool, two teams taking from it, usually without talking to each other. If your Power Platform admin hands out a lot of capacity, your Microsoft 365 admin sees available credits drop for no obvious reason. Put both roles in the same monthly review, or expect surprises.

## Foundry agents

### What you pay for

Foundry works the opposite way to Copilot Studio. A credit hides a whole workflow behind one number. Foundry charges each resource separately, which is harder to forecast but much easier to assign to a team.

Start with the headline on the [Foundry Agent Service pricing page](https://azure.microsoft.com/en-us/pricing/details/foundry-agent-service/): there is "no additional charge for creating or running Foundry-native agents" with prompts and workflows. You pay for what the agent uses.

| Component | How it is charged |
|---|---|
| Model use | Tokens, with input and output priced separately |
| File Search (knowledge) | 0.11 US dollars per GB of vector storage per day, first GB free |
| Code Interpreter | 0.033 US dollars per session |
| Web Search and Custom Search | 14 US dollars per 1,000 requests |
| Hosted agents (Agent Framework, LangGraph) | The container compute they run on, per hour |
| Fabric, SharePoint, Bing grounding, Foundry IQ, Logic Apps connectors | Charged separately, on top of tokens |

The [cost planning page](https://learn.microsoft.com/en-us/azure/foundry/concepts/manage-costs) (last updated 27 August 2026) adds three things that catch teams in month two. Fine-tuning is charged three times - training, hosting, and use - and a fine-tuned deployment costs money while it exists, even when nobody uses it. Failed calls are not automatically free: "HTTP status codes alone don't determine whether usage is billed." And there is no emergency brake. Microsoft writes that OpenAI offers hard limits that stop you from going over budget, and that Azure OpenAI does not currently offer this.

### Where you see the cost

**Azure Cost Management is the official record.** Two practical notes. Azure OpenAI sits inside the wider Cognitive Services group, so filter by service tier. And meters are named `model-name-GUID`. Partner and community models appear at resource group level instead of on the Foundry resource, and some show under "Global resources". So look at the whole resource group, not just the resource.

**The Foundry portal shows estimates, not invoices.** There is an estimated cost tile per project and date range, and an estimated cost column in the agent list. Microsoft's own advice is worth following exactly: use the estimate for near-real-time monitoring, and use Cost Management and the invoice for the actual numbers. The estimates leave out prompt agents, non-Foundry agents, and provisioned throughput.

**Anomaly detection is your safety net, and it is slower than an agent.** Azure checks each subscription daily against a forecast built from the last 60 days, and "Anomaly detection runs 36 hours after the end of the day (UTC)". Alert rules only work at the subscription level; you get five per subscription, and the email is sent once, when the anomaly is found. For a normal workload, that is fine. For an agent stuck in a loop, 36 hours is the whole incident.

### How to save money

Four things really move a Foundry bill. The rest is small change.

**Match the deployment type to the workload.** Standard pay-per-token for development and for traffic that comes in bursts. Provisioned Throughput for steady production that needs predictable speed - but remember you cannot pause it, and "Billing stops only when the deployment is deleted." PTU quota is shared across supported models in a region and deployment type, so you can consolidate more than people expect. If you reserve, create the deployments first and buy the reservation after, and keep in mind that a reservation does not guarantee capacity.

**Move bulk work to Batch.** Large jobs that can wait run at about half the standard price. It is still the most overlooked discount on the platform for summarizing and classifying in bulk.

**Use prompt caching, and check both sides of it.** Reading from the cache is cheaper on input tokens for Standard deployments, and up to 100% cheaper for Provisioned ones. On GPT-5.6 models and newer, writing to the cache can cost extra. The rules are strict: at least 1,024 tokens, an identical prompt start, and no sharing between Azure subscriptions. Standard deployments report `cached_tokens` and `cache_write_tokens`. PTU-managed deployments do not show the write field.

**Treat the model router mode as a cost dial.** Balanced picks the cheapest model that stays within about 1 to 2% of the best quality. Cost mode widens that to about 5 to 6%. Quality mode ignores cost. One catch before you route production traffic: the usable context window is limited by the smallest model behind the router.

## How to charge costs back

This is where the real work is, because each surface gives you a different handle.

**Copilot Studio - the environment and the billing plan.** The Power Platform account resource created by a billing plan can be tagged like any other Azure resource, and that is how Copilot Studio costs enter your normal Azure cost model. Deleting the billing policy does not delete that resource. And because there is no per-user view here, the way you lay out environments *is* your chargeback model.

**Microsoft 365 Copilot and Cowork - the spending policy.** One policy per Entra group is your department unit, with per-user limits inside it. Microsoft describes this as billing per department, with different billing methods per group, department, or set of users. These two are the only surfaces with real per-user cost data.

**Foundry - the project tag.** The best handle of the four, and currently in preview. Foundry supports chargeback per project, and "Every Foundry project is automatically tagged with a project tag on its underlying usage." You do not tag anything yourself. Filter Cost Analysis by the `project` tag. The preview limit covers models sold by Azure, including Azure OpenAI, but not yet models sold through Azure Marketplace.

A pattern that works, and this part is mine rather than Microsoft's: one environment and one billing plan per business unit in Copilot Studio, with the account resource tagged to that unit; one spending policy per Entra group for Copilot and Cowork, with per-user limits; one Foundry project per use case, inside a resource group that belongs to the business unit. Then one place where you bring the four together.

## Bringing it all into one view

So far this has been four separate conversations with four separate admin centers. The obvious question is whether anything connects them. The honest answer: partly, and you have to build it.

### What Microsoft's FinOps guidance covers

Microsoft's FinOps guidance on Learn follows a three-phase cycle - Inform, Optimize, Operate - with areas such as allocation, anomaly management, unit economics, and invoicing and chargeback. Microsoft describes it as "largely based on the FinOps Framework with a few enhancements" from its own customers and partners.

It is good guidance, and it says nothing about agents. It has no AI or agent page. The unit economics page, which is closest to the question "what does one agent session cost", stays general: it explains that unit economics means working out the cost of a single unit of your business, and points you to your own application telemetry, Azure Monitor, and Application Insights. In short, you have to measure your own agents. Nobody hands you a cost-per-conversation number.

So the framework gives you the words. The toolkit gives you the tools.

### What is in the FinOps toolkit

The [FinOps toolkit](https://learn.microsoft.com/en-us/cloud-computing/finops/toolkit/finops-toolkit-overview) (last updated 11 February 2026) is open source, with monthly releases, and it is wider than the hubs it is known for:

* **FinOps hubs** - the data platform, described below
* **Power BI reports** - five starter reports, meant to be changed
* **FinOps workbooks** and a **cost optimization workbook** - Azure Monitor workbooks with savings findings
* **A governance workbook** - policy and compliance next to cost
* **Azure Optimization Engine** - automatic optimization suggestions
* **A PowerShell module and Bicep modules** - for scripting and infrastructure as code
* **Open data** - pricing units, regions, resource types, services, and sample exports

If you just need better Azure reporting for Foundry agents, the workbooks and Power BI reports may already be enough. Build a hub when several teams need to query the same data.

### What a FinOps hub is

Microsoft describes [FinOps hubs](https://learn.microsoft.com/en-us/cloud-computing/finops/toolkit/hubs/finops-hubs-overview) (last updated 1 April 2026) as "virtual command centers for leaders throughout the organization to report on, monitor, and optimize cost". They are built on three ideas: be the standard way to apply the FinOps Framework, work at large scale, and stay open and extensible.

When you deploy the template, you get a Data Lake Storage Gen2 account as the landing area, a Data Factory instance that handles loading and clean-up, a Key Vault for the Data Factory credentials, and optionally Azure Data Explorer or Microsoft Fabric Real-Time Intelligence for analysis. After that, you can query with KQL, use the Data Explorer or Fabric dashboards, connect the Power BI templates, or point your own tools at the data.

The benefits that matter for an agent estate, from Microsoft's own list:

* Reporting across accounts and subscriptions **in separate tenants**
* Summarizing negotiated and commitment discount savings for EA and MCA accounts - where your Foundry reservations show up
* Year-over-year trend queries that answer in seconds
* "Full alignment with the FinOps Open Cost and Usage Specification (FOCUS)"
* Room to **add business data or cost data from other providers** through Data Factory, Data Explorer, Fabric, and Power BI
* Backward compatibility when future data versions add or change columns
* Conversion to parquet for faster access

FOCUS is what makes this work as a common format. Cost Management exports support it in several versions - 1.0-preview, 1.0, 1.0r2, and 1.2-preview - and a FOCUS export holds the same cost and usage data as the actual and amortized files. One format, one store, one query language for everything Azure bills.

### What a hub costs

Microsoft publishes an estimate instead of leaving you to guess: from 120 US dollars per month, plus about 10 US dollars per month for every 1 million US dollars of cost you monitor. Most of that is the analysis engine - around 120 dollars for a single-node Azure Data Explorer cluster, or 300 dollars for F2 Fabric capacity - plus around 10 dollars of storage and processing per 1 million dollars monitored, based on roughly 20 GB of data per 1 million dollars. Without Data Explorer or Fabric, it drops to about $ 5 per $ 1 million monitored. Fabric or Power BI licenses come on top.

For a company spending real money on agents, that is small compared to what you can see. For a small estate, start with the workbooks and the Power BI reports and skip the cluster.

### What you still have to join up yourself

This is the part I want you to remember, because it is where the "single screen" idea falls apart.

A hub loads **Cost Management exports**. So it sees what Azure bills. Foundry is fully covered - tokens, tools, storage, PTU, reservations. Copilot Studio is covered only if you use pay-as-you-go, because that usage is billed through the Power Platform account resource in your Azure subscription. Prepaid capacity packs and Microsoft 365 credit use - Copilot and Cowork - are bought and reported on the Microsoft 365 side, in the admin center views described earlier, not as Azure meters.

So a realistic target is three feeds, not one screen:

| Feed | What it covers | How it gets into the hub |
|---|---|---|
| Cost Management exports (FOCUS) | All of Foundry, plus Copilot Studio pay-as-you-go | Built in, the hub's normal path |
| Power Platform consumption reports | Copilot Studio prepaid credit use per environment and agent | Export by hand or by script, then your own Data Factory pipeline |
| Microsoft 365 Cost Management views | Copilot and Cowork credit use per policy, group, and user | Same way |

Microsoft's own guidance supports this: you are meant to extend a hub with business data and other cost data through Data Factory. One rule to follow: do not change the built-in pipelines or the data in the `msexports` container, and give your own pipelines a clear prefix so they do not clash with new ones.

Sort out permissions early, because they cross teams. Setting up exports needs Cost Management Contributor at subscription or resource group level, or the matching reader and contributor roles at EA and MCA billing level. Deploying the template needs Owner, or Contributor plus Role-Based Access Control Administrator.

### Let an agent read your cost data

The toolkit closes a nice loop. The [configure AI agents for FinOps hubs](https://learn.microsoft.com/en-us/cloud-computing/finops/toolkit/hubs/configure-ai) page (last updated 18 May 2026) shows how to connect a hub to a Kusto Query MCP server and publish it as an agent in Teams or Microsoft 365 Copilot. It also covers GitHub Copilot agent mode with the Azure MCP server.

This is genuinely useful for the quick questions that otherwise land on someone's desk: which agent grew most this month, which environment is heading over budget. Two warnings. It reads hub data, so it has the same gaps as above. And it is itself an agent on one of the four meters in this article, so give it the same spending limits as everything else.

### Why this is worth it for a larger company

The admin center screens are fine for "what did this agent cost last month". They are not enough to run a portfolio. Five things change once the data sits in one place.

**One number your finance team accepts.** Today the Copilot bill, the Copilot Studio report, and the Azure invoice arrive separately, get pasted into a spreadsheet, and no longer match by the time anyone presents them. With one store, total agent spend is a query - and the same query works next month.

**Chargeback that survives a reorganization.** Costs are assigned by structures - environments, spending policies, projects, tags - not by someone's spreadsheet. When a business unit is split, you remap a field instead of rebuilding the model. That matters, because the one certainty with an agent estate is that it will be reorganized before it is optimized.

**It works across tenants.** Reporting across accounts and subscriptions in separate tenants is on Microsoft's benefit list. If you carry an acquisition, a joint venture, or a regional tenant, that is the difference between one view and a quarterly reconciliation project.

**Evidence for the big commitments.** Foundry's strongest savings - provisioned throughput, reservations, batch - are commitments you make against a usage pattern. Summarized discount savings for EA and MCA accounts, plus fast year-over-year queries, turn "we think this workload is steady" into a number you can defend. Buying PTU on a hunch is how you end up paying around the clock for capacity you use part-time.

**A place for the business numbers.** Cost per result needs a second number - tickets solved, invoices cleared, documents checked - and that lives in a business system, not in a billing feed. Data Factory, Fabric, and Power BI are where the two meet. Until they do, you have spend without meaning.

### Where to start if you have none of this

The order below is mine, not Microsoft's. It starts with what pays off fastest and leaves the platform work for later. Almost every runaway-cost story I see would have been stopped by step one, which takes an afternoon and costs nothing.

**1. Switch on the controls you already have.** Monthly limits per agent with a hard stop in the Power Platform admin center. Spending limits per user and warnings in the Microsoft 365 admin center, with auto-apply for new services off. Budgets and anomaly alerts on the Azure subscriptions that carry Foundry, knowing they only warn you.

**2. Assign an owner to every agent and environment.** A cost with no owner is a cost nobody reduces. Do this while the list still fits on one page.

**3. Sort out the structure before the volume arrives.** One environment and billing plan per business unit, one spending policy per Entra group, one Foundry project per use case, and the Power Platform account resource tagged to a cost center. Doing this later is a project. Doing it now is a naming convention.

**4. Turn on Azure reporting without building anything.** Create a FOCUS export in Cost Management, then use the toolkit's Power BI reports and the cost optimization and governance workbooks. For many companies, this is the point of diminishing returns, and stopping here is a fair answer.

**5. Deploy a hub when more than one team needs the same data.** The prerequisites are short: enable the `CostManagementExports` and `EventGrid` resource providers on the subscription, agree on public or private network routing with your network team, optionally set up Fabric Real-Time Intelligence, deploy the template, create the exports or give the hub access, then connect the dashboards or Power BI reports. Agree on the permissions first.

**6. Add the two manual feeds.** Power Platform consumption reports and Microsoft 365 credit use, loaded through your own pipelines, leaving the built-in ones and the `msexports` container alone.

**7. Add the business numbers, then let an agent read it.** Bring in the result counts that turn spend into cost per outcome. Only then put an agent on top, so people can ask questions instead of raising requests.

One last thought on the order. Steps one to three are governance: they cost attention and nothing else. Steps four to seven are engineering with a real bill. Teams often start at step five because it is the interesting one, and find out months later that they built great reporting for an estate that still has no hard stops and no owners.

{: .note }
Cost Management exports usually run every 24 hours, though managed exports can run more often. Anything you build on top inherits that delay, and the Foundry portal's own figures are meant for quick monitoring, not for reconciliation. No hub gives you a live agent bill.

## Sources

- Microsoft Learn, [Billing rates and management - Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-messages-management), last updated 3 August 2026: the credit rates, voice rates, double charging for reasoning models, the CUA exclusion, and the 125% cut-off
- Microsoft Learn, [Standard harness licensing - Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/billing-licensing), last updated 3 August 2026: credits as the shared currency, ways to buy, no carry-over between months, free use for licensed users
- Microsoft Learn, [Harnesses in Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/harnesses-overview), last updated 27 August 2026: the three harnesses and how each is billed
- Microsoft Learn, [Overview of usage-based billing for the GitHub Copilot harness](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/billing-credit-overview), last updated 31 August 2026: charging during build, and what credits cover
- Microsoft Learn, [Manage costs for agents powered by the GitHub Copilot harness](https://learn.microsoft.com/en-us/power-platform/admin/manage-usage-github-copilot-harness), last updated 28 August 2026: budgets do not stop use, no per-user attribution, usage-based billing for developer and trial environments, the shared credit pool
- Microsoft Learn, [Manage Copilot Credits and capacity for Copilot Studio](https://learn.microsoft.com/en-us/power-platform/admin/manage-copilot-studio-copilot-credits-capacity), last updated 18 August 2026: admin center reporting, monthly limits per agent, and the hard stop
- Microsoft Learn, [Set up a pay-as-you-go plan](https://learn.microsoft.com/en-us/power-platform/admin/pay-as-you-go-set-up), last updated 16 December 2025: billing plans, the Power Platform account resource, and tagging it for Azure cost allocation
- Microsoft Learn, [Managing AI experiences enabled by usage-based billing](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-manage-copilot-credits), last updated 10 September 2026: spending policies, limits per user, which pot pays first, the fixed billing method, and unreported use above a limit
- Microsoft Learn, [Usage-based billing overview for Copilot Credits](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-overview-copilot-credits): which services this billing model covers, including Cowork and the Work IQ API
- Microsoft Learn, [Microsoft Copilot pay-as-you-go service overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/pay-as-you-go/overview), last updated 18 August 2026: the billing policy as a department unit, and budget limits
- Microsoft Learn, [Microsoft Copilot Agents usage report (Preview)](https://learn.microsoft.com/en-us/microsoft-365/admin/activity-reports/microsoft-365-copilot-agents-new), last updated 18 August 2026: what the adoption report shows, and what it leaves out
- Microsoft Learn, [Copilot controls Overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/copilot-controls/overview), last updated 9 September 2026: the three pillars, with licensing and metering as a management control
- Microsoft, [Microsoft 365 Copilot plans and pricing](https://www.microsoft.com/en-us/microsoft-365-copilot/pricing/enterprise): the 30 dollar seat, what is included and what is metered, the Azure subscription requirement, and the employee-facing and API footnotes
- Microsoft, [Copilot Studio pricing and plans](https://www.microsoft.com/en-us/microsoft-365-copilot/pricing/copilot-studio): the 200 dollar pre-purchase plan, with no credit quantity published
- Microsoft Azure, [Copilot Studio pay-as-you-go pricing](https://azure.microsoft.com/en-us/pricing/details/copilot-studio/): 0.01 dollars per Copilot Credit, and what a credit measures
- Microsoft Azure, [Foundry Agent Service pricing](https://azure.microsoft.com/en-us/pricing/details/foundry-agent-service/): no charge for Foundry-native agents, plus File Search, Code Interpreter, Web Search, and hosted agent rates
- Microsoft Learn, [Plan and manage costs for Microsoft Foundry](https://learn.microsoft.com/en-us/azure/foundry/concepts/manage-costs), last updated 27 August 2026: fine-tuning charges, HTTP status codes and billing, no hard limits, meter names, portal estimates, and chargeback per project in preview
- Microsoft Learn, [Provisioned throughput billing and cost management](https://learn.microsoft.com/en-us/azure/foundry/openai/concepts/provisioned-throughput-billing), last updated 26 May 2026: hourly PTU billing, no pause, shared quota, and the order for reservations
- Microsoft Learn, [Prompt caching with Azure OpenAI](https://learn.microsoft.com/en-us/azure/foundry/openai/how-to/prompt-caching), last updated 11 August 2026: cheaper cache reads, cache write charges on GPT-5.6 and newer, and the 1,024-token rule
- Microsoft Learn, [Model router for Microsoft Foundry](https://learn.microsoft.com/en-us/azure/foundry/openai/concepts/model-router): routing modes as cost settings, and the smallest-context-window catch
- Microsoft Learn, [Identify anomalies and unexpected changes in cost](https://learn.microsoft.com/en-us/azure/cost-management-billing/understand/analyze-unexpected-charges), last updated 26 June 2025: the 36-hour delay, one-time alerts, subscription scope, and the five-rule limit
- Microsoft Learn, [FinOps hubs overview](https://learn.microsoft.com/en-us/cloud-computing/finops/toolkit/hubs/finops-hubs-overview), last updated 1 April 2026: what a hub deploys, FOCUS alignment, permissions, and the published cost estimate
- Microsoft Learn, [FinOps Framework overview](https://learn.microsoft.com/en-us/cloud-computing/finops/framework/finops-framework), last updated 8 May 2025: the three phases, the capability areas, and the lack of agent guidance
- Microsoft Learn, [Unit economics](https://learn.microsoft.com/en-us/cloud-computing/finops/framework/quantify/unit-economics), last updated 2 April 2025: what a cost unit is, and why you have to measure it yourself
- Microsoft Learn, [FinOps toolkit overview](https://learn.microsoft.com/en-us/cloud-computing/finops/toolkit/finops-toolkit-overview), last updated 11 February 2026: the toolkit parts, open data, and monthly releases
- Microsoft Learn, [Configure AI agents for FinOps hubs](https://learn.microsoft.com/en-us/cloud-computing/finops/toolkit/hubs/configure-ai), last updated 18 May 2026: the Kusto MCP server, the Azure MCP server, and the export schedule
- Microsoft Learn, [FOCUS cost and usage details file schema](https://learn.microsoft.com/en-us/azure/cost-management-billing/dataset-schema/cost-usage-details-focus), last updated 26 June 2025: the supported FOCUS versions and what an export contains
- Microsoft Learn, [Dataverse capacity-based storage details](https://learn.microsoft.com/en-us/power-platform/admin/capacity-storage), last updated 17 August 2026: storage limits per type, and the agent activity that uses them
