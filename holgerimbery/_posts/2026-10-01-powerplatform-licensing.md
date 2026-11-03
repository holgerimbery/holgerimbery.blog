---
layout: post
title: "Understanding Microsoft Power Platform Licensing Rev.7"
description: A practitioner's reference for Power Platform core, Copilot Studio, Dataverse, Dynamics 365 Contact Center, and Dynamics 365 Customer Service.
date: 2026-11-01
author: admin
slug: powerplatform-licensing
canonical_url: https://holgerimbery.blog/powerplatform-licensing
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/05/andre-taissin-5OUMf1Mr5pU-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@andretaissin?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Andre Taissin</a> on <a href="https://unsplash.com/photos/pink-pig-coin-bank-on-brown-wooden-table-5OUMf1Mr5pU?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
"\r": null
tags:
  - agents
  - copilotstudio
  - dataverse
  - dynamics365contactcenter
  - dynamics365customerservice
  - licensing
  - powerplatform
featured: true
toc: true
---



{: .q-left }
> This article is updated frequently and reflects the latest changes in Power Platform licensing, including Dataverse capacity, Copilot Studio credits, and Dynamics 365 Contact Center bundles. There is a changelog at the end of the article that records the latest three revisions.
  
{: .note }
**Scope.** This article covers Power Apps, Power Automate, Power Pages, Microsoft Copilot Studio, Microsoft Dataverse, Dynamics 365 Contact Center, and Dynamics 365 Customer Service. The following are deliberately out of scope and are NOT addressed: Power BI (separate Pro / PPU / Premium licensing model), Dynamics 365 Sales, Field Service, Business Central, Finance, Supply Chain Management, Project Operations, Commerce, Customer Insights – Data, Customer Insights – Journeys, Industry Clouds, and Microsoft Fabric. Government cloud SKUs (GCC, GCC High, DoD), Education (A-SKUs), and Nonprofit pricing are referenced only briefly in §6.

---

## 1. Power Platform (Core)

### 1.1 Power Apps

Power Apps in 2026 has three commercial purchase paths and one free developer path.

| SKU | List price (USD) | Entitlement |
|-----|------------------|-------------|
| **Power Apps Premium** (per user) | **$20 / user / month** → **$22** (Jan 1, 2027) | Unlimited custom canvas + model-driven apps and Power Pages portals (run-time). Includes Premium connectors, custom connectors, on-prem data gateway, and **250 MB Dataverse database + 2 GB Dataverse file accrued capacity per user**, as shown on the live Power Apps pricing page and confirmed in the October 2026 Power Platform Licensing Guide (Accrued column). The 20 GB figure sometimes quoted is the tenant-wide **default**, not per-user accrual — see §3.1–§3.2. Per the October 2026 guide, use of apps built in Copilot Studio (Paid Public Preview) and of Copilot Cowork (Frontier) is also included, subject to Power Apps Premium request limits; hosting and AI runtime consume Copilot Credits (see §2.0). |
| **Power Apps Premium** (volume tier) | **$12 / user / month** → **$14** (Jan 1, 2027) | Same entitlement as Power Apps Premium, available with a **2,000-seat minimum** (live pricing page). The October 2026 Power Platform Licensing Guide words this as **2,000+ new per-user licenses**. (Earlier revisions tied this tier to 2,000+ Microsoft 365 licenses, which the guide does not say.) |
| **Power Apps per App** (subscription license) | **End of Sale — January 2026** | The per-App *subscription* license is no longer sold (Power Platform Licensing Guide change log, January 2026). Existing customers may renew per Microsoft's transition terms; new per-app scenarios use the pay-as-you-go meter below. |
| **Power Apps Pay-as-you-go** | **$10 per active user per app / month** | Consumption-billed through an Azure subscription. An "active user" is any user who launches the app within a calendar month. |
| **Power Apps Developer Plan** | Free | Build/test against a personal developer environment; no production rights. |

Sources: [Power Apps pricing](https://www.microsoft.com/en-us/power-platform/products/power-apps/pricing), [Power Platform Licensing Guide October 2026 (PDF)](https://go.microsoft.com/fwlink/?linkid=2085130).

{: .important }
**Upcoming price change — Power Apps Premium (effective January 1, 2027).** On September 9, 2026 Microsoft announced the first Power Apps Premium list-price increase in more than five years: **Power Apps Premium rises from $20 to $22/user/month**, and the **2,000-seat volume tier from $12 to $14/user/month**. Only these two SKUs change — all other Power Platform products, and all Power Apps entitlements seeded through Microsoft 365 / Dynamics 365, are unchanged, and no entitlements are removed. Existing subscriptions keep their current price through the end of their term; the new price applies to new purchases, renewals, and co-terminations beginning on or after January 1, 2027 (U.S. Government increases are capped at 10%/year and phased). Microsoft adds that the new prices apply to monthly and annual billing alike, that nonprofit and education prices move in line, and that the pricing page, price list, and licensing guide will show the new figures from January 1, 2027. The $20 / $12 prices in the table above remain in effect until then ([Microsoft announcement](https://www.microsoft.com/en-us/licensing/news/power-apps-premium-price-update)).

**Per-App SKU status flag (resolved).** The **August 2026 Power Platform Licensing Guide change log confirms the Power Apps per App *subscription* license reached End of Sale in January 2026.** What remains on the price list is the **Power Apps per app pay-as-you-go meter at $10 per active user/app/month** (an "active user" is anyone who opens the app one or more times in a calendar month). Per-app economics are therefore still available — as consumption billing, not a fixed subscription. Model role-segmented app usage on the $10 meter, and choose Power Apps Premium ($20, or $12 with a 2,000-seat minimum) when most users run most apps. The October 2026 guide still lists Power Apps Premium as the only Power Apps subscription, with the per app meter as the pay-as-you-go option.

#### Standard vs Premium connectors — the core licensing fault line

Microsoft splits its 1,500+ certified connectors into two classes, enforced both at the connection-add step and at runtime ([connector reference](https://learn.microsoft.com/en-us/connectors/connector-reference/)):

- **Standard connectors** — included with any Microsoft 365 / Office 365 commercial plan. Examples: SharePoint, Outlook 365, OneDrive for Business, Teams, Excel Online Business, Planner, Dataverse for Teams.
- **Premium connectors** — require a paid Power Apps / Power Automate license, a per-app pass, or PAYG. Examples: **SQL Server, Azure SQL, Dataverse (full), HTTP, all custom connectors, all third-party SaaS connectors** (Salesforce, SAP, Oracle, ServiceNow, Workday, Zendesk).

The moment an app or a flow touches one Premium connector, every user of that app or flow needs a Premium license. There is no "occasional use" carve-out.

#### Seeded Microsoft 365 / Office 365 entitlements

Every commercial M365 plan (Business Basic/Standard/Premium, E3, E5, F3, A3, A5, G3, G5) grants:

- **Power Apps for Office 365** — build/run canvas apps using **Standard connectors only**; no access to full Dataverse.
- **Power Automate for Office 365** — cloud flows using Standard connectors only, with **6,000 API requests per user per 24 hours** ([API request limits and allocations](https://learn.microsoft.com/en-us/power-platform/admin/api-request-limits-allocations)).

These rights specifically exclude full Dataverse, all Premium and custom connectors, the on-prem data gateway, and AI Builder.

**Microsoft 365 F-series caveat.** F1 and F3 (Frontline) plans grant *reduced* seeded Power Platform rights compared with E3/E5: F1 has effectively no app-authoring entitlement, and F3 includes canvas + Standard connectors with tighter API limits. Architects planning frontline-worker deployments cannot assume the same entitlements that appear in E-series guidance.

#### Real-world example — Premium vs per App

A 500-employee manufacturer deploys three line-of-business Power Apps (HSE incident reporting, plant visitor management, asset-walk inspection), each connecting to Dataverse and Azure SQL.

- **Premium path:** 500 × $20 = **$10,000 / month**. Every user can run all three apps and any future apps. For new purchases and renewals from January 1, 2027 this becomes 500 × $22 = **$11,000 / month**.
- **Per app pay-as-you-go path ($10 per active user per app per month):** three apps × $10 × 500 = **$15,000 / month** if every user opens every app each month. If usage is segmented (200 users on HSE, 300 on visitor management, 100 on asset-walk), the math becomes (200 + 300 + 100) × $10 = **$6,000 / month**. (Earlier revisions used the retired $5 per app subscription.)

**Rule of thumb:** Premium wins when most users run most apps. The per app meter wins when usage is role-segmented and the user count per app is well below the total workforce.

### 1.2 Power Automate

| SKU | List price (USD) | Entitlement |
|-----|------------------|-------------|
| **Power Automate Premium** (per user) | **$15 / user / month** | Unlimited cloud flows with Premium connectors, **one attended RPA bot** (desktop flow in attended mode), Process Mining desktop app with 50 MB of process mining data storage per user (pooled up to 100 GB per tenant). Seeded AI Builder credits are no longer granted on new or renewed licenses from November 1, 2026 (see §2.2.1). 40,000 API requests / user / 24 h. |
| **Power Automate Process** (per flow / per bot) | **$150 / bot or flow / month** | One unattended RPA bot OR one cloud flow that any user in the org may trigger. Service-account license for shared automations. |
| **Power Automate Hosted Process** | **$215 / bot / month** | Microsoft-hosted Windows VM for unattended desktop flows — no on-prem machine required. Includes one Process license. |
| **Power Automate Pay-as-you-go** | **$0.60 per premium cloud flow run or attended desktop flow run; $3.00 per unattended desktop flow run or hosted RPA run** | Azure-billed, in preview per Microsoft Learn. Flows that use only Standard connectors are not charged. Suitable for low-frequency, high-variance workloads. |
| **Process Mining add-on** | **$5,000 / tenant / month** | 100 GB of process mining data stored per tenant per month. Add-on to Power Automate Premium only. Accrues 2 GB Dataverse database and 1 TB Dataverse file capacity. |

Sources: [Power Automate pricing](https://www.microsoft.com/en-us/power-platform/products/power-automate/pricing), [Power Platform Licensing Guide October 2026](https://go.microsoft.com/fwlink/?linkid=2085130), [Pay-as-you-go meters (Microsoft Learn)](https://learn.microsoft.com/en-us/power-platform/admin/pay-as-you-go-meters). Power Automate Premium ($15/user/month) and Process ($150/bot/month) are confirmed in the October 2026 guide.

#### Real-world example — Process vs Hosted Process

A finance team runs an unattended nightly bot that reconciles bank statements with ERP entries. The bot runs on a corporate VDI that is patched weekly, resulting in 1–2 missed runs per month. Moving to **Hosted Process at $215 / bot / month** eliminates the VDI dependency and adds Microsoft-managed patching, RDP brokering, and elastic capacity. ROI breaks even at one prevented missed reconciliation per month.

### 1.3 Power Pages

Power Pages (the renamed Power Apps Portals) is licensed by **monthly active users (MAU) per site**. A MAU is a unique identity that loads any Power Pages page within a calendar month. Authenticated MAUs sign in (Entra ID, Entra External ID / B2C, Microsoft account, LinkedIn, etc.); anonymous MAUs are unauthenticated public visitors. Search-engine crawlers are not counted ([Power Pages capacity licensing](https://learn.microsoft.com/en-us/power-pages/admin/about-capacity-licensing)).

| SKU | List price (USD) | Entitlement |
|-----|------------------|-------------|
| **Authenticated Users capacity pack** | **$200 / pack / month** (Tier 1, from 1 pack); **$75** (Tier 2, from 100 packs); **$50** (Tier 3, from 1,000 packs) | 100 authenticated MAUs / site / month per pack. Accrues 2 GB Dataverse database, 16 GB file, and 1 GB log capacity per pack. Unused capacity does not carry over to the next month. |
| **Anonymous Users capacity pack** | **$75 / pack / month** (Tier 1, from 1 pack); **$37.50** (Tier 2, from 20 packs); **$25** (Tier 3, from 200 packs) | 500 anonymous MAUs / site / month per pack. Accrues 500 MB Dataverse database, 4 GB file, and 250 MB log capacity per pack. Unused capacity does not carry over to the next month. |
| **Power Pages PAYG** | **$4 / authenticated MAU / site; $0.30 / anonymous MAU / site** | Azure-billed; no monthly minimum. Capacity packs cannot be used in a pay-as-you-go environment. |

Sources: [Power Pages pricing](https://www.microsoft.com/en-us/power-platform/products/power-pages/pricing), [Power Platform Licensing Guide October 2026 (PDF)](https://go.microsoft.com/fwlink/?linkid=2085130) (volume tiers and capacity accrual), [Pay-as-you-go meters (Microsoft Learn)](https://learn.microsoft.com/en-us/power-platform/admin/pay-as-you-go-meters).

#### Real-world example — Power Pages MAU math

A municipality launches a citizen-permit portal expected to draw **8,000 anonymous monthly active users** (unique visitors who load any page in the month) and **2,400 authenticated MAUs** (unique citizens who sign in to file a permit application).

- Capacity packs: 16 × Anonymous (16 × 500 = 8,000 anon MAU, $75 × 16 = $1,200) + 24 × Authenticated (24 × 100 = 2,400 auth MAU, $200 × 24 = $4,800) = **$6,000 / month**. Both pack counts sit below the Tier 2 thresholds, so Tier 1 prices apply.
- PAYG: 8,000 × $0.30 + 2,400 × $4 = **$12,000 / month**.

Capacity packs win at steady volumes; PAYG wins for unpredictable spikes. Note that an authenticated MAU is a *unique signed-in identity per month*, not a session or a page view — repeat visits by the same citizen do not increment the count.

### 1.4 Tenant environment and API entitlements

- **Default environment.** Each tenant receives one default environment provisioned with **3 GB Dataverse database, 3 GB file, and 1 GB log** capacity ([Dataverse capacity storage](https://learn.microsoft.com/en-us/power-platform/admin/capacity-storage)). Production and sandbox environments draw from the tenant Dataverse pool. No hard cap on environment count, but each consumes from the shared pool ([environments overview](https://learn.microsoft.com/en-us/power-platform/admin/environments-overview)).
- **Developer environment.** Every user with any seeded or paid license automatically receives a personal developer environment.
- **API request entitlements** (per user per 24h, with overage pooled at tenant level): Premium Power Apps / Premium Power Automate / D365 Enterprise users get **40,000 requests / user / 24 h**; per-App users get **6,000**; Microsoft 365–seeded users get **6,000 / user / 24 h** for Standard-connector usage. Excess returns HTTP 429 but does not auto-bill; the **Power Platform Requests add-on** raises the tenant limit by 50,000 requests / 24 h ([API request limits and allocations](https://learn.microsoft.com/en-us/power-platform/admin/api-request-limits-allocations)).

**When the Requests add-on actually matters.** High-volume Power Automate scenarios are typically triggered by child-flow fan-out patterns, integration flows polling HTTP endpoints on a short cadence, large-scale Dataverse data movement, and any flow making many connector calls per run. If your monitoring shows users approaching the daily cap or HTTP 429s in the flow run history, the add-on is the supported answer.

### 1.5 Managed Environments and Governance Licensing

**Managed Environments** is Microsoft's governance overlay for Power Platform environments — it surfaces DLP enforcement, sharing limits, weekly digests, Power Platform Pipelines, solution checker enforcement, and "Maker welcome content." Managed Environments has **no separate SKU price**, but it gates feature access by *user-license type*: every user accessing a Managed Environment must hold a **Power Apps Premium**, **Power Automate Premium**, **Power Pages**, or qualifying **Dynamics 365** license ([about Managed Environments](https://learn.microsoft.com/en-us/power-platform/admin/managed-environment-overview)).

The practical consequence: a tenant that adopted Managed Environments for governance reasons cannot mix-and-match M365-seeded users into the same environment. This is the most common reason a sizing exercise sized for "Premium for makers, M365 seeded for everyone else" needs to be re-priced upward.

### 1.6 Trial, Developer, and non-production licenses

- **30-day trials** are available for Power Apps Premium and Power Automate Premium. Trials convert to paid via the Microsoft 365 admin center or your CSP / EA channel.
- **Power Apps Developer Plan** (free) replaces the retired Power Apps Community Plan. It provides a personal developer environment for build/test, with **no production rights and no commercial use**. Each user with any paid or seeded license is automatically entitled to a developer environment ([Developer Plan](https://powerapps.microsoft.com/en-us/developerplan/)).
- **Dynamics 365 30-day trials** are available for each base SKU. Customer Service Premium and Contact Center trials are tenant-bound; voice channel usage during trial incurs ACS pass-through charges if a phone number is provisioned.

---

## 2. Microsoft Copilot Studio

Copilot Studio is licensed by **Copilot Credit consumption**, which replaced the legacy "message" terminology on September 1, 2025. Credits pool at the tenant level and are consumed FIFO across **all Copilot Studio agents, all environments, and bundled Dynamics 365 AI agents**. Microsoft documentation consistently references the Contact Center and Customer Service AI agents (Customer Intent, Customer Knowledge, Quality Evaluation) as drawing from the same credit pool.

### 2.0 Build harnesses and apps (October 2026 guide)

The October 2026 Copilot Studio Licensing Guide keeps the **three "harnesses"** — the software scaffolding an agent uses to plan, reason, keep context, and call tools — and now also lets makers build **apps** (not just agents) in Copilot Studio. The harness a maker chooses affects **when** Copilot Credits are consumed:

| Harness | What it's for | Credit consumption |
|---------|---------------|--------------------|
| **GitHub Copilot harness** | Optimize end-to-end business processes with an agentic build experience; **the only harness that also builds apps in Copilot Studio** | Consumes Copilot Credits at **both build/maker time and runtime** (app authoring billed by complexity and amount of generation/iteration) |
| **Standard harness** | Rule-based conversational agents with predefined topics, flows, and workflows | LLM-powered maker features consume credits; runtime billed via Copilot Credits (fair-usage limits apply in Microsoft channels) |
| **Copilot Chat harness** | Customize Microsoft 365 Copilot with your organization's knowledge | LLM-powered maker features consume credits; runtime billed via Copilot Credits (fair-usage limits apply in Microsoft channels) |

Manual, non-LLM configuration does **not** consume credits; natural-language authoring, Evaluation, and Preview do. For Microsoft 365 Copilot USL holders, employee-facing (B2E) runtime of **Standard** and **Copilot Chat** harness agents in Microsoft channels is included in the USL and does not require a Copilot Credit purchasing option to be configured; **GitHub Copilot** harness runtime always consumes credits. (Source: Copilot Studio Licensing Guide, October 2026.)

{: .note }
**New in September 2026 — Apps in Copilot Studio (Paid Public Preview).** Makers can now build **apps** (not only agents) in Copilot Studio, using the **GitHub Copilot harness**. Apps are deployed to the new **Copilot Managed Runtime Host** — a Microsoft-managed, Entra-authenticated runtime that supplies the infrastructure to deploy, run, monitor, and manage apps under enterprise governance, security, and admin controls. App authoring, hosting, runtime, and management are billed through **Copilot Credits usage-based billing**, scaled by app complexity and the volume of generation/iteration. **Running these apps is included for users with a Power Apps Premium USL** (subject to existing Power Apps Premium request limits); usage beyond those limits — and any AI-powered runtime such as agents and Work IQ APIs — consumes Copilot Credits. The October 2026 Power Platform Licensing Guide states the same split and extends it: use of apps built in Copilot Studio and of **Copilot Cowork (Frontier)** is included with Power Apps Premium USLs subject to request limits, while hosting and managing apps in the Copilot Managed Runtime Host and AI runtime (agents, Work IQ APIs) consume Copilot Credits.

### 2.1 Commercial models

The October 2026 guide defines **four purchasing constructs** for Copilot Credits, plus the zero-rated Microsoft 365 Copilot path. *(Terminology note: the October 2026 guide reflects Microsoft's August 2026 rebrand of "Microsoft 365 Copilot" to "**Microsoft Copilot**" — the $30/user/month license and its use rights are unchanged; this article keeps the familiar "Microsoft 365 Copilot" name alongside the new one.)*

| Purchasing construct | List price (USD) | How it works |
|----------------------|------------------|--------------|
| **1. Pay-as-you-go Copilot Credit** (Azure-billed meter) | **$0.01 / Copilot Credit** | Post-pay for the exact credits agents and flows consume in a billing month; no upfront commitment. Decrements the Microsoft Azure Consumption Commitment (MACC); not Azure-prepayment eligible. |
| **2. Copilot Credit Pre-Purchase Plan (P3)** | Tiered discount off PAYG (see tiers below) | One-year pay-upfront pool of Copilot Credits that auto-decrements; overage rolls to PAYG or an added pool. Unused credits expire at the end of the annual term. |
| **3. Microsoft Agent Pre-Purchase Plan (P3)** | Tiered discount (see tiers below) | One-year pay-upfront pool priced in **Agent Commit Units (ACUs)** that covers eligible usage across **Copilot Studio *and* Microsoft Foundry**. **1 ACU = $1 = 100 Copilot Credits.** Per environment via billing plan; unused ACUs do not roll over. |
| **4. Copilot Studio capacity pack** (subscription license) | **$200 / pack / month, billed annually = 25,000 Copilot Credits** (≈ $0.008 / credit) | Per-tenant subscription; buy packs for expected monthly volume. Unused credits do not roll over month to month. Each builder also needs a **Copilot Studio User License ($0)**. |
| **M365 Copilot included usage** (not a purchase) | Zero-rated for licensed M365 Copilot users | B2E runtime of Standard / Copilot Chat harness agents in Microsoft channels is included in the $30/user/month M365 Copilot USL when the agent runs under the licensed user's identity; no tenant credits drawn. |

**Copilot Credit Pre-Purchase Plan (P3) tiers** (one-year, pay-upfront):

| Tier | Copilot Credits | Discount |
|------|-----------------|----------|
| 1 | 300,000 | 5% |
| 2 | 1,500,000 | 6% |
| 3 | 3,000,000 | 7% |
| 4 | 15,000,000 | 8% |
| 5 | 30,000,000 | 10% |
| 6 | 75,000,000 | 12% |
| 7 | 150,000,000 | 14% |
| 8 | 225,000,000 | 17% |
| 9 | 300,000,000 | 20% |

**Microsoft Agent Pre-Purchase Plan (P3) tiers** (one-year, pay-upfront; priced in ACUs, 1 ACU = $1 = 100 Copilot Credits):

| Tier | Agent Commit Units (ACUs) | Discount |
|------|---------------------------|----------|
| 1 | 20,000 | 5% |
| 2 | 100,000 | 10% |
| 3 | 500,000 | 15% |

Sources: Microsoft Copilot Studio Licensing Guide, October 2026; [Copilot Studio pricing](https://www.microsoft.com/en-us/copilot/pricing/copilot-studio); [Microsoft Agent Prepurchase Plan (Microsoft Learn)](https://learn.microsoft.com/en-us/azure/cost-management-billing/reservations/agent-pre-purchase); [Copilot Credits pre-purchase](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-pre-purchase-pricing); [M365 Copilot included entitlement](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-licensing-microsoft-copilot-included).

### 2.2 Copilot Credit billing rates

Per the April 2026 Copilot Studio Licensing Guide and the [Copilot Studio billing-rates page](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-messages-capacity):

| Event | Credits consumed |
|-------|------------------|
| **Classic answer** (deterministic topic flow, no LLM) | **1** |
| **Generative answer** (RAG over indexed knowledge sources) | **2** |
| **Agent action / tool call** (Power Automate flow, REST connector) | **5** |
| **Tenant Microsoft Graph grounding** (employee context) | **10** (reduced from 30; confirmed in the Power Platform Licensing Guide change log, April 2025) |
| **Voice** (per minute) | **13** |
| **Autonomous action** (event-triggered, no user prompt) | **25** |

{: .note }
**Billing rates.** Microsoft rebranded "messages" to "Copilot Credits" on September 1, 2025; the pay-as-you-go rate and the prepaid-pack quantity did **not** change with the rename. The table above shows the per-event rates from the April 2026 licensing guide. The October 2026 Copilot Studio Licensing Guide lists per-event rates by reference to the separate [Billing rates and management](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-messages-capacity) page.

**Capacity pooling.** All credits pool at the tenant level. Overage on the Pre-Purchase Plan rolls onto PAYG automatically unless the admin disables overflow.

### 2.2.1 AI Builder — current state and sunset

AI Builder capacity add-ons reached **End of Sale in November 2025** per the Power Platform Licensing Guide change log. The second milestone has now arrived: **starting November 1, 2026, no new or renewed Power Platform or Dynamics 365 licenses receive seeded AI Builder credits** (Microsoft Learn, AI Builder licensing overview). Existing add-on customers keep their add-on credits and can still renew them. Seeded credits on agreements that started before November 1, 2025 are honored through the end of that agreement term. AI Builder serves form processing / document automation, prediction models, sentiment analysis, and category classification scenarios, distinct from Copilot Studio agent invocations. The features keep working: in Power Apps and Power Automate they use any remaining AI Builder credits first and then Copilot Credits; in Copilot Studio they consume Copilot Credits.

**From November 1, 2026:** plan new AI Builder workloads on Copilot Credits. Tenants that still hold add-on or term-protected seeded AI Builder credits draw those first, so size Copilot Credit capacity for the fallback once they run out ([Copilot Studio Licensing Guide October 2026 (PDF)](https://go.microsoft.com/fwlink/?linkid=2243406); [End of AI Builder credits (Microsoft Learn)](https://learn.microsoft.com/en-us/ai-builder/endofaibcredits)).

### 2.3 What's included with Microsoft 365 Copilot vs what requires Copilot Studio

There are **three distinct user-license states** that affect how a Copilot Studio agent is billed:

| Capability | M365 Copilot ($30 / user / month) | M365 Copilot Chat (free tier) | Copilot Studio (credits) |
|-----------|-----------------------------------|-------------------------------|--------------------------|
| Out-of-box Copilot Chat in Word/Excel/PowerPoint/Outlook/Teams | Included | Limited (web grounding only; no tenant data) | n/a |
| Microsoft Graph grounding for the *user's own* M365 content | Included | Not included | n/a |
| Invoking a custom agent published in M365 Copilot / Teams (B2E) | **Zero-rated** (no tenant credits drawn) | **Metered to tenant Copilot Credits** | n/a |
| Building a custom agent in Copilot Studio | Not included | Not included | Required |
| Publishing a custom agent to a custom channel (web embed, Direct Line, WhatsApp, Slack, etc.) | Not included | Not included | Required — credits consumed |
| Anonymous public web chat (B2C) | Not included | Not included | Required — credits consumed regardless of user M365 Copilot status |

{: .important }
**The free-tier surprise.** A tenant that rolls out Microsoft 365 Copilot Chat broadly without buying the $30 M365 Copilot license will see agent invocations from those users **draw against tenant Copilot Credits** rather than being zero-rated. The economics flip at the M365 Copilot license boundary, not at the Copilot Chat boundary. Plan B2E credit budgets accordingly.

{: .note }
**Work IQ APIs are not zero-rated.** Per the August 2026 guide (a July 2026 change), a Copilot Studio agent's use of **Work IQ APIs is not included** in the Microsoft 365 Copilot USL and consumes Copilot Credits even in otherwise-included B2E scenarios.

### 2.4 Role-specific Copilots — Sales and Service

Distinct from Copilot Studio agents and from the in-Customer-Service Copilot, Microsoft also sells two **role-overlay Copilot SKUs**:

- **Microsoft 365 Copilot for Sales** — overlays M365 Copilot with a Sales-side experience that surfaces CRM context in Outlook and Teams, supports both Dynamics 365 Sales and Salesforce as the system of record.
- **Microsoft 365 Copilot for Service** — equivalent for Service scenarios, integrating with Dynamics 365 Customer Service and ServiceNow.

Each is a **per-user seat license**. These SKUs are **not** the same as Copilot Studio credits and are **not** consumed from the tenant credit pool — they are flat per-user subscriptions.

### 2.5 Real-world example — Pre-Purchase vs PAYG break-even

A retail customer expects 50,000 generative answers and 5,000 agent actions per month.

- Credits required: 50,000 × 2 + 5,000 × 5 = **125,000 credits / month**.
- PAYG cost: 125,000 × $0.01 = **$1,250 / month**.
- Capacity packs: 5 × $200 packs = **$1,000 / month** for 125,000 credits (5 × 25,000) — the effective $0.008 / credit is exactly a 20% saving vs PAYG.

**Rule of thumb:** Above ~25,000 credits / month, the **$200 capacity pack** beats PAYG. For large annual commitments the **Copilot Credit Pre-Purchase Plan (P3)** layers on a further 5–20% tiered discount, and the **Microsoft Agent Pre-Purchase Plan (P3)** is the option when the same up-front commitment must also cover Microsoft Foundry usage.

---

## 3. Microsoft Dataverse

Dataverse is the relational data backbone behind model-driven Power Apps and Dynamics 365. It is licensed as a **shared, tenant-level capacity pool** measured in three buckets — **Database** (relational rows), **File** (attachments / images / blobs), and **Log** (audit trail). Every Power Apps / Power Automate / Dynamics 365 license contributes per-user accrued capacity to the same shared pool, on top of a one-time tenant default.

### 3.1 Default tenant entitlement

The first eligible subscription provisioned in a tenant grants a **one-time tenant-level default**. The **October 2026 Power Platform Licensing Guide** puts the **File default at 20 GB and the Log default at 2 GB**; for the **Database default** the guide is still internally inconsistent — its worked example uses **10 GB** while its capacity table lists **20 GB** (these tenant defaults were raised in November 2025). This is not per subscription — purchasing a second Power Apps Premium or Dynamics 365 SKU does NOT double the default. The per-environment default (3 GB DB / 3 GB File / 1 GB Log for the default environment) is separate ([Dataverse capacity storage](https://learn.microsoft.com/en-us/power-platform/admin/capacity-storage)). The **October 2026 Copilot Studio Licensing Guide** states a **Dataverse-for-Copilot-Studio default of 15 GB Database / 20 GB File / 2 GB Log** per tenant (the Database default rose from 5 GB to 15 GB in December 2025) — the entitlement a tenant's first Copilot Studio / Power Apps / Power Automate / Power Pages or select Dynamics 365 subscription unlocks. Do not confuse it with the general Power Platform tenant default above. Power Pages capacity packs carry their own tenant default in the October 2026 Power Platform guide (15 GB Database / 2 GB Log).

### 3.2 Per-license accrued capacity

Dataverse capacity has two distinct dimensions that are easy to confuse: a **one-time tenant Default** (raised in November 2025) and **per-user Accrued** capacity (added for each license). The October 2026 Power Platform Licensing Guide lists them in separate columns, and its per-user numbers agree with the live pricing pages. The table below shows the **per-user accrued** values; the tenant default is covered in §3.1.

| License | DB accrued (live pricing page) | File accrued (live pricing page) | Licensing Guide PDF reports |
|---------|-------------------------------|----------------------------------|-----------------------------|
| Power Apps Premium | 250 MB / user | 2 GB / user | **Confirmed** by the October 2026 PPLG (Accrued column). The 20 GB sometimes cited is the tenant-wide **Default**, not per-user accrual — see §3.1. |
| Power Apps per App pass | 50 MB / user / pass | 400 MB / user / pass | Per the April 2026 PPLG. |
| Power Automate Premium | 250 MB / user | 2 GB / user | Per the live Power Automate pricing page. |
| Power Automate Process / Hosted Process | 50 MB / flow or bot | 200 MB / flow or bot | Per the live Power Automate pricing page. |
| Power Automate Process Mining add-on | 2 GB / license | 1 TB / license | Per the live Power Automate pricing page and the October 2026 PPLG. |
| Power Pages Authenticated Users capacity pack | 2 GB / pack | 16 GB / pack | Per the live Power Pages pricing page and the October 2026 PPLG (plus 1 GB Log / pack). |
| Power Pages Anonymous Users capacity pack | 500 MB / pack | 4 GB / pack | Per the live Power Pages pricing page and the October 2026 PPLG (plus 250 MB Log / pack). |
| Dynamics 365 Sales / Customer Service / Field Service / Contact Center Enterprise | About 250 MB / seat, on top of the 30 GB CRM tenant default (see §3.5) | About 2 GB / seat, on top of the 40 GB CRM tenant default (see §3.5) | The 30 GB / 40 GB figures are the one-time tenant default for Dynamics 365 CRM apps, not per-user capacity (August 2026 Dynamics 365 Licensing Guide). |
| Dynamics 365 Finance / SCM / Project Operations / Commerce | PPLG reports up to **90 GB / user DB** (uplift) | Up to 80 GB / user File (uplift) | Per the April 2026 PPLG. |
| Dynamics 365 Business Central Premium | 4 GB / user | 4 GB / user | Per the April 2026 D365 Licensing Guide. |
| Dynamics 365 Team Members | 250 MB / user | 2 GB / user | Per the April 2026 D365 Licensing Guide. |

Sources: [Power Apps pricing](https://www.microsoft.com/en-us/power-platform/products/power-apps/pricing); [Power Automate pricing](https://www.microsoft.com/en-us/power-platform/products/power-automate/pricing); [Power Platform Licensing Guide October 2026 (PDF)](https://go.microsoft.com/fwlink/?linkid=2085130); [Dynamics 365 Licensing Deck March 2026 (PDF)](https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/bade/documents/products-and-services/en-us/bizapps/Dynamics-365-Licensing-Deck-March-2026-PUB.pdf).

{: .important }
**Default vs per-user accrual — resolved for Power Platform.** The October 2026 Power Platform Licensing Guide confirms Power Apps Premium accrues **250 MB DB + 2 GB File per user** — the same as the pricing page. The larger numbers that circulated (e.g., 20 GB) are the **one-time tenant Database default**, not a per-user accrual, and must not be multiplied per user. For **Dynamics 365** SKUs the analogous per-user figures still come from the Dynamics 365 Licensing Guide (see §3.5).

### 3.3 Capacity add-ons

**Subscription capacity add-ons** (billed annually; confirmed in the October 2026 Power Platform and Copilot Studio Licensing Guides):

| Add-on | Minimum quantity | List price (USD) |
|--------|------------------|------------------|
| Dataverse Database capacity | 1 GB | **$40 / GB / month** |
| Dataverse Database capacity **Tier 2** | 1,000 GB | **$30 / GB / month** |
| Dataverse File capacity | 1 GB | **$2 / GB / month** |
| Dataverse Log capacity | 1 GB | **$10 / GB / month** |

**Pay-as-you-go Dataverse capacity meters** (per environment, billed on consumption above a 1 GB Database + 1 GB File per-environment entitlement — no Log entitlement):

| Meter | List price (USD) |
|-------|------------------|
| Dataverse Database capacity | **$48 / GB / month** |
| Dataverse File capacity | **$2.40 / GB / month** |
| Dataverse Log capacity | **$12 / GB / month** |

Subscription capacity is purchased per tenant and allocated across environments by an admin in the Power Platform admin center; the pay-as-you-go meters bill per environment as an alternative to subscription add-ons for overages. Dataverse capacity add-ons do not apply to Dataverse-for-Teams environments.

### 3.4 Dataverse for Teams vs full Dataverse

**Dataverse for Teams** is a constrained Dataverse instance bundled with **any Microsoft 365 plan that includes Teams** (Business Basic and above, E1+, F3, A1+, G1+). It exists to make canvas Power Apps inside Teams feasible without buying Premium ([about Teams environment](https://learn.microsoft.com/en-us/power-platform/admin/about-teams-environment)).

Limits:
- **2 GB capacity per Teams environment** (auto-provisioned per Team that adds a Power App).
- Maximum **5 GB per environment after upgrade**.
- **No Premium connectors, no custom connectors, no external API integrations** outside Teams. No advanced security roles. No model-driven apps.

An admin can **upgrade a Dataverse-for-Teams environment to a full Dataverse production environment**, at which point Premium licensing rules apply and the per-user accrued capacity is added to the tenant pool. This is a one-way upgrade.

### 3.5 Real-world example — Dataverse capacity math

A 200-user Dynamics 365 Customer Service Enterprise tenant in 2026. Customer Service Enterprise is a Dynamics 365 **CRM** app, so per the **August 2026 Dynamics 365 Licensing Guide** it draws on the shared CRM **tenant Default of 30 GB Database / 40 GB File** (granted once; the highest CRM tier sets it) plus a small **per-user *accrued*** increment — about **250 MB Database / 2 GB File per Enterprise seat** (the same accrual pattern as Power Apps Premium). The 30 GB / 40 GB is the **tenant default, not a per-user number** — the same correction applied to Power Apps in §3.2:

- Database = 30 GB (tenant default) + 200 × 0.25 GB (accrued per seat) = **80 GB Database**
- File = 40 GB (tenant default) + 200 × 2 GB (accrued per seat) = **440 GB File**

An earlier draft of this example multiplied the **30 GB tenant default as if it were a per-user accrual**, producing a fictitious **~6,010 GB** — the default-vs-accrued error corrected for Power Apps in §3.2. Database is still the pool most likely to drive overage for data-heavy CRM deployments (every record row consumes database capacity), but it accrues in **small per-seat increments on top of the one-time tenant default**, not tens of gigabytes per user.

{: .note }
**Tenant default, not per user.** Do **not** multiply the 30 GB default per user. Overage is still possible where File or Log capacity is consumed disproportionately (audit-heavy compliance scenarios, high-attachment-volume case management).

---

## 4. Copilot Studio with Dynamics 365 Contact Center

In 2024, Microsoft repositioned the omnichannel pieces of Customer Service as a **CRM-agnostic Contact Center as a Service** offering. The strategic intent: sell a "Copilot-first" CCaaS to organizations whose system of record is Salesforce, ServiceNow, Zendesk, or anything else — not just Dynamics 365.

### 4.1 Dynamics 365 Contact Center SKUs

| SKU | List price (USD) | Entitlement |
|-----|------------------|-------------|
| **Dynamics 365 Contact Center** (full) | **$110 / user / month** | Digital + voice channels, unified routing, Copilot in service representative desktop, integrations with Salesforce / Dynamics 365 / ServiceNow / Zendesk. **AI agents** (Customer Intent, Customer Knowledge, Quality Evaluation) **require Copilot Credits sold separately**. |
| **Dynamics 365 Contact Center Digital** | **$95 / user / month** | Digital messaging and chat channels only; no voice. |
| **Dynamics 365 Contact Center Voice** | **$95 / user / month** | Native voice channel only; no digital messaging. |
| **Promotional discount** *(expired June 30, 2026)* | **40% off, Oct 1, 2025 → Jun 30, 2026 — window has closed** | EA / CSP only; was not stackable. As of July 25, 2026 this offer is no longer shown on the Contact Center pricing page. |

Source: [Contact Center pricing](https://www.microsoft.com/en-us/dynamics-365/products/contact-center/pricing).

The Contact Center pricing page also notes discount pricing when Contact Center is purchased with Customer Service Enterprise licenses; the discounted price is not published.

**Capacity entitlements per Contact Center user** (per the Dynamics 365 Licensing Guide August 2026): 50 record routes / user, 1,000 messaging conversations / user / month, 3,000 IVR voice-bot minutes / tenant / month with the Voice add-in. Overage is billed via Copilot Credits or Azure Communication Services (ACS) pass-through.

### 4.2 Voice channel — Azure Communication Services pass-through

Voice is built on **Azure Communication Services**. Phone-number rental and per-minute usage charges are **NOT included** in the Contact Center subscription — they are billed separately through an Azure subscription.

| Voice meter | Rate (USD) |
|-------------|------------|
| PSTN inbound (US toll-free) | **$0.022 / min** |
| PSTN outbound (US) | **$0.013 / min** |
| VOIP inbound | **$0.004 / min** |
| SBC → ACS direct routing | **$0.004 / min** |
| Single-channel mixed-audio recording | **$0.004 / min** |

Phone-number leases run roughly $1 / month (US local DID) to $2 / month (US toll-free). SMS and WhatsApp messaging are metered per message under ACS pass-through. International outbound PSTN rates vary widely by destination — pull the current ACS price list per country before scoping any non-US deployment. Source: [voice channel pricing scenarios](https://learn.microsoft.com/en-us/dynamics365/customer-service/administer/voice-channel-pricing-scenarios).

{: .note }
**ACS rates.** ACS per-minute rates and DID lease costs change periodically and vary by region. The figures above are US commercial rates at the time of writing.

### 4.3 Where Copilot Studio meets Contact Center

When a customer interacts with an **AI agent** inside Contact Center — for example, a Customer Intent Agent that captures reason-for-contact before routing, or a Customer Knowledge Agent that drafts answers from the knowledge base — each turn consumes **Copilot Credits at the rates in §2.2**. The organization must hold either a Copilot Studio Pre-Purchase Plan or PAYG capacity. AI agents are NOT included in the base $110 Contact Center subscription — the official pricing page explicitly labels them "Requires Copilot Credits (sold separately)." **Exception (added July 2026):** the current Customer Service pricing page now shows **Customer Service Premium** with *included* base Copilot Credit capacity for these agents (footnote: "Base Copilot Credit capacity included in Dynamics 365 Customer Service Premium"), so a Premium seat carries a starter credit allotment that a standalone Contact Center seat does not — heavy usage still consumes additional credits beyond the included capacity.

This is the single most-misunderstood line in the entire Dynamics 365 portfolio. Buying Contact Center alone gives you the orchestration runtime — channel ingress, routing, the agent desktop, and reporting. It does NOT give you the AI agents the marketing material is built around. Those run on Copilot Studio credits.

### 4.4 Unified routing

Unified routing — skill-based, attribute-based, and longest-idle distribution across voice, chat, email, and social channels — is included with **Contact Center, Contact Center Digital, Contact Center Voice, Customer Service Enterprise, and Customer Service Premium**. It is **NOT included with Customer Service Professional**, which is the largest hidden functional gap between Professional and Enterprise.

### 4.5 Real-world example — Contact Center + ACS

A 60-seat outbound sales team uses Contact Center Voice ($95 × 60 = $5,700 / month at list price; the 40% promotion that cut this to $3,420 ended June 30, 2026) and makes 25 outbound calls per agent per day, average 4 minutes:

- Monthly outbound minutes: 60 × 25 × 4 × 21 = **126,000 min**
- ACS PSTN outbound charge: 126,000 × $0.013 = **$1,638**
- 60 toll-free DIDs at $2/each = **$120**
- **All-in: $5,700 + $1,638 + $120 = $7,458 / month**

Add a Customer Intent AI agent that captures reason-for-contact on every call (2 credits per turn, average 3 turns per call): 60 × 25 × 21 × 3 × 2 = **189,000 credits / month** ≈ $1,512 / month at the capacity-pack rate ($0.008 per credit), or $1,890 at pay-as-you-go ($0.01). The AI agent line item is real money — budget for it separately.

---

## 5. Dynamics 365 Customer Service

### 5.1 Base SKUs

| SKU | List price (USD) | Entitlement |
|-----|------------------|-------------|
| **Customer Service Professional** | **$50 / user / month** | Case management, knowledge management, customer service hub UI, mobile app, M365 integration. **Limited customization:** 15 custom tables, 5 BPFs, 5 dashboards, 2 forms/views per table, 15 queues. **No unified routing**, no multisession workspace, no embedded intelligence. |
| **Customer Service Enterprise** | **$105 / user / month** | Everything in Professional + unified routing, multisession workspace, embedded intelligence, **Copilot in service representative desktop** (case summary, email draft, conversation summary, Q&A over knowledge), full Power Apps customization (write access to all standard/custom tables, unlimited BPFs, dashboards, forms). |
| **Customer Service Premium** | **$195 / user / month** | Customer Service Enterprise + Dynamics 365 Contact Center bundled. Saves $20 / user / month vs buying them separately ($105 + $110 = $215). Per the current pricing page, Premium also includes **base Copilot Credit capacity** for the bundled AI agents (Customer Intent, Customer Knowledge Management, Case Management, Quality Evaluation), which on Professional/Enterprise "require Copilot Credits (sold separately)." |
| **Premium step-up** (introduced March 2026) | Step-up SKU | Customers on Enterprise can step up to Premium without re-signing the agreement. |

Source: [Customer Service pricing](https://www.microsoft.com/en-us/dynamics-365/products/customer-service/pricing).

**Recent pricing changes.** Customer Service Enterprise moved from $95 to **$105 / user / month** in mid-2025; partner blogs dated 2024 still cite $95. The **40% promotional discount** that ran October 1, 2025 → June 30, 2026 applied to **Customer Service Premium**, **Dynamics 365 Contact Center**, **Contact Center Digital**, and **Contact Center Voice** SKUs only — **Customer Service Enterprise was NOT included** in the promotion. **This promotional window closed on June 30, 2026 and is no longer displayed on Microsoft's pricing pages** ([Contact Center pricing](https://www.microsoft.com/en-us/dynamics-365/products/contact-center/pricing)). The promotion is EA / CSP only and is not stackable with other discounts.

### 5.2 Capacity entitlements per Customer Service license

- **Dataverse:** Customer Service Enterprise draws on the Dynamics 365 CRM tenant default of 30 GB Database / 40 GB File plus a small per-seat accrual (see §3.5).
- **Unified routing** (Enterprise+): 50 record routes / user, 1,000 messaging conversations / user / month.
- **API requests:** 40,000 / user / 24 h.
- **Copilot for Customer Service:** Included in Enterprise and Premium since 2024 — case summary, email draft, conversation summary, real-time agent assist, Q&A over linked knowledge sources.

### 5.3 Add-ins available to Customer Service Enterprise

These add-ins enable omnichannel capabilities for Customer Service Enterprise customers who do not want the full Contact Center bundle. **They cannot be purchased on top of Customer Service Professional.**

| Add-in | List price (USD, est.) | Entitlement |
|--------|------------------------|-------------|
| **Digital Messaging Add-in** | **$75 / user / month** | Live and persistent chat, SMS, WhatsApp, Facebook Messenger, Apple Messages for Business, LINE, WeChat, custom messaging channels. |
| **Voice Channel Add-in** | **$75 / user / month** | Native ACS-powered voice on Customer Service — inbound/outbound PSTN, IVR (3,000 voice-bot minutes / tenant included), call recording, transcription, sentiment analysis. ACS per-minute pass-through still applies. |
| **Digital Messaging + Voice Add-in** | **$90 / user / month** | Bundle of both — saves $60 / user / month vs separate. |
| **Chat Add-in** | **$60 / user / month** | Live chat only (subset of Digital Messaging). |

Sources: [Microsoft Dynamics community thread, MS employee response (June 2024)](https://community.dynamics.com/forums/thread/details/?threadid=5752f6aa-042f-ef11-840a-000d3a18baa0), [TrustRadius Customer Service pricing 2026](https://www.trustradius.com/products/microsoft-dynamics-365-customer-service/pricing), [voice channel pricing scenarios](https://learn.microsoft.com/en-us/dynamics365/customer-service/administer/voice-channel-pricing-scenarios).

**Note on sources.** Add-in USD list prices come from the Microsoft Dynamics community (employee response) and TrustRadius pricing aggregation. They are **not published on the public microsoft.com Customer Service pricing page**, which lists only the three base plans.

### 5.4 Customer Service Enterprise vs Contact Center vs Premium — the decision matrix

| Need | Recommended SKU | Monthly cost (200 seats, list, before promo) |
|------|------------------|-----------------------------------------------|
| Case + knowledge management only | Customer Service Professional | $10,000 |
| Case + omnichannel digital messaging | CS Enterprise + Digital Messaging Add-in | (105+75) × 200 = **$36,000** |
| Case + voice | CS Enterprise + Voice Channel Add-in | (105+75) × 200 = **$36,000** |
| Case + digital + voice (full omnichannel) | Customer Service Premium | 195 × 200 = **$39,000** |
| CRM-agnostic CCaaS (no D365 CRM in scope) | Dynamics 365 Contact Center | 110 × 200 = **$22,000** |
| Existing non-MS CRM + native voice + AI agents | Contact Center + Copilot Studio Pre-Purchase | 110 × 200 + credit pack = **~$22,000 + credits** |

### 5.5 Real-world example — when Premium beats Enterprise + add-ins

A 500-seat global support center needs digital messaging on day one and plans to add voice within 12 months. List-price comparison:

- Enterprise + Digital Messaging immediately: ($105 + $75) × 500 = **$90,000 / month** (Enterprise is NOT eligible for the 40% promo)
- Adding voice 12 months later (Digital Messaging + Voice combined add-in): ($105 + $90) × 500 = **$97,500 / month**
- Customer Service Premium from day one: $195 × 500 = **$97,500 / month**

Premium at list price matches Enterprise + combined add-in. The **decisive factor** is the promotional window. Under the **40% promo while it was active (Oct 1, 2025 → Jun 30, 2026, now expired)**:

- Customer Service Premium with promo: $195 × 0.60 × 500 = **$58,500 / month** for 500 seats
- Enterprise + Digital Messaging (no promo eligibility on either component): **$90,000 / month**

Premium under the promo was **$31,500 / month cheaper** for 500 seats than the Enterprise + add-in path while bundling the full Contact Center feature set (AI agents framework, ACS integration, unified routing with 1,000 messaging conversations / user / month, advanced reporting). The Customer Service Enterprise to Premium step-up (reflected in the Dynamics 365 Licensing Guide since August 2026) further reduces re-papering friction for Enterprise customers moving up. **The recommendation:** if voice is on the roadmap inside 18 months, start on Premium. (The 40% promo window that made this especially compelling closed June 30, 2026.)

---

## 6. Cross-cutting Guidance — How to Decide What to License

### 6.1 Decision principles

1. **Start with the data.** If the workload needs full Dataverse and Premium connectors, you are in Premium territory. If everything lives in SharePoint, Excel, and Teams, M365-seeded rights may be sufficient.
2. **Count the apps per user.** Power Apps Premium wins when most users run most apps; per-App wins when usage is role-segmented and you can count app users by the hundred, not the thousand.
3. **Separate the AI line item from the seat line item.** Copilot Studio credits are a separate budget. Contact Center seats do not include AI agent consumption. Customer Service Enterprise seats do not include the omnichannel add-ins.
4. **Promotional windows and eligibility.** The 40% discount applied to **Customer Service Premium**, **Dynamics 365 Contact Center**, **Contact Center Digital**, and **Contact Center Voice** through June 30, 2026 — **that window has now closed** (as of July 25, 2026 it is no longer shown on the pricing pages). **Customer Service Enterprise was never eligible.** If a sizing exercise is sitting on Enterprise + add-ins, model the Premium alternative explicitly before deciding.
5. **Expect movement.** Copilot Credit billing rates, Customer Service add-in list prices, and Dataverse per-user accruals have all moved within the last 12 months. The Changelog at the end records each change.

### 6.2 Cloud variants and regulated tenants

- **Government clouds (GCC, GCC High, DoD).** Power Platform and Dynamics 365 SKUs in US government clouds have a separate price list, separate feature-parity timeline (Copilot Studio voice and some AI agents have historically reached GCC clouds later than commercial), and constraints on which ACS regions and Azure OpenAI endpoints are available. Public-sector and defense readers should treat this article's pricing as commercial-cloud-only.
- **EU Data Boundary.** Microsoft completed full inclusion of Copilot and AI services in the EU Data Boundary in early 2025; processing for tenants in scope remains in EU/EFTA data centers. Multi-geo Dataverse is available as a separate capability with its own capacity implications.
- **Sovereign and regulated EU clouds.** Specific sovereign offerings (such as the Microsoft Cloud for Sovereignty, and locally-operated partner offerings where applicable) have distinct SKU availability and price lists.

### 6.3 Education and Nonprofit

- **Education (A-SKUs).** A1, A3, and A5 plans grant seeded Power Platform rights similar in shape to E-series equivalents but with reduced commercial use scope. Dynamics 365 has dedicated Education SKUs.
- **Nonprofit.** Eligible nonprofits qualify for steep discounts on Power Apps Premium and Dynamics 365 base SKUs via the Microsoft Tech for Social Impact program. Pricing varies by entity and country — engage Microsoft Philanthropies for current quotes.

### 6.4 Common mistakes to avoid

1. **Buying Contact Center without Copilot Credits.** The AI agents in marketing material are not included in the seat price — see §4.3.
2. **Assuming Managed Environments is free.** It has no SKU price, but it gates per-user license type — see §1.5.
3. **Treating "Premium" as a single product.** Power Apps Premium ≠ Customer Service Premium ≠ Contact Center Premium (does not exist; Contact Center has three flavors instead). Always specify.
4. **Mixing M365-seeded users into a Power Apps Premium app silently.** As soon as one Premium or custom connector is added to the app, every user needs a paid license — there is no occasional-use carve-out.
5. **Forgetting that F-series ≠ E-series for Power Platform rights** — see §1.1 caveat.
6. **Assuming the 40% promo applies to Customer Service Enterprise.** It does not — see §5.1 and §6.1 step 4.

### 6.5 Negotiation levers — EA vs CSP vs MCA-E

- **Enterprise Agreement (EA).** Best for very large tenants with predictable three-year demand; gates access to certain volume discounts and the 40% Contact Center promotion. Price-protected through the EA term.
- **Cloud Solution Provider (CSP).** Most flexible for mid-market — monthly cadence, partner-managed billing, easier mid-term seat changes. Promotion eligibility usually mirrors EA.
- **Microsoft Customer Agreement for Enterprise (MCA-E).** Microsoft's direct-purchase model, replacing some EA scenarios. Modern, online-managed, but coverage varies by region and SKU.

---

## 7. Conclusion

Microsoft's business-application licensing in 2026 reflects a maturing, three-pillar commercial design: **per-user subscriptions** for the seat-based products, **capacity-based consumption metering** for Dataverse and Copilot Studio Copilot Credits, and **MAU-based capacity packs** for citizen-facing Power Pages portals.

The structurally interesting shift of the last twelve months is the consolidation of Power Platform AI consumption under a single **Copilot Credit** meter (new and renewed licenses stopped receiving seeded AI Builder credits on November 1, 2026) — a strategic move toward a unified Azure-billed currency for all AI workloads. Future licensing decisions will increasingly be about *how much AI you can commit to up front* (capacity packs and the Copilot Credit or cross-platform Microsoft Agent Pre-Purchase Plans) versus *flexibility to spike* (pay-as-you-go), rather than which SKU contains which feature. In parallel, the August 2026 Power Platform Licensing Guide clarified what had looked like a pricing-page-vs-guide discrepancy: it is the **one-time tenant Dataverse default** that rose (November 2025), not per-user accrual — Power Apps Premium still accrues 250 MB DB / 2 GB File per user.

For the practitioner, three defaults: **Power Apps Premium for new build-outs unless app usage is clearly segmented by role; Customer Service Premium over Enterprise + add-ins for any deployment that includes both voice and digital messaging (the 40% Contact Center promo that made this especially attractive ran to June 30, 2026 and has since closed — Enterprise was never eligible); Copilot Studio capacity packs above ~25,000 credits / month, stepping up to the Copilot Credit or Microsoft Agent Pre-Purchase Plan (P3) for large annual commitments.**

This article is revised on a rolling basis. The **Changelog** at the end records every license-relevant change Microsoft publishes — price adjustments, SKU additions or retirements, capacity changes, billing rate revisions — with effective date, source, and a one-line impact note.

---

## Glossary

| Term | Expansion |
|------|-----------|
| **ACS** | Azure Communication Services — Azure platform service that provides PSTN voice, SMS, chat, and email under per-meter billing. Underpins the Contact Center and Customer Service voice channels. |
| **BPF** | Business Process Flow — a guided multi-stage workflow in Dynamics 365 / Dataverse model-driven apps. |
| **B2C** | Business to Consumer — public-facing scenarios (e.g., anonymous web chat, citizen portals). |
| **B2E** | Business to Employee — internal scenarios where the user is a licensed employee of the tenant. |
| **CCaaS** | Contact Center as a Service — cloud-delivered contact center, often CRM-agnostic. |
| **CoE Starter Kit** | Center of Excellence Starter Kit — Microsoft's free governance accelerator for Power Platform tenants. |
| **CSP** | Cloud Solution Provider — Microsoft's indirect partner channel for purchasing cloud services. |
| **Dataverse** | Microsoft's relational data platform behind model-driven Power Apps and Dynamics 365. |
| **DID** | Direct Inward Dialing — a directly-dialable telephone number, usually a local geographic number. |
| **DLP** | Data Loss Prevention — Power Platform policy controls that restrict which connectors can share data. |
| **EA** | Enterprise Agreement — Microsoft's traditional 3-year volume licensing agreement. |
| **EU Data Boundary** | Microsoft commitment to process EU/EFTA customer data within EU/EFTA data centers. |
| **FIFO** | First In, First Out — credit-consumption order across a pooled allocation. |
| **GCC / GCC High / DoD** | US government cloud variants — GCC (Moderate), GCC High (IL4), DoD (IL5/IL6). |
| **IVR** | Interactive Voice Response — automated voice menu / bot at the start of a call. |
| **MAU** | Monthly Active User — a unique identity counted once per calendar month, regardless of session count. |
| **MCA-E** | Microsoft Customer Agreement for Enterprise — Microsoft's modern direct-purchase contract model. |
| **PAYG** | Pay-As-You-Go — Azure-billed consumption with no upfront commitment. |
| **PPLG** | Power Platform Licensing Guide — Microsoft's authoritative entitlement reference PDF, updated regularly. |
| **PSTN** | Public Switched Telephone Network — traditional dialed phone network. |
| **RAG** | Retrieval-Augmented Generation — pattern where an LLM is grounded on retrieved documents. |
| **RPA** | Robotic Process Automation — UI-automation of desktop and web applications (Power Automate desktop flows). |
| **SBC** | Session Border Controller — a network device that bridges enterprise voice (SIP) to a carrier. |
| **VOIP** | Voice over IP — voice traffic over the public internet rather than PSTN. |

---

## Sources (primary)

1. [Microsoft Power Platform Licensing Guide, October 2026 (PDF)](https://go.microsoft.com/fwlink/?linkid=2085130)
2. [Microsoft Dynamics 365 Licensing Guide, current edition (October 2026 at the time of writing) (PDF)](https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/bade/documents/products-and-services/en-us/bizapps/Dynamics-365-Licensing-Guide.pdf)
3. [Microsoft Dynamics 365 Licensing Deck — March 2026 (PDF)](https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/bade/documents/products-and-services/en-us/bizapps/Dynamics-365-Licensing-Deck-March-2026-PUB.pdf)
4. [Microsoft Copilot Studio Licensing Guide (fwlink → current edition; **October 2026** at the time of writing)](https://go.microsoft.com/fwlink/?linkid=2243406)
5. [Power Apps pricing](https://www.microsoft.com/en-us/power-platform/products/power-apps/pricing)
6. [Power Automate pricing](https://www.microsoft.com/en-us/power-platform/products/power-automate/pricing)
7. [Power Pages pricing](https://www.microsoft.com/en-us/power-platform/products/power-pages/pricing)
8. [Microsoft Copilot Studio pricing](https://www.microsoft.com/en-us/copilot/pricing/copilot-studio)
9. [Dynamics 365 Customer Service pricing](https://www.microsoft.com/en-us/dynamics-365/products/customer-service/pricing)
10. [Dynamics 365 Contact Center pricing](https://www.microsoft.com/en-us/dynamics-365/products/contact-center/pricing)
11. [Copilot Studio billing rates (Microsoft Learn)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-messages-capacity)
12. [Power Platform admin licensing FAQ (Microsoft Learn)](https://learn.microsoft.com/en-us/power-platform/admin/powerapps-flow-licensing-faq)
13. [Dataverse storage capacity (Microsoft Learn)](https://learn.microsoft.com/en-us/power-platform/admin/capacity-storage)
14. [Power Pages capacity licensing (Microsoft Learn)](https://learn.microsoft.com/en-us/power-pages/admin/about-capacity-licensing)
15. [Voice channel pricing scenarios (Microsoft Learn)](https://learn.microsoft.com/en-us/dynamics365/customer-service/administer/voice-channel-pricing-scenarios)
16. [Dataverse for Teams environment (Microsoft Learn)](https://learn.microsoft.com/en-us/power-platform/admin/about-teams-environment)
17. [Power Platform environments overview (Microsoft Learn)](https://learn.microsoft.com/en-us/power-platform/admin/environments-overview)
18. [Power Platform API request limits and allocations (Microsoft Learn)](https://learn.microsoft.com/en-us/power-platform/admin/api-request-limits-allocations)
19. [Microsoft 365 Copilot included Copilot Studio usage (Microsoft Learn)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-licensing-microsoft-copilot-included)
20. [Copilot Credits Pre-Purchase Plan / PAYG (Microsoft Learn)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-pre-purchase-pricing)
21. [Connector reference (Microsoft Learn)](https://learn.microsoft.com/en-us/connectors/connector-reference/)
22. [Microsoft Dynamics community — Customer Service add-in pricing (employee response, June 2024)](https://community.dynamics.com/forums/thread/details/?threadid=5752f6aa-042f-ef11-840a-000d3a18baa0)
23. [TrustRadius — Dynamics 365 Customer Service pricing (2026)](https://www.trustradius.com/products/microsoft-dynamics-365-customer-service/pricing)
24. [Microsoft Agent Prepurchase Plan — Agent Commit Units (Microsoft Learn)](https://learn.microsoft.com/en-us/azure/cost-management-billing/reservations/agent-pre-purchase)
25. [Copilot Studio pay-as-you-go pricing (Azure)](https://azure.microsoft.com/en-us/pricing/details/copilot-studio/)
26. [New pricing for Power Apps Premium — effective January 1, 2027 (Microsoft Licensing News, September 9, 2026)](https://www.microsoft.com/en-us/licensing/news/power-apps-premium-price-update)
27. [Power Platform pay-as-you-go meters (Microsoft Learn)](https://learn.microsoft.com/en-us/power-platform/admin/pay-as-you-go-meters)
28. [End of AI Builder credits (Microsoft Learn)](https://learn.microsoft.com/en-us/ai-builder/endofaibcredits)
29. [AI Builder licensing overview (Microsoft Learn)](https://learn.microsoft.com/en-us/ai-builder/administer-licensing)

---

## Changelog

**Changelog: 2026-11-01 (Revision 7, October 2026 licensing guides).** Updated to the October 2026 editions of the Power Platform, Copilot Studio, and Dynamics 365 licensing guides. List prices are unchanged. Changes:

- **Guide references moved to the October 2026 editions** (Power Platform was August 2026, Copilot Studio was September 2026, Dynamics 365 was August 2026) in §1.1, §1.2, §1.3, §2.0, §2.1, §2.2, §2.2.1, §3.1 to §3.3, and Sources. The Dynamics 365 guide link now points to Microsoft's current-edition URL. The Copilot Studio October edition adds no change-log rows after September 2026. The Dynamics 365 October edition lists Dynamics 365 Sustainability as its only new offer, which is outside this article's scope.
- **Power Pages pay-as-you-go corrected (§1.3).** Authenticated users cost $4 per active user per site per month, not $2 (Microsoft Learn, pay-as-you-go meters). Anonymous users stay at $0.30. The worked example's pay-as-you-go total moves from $7,200 to $12,000 per month; the capacity-pack total stays at $6,000.
- **Power Pages capacity packs (§1.3, §3.1, §3.2).** Added the volume tiers from the October 2026 Power Platform guide (Authenticated $200, $75 from 100 packs, $50 from 1,000 packs; Anonymous $75, $37.50 from 20 packs, $25 from 200 packs), the Dataverse capacity each pack accrues, and the Power Pages tenant default (15 GB Database, 2 GB Log). Removed the "overage per MAU" wording, which no Microsoft source supports. Unused capacity does not carry over, and packs cannot be used in pay-as-you-go environments.
- **Power Automate (§1.2, §3.2).** Pay-as-you-go now shows both meters: $0.60 per premium cloud or attended desktop flow run and $3.00 per unattended desktop flow or hosted RPA run (preview). The Process Mining add-on now reads 100 GB of process mining data per tenant per month, add-on to Premium only, with 2 GB database and 1 TB file accrual, replacing the unsupported "more than 5 process maps" wording. Premium now lists 50 MB of process mining data per user.
- **AI Builder (§1.2, §2.2.1, Conclusion).** Rewritten for the November 1, 2026 milestone: new and renewed Power Platform and Dynamics 365 licenses no longer receive seeded AI Builder credits. Added how add-on credits and term-protected seeded credits are treated and how features fall back to Copilot Credits.
- **Power Apps (§1.1, §2.0).** The $12 volume tier now reads "2,000-seat minimum" (pricing page) or "2,000+ new per-user licenses" (October 2026 guide), replacing "2,000+ Microsoft 365 licenses". Added that Power Apps Premium includes use of apps built in Copilot Studio and of Copilot Cowork (Frontier), subject to request limits, while hosting and AI runtime consume Copilot Credits. The January 1, 2027 price box now notes that the increase covers monthly billing too and that nonprofit and education prices move in line. The Premium vs per app example now uses the $10 per app meter instead of the retired $5 subscription ($15,000 per month if everyone uses every app, $6,000 when segmented) and shows the $11,000 Premium cost from 2027.
- **Copilot Studio pricing link (§2.1, Sources).** Microsoft moved the pricing page to microsoft.com/en-us/copilot/pricing/copilot-studio.
- **Contact Center (§4.1, §4.5).** Added the pricing-page note on discount pricing with Customer Service Enterprise. The §4.5 example now uses list price because the 40% promotion ended June 30, 2026 (all-in $7,458 per month instead of $5,178), and the AI agent cost is labelled at the capacity-pack rate ($1,512) with the pay-as-you-go figure ($1,890).
- **Smaller fixes.** §5.5 now gives the Premium promo saving as $31,500 per month for 500 seats (was "roughly $30,000 / user / month"). The Conclusion now says the Changelog is at the end.
- **Body text cleaned up.** Removed the confidence notes and review reminders. Removed the Power Platform Requests add-on price and the Microsoft 365 Copilot for Sales / Service price, which Microsoft does not publish. The Dynamics 365 CRM rows in §3.2 and the Dataverse line in §5.1 now match §3.5 (30 GB / 40 GB is a tenant default, not per user). §2.2, §3.5, §4.2, and §5.3 notes now state their sources only.

**Changelog — 2026-10-01 (Revision 6 — newest-guide refresh: Copilot Studio September 2026 + Dynamics 365 August 2026).** Updated to the two newest licensing guides. Changes:

- **Copilot Studio guide → September 2026 (was August 2026).** Two additions in the September 2026 edition: (1) **Apps in Copilot Studio (Paid Public Preview)** — makers can now build *apps* (not just agents) in Copilot Studio using the **GitHub Copilot harness**, billed through Copilot Credits usage-based billing by app complexity and generation/iteration; and (2) the **Copilot Managed Runtime Host**, where those apps are deployed, run, and managed (Entra auth + enterprise governance), also billed via Copilot Credits — **but running them is included for Power Apps Premium USL holders**, subject to Power Apps Premium request limits (AI runtime such as agents and Work IQ APIs is excluded and consumes credits). §2.0 updated.
- **"Microsoft 365 Copilot" renamed "Microsoft Copilot" (effective August 2026).** The Copilot Studio guide change log records the rebrand; the $30/user/month license and its use rights are unchanged. Noted at §2.1; the article keeps "Microsoft 365 Copilot" for recognizability alongside the new name.
- **Dynamics 365 guide → August 2026 (was April 2026).** Links updated (§4.1, Sources). New in this edition: Customer Insights **Journey Creation** and **Outreach Optimization** agents (Paid Public Preview); the March 2026 deck's **Customer Service Enterprise→Premium step-up** and **increased Sales Premium Dataverse capacities** are reflected.
- **§3.5 corrected and resolved.** The old example multiplied **30 GB per user**, producing a fictitious **6,010 GB**. August 2026 Dynamics 365 data confirms **30 GB Database / 40 GB File is the one-time tenant *Default* for D365 CRM apps** — *not* a per-user figure. Per-user *accrued* capacity for an Enterprise CRM seat is a small increment (~250 MB DB / 2 GB File, the Power Apps Premium pattern). The example is rewritten: a 200-seat Customer Service Enterprise tenant entitles ≈ **80 GB Database / 440 GB File**. This closes the §3.5 item flagged since Revision 4.
- **Changelog moved to the end of the article** (per author preference); the intro now points readers to the end.

**Changelog — 2026-10-01 (Revision 5 — October 2026 pricing release).** Changes:

- **Announced Power Apps Premium price increase (effective January 1, 2027).** Microsoft's September 9, 2026 licensing announcement confirms the first Power Apps Premium list-price increase in more than five years: **Power Apps Premium $20 → $22/user/month** and the **2,000-seat volume tier $12 → $14/user/month**. Only these two SKUs are affected; all other Power Platform products, and the Power Apps entitlements seeded inside Microsoft 365 / Dynamics 365, are unchanged, and no entitlements are being removed. Existing subscriptions keep their price through the end of their term; the new price applies to new purchases, renewals, and co-terminations beginning on or after January 1, 2027 (U.S. Government increases are capped at 10%/year and phased). §1.1 now flags this, and today's $20 / $12 remain the current list prices until then.
- **Pricing-page terminology.** The Power Apps, Power Automate, and Power Pages pricing pages now surface the Copilot Studio pre-purchase as **"Copilot Credit Commit Units" with "save up to 20%"** — the same construct this guide documents as the Copilot Credit / Microsoft Agent Pre-Purchase Plan (§2.1); no price change.
- **This is a new dated release file** (`2026-10-01-powerplatform-licensing.md`). The post's identity — slug, canonical URL, and original publish date — is unchanged; the `updated` field is now 2026-10-01.
