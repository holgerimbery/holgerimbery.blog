---
layout: post
title: "Power Platform Governance: A Practitioner's Reference (Part 1)"
description: "Part 1 of a two-part guide to managing and securing Power Platform environments within Microsoft 365 — environment strategy, the default environment, Managed Environments, environment groups, DLP, tenant isolation, identity, and monitoring."
date: 2026-05-16
author: admin
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/05/charles-forerunner-3fPXt37X6UQ-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@charles_forerunner?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Charles Forerunner</a> on <a href="https://unsplash.com/photos/people-standing-inside-city-building-3fPXt37X6UQ?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>


tags: [copilotstudio, agents, governance, powerplatform, dataverse, security, compliance]
featured: true
toc: true
---

{: .q-left }
> **Summary lede.** Power Platform and Copilot Studio now let every licensed Microsoft 365 user build apps, automations, and AI agents that touch enterprise data. This first part of a two-article reference walks through the platform-level foundations that everything else rests on — environment strategy, default-environment hardening, Managed Environments, environment groups and rules, DLP, tenant isolation, identity, and monitoring — and shows how they combine into a coherent, enforceable posture. Part 2 next week will cover Copilot Studio governance, agent authentication, ALM and pipelines, solution checker, licensing, and change management.

{: .q-left }
> **Who this is for.** Power Platform administrators, security or compliance officers responsible for a Microsoft 365 tenant, Center of Excellence leads, architects designing a low-code or AI-agent platform, and makers who want to understand the guardrails around the tools they build with. The document replaces fragmented documentation with an ordered walkthrough of what actually exists today: CLI snippets, PowerShell examples, and direct links to authoritative Microsoft Learn pages. Nothing here is speculative, so the patterns can be applied to a tenant without waiting for a future release. If you need to defend an environment posture to auditors, onboard a new admin, set priorities for a governance rollout, or decide what "good" looks like for your tenant, this gives you the vocabulary, the examples, and the reasoning in one place.

## Why governance matters

Power Platform and Copilot Studio have turned a large part of every Microsoft 365 tenant into a build surface. Employees who never wrote code are now authoring apps, flows, and AI agents that read from SharePoint, write to Dataverse, send email on behalf of users, and call external APIs. That shift changes the risk profile of the tenant in ways that are visible to three constituencies, each with a different stake.

For **the business**, governance is what keeps low-code and AI investments returning value instead of accumulating liability. Ungoverned environments grow a long tail of half-finished apps, orphaned flows, and agents with unknown owners — each one a support ticket, compliance finding, or incident waiting to happen. Regulators increasingly ask who authored a control, what data it touched, and how changes were approved. A documented governance posture answers those questions without forensic archaeology and lets the business say *yes* to new use cases because the controls are already in place.

For **IT**, governance is the mechanism that preserves tenant integrity while the perimeter expands. Data Loss Prevention, tenant isolation, identity controls, and pipelines are not optional add-ons; they are how IT shifts from gatekeeper to platform operator. Without them, the only available stance is blanket denial — which does not reduce risk, because work simply moves to spreadsheets, personal accounts, and shadow SaaS where IT has no visibility at all. With them, IT can set guardrails at the platform level, delegate day-to-day authoring to business units, and focus engineering time on integrations, security, and automation.

For **makers**, governance is the difference between building with confidence and building in the dark. Clear environment boundaries, known DLP rules, a predictable ALM path, and a Center of Excellence to turn to all reduce the cognitive load of citizen development. Makers who know what is allowed spend their time on business logic, not on working around unclear policy. Maker welcome content, solution checker, and sharing limits exist to shorten the feedback loop so that problems are caught while they are still cheap to fix.

This first article works through the platform-level foundations: environment design, the default environment, Managed Environments, environment groups, DLP, tenant isolation, identity, and monitoring. Each control begins with the reason it exists, moves to the how, and points you to the authoritative Microsoft Learn page. Part 2 will build on this base by covering the resources that live inside those environments — Copilot Studio agents, ALM, licensing, and change management.

{: .important }
**A note on the kits.** 
If you are coming to this article expecting the **CoE Starter Kit** or the **ALM Accelerator** to do the governance heavy lifting: that picture has changed. Microsoft has confirmed that the **CoE Starter Kit is no longer actively maintained** — its core capabilities are now part of the Power Platform admin center — and the **ALM Accelerator for Power Platform is formally deprecated**, with **Power Platform Pipelines** as the named replacement. Section 8.6 covers the CoE Starter Kit transition to the admin center; section 3.5 covers the ALM Accelerator → Pipelines transition; the rest of the article reflects that shift.

---

## 1. Environment Strategy

An environment in Power Platform is a container for apps, flows, agents, connections, and Dataverse data. Environment design is the foundation of governance because DLP scope, security roles, capacity, and compliance boundaries all follow environment lines. Get the topology right and every later control has somewhere clean to attach. Get it wrong and you spend the rest of the rollout retrofitting policy onto a sprawl.

### 1.1 Know the environment types

**Why.** Each type carries different defaults for licensing, data residency, and lifecycle. Choosing the wrong type at provisioning time creates rework that is rarely cheap to undo.

**How.** Five types are in active use today:

- **Default** — one per tenant, created automatically, open to every licensed user.
- **Production** — business-critical workloads, backed by Dataverse.
- **Sandbox** — non-production, resettable, suitable for UAT and load tests.
- **Developer** — single-maker environments, created manually or via routing.
- **Trial** and **Teams** — time-limited or chat-scoped; not recommended for production assets.

**Learn more.** [Environments overview](https://learn.microsoft.com/power-platform/admin/environments-overview).

### 1.2 Adopt a topology that mirrors your delivery lifecycle

**Why.** A topology aligned with how your organization actually builds shortens the path from idea to production and gives every governance rule (DLP, sharing limits, release channel) a natural place to land.

**How.** A typical enterprise pattern separates by lifecycle and purpose:

```
Default  -> personal productivity only (restricted)
DEV-*    -> per-maker or per-team developer environments
TEST-*   -> solution UAT with production-like data volume
PROD-*   -> published solutions, scoped by region or business unit
```

Add a dedicated **CoE** environment for governance tooling (pipelines host and any remaining CoE Starter Kit components — see section 8.6 for the kit's status) and a **training** environment for enablement.

**Learn more.** [Establishing an environment strategy](https://learn.microsoft.com/power-platform/guidance/adoption/environment-strategy).

### 1.3 Restrict who can create environments

**Why.** Self-service environment creation is the fastest way to lose tenant-wide visibility. Most makers do not need to create environments; the few who do should be deliberately empowered.

**How.** In tenant settings, configure `Who can create production and sandbox environments` and `Who can create trial environments` to limit creation to admins or a named CoE group. For repeatable provisioning, drive creation through the CLI:

```
pac admin create --name "DEV-Finance-EU" --type Sandbox --region europe
```

**Learn more.** [Control who can create environments](https://learn.microsoft.com/power-platform/admin/control-environment-creation), [pac admin reference](https://learn.microsoft.com/power-platform/developer/cli/reference/admin).

### 1.4 Pick a region before you provision

**Why.** Environments are region-locked. Region determines data residency, latency, and which regional services (Application Insights endpoints, Dataverse data centers) integrate cleanly. Moving an environment between regions is not a supported operation.

**How.** Choose the region from the regional catalog at provisioning time. For regulated workloads, pick the region that satisfies the controlling jurisdiction even if it is not where most of your users sit.

**Learn more.** [Environment regions](https://learn.microsoft.com/power-platform/admin/regions-overview).

### 1.5 Plan capacity before you turn on Dataverse

**Why.** Dataverse-enabled environments draw from a tenant-wide capacity pool. Capacity surprises are a leading cause of unplanned read-only mode in production.

**How.** Any Dataverse-enabled environment — production or sandbox — requires the tenant-level minimum of 1 GB of database capacity. Capacity is a tenant pool, not a per-environment allocation, so plan total tenant capacity against the number of Dataverse-enabled environments you intend to run.

**Learn more.** [About Dataverse storage capacity](https://learn.microsoft.com/power-platform/admin/about-storage-capacity).

### 1.6 Isolate regulated workloads

**Why.** DLP, security roles, and Dataverse auditing settings are scoped per environment. Mixing regulated and non-regulated workloads in the same environment forces every control to be the strictest common denominator and complicates compliance reporting.

**How.** Provision separate environments for HR, Finance, and other regulated workloads. Each one becomes a clean target for environment-specific DLP, role assignments, and backup retention.

**Learn more.** [Establishing an environment strategy](https://learn.microsoft.com/power-platform/guidance/adoption/environment-strategy).

---

## 2. Governing the Default Environment

The default environment is the only environment created automatically in every Power Platform tenant. Every licensed user is a member and holds the `Environment Maker` role, which lets them create apps, flows, connections, and Copilot Studio agents. It is always present, always writable, and cannot be deleted or renamed — which makes it the single most common source of shadow IT on the platform. It needs explicit governance, not benign neglect.

### 2.1 Understand what makes the default environment different

**Why.** Treating the default environment like any other production environment leads to surprises. Several behaviors are unique to it and cannot be disabled.

**How.** Plan around four facts:

- It cannot be deleted. It can be renamed and reassigned to a non-default type for display purposes, but Microsoft treats it as the fallback environment for personal productivity.
- Every new tenant user inherits `Environment Maker`. There is no tenant setting that removes this role on the default environment.
- Dataverse is optional by default, but once added it cannot be removed.
- Connectors default to the same tenant-wide DLP policy as any other non-scoped environment.

**Learn more.** [Default environment overview](https://learn.microsoft.com/power-platform/admin/environments-overview#the-default-environment).

### 2.2 Rename and tag for clarity

**Why.** Makers cannot make good decisions about where to build if the default environment looks like any other production candidate. The name is the first signal.

**How.** Rename the default environment to something like `Personal Productivity (Default)` so its purpose is unambiguous. Apply a consistent solution-naming convention for any assets that genuinely belong there (such as personal flows).

**Learn more.** [Default environment overview](https://learn.microsoft.com/power-platform/admin/environments-overview#the-default-environment).

### 2.3 Attach a restrictive DLP policy

**Why.** The default environment is where ungoverned makers land first. A restrictive DLP policy turns the blast radius from "every connector Microsoft ships" into a known, defensible set.

**How.** Move risky connectors (HTTP, custom connectors, social media, unauthenticated agent chat) to `Blocked`. Keep only Microsoft 365, Dataverse, and a short approved list in `Business`.

**Learn more.** [Data policies overview](https://learn.microsoft.com/power-platform/admin/wp-data-loss-prevention).

### 2.4 Keep Dataverse out (or contained) by default

**Why.** Once Dataverse is added to the default environment, it cannot be removed. Production data living next to ungoverned personal flows is a compliance problem that is hard to walk back.

**How.** If the default environment still lacks Dataverse, leave it off. Production data belongs in dedicated environments where capacity and backup are managed deliberately.

**Learn more.** [Default environment overview](https://learn.microsoft.com/power-platform/admin/environments-overview#the-default-environment).

### 2.5 Constrain sharing through Managed Environments

**Why.** Without sharing limits, a maker can publish an app or agent to the entire tenant with one click. The default environment is the most common origin for that mistake.

**How.** Convert the default environment to a Managed Environment and apply `Limit sharing` rules: cap the number of users an asset can be shared with and disable sharing through security groups. Mechanics are covered in section 3.

**Learn more.** [Limit sharing in Managed Environments](https://learn.microsoft.com/power-platform/admin/managed-environment-sharing-limits).

### 2.6 Enable default environment routing

**Why.** The cleanest way to keep the default environment empty is to redirect new makers somewhere else automatically. Routing replaces "the default environment is where people end up" with "the default environment is where nobody builds."

**How.** Turn on **default environment routing** under **Settings > Default environment routing** in the Power Platform admin center. Each routed maker receives a personal developer environment; group those environments with **Environment groups** and apply policies in bulk (sharing limits, maker welcome content, solution checker).

**Learn more.** [Default environment routing](https://learn.microsoft.com/power-platform/admin/default-environment-routing), [Environment groups](https://learn.microsoft.com/power-platform/admin/environment-groups).

### 2.7 Lock down agents and Copilot in the default environment

**Why.** Copilot Studio agents created in the default environment are immediately discoverable by all licensed users. Without explicit controls, makers can publish unauthenticated agents, call any non-blocked connector, and add knowledge sources the creator already has access to.

**How.** Apply layered controls: convert the default environment to a Managed Environment, block the `Chat without Microsoft Entra ID authentication in Copilot Studio` connector in DLP, block the `HTTP` and `HTTP with Microsoft Entra ID` connectors, and enable tenant-level Copilot Studio restrictions on who can publish.

**Learn more.** [Data policies for Copilot Studio](https://learn.microsoft.com/microsoft-copilot-studio/admin-data-loss-prevention), [Tenant settings reference](https://learn.microsoft.com/power-platform/admin/tenant-settings).

### 2.8 Turn on monitoring before you need it

**Why.** Telemetry collected after an incident is worth less than telemetry collected before one. Get visibility on the default environment first, because that is where ungoverned activity tends to land.

**How.** Enable **tenant-level analytics** in the Power Platform admin center to capture telemetry. Use the admin center **Inventory**, **Usage**, **Monitor**, and **Actions** experiences to list apps, flows, and agents by owner — these have replaced the CoE Starter Kit inventory flows (see section 8.6). Review the Managed Environments **weekly digest** for inactive and top-used assets.

**Learn more.** [Tenant-level analytics](https://learn.microsoft.com/power-platform/admin/tenant-level-analytics).

### 2.9 A starting DLP stance

The example below is not a policy you should ship verbatim, but it is a defensible starting point for a default environment that has no other governance in place:

```
Business group:    Microsoft 365 connectors (Outlook, SharePoint, Teams, OneDrive), Dataverse, Approvals
Non-business:      (empty)
Blocked:           HTTP, HTTP with Microsoft Entra ID, custom connectors,
                   Chat without Microsoft Entra ID authentication in Copilot Studio,
                   SMTP, FTP, social media connectors
```

**Learn more.** [Create a data policy](https://learn.microsoft.com/power-platform/admin/create-dlp-policy), [Control environment creation](https://learn.microsoft.com/power-platform/admin/control-environment-creation).

---

## 3. Managed Environments

Managed Environments is a premium governance layer that augments a standard environment with administrative controls. Enabling it does not change the environment's region, type, or Dataverse schema; it activates a set of tenant-visible features that admins can enforce. Most of the controls that follow in this document depend on Managed Environments being on.

### 3.1 Limit sharing

**Why.** Uncontrolled sharing is one of the highest-impact governance gaps. A single misconfigured share can expose an app or agent to the entire tenant.

**How.** Cap the number of users an app or agent can be shared with, block sharing through security groups, and block editor sharing. Configure under `Edit Managed Environments > Limit sharing`. Rules apply on the next share action; existing assignments remain.

**Learn more.** [Limit sharing](https://learn.microsoft.com/power-platform/admin/managed-environment-sharing-limits).

### 3.2 Receive a weekly digest

**Why.** Admins do not have time to log into the admin center every day. A scheduled summary keeps inactive and top-used assets in front of them without manual polling.

**How.** Power Platform and Dynamics 365 admins automatically receive an email summary covering active users, top apps, and inactive apps and flows. Add additional recipients via PowerShell:

```
$t = Get-TenantSettings
$t.powerPlatform.governance |
  Add-Member -NotePropertyName additionalAdminDigestEmailRecipients `
             -NotePropertyValue 'coe@contoso.com;ops@contoso.com'
Set-TenantSettings -RequestBody $t
```

**Learn more.** [Usage insights (weekly digest)](https://learn.microsoft.com/power-platform/admin/managed-environment-usage-insights).

### 3.3 Enforce solution checker

**Why.** Static analysis catches problems while they are cheap to fix. Without enforcement, solution checker becomes optional and stops being run.

**How.** Run static analysis on solution import; warn or block. Configure under `Edit Managed Environments > Solution checker` (mechanics in part 2, section 12).

**Learn more.** [Solution checker enforcement](https://learn.microsoft.com/power-platform/admin/managed-environment-solution-checker).

### 3.4 Show maker welcome content

**Why.** Makers who never see your governance guidance cannot follow it. The first experience inside the maker portals is the cheapest channel for organizational rules.

**How.** Configure a banner that appears for new makers in `make.powerapps.com` and `copilotstudio.microsoft.com`. Use it to point makers at internal documentation, the right environments, and approval processes.

**Learn more.** [Managed Environments overview](https://learn.microsoft.com/power-platform/admin/managed-environment-overview).

### 3.5 Host Power Platform Pipelines

**Why.** Power Platform Pipelines are the native, low-code path for promotion across environments. They require Managed Environments to run, and as of 2024 Microsoft has positioned them as the **strategic replacement for the ALM Accelerator for Power Platform**, which is formally deprecated and slated for removal in a future release. New ALM rollouts should start here rather than on the accelerator.

**How.** Designate a Managed Environment as the pipelines host (covered in part 2, section 11). Source and target environments are registered in the host. If your tenant currently runs on the ALM Accelerator canvas app + Azure DevOps templates, treat this as the trigger to plan a migration to Pipelines — the accelerator continues to function for now, but no new investment is going into it.

**Learn more.** [Power Platform Pipelines](https://learn.microsoft.com/power-platform/alm/pipelines), [ALM Accelerator for Power Platform (Deprecated)](https://learn.microsoft.com/power-platform/guidance/alm-accelerator/overview).

### 3.6 Restrict Dataverse access by IP

**Why.** Network-level controls reduce the attack surface even when identity controls are intact. They also satisfy auditors who expect defense in depth.

**How.** **IP firewall** restricts Dataverse access to declared IP ranges. **IP cookie binding** adds session-level enforcement so that a stolen token cannot be replayed from a different network.

**Learn more.** [IP firewall](https://learn.microsoft.com/power-platform/admin/ip-firewall).

### 3.7 Customer Lockbox and Customer-Managed Key

**Why.** Regulated tenants often need explicit approval before Microsoft engineers can access tenant data, and they need encryption keys under their own control.

**How.** Customer Lockbox requires customer approval for Microsoft support access to environment data. Customer-Managed Key brings tenant-controlled keys into Dataverse encryption. Both require premium tenant licensing.

**Learn more.** [Managed Environments overview](https://learn.microsoft.com/power-platform/admin/managed-environment-overview).

### 3.8 Extend backup retention

**Why.** The seven-day default backup window is short for production workloads. An incident discovered on day eight has no restore point.

**How.** Managed Environments support extended retention windows beyond the seven-day default. Configure retention per environment or, for groups, via the `Back-up retention` rule.

**Learn more.** [Manual backups](https://learn.microsoft.com/power-platform/admin/backup-restore-environments).

### 3.9 DLP for desktop flows

**Why.** Desktop (RPA) flows can interact with anything on the host machine, which makes connector-level DLP particularly important for them. The control is gated behind Managed Environments.

**How.** Apply DLP policies to desktop flows the same way you apply them to cloud flows; enforcement happens at design and run time.

**Learn more.** [Data policies overview](https://learn.microsoft.com/power-platform/admin/wp-data-loss-prevention).

### 3.10 Use the Catalog for internal distribution

**Why.** Without a catalog, reusable components are shared informally — by email, by chat, by file share — and traceability collapses. A catalog gives makers an approved internal store.

**How.** Publish components (templates, connectors, plug-ins) to the Catalog so makers can install them with provenance and version metadata.

**Learn more.** [Managed Environments overview](https://learn.microsoft.com/power-platform/admin/managed-environment-overview).

### 3.11 Plan for the licensing implications

**Why.** Managed Environments changes how runtime licensing works for users, and that change is the most common surprise during rollout.

**How.** Every user who activates an app, flow, or agent in a Managed Environment must hold a premium Power Platform license (Power Apps per user/per app, Power Automate Premium, or Dynamics 365). Confirm license posture before flipping the switch.

**Learn more.** [Power Platform licensing overview](https://learn.microsoft.com/power-platform/admin/pricing-billing-skus).

### 3.12 Enabling

**Why.** The toggle is per environment, so enablement is a deliberate act, not a tenant flag.

**How.** In the Power Platform admin center, choose the environment, then `Edit Managed Environments`. From the CLI:

```
pac admin set-governance-config --environment-id <GUID> --protection-level Standard
```

**Learn more.** [Enable Managed Environments](https://learn.microsoft.com/power-platform/admin/managed-environment-enable).

### 3.13 When to enable

**Why.** Managed Environments costs licensing and increases admin overhead. Enabling it everywhere is wasteful; enabling it nowhere defeats the purpose.

**How.** Use Managed Environments for any environment with production workloads, external sharing, or sensitive data. Apply it to personal developer environments created by default environment routing so sharing limits and solution checker apply uniformly.

**Learn more.** [Managed Environments overview](https://learn.microsoft.com/power-platform/admin/managed-environment-overview).

---

## 4. Environment Groups and Rules

Environment groups organize Managed Environments into collections so admins can apply policies in bulk. Each environment belongs to at most one group; groups cannot be nested or overlap; non-managed environments cannot be added.

### 4.1 Group environments by policy intent

**Why.** Without grouping, every environment is a one-off configuration. As the platform scales, that becomes unmaintainable. Groups let policy intent travel with environments instead of with people.

**How.** Build groups around policy needs rather than reporting structure: a regulated production group, a pilot group for previews, a routed personal-productivity group, an admin/CoE group. A typical layout:

```
Personal Productivity        -> routed per-maker developer envs; sharing disabled
Pilot                        -> experimental AI features on; release channel = Monthly
Production EU                -> AI off for regulated data; release channel = Auto
Production US                -> same policies as EU, separate region
CoE / Admin                  -> governance tooling; locked down
```

**Learn more.** [Environment groups](https://learn.microsoft.com/power-platform/admin/environment-groups).

### 4.2 Apply rules at the group level

**Why.** When a rule is published at the group level, the corresponding setting becomes read-only inside each member environment. This makes policy enforceable rather than advisory; per-environment overrides are not supported.

**How.** Use the admin center to publish any of the rules currently available (generally available unless noted):

- Sharing agents with Editor permissions
- Sharing agents with Viewer permissions
- Sharing controls for canvas apps
- Sharing controls for solution-aware cloud flows
- AI-powered Copilot features
- Generative AI settings
- External models
- AI prompts
- Accessing transcripts from conversations in Copilot Studio agents
- Sharing data between Copilot Studio and Viva Insights
- Maker welcome content
- Release channel
- Back-up retention
- Solution checker enforcement
- Unmanaged customizations
- Usage insights
- Power Apps component framework for canvas apps
- Content security policy
- Power Apps code apps
- Preview and experimental AI models
- Default deployment pipeline (preview)
- Advanced connector policy (preview)
- AI-generated descriptions (preview)

**Learn more.** [Rules for environment groups](https://learn.microsoft.com/power-platform/admin/environment-groups-rules).

### 4.3 Manage group membership from the CLI

**Why.** Group membership changes are routine — onboarding new environments, retiring old ones — and should be scriptable. Rule definitions still live in the admin center; the CLI handles membership.

**How.** Use the `pac admin` group commands:

```
pac admin list-groups
pac admin add-group --environment <env-id> --environment-group <group-id>
```

**Learn more.** [pac admin reference](https://learn.microsoft.com/power-platform/developer/cli/reference/admin).

### 4.4 Plan for group removal

**Why.** Removing an environment from a group is a half-revert: rule values stay where they were, but the environment becomes editable again locally. Without a manual reconciliation step, the environment can drift in ways that are hard to detect.

**How.** When you remove an environment from a group, treat the action as the start of a configuration review. Reconcile every formerly group-managed setting against your current standard before declaring the migration done.

**Learn more.** [Environment groups](https://learn.microsoft.com/power-platform/admin/environment-groups).

### 4.5 Pair groups with default environment routing

**Why.** Routed personal developer environments multiply quickly. Without grouping, you end up with hundreds of environments each configured independently.

**How.** Auto-route new makers into personal environments, then assign those environments to a `Personal Productivity` group with sharing disabled and solution checker enforced. Policies follow membership automatically.

**Learn more.** [Default environment routing](https://learn.microsoft.com/power-platform/admin/default-environment-routing).

---

## 5. Data Loss Prevention Policies

Data Loss Prevention (DLP) policies in Power Platform control which connectors can be combined inside apps, flows, and agents. Policies apply to Power Apps, Power Automate cloud flows, desktop flows (in Managed Environments), and Copilot Studio agents.

### 5.1 Sort connectors into three groups

**Why.** Data leaks happen when organizational data moves alongside non-organizational connectors in the same resource. The three-group model is how Power Platform prevents that combination at design time.

**How.** Place each connector into one of three groups:

- **Business** — connectors that can exchange organizational data with each other.
- **Non-business** — connectors that can exchange non-organizational data with each other.
- **Blocked** — connectors that cannot be used at all.

Data cannot flow between Business and Non-business within the same resource.

**Learn more.** [Data policies overview](https://learn.microsoft.com/power-platform/admin/wp-data-loss-prevention).

### 5.2 Set the default group for new connectors

**Why.** Microsoft adds connectors continuously. If new connectors land in a permissive group by default, your DLP posture decays without anyone editing policy.

**How.** Set the **Default group** to `Blocked`. New connectors stay blocked until an admin explicitly classifies them.

**Learn more.** [Create a data policy](https://learn.microsoft.com/power-platform/admin/create-dlp-policy).

### 5.3 Choose the right policy scope

**Why.** A tenant-wide policy is the right baseline for high-risk connectors, but environment-specific policies let you allow connectors where they are needed without opening them everywhere.

**How.** Target a policy at all environments (with optional exclusions), at specific environments, or only at the default environment. Policies aggregate: a connector blocked by *any* applicable policy is blocked for that environment.

**Learn more.** [Create a data policy](https://learn.microsoft.com/power-platform/admin/create-dlp-policy).

### 5.4 Filter by endpoint

**Why.** A blanket block on `HTTP` is often too restrictive. Endpoint filtering keeps the connector available for the URLs you actually need while denying everything else.

**How.** Allow or block specific URLs on HTTP-capable connectors, SQL Server, Azure Blob, and others. This is a premium-tier capability.

**Learn more.** [Endpoint filtering](https://learn.microsoft.com/power-platform/admin/connector-endpoint-filtering).

### 5.5 Restrict individual connector actions

**Why.** Many connectors expose both safe (read) and dangerous (arbitrary execute) actions. Action control lets you keep the safe ones while blocking the dangerous ones.

**How.** Allow or block individual actions on a connector — for example, block `Execute a SQL query` on SQL Server while allowing table reads. Premium tier.

**Learn more.** [Connector action control](https://learn.microsoft.com/power-platform/admin/connector-action-control).

### 5.6 Allow-list custom connector patterns

**Why.** Custom connectors are an open door if left ungoverned. Pattern-based allow-listing lets you approve a class of internal endpoints without approving every custom connector individually.

**How.** Allow-list custom connectors by URL pattern. Pair with a tenant-wide block on unmatched custom connectors.

**Learn more.** [Connector endpoint filtering](https://learn.microsoft.com/power-platform/admin/connector-endpoint-filtering).

### 5.7 A high-risk tenant baseline

The example below is a defensible starting point for a tenant where regulated data lives next to general productivity:

```
Business:      Microsoft 365 connectors (Outlook, Teams, SharePoint, OneDrive),
               Dataverse, Approvals, Planner
Non-business:  Bing Search, Translator, MSN Weather
Blocked:       HTTP, HTTP with Microsoft Entra ID (unless endpoint-filtered),
               custom connectors in default env, Twitter/X, Facebook, SMTP, FTP,
               Chat without Microsoft Entra ID authentication in Copilot Studio
Default group: Blocked
```

**Learn more.** [Create a data policy](https://learn.microsoft.com/power-platform/admin/create-dlp-policy).

### 5.8 Manage DLP from PowerShell

**Why.** UI configuration does not survive disaster recovery, audit reproduction, or environment cloning. Scripted policy management does.

**How.** Use the DLP cmdlets to retrieve, create, and modify policies:

```
Get-DlpPolicy
New-DlpPolicy -DisplayName "Tenant baseline"
# manage connector groups via Set-DlpPolicyDefaultConnectorGroup, Add-ConnectorToBusinessDataGroup, etc.
```

**Learn more.** [DLP PowerShell cmdlets](https://learn.microsoft.com/power-platform/admin/powerapps-powershell#data-loss-prevention-dlp-policy-commands).

### 5.9 Understand enforcement timing

**Why.** Knowing when a policy takes effect is critical during incident response — and during planned changes that you do not want to break in production at noon.

**How.** Policy changes take effect within minutes for new resources and on the next save or publish for existing ones. Copilot Studio enforces DLP in real time; makers see a validation error immediately when a blocked connector is referenced.

**Learn more.** [Data policies overview](https://learn.microsoft.com/power-platform/admin/wp-data-loss-prevention).

---

## 6. Tenant Isolation and Cross-Tenant Controls

Tenant isolation restricts which external Microsoft Entra ID tenants can be used as the identity source for connections inside your Power Platform tenant. It is a separate control from DLP and from Microsoft Entra B2B. DLP governs *which connectors* can be used; tenant isolation governs *which tenants users can authenticate to* when creating a connection.

### 6.1 Distinguish inbound from outbound

**Why.** Tenant isolation is directional. Mixing the two leads to either over-blocking (legitimate B2B work breaks) or under-blocking (data exfiltration paths remain).

**How.** Configure each direction explicitly:

- **Inbound** — another tenant's users creating a connection that points into your tenant.
- **Outbound** — your tenant's users creating a connection that points into another tenant.

**Learn more.** [Tenant isolation](https://learn.microsoft.com/power-platform/admin/cross-tenant-restrictions).

### 6.2 Verify your default — it depends on tenant age

**Why.** The default behavior changed in 2026, and assumptions from older guidance no longer apply universally.

**How.** Tenants created **before 30 March 2026** have both directions allowed by default; tenant isolation must be enabled explicitly. Tenants created **on or after 30 March 2026** ship with tenant isolation enabled and both directions defaulting to deny — only allow-listed tenant IDs can be used. Verify the current state in your tenant rather than assuming a default.

**Learn more.** [Restrict cross-tenant inbound/outbound](https://learn.microsoft.com/power-platform/admin/cross-tenant-restrictions#enable-tenant-isolation).

### 6.3 Configure tenant isolation deliberately

**Why.** The control is tenant-wide; there is no per-environment override. A misconfiguration affects the entire tenant.

**How.** In the Power Platform admin center, under `Security > Tenant isolation`, set:

```
Tenant isolation: On
Default:          Block
Exceptions:       contoso-partner.onmicrosoft.com  (Inbound, Outbound)
                  fabrikam.onmicrosoft.com          (Outbound only)
```

**Learn more.** [Tenant isolation](https://learn.microsoft.com/power-platform/admin/cross-tenant-restrictions).

### 6.4 Know what tenant isolation does *not* cover

**Why.** Tenant isolation is sometimes mistaken for a complete cross-tenant boundary. It is not. Pairing it with the right Entra controls is the only way to close the gap.

**How.** Tenant isolation applies to connectors that authenticate with Microsoft Entra ID (SharePoint, OneDrive, Dataverse, Outlook, Microsoft 365, Azure, etc.). It does not apply to:

- Connectors that use API keys or generic OAuth.
- Service principal and managed identity authentication, which follow Microsoft Entra cross-tenant access policies.

Pair tenant isolation with Microsoft Entra cross-tenant access settings for a complete boundary.

**Learn more.** [Tenant isolation](https://learn.microsoft.com/power-platform/admin/cross-tenant-restrictions).

### 6.5 Layer Conditional Access

**Why.** Tenant isolation controls *where* identities can come from; Conditional Access controls *under what conditions* identity is accepted. Both layers are needed.

**How.** Apply Conditional Access policies to the `Power Platform API` application to restrict sign-in by user, device, location, and risk.

**Learn more.** [Conditional Access for Power Platform](https://learn.microsoft.com/power-platform/admin/conditional-access).

### 6.6 Layer the IP firewall

**Why.** Network-level controls reduce the attack surface even when identity controls are intact. They also satisfy auditors who expect defense in depth.

**How.** The IP firewall (Managed Environments) restricts Dataverse access to declared IP ranges. Configure per environment.

**Learn more.** [IP firewall](https://learn.microsoft.com/power-platform/admin/ip-firewall).

### 6.7 Enable continuous access evaluation

**Why.** Static sign-in evaluation cannot react to changes in identity posture mid-session. CAE narrows the window between an account becoming risky and that account losing access.

**How.** Continuous access evaluation (CAE) on Dataverse revokes sessions when identity posture changes — for example, when a user is disabled or moves outside an allowed network.

**Learn more.** [Conditional Access for Power Platform](https://learn.microsoft.com/power-platform/admin/conditional-access).

### 6.8 Monitor configuration changes and runtime denials

**Why.** Tenant isolation is most useful when its events are visible. Two surfaces matter: configuration changes (someone modifying the policy) and runtime denials (someone hitting the policy).

**How.** Tenant isolation events flow to the Power Platform audit log and the Microsoft Purview unified audit log. Configuration changes appear under the `TenantIsolationPolicyUpdate` activity; runtime denials surface as connection-creation failures rather than under a single unified filter — review both when investigating.

**Learn more.** [Audit logs](https://learn.microsoft.com/power-platform/admin/audit-logs).

---

## 7. Security Roles and Identity

Power Platform authorization is layered. Microsoft Entra ID provides tenant-level identity and global roles; Dataverse provides row- and column-level security inside each environment; connectors use per-user or service-principal credentials.

### 7.1 Use the right tenant role

**Why.** Tenant-scoped governance work does not need Global Administrator. Over-privileged accounts increase blast radius without buying capability.

**How.** Pick from the Microsoft Entra ID roles that govern Power Platform:

- **Power Platform Administrator** — full control of environments, DLP, tenant settings, licenses (within Power Platform scope). Sufficient for almost all governance work.
- **Dynamics 365 Administrator** — equivalent scope for Dynamics 365 and Dataverse-backed environments.
- **Global Administrator** — superset; not recommended for day-to-day platform work.
- **Fabric Administrator** — required for Power BI workspace and capacity governance that overlaps Power Platform.

Assign least-privileged roles.

**Learn more.** [Microsoft Entra roles for Power Platform](https://learn.microsoft.com/power-platform/admin/use-service-admin-role-manage-tenant).

### 7.2 Map environment roles to job function

**Why.** Environment roles control everything inside an environment, including who can hand out further roles. A misassignment here is hard to roll back without auditing.

**How.** Inside each environment, the standard roles are:

- **System Administrator** — root of the environment; can assign any role.
- **System Customizer** — schema and solution changes without user management.
- **Environment Maker** — create apps, flows, agents, and custom connectors.
- **Basic User** — runtime access to assigned records.
- **Delegated Admin** — scoped admin, granted via Microsoft Entra ID groups.

**Learn more.** [Dataverse security roles](https://learn.microsoft.com/power-platform/admin/database-security).

### 7.3 Build custom roles from a known baseline

**Why.** Privileges in Dataverse are granular; granting `*` privileges in a custom role is the fastest way to recreate the problems custom roles were supposed to solve.

**How.** Always start from a copy of an out-of-box role and remove or add the privileges you need at table, action, and column level. Avoid wildcard privileges.

**Learn more.** [Dataverse security roles](https://learn.microsoft.com/power-platform/admin/database-security).

### 7.4 Prefer teams over individual sharing

**Why.** Individual record sharing is auditable in theory and unmaintainable in practice. Teams turn membership into access.

**How.** Use **Owner teams** or **Access teams** for direct ownership and sharing. For large memberships, use **Microsoft Entra group teams** so group membership drives row access automatically.

**Learn more.** [Microsoft Entra group teams](https://learn.microsoft.com/power-platform/admin/manage-group-teams).

### 7.5 Use service principals for non-interactive work

**Why.** Pipelines, integrations, and admin automation should not depend on human accounts. Service principals carry their own lifecycle and credentials, which is what audit and compliance expect.

**How.** Register the app in Microsoft Entra ID, then assign an application user:

```
pac admin create-service-principal `
  --environment <env-id> `
  --name "Pipelines SPN" `
  --role "System Administrator"
```

Rotate secrets and prefer federated credentials or managed identities where supported.

**Learn more.** [Application users](https://learn.microsoft.com/power-platform/admin/manage-application-users).

### 7.6 Apply Conditional Access and MFA

**Why.** Identity is the perimeter. Conditional Access and MFA are how that perimeter actually behaves under load — risky logins, anomalous locations, compromised credentials.

**How.** Apply Conditional Access to the `Power Platform API` app and to `Microsoft Dataverse`. Enforce MFA for administrators and for makers who connect to sensitive data sources.

**Learn more.** [Conditional Access](https://learn.microsoft.com/power-platform/admin/conditional-access).

---

## 8. Monitoring, Analytics, and Tenant Inventory

Governance without telemetry degrades quickly. Power Platform exposes several monitoring surfaces; the **Inventory**, **Usage**, **Monitor**, and **Actions** experiences in the Power Platform admin center wrap them into a tenant-wide inventory and alerting layer that Microsoft maintains as a first-party feature. The community **CoE Starter Kit** filled this role for years but is no longer actively maintained — section 8.6 covers what that transition means in practice.

### 8.1 Use admin center analytics for per-environment visibility

**Why.** Most operational questions ("is anyone using this app?", "are flow runs failing?") have answers in the admin center. Reaching for the CoE Starter Kit before checking the built-in analytics wastes time.

**How.** Per-environment charts cover Power Apps usage, Power Automate runs, Dataverse API calls, and Copilot Studio sessions. Tenant-level analytics must be enabled in tenant settings before charts populate.

**Learn more.** [Tenant-level analytics](https://learn.microsoft.com/power-platform/admin/tenant-level-analytics).

### 8.2 Push the weekly digest to a wider audience

**Why.** The digest is a high-signal, low-noise summary. Only Power Platform and Dynamics 365 admins receive it by default, which is usually too narrow.

**How.** Add CoE leads, security reviewers, and operations partners using `additionalAdminDigestEmailRecipients` (mechanics in section 3.2).

**Learn more.** [Usage insights (weekly digest)](https://learn.microsoft.com/power-platform/admin/managed-environment-usage-insights).

### 8.3 Stream audit events to Microsoft Purview

**Why.** Platform-level actions — DLP changes, environment creations, sharing events — must be reviewable months after they happen. Purview is the long-term store.

**How.** Power Platform activities flow natively into the Microsoft Purview unified audit log. Search them in the Purview portal, with the `Search-UnifiedAuditLog` Exchange Online PowerShell cmdlet, or via the Microsoft 365 Audit API.

**Learn more.** [Audit logs and Purview](https://learn.microsoft.com/power-platform/admin/manage-dataverse-auditing), [Search the audit log](https://learn.microsoft.com/purview/audit-search).

### 8.4 Turn on Dataverse auditing per table

**Why.** Per-table read and change auditing is the only way to answer record-level forensic questions ("who saw this row?", "what changed and when?"). Without it, the trail stops at the API layer.

**How.** Enable auditing on tables that hold sensitive data. Retention follows the environment's audit retention setting; review it before assuming you have history.

**Learn more.** [Audit logs and Purview](https://learn.microsoft.com/power-platform/admin/manage-dataverse-auditing).

### 8.5 Export to Application Insights

**Why.** Built-in analytics is summary-level. Application Insights gives you raw traces for performance and error analysis — the same signal an Azure team would expect.

**How.** In an environment's settings under `Product > Application Insights (preview)`, add the connection string:

```
InstrumentationKey=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx;
IngestionEndpoint=https://westeurope-1.in.applicationinsights.azure.com/
```

Power Apps emit `pageView`, `traceEvent`, and error events; model-driven apps add form performance metrics.

**Learn more.** [Application Insights for Power Platform](https://learn.microsoft.com/power-platform/admin/app-insights-app-making).

### 8.6 The CoE Starter Kit and ALM Accelerator — what changed

**Why.** Until recently, the **CoE Starter Kit** and the **ALM Accelerator for Power Platform** were the two community-driven kits most enterprise governance setups leaned on — one for inventory and oversight, the other for solution promotion and source control. Both have now been superseded by native, in-product experiences, and following the old guidance without qualification leads new tenants down a maintenance dead end.

**How.** Two formal status updates to be aware of:

- **CoE Starter Kit — no longer actively maintained (Microsoft, May 2026).** The Microsoft Learn page now opens with a clear notice: *"The Power Platform CoE Starter Kit is no longer actively maintained. Its core capabilities are part of the Power Platform admin center. Issues are no longer reviewed or addressed."* The kit remains available for existing and new deployments, but it will not receive new features and GitHub issues are not triaged. Microsoft directs admins to the native admin center experiences instead:

  - **Inventory** — view and govern all apps, flows, and agents across the tenant.
  - **Usage** — track adoption and identify top resources and their owners.
  - **Monitor** — operational health of heavily used resources.
  - **Actions** — surface risks, enforce best practices, and act on governance insights.

  Beyond the UI, the same data is reachable through the **Power Platform CLI**, the **Power Platform API**, the **Power Platform inventory API**, and the **Power Platform for Admins V2** connector — which is what to build automation against going forward.

- **ALM Accelerator for Power Platform — formally deprecated (Microsoft Learn page last updated 2024-04-24).** Microsoft's overview page is now titled *"ALM Accelerator for Power Platform (Deprecated)"* and carries this notice: *"The ALM Accelerator is deprecated and will be removed in a future release. Use Pipelines in Power Platform to bring ALM automation capabilities to Power Platform and Dynamics 365 services. Pipelines can be used with source code integration or extended to integrate with other providers."* The accelerator was a canvas-app-plus-Azure-Pipelines reference implementation; the strategic replacement is the in-product **Power Platform Pipelines** experience (introduced in section 3.5 and detailed in part 2). The accelerator continues to function for now, but no new investment is going into it and it is on track to be removed.

**Practical recommendation.** If you already run either kit, keep operating it — neither is being switched off tomorrow — but stop building new dependencies on top of it. For inventory, attestation, and orphaned-asset detection, build against the admin center experiences and the inventory API. For ALM, route new solutions through Power Platform Pipelines and plan a migration off the ALM Accelerator so you are not caught out when a removal date is announced. Tenants starting from scratch in 2026 should skip both kits and build directly on the in-product surfaces.

**Learn more.** [CoE Starter Kit transition to Power Platform admin center](https://learn.microsoft.com/power-platform/guidance/coe/starter-kit), [ALM Accelerator for Power Platform (Deprecated)](https://learn.microsoft.com/power-platform/guidance/alm-accelerator/overview), [Power Platform Pipelines](https://learn.microsoft.com/power-platform/alm/pipelines), [Power Platform inventory API](https://learn.microsoft.com/power-platform/admin/programmability-authentication-v2).

### 8.7 Forward to Microsoft Sentinel

**Why.** SOCs want one queue. Forwarding Power Platform signal to Sentinel puts platform incidents next to the rest of the security telemetry instead of in a separate place no one watches.

**How.** Forward the Power Platform activity log and Purview audit events to Sentinel via the `Microsoft Power Platform administrative logs` data connector. Pre-built analytic rules cover suspicious DLP changes, mass app sharing, and unauthenticated agent publishing.

**Learn more.** [Sentinel connector](https://learn.microsoft.com/azure/sentinel/data-connectors/microsoft-power-platform).

---

## Outlook: what part 2 covers

Part 1 has established the platform-level perimeter — the environments themselves, the policies that bound them, the identities that reach them, and the telemetry that watches them. None of those controls answers the question of what gets *built* inside that perimeter, or how that work moves from a maker's hands into production. That is the territory of part 2.

Next week's article picks up where this one ends and walks through six topics in the same Why → How → Learn more pattern:

- **Governing Microsoft Copilot Studio.** Tenant- and environment-level controls for AI agents, including who can publish, what AI features are allowed where, how knowledge sources are scoped, and how transcripts are retained.
- **Agent authentication and connector governance.** The three authentication modes, the Entra Agent ID model that replaces stored client secrets, the connectors that should be blocked in regulated tenants, and the action-level controls that turn dangerous connectors into safe-but-useful ones.
- **Application Lifecycle Management and pipelines.** Solutions as the unit of deployment, environment variables and connection references, Power Platform Pipelines as the native promotion path (and the strategic replacement for the now-deprecated ALM Accelerator for Power Platform), and when to fall back to Azure DevOps or GitHub.
- **Solution checker and quality gates.** Static analysis for apps, flows, and agents; how to enforce it at solution import; how to read SARIF output; and how agent evaluations complement structural checks with behavioral ones.
- **Licensing and capacity governance.** Power Apps and Power Automate license models, Dataverse capacity allocation, the Copilot Credits consumption model and its gotchas, and how to keep license assignment in sync with employment.
- **Change management and release rings.** The two release channels that actually exist for Power Platform (Auto and Monthly — there is no Semi-Annual), how to gate previews per environment group, in-tenant change categories, administration mode, manual backups, and rollback realities.

If you treat part 1 as the platform on which everything stands, part 2 is everything that runs on that platform. The two are designed to be read together: the controls in part 1 only matter because they shape the work covered in part 2, and the controls in part 2 only stick because the foundations in part 1 hold them up.

---

## Conclusion (Part 1)

Platform-level governance is the foundation of everything else. It is the cumulative result of many small, well-placed controls working together: an environment topology that matches how the organization actually builds, a default environment treated as a perimeter rather than a playground, Managed Environments and environment groups that make policy enforceable at scale, DLP and tenant isolation that bound where data can move, identity and Conditional Access that decide who is allowed to touch the platform at all, and monitoring that turns activity into evidence.

The controls described in this article already exist in the platform today. None of them require custom engineering, third-party tooling, or preview access to be useful. What they require is decision-making: which environments belong in which group, which connectors are business versus non-business, which tenants are trusted for cross-tenant connections, and who has the right to administer what. Those decisions *are* the platform half of governance.

Start small and iterate. A minimum viable foundation is: restrict default environment creation, attach a tenant-wide baseline DLP policy, enable default environment routing with a Managed Environments group, turn on tenant-level analytics, lean on the Power Platform admin center's **Inventory**, **Usage**, **Monitor**, and **Actions** experiences (the CoE Starter Kit is no longer actively maintained — see section 8.6), and verify your tenant isolation defaults. Everything in part 1 is a refinement on that minimum viable foundation; everything in part 2 will be a refinement on top of part 1.

Read on next week for the second half — agents, ALM, licensing, and change management — and a closing recap that ties both articles together.
