---
layout: post
title: "Power Platform Governance: A Practitioner's Reference (Part 2)"
description: "Part 2 of a two-part guide to managing and securing Power Platform environments within Microsoft 365 — Copilot Studio governance, agent authentication, ALM and pipelines, solution checker, licensing, and change management."
date: 2026-05-23
author: admin
slug: powerplatform-governance-part-2
canonical_url: https://holgerimbery.blog/powerplatform-governance-part-2
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/05/charles-forerunner-3fPXt37X6UQ-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@charles_forerunner?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Charles Forerunner</a> on <a href="https://unsplash.com/photos/people-standing-inside-city-building-3fPXt37X6UQ?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>


tags: [copilotstudio, agents, governance, powerplatform, dataverse, security, compliance, applicationlifecyclemanagement, pipelines]
featured: false
toc: true
---

{: .q-left }
> **Summary lede.** Part 2 of this two-article reference picks up where last week's foundations ended. With the platform perimeter in place — environments, Managed Environments, environment groups, DLP, tenant isolation, identity, and monitoring — this article works through the resources that live inside that perimeter and the processes that move them through it: Copilot Studio agents, agent authentication and connector governance, Application Lifecycle Management and pipelines, solution checker and quality gates, licensing and capacity governance, and change management and release rings. A closing recap then ties both articles together into a single posture.

{: .q-left }
> **Last verified: May 2026.** Feature availability and documentation links were checked against Microsoft Learn as of this date. Power Platform evolves rapidly; confirm preview/GA status before acting on release-sensitive claims.

{: .q-left }
> **Who this is for.** Same audience as part 1 — Power Platform administrators, security and compliance officers, Center of Excellence leads, architects, and makers. Part 2 assumes you have read Part 1 or have an equivalent grasp of environment design, Managed Environments, environment groups, and DLP. Where part 1 answered "what is the perimeter and how do we hold it?", part 2 answers "what gets built inside it, and how does that work move from a maker's hands into production safely?" The format is unchanged: each control begins with the reason it exists, moves to the how, and points you to the authoritative Microsoft Learn page.

{: .important }
**A note on the kits (continues from part 1).**  
Two pieces of widely-deployed community tooling have changed status: the **CoE Starter Kit** is no longer actively maintained — its core capabilities are now part of the Power Platform admin center (Inventory, Usage, Monitor, Actions) — and the **ALM Accelerator for Power Platform** is formally deprecated, with **Power Platform Pipelines** as the named replacement. Sections 9.14 (agent inventory) and 11 (ALM and pipelines) reflect that. The detailed write-up of the CoE Starter Kit transition lives in part 1, section 8.6; the ALM Accelerator transition is summarised in section 11.6 of this part.

## Recap: where part 1 left off

As we saw last week, platform-level governance is the foundation on which everything else rests. Part 1 walked through eight sections of foundations:

- **Environment strategy.** Environments are the unit of governance because DLP, security roles, capacity, and compliance boundaries all follow environment lines. A topology that mirrors your delivery lifecycle (default for personal productivity; dev/test/prod for solutions; dedicated CoE and training environments) gives every later control a place to attach to.
- **The default environment.** It cannot be deleted, every licensed user is a maker in it, and Dataverse cannot be removed once added. Renaming it, attaching a restrictive DLP policy, enabling default environment routing, and converting it to a Managed Environment turn it into a known, bounded surface.
- **Managed Environments.** A premium governance layer that adds sharing limits, the weekly digest, solution checker enforcement, maker welcome content, pipelines hosting, IP firewall, extended backup, and DLP for desktop flows. Most of part 2's controls depend on Managed Environments being on.
- **Environment groups and rules.** Groups apply policy in bulk to Managed Environments. When a rule is published at the group level, the corresponding setting becomes read-only in each member environment, which makes the policy enforceable rather than advisory.
- **Data Loss Prevention.** Connectors are sorted into Business, Non-business, and Blocked. Data cannot flow between Business and Non-business in the same resource. Endpoint filtering and connector action control let you keep useful connectors while blocking their dangerous edges.
- **Tenant isolation and cross-tenant controls.** Restricts which external Entra ID tenants can be the identity source for connections. Tenant isolation is off by default; enable it explicitly and configure inbound and outbound rules for each trusted tenant.
- **Security roles and identity.** Layered authorization: Entra ID at the tenant, Dataverse roles inside each environment, service principals for non-interactive work, Conditional Access and MFA on the `Power Platform API`.
- **Monitoring, analytics, and tenant inventory.** Built-in admin center analytics (the **Inventory**, **Usage**, **Monitor**, and **Actions** experiences), the weekly digest, Microsoft Purview audit log, Application Insights export, and Microsoft Sentinel for SOC integration. The **CoE Starter Kit** is no longer actively maintained; its inventory and attestation scenarios are now Microsoft's responsibility in the admin center, accessible via the **Power Platform inventory API** and the **Power Platform for Admins V2** connector for custom automation.

The minimum viable foundation from part 1 was: restrict default environment creation, attach a tenant-wide baseline DLP policy, enable default environment routing with a Managed Environments group, turn on tenant-level analytics, lean on the Power Platform admin center's **Inventory**, **Usage**, **Monitor**, and **Actions** experiences (the CoE Starter Kit is no longer actively maintained), and verify your tenant isolation defaults. Everything in part 2 assumes that the foundation is in place. The section numbering continues from part 1, starting at section 9.

---

## 9. Governing Microsoft Copilot Studio

Copilot Studio agents are Power Platform resources. They are stored in environments, secured with Dataverse, shared through the same sharing model as apps and flows, and subject to DLP policies. A Copilot Studio agent is not a separate governance domain; it is a new resource type inside the platform perimeter. The controls below are specific to agents and combine with the platform-wide ones covered in part 1.

### 9.1 Decide agent posture in tenant settings

**Why.** The most basic question — "should agents exist in this tenant at all, and where?" — is answered at the tenant level. Skipping this step makes every later control fight a current.

**How.** In **Power Platform admin center > Settings > Tenant settings**, control whether Copilot Studio is enabled, who can create agents, whether agents can be created in the default environment, and which AI features (generative answers, autonomous triggers, external models) are available.

**Learn more.** [Tenant settings reference](https://learn.microsoft.com/power-platform/admin/tenant-settings).

### 9.2 Use the Copilot Studio admin center for agent-specific controls

**Why.** Some agent controls live outside the Power Platform admin center because they are specific to Copilot Studio's data model.

**How.** Visit `admin.copilotstudio.microsoft.com` to control sharing org-wide, tenant-wide data access settings for agents, and transcript retention.

**Learn more.** [Copilot Studio admin center](https://learn.microsoft.com/microsoft-copilot-studio/admin-admin-center).

### 9.3 Restrict who can share agents tenant-wide

**Why.** "Share with my entire organization" is a one-click action that bypasses normal sharing limits. Without restriction, any maker can publish a tenant-wide agent.

**How.** Org-wide sharing is controlled through a combination of tenant settings and Managed Environment sharing rules. In the Power Platform admin center, restrict who can share agents broadly; in Managed Environments, use sharing limits to cap the number of viewers and disable sharing via security groups. Restrict org-wide sharing to a CoE or approvals group for production-grade use.

**Learn more.** [Control how agents are shared](https://learn.microsoft.com/microsoft-copilot-studio/admin-sharing-controls-limits).

### 9.4 Cap agent sharing per environment

**Why.** Even with tenant-wide sharing locked down, intra-tenant oversharing is still possible. Sharing limits cap blast radius per agent.

**How.** In a Managed Environment, apply `Limit sharing` to cap viewers per agent and disable sharing via security groups. Mechanics are in part 1, section 3.

**Learn more.** [Limit sharing](https://learn.microsoft.com/power-platform/admin/managed-environment-sharing-limits).

### 9.5 Apply group rules for agent sharing

**Why.** Sharing limits per environment are tedious to manage at scale. Group rules let you apply the same sharing posture across many environments at once.

**How.** Use the `Sharing agents with Editor permissions` and `Sharing agents with Viewer permissions` environment group rules.

**Learn more.** [Rules for environment groups](https://learn.microsoft.com/power-platform/admin/environment-groups-rules).

### 9.6 Set maker welcome content for Copilot Studio

**Why.** Most makers entering Copilot Studio will not have read your governance documentation. The welcome banner is the cheapest place to put guardrails in front of them.

**How.** Configure maker welcome content in Managed Environments to surface agent guidelines as makers enter Copilot Studio.

**Learn more.** [Copilot Studio security and governance](https://learn.microsoft.com/microsoft-copilot-studio/admin-security-and-governance).

### 9.7 Run solution checker on agent solutions

**Why.** Static analysis catches structural problems in agents the same way it does in apps and flows — missing fallbacks, knowledge sources without authentication, references to blocked connectors.

**How.** Solution checker runs at solution import in Managed Environments. Mechanics are covered in section 12.

**Learn more.** [Solution checker enforcement](https://learn.microsoft.com/power-platform/admin/managed-environment-solution-checker).

### 9.8 Govern AI features per environment group

**Why.** Generative and external AI features carry different risk profiles in different environments. Production with regulated data needs a stricter stance than a pilot environment.

**How.** Use the `AI-powered Copilot features`, `Generative AI settings`, `External models`, `AI prompts`, and `Preview and experimental AI models` rules to turn capabilities off where they should not be available.

**Learn more.** [Rules for environment groups](https://learn.microsoft.com/power-platform/admin/environment-groups-rules).

### 9.9 Control transcript access

**Why.** Conversation transcripts can contain sensitive prompts and customer data. Default-on transcript retention is a poor fit for regulated environments.

**How.** The `Accessing transcripts from conversations in Copilot Studio agents` rule turns transcript retention off for environments in regulated groups.

**Learn more.** [Rules for environment groups](https://learn.microsoft.com/power-platform/admin/environment-groups-rules).

### 9.10 Block high-risk agent connectors in DLP

**Why.** DLP on agent connectors is the only way to stop entire classes of bad behavior at design time — public agents, ad-hoc HTTP, autonomous triggers — without playing whack-a-mole.

**How.** Common blocks for regulated tenants:

- **`Chat without Microsoft Entra ID authentication in Copilot Studio`** — prevents publishing public, unauthenticated agents.
- **`Direct Line channels in Copilot Studio`** — block if only Teams, SharePoint, and Microsoft 365 Copilot channels are approved.
- **`Skills`** — prevents invocation of arbitrary Bot Framework skills.
- **`HTTP requests`** — prevents ad-hoc outbound calls from agents.
- **`Event triggers`** — disables autonomous agents until they are approved.

Enforcement is real time; makers see validation errors while authoring.

**Learn more.** [Configure data policies for agents](https://learn.microsoft.com/microsoft-copilot-studio/admin-data-loss-prevention).

### 9.11 Constrain knowledge sources

**Why.** Knowledge sources are how agents reach data. A loose knowledge configuration is a loose data perimeter.

**How.** Apply scope-aware controls to each source type:

- A broad SharePoint URL can expose a large portion of the site's content to the agent, limited by supported file types, page types, and the user's permissions at runtime. Grant scope at the document library or folder level where possible to minimize exposure.
- Public website knowledge is fetched at runtime; treat it as untrusted input for prompt-injection exposure.
- Files uploaded as knowledge are stored in the agent's Dataverse tables and inherit environment backup and data residency.

Use **sensitivity labels** and **Microsoft Purview** to label and classify content before it is indexed.

**Learn more.** [Copilot Studio security and governance](https://learn.microsoft.com/microsoft-copilot-studio/admin-security-and-governance).

### 9.12 Pick an authentication mode per agent

**Why.** Authentication mode determines whether sharing limits apply at all. Sharing limits apply only to agents that require authentication; public agents bypass the sharing model entirely.

**How.** Three modes exist:

- **Authenticate with Microsoft** (Entra ID, default) — recommended for regulated environments.
- **Authenticate manually** — generic OAuth.
- **No authentication** — public; not recommended for tenants with sensitive data.

Require Entra ID authentication in regulated environments by blocking the no-authentication connector in DLP. Blocking no-authentication is the prerequisite for sharing limits to be meaningful at all.

**Learn more.** [Configure user authentication](https://learn.microsoft.com/microsoft-copilot-studio/configuration-end-user-authentication).

### 9.13 Approve a deployment channel matrix

**Why.** Each channel has its own risk profile and operational model. Without an approved matrix, channel selection becomes a maker-by-maker decision.

**How.** Enforce an approved channel matrix through tenant settings and DLP:

| Channel | Control |
|---|---|
| Microsoft Teams | Admin-approved app catalog; manifests are solution-aware |
| Microsoft 365 Copilot | Tenant Copilot extension governance |
| SharePoint | Site permissions; viewer licensing applies at runtime |
| Custom website | Block for regulated environments; pair with IP allow-list |
| Direct Line | Block by default |

**Learn more.** [Copilot Studio security and governance](https://learn.microsoft.com/microsoft-copilot-studio/admin-security-and-governance).

### 9.14 Monitor agents with the right surface for the question

**Why.** Different questions have different right surfaces. Behavior questions, audit questions, and inventory questions each have a primary tool.

**How.** Match the surface to the question:

- **Agent analytics** in Copilot Studio for sessions, resolution rate, and escalations.
- **Copilot Studio audit logs** in Microsoft Purview for create, publish, share, knowledge change, and tool add events.
- **Application Insights export** (Managed Environments) for detailed traces.
- **Power Platform admin center Inventory** (and the **Power Platform inventory API** / **Power Platform for Admins V2** connector) for owner, environment, authentication mode, and last publish across all agents in the tenant. This is the replacement surface for the CoE Starter Kit's `Power Platform agents` inventory table, which is no longer actively maintained.

**Learn more.** [Copilot Studio audit logs in Purview](https://learn.microsoft.com/microsoft-copilot-studio/admin-logging-copilot-studio), [Power Platform inventory API](https://learn.microsoft.com/power-platform/admin/programmability-authentication-v2).

### 9.15 Treat autonomous agents as a higher-risk class

**Why.** Autonomous (event-triggered) agents run without interactive sessions, which expands the attack surface and removes the human-in-the-loop signal that interactive agents give you.

**How.** Keep autonomous agents in a dedicated environment, require code review on triggers, and disable them with the `Event triggers` DLP connector in environments that are not ready.

**Learn more.** [Configure data policies for agents](https://learn.microsoft.com/microsoft-copilot-studio/admin-data-loss-prevention).

### 9.16 Govern MCP servers through advanced connector policies

**Why.** Model Context Protocol (MCP) servers extend agents with external tools. From a governance standpoint, each MCP server is an integration path that must be governed; treating it informally creates an unaudited surface.

**How.** MCP connectors are a distinct connector class in Power Platform — they are not custom connectors and are not governed through custom connector DLP. Instead, use **advanced connector policies (ACP)** to control MCP server registration and usage. Review the server code or vendor, restrict outbound network paths, and block ad-hoc registration by makers through ACP rules.

**Learn more.** [Agents and MCP](https://learn.microsoft.com/microsoft-copilot-studio/mcp), [Data policies](https://learn.microsoft.com/power-platform/admin/wp-data-loss-prevention).

---

## 10. Agent Authentication and Connector Governance

Agents built in Copilot Studio interact with data and services through connectors, knowledge sources, and tools. Connector governance for agents uses the same Power Platform DLP engine applied to Power Apps and Power Automate, but a few controls are agent-specific.

### 10.1 Choose an authentication mode

**Why.** Authentication mode determines who can use the agent and whether platform sharing controls apply at all.

**How.** Pick one of three modes:

- **Authenticate with Microsoft** (default) — uses Microsoft Entra ID. The agent requires sign-in; sharing limits apply.
- **Authenticate manually** — generic OAuth 2.0 (Okta, Auth0, custom IdP). Agent requires sign-in but identity lives outside Entra ID.
- **No authentication** — public link or embedded web chat. Sharing limits are bypassed.

Block the connector `Chat without Microsoft Entra ID authentication in Copilot Studio` in the tenant baseline DLP to remove the `No authentication` option entirely.

**Learn more.** [Configure user authentication](https://learn.microsoft.com/microsoft-copilot-studio/configuration-end-user-authentication).

### 10.2 Use Entra Agent ID for outbound calls (preview)

**Why.** Older agent integrations relied on stored client secrets, which are awkward to rotate and easy to leak. Entra Agent ID replaces that pattern with a managed identity model that the platform owns.

**How.** Entra Agent ID (currently in preview) provisions each Copilot Studio agent with its own Microsoft Entra service principal of subtype `Agent`. Once enabled per environment, the agent presents this identity on outbound calls. The Agent ID is managed by the platform and visible in the Entra ID portal under enterprise applications. Administrators opt in at the environment level; the feature is not automatic by default. Where legacy connectors still rely on stored secrets, rotate them through Azure Key Vault.

**Learn more.** [Entra agent identities (preview)](https://learn.microsoft.com/microsoft-copilot-studio/admin-use-entra-agent-identities).

### 10.3 Block high-risk connectors

**Why.** A handful of connectors account for most of the risk in agent tooling. Blocking them by default forces every exception to be justified.

**How.** Common blocks for regulated tenants:

- `HTTP`, `HTTP with Microsoft Entra ID` (or endpoint-filter them to an allow-list).
- `Chat without Microsoft Entra ID authentication in Copilot Studio`.
- `Skills` (Bot Framework skills as tools).
- `Event triggers` (autonomous agents).
- Custom connectors unless catalog-approved.

**Learn more.** [Configure data policies for agents](https://learn.microsoft.com/microsoft-copilot-studio/admin-data-loss-prevention).

### 10.4 Use action control for partial approval

**Why.** Some connectors are too useful to block entirely but too dangerous to allow in full. Action control gives you a middle ground.

**How.** Allow read actions and block write actions on high-risk connectors — for example, allow `Get rows` on SQL Server but block `Execute a SQL query`.

**Learn more.** [Connector action control](https://learn.microsoft.com/power-platform/admin/connector-action-control).

### 10.5 A scripted policy baseline

**Why.** A baseline that lives only in the UI is not portable across tenants and not testable in code review. PowerShell-defined baselines fix both problems.

**How.** A starter snippet using the Power Apps Administration PowerShell module:

```
# Create a new DLP policy
$policy = New-AdminDlpPolicy -DisplayName "Agent baseline"

# Move SharePoint Online to the Business data group
Set-AdminDlpPolicy -PolicyName $policy.PolicyName `
  -MoveTo "BusinessDataOnly" `
  -ConnectorName "shared_sharepointonline"

# Move HTTP to the Blocked group
Set-AdminDlpPolicy -PolicyName $policy.PolicyName `
  -MoveTo "Blocked" `
  -ConnectorName "shared_logicflows_http"

# Set the default group for new connectors to Blocked
Set-AdminDlpPolicy -PolicyName $policy.PolicyName `
  -SetNonBusinessDataGroupState "Block"
```

**Learn more.** [DLP PowerShell cmdlets](https://learn.microsoft.com/power-platform/admin/powerapps-powershell#data-loss-prevention-dlp-policy-commands).

### 10.6 Govern tools, prompts, and MCP

**Why.** Agents do more than call connectors. Prompt content and external tools are governance surfaces in their own right; ignoring them leaves a hole the connector model alone cannot close.

**How.** Govern each surface:

- **Generative orchestration** with built-in prompts — control via the `AI prompts` and `Generative AI settings` rules.
- **Custom prompts** (prompt columns, AI Builder prompts) — audit through Dataverse.
- **MCP servers** as external tools — govern through advanced connector policies (ACP) and inventory via the Copilot Studio admin center.

**Learn more.** [Agents and MCP](https://learn.microsoft.com/microsoft-copilot-studio/mcp), [Data policies](https://learn.microsoft.com/power-platform/admin/wp-data-loss-prevention).

### 10.7 Constrain knowledge sources upstream

**Why.** Knowledge sources are the easiest way for an agent to reach data the maker should not be able to reach. Upstream labels and authentication requirements close that gap.

**How.** Apply layered controls:

- Require authenticated SharePoint sources; block public websites in regulated environments.
- Apply Microsoft Purview sensitivity labels upstream; agents honor label-based access for SharePoint and OneDrive content.
- Use the `Accessing transcripts from conversations in Copilot Studio agents` rule to block transcript retention where conversations could contain sensitive prompts.

**Learn more.** [Purview sensitivity labels for Copilot](https://learn.microsoft.com/purview/sensitivity-labels), [Endpoint filtering](https://learn.microsoft.com/power-platform/admin/connector-endpoint-filtering).

---

## 11. Application Lifecycle Management and Pipelines

Application Lifecycle Management (ALM) for Power Platform is built on **solutions**. A solution is a versioned container for apps, flows, agents, tables, roles, and environment variables. Movement between environments always goes through solution export and import — manually, via Power Platform Pipelines, or via Azure DevOps or GitHub.

### 11.1 Treat solutions as the unit of deployment

**Why.** Solutions give you a versioned, traceable artifact. The Default Solution does not; deploying out of it is how teams lose change history.

**How.** Use one solution per deployable unit and avoid the **Default Solution**.

**Learn more.** [ALM basics](https://learn.microsoft.com/power-platform/alm/basics-alm).

### 11.2 Make flows solution-aware

**Why.** Non-solution-aware flows do not move cleanly between environments. Teams that skip this setting end up rebuilding flows in production by hand.

**How.** Turn on `Default to creating new cloud flows as solution-aware` so every new flow lands in a solution by default.

**Learn more.** [ALM basics](https://learn.microsoft.com/power-platform/alm/basics-alm).

### 11.3 Use environment variables and connection references

**Why.** Hard-coded connection strings and configuration values break promotion. Variables and references decouple configuration from solution content.

**How.** Use **environment variables** for configuration and **connection references** for flows and agents so connections can be rebound per environment without editing solution content.

**Learn more.** [ALM basics](https://learn.microsoft.com/power-platform/alm/basics-alm).

### 11.4 Version solutions semantically

**Why.** Semantic versioning makes it possible to reason about what changed between releases. Without it, "version 7" tells you nothing.

**How.** Use semantic versioning (`1.4.2`) and tag the source control commit that produced each version.

**Learn more.** [ALM basics](https://learn.microsoft.com/power-platform/alm/basics-alm).

### 11.5 Adopt Power Platform Pipelines for native deployment

**Why.** Pipelines provide a deployment surface that runs inside the Power Platform itself — no external CI/CD required. For most low-code teams, they are the right starting point, and as of 2024 Microsoft has positioned them as the **strategic replacement for the now-deprecated ALM Accelerator for Power Platform** (covered in 11.6).

**How.** Pipelines require a **host environment** where the pipeline configuration is stored. **Target environments** must be Managed Environments (the host itself does not need to be). Source and target environments are registered in the host. A deployment imports a solution, rebinds connection references, and runs solution checker. Approvals can be attached to deployment stages.

**Learn more.** [Power Platform Pipelines](https://learn.microsoft.com/power-platform/alm/pipelines).

### 11.6 Set up the pipelines host (and migrate off the ALM Accelerator)

**Why.** Two pieces of status to keep straight when standing up native ALM:

1. **The ALM Accelerator for Power Platform is deprecated (Microsoft Learn page last updated 2024-04-09).** Microsoft's overview page is now titled *"ALM Accelerator for Power Platform (Deprecated)"* and carries this notice: *"The ALM Accelerator is deprecated and will be removed in a future release. Use Pipelines in Power Platform to bring ALM automation capabilities to Power Platform and Dynamics 365 services. Pipelines can be used with source code integration or extended to integrate with other providers."* The accelerator was a canvas-app-plus-Azure-Pipelines reference implementation; the strategic replacement is the native Power Platform Pipelines experience described in 11.5. The accelerator continues to function for now, but no new investment is going into it and it is on track to be removed.
2. **The pipelines host solution is not the CoE Starter Kit.** They are different solutions with different purposes; conflating them leads to stalled rollouts. (The CoE Starter Kit itself is also no longer actively maintained — see part 1, section 8.6 — but that is a separate transition from the ALM Accelerator one.)

**How.** Install the **Power Platform Pipelines** managed solution in the host environment (sometimes referenced as the *Deployment Pipeline Configuration* app). Register environments in the `Deployment Environments` table. If your tenant currently runs on the ALM Accelerator canvas app and Azure DevOps templates, treat this as the trigger to plan a migration to Pipelines — start by mapping each accelerator pipeline to a Pipelines stage, then route new solutions through Pipelines and freeze the accelerator pipelines for net-new work. Source-control integration is on the Pipelines roadmap; if you need it today, fall back to Build Tools or GitHub Actions (11.10) rather than to the accelerator.

**Learn more.** [Set up Pipelines](https://learn.microsoft.com/power-platform/alm/set-up-pipelines), [ALM Accelerator for Power Platform (Deprecated)](https://learn.microsoft.com/power-platform/guidance/alm-accelerator/overview).

### 11.7 Run pipelines as service principals

**Why.** Pipelines should not depend on a human account that might leave the company. Service principals carry their own lifecycle and credentials.

**How.** Assign a service principal with `System Administrator` in source and target environments. Use a **delegated service account** or **managed identity** where supported to avoid storing client secrets.

**Learn more.** [Application users](https://learn.microsoft.com/power-platform/admin/manage-application-users).

### 11.8 Promote solutions with the PAC CLI

**Why.** Manual export and import via the UI is fine for one-off moves but not for repeatable deployments. The CLI is what survives review, automation, and offboarding.

**How.** A typical export/import:

```
pac auth create --url https://dev.crm.dynamics.com
pac solution export --name HRSolution --path ./HRSolution.zip --managed
pac auth create --url https://test.crm.dynamics.com
pac solution import --path ./HRSolution.zip --force-overwrite
```

**Learn more.** [pac pipeline reference](https://learn.microsoft.com/power-platform/developer/cli/reference/pipeline).

### 11.9 Trigger a pipeline deployment from the CLI

**Why.** Pipeline runs should be drivable from automation. The CLI provides exactly the surface needed.

**How.** Authenticate against the source environment first, then run:

```
pac pipeline deploy --solutionName HRSolution `
                    --currentVersion 1.4.1 `
                    --newVersion 1.4.2 `
                    --stageId <stageId>
```

The active `pac auth` profile selects the pipeline; deployment notes are not a CLI argument and are added through the admin UI when needed.

**Learn more.** [pac pipeline reference](https://learn.microsoft.com/power-platform/developer/cli/reference/pipeline).

### 11.10 Use Azure DevOps or GitHub when policy requires it

**Why.** Native pipelines are the right tool for most low-code teams, but they do not cover every release scenario — external approvals, multi-stack coordination, artifact signing.

**How.** **Power Platform Build Tools** (Azure DevOps) and **Power Platform Actions** (GitHub) expose the same CLI commands as pipeline tasks. Use them when the release policy requires capabilities the native pipelines do not have.

**Learn more.** [Power Platform Build Tools](https://learn.microsoft.com/power-platform/alm/devops-build-tools), [GitHub Actions for Power Platform](https://learn.microsoft.com/power-platform/alm/devops-github-actions).

### 11.11 Deploy managed, not unmanaged, to higher environments

**Why.** Unmanaged solutions in production allow layered customization that erodes traceability. Managed solutions force changes back through ALM.

**How.** Deploy **managed** solutions to test and production. Enable the **Block unmanaged customizations** setting per environment (under Settings > Features) for production environments to prevent unmanaged changes from being imported.

**Learn more.** [ALM basics](https://learn.microsoft.com/power-platform/alm/basics-alm), [Block unmanaged customizations](https://learn.microsoft.com/power-platform/alm/block-unmanaged-customizations).

---

## 12. Solution Checker and Quality Gates

Solution checker is a static-analysis engine that inspects solution contents against a Microsoft-maintained rule set. It runs on canvas apps, model-driven apps, Power Fx, Dataverse customizations, plug-ins, web resources, cloud flows, and Copilot Studio agents.

### 12.1 Run on demand for fast feedback

**Why.** Makers and reviewers want feedback before they commit, not after the fact. On-demand runs close that gap.

**How.** Run from the Power Platform admin center, from `make.powerapps.com`, or with `pac solution check`.

**Learn more.** [Solution checker](https://learn.microsoft.com/power-platform/alm/checker-api/overview).

### 12.2 Integrate with pipelines

**Why.** Manual runs depend on discipline. Pipeline-integrated runs depend on configuration, which is more reliable.

**How.** Solution checker runs automatically before deployment in Power Platform Pipelines. No additional setup is needed beyond registering the pipeline.

**Learn more.** [Power Platform Pipelines](https://learn.microsoft.com/power-platform/alm/pipelines).

### 12.3 Enforce at solution import

**Why.** A warning that does not block is a warning that gets ignored. Enforcement turns solution checker into an actual gate.

**How.** In Managed Environments, set `Solution checker enforcement` to `Warn` or `Block` for solution import. At `Block`, an import containing a rule violation at or above the threshold fails with the list of offending components.

**Learn more.** [Solution checker enforcement](https://learn.microsoft.com/power-platform/admin/managed-environment-solution-checker).

### 12.4 Understand the rule categories

**Why.** Knowing what solution checker looks for helps you read the output and prioritize fixes.

**How.** The rule categories include:

- **Security** — use of `Execute Fetch` with user-supplied input, open redirects in web resources, plug-in secrets in traces.
- **Performance** — non-delegable queries in canvas apps, missing indexes in Dataverse, synchronous plug-ins on create/update of high-volume tables.
- **Design** — missing connection references, hard-coded GUIDs, deprecated API calls.
- **Reliability** — missing error handling in flows, unbounded loops, overlapping workflow triggers.
- **Compatibility** — usage of deprecated or removed platform features.

**Learn more.** [Rule reference](https://learn.microsoft.com/power-apps/maker/data-platform/use-powerapps-checker).

### 12.5 Run from the CLI and consume SARIF

**Why.** Output that can be parsed by the rest of your toolchain is output that gets used. SARIF is the lingua franca of code scanners.

**How.** Run with the CLI and consume the SARIF output:

```
pac solution check --path ./HRSolution.zip `
                   --geo Europe `
                   --ruleSet "Solution Checker"
```

The CLI returns a SARIF file that can be uploaded to GitHub code scanning or parsed in Azure DevOps. Severity is one of `High`, `Medium`, `Low`, `Informational`.

**Learn more.** [pac solution check](https://learn.microsoft.com/power-platform/developer/cli/reference/solution#pac-solution-check).

### 12.6 Configure enforcement thresholds explicitly

**Why.** Default thresholds may not match your risk tolerance. Configuration makes the threshold explicit instead of implicit.

**How.** In the admin center, `Edit Managed Environments > Solution checker`:

```
Enforcement: Block
Severity threshold: High
Exclusion rules: (solution-specific overrides)
```

**Learn more.** [Solution checker enforcement](https://learn.microsoft.com/power-platform/admin/managed-environment-solution-checker).

### 12.7 Validate agents through complementary checks

**Why.** Agents have failure modes apps and flows do not — missing fallbacks, public knowledge, blocked-channel publish. No single tool covers all of them.

**How.** Solution checker validates the solution container that holds a Copilot Studio agent (flows, plug-ins, web resources inside the solution), and DLP enforcement validates connector usage at design time. For agent-specific quality — topic coverage, fallback behavior, knowledge source configuration — use **agent evaluations** (section 12.8) and manual review as part of the deployment approval. DLP policy violations (references to blocked connectors, no-authentication publish) surface as real-time authoring errors, not as solution checker findings.

**Learn more.** [Solution checker](https://learn.microsoft.com/power-platform/alm/checker-api/overview), [Configure data policies for agents](https://learn.microsoft.com/microsoft-copilot-studio/admin-data-loss-prevention).

### 12.8 Add agent evaluations for behavioral quality

**Why.** Solution checker validates structure, not behavior. Behavioral quality — does the agent give the right answer to the right prompt — needs a separate gate.

**How.** Copilot Studio includes **agent evaluations**: define test sets of prompts and expected behaviors, then run them before publish. Evaluations are complementary to solution checker, not a replacement.

**Learn more.** [Agent evaluations](https://learn.microsoft.com/microsoft-copilot-studio/analytics-agent-evaluation-intro).

---

## 13. Licensing and Capacity Governance

Licensing is a governance concern because runtime usage of Power Platform and Copilot Studio is gated by assigned licenses and consumed capacity. Capacity misconfiguration is a leading cause of outages.

### 13.1 Pick the right Power Apps license model

**Why.** Per-app and per-user pricing have different break-even points. Choosing the wrong one for your usage pattern overpays for licenses or under-provisions makers.

**How.** **Power Apps** ships per user or per app. Per-app covers one app (or one portal) per license per user; per-user covers unlimited apps. Pick based on the number of apps the average user consumes.

**Learn more.** [Power Platform licensing overview](https://learn.microsoft.com/power-platform/admin/pricing-billing-skus).

### 13.2 Match Power Automate plans to flow type

**Why.** Per-user, per-flow, and process plans suit different scenarios. Buying the wrong plan creates a cliff: either you over-license low-volume flows or run out of capacity on high-volume ones.

**How.** **Power Automate** ships per user (user plan) or per flow (Process license). The **Hosted Process** license is a superset that adds hosted machine capacity for unattended RPA workloads. Pick per-user for broad automation adoption; use Process or Hosted Process licenses for high-volume or RPA-specific flows.

**Learn more.** [Power Platform licensing overview](https://learn.microsoft.com/power-platform/admin/pricing-billing-skus).

### 13.3 Allocate Dataverse capacity per environment

**Why.** Without explicit allocation, environments draw from the tenant pool until exhausted. When the pool is gone, every over-pool environment goes read-only at once.

**How.** Dataverse capacity (database, file, log) accrues per tenant and is allocated per environment. Assign capacity explicitly under `Resources > Capacity > Environments`.

**Learn more.** [Capacity in admin center](https://learn.microsoft.com/power-platform/admin/capacity-storage).

### 13.4 Plan Copilot Studio consumption

**Why.** Copilot Studio consumption is metered in credits, and there is no hard tenant-wide cap. Budget alerts, not blocks, are the primary guard against runaway spend.

**How.** **Copilot Studio** consumes **Copilot Credits** based on feature type (generative answers, actions, autonomous events), sold as **prepaid capacity** or **pay-as-you-go** (PAYG). Microsoft 365 Copilot user licenses include a separate allowance. Credit consumption varies by the capabilities an agent invokes, not by a flat per-message rate. Constraints to plan for:

- PAYG requires a **billing policy** linked to an Azure subscription, configured at the environment level; without it, PAYG is inactive.
- Configurable consumption caps are being introduced (2026 release wave 1); until fully rolled out, budget alerts remain the primary guard against runaway spend.
- Consumption reporting is in `Resources > Capacity > Copilot Studio`.

Monitor trends weekly and set Azure budget alerts on the PAYG meter subscription.

**Learn more.** [Copilot Studio licensing](https://learn.microsoft.com/microsoft-copilot-studio/requirements-licensing-subscriptions), [Pay-as-you-go setup](https://learn.microsoft.com/power-platform/admin/pay-as-you-go-overview).

### 13.5 License Power Pages by site capacity

**Why.** Power Pages licensing is per-site, not per-user, which is easy to miss when projecting cost.

**How.** **Power Pages** is licensed by authenticated or anonymous user capacity per site. Plan capacity per site, not per identity.

**Learn more.** [Power Platform licensing overview](https://learn.microsoft.com/power-platform/admin/pricing-billing-skus).

### 13.6 Use group-based licensing and audit monthly

**Why?** Direct license assignment leaves orphaned licenses behind when users leave. Group-based licensing keeps assignment in sync with employment.

**How.** Use Microsoft Entra ID group-based licensing. Audit monthly with PowerShell:

```
Connect-MgGraph -Scopes "Directory.Read.All"
Get-MgUser -All -Property AssignedLicenses,UserPrincipalName |
  Where-Object { $_.AssignedLicenses.SkuId -contains "<Power Apps Per User SKU>" } |
  Select-Object UserPrincipalName
```

**Learn more.** [Power Platform licensing overview](https://learn.microsoft.com/power-platform/admin/pricing-billing-skus).

### 13.7 Account for Developer Plan environments

**Why.** Developer environments are free per user but count against tenant environment quotas. Without a plan, they accumulate quietly.

**How.** **Power Apps Developer Plan** provides free developer environments (up to three per user) for learning and building. Developer environment capacity does not count against the tenant's paid environment quota. Use default environment routing to manage developer environments centrally.

**Learn more.** [Developer Plan](https://learn.microsoft.com/power-platform/developer/plan).

---

## 14. Change Management and Release Rings

Power Platform receives continuous updates from Microsoft and from in-tenant makers. A change management practice that controls both streams keeps environments predictable.

### 14.1 Choose a release channel per environment group

**Why.** Microsoft pushes updates continuously. Channels let you control whether an environment gets updates as soon as they ship or after a slower validation period — a critical lever for production.

**How.** Power Platform environments support three channels:

- **Auto** (default) — updates arrive as they are released to ring-by-ring deployment and are recommended for production environments where stability is achieved through Microsoft's own gradual rollout.
- **Monthly** — fixed monthly cadence; let's pilot environments to preview the next set of updates before they reach Auto.
- **Semi-Annual** — available for model-driven apps; updates arrive on a six-month cadence for organizations that need longer validation cycles.

Set the channel with the environment group rule **Release channel**. Production groups typically stay on `Auto`; pilot groups use `Monthly` for early validation. The `Semi-Annual` channel is primarily relevant for model-driven app scenarios that require extended validation.

**Learn more.** [Release channels](https://learn.microsoft.com/power-platform/admin/release-channels), [Model-driven app release channels](https://learn.microsoft.com/power-apps/maker/model-driven-apps/channel-overview).

### 14.2 Track Microsoft release waves

**Why.** Release waves announce major capability changes twice a year. They are how you anticipate behavior changes that channels alone cannot smooth over.

**How.** Track release waves through the Microsoft Dynamics 365 release plans site and surface relevant items in your CoE communications.

**Learn more.** [Release waves](https://learn.microsoft.com/dynamics365/release-plans/).

### 14.3 Gate previews and experimental features

**Why.** Preview features can disappear, change behavior, or carry undocumented limits. They do not belong in regulated environments.

**How.** Use the `Generative AI settings` and `Preview and experimental AI models` rules at the environment group level to gate preview capabilities. Keep previews off in regulated groups; enable in a pilot group with representative data.

**Learn more.** [Rules for environment groups](https://learn.microsoft.com/power-platform/admin/environment-groups-rules).

### 14.4 Define in-tenant change categories

**Why?** Treating every deployment the same way over-controls routine changes and under-controls risky ones. Categories let you match scrutiny to risk.

**How.** Apply the same change categories used in traditional IT:

1. **Standard** (pre-approved) — patch increments of an existing solution, deployed via pipelines.
2. **Normal** — new apps, flows, or agents; requires CoE or architecture review.
3. **Emergency** — hotfixes; post-implementation review required.

Each category maps to a pipeline approval configuration. Approvals are implemented as Dataverse records in the pipelines host with Azure AD group-based reviewer lists.

**Learn more.** [Power Platform Pipelines](https://learn.microsoft.com/power-platform/alm/pipelines).

### 14.5 Use administration mode during deployments

**Why.** Deploying while users are active risks corrupted state and poor user experience. Administration mode blocks user traffic while the change is being made.

**How.** Enable administration mode with the CLI:

```
pac admin set-runtime-state --runtime-state AdminMode
```

Revert with `--runtime-state Enabled`.

**Learn more.** [Administration mode](https://learn.microsoft.com/power-platform/admin/admin-mode).

### 14.6 Take a manual backup before risky changes

**Why.** Automatic backups follow a schedule; risky changes do not. A manual restore point taken just before a deployment is the cheapest insurance available.

**How.** Run `pac admin backup` to create a manual restore point. Set the **Backup retention** rule to at least 28 days for production groups.

**Learn more.** [Manual backups](https://learn.microsoft.com/power-platform/admin/backup-restore-environments).

### 14.7 Communicate changes through known channels

**Why.** Surprises drive support volume. The cheapest way to reduce surprise is to communicate changes through channels the audience already reads.

**How.** Layer three channels:

- The **Message Center** in the Microsoft 365 admin center surfaces Power Platform MC alerts. Subscribe Power Platform admins and CoE members.
- Use the **Maker welcome content** rule to publish in-product notices for upcoming behavior changes.
- Maintain a tenant changelog in the CoE environment, linking MC IDs, affected environments, and owners.

**Learn more.** [Message Center](https://learn.microsoft.com/microsoft-365/admin/manage/message-center).

### 14.8 Plan for rollback

**Why.** Rollback in Power Platform is limited and asymmetric. Pretending it is straightforward leads to ugly outages when something does need to be reversed.

**How.** Rollback is constrained to Dataverse restore points and solution re-import of a prior version. Canvas apps retain version history; model-driven apps roll back via solution version. For Copilot Studio, earlier agent versions can be restored from the agent version list.

**Learn more.** [Manual backups](https://learn.microsoft.com/power-platform/admin/backup-restore-environments), [Copilot Studio agent versions](https://learn.microsoft.com/microsoft-copilot-studio/authoring-publish-basics).

---

## Conclusion: bringing both parts together

Power Platform governance is not a single product, a single policy, or a single role. Across the two articles in this reference, the cumulative result is shown to be the result of many small, well-placed controls working together. Part 1 covered the platform on which everything stands: an environment topology that matches how the organization actually builds, a default environment treated as a perimeter rather than a playground, Managed Environments and environment groups that make policy enforceable at scale, DLP and tenant isolation that bound where data can move, identity and Conditional Access that decide who is allowed to touch the platform at all, and monitoring that turns activity into evidence. Part 2 covered everything that runs on that platform: Copilot Studio controls that extend the same model to AI agents, agent authentication and connector governance that shape what agents are allowed to do, ALM and pipelines that move solutions through environments traceably, solution checker and agent evaluations that gate quality at import and publish, licensing and capacity governance that prevent runtime surprises, and change management practices that absorb both Microsoft's rollouts and your own without disrupting users.

The two halves only work together. Part 1's controls are not useful without something to govern; part 2's controls do not stick without the foundations underneath them. Sharing limits matter only because Managed Environments make them enforceable. Solution checker enforcement matters only because environmental groups can apply it consistently. Entra Agent ID matters only because Conditional Access gates the identities of those agents present. The two articles are designed to be read as a single document, split for readability, not as independent pieces.

The controls described across both parts already exist in the platform today. Nearly all are generally available; Entra Agent ID (section 10.2) is still in preview. None of them requires custom engineering or third-party tooling to be useful. What they require is decision-making: which environments belong in which group, which connectors are business versus non-business, which agents must authenticate with Microsoft Entra ID, which release channel each group follows, who approves a production deployment, and where the lines are drawn between regulated and general-purpose work. Those decisions *are* governance.

Start small and iterate. A minimum viable posture across both articles is: restrict default environment creation, attach a tenant-wide baseline DLP policy, enable default environment routing with a Managed Environments group, turn on tenant-level analytics, lean on the Power Platform admin center's **Inventory**, **Usage**, **Monitor**, and **Actions** experiences (the CoE Starter Kit is no longer actively maintained), verify your tenant isolation defaults, require authenticated agents, run solution checker at import, deploy through **Power Platform Pipelines** as a service principal (the strategic replacement for the now-deprecated ALM Accelerator), and set Auto channel for production with Monthly for a pilot ring. Everything else in these two articles is a refinement on that foundation. Governance that grows with the platform is governance that lasts; governance that is bolted on after an incident rarely recovers the ground it lost.

Read this reference end to end once to map the territory, then return to it section by section as decisions come up. Both articles are designed to be skimmed for vocabulary and read closely when a specific control is at issue.
