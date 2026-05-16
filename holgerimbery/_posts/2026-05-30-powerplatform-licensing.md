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
Power Platform licensing is now a hybrid of seat-based user licenses, pooled consumption credits, and MAU-based web access, and small architecture choices can materially change total cost. This guide maps the changes — Dataverse capacity uplift, Copilot Credits replacing messages, and the expansion of Dynamics 365 Contact Center/Customer Service bundles—into practical sizing and purchasing decisions with source-backed pricing.

{: .q-left }
> **Why read this article**
Microsoft's business-application licensing surface is a three-pillar commercial design that nobody encounters as a single coherent story: **per-user subscriptions** for the seat-based products (Power Apps, Power Automate, Dynamics 365 apps, Contact Center), **capacity-based consumption metering** for Dataverse and Copilot Studio Copilot Credits, and **monthly-active-user packs** for citizen-facing Power Pages portals. The result is that two near-identical projects can land on wildly different invoices depending on a handful of design decisions made by an architect who may never have read a licensing guide.

The last twelve months changed the math in three places that matter:

1. **December 2025 — Dataverse capacity uplift.** Per-license accrued storage roughly doubled or tripled across Power Apps Premium, Dynamics 365 CRM, and Dynamics 365 ERP SKUs. For most mid-market tenants, Dataverse overage billing has effectively disappeared as a cost line.
2. **Late 2025 — Copilot Studio "messages" became "Copilot Credits."** The meter is renamed, the rates are revised (tenant Microsoft Graph grounding dropped from 30 to 10 credits per call), and Copilot Credits now pool across Copilot Studio agents AND the AI agents shipped inside Dynamics 365 Contact Center, Customer Service, and Sales.
3. **2024–2026 — Dynamics 365 Contact Center as a standalone, CRM-agnostic CCaaS SKU**, plus the new **Customer Service Premium** bundle ($195/user/month = Customer Service Enterprise + Contact Center).

This article is the reference that ties the structural decisions to the line items. Every numeric claim has a source URL. Every section closes with a real-world example showing why a customer would land on one option over another. Read this before sizing a Power Platform deployment, scoping a Copilot Studio agent, or negotiating a Dynamics 365 renewal.

{: .important }
**Confidence note.** Prices and entitlements published on Microsoft's own pricing pages and the April 2026 licensing guides are HIGH confidence. Customer Service Enterprise omnichannel add-in USD list prices are MODERATE confidence — they are confirmed only via Microsoft community channels and partner aggregators, not the public pricing page, and large-deal customers should obtain a final quote from a Microsoft account team or CSP partner.

---

## 1. Power Platform (Core)

### 1.1 Power Apps

Power Apps in 2026 has three commercial purchase paths and one free developer path.

| SKU | List price (USD) | Entitlement |
|-----|------------------|-------------|
| **Power Apps Premium** (per user) | **$20 / user / month** | Unlimited custom canvas + model-driven apps and Power Pages portals (run-time). Includes Premium connectors, custom connectors, on-prem data gateway, and **20 GB Dataverse database accrued capacity per user** (post-Dec 2025 uplift). |
| **Power Apps per App** (per user per app) | **$5 / user / app / month** | One app or one portal per "pass." Dataverse limited to that app's scope: 50 MB DB / 400 MB file per user per pass. 5-pack minimum has been removed. |
| **Power Apps Pay-as-you-go** | **$10 per active user per app / month** | Consumption-billed through an Azure subscription. An "active user" is any user who launches the app within a calendar month. |
| **Power Apps Developer Plan** | Free | Build/test against a personal developer environment; no production rights. |

Sources: [Power Apps pricing](https://www.microsoft.com/en-us/power-platform/products/power-apps/pricing), [Power Platform Licensing Guide April 2026 (PDF)](https://go.microsoft.com/fwlink/?linkid=2085130).

**Per-App SKU status flag.** Microsoft announced **end-of-sale of the Power Apps per App SKU on January 2, 2026** for new commercial customers. In **early April 2026** Microsoft reversed and reinstated the per-App SKU on the public price list. The April 2026 licensing guide reflects per-App as a current offer. This is the kind of change a future revision of this article will capture in the changelog.

#### Standard vs Premium connectors — the core licensing fault line

Microsoft splits its 1,500+ certified connectors into two classes, enforced both at the connection-add step and at runtime ([connector reference](https://learn.microsoft.com/en-us/connectors/connector-reference/)):

- **Standard connectors** — included with any Microsoft 365 / Office 365 commercial plan. Examples: SharePoint, Outlook 365, OneDrive for Business, Teams, Excel Online Business, Planner, Dataverse for Teams.
- **Premium connectors** — require a paid Power Apps / Power Automate license, a per-app pass, or PAYG. Examples: **SQL Server, Azure SQL, Dataverse (full), HTTP, all custom connectors, all third-party SaaS connectors** (Salesforce, SAP, Oracle, ServiceNow, Workday, ZenDesk).

The moment an app or a flow touches one Premium connector, every user of that app or flow needs a Premium license. There is no "occasional use" carve-out.

#### Seeded Microsoft 365 / Office 365 entitlements

Every commercial M365 plan (Business Basic/Standard/Premium, E3, E5, F3, A3, A5, G3, G5) grants:

- **Power Apps for Office 365** — build/run canvas apps using **Standard connectors only**; no access to full Dataverse.
- **Power Automate for Office 365** — cloud flows using Standard connectors only, with **2,000 API requests per user per day** pooled at the tenant level.

These rights specifically exclude full Dataverse, all Premium and custom connectors, the on-prem data gateway, and AI Builder.

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

A finance team runs a nightly unattended bot that reconciles bank statements against ERP entries. The bot runs on a corporate VDI patched weekly, causing 1–2 missed runs per month. Moving to **Hosted Process at $215 / bot / month** eliminates the VDI dependency and adds Microsoft-managed patching, RDP brokering, and elastic capacity. ROI breaks even at one prevented missed reconciliation per month.

### 1.3 Power Pages

Power Pages (the renamed Power Apps Portals) is licensed by **monthly active users (MAU) per site**. A MAU is a unique identity that loads any Power Pages page within a calendar month. Authenticated MAUs sign in (Entra ID, Entra External ID / B2C, Microsoft account, LinkedIn, etc.); anonymous MAUs are unauthenticated public visitors. Search-engine crawlers are not counted ([Power Pages capacity licensing](https://learn.microsoft.com/en-us/power-pages/admin/about-capacity-licensing)).

| SKU | List price (USD) | Entitlement |
|-----|------------------|-------------|
| **Authenticated Users capacity pack** | **$200 / site / month** | 100 authenticated MAUs / site / month. Overage: $2 / MAU. |
| **Anonymous Users capacity pack** | **$75 / site / month** | 500 anonymous MAUs / site / month. Overage: $0.30 / MAU. |
| **Power Pages PAYG** | $2 / authenticated MAU; $0.30 / anonymous MAU | Azure-billed; no monthly minimum. |

Source: [Power Pages pricing](https://www.microsoft.com/en-us/power-platform/products/power-pages/pricing).

#### Real-world example — Power Pages MAU math

A municipality launches a citizen-permit portal expected to draw 8,000 anonymous page visits and 2,400 authenticated permit applications per month.

- Capacity packs: 5 × Anonymous ($75 × 5 = $375) + 24 × Authenticated ($200 × 24 = $4,800) = **$5,175 / month**.
- PAYG: 8,000 × $0.30 + 2,400 × $2 = **$7,200 / month**.

Capacity packs win at steady volumes; PAYG wins for unpredictable spikes.

### 1.4 Tenant environment and API entitlements

- **Default environment.** Each tenant receives one default environment (1 GB Dataverse, expandable). Production and sandbox environments draw from the tenant Dataverse pool. No hard cap on environment count, but each consumes from the shared pool ([environments overview](https://learn.microsoft.com/en-us/power-platform/admin/environments-overview)).
- **Developer environment.** Every user with any seeded or paid license automatically receives a personal developer environment.
- **API request entitlements** (pooled at tenant level): Premium Power Apps / Premium Power Automate / D365 Enterprise users contribute **40,000 requests / 24 h each**; per-App users contribute **6,000**; M365-seeded users contribute **6,000 Standard requests** to a separate Standard pool. Excess returns HTTP 429 but does not auto-bill; a separate **Power Platform Requests add-on** ($50 / 50,000 requests / month) is available ([API request limits and allocations](https://learn.microsoft.com/en-us/power-platform/admin/api-request-limits-allocations)).

---

## 2. Microsoft Copilot Studio

Copilot Studio is licensed by **Copilot Credit consumption**, which replaced the legacy "message" terminology in late 2025. Credits pool at the tenant level and are consumed FIFO across **all Copilot Studio agents, all environments, and all bundled Dynamics 365 AI agents** (Contact Center, Customer Service, Sales).

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
| **Tenant Microsoft Graph grounding** (employee context) | **10** (reduced from 30 before the rebrand) |
| **Voice** (per minute) | **13** |
| **Autonomous action** (event-triggered, no user prompt) | **25** |

**Capacity pooling.** All credits pool at tenant level. Overage on the Pre-Purchase Plan rolls onto PAYG automatically unless the admin disables overflow.

**AI Builder sunset.** Legacy AI Builder credits ($500 per 1 million units) are scheduled to be **retired in November 2026** and consolidated under the Copilot Credit meter. Customers with active AI Builder add-ons can use them until renewal ([Copilot Studio Licensing Guide April 2026 (PDF)](https://go.microsoft.com/fwlink/?linkid=2243406)).

### 2.3 What's included with Microsoft 365 Copilot vs what requires Copilot Studio

| Capability | M365 Copilot ($30 / user / month) | Copilot Studio (credits) |
|-----------|-----------------------------------|--------------------------|
| Out-of-box Copilot Chat in Word/Excel/PowerPoint/Outlook/Teams | Included | Not applicable |
| Microsoft Graph grounding for the *user's own* M365 content | Included | n/a |
| Invoking a custom agent published in M365 Copilot / Teams (B2E) | **Zero-rated** (no tenant credits drawn) | n/a |
| Building a custom agent in Copilot Studio | Not included | Required |
| Publishing a custom agent to a custom channel (web embed, Direct Line, WhatsApp, Slack, etc.) | Not included | Required — credits consumed |
| Anonymous public web chat (B2C) | Not included | Required — credits consumed regardless of user M365 Copilot status |

### 2.4 Real-world example — Pre-Purchase vs PAYG break-even

A retail customer expects 50,000 generative answers and 5,000 agent actions per month.

- Credits required: 50,000 × 2 + 5,000 × 5 = **125,000 credits / month**.
- PAYG cost: 125,000 × $0.01 = **$1,250 / month**.
- Pre-Purchase: 5 × $200 packs = **$1,000 / month** for 125,000 credits — exactly the advertised 20% discount.

**Rule of thumb:** Above ~25,000 credits / month, Pre-Purchase always wins.

---

## 3. Microsoft Dataverse

Dataverse is the relational data backbone behind model-driven Power Apps and Dynamics 365. It is licensed as a **shared, tenant-level capacity pool** measured in three buckets — **Database** (relational rows), **File** (attachments / images / blobs), and **Log** (audit trail). Every Power Apps / Power Automate / Dynamics 365 license contributes per-user accrued capacity to the same shared pool, on top of a one-time tenant default.

### 3.1 Default tenant entitlement

The first eligible subscription provisioned in a tenant grants a **one-time default**: **10 GB Database, 20 GB File, 2 GB Log**. This is not per subscription — purchasing a second Power Apps Premium or Dynamics 365 SKU does NOT double the default ([Dataverse capacity storage](https://learn.microsoft.com/en-us/power-platform/admin/capacity-storage)).

### 3.2 Per-license accrued capacity (post-December 2025 uplift)

The biggest licensing change of the last twelve months. The April 2026 Power Platform Licensing Guide and March 2026 Dynamics 365 Licensing Deck both reflect the new values:

| License | DB accrued | File accrued | Notes |
|---------|-----------|--------------|-------|
| Power Apps Premium | **20 GB / user** (was 10) | 2 GB / user | December 2025 increase |
| Power Apps per App pass | 5 MB / user / pass | 1 GB / user / pass | Unchanged |
| Power Automate Premium | 50 MB / user | 200 MB / user | Unchanged |
| Dynamics 365 Sales / Customer Service / Field Service / Contact Center Enterprise | **30 GB / user** (was 10) | 30 GB / user | December 2025 increase |
| Dynamics 365 Finance / SCM / Project Operations / Commerce | **90 GB / user** (was 60) | 80 GB / user | December 2025 increase |
| Dynamics 365 Business Central Premium | 4 GB / user | 4 GB / user | Unchanged |
| Dynamics 365 Team Members | 250 MB / user | 2 GB / user | Unchanged |

Sources: [Power Platform Licensing Guide April 2026 (p. 21)](https://go.microsoft.com/fwlink/?linkid=2085130); [Dynamics 365 Licensing Deck March 2026 (PDF)](https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/bade/documents/products-and-services/en-us/bizapps/Dynamics-365-Licensing-Deck-March-2026-PUB.pdf).

**Documentation ambiguity.** Page 22 of the April 2026 PPLG still references 10 GB Power Apps Premium accrued capacity in a worked example — a residual inconsistency Microsoft has not corrected. Trust the page-21 table (newer authoritative value).

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

A 200-user Dynamics 365 Customer Service Enterprise tenant in 2026:

- Default + accrued capacity = 10 GB (default DB) + 200 × 30 GB (accrued) = **6,010 GB Database**
- File: 20 GB + 200 × 30 GB = **6,020 GB File**

Prior to December 2025, the same tenant would have entitled only 10 + 200 × 10 = **2,010 GB DB**. The change has effectively eliminated Dataverse capacity overage billing for most CRM customers below 1,000 seats — a structural reduction in TCO that did not require a price change.

---

## 4. Copilot Studio with Dynamics 365 Contact Center

In 2024 Microsoft repositioned the omnichannel pieces of Customer Service as a **CRM-agnostic Contact Center as a Service** offering. The strategic intent: sell a "Copilot-first" CCaaS to organizations whose system of record is Salesforce, ServiceNow, Zendesk, or anything else — not just Dynamics 365.

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

Phone-number leases run roughly $1 / month (US local DID) to $2 / month (US toll-free). SMS is metered per message. Source: [voice channel pricing scenarios](https://learn.microsoft.com/en-us/dynamics365/customer-service/administer/voice-channel-pricing-scenarios).

### 4.3 Where Copilot Studio meets Contact Center

When a customer interacts with an **AI agent** inside Contact Center — for example, a Customer Intent Agent that captures reason-for-contact before routing, or a Customer Knowledge Agent that drafts answers from the knowledge base — each turn consumes **Copilot Credits at the rates in §2.2**. The organization must hold either a Copilot Studio Pre-Purchase Plan or PAYG capacity. AI agents are NOT included in the base $110 Contact Center subscription — the official pricing page explicitly labels them "Requires Copilot Credits (sold separately)."

This is the single most-misunderstood line in the entire Dynamics 365 portfolio. Buying Contact Center alone gives you the orchestration runtime — channel ingress, routing, the agent desktop, reporting. It does NOT give you the AI agents the marketing material is built around. Those run on Copilot Studio credits.

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

**Recent pricing changes.** Customer Service Enterprise moved from $95 to **$105 / user / month** in mid-2025; partner blogs dated 2024 still cite $95. The **40% promotional discount** running October 1, 2025 → June 30, 2026 applies to Customer Service Enterprise, Customer Service Premium, and Contact Center SKUs.

### 5.2 Capacity entitlements per Customer Service license

- **Dataverse:** 30 GB DB / 30 GB File / 2 GB Log per user (since December 2025; was 10 GB DB).
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

A 500-seat global support center needs digital messaging on day one and plans to add voice within 12 months.

- Enterprise + Digital Messaging immediately: ($105 + $75) × 500 = **$90,000 / month**
- Adding voice 12 months later (Digital Messaging + Voice combined add-in): ($105 + $90) × 500 = **$97,500 / month**
- Customer Service Premium from day one: $195 × 500 = **$97,500 / month**

Premium costs the same as Enterprise + the combined add-in, but ships with the full Contact Center feature set on day one (AI agents framework, ACS integration, unified routing with 1,000 messaging conversations / user / month, advanced reporting) and is covered by the March 2026 step-up SKU. **The recommendation:** if voice is on the roadmap inside 18 months, start on Premium.

---

## 6. Cross-cutting Guidance — How to Decide What to License

1. **Start with the data.** If the workload needs full Dataverse and Premium connectors, you are in Premium territory. If everything lives in SharePoint, Excel, and Teams, M365-seeded rights may be sufficient.
2. **Count the apps per user.** Power Apps Premium wins when most users run most apps; per-App wins when usage is role-segmented and you can count app users by the hundred, not the thousand.
3. **Separate the AI line item from the seat line item.** Copilot Studio credits are a separate budget. Contact Center seats do not include AI agent consumption. Customer Service Enterprise seats do not include the omnichannel add-ins.
4. **Use the promotional window.** The 40% discount on Customer Service Enterprise, Customer Service Premium, and Contact Center SKUs runs through June 30, 2026. If you have a renewal or net-new deal in scope, align the negotiation to the promotion.
5. **Re-verify the moving parts before signing.** Copilot Credit billing rates and Customer Service add-in list prices have both moved within the last 90 days. The next revision of this article will track those in a dedicated changelog section.

---

## 7. Conclusion

Microsoft's business-application licensing in 2026 reflects a maturing, three-pillar commercial design: **per-user subscriptions** for the seat-based products, **capacity-based consumption metering** for Dataverse and Copilot Studio Copilot Credits, and **MAU-based capacity packs** for citizen-facing Power Pages portals.

The most consequential shift of the last twelve months is not a price change but a *value* change. December 2025's quiet but very large Dataverse capacity uplift effectively removed Dataverse overage billing as a meaningful cost line for most mid-market customers — fundamentally improving the economics of any non-trivial Power Apps or Dynamics 365 deployment. Simultaneously, the consolidation of Power Platform AI consumption under a single **Copilot Credit** meter (with AI Builder credits scheduled to be retired in November 2026) signals a strategic move toward a unified Azure-billed currency for all AI workloads. Future licensing decisions will increasingly be about *how much AI you can commit to up front* (Pre-Purchase Plan) versus *flexibility to spike* (PAYG), rather than which SKU contains which feature.

For the practitioner, three defaults: **Power Apps Premium for new build-outs unless app usage is clearly segmented by role; Customer Service Premium over Enterprise + add-ins for any deployment that includes both voice and digital messaging; Copilot Studio Pre-Purchase Plan above ~25,000 credits / month.** Confidence in these recommendations is HIGH for prices on Microsoft's own pricing pages and MODERATE for add-in list prices and Copilot Credit billing rates, both of which have moved within the last 90 days and should be re-verified before any commercial commitment.

This article will be revised. The next revision will append a **Changelog** section recording every license-relevant change Microsoft publishes — price adjustments, SKU additions or retirements, capacity changes, billing rate revisions — with effective date, source URL, and a one-line impact note.

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

