---
layout: post
title: "Understanding Microsoft Power Platform Licensing: A Practitioner's Reference"
description: "A practitioner's reference for Power Platform core, Copilot Studio, Dataverse, Dynamics 365 Contact Center, and Dynamics 365 Customer Service."
date: 2026-05-30
author: admin
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/05/andre-taissin-5OUMf1Mr5pU-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@andretaissin?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Andre Taissin</a> on <a href="https://unsplash.com/photos/pink-pig-coin-bank-on-brown-wooden-table-5OUMf1Mr5pU?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
      


tags: ["powerplatform", "licensing", "copilotstudio", "dataverse", "dynamics365contactcenter", "dynamics365customerservice"]
featured: true
toc: true
---

{: .q-left }
> **Summary lede:** 
Power Platform licensing is now a hybrid of seat-based user licenses, pooled consumption credits, and MAU-based web access, and small architecture choices can materially change total cost. This guide maps the recent changes — Copilot Credits replacing messages, the April 2026 Dataverse accrual figures in the licensing guides, and the expansion of Dynamics 365 Contact Center / Customer Service bundles — into practical sizing and purchasing decisions with source-backed pricing.

{: .q-left }
> **Why read this article**
Microsoft's business-application licensing surface is a three-pillar commercial design that nobody encounters as a single coherent story: **per-user subscriptions** for the seat-based products (Power Apps, Power Automate, Dynamics 365 apps, Contact Center), **capacity-based consumption metering** for Dataverse and Copilot Studio Copilot Credits, and **monthly-active-user packs** for citizen-facing Power Pages portals. The result is that two near-identical projects can land on wildly different invoices depending on a handful of design decisions made by an architect who may never have read a licensing guide.

The last twelve months changed the math in three places that matter:

1. **Dataverse per-user accrual reporting (April 2026 licensing guides).** The April 2026 Power Platform and Dynamics 365 Licensing Guide PDFs report meaningfully higher per-license accrued storage for Power Apps Premium and several Dynamics 365 SKUs than prior revisions did. Microsoft's live pricing pages still display the previous per-user figures (e.g., 250 MB DB / 2 GB File for Power Apps Premium) — meaning the guide PDF and the marketing page disagree at the time of writing. This article cites the live pricing page as the conservative number and flags the guide-PDF uplift where it appears. Verify against the current PPLG PDF before sizing.
2. **Late 2025 — Copilot Studio "messages" became "Copilot Credits."** The meter was renamed and the per-event rates revised. Copilot Credits now pool across Copilot Studio agents AND the AI agents shipped inside Dynamics 365 Contact Center, Customer Service, and (per Microsoft messaging at the time of the rebrand) Sales-side AI agents.
3. **2024–2026 — Dynamics 365 Contact Center as a standalone, CRM-agnostic CCaaS SKU**, plus the **Customer Service Premium** bundle ($195/user/month = Customer Service Enterprise + Contact Center).

This article is the reference that ties the structural decisions to the line items. Every numeric claim has a source URL. Every section closes with a real-world example that shows why a customer would choose one option over another. Read this before sizing a Power Platform deployment, scoping a Copilot Studio agent, or negotiating a Dynamics 365 renewal.

{: .important }
**Confidence note.** Prices and entitlements published on Microsoft's own public pricing pages are HIGH confidence at the time of writing. The following are MODERATE confidence and should be re-verified against the current Microsoft Licensing Guide PDFs before any commercial commitment:  
(a) per-user Dataverse accrual figures from the April 2026 Power Platform / Dynamics 365 Licensing Guides where they exceed the live pricing-page figures;  
(b) Copilot Studio Copilot Credit per-event billing rates (the meter was rebranded in late 2025 and the published rates have moved);  
(c) Customer Service Enterprise omnichannel add-in USD list prices — confirmed via Microsoft community channels and partner aggregators, not the public pricing page;  
(d) the Premium step-up SKU reported as introduced in March 2026. Treat MODERATE-confidence items as anchors for a discussion with your Microsoft account team or CSP partner, not as final quoted prices.

{: .note }
**Scope.** This article covers Power Apps, Power Automate, Power Pages, Microsoft Copilot Studio, Microsoft Dataverse, Dynamics 365 Contact Center, and Dynamics 365 Customer Service. The following are deliberately out of scope and are NOT addressed: Power BI (separate Pro / PPU / Premium licensing model), Dynamics 365 Sales, Field Service, Business Central, Finance, Supply Chain Management, Project Operations, Commerce, Customer Insights – Data, Customer Insights – Journeys, Industry Clouds, and Microsoft Fabric. Government cloud SKUs (GCC, GCC High, DoD), Education (A-SKUs), and Nonprofit pricing are referenced only briefly in §6.

---

## 1. Power Platform (Core)

### 1.1 Power Apps

Power Apps in 2026 has three commercial purchase paths and one free developer path.

| SKU | List price (USD) | Entitlement |
|-----|------------------|-------------|
| **Power Apps Premium** (per user) | **$20 / user / month** | Unlimited custom canvas + model-driven apps and Power Pages portals (run-time). Includes Premium connectors, custom connectors, on-prem data gateway, and **250 MB Dataverse database + 2 GB Dataverse file accrued capacity per user** as displayed on the live Power Apps pricing page. The April 2026 Power Platform Licensing Guide PDF reports a higher figure — see §3.2 for the discrepancy and how to read it. |
| **Power Apps per App** (per user per app) | **$5 / user / app / month** | One app or one portal per "pass." Dataverse is limited to that app's scope: 50 MB DB / 400 MB file per user per pass. 5-pack minimum has been removed. |
| **Power Apps Pay-as-you-go** | **$10 per active user per app / month** | Consumption-billed through an Azure subscription. An "active user" is any user who launches the app within a calendar month. |
| **Power Apps Developer Plan** | Free | Build/test against a personal developer environment; no production rights. |

Sources: [Power Apps pricing](https://www.microsoft.com/en-us/power-platform/products/power-apps/pricing), [Power Platform Licensing Guide April 2026 (PDF)](https://go.microsoft.com/fwlink/?linkid=2085130).

**Per-App SKU status flag.** Microsoft announced **end-of-sale of the Power Apps per App SKU on January 2, 2026** for new commercial customers. In **early April 2026**, Microsoft reversed and reinstated the per-App SKU on the public price list. The April 2026 licensing guide reflects per-App as a current offer. This is the kind of change a future revision of this article will capture in the changelog.

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

- **Premium path:** 500 × $20 = **$10,000 / month**. Every user can run all three apps and any future apps.
- **Per-App path:** Three apps × $5 × 500 = $7,500 / month — **only if every user uses every app**. If usage is segmented — 200 users on HSE, 300 on visitor management, 100 on asset-walk — the math becomes (200 + 300 + 100) × $5 = **$3,000 / month**.

**Rule of thumb:** Premium wins when most users run most apps. Per-App wins when usage is role-segmented and the user count per app is well below the total workforce.

### 1.2 Power Automate

| SKU | List price (USD) | Entitlement |
|-----|------------------|-------------|
| **Power Automate Premium** (per user) | **$15 / user / month** | Unlimited cloud flows with Premium connectors, **one attended RPA bot** (desktop flow in attended mode), Process Mining (basic), AI Builder credits pool access (until November 2026). 40,000 API requests / user / 24 h. |
| **Power Automate Process** (per flow / per bot) | **$150 / bot or flow / month** | One unattended RPA bot OR one cloud flow that any user in the org may trigger. Service-account license for shared automations. |
| **Power Automate Hosted Process** | **$215 / bot / month** | Microsoft-hosted Windows VM for unattended desktop flows — no on-prem machine required. Includes one Process license. |
| **Power Automate Pay-as-you-go** | **$0.60 per cloud flow run** | Azure-billed. Suitable for low-frequency, high-variance workloads. |
| **Process Mining add-on** | **$5,000 / tenant / month** | Enterprise Process Mining for >5 process maps or unlimited records. |

Sources: [Power Automate pricing](https://www.microsoft.com/en-us/power-platform/products/power-automate/pricing), [Power Platform Licensing Guide April 2026](https://go.microsoft.com/fwlink/?linkid=2085130).

#### Real-world example — Process vs Hosted Process

A finance team runs an unattended nightly bot that reconciles bank statements with ERP entries. The bot runs on a corporate VDI that is patched weekly, resulting in 1–2 missed runs per month. Moving to **Hosted Process at $215 / bot / month** eliminates the VDI dependency and adds Microsoft-managed patching, RDP brokering, and elastic capacity. ROI breaks even at one prevented missed reconciliation per month.

### 1.3 Power Pages

Power Pages (the renamed Power Apps Portals) is licensed by **monthly active users (MAU) per site**. A MAU is a unique identity that loads any Power Pages page within a calendar month. Authenticated MAUs sign in (Entra ID, Entra External ID / B2C, Microsoft account, LinkedIn, etc.); anonymous MAUs are unauthenticated public visitors. Search-engine crawlers are not counted ([Power Pages capacity licensing](https://learn.microsoft.com/en-us/power-pages/admin/about-capacity-licensing)).

| SKU | List price (USD) | Entitlement |
|-----|------------------|-------------|
| **Authenticated Users capacity pack** | **$200 / site / month** | 100 authenticated MAUs / site / month. Overage: $2 / MAU. |
| **Anonymous Users capacity pack** | **$75 / site / month** | 500 anonymous MAUs / site / month. Overage: $0.30 / MAU. |
| **Power Pages PAYG** | $2 / authenticated MAU; $0.30 / anonymous MAU | Azure-billed; no monthly minimum. |

Source: [Power Pages pricing](https://www.microsoft.com/en-us/power-platform/products/power-pages/pricing).

#### Real-world example — Power Pages MAU math

A municipality launches a citizen-permit portal expected to draw **8,000 anonymous monthly active users** (unique visitors who load any page in the month) and **2,400 authenticated MAUs** (unique citizens who sign in to file a permit application).

- Capacity packs: 16 × Anonymous (16 × 500 = 8,000 anon MAU, $75 × 16 = $1,200) + 24 × Authenticated (24 × 100 = 2,400 auth MAU, $200 × 24 = $4,800) = **$6,000 / month**.
- PAYG: 8,000 × $0.30 + 2,400 × $2 = **$7,200 / month**.

Capacity packs win at steady volumes; PAYG wins for unpredictable spikes. Note that an authenticated MAU is a *unique signed-in identity per month*, not a session or a page view — repeat visits by the same citizen do not increment the count.

### 1.4 Tenant environment and API entitlements

- **Default environment.** Each tenant receives one default environment provisioned with **3 GB Dataverse database, 3 GB file, and 1 GB log** capacity ([Dataverse capacity storage](https://learn.microsoft.com/en-us/power-platform/admin/capacity-storage)). Production and sandbox environments draw from the tenant Dataverse pool. No hard cap on environment count, but each consumes from the shared pool ([environments overview](https://learn.microsoft.com/en-us/power-platform/admin/environments-overview)).
- **Developer environment.** Every user with any seeded or paid license automatically receives a personal developer environment.
- **API request entitlements** (per user per 24h, with overage pooled at tenant level): Premium Power Apps / Premium Power Automate / D365 Enterprise users get **40,000 requests / user / 24 h**; per-App users get **6,000**; Microsoft 365–seeded users get **6,000 / user / 24 h** for Standard-connector usage. Excess returns HTTP 429 but does not auto-bill; the **Power Platform Requests add-on** raises the tenant limit by 50,000 requests / 24 h (the $50 / month figure is widely partner-quoted but is not on the public allocations page — confirm before quoting) ([API request limits and allocations](https://learn.microsoft.com/en-us/power-platform/admin/api-request-limits-allocations)).

**When the Requests add-on actually matters.** High-volume Power Automate scenarios are typically triggered by child-flow fan-out patterns, integration flows polling HTTP endpoints on a short cadence, large-scale Dataverse data movement, and any flow making many connector calls per run. If your monitoring shows users approaching the daily cap or HTTP 429s in the flow run history, the add-on is the supported answer.

### 1.5 Managed Environments and Governance Licensing

**Managed Environments** is Microsoft's governance overlay for Power Platform environments — it surfaces DLP enforcement, sharing limits, weekly digests, Power Platform Pipelines, solution checker enforcement, and "Maker welcome content." Managed Environments has **no separate SKU price**, but it gates feature access by *user-license type*: every user accessing a Managed Environment must hold a **Power Apps Premium**, **Power Automate Premium**, **Power Pages**, or qualifying **Dynamics 365** license ([about Managed Environments](https://learn.microsoft.com/en-us/power-platform/admin/managed-environment-overview)).

The practical consequence: a tenant that adopted Managed Environments for governance reasons cannot mix-and-match M365-seeded users into the same environment. This is the most common reason a sizing exercise sized for "Premium for makers, M365 seeded for everyone else" needs to be re-priced upward.

The **CoE Starter Kit** (Center of Excellence) and **Power Platform Pipelines** ship at no additional cost but are built on Premium and Managed Environments — same user-license gating applies.

### 1.6 Trial, Developer, and non-production licenses

- **30-day trials** are available for Power Apps Premium and Power Automate Premium. Trials convert to paid via the Microsoft 365 admin center or your CSP / EA channel.
- **Power Apps Developer Plan** (free) replaces the retired Power Apps Community Plan. It provides a personal developer environment for build/test, with **no production rights and no commercial use**. Each user with any paid or seeded license is automatically entitled to a developer environment ([Developer Plan](https://powerapps.microsoft.com/en-us/developerplan/)).
- **Dynamics 365 30-day trials** are available for each base SKU. Customer Service Premium and Contact Center trials are tenant-bound; voice channel usage during trial incurs ACS pass-through charges if a phone number is provisioned.

---

## 2. Microsoft Copilot Studio

Copilot Studio is licensed by **Copilot Credit consumption**, which replaced the legacy "message" terminology in late 2025. Credits pool at the tenant level and are consumed FIFO across **all Copilot Studio agents, all environments, and bundled Dynamics 365 AI agents**. Microsoft documentation consistently references the Contact Center and Customer Service AI agents (Customer Intent, Customer Knowledge, Quality Evaluation) as drawing from the same credit pool. Sales-side AI agents are referenced in Microsoft messaging as participating in the pooled meter (MODERATE confidence — verify on the Dynamics 365 Sales pricing page).

### 2.1 Commercial models

| SKU | List price (USD) | Entitlement |
|-----|------------------|-------------|
| **Copilot Studio Pre-Purchase Plan** (Tenant Message Pack) | **$200 / month for 25,000 Copilot Credits** (≈ $0.008 / credit) | Annual commitment; up to **20% discount** vs PAYG. |
| **Copilot Studio Pay-as-you-go** (Azure-billed) | **$0.01 / Copilot Credit** | No commitment; Azure subscription required. |
| **M365 Copilot included usage** | Zero-rated for licensed M365 Copilot users | When agents are invoked through M365 Copilot Chat or Teams by a user holding the $30 / user / month M365 Copilot license, no tenant credits are drawn ("B2E zero-rated path"). |
| **Agent Pre-Purchase Plan** (Azure Reservation) | Up to 20% off PAYG | Credits apply across all Copilot Studio agents AND Dynamics 365 agents. |

Sources: [Copilot Studio pricing](https://www.microsoft.com/en-us/microsoft-copilot/microsoft-copilot-studio/pricing), [Copilot Credits pre-purchase](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-pre-purchase-pricing), [M365 Copilot included entitlement](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-licensing-microsoft-copilot-included).

### 2.2 Copilot Credit billing rates

Per the April 2026 Copilot Studio Licensing Guide and the [Copilot Studio billing-rates page](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-messages-capacity):

| Event | Credits consumed |
|-------|------------------|
| **Classic answer** (deterministic topic flow, no LLM) | **1** |
| **Generative answer** (RAG over indexed knowledge sources) | **2** |
| **Agent action / tool call** (Power Automate flow, REST connector) | **5** |
| **Tenant Microsoft Graph grounding** (employee context) | **10** (reported reduced from 30 before the rebrand) |
| **Voice** (per minute) | **13** |
| **Autonomous action** (event-triggered, no user prompt) | **25** |

{: .warning }
**Confidence note.** Per-event credit rates were revised when Microsoft rebranded "messages" to "Copilot Credits" in late 2025; the table above reflects the rates reported in the April 2026 licensing guide but has not been independently verified at the time of writing. The Microsoft Learn billing-rates page is authoritative — confirm before sizing a deployment.

**Capacity pooling.** All credits pool at the tenant level. Overage on the Pre-Purchase Plan rolls onto PAYG automatically unless the admin disables overflow.

### 2.2.1 AI Builder — current state and sunset

While AI Builder remains on price lists, it serves form processing / document automation, prediction models, sentiment analysis, and category classification scenarios — distinct from Copilot Studio agent invocations. Legacy AI Builder credits at **$500 per 1 million service credits** are scheduled to be **retired in November 2026** and consolidated under the Copilot Credit meter. Customers with active AI Builder add-ons can use them until renewal; net-new deployments after the retirement date will provision Copilot Credits instead.

**During the transition (now through November 2026):** if a workload is predominantly document processing, AI Builder may still be the more economical SKU. If it mixes document processing with conversational agents, Copilot Credits are the forward-compatible path. Re-check the current Copilot Studio Licensing Guide before committing to either ([Copilot Studio Licensing Guide April 2026 (PDF)](https://go.microsoft.com/fwlink/?linkid=2243406)).

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

### 2.4 Role-specific Copilots — Sales and Service

Distinct from Copilot Studio agents and from the in-Customer-Service Copilot, Microsoft also sells two **role-overlay Copilot SKUs**:

- **Microsoft 365 Copilot for Sales** — overlays M365 Copilot with a Sales-side experience that surfaces CRM context in Outlook and Teams, supports both Dynamics 365 Sales and Salesforce as the system of record.
- **Microsoft 365 Copilot for Service** — equivalent for Service scenarios, integrating with Dynamics 365 Customer Service and ServiceNow.

Each is a **per-user seat license** with pricing reported around the $50 / user / month range (MODERATE confidence — verify against the current Microsoft 365 Copilot pricing page). These SKUs are **not** the same as Copilot Studio credits and are **not** consumed from the tenant credit pool — they are flat per-user subscriptions.

### 2.5 Real-world example — Pre-Purchase vs PAYG break-even

A retail customer expects 50,000 generative answers and 5,000 agent actions per month.

- Credits required: 50,000 × 2 + 5,000 × 5 = **125,000 credits / month**.
- PAYG cost: 125,000 × $0.01 = **$1,250 / month**.
- Pre-Purchase: 5 × $200 packs = **$1,000 / month** for 125,000 credits — exactly the advertised 20% discount.

**Rule of thumb:** Above ~25,000 credits / month, Pre-Purchase always wins.

---

## 3. Microsoft Dataverse

Dataverse is the relational data backbone behind model-driven Power Apps and Dynamics 365. It is licensed as a **shared, tenant-level capacity pool** measured in three buckets — **Database** (relational rows), **File** (attachments / images / blobs), and **Log** (audit trail). Every Power Apps / Power Automate / Dynamics 365 license contributes per-user accrued capacity to the same shared pool, on top of a one-time tenant default.

### 3.1 Default tenant entitlement

The first eligible subscription provisioned in a tenant grants a **one-time tenant-level default** (long-standing licensing-guide figure: **10 GB Database, 20 GB File, 2 GB Log**). This is not per subscription — purchasing a second Power Apps Premium or Dynamics 365 SKU does NOT double the default. The per-environment default (3 GB DB / 3 GB File / 1 GB Log for the default environment) is separate. Verify both figures against the current licensing guide ([Dataverse capacity storage](https://learn.microsoft.com/en-us/power-platform/admin/capacity-storage)).

### 3.2 Per-license accrued capacity

Dataverse per-user accrual is reported in two places that currently disagree at the time of writing: Microsoft's live pricing pages (the conservative numbers below) and the April 2026 Power Platform / Dynamics 365 Licensing Guide PDFs (which report larger figures for several SKUs, attributed to a late-2025 uplift). The table below shows the **live pricing-page values** with the licensing-guide PDF figure noted where it differs.

| License | DB accrued (live pricing page) | File accrued (live pricing page) | Licensing Guide PDF reports |
|---------|-------------------------------|----------------------------------|-----------------------------|
| Power Apps Premium | 250 MB / user | 2 GB / user | Reported as substantially higher in the April 2026 PPLG PDF (figures circulating in partner channels reference 20 GB DB / user as the post-uplift number) — **verify against current PPLG PDF before sizing**. |
| Power Apps per App pass | 50 MB / user / pass | 400 MB / user / pass | Per the April 2026 PPLG. |
| Power Automate Premium | 250 MB / user | 2 GB / user | Per the live Power Automate pricing page. |
| Power Automate Process / Hosted Process | 50 MB / flow or bot | 200 MB / flow or bot | Per the live Power Automate pricing page. |
| Dynamics 365 Sales / Customer Service / Field Service / Contact Center Enterprise | Live pages show entitlement; PPLG reports up to **30 GB / user DB** (uplift) | Up to 30 GB / user File (uplift) | **MODERATE confidence**; verify against current PPLG PDF. |
| Dynamics 365 Finance / SCM / Project Operations / Commerce | PPLG reports up to **90 GB / user DB** (uplift) | Up to 80 GB / user File (uplift) | **MODERATE confidence**; verify against current PPLG PDF. |
| Dynamics 365 Business Central Premium | 4 GB / user | 4 GB / user | Per the April 2026 D365 Licensing Guide. |
| Dynamics 365 Team Members | 250 MB / user | 2 GB / user | Per the April 2026 D365 Licensing Guide. |

Sources: [Power Apps pricing](https://www.microsoft.com/en-us/power-platform/products/power-apps/pricing); [Power Automate pricing](https://www.microsoft.com/en-us/power-platform/products/power-automate/pricing); [Power Platform Licensing Guide April 2026 (PDF)](https://go.microsoft.com/fwlink/?linkid=2085130); [Dynamics 365 Licensing Deck March 2026 (PDF)](https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/bade/documents/products-and-services/en-us/bizapps/Dynamics-365-Licensing-Deck-March-2026-PUB.pdf).

{: .important }
**Pricing-page vs Licensing Guide disagreement.** At the time of writing, the public Power Apps pricing page reports 250 MB DB + 2 GB File per Premium user, while the April 2026 Power Platform Licensing Guide PDF reports higher per-user accruals. Sizing should be based on the figures the customer is contractually entitled to under the licensing-guide PDF in force at the time of purchase — confirm with your Microsoft account team or CSP partner before signing.

### 3.3 Capacity add-ons

| Add-on | List price (USD) |
|--------|------------------|
| Dataverse Database Capacity | **$40 / GB / month** |
| Dataverse File Capacity | **$2 / GB / month** |
| Dataverse Log Capacity | **$10 / GB / month** |

Capacity is purchased per tenant and allocated across environments by an admin in the Power Platform admin center.

### 3.4 Dataverse for Teams vs full Dataverse

**Dataverse for Teams** is a constrained Dataverse instance bundled with **any Microsoft 365 plan that includes Teams** (Business Basic and above, E1+, F3, A1+, G1+). It exists to make canvas Power Apps inside Teams feasible without buying Premium ([about Teams environment](https://learn.microsoft.com/en-us/power-platform/admin/about-teams-environment)).

Limits:
- **2 GB capacity per Teams environment** (auto-provisioned per Team that adds a Power App).
- Maximum **5 GB per environment after upgrade**.
- **No Premium connectors, no custom connectors, no external API integrations** outside Teams. No advanced security roles. No model-driven apps.

An admin can **upgrade a Dataverse-for-Teams environment to a full Dataverse production environment**, at which point Premium licensing rules apply and the per-user accrued capacity is added to the tenant pool. This is a one-way upgrade.

### 3.5 Real-world example — Dataverse capacity math

A 200-user Dynamics 365 Customer Service Enterprise tenant in 2026, using the licensing-guide-PDF per-user figures (30 GB DB / 30 GB File per Enterprise CRM user):

- Default + accrued DB = 10 GB (tenant default) + 200 × 30 GB (accrued) = **6,010 GB Database**
- File = 20 GB + 200 × 30 GB = **6,020 GB File**

At the older 10 GB per-user accrual, the same tenant would have entitled 10 + 200 × 10 = **2,010 GB DB** — meaningfully less, and historically the line item that drove Dataverse capacity overage billing for mid-market CRM customers.

{: .warning }
**Confidence note for §3.5.** The 30 GB/user figure is reported in the April 2026 Dynamics 365 Licensing Guide PDF but is not displayed on the public Dynamics 365 Customer Service pricing page. Treat the "6,010 GB DB" headline as MODERATE confidence and re-verify against the current PDF before using it for budget planning. Customers below the headline number can still hit overage if the file or Log capacity is consumed disproportionately (audit-heavy compliance scenarios, high-attachment-volume case management).

---

## 4. Copilot Studio with Dynamics 365 Contact Center

In 2024, Microsoft repositioned the omnichannel pieces of Customer Service as a **CRM-agnostic Contact Center as a Service** offering. The strategic intent: sell a "Copilot-first" CCaaS to organizations whose system of record is Salesforce, ServiceNow, Zendesk, or anything else — not just Dynamics 365.

### 4.1 Dynamics 365 Contact Center SKUs

| SKU | List price (USD) | Entitlement |
|-----|------------------|-------------|
| **Dynamics 365 Contact Center** (full) | **$110 / user / month** | Digital + voice channels, unified routing, Copilot in service representative desktop, integrations with Salesforce / Dynamics 365 / ServiceNow / Zendesk. **AI agents** (Customer Intent, Customer Knowledge, Quality Evaluation) **require Copilot Credits sold separately**. |
| **Dynamics 365 Contact Center Digital** | **$95 / user / month** | Digital messaging and chat channels only; no voice. |
| **Dynamics 365 Contact Center Voice** | **$95 / user / month** | Native voice channel only; no digital messaging. |
| **Promotional discount** | **40% off, Oct 1, 2025 → Jun 30, 2026** | EA / CSP only; not stackable. |

Source: [Contact Center pricing](https://www.microsoft.com/en-us/dynamics-365/products/contact-center/pricing).

**Capacity entitlements per Contact Center user** (per the Dynamics 365 Licensing Guide April 2026): 50 record routes / user, 1,000 messaging conversations / user / month, 3,000 IVR voice-bot minutes / tenant / month with the Voice add-in. Overage is billed via Copilot Credits or Azure Communication Services (ACS) pass-through.

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

{: .warning }
**Confidence note for §4.2.** ACS per-minute rates and DID lease costs change periodically and vary by region. The figures above are widely quoted US commercial rates at the time of writing (MODERATE confidence); always pull the live ACS pricing per country / channel before contracting.

### 4.3 Where Copilot Studio meets Contact Center

When a customer interacts with an **AI agent** inside Contact Center — for example, a Customer Intent Agent that captures reason-for-contact before routing, or a Customer Knowledge Agent that drafts answers from the knowledge base — each turn consumes **Copilot Credits at the rates in §2.2**. The organization must hold either a Copilot Studio Pre-Purchase Plan or PAYG capacity. AI agents are NOT included in the base $110 Contact Center subscription — the official pricing page explicitly labels them "Requires Copilot Credits (sold separately)."

This is the single most-misunderstood line in the entire Dynamics 365 portfolio. Buying Contact Center alone gives you the orchestration runtime — channel ingress, routing, the agent desktop, and reporting. It does NOT give you the AI agents the marketing material is built around. Those run on Copilot Studio credits.

### 4.4 Unified routing

Unified routing — skill-based, attribute-based, and longest-idle distribution across voice, chat, email, and social channels — is included with **Contact Center, Contact Center Digital, Contact Center Voice, Customer Service Enterprise, and Customer Service Premium**. It is **NOT included with Customer Service Professional**, which is the largest hidden functional gap between Professional and Enterprise.

### 4.5 Real-world example — Contact Center + ACS

A 60-seat outbound sales team uses Contact Center Voice ($95 × 60 = $5,700 / month, or $3,420 / month after the 40% promo) and makes 25 outbound calls per agent per day, average 4 minutes:

- Monthly outbound minutes: 60 × 25 × 4 × 21 = **126,000 min**
- ACS PSTN outbound charge: 126,000 × $0.013 = **$1,638**
- 60 toll-free DIDs at $2/each = **$120**
- **All-in: $3,420 + $1,638 + $120 = $5,178 / month**

Add a Customer Intent AI agent that captures reason-for-contact on every call (2 credits per turn, average 3 turns per call): 60 × 25 × 21 × 3 × 2 = **189,000 credits / month** ≈ $1,512 / month at Pre-Purchase rates. The AI agent line item is real money — budget for it separately.

---

## 5. Dynamics 365 Customer Service

### 5.1 Base SKUs

| SKU | List price (USD) | Entitlement |
|-----|------------------|-------------|
| **Customer Service Professional** | **$50 / user / month** | Case management, knowledge management, customer service hub UI, mobile app, M365 integration. **Limited customization:** 15 custom tables, 5 BPFs, 5 dashboards, 2 forms/views per table, 15 queues. **No unified routing**, no multisession workspace, no embedded intelligence. |
| **Customer Service Enterprise** | **$105 / user / month** | Everything in Professional + unified routing, multisession workspace, embedded intelligence, **Copilot in service representative desktop** (case summary, email draft, conversation summary, Q&A over knowledge), full Power Apps customization (write access to all standard/custom tables, unlimited BPFs, dashboards, forms). |
| **Customer Service Premium** | **$195 / user / month** | Customer Service Enterprise + Dynamics 365 Contact Center bundled. Saves $20 / user / month vs buying them separately ($105 + $110 = $215). |
| **Premium step-up** (introduced March 2026) | Step-up SKU | Customers on Enterprise can step up to Premium without re-signing the agreement. |

Source: [Customer Service pricing](https://www.microsoft.com/en-us/dynamics-365/products/customer-service/pricing).

**Recent pricing changes.** Customer Service Enterprise moved from $95 to **$105 / user / month** in mid-2025; partner blogs dated 2024 still cite $95. The **40% promotional discount** running October 1, 2025 → June 30, 2026 applies to **Customer Service Premium**, **Dynamics 365 Contact Center**, **Contact Center Digital**, and **Contact Center Voice** SKUs only — **Customer Service Enterprise is NOT included** in the promotion, per the eligibility footnote on the [Contact Center pricing page](https://www.microsoft.com/en-us/dynamics-365/products/contact-center/pricing). The promotion is EA / CSP only and is not stackable with other discounts.

### 5.2 Capacity entitlements per Customer Service license

- **Dataverse:** the April 2026 Dynamics 365 Licensing Guide reports up to 30 GB DB / 30 GB File / 2 GB Log per Customer Service Enterprise user (MODERATE confidence; verify against current PDF).
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

**Confidence note.** Add-in USD list prices are confirmed via the Microsoft Dynamics community (employee response) and TrustRadius pricing aggregation, but at the time of writing they are **not directly published on the public microsoft.com Customer Service pricing page**, which links only to the three base plans. Treat as MODERATE-confidence list prices; final quotes should come from the Microsoft account team or a CSP partner.

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

Premium at list price matches Enterprise + combined add-in. The **decisive factor** is the promotional window. Under the **40% promo (Oct 1, 2025 → Jun 30, 2026)**:

- Customer Service Premium with promo: $195 × 0.60 × 500 = **$58,500 / month** for 500 seats
- Enterprise + Digital Messaging (no promo eligibility on either component): **$90,000 / month**

Premium under the promo is **roughly $30,000 / user / month cheaper** than the Enterprise + add-in path while bundling the full Contact Center feature set (AI agents framework, ACS integration, unified routing with 1,000 messaging conversations / user / month, advanced reporting). The Premium step-up SKU reported in March 2026 (MODERATE confidence; verify with your account team) further reduces re-papering friction for Enterprise customers moving up. **The recommendation:** if voice is on the roadmap inside 18 months, start on Premium — especially if the contract can be signed inside the promo window.

---

## 6. Cross-cutting Guidance — How to Decide What to License

### 6.1 Decision principles

1. **Start with the data.** If the workload needs full Dataverse and Premium connectors, you are in Premium territory. If everything lives in SharePoint, Excel, and Teams, M365-seeded rights may be sufficient.
2. **Count the apps per user.** Power Apps Premium wins when most users run most apps; per-App wins when usage is role-segmented and you can count app users by the hundred, not the thousand.
3. **Separate the AI line item from the seat line item.** Copilot Studio credits are a separate budget. Contact Center seats do not include AI agent consumption. Customer Service Enterprise seats do not include the omnichannel add-ins.
4. **Use the promotional window — but check eligibility carefully.** The 40% discount applies to **Customer Service Premium**, **Dynamics 365 Contact Center**, **Contact Center Digital**, and **Contact Center Voice** through June 30, 2026. **Customer Service Enterprise is NOT eligible.** If a sizing exercise is sitting on Enterprise + add-ins, model the Premium-with-promo alternative explicitly before deciding.
5. **Re-verify the moving parts before signing.** Copilot Credit billing rates, Customer Service add-in list prices, and Dataverse per-user accruals have all moved within the last 12 months. The next revision of this article will track those in a dedicated changelog section.

### 6.2 Cloud variants and regulated tenants

- **Government clouds (GCC, GCC High, DoD).** Power Platform and Dynamics 365 SKUs in US government clouds have a separate price list, separate feature-parity timeline (Copilot Studio voice and some AI agents have historically reached GCC clouds later than commercial), and constraints on which ACS regions and Azure OpenAI endpoints are available. Public-sector and defense readers should treat this article's pricing as commercial-cloud-only and verify GCC/GCC High availability with their account team before sizing.
- **EU Data Boundary.** Microsoft completed full inclusion of Copilot and AI services in the EU Data Boundary in early 2025; processing for tenants in scope remains in EU/EFTA data centers. Multi-geo Dataverse is available as a separate capability with its own capacity implications.
- **Sovereign and regulated EU clouds.** Specific sovereign offerings (such as the Microsoft Cloud for Sovereignty, and locally-operated partner offerings where applicable) have distinct SKU availability and price lists. Confirm specifics with your account team.

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
- **Cloud Solution Provider (CSP).** Most flexible for mid-market — monthly cadence, partner-managed billing, easier mid-term seat changes. Promotion eligibility usually mirrors EA but ask the CSP partner to confirm.
- **Microsoft Customer Agreement for Enterprise (MCA-E).** Microsoft's direct-purchase model, replacing some EA scenarios. Modern, online-managed, but coverage varies by region and SKU. Confirm what is available in your geography.

---

## 7. Conclusion

Microsoft's business-application licensing in 2026 reflects a maturing, three-pillar commercial design: **per-user subscriptions** for the seat-based products, **capacity-based consumption metering** for Dataverse and Copilot Studio Copilot Credits, and **MAU-based capacity packs** for citizen-facing Power Pages portals.

The structurally interesting shift of the last twelve months is the consolidation of Power Platform AI consumption under a single **Copilot Credit** meter (with AI Builder credits scheduled to be retired in November 2026) — a strategic move toward a unified Azure-billed currency for all AI workloads. Future licensing decisions will increasingly be about *how much AI you can commit to up front* (Pre-Purchase Plan) versus *flexibility to spike* (PAYG), rather than which SKU contains which feature. In parallel, the April 2026 licensing guides report higher per-user Dataverse accruals for Power Apps Premium and several Dynamics 365 SKUs than the live pricing pages currently display — a discrepancy that materially affects sizing for tenants with 100+ seats and that should be re-verified against the licensing guide PDF in force at contract signing.

For the practitioner, three defaults: **Power Apps Premium for new build-outs unless app usage is clearly segmented by role; Customer Service Premium over Enterprise + add-ins for any deployment that includes both voice and digital messaging (especially under the 40% promo window, which Enterprise is not eligible for); Copilot Studio Pre-Purchase Plan above ~25,000 credits / month.** Confidence in these recommendations is HIGH for prices on Microsoft's own pricing pages and MODERATE for add-in list prices, Copilot Credit billing rates, and Licensing Guide PDF Dataverse accrual figures — all should be re-verified before any commercial commitment.

This article will be revised. The next revision will append a **Changelog** section recording every license-relevant change Microsoft publishes — price adjustments, SKU additions or retirements, capacity changes, billing rate revisions — with effective date, source URL, and a one-line impact note.

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

1. [Microsoft Power Platform Licensing Guide — April 2026 (PDF)](https://go.microsoft.com/fwlink/?linkid=2085130)
2. [Microsoft Dynamics 365 Licensing Guide — April 2026 (PDF)](https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/bade/documents/products-and-services/en-us/bizapps/Dynamics-365-Licensing-Guide-April-2026.pdf)
3. [Microsoft Dynamics 365 Licensing Deck — March 2026 (PDF)](https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/bade/documents/products-and-services/en-us/bizapps/Dynamics-365-Licensing-Deck-March-2026-PUB.pdf)
4. [Microsoft Copilot Studio Licensing Guide — April 2026 (PDF)](https://go.microsoft.com/fwlink/?linkid=2243406)
5. [Power Apps pricing](https://www.microsoft.com/en-us/power-platform/products/power-apps/pricing)
6. [Power Automate pricing](https://www.microsoft.com/en-us/power-platform/products/power-automate/pricing)
7. [Power Pages pricing](https://www.microsoft.com/en-us/power-platform/products/power-pages/pricing)
8. [Microsoft Copilot Studio pricing](https://www.microsoft.com/en-us/microsoft-copilot/microsoft-copilot-studio/pricing)
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

