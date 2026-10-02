---
layout: post
canonical_url: https://holgerimbery.blog/copilot-pricing-licenses-and-credits
title: "Understanding Microsoft Copilot Licensing - Rev1"
description: "Part one of a short, but living series on what Copilot and agents cost. What the Copilot license costs, how Copilot Credits work, which features use them, and what Microsoft has announced next."
date: 26-10-03
author: admin
slug: copilot-pricing-licenses-and-credits
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/10/immo-wegmann-lLRm3S-7Kfw-unsplash.jpg
image_caption: "Photo by <a href=\"https://unsplash.com/@tinkerman?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText\">Immo Wegmann</a> on <a href=\"https://unsplash.com/photos/silver-and-gold-round-coins-lLRm3S-7Kfw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText\">Unsplash</a>"
tags:
  - agent365
  - agentfinops
  - copilotcowork
  - copilotcredits
  - copilotstudio
  - finops
  - licensing
  - microsoft365copilot
  - microsoft365e7
  - pricing
  - usagebasedbilling
  - usersubscriptionlicense
featured: true
toc: true
---

{: .note }
This is a living article. I check it against Microsoft's pricing pages, licensing guides, and Learn documentation at the start of every month and update it when something changes. The changelog at the end lists every change.

## Since September 25, Copilot has two price tags

On September 25, 2026, Jared Spataro described the new split on the [Official Microsoft Blog](https://blogs.microsoft.com/blog/2026/09/25/introducing-the-new-copilot-with-home-code-and-autopilot/). The per-user license (Microsoft calls it the USL, user subscription license) covers everyday AI. Usage-based billing (UBB) covers the heavy work. His wording: "Cowork, Code, and Autopilot … and frontier models like Astra and Fable all run on UBB."

For the license, the post promises "the best possible quality at a fixed cost": Copilot in Chat and in Word, Excel, PowerPoint, Outlook, and Teams, plus model selection. Auto, the default mode that picks a model for each request, "is at the heart of the USL."

Microsoft published a Learn page on the same day, [Understanding the user subscription license (USL) and usage-based billing (UBB)](https://learn.microsoft.com/en-us/microsoft-365/copilot/user-subscription-license-usage-based-billing). It calls the two kinds of work "everyday AI" and "advanced AI". Everyday AI is summarizing meetings, drafting documents, and analysis. Advanced AI is "complex, long-running agentic work you hand off": Cowork, Code, Autopilot, the newest frontier models, and some new agentic features in SharePoint.

The page also answers three practical questions.

* **Do credits replace the license?** No. "UBB experiences consume Copilot Credits and require a USL for access."
* **Can users run up a bill on their own?** Not at first. "Admins must set up a billing policy before a user can use AI experiences that require usage-based billing."
* **Who should pay?** Microsoft suggests UBB "may be better funded by business units". So IT buys the licenses, and the teams that want agentic work pay for the credits.

Put the base plan underneath, because you can't buy Copilot without one, and you get three layers.

| Layer | What it covers | How you pay | Who usually pays |
|---|---|---|---|
| Microsoft 365 base plan | The prerequisite | Fixed, per user | IT |
| Copilot license (USL) | Chat, Copilot in the Office apps, Auto, model choice | Fixed, per user | IT |
| Usage-based billing (UBB) | Cowork, Code, Autopilot, frontier models, Work IQ APIs, many agents | Copilot Credits, per use | Business units, if you follow Microsoft |

The US enterprise page is clear about the first row: "A qualifying Microsoft 365 subscription is required to purchase Copilot."

{: .note }
In August 2026, Microsoft renamed "Microsoft 365 Copilot" to "Microsoft Copilot". Learn: "Microsoft 365 Copilot is now named Microsoft Copilot". Most pricing pages still use the old name, so I use it wherever I quote it.

## How we got here

The September 25 post named something that had been happening for a year. Here are the main steps.

| Date | What changed |
|---|---|
| September 1, 2025 | "Messages" in Copilot Studio renamed to Copilot Credits, same price |
| October 27, 2025 | Copilot Credit Pre-Purchase Plan introduced |
| December 2, 2025 | Copilot Business for small companies announced at $21 |
| March 9, 2026 | Microsoft 365 E7 announced (available May 1 at $99); Cowork in research preview |
| June 16, 2026 | Cowork generally available, billed in credits |
| July 1, 2026 | Base Microsoft 365 plans more expensive; Copilot price unchanged |
| September 25, 2026 | License and usage-based billing split named; Code and Autopilot go on credits |

That year, the $30 license price didn't move. Almost every new feature that needs a lot of computing went onto credits instead.

## What the Copilot license costs

These are Microsoft's list prices as of October 2, 2026. Dollar prices are from the US pages. Euro prices are from the German pages and exclude VAT. Other countries and buying channels (EA or CSP) may have different numbers.

| Plan | USD per user/month | EUR per user/month | Notes |
|---|---|---|---|
| Microsoft 365 Copilot | $30.00 | €26.00 | Paid yearly (monthly billing: $31.50; no euro price published) |
| Microsoft 365 Copilot Business | $21.00 | €18.20 | Up to 300 users |
| Copilot Business, current discount | $18.00 | €15.60 | July 1 – December 31, 2026 |
| Business Standard + Copilot Business | $23.50 | €20.36 | Bundle, paid yearly |
| Business Premium + Copilot Business | $32.00 | €27.73 | Bundle, paid yearly |
| Microsoft 365 E7 (Copilot included) | $99.00 | €91.92 | Paid yearly |

The [US enterprise page](https://www.microsoft.com/en-us/copilot/solutions/enterprise) shows "$30.00 user/month, paid yearly" and "Or $31.50 paid monthly (Annual commitment)". The [German enterprise page](https://www.microsoft.com/de-de/microsoft-365-copilot/enterprise) shows €26.00 per user per month, billed annually. It also offers monthly payments, but doesn't show a monthly euro price.

Which base plans qualify is listed in [License options for Microsoft Copilot](https://learn.microsoft.com/en-us/microsoft-365/copilot/microsoft-365-copilot-licensing) (updated September 17, 2026). For the enterprise add-on that's E7 (which already includes Copilot), E5, E3, F1, F3, the Business plans, Apps for Enterprise and for Business, Office 365 E5, E3, E1, and F3, the Teams plans, and standalone Exchange, SharePoint, OneDrive, Planner and Project, Visio, and Clipchamp plans.

What the license adds over free Chat is set out in the [enterprise pricing matrix](https://www.microsoft.com/en-us/copilot/pricing/enterprise): priority model access, Work IQ, and semantic indexing. Voice shows the difference well: "10 mins/day for Copilot Chat users; 60 mins/day for Microsoft 365 Copilot users."

### Copilot Business

Copilot Business is the license for companies with up to 300 users. Microsoft launched it in December 2025. The [launch post](https://www.microsoft.com/en-us/copilot/blog/2025/12/02/microsoft-365-copilot-business-the-future-of-work-for-small-businesses/) said: "For just USD 21 per user per month, Copilot Business brings…". It also offered bundle prices "for a limited time only (until June 30, 2026)".

A new discount now runs on the [business pricing page](https://www.microsoft.com/en-us/copilot/pricing/business): "This discount offer is available between July 1, 2026, and December 31, 2026." The [German page](https://www.microsoft.com/de-de/microsoft-365-copilot/pricing) gives the same dates, with Copilot Business at €18.20, discounted to €15.60.

Read the small print before you plan with the lower number. The discount is only for "existing Microsoft 365 customers with an eligible Business plan", and "promotional pricing applies to the first year only". If you buy at €15.60 today, you pay €18.20 from the second year. Eligible base plans, according to Learn, are Business Premium, Business Standard, Business Basic, Apps for Business, and Teams Essentials.

Copilot Business doesn't include any credits either. The pricing page also lists Cowork as "Metered" for Business customers.

### Microsoft 365 E7

Judson Althoff announced E7 on March 9, 2026, on the [Official Microsoft Blog](https://blogs.microsoft.com/blog/2026/03/09/introducing-the-first-frontier-suite-built-on-intelligence-trust/): "Microsoft 365 E7 unifies Microsoft 365 E5, Microsoft 365 Copilot and Agent 365". It became available "on May 1 for $99 per user". Agent 365 is also sold on its own, "on May 1 for $15 per user". E7 is "available with and without Teams."

The [E7 product page](https://www.microsoft.com/en-us/microsoft-365/enterprise/e7) shows $99.00 per user per month, with E5 next to it at $60.00. The [German E7 page](https://www.microsoft.com/de-de/microsoft-365/enterprise/e7) shows €91.92, with E5 at €58.13. The [German enterprise plans page](https://www.microsoft.com/de-de/microsoft-365/enterprise/microsoft365-plans-and-pricing) lists Agent 365 on its own at €13.00 per user per month. The July price change left E7 alone: "Microsoft 365 E7 pricing is not changing as part of this update."

E7 gives you the license, not a credit budget. Cowork, Code, and every other credit-based feature cost E7 users the same as they do for everyone else.

### The base plans went up on July 1, 2026

Microsoft announced this in December 2025 in [Advancing Microsoft 365: New capabilities and pricing update](https://www.microsoft.com/en-us/copilot/blog/2025/12/04/advancing-microsoft-365-new-capabilities-and-pricing-update/), and published the full tables in February 2026 in [Microsoft 365 Pricing and Packaging Updates](https://www.microsoft.com/en-us/licensing/news/2026-M365-Packaging-Pricing-Updates). The plans most Copilot customers sit on changed like this (list prices with Teams, per user per month, paid yearly). Microsoft published the before-and-after prices in dollars only. For Germany, I can only show today's price.

| Plan | US before | US from July 1, 2026 | Germany today |
|---|---|---|---|
| Microsoft 365 E3 | $36.00 | $39.00 | €37.78 |
| Microsoft 365 E5 | $57.00 | $60.00 | €58.13 |
| Business Basic | $6.00 | $7.00 | €6.07 |
| Business Standard | $12.50 | $14.00 | €12.13 |
| Business Premium | $22.00 | $22.00 | €19.06 |

The same page lists Office 365, frontline, and Apps plans. Copilot was left out on purpose: the [public FAQ](https://www.microsoft.com/en-us/licensing/news/2026-M365-Packaging-Pricing-Updates-FAQ) says the change "does not apply to standalone Microsoft Teams or Copilot SKUs." Existing customers keep their price until renewal. Part of the reasoning is new Copilot Chat features in the base plans, which the December post describes as "inbox and calendar awareness and access to Word, Excel, and PowerPoint agents".

## What people get without a license

Every eligible Microsoft 365 user has Copilot Chat. [Manage Microsoft Copilot Chat](https://learn.microsoft.com/en-us/copilot/manage) (updated September 24, 2026) says it is "available at no extra cost for eligible users".

It isn't the same as having a license, and users can see which one they have. The [Copilot Chat overview](https://learn.microsoft.com/en-us/copilot/overview) and the support article [What Copilot license do I have](https://support.microsoft.com/en-us/microsoft-365-copilot/what-copilot-license-do-i-have) describe three labels:

| Label shown to the user | What they get |
|---|---|
| Copilot Chat (Basic) | Chat, but no Copilot in Word, Excel, PowerPoint, and OneNote |
| Microsoft 365 Copilot (Basic) | Standard access to Copilot in those apps |
| Premium / Pro | A licensed Copilot user |

Learn adds that the in-app experience "might vary depending on your organization's licensing and tenant configuration".

Unlicensed users can still run up costs through agents. The E7 page footnote says: "An Azure subscription is required to use agents and is priced on a metered basis." The rate on [Meters for Microsoft Copilot pay-as-you-go services](https://learn.microsoft.com/en-us/microsoft-365/copilot/pay-as-you-go/meters) is "$0.01 per message". That page still uses the old word, but it's the same price as one Copilot Credit.

## How Copilot Credits work

A year ago, Copilot Studio counted "messages". [Standard harness licensing](https://learn.microsoft.com/en-us/microsoft-copilot-studio/billing-licensing) records the change: "Starting on September 1, 2025, the common currency for agents changed from messages to Copilot Credits." The price stayed the same.

Since then, credits have become the currency for much more than Copilot Studio. The [Copilot Credits Guide](https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/bade/documents/products-and-services/en-us/ai/Copilot-Credits-Guide-September-2026.pdf) (September 2026) says: "Copilot Credits serve as the common currency in this usage-based model." One pool per tenant pays for Cowork, Copilot Studio agents, Dynamics 365 agents, Power Platform features, and the Work IQ APIs.

You can buy them three ways.

| Option | Price | Commitment | Suits |
|---|---|---|---|
| Pay-as-you-go | $0.01 per credit | None; billed monthly via Azure | Getting started, uneven use |
| Pre-Purchase Plan (P3) | 5% to 20% off | One year, paid up front | Large, predictable use |
| Capacity pack | $200 (€173.30) per 25,000 credits a month | Billed annually | Existing Copilot Studio setups |

Both licensing guides give the pay-as-you-go rate as "Pricing: $0.01/Copilot Credit". The [Copilot Studio Licensing Guide, October 2026](https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/bade/documents/products-and-services/en-us/ai/Microsoft-Copilot-Studio-Licensing-Guide.pdf) prices the pack at "$200 per credit pack/month (billed annually)". Unused pack credits don't roll over. The [German Copilot Studio page](https://www.microsoft.com/de-de/microsoft-365-copilot/pricing/copilot-studio) shows €173.30 in its comparison table, while its FAQ leaves the pack price blank. The US page has the same gap.

Microsoft introduced the Pre-Purchase Plan on October 27, 2025, in [Scale your agent rollout with confidence](https://www.microsoft.com/en-us/copilot/blog/copilot-studio/scale-your-agent-rollout-with-confidence-introducing-copilot-credit-pre-purchase-plan/), as "a one-year, pay-up-front purchase option for Copilot Credits". It counts toward an Azure consumption commitment and renews automatically. The discount depends on how much you buy:

| Credits bought up front | Discount |
|---|---|
| 300,000 | 5% |
| 1,500,000 | 6% |
| 3,000,000 | 7% |
| 15,000,000 | 8% |
| 30,000,000 | 10% |
| 75,000,000 | 12% |
| 150,000,000 | 14% |
| 225,000,000 | 17% |
| 300,000,000 | 20% |

{: .caution }
You can't undo a pre-purchase. The [Cost Management page for Copilot Credit P3](https://learn.microsoft.com/en-us/azure/cost-management-billing/reservations/copilot-credit-p3) says: "All purchases are final." Unused credits expire at the end of the year, so size the plan on what you actually use, not on the discount.

Since February 2026, there is also an Agent Pre-Purchase Plan that covers Copilot Studio and Microsoft Foundry together. The September licensing guide: "Each ACU is worth $1 of Copilot Credit or Microsoft Foundry usage." It has three tiers: 20,000 units at 5%, 100,000 at 10%, and 500,000 at 15%.

## What uses credits

Spataro's sentence names Cowork, Code, Autopilot, and frontier models. Other Microsoft pages add a few more. This is everything I could confirm.

| Feature | Status | Source |
|---|---|---|
| Copilot Cowork | Generally available since June 16, 2026 | Cowork launch post |
| Code | Rolling out to Frontier program tenants | September 25 blog post |
| Autopilot (formerly Scout) | Private preview from end of September 2026 | September 25 blog post |
| Frontier models Astra and Fable | On usage-based billing | September 25 post, USL/UBB Learn page |
| Some Copilot in SharePoint features: image generation and editing, advanced autofill, site analytics | Credits rolling out with general availability, which started September 30, 2026 | SharePoint blog, USL/UBB Learn page |
| Work IQ APIs | Nothing included in the license | Credits Guide |
| Computer use in agents | Not included in the license | Billing rates Learn page |
| Apps built in Copilot Studio | Paid public preview | Copilot Studio Licensing Guide |

### Copilot Cowork

Cowork was the first major Copilot feature that the license alone doesn't cover. It started as a research preview in March and became generally available on June 16, 2026. The [launch post](https://www.microsoft.com/en-us/copilot/blog/2026/06/16/copilot-cowork-is-now-generally-available/) says it is "billed on a usage basis, denominated in Copilot Credits", and the June 2026 edition of the Credits Guide adds: "No Cowork entitlements are included with the Microsoft 365 Copilot subscription." So each Cowork user needs a license and credits.

A task's cost depends on the model, how much context it pulls in, how many tools it calls, and how long it runs. Microsoft gives rough examples:

| Task | Credits (Microsoft's examples) | At $0.01 per credit |
|---|---|---|
| Light | 70–200 | $0.70–$2.00 |
| Medium | 400–600 | $4.00–$6.00 |
| Heavy | about 1,500 | about $15.00 |

Your own tasks won't match these exactly, but they give you the order of magnitude. Frontier program tenants had a grace period and were "not billed until July 1, 2026". Cowork ships switched off ("Cowork is off by default"), and admins can set spending limits for the whole tenant, for groups, and for individual users.

{: .note }
The pricing page line "Available via Frontier program, pricing final upon GA" refers to App Builder and Workflows agents, not to Cowork. Cowork's billing is already final.

### Code and Autopilot

Code lets anyone build small apps, dashboards, and automations. The September 25 post says "Code is rolling out to Frontier at the end of the month, with broad availability in the coming weeks", and that it "will be in preview for Microsoft 365 Premium and Pro subscribers later this year."

Autopilot is "a persistent, proactive and personal agent that keeps working even when you're not". According to the post, "Autopilot is expanding to private preview at the end of the month."

Both use credits from day one. Both are built to run longer than a typical Cowork task, so I expect they'll end up as the bigger items on the bill. That's my view, not something Microsoft has said.

## Copilot Studio agents: included or billed?

This is the question I get asked most. A licensed Copilot user talks to a Copilot Studio agent. Who pays for it?

Often nobody, as long as usage stays within limits. The [billing rates page](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-messages-management) lists employee-facing use as "No charge" when the user has a Copilot license, and the agent runs under that user's identity, with the note "Usage is limited to fair usage limits." [Standard harness licensing](https://learn.microsoft.com/en-us/microsoft-copilot-studio/billing-licensing) says that for licensed users in Copilot Chat, Teams, and SharePoint, "classic answers, generative answers, or Microsoft Graph tenant grounding have zero-rated usage". Zero-rated means they cost no credits.

The trouble is in the exceptions. An agent uses credits when:

* **A flow starts on its own.** Free runs apply "only to runs triggered via the 'When an agent calls the flow' trigger". A flow started by a schedule or an event is billed.
* **It gives generative answers outside Agent Builder.** They're billed "unless the agent is created in Agent Builder in Microsoft 365" and don't use tenant graph grounding.
* **It uses computer use.** "Computer-Using Agents (CUA) usage is not included in the Microsoft 365 Copilot USL."
* **It calls APIs.** The [business pricing page](https://www.microsoft.com/en-us/copilot/pricing/business): "Does not include cost of API calls, including Work IQ API calls."
* **It uses Work IQ.** The September 2026 Credits Guide: "Work IQ APIs are not included as entitlements in the Microsoft Copilot license." The Tools API costs 0.1 credits per call. The Chat and Context APIs vary by query; the June edition gave examples ranging from 20 to 150 credits per query. Work IQ used inside Copilot itself (chat, the Office apps, Researcher, Analyst, Facilitator) carries no extra charge. The older Retrieval API and Chat API stay free for licensed users, and the guide says, "This licensing model will continue for now." I wouldn't count on that lasting.
* **It's built on the GitHub Copilot harness.** Copilot Studio now has three harnesses (Copilot Chat, Standard, GitHub Copilot). The GitHub one "Requires Copilot Credits for LLM-powered maker experiences", even while you're still building.
* **The user has no license.** All of the free rules above apply to licensed users only.

{: .tip }
Before anyone promises a business unit that "agents are included with Copilot", go through each agent's triggers, tools, channels, and users. Scheduled flows, computer use, Work IQ calls, the GitHub harness, and unlicensed users all cost credits.

### What a Copilot Studio agent costs per action

When an agent does use credits, [Billing rates and management](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-messages-management) (updated August 3, 2026) sets the rates. These are for the Standard harness.

| Action | Copilot Credits |
|---|---|
| Classic answer | 1 |
| Generative answer | 2 |
| Agent action | 5 |
| Tenant graph grounding | 10 |
| Agent flow actions | 13 per 100 actions |
| AI tools, basic / standard / premium | 1 / 15 / 100 per 10 responses |
| Content processing | 8 per page |
| Voice, classic / GenAI / premium GenAI | 10 / 35 / 75 per minute |

The same page has four more rules that change the result:

* Reasoning models cost extra: "Total cost = feature rate for the operation + text and generative AI tools (premium)", and the premium rate is 10 credits per 1,000 tokens.
* Computer use is charged at the agent action rate.
* Your own models are billed separately: the rates "exclude bring-your-own-model configurations, including Azure Foundry models".
* Prepaid capacity has a hard limit: "Enforcement is triggered when a tenant reaches 125% of their prepaid capacity." Custom agents then stop, and agent flows are blocked once capacity runs out.

### Copilot Studio licenses

If you buy capacity packs, each pack is the tenant license: $200 for 25,000 credits a month. On top of that, "A Copilot Studio User License ($0) is required for each user that builds" agents, and Learn says you first need "a Copilot Studio tenant prepaid Copilot Credit pack subscription". If you pay as you go or pre-purchase instead, makers don't need a user license. They need the "Copilot Studio Author role", a free security group in the Power Platform admin center.

The September guide's change log lists a few more changes:

* three harnesses since August 2026, with the standalone Copilot Studio license adding the GitHub harness, external channels, and users without a Copilot license;
* "Default Dataverse Database capacity increased from 5 GB to 15 GB" in December 2025;
* Managed Environments included in the "Copilot Studio for Microsoft Copilot license", "only for features related to Copilot Studio";
* Apps built in Copilot Studio in paid public preview since September 2026, "billed through Copilot Credits".

## Announced, but not yet dated

Several changes from September 25 still have no firm date.

**Usage limits on the license.** The Learn page describes users who "Reach usage limits in the USL (coming soon)". They'll see a notice as they approach the limit. After the limit, "they have the option to continue with UBB by consuming Copilot Credits or, if applicable, reroute to Auto to continue their work." The same page says some models are "included with fair use, such as GPT 5.6 and Sonnet, and others included with limits, such as Opus."

{: .warning }
There's no date for the usage limits yet. When they arrive, part of what people do today at the flat license price will start costing credits. If you budget for 2027 now, leave room for that.

**Better cost controls.** The blog says cost management in Agent 365 "is expanding beyond Cowork and Work IQ APIs to include Code and Copilot Managed Runtime, with support for agents built in Microsoft Copilot Studio planned for October." Admins get more control over spending policies and model choice, and users can see their own credit balance in Copilot. I'll go through these in the next post.

**New services join your billing policy automatically.** [Usage-Based Billing and Cost Management for Copilot Credits](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-overview-copilot-credits) says: "The Auto-apply new services setting is enabled by default". When Microsoft moves another feature onto credits, it can start using your budget without anyone deciding it should.

**Partner purchases.** Microsoft has moved this date. New Copilot Business licenses bought through a CSP partner will have pay-as-you-go credits switched on from December 1, 2026, not November 2 as first announced. The [Partner Center announcement for October 2026](https://learn.microsoft.com/en-us/partner-center/announcements/2026-october) adds two details. The default limit is "4,000 Copilot Credits per user per month", which admins can change. That's up to $40 per user per month at the pay-as-you-go rate. And the change "will initially not be available" in several markets, including Germany, France, Italy, Spain, and the Netherlands.

**Ignite.** Microsoft points to Ignite, November 17–20, 2026, for the next round of news. Prices may move again after that.

## Before the next budget round

Prices alone won't give you a budget, but they will help you make a few decisions now.

1. **Plan two budgets.** One for base plans and Copilot licenses, fixed per user. One for credits, which depend on usage. If you bought Copilot Business at the discount, use the full price from year two.
2. **Decide who owns the credit budget.** Microsoft suggests business units. Agree on it before anyone switches on Cowork, Code, or Autopilot.
3. **Don't pre-purchase yet.** Pay as you go for a few months, then buy a Pre-Purchase Plan based on real numbers. The purchase is final.
4. **Buying through a partner?** Talk to them before December 1, 2026, about how pay-as-you-go will be set up for new Copilot Business licenses, and agree whether the default limit of 4,000 credits per user per month suits you.

The price list only tells you what you could pay. What you actually pay depends on how you run things, and that's what the next post in this series covers: where each of these costs appears, which admin center shows it, how to set billing policies and spending limits, how to charge costs back to the teams that cause them, and what to do once Microsoft puts a date on the usage limits.

## Sources

- Official Microsoft Blog, [Introducing the new Copilot with Home, Code and Autopilot](https://blogs.microsoft.com/blog/2026/09/25/introducing-the-new-copilot-with-home-code-and-autopilot/), September 25, 2026: the license and usage-based billing split, Code and Autopilot timelines, cost management expansion, admin and user controls, Ignite dates
- Microsoft Learn, [Understanding the user subscription license (USL) and usage-based billing (UBB)](https://learn.microsoft.com/en-us/microsoft-365/copilot/user-subscription-license-usage-based-billing), last updated September 25, 2026: everyday and advanced AI, UBB requires a USL, billing policy requirement, funding by business units, usage limits "coming soon", model inclusion
- Microsoft Learn, [Usage-Based Billing and Cost Management for Copilot Credits](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-overview-copilot-credits), last updated September 25, 2026: auto-apply setting
- Microsoft, [Microsoft Copilot Plans and Pricing – AI for Business](https://www.microsoft.com/en-us/copilot/pricing/business), read October 1, 2026: Copilot Business prices, discount terms, bundles, Cowork "Metered", API calls excluded
- Microsoft Germany, [Microsoft 365 Copilot for business, German page](https://www.microsoft.com/de-de/microsoft-365-copilot/pricing), read October 2, 2026: euro prices for Copilot Business and bundles, discount dates, prices excluding VAT
- Microsoft, [Microsoft Copilot Plans and Pricing – Enterprise](https://www.microsoft.com/en-us/copilot/pricing/enterprise), read October 1, 2026: feature matrix, voice limits
- Microsoft, [AI for Enterprise Productivity - Microsoft Copilot](https://www.microsoft.com/en-us/copilot/solutions/enterprise), read October 1, 2026: $30.00 and $31.50 prices, qualifying plan requirement
- Microsoft Germany, [Microsoft 365 Copilot for enterprise, German page](https://www.microsoft.com/de-de/microsoft-365-copilot/enterprise), read October 1, 2026: €26.00 price, no monthly euro price shown
- Microsoft Germany, [Copilot Studio pricing, German page](https://www.microsoft.com/de-de/microsoft-365-copilot/pricing/copilot-studio), read October 1, 2026: €173.30 in the comparison table, pack price missing in the FAQ
- Microsoft Learn, [License options for Microsoft Copilot](https://learn.microsoft.com/en-us/microsoft-365/copilot/microsoft-365-copilot-licensing), last updated September 17, 2026: eligible base plans
- Microsoft Learn, [Manage Microsoft Copilot Chat](https://learn.microsoft.com/en-us/copilot/manage), last updated September 24, 2026: rename to Microsoft Copilot, Copilot Chat at no extra cost
- Microsoft Learn, [Overview of Microsoft Copilot Chat](https://learn.microsoft.com/en-us/copilot/overview), last updated September 10, 2026: the three Copilot labels
- Microsoft Support, [What Copilot license do I have](https://support.microsoft.com/en-us/microsoft-365-copilot/what-copilot-license-do-i-have), April 2026: the three Copilot labels
- Microsoft Learn, [Meters for Microsoft Copilot pay-as-you-go services](https://learn.microsoft.com/en-us/microsoft-365/copilot/pay-as-you-go/meters), last updated August 18, 2026: $0.01 rate for agents in Copilot Chat
- Microsoft Learn, [Standard harness licensing – Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/billing-licensing), last updated August 3, 2026: messages renamed to credits, zero-rated usage, user license prerequisite
- Microsoft Learn, [Billing rates and management – Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-messages-management), last updated August 3, 2026: rates per action, reasoning surcharge, computer use, 125% limit, free use for licensed users
- Microsoft, [Microsoft Copilot Studio Licensing Guide – October 2026](https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/bade/documents/products-and-services/en-us/ai/Microsoft-Copilot-Studio-Licensing-Guide.pdf), October 2026: pack price, pre-purchase tiers, Agent Pre-Purchase Plan, $0 user license, Author role, harnesses, change log
- Microsoft, [Copilot Credits Guide – September 2026](https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/bade/documents/products-and-services/en-us/ai/Copilot-Credits-Guide-September-2026.pdf), September 2026: credits as common currency, pay-as-you-go rate, pre-purchase tiers, Work IQ not included in the license, Tools API rate, no extra charge for Work IQ inside Copilot
- Microsoft, [Copilot Credits Guide – June 2026](https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/bade/documents/products-and-services/en-us/ai/Microsoft-Copilot-Credits-Guide-June-16-2026-PUB.pdf), June 2026: no Cowork entitlement in the license, Cowork and Work IQ example credit ranges
- Microsoft Learn, [Copilot Credit P3 – Microsoft Cost Management](https://learn.microsoft.com/en-us/azure/cost-management-billing/reservations/copilot-credit-p3), last updated July 17, 2026: purchases are final, expiry at end of term
- Microsoft Copilot Blog, [Scale your agent rollout with confidence: Introducing Copilot Credit Pre-Purchase Plan](https://www.microsoft.com/en-us/copilot/blog/copilot-studio/scale-your-agent-rollout-with-confidence-introducing-copilot-credit-pre-purchase-plan/), October 27, 2025: introduction of the Pre-Purchase Plan
- Microsoft Copilot Blog, [Microsoft 365 Copilot Business: The future of work for small businesses](https://www.microsoft.com/en-us/copilot/blog/2025/12/02/microsoft-365-copilot-business-the-future-of-work-for-small-businesses/), December 2, 2025: launch and $21 price, bundle offer until June 30, 2026
- Microsoft Copilot Blog, [Advancing Microsoft 365: New capabilities and pricing update](https://www.microsoft.com/en-us/copilot/blog/2025/12/04/advancing-microsoft-365-new-capabilities-and-pricing-update/), December 4, 2025, updated March 18, 2026: announcement of the July 1, 2026 price change, Copilot Chat features
- Microsoft Germany, [Microsoft 365 Enterprise plans and pricing, German page](https://www.microsoft.com/de-de/microsoft-365/enterprise/microsoft365-plans-and-pricing), read October 2, 2026: E3 €37.78, E5 €58.13, Agent 365 €13.00
- Microsoft Germany, German pages for [Business Basic (plan comparison)](https://www.microsoft.com/de-de/microsoft-365/business/microsoft-365-plans-and-pricing), [Business Standard](https://www.microsoft.com/de-de/microsoft-365/business/microsoft-365-business-standard), and [Business Premium](https://www.microsoft.com/de-de/microsoft-365/business/microsoft-365-business-premium), read October 1, 2026: €6.07, €12.13, and €19.06
- Microsoft Licensing, [Microsoft 365 Pricing and Packaging Updates](https://www.microsoft.com/en-us/licensing/news/2026-M365-Packaging-Pricing-Updates), February 16, 2026: old and new base plan prices, effective date
- Microsoft Licensing, [Microsoft 365 Packaging and Pricing Updates Public FAQ](https://www.microsoft.com/en-us/licensing/news/2026-M365-Packaging-Pricing-Updates-FAQ), March 24, 2026: Copilot excluded, E7 unchanged, prices kept until renewal
- Official Microsoft Blog, [Introducing the First Frontier Suite built on Intelligence + Trust](https://blogs.microsoft.com/blog/2026/03/09/introducing-the-first-frontier-suite-built-on-intelligence-trust/), March 9, 2026: E7 contents and price, Agent 365 at $15, Cowork research preview
- Microsoft, [Microsoft 365 E7 for Enterprise](https://www.microsoft.com/en-us/microsoft-365/enterprise/e7) and [German page](https://www.microsoft.com/de-de/microsoft-365/enterprise/e7), read October 1, 2026: $99.00 and €91.92 prices, E5 at $60.00 and €58.13, metered agents footnote
- Microsoft Copilot Blog, [Copilot Cowork is now generally available](https://www.microsoft.com/en-us/copilot/blog/2026/06/16/copilot-cowork-is-now-generally-available/), June 16, 2026: general availability, credit billing, example task costs, grace period, off by default
- Microsoft Learn, [What's new in Copilot Cowork](https://learn.microsoft.com/en-us/microsoft-365/copilot/cowork/whats-new), last updated September 25, 2026: model change at launch
- Microsoft Learn, [October 2026 announcements – Partner Center](https://learn.microsoft.com/en-us/partner-center/announcements/2026-october), last updated October 1, 2026: pay-as-you-go default for new CSP Copilot Business licenses moved to December 1, 2026, default limit of 4,000 credits per user per month, markets where it starts later
- Microsoft SharePoint Blog, [What's new in Copilot in SharePoint: October 2026](https://techcommunity.microsoft.com/blog/spblog/what%E2%80%99s-new-in-copilot-in-sharepoint-october-2026/4535423), October 1, 2026: general availability from September 30, 2026, image generation and editing, advanced autofill, and site analytics use Copilot Credits

## Changelog

| Date | Change |
|---|---|
| October 2, 2026 | Rev1. Renamed to "Understanding Microsoft Copilot Licensing - Rev1" and described as a living series. Partner (CSP) pay-as-you-go default moved from November 2 to December 1, 2026, with a default limit of 4,000 credits per user per month and a later start in Germany and other markets. Added the Copilot in SharePoint features that use credits. Sources moved to the Copilot Studio Licensing Guide (October 2026) and the Copilot Credits Guide (September 2026). Prices re-checked on the US and German pages: no changes. Removed the series intro at the top. |
| October 3, 2026 | First published. Prices checked against Microsoft's US and German pages on October 1, 2026. |

