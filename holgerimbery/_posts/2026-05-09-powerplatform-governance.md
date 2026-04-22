---
layout: post
title: "Power Platform Governance: A Practitioner's Reference"
description: "A comprehensive guide to managing and securing Power Platform environments, apps, and AI agents within Microsoft 365."
date: 2026-05-09
author: admin
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/05/charles-forerunner-3fPXt37X6UQ-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@charles_forerunner?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Charles Forerunner</a> on <a href="https://unsplash.com/photos/people-standing-inside-city-building-3fPXt37X6UQ?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
      
            
tags: [copilotstudio, agents, governance, powerplatform, dataverse, security, compliance]
featured: true
toc: true
---
{: .q-left }
> **Summary Lede** Power Platform and Copilot Studio now let every licensed Microsoft 365 user build apps, automations, and AI agents that touch enterprise data. This reference describes the controls currently shipping in the platform — environment strategy, default-environment hardening, Managed Environments, environment groups and rules, DLP, tenant isolation, identity, monitoring, Copilot Studio governance, agent authentication and connector controls, ALM and pipelines, solution checker, licensing and capacity, and change management — and explains how they combine into a coherent, enforceable posture.


> **Why read this:** Read this if you are  a Power Platform administrator, a security or compliance officer responsible for a Microsoft 365 tenant, a Center of Excellence lead, an architect designing a low-code or AI agent platform, or a maker who wants to understand the guardrails around the tools you build with. It is a single, linear reference that replaces fragmented documentation with an ordered walkthrough of the controls that actually exist today, with CLI snippets, PowerShell examples, and direct links to the authoritative Microsoft Learn pages. It focuses on current, shipping capabilities — nothing speculative — so the patterns can be applied to a tenant without waiting for a future release. If you need to defend an environment posture to auditors, onboard a new admin, set priorities for a governance rollout, or decide what "good" looks like for your tenant, this document gives you the vocabulary, the examples, and the reasoning in one place.

## Why governance matters

Power Platform and Copilot Studio have turned a large part of every Microsoft 365 tenant into a build surface. Employees who never wrote code are now authoring apps, flows, and AI agents that read from SharePoint, write to Dataverse, send email on behalf of users, and call external APIs. That shift changes the risk profile of the tenant in ways that are visible to three constituencies, each with a different stake.

For **the business**, governance is what keeps low-code and AI investments returning value instead of accumulating liability. Ungoverned environments create a long tail of half-finished apps, orphaned flows, and agents with unknown owners; each one is a support ticket, a compliance finding, or an incident waiting to happen. Regulators increasingly ask who authored a control, what data it touched, and how changes are approved. A documented governance posture answers those questions without forensic archaeology and lets the business say yes to new use cases because the controls are already in place.

For **IT**, governance is the mechanism that preserves tenant integrity while the perimeter expands. Data Loss Prevention, tenant isolation, identity controls, and pipelines are not optional add-ons; they are the means by which IT shifts from gatekeeper to platform operator. Without them, the only available stance is a blanket denial, which does not reduce risk because work moves to spreadsheets, personal accounts, and shadow SaaS where IT has no visibility at all. With them, IT can set guardrails at the platform level, delegate day-to-day authoring to business units, and focus engineering time on integrations, security, and automation.

For **makers**, governance is the difference between building with confidence and building in the dark. Clear environment boundaries, known DLP rules, a predictable ALM path, and a Center of Excellence to turn to all reduce the cognitive load of citizen development. Makers who know what is allowed spend their time on business logic, not on working around unclear policy. Maker welcome content, solution checker, and sharing limits exist to shorten the feedback loop so that problems are caught while they are still cheap to fix.

The rest of this document is a single, linear reference that works through the controls currently available in Power Platform and Copilot Studio, starting with environment design and ending with release management. Each section is self-contained and ends with a link list pointing to the authoritative Microsoft documentation and CLI references.

---

## 1. Environment Strategy for Power Platform Governance

An environment in Power Platform is a container for apps, flows, agents, connections, and Dataverse data. Environment design is the foundation of governance because DLP scope, security roles, capacity, and compliance boundaries all follow environment lines.

### Environment types

- **Default**: one per tenant, created automatically, open to every licensed user.
- **Production**: business-critical workloads, backed by Dataverse.
- **Sandbox**: non-production, resettable, usable for UAT and load tests.
- **Developer**: single-maker environments, created manually or via routing.
- **Trial** and **Teams**: time-limited or chat-scoped, not recommended for production assets.

### Recommended topology

A typical enterprise topology separates by lifecycle and purpose:

```
Default  -> personal productivity only (restricted)
DEV-*    -> per-maker or per-team developer environments
TEST-*   -> solution UAT with production-like data volume
PROD-*   -> published solutions, scoped by region or business unit
```

Add a dedicated **CoE** environment for governance tooling (CoE Starter Kit, pipelines host) and a **training** environment for enablement.

### Provisioning controls

Restrict environment creation to admins through tenant settings (`Who can create production and sandbox environments`) and control trial creation with `Who can create trial environments`. Use `pac admin create` for repeatable provisioning:

```
pac admin create --name "DEV-Finance-EU" --type Sandbox --region europe
```

### Key design decisions

- Data residency: environments are region-locked; choose the region before provisioning.
- Licensing: Dataverse-backed environments consume 1 GB database per production instance.
- Isolation: separate environments per regulated workload (HR, Finance) to contain DLP and role assignments.

### Links

- [Environments overview](https://learn.microsoft.com/power-platform/admin/environments-overview)
- [Control who can create environments](https://learn.microsoft.com/power-platform/admin/control-environment-creation)
- [pac admin reference](https://learn.microsoft.com/power-platform/developer/cli/reference/admin)
- [Environment regions](https://learn.microsoft.com/power-platform/admin/regions-overview)
- [Establishing an environment strategy](https://learn.microsoft.com/power-platform/guidance/adoption/environment-strategy)

---

## 2. Governing the Default Environment

The default environment is the only environment created automatically in every Power Platform tenant. Every licensed user is a member and holds the `Environment Maker` role, which lets them create apps, flows, connections, and Copilot Studio agents. Because it is always present, always writable, and cannot be deleted or renamed, the default environment is the single most common source of shadow IT on the platform. It requires explicit governance rather than being left as a catch-all.

### Why it needs dedicated governance

- It cannot be deleted. It can be renamed and reassigned to a non-default type for display purposes, but Microsoft treats it as the fallback environment for personal productivity.
- Every new tenant user inherits `Environment Maker`. There is no tenant setting that removes this role on the default environment.
- Dataverse is optional by default. If Dataverse is added later, it cannot be removed.
- Connectors default to the same tenant-wide DLP policy as any other non-scoped environment.

### Baseline configuration

1. **Rename and tag**. Rename to something like `Personal Productivity (Default)` so makers recognize it is not a production environment. Tag assets through solution naming conventions.
2. **Attach a restrictive DLP policy**. Move risky connectors (HTTP, custom connectors, social media, unauthenticated agent chat) to `Blocked`. Keep only Microsoft 365, Dataverse, and a short approved list in `Business`.
3. **Block new Dataverse**. If the default environment still lacks Dataverse, leave it off. Production data belongs in dedicated environments.
4. **Restrict app, flow, and agent sharing** through Managed Environments sharing limits (see the Managed Environments section).

### Default environment routing

Enable **default environment routing** so that makers who start building in the default environment are redirected into personal developer environments that are automatically created for them. This keeps the default environment empty of maker content and places each maker's work in an isolated, governable environment.

Turn it on in the Power Platform admin center under **Settings > Default environment routing**, then group the generated personal environments with **Environment groups** and apply policies in bulk (sharing limits, maker welcome content, solution checker).

### Agent and Copilot controls

Copilot Studio agents created in the default environment are immediately discoverable by all licensed users. Without explicit controls:

- Makers can publish agents with `No authentication`, exposing data to anyone with the link.
- Agents can call any connector not blocked by DLP.
- Agents can add knowledge sources (SharePoint sites, websites, files) that the creator has access to.

Mitigate by: converting the default environment to a Managed Environment, blocking the `Chat without Microsoft Entra ID authentication in Copilot Studio` connector in DLP, blocking `HTTP` and `HTTP with Microsoft Entra ID` connectors, and enabling tenant-level Copilot Studio restrictions on who can publish.

### Monitoring

Enable **tenant-level analytics** in the Power Platform admin center to capture telemetry from the default environment. Pair with the CoE Starter Kit inventory flows to list apps, flows, and agents by owner. Review the Managed Environments **weekly digest** for inactive and top-used assets in the default environment.

### Example: minimum DLP stance

```
Business group:    Microsoft 365 connectors (Outlook, SharePoint, Teams, OneDrive), Dataverse, Approvals
Non-business:      (empty)
Blocked:           HTTP, HTTP with Microsoft Entra ID, custom connectors,
                   Chat without Microsoft Entra ID authentication in Copilot Studio,
                   SMTP, FTP, social media connectors
```

### Links

- [Default environment overview](https://learn.microsoft.com/power-platform/admin/environments-overview#the-default-environment)
- [Default environment routing](https://learn.microsoft.com/power-platform/admin/default-environment-routing)
- [Limit sharing in Managed Environments](https://learn.microsoft.com/power-platform/admin/managed-environment-sharing-limits)
- [Data policies for Copilot Studio](https://learn.microsoft.com/microsoft-copilot-studio/admin-data-loss-prevention)
- [Tenant-level analytics](https://learn.microsoft.com/power-platform/admin/tenant-level-analytics)
- [Control environment creation](https://learn.microsoft.com/power-platform/admin/control-environment-creation)
- [Environment groups](https://learn.microsoft.com/power-platform/admin/environment-groups)

---

## 3. Managed Environments

Managed Environments is a premium governance layer that augments a standard environment with administrative controls. Enabling it does not change the environment's region, type, or Dataverse schema. It activates a set of tenant-visible features that admins can enforce.

### Features available today

- **Limit sharing**: cap the number of users an app or agent can be shared with; block sharing through security groups; block editor sharing.
- **Weekly digest**: email summary to Power Platform and Dynamics 365 admins covering active users, top apps, inactive apps and flows.
- **Solution checker enforcement**: run static analysis on solution import; warn or block.
- **Maker welcome content**: a configurable banner for new makers in make.powerapps.com and copilotstudio.microsoft.com.
- **Pipelines** host: Power Platform pipelines require a Managed Environment as host.
- **IP firewall and IP cookie binding**: restrict Dataverse access by IP range.
- **Customer Lockbox** and **Customer-Managed Key** (premium tenants).
- **Extended backup** beyond the 7-day default.
- **DLP for desktop flows**.
- **Catalog** for internal distribution of components.

Licensing note: every user who activates an app, flow, or agent in a Managed Environment must hold a premium Power Platform license (Power Apps per user/per app, Power Automate Premium, Dynamics 365).

### Enabling

Managed Environments is toggled per environment. In the Power Platform admin center choose the environment, then `Edit Managed Environments`. From the CLI:

```
pac admin set-governance-config --environment-id <GUID> --protection-level Standard
```

### Sharing limits example

In the admin center, under `Edit Managed Environments > Limit sharing`:

- `Exclude sharing with security groups`
- `Limit total individuals who can be shared with` = 20

Rules apply on the next share action. Existing assignments remain.

### Weekly digest recipients via PowerShell

```
$t = Get-TenantSettings
$t.powerPlatform.governance |
  Add-Member -NotePropertyName additionalAdminDigestEmailRecipients `
             -NotePropertyValue 'coe@contoso.com;ops@contoso.com'
Set-TenantSettings -RequestBody $t
```

### When to enable

Use Managed Environments for any environment with production workloads, external sharing, or sensitive data. Also apply it to personal developer environments created by default environment routing so sharing limits and solution checker apply uniformly.

### Links

- [Managed Environments overview](https://learn.microsoft.com/power-platform/admin/managed-environment-overview)
- [Enable Managed Environments](https://learn.microsoft.com/power-platform/admin/managed-environment-enable)
- [Limit sharing](https://learn.microsoft.com/power-platform/admin/managed-environment-sharing-limits)
- [Usage insights (weekly digest)](https://learn.microsoft.com/power-platform/admin/managed-environment-usage-insights)
- [Solution checker enforcement](https://learn.microsoft.com/power-platform/admin/managed-environment-solution-checker)

---

## 4. Environment Groups and Rules

Environment groups organize Managed Environments into collections so that admins can apply policies in bulk. Each environment belongs to at most one group. Groups cannot be nested and cannot overlap. Non-managed environments cannot be added.

### Rules currently published

Per the admin center catalog, the following rules can be set at the group level (generally available unless noted):

- Sharing agents with Editor permissions
- Sharing agents with Viewer permissions
- Sharing controls for canvas apps
- Sharing controls for solution-aware cloud flows
- AI-powered Copilot features
- Generative AI settings
- External models
- AI prompts
- Access to transcripts from Copilot Studio conversations
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

When a rule is published at the group level, the corresponding setting becomes read-only inside each member environment. Per-environment overrides are not supported.

### Typical group layout

```
Personal Productivity        -> routed per-maker developer envs; sharing disabled
Pilot                        -> experimental AI features on; release channel = Monthly
Production EU                -> AI off for regulated data; release channel = Semi-Annual
Production US                -> same policies as EU, separate region
CoE / Admin                  -> governance tooling; locked down
```

### CLI

```
pac admin list-groups
pac admin add-group --environment <env-id> --group <group-id>
```

The admin center is the only surface that edits rules today; the CLI supports group membership only.

### Behavior on removal

When an environment is removed from a group, the last applied rule values remain as the current configuration, but the environment becomes editable again by its local admin. This simplifies migration but leaves no automatic revert, so reconcile settings manually after removal.

### Links

- [Environment groups](https://learn.microsoft.com/power-platform/admin/environment-groups)
- [Rules for environment groups](https://learn.microsoft.com/power-platform/admin/environment-groups-rules)
- [pac admin list-groups](https://learn.microsoft.com/power-platform/developer/cli/reference/admin#pac-admin-list-groups)
- [Default environment routing](https://learn.microsoft.com/power-platform/admin/default-environment-routing)

---

## 5. Data Loss Prevention Policies

Data Loss Prevention (DLP) policies in Power Platform control which connectors can be combined inside apps, flows, and agents. Policies apply to Power Apps, Power Automate cloud flows, desktop flows (in Managed Environments), and Copilot Studio agents.

### Groups

Each connector is placed into one of three groups:

- **Business**: connectors that can exchange organizational data with each other.
- **Non-business**: connectors that can exchange non-organizational data with each other.
- **Blocked**: connectors that cannot be used at all.

Data cannot flow between Business and Non-business within the same resource. The **Default group** setting controls where new connectors land when Microsoft introduces them; setting it to `Blocked` prevents accidental exposure of future connectors.

### Scope

A policy can target:

- All environments, with optional exclusions
- Specific environments
- Only the default environment

Policies aggregate: a connector blocked by any applicable policy is blocked for that environment.

### Endpoint and action filtering

Premium tiers support:

- **Endpoint filtering**: allow or block specific URLs on HTTP-capable connectors, SQL Server, Azure Blob, and others.
- **Connector action control**: allow or block individual actions of a connector (e.g., block `Execute a SQL query` on SQL Server while allowing table reads).
- **Custom connector patterns**: allow-list by URL pattern.

### Example: high-risk tenant baseline

```
Business:      Microsoft 365 connectors (Outlook, Teams, SharePoint, OneDrive),
               Dataverse, Approvals, Planner
Non-business:  Bing Search, Translator, MSN Weather
Blocked:       HTTP, HTTP with Microsoft Entra ID (unless endpoint-filtered),
               custom connectors in default env, Twitter/X, Facebook, SMTP, FTP,
               Chat without Microsoft Entra ID authentication in Copilot Studio
Default group: Blocked
```

### PowerShell

```
Get-DlpPolicy
New-DlpPolicy -DisplayName "Tenant baseline"
# manage connector groups via Set-DlpPolicyDefaultConnectorGroup, Add-ConnectorToBusinessDataGroup, etc.
```

### Enforcement timing

Policy changes take effect within minutes for new resources and on the next save or publish for existing ones. Copilot Studio enforces DLP in real time; makers see a validation error immediately when a blocked connector is referenced.

### Links

- [Data policies overview](https://learn.microsoft.com/power-platform/admin/wp-data-loss-prevention)
- [Create a data policy](https://learn.microsoft.com/power-platform/admin/create-dlp-policy)
- [Connector action control](https://learn.microsoft.com/power-platform/admin/connector-action-control)
- [Endpoint filtering](https://learn.microsoft.com/power-platform/admin/connector-endpoint-filtering)
- [DLP PowerShell cmdlets](https://learn.microsoft.com/power-platform/admin/powerapps-powershell#data-loss-prevention-dlp-policy-commands)

---

## 6. Tenant Isolation and Cross-Tenant Controls

Tenant isolation restricts which external Microsoft Entra ID tenants can be used as the identity source for connections inside your Power Platform tenant. It is a separate control from DLP and from Microsoft Entra B2B. DLP governs which connectors can be used; tenant isolation governs which tenants users can authenticate to when creating a connection.

### Direction and defaults

Tenant isolation has two directions:

- **Inbound**: another tenant's users creating a connection that points into your tenant.
- **Outbound**: your tenant's users creating a connection that points into another tenant.

By default both are allowed. Once you enable tenant isolation, both directions default to deny and only allow-listed tenant IDs can be used.

### Configuration

In the Power Platform admin center, under `Security > Tenant isolation`, set:

```
Tenant isolation: On
Default:          Block
Exceptions:       contoso-partner.onmicrosoft.com  (Inbound, Outbound)
                  fabrikam.onmicrosoft.com          (Outbound only)
```

Rules apply to all environments in the tenant; there is no per-environment override.

### What it covers

Tenant isolation applies to connectors that authenticate with Microsoft Entra ID (SharePoint, OneDrive, Dataverse, Outlook, Microsoft 365, Azure, etc.). It does not apply to:

- Connectors that use API keys or generic OAuth
- Service principal and managed identity authentication, which follow Microsoft Entra cross-tenant access policies

Pair tenant isolation with Microsoft Entra cross-tenant access settings for a complete boundary.

### Conditional Access and IP restrictions

Tenant isolation is one control in a layered identity perimeter:

- **Conditional Access** policies targeting the `Power Platform API` application restrict sign-in by user, device, location, and risk.
- **IP firewall** (Managed Environments) restricts Dataverse access to declared IP ranges.
- **Continuous access evaluation (CAE)** on Dataverse revokes sessions when identity posture changes.

### Monitoring

Tenant isolation events are logged to the Power Platform audit log and exported to the Microsoft Purview unified audit log. Filter on `TenantIsolationPolicy` activity to review connection denials.

### Links

- [Tenant isolation](https://learn.microsoft.com/power-platform/admin/cross-tenant-restrictions)
- [Restrict cross-tenant inbound/outbound](https://learn.microsoft.com/power-platform/admin/cross-tenant-restrictions#enable-tenant-isolation)
- [Conditional Access for Power Platform](https://learn.microsoft.com/power-platform/admin/conditional-access)
- [IP firewall](https://learn.microsoft.com/power-platform/admin/ip-firewall)
- [Audit logs](https://learn.microsoft.com/power-platform/admin/audit-logs)

---

## 7. Security Roles and Identity

Power Platform authorization is layered. Microsoft Entra ID provides tenant-level identity and global roles; Dataverse provides row- and column-level security inside each environment; connectors use per-user or service-principal credentials.

### Tenant roles

Microsoft Entra ID roles that govern Power Platform:

- **Power Platform Administrator**: full control of environments, DLP, tenant settings, licenses (within Power Platform scope).
- **Dynamics 365 Administrator**: equivalent scope for Dynamics 365 and Dataverse-backed environments.
- **Global Administrator**: superset, not recommended for day-to-day platform work.
- **Fabric Administrator**: required for Power BI workspace and capacity governance that overlaps Power Platform.

Assign least-privileged roles. The Power Platform Admin role is sufficient for almost all governance work.

### Environment roles

Inside each environment:

- **System Administrator**: root of the environment, can assign any role.
- **System Customizer**: schema and solution changes without user management.
- **Environment Maker**: create apps, flows, agents, and custom connectors.
- **Basic User**: runtime access to assigned records.
- **Delegated Admin**: scoped admin, granted via Microsoft Entra ID groups.

Custom roles inherit privileges at table, action, and column level. Always start from a copy of an out-of-box role rather than granting `*` privileges.

### Dataverse record sharing and teams

Row ownership, hierarchical access, and sharing are enforced by Dataverse. Prefer **Owner teams** or **Access teams** over individual sharing to keep permissions auditable. For large membership, use **Microsoft Entra group teams** so that group membership drives row access.

### Service principals

Use application users (service principals) for non-interactive workloads: pipelines, integrations, and admin automation. Register the app in Microsoft Entra ID, then assign an application user:

```
pac admin create-service-principal `
  --environment <env-id> `
  --name "Pipelines SPN" `
  --role "System Administrator"
```

Rotate secrets and prefer federated credentials or managed identities where supported.

### Conditional Access and MFA

Apply Conditional Access to the `Power Platform API` app and to `Microsoft Dataverse`. Enforce MFA for administrators and for makers who connect to sensitive data sources.

### Links

- [Microsoft Entra roles for Power Platform](https://learn.microsoft.com/power-platform/admin/use-service-admin-role-manage-tenant)
- [Dataverse security roles](https://learn.microsoft.com/power-platform/admin/database-security)
- [Microsoft Entra group teams](https://learn.microsoft.com/power-platform/admin/manage-group-teams)
- [Application users](https://learn.microsoft.com/power-platform/admin/manage-application-users)
- [Conditional Access](https://learn.microsoft.com/power-platform/admin/conditional-access)

---

## 8. Monitoring, Analytics, and the CoE Starter Kit

Governance without telemetry degrades quickly. Power Platform exposes several monitoring surfaces, and the Center of Excellence (CoE) Starter Kit wraps them into a usable inventory and alerting layer.

### Built-in surfaces

- **Power Platform admin center analytics**: per-environment charts for Power Apps usage, Power Automate runs, Dataverse API calls, and Copilot Studio sessions. Requires **tenant-level analytics** enabled.
- **Managed Environments weekly digest**: email summary of top and inactive apps and flows.
- **Audit logs**: platform-level actions stream to the Microsoft Purview unified audit log via `Exchange Online` connector (`Search-UnifiedAuditLog`) and the Microsoft 365 Audit API.
- **Dataverse auditing**: per-table read/change logging, retained per the environment's audit retention setting.
- **Application Insights export**: Managed Environments can stream canvas app, model-driven app, and agent telemetry to Azure Application Insights.

### Application Insights export example

In an environment's settings under `Product > Application Insights (preview)`, add the connection string:

```
InstrumentationKey=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx;
IngestionEndpoint=https://westeurope-1.in.applicationinsights.azure.com/
```

Power Apps emit `pageView`, `traceEvent`, and error events; model-driven apps add form performance metrics.

### CoE Starter Kit

The CoE Starter Kit is a Microsoft-maintained solution (unmanaged, open source on GitHub) that provides:

- Inventory of environments, apps, flows, connectors, custom connectors, agents, and makers
- Compliance workflows (owner attestation, orphaned asset detection)
- DLP editor and policy documentation generator
- A dashboard app for platform admins

Install it in a dedicated environment with Dataverse, run the setup wizard, and schedule the inventory sync flows.

### Microsoft Sentinel integration

Forward the Power Platform activity log and Purview audit events to Sentinel via the `Microsoft Power Platform administrative logs` data connector. Pre-built analytic rules cover suspicious DLP changes, mass app sharing, and unauthenticated agent publishing.

### Links

- [Tenant-level analytics](https://learn.microsoft.com/power-platform/admin/tenant-level-analytics)
- [CoE Starter Kit](https://learn.microsoft.com/power-platform/guidance/coe/starter-kit)
- [Application Insights for Power Platform](https://learn.microsoft.com/power-platform/admin/app-insights-app-making)
- [Audit logs and Purview](https://learn.microsoft.com/power-platform/admin/manage-dataverse-auditing)
- [Sentinel connector](https://learn.microsoft.com/azure/sentinel/data-connectors/microsoft-power-platform)

---

## 9. Governing Microsoft Copilot Studio

Copilot Studio agents are Power Platform resources. They are stored in environments, secured with Dataverse, shared through the same sharing model as apps and flows, and subject to DLP policies. A Copilot Studio agent is not a separate governance domain; it is a new resource type inside the platform perimeter. This section describes the controls that are specific to agents and how to combine them with the platform-wide ones covered elsewhere.

### Tenant-level controls

Two admin surfaces control Copilot Studio at the tenant level:

1. **Power Platform admin center > Settings > Tenant settings**. Controls whether Copilot Studio is enabled at all, who can create agents, whether agents can be created in the default environment, and whether specific AI features (generative answers, autonomous triggers, external models) are available.
2. **Copilot Studio admin center** (`admin.copilotstudio.microsoft.com`). Controls sharing org-wide, tenant-wide data access settings for agents, and transcripts retention.

A recent tenant setting called **"Choose who has permission to share agents with your entire organization"** allows three modes: all users, no users, or specific groups. Restrict to a CoE or approvals group for production-grade sharing.

### Environment-level controls

Inside each environment (preferably Managed):

- **Sharing limits**: apply `Limit sharing` to cap viewers per agent and disable sharing via security groups (see the Managed Environments section for mechanics).
- **Sharing agents with Editor/Viewer permissions** as environment group rules.
- **Maker welcome content**: surface agent guidelines to new makers entering Copilot Studio.
- **Solution checker enforcement**: run static analysis on agent solutions at import.
- **AI features and generative AI settings** rules to turn off preview or experimental models per environment group.
- **Access to transcripts from Copilot Studio conversations**: off by default in regulated groups.

### Data policies for agents

Copilot Studio connectors in DLP govern agent behavior. Common controls:

- **Block `Chat without Microsoft Entra ID authentication in Copilot Studio`** to prevent publishing public, unauthenticated agents.
- **Block `Direct Line channels in Copilot Studio`** if only Teams, SharePoint, and Microsoft 365 Copilot channels are approved.
- **Block `Skills` connector** to prevent invocation of arbitrary Bot Framework skills.
- **Block `HTTP requests`** to prevent ad-hoc outbound calls from agents.
- **Block `Event triggers`** if autonomous agents are not approved.

Enforcement is real time. Makers see validation errors while authoring.

### Knowledge sources

Agents can reference SharePoint sites, public websites, uploaded files, Dataverse, and Microsoft Graph. Risks:

- A broad SharePoint URL grants the agent the site's entire content tree to makers who already have access. Grant scope at the document library or folder level where possible.
- Public website knowledge is fetched at runtime; treat it as untrusted input for prompt-injection exposure.
- Files uploaded as knowledge are stored in the agent's Dataverse tables; they inherit environment backup and data residency.

Use **sensitivity labels** and **Microsoft Purview** to label and classify content before it is indexed.

### Authentication modes

Agents support three modes: **Authenticate with Microsoft** (Entra ID, default), **Authenticate manually** (generic OAuth), and **No authentication** (public). Require Entra ID authentication in regulated environments by blocking the no-authentication connector in DLP.

Per Microsoft Learn, *sharing limits apply only to agents that require authentication*; public agents bypass the sharing model. Blocking no-authentication is therefore a prerequisite for sharing limits to be meaningful.

### Deployment channels

Approved channel matrix is enforced through tenant settings and DLP:

| Channel | Control |
|---|---|
| Microsoft Teams | Admin-approved app catalog; manifests are solution-aware |
| Microsoft 365 Copilot | Tenant Copilot extension governance |
| SharePoint | Site permissions; viewer licensing applies at runtime |
| Custom website | Block for regulated environments; pair with IP allow-list |
| Direct Line | Block by default |

### Monitoring

- **Agent analytics** in Copilot Studio: sessions, resolution rate, escalations.
- **Copilot Studio audit logs** in Microsoft Purview: agent create, publish, share, knowledge change, tool add.
- **Application Insights export** (Managed Environments) for detailed traces.
- **CoE Starter Kit**: inventory table `Power Platform agents` lists owner, environment, authentication mode, last publish.

### Autonomous agents and MCP

Autonomous agents (event-triggered, not user-invoked) expand the attack surface because they run without interactive sessions. Keep them in a dedicated environment, require code review on triggers, and disable them with the `Event triggers` DLP connector in environments that are not ready.

Model Context Protocol (MCP) servers extend agents with external tools. Treat each MCP server as a custom connector for governance: review the server code or vendor, restrict outbound network paths, and block ad-hoc registration by makers.

### Links

- [Copilot Studio security and governance](https://learn.microsoft.com/microsoft-copilot-studio/admin-security-and-governance)
- [Configure data policies for agents](https://learn.microsoft.com/microsoft-copilot-studio/admin-data-loss-prevention)
- [Control how agents are shared](https://learn.microsoft.com/microsoft-copilot-studio/admin-sharing-controls-limits)
- [Configure user authentication](https://learn.microsoft.com/microsoft-copilot-studio/configuration-end-user-authentication)
- [Copilot Studio admin center](https://learn.microsoft.com/microsoft-copilot-studio/admin-admin-center)
- [Copilot Studio audit logs in Purview](https://learn.microsoft.com/microsoft-copilot-studio/admin-logging-copilot-studio)
- [Tenant settings reference](https://learn.microsoft.com/power-platform/admin/tenant-settings)
- [Environment group rules](https://learn.microsoft.com/power-platform/admin/environment-groups-rules)

---

## 10. Agent Authentication and Connector Governance

Agents built in Copilot Studio interact with data and services through connectors, knowledge sources, and tools. Connector governance for agents is the same Power Platform DLP engine applied to Power Apps and Power Automate, but a few controls are agent-specific.

### Authentication modes

- **Authenticate with Microsoft** (default). Uses Microsoft Entra ID. The agent requires sign-in; sharing limits apply.
- **Authenticate manually**. Generic OAuth 2.0 (Okta, Auth0, custom IdP). Agent requires sign-in but identity lives outside Entra ID.
- **No authentication**. Public link or embedded web chat. Sharing limits are bypassed.

Block the connector `Chat without Microsoft Entra ID authentication in Copilot Studio` in the tenant baseline DLP to remove the `No authentication` option.

### Federated agent identity

New agents use federated workload identities for outbound calls instead of stored client secrets. Administrators configure which Entra ID app registrations are trusted for agent federation. Prefer federation over stored secrets and rotate any remaining secrets via Azure Key Vault.

### Connector governance for agents

Connectors used as tools by agents are subject to DLP. Common blocks for regulated tenants:

- `HTTP`, `HTTP with Microsoft Entra ID` (or endpoint-filter them to an allow-list)
- `Chat without Microsoft Entra ID authentication in Copilot Studio`
- `Skills` (Bot Framework skills as tools)
- `Event triggers` (autonomous agents)
- Custom connectors unless catalog-approved

Use **connector action control** to allow read actions and block write actions on high-risk connectors (e.g., SQL Server `Get rows` allowed, `Execute a SQL query` blocked).

### Example policy snippet (PowerShell)

```
$policy = New-DlpPolicy -DisplayName "Agent baseline"
Add-ConnectorToBusinessDataGroup -PolicyName $policy.Name -ConnectorName shared_sharepointonline
Add-ConnectorToBlockedGroup     -PolicyName $policy.Name -ConnectorName shared_logicflows_http
Set-DlpPolicyDefaultConnectorGroup -PolicyName $policy.Name -DefaultGroup Blocked
```

### Tools, prompts, and MCP

Beyond connectors, agents can use:

- **Generative orchestration** with built-in prompts. Governable per environment group via `AI prompts` and `Generative AI settings` rules.
- **Custom prompts** (prompt columns, AI Builder prompts). Audit through Dataverse.
- **MCP servers** as external tools. Treat each server as a connector; inventory via Copilot Studio admin center.

### Knowledge source controls

- Require authenticated SharePoint sources; public websites block in regulated environments.
- Apply Microsoft Purview sensitivity labels upstream; agents honor label-based access for SharePoint and OneDrive content.
- Use `Access to transcripts` rule to block transcript retention where conversations could contain sensitive prompts.

### Links

- [Configure user authentication](https://learn.microsoft.com/microsoft-copilot-studio/configuration-end-user-authentication)
- [Connector action control](https://learn.microsoft.com/power-platform/admin/connector-action-control)
- [Endpoint filtering](https://learn.microsoft.com/power-platform/admin/connector-endpoint-filtering)
- [Agents and MCP](https://learn.microsoft.com/microsoft-copilot-studio/mcp)
- [Purview sensitivity labels for Copilot](https://learn.microsoft.com/purview/sensitivity-labels)

---

## 11. Application Lifecycle Management and Pipelines

Application Lifecycle Management (ALM) for Power Platform is built on **solutions**. A solution is a versioned container for apps, flows, agents, tables, roles, and environment variables. Movement between environments is always through solution export/import, whether manual, via Power Platform pipelines, or via Azure DevOps/GitHub.

### Solution hygiene

- One solution per deployable unit; avoid the **Default Solution**.
- Configure **solution-aware** flows (`Default to creating new cloud flows as solution-aware` setting).
- Use **environment variables** for connection references and configuration instead of hard-coded values.
- Use **connection references** for flows and agents so connections can be rebound per environment.
- Version solutions with semantic versioning (`1.4.2`) and tag the source control commit.

### Power Platform pipelines

Pipelines provide a native deployment surface that runs inside the Power Platform:

- Requires a **host environment** that is a Managed Environment.
- Source and target environments are registered in the host.
- A pipeline deployment imports a solution, rebinds connection references, and runs solution checker.
- Approvals can be attached to deployment stages.

Enable through the host environment solution **`CenterOfExcellencePipelines`** (auto-provisioned). Register environments in the `Deployment Environments` table.

### Pipelines with service principals

Assign a service principal with `System Administrator` in source and target environments. Use a **delegated service account** or **managed identity** where supported to avoid storing client secrets.

### PAC CLI deployment snippet

```
pac auth create --url https://dev.crm.dynamics.com
pac solution export --name HRSolution --path ./HRSolution.zip --managed
pac auth create --url https://test.crm.dynamics.com
pac solution import --path ./HRSolution.zip --force-overwrite
```

For pipelines-based deployment:

```
pac pipeline deploy --id <pipelineId> --stage-id <stageId> `
                    --notes "Release 1.4.2"
```

### Azure DevOps / GitHub

The **Power Platform Build Tools** (Azure DevOps) and **Power Platform Actions** (GitHub) expose the same CLI commands as pipeline tasks. Use them when release policy requires external approvals, multi-stack coordination, or artifact signing.

### Managed vs unmanaged

Deploy **managed** solutions to test and production. Unmanaged solutions allow layered customization in higher environments and compromise traceability. Use the environment group rule `Unmanaged customizations` to block unmanaged changes in Production groups.

### Links

- [ALM basics](https://learn.microsoft.com/power-platform/alm/basics-alm)
- [Power Platform pipelines](https://learn.microsoft.com/power-platform/alm/pipelines)
- [pac pipeline reference](https://learn.microsoft.com/power-platform/developer/cli/reference/pipeline)
- [Power Platform Build Tools](https://learn.microsoft.com/power-platform/alm/devops-build-tools)
- [GitHub Actions for Power Platform](https://learn.microsoft.com/power-platform/alm/devops-github-actions)

---

## 12. Solution Checker and Quality Gates

Solution checker is a static-analysis engine that inspects solution contents against a Microsoft-maintained rule set. It runs on canvas apps, model-driven apps, Power Fx, Dataverse customizations, plug-ins, web resources, cloud flows, and Copilot Studio agents.

### Operating modes

- **On demand** from the Power Platform admin center, make.powerapps.com, or `pac solution check`.
- **Pipeline integrated**: runs automatically before deployment in Power Platform pipelines.
- **Enforced**: in Managed Environments, `Solution checker enforcement` can be set to `Warn` or `Block` for solution import.

### Rule categories

- **Security**: use of `Execute Fetch` with user-supplied input, open redirects in web resources, plug-in secrets in traces.
- **Performance**: non-delegable queries in canvas apps, missing indexes in Dataverse, synchronous plug-ins on create/update of high-volume tables.
- **Maintainability**: missing connection references, hard-coded GUIDs, deprecated API calls.
- **Reliability**: missing error handling in flows, unbounded loops, overlapping workflow triggers.

### Example

```
pac solution check --path ./HRSolution.zip `
                   --geo europe `
                   --ruleset "Solution Checker"
```

The CLI returns a SARIF file that can be uploaded to GitHub code scanning or parsed in Azure DevOps. Severity is one of `Critical`, `High`, `Medium`, `Low`, `Informational`.

### Enforcement configuration

In the admin center, `Edit Managed Environments > Solution checker`:

```
Enforcement: Block
Severity threshold: High
Exclusion rules: (solution-specific overrides)
```

At `Block`, an import containing a rule violation at or above the threshold fails with the list of offending components.

### Agent-specific checks

Solution checker validates Copilot Studio agents for: unused topics, missing fallback, knowledge sources without authentication, publish to blocked channels, and references to DLP-blocked connectors.

### Agent evaluations

For behavioral quality (not structural), Copilot Studio includes **agent evaluations**. Define test sets of prompts and expected behaviors; run them before publish. Evaluations are complementary to solution checker and do not replace it.

### Links

- [Solution checker](https://learn.microsoft.com/power-platform/alm/checker-api/overview)
- [Solution checker enforcement](https://learn.microsoft.com/power-platform/admin/managed-environment-solution-checker)
- [pac solution check](https://learn.microsoft.com/power-platform/developer/cli/reference/solution#pac-solution-check)
- [Agent evaluations](https://learn.microsoft.com/microsoft-copilot-studio/authoring-agent-evaluations)
- [Rule reference](https://learn.microsoft.com/power-platform/alm/checker-api/rules)

---

## 13. Licensing and Capacity Governance

Licensing is a governance concern because runtime usage of Power Platform and Copilot Studio is gated by assigned licenses and consumed capacity. Capacity misconfiguration is a leading cause of outages.

### License types

- **Power Apps**: per user or per app. Per-app covers one or two apps per user; per-user covers unlimited apps.
- **Power Automate**: per user (user plan) or per flow (hosted plan). Process plans allocate capacity to a single flow, typically for RPA.
- **Dataverse**: capacity (database, file, log) accrues per tenant, allocated per environment.
- **Copilot Studio**: **Copilot Credits** consumed per message. Sold as **prepaid capacity** or **pay-as-you-go** (PAYG). Microsoft 365 Copilot user licenses include a separate allowance.
- **Power Pages**: authenticated or anonymous user capacity per site.

### Copilot Studio consumption model

Each agent message consumes credits based on message type (generative answers, actions, autonomous events). Key constraints:

- PAYG requires the **Dataverse Azure subscription meter** configured at the environment level; without it, PAYG is inactive.
- No hard tenant-wide consumption cap exists today. Alerts, not blocks, are the primary guard.
- Consumption reporting is in the Power Platform admin center under `Resources > Capacity > Copilot Studio`.

Monitor trends weekly. Set Azure budget alerts on the PAYG meter subscription.

### Capacity allocation

In `Resources > Capacity > Environments`, assign Dataverse capacity explicitly per environment. Without assignment, environments draw from the tenant pool until exhausted, at which point all over-pool environments enter read-only.

### License assignment audit

Use Microsoft Entra ID group-based licensing. Avoid direct assignment so that license removal is automatic on offboarding. Audit monthly:

```
Connect-MgGraph -Scopes "Directory.Read.All"
Get-MgUser -All -Property AssignedLicenses,UserPrincipalName |
  Where-Object { $_.AssignedLicenses.SkuId -contains "<Power Apps Per User SKU>" } |
  Select-Object UserPrincipalName
```

### Developer licenses

**Power Apps Developer Plan** provides a free, single-user environment for learning. Governance implication: developer environments are tenant assets and count against environment quotas. Use default environment routing to manage them.

### Links

- [Power Platform licensing overview](https://learn.microsoft.com/power-platform/admin/pricing-billing-skus)
- [Copilot Studio licensing](https://learn.microsoft.com/microsoft-copilot-studio/requirements-licensing-subscriptions)
- [Capacity in admin center](https://learn.microsoft.com/power-platform/admin/capacity-storage)
- [Pay-as-you-go setup](https://learn.microsoft.com/power-platform/admin/pay-as-you-go-overview)
- [Developer Plan](https://learn.microsoft.com/power-platform/developer/plan)

---

## 14. Change Management and Release Rings

Power Platform receives continuous updates from Microsoft and from in-tenant makers. A change management practice that controls both streams keeps environments predictable.

### Microsoft release waves and channels

Microsoft rolls out infrastructure changes through **release waves** (two per year) and maker-facing app updates through **release channels**:

- **Auto channel** (default): updates arrive as they are released to ring-by-ring deployment.
- **Monthly channel**: fixed weekly cadence; enterprise customers can preview monthly.
- **Semi-Annual channel**: slower rollout; aligned with two release waves per year.

Set the release channel with the environment group rule **Release channel**. Production groups typically use `Semi-Annual`; pilot groups use `Monthly` for early validation.

### Previews and experimental features

The **Generative AI settings** and **Preview and experimental AI models** rules at the environment group level gate preview capabilities. Keep previews off in regulated groups; enable in a pilot group with representative data.

### In-tenant change management

Apply the same change categories used in traditional IT:

1. **Standard** (pre-approved): patch increments of an existing solution, deployed via pipelines.
2. **Normal**: new apps, flows, agents; requires CoE or architecture review.
3. **Emergency**: hotfixes; post-implementation review required.

Each category maps to a pipeline approval configuration. Approvals are implemented as Dataverse records in the pipelines host with Azure AD group-based reviewer lists.

### Deployment windows

Use maintenance windows for production environments. In the admin center, configure:

- **Administration mode** via `pac admin set-runtime-state` to block user traffic during deployment.
- **Backup** before change: `pac admin backup` to create a manual restore point.
- **Backup retention** rule set to at least 28 days for production groups.

### Communicating changes

- The **Message Center** in Microsoft 365 admin center surfaces Power Platform MC alerts. Subscribe Power Platform admins and CoE members.
- Use **Maker welcome content** rule to publish in-product notices for upcoming behavior changes.
- Maintain a tenant changelog in the CoE environment, linking MC IDs, affected environments, and owners.

### Rollback

Rollback is limited to Dataverse restore points and solution re-import of a prior version. Canvas apps retain version history; model-driven apps roll back via solution version. For Copilot Studio, earlier agent versions can be restored from the agent version list.

### Links

- [Release channels](https://learn.microsoft.com/power-platform/admin/release-channels)
- [Release waves](https://learn.microsoft.com/dynamics365/release-plans/)
- [Administration mode](https://learn.microsoft.com/power-platform/admin/admin-mode)
- [Manual backups](https://learn.microsoft.com/power-platform/admin/backup-restore-environments)
- [Message Center](https://learn.microsoft.com/microsoft-365/admin/manage/message-center)
- [Copilot Studio agent versions](https://learn.microsoft.com/microsoft-copilot-studio/authoring-publish-basics)

---

## Conclusion

Power Platform governance is not a single product, a single policy, or a single role. It is the cumulative result of many small, well-placed controls working together: an environment topology that matches how the organization actually builds, a default environment that is treated as a perimeter rather than a playground, Managed Environments and environment groups that make policy enforceable at scale, DLP and tenant isolation that bound what data can move where, identity and Conditional Access that decide who is allowed to touch the platform at all, monitoring that turns activity into evidence, Copilot Studio controls that extend the same model to AI agents, ALM and solution checker that keep releases traceable and reversible, licensing hygiene that prevents runtime surprises, and a change management practice that absorbs Microsoft's rollouts without disrupting users.

The controls described in this document already exist in the platform today; none of them require custom engineering, third-party tooling, or preview access to be useful. What they require is decision-making: which environments belong in which group, which connectors are business versus non-business, which agents must authenticate with Microsoft Entra ID, which release channel each group follows, and who approves a production deployment. Those decisions are governance.

Start small and iterate. A minimum viable posture is: restrict default environment creation, attach a tenant-wide baseline DLP policy, enable default environment routing with a Managed Environments group, turn on tenant-level analytics, install the CoE Starter Kit, and require authenticated agents. Everything else in this document is a refinement on that foundation. Governance that grows with the platform is governance that lasts; governance that is bolted on after an incident rarely recovers the ground it lost.
