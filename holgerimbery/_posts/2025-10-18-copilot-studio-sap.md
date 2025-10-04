---
layout: post
title: Integrating SAP with Copilot Studio Agents - Why it Matters, What to Build, and How to Deliver
description: This article explores how to integrate SAP systems with Microsoft Copilot Studio Agents, enabling AI-driven interactions and workflows within enterprise environments. It covers architecture, use cases, and best practices for leveraging SAP data in AI agents.
date: 2025-10-18
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/10/peter-miranda-fTw24pNs21w-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@petermiranda?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Peter Miranda</a> on <a href="https://unsplash.com/photos/man-in-blue-and-black-cap-looking-at-silver-imac-fTw24pNs21w?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>

category: [copilotstudio, SAP, agents]
author: admin
featured: true
toc: true
---

{: .q-left }
> **Summary Lede**:  
> Enterprise systems often operate in silos, forcing users to switch contexts and applications to complete business tasks. By connecting SAP's robust business processes with Microsoft Copilot Studio agents, organizations can now bring critical operational data and transactions directly into Microsoft 365 and Teams—where people already collaborate. This integration enables AI-driven, conversational interactions with SAP systems, eliminating the need to switch applications and accelerating decision-making and productivity across the enterprise.


Bringing SAP data and actions directly into Copilot Studio agents puts your operational truth in the same place people already collaborate—Microsoft 365 and Teams—so users don't have to switch tools or context when they need to look up a sales order, check ATP, raise a vendor query, or submit an approval. This "in‑the‑flow‑of‑work" approach is now practical thanks to: (1) SAP APIs (OData, RFC/BAPI) made accessible and governable via SAP Integration Suite API Management and/or Azure API Management, and (2) native SAP connectors and agent publishing pipelines in Copilot Studio and Microsoft 365 Copilot.   

Integrating SAP with Copilot Studio agents is straightforward using first‑party connectors (SAP OData and SAP ERP) that support secure, scalable connectivity patterns (including Entra ID SSO and on‑premises data gateway). By exposing SAP APIs through API Management, you can enforce security policies, apply principal propagation to preserve SAP authorizations, and avoid overloading core systems. Once connected, you can build low-code agent flows that call SAP tools and publish agents to Teams and Microsoft 365 Copilot for easy user access. This approach reduces friction, improves adoption, and accelerates decision-making by keeping users in their primary collaboration environment.

## Why integrate SAP into Copilot Studio?

### Keep people in the flow of work (no app‑switching)

Publishing your Copilot Studio agents into Microsoft 365 Copilot and Teams enables business users to ask questions like “Show undelivered sales orders for Contoso this week” directly in chats, channels, or Copilot Chat—without needing to open SAP GUI or a separate portal. This reduces friction, improves adoption, and shortens cycle time for everyday decisions.


### Use enterprise‑grade connectors and governance—safely

Microsoft provides two first‑party SAP connectors: **SAP OData** (for S/4HANA, SuccessFactors, Concur, etc.) and **SAP ERP** (RFC/BAPI/IDoc for NetWeaver‑based systems). These support secure connectivity patterns (including Entra ID SSO through Azure API Management)
With API Management (SAP Integration Suite APIM and/or Azure API Management), you can surface SAP APIs with throttling, policy‑based security, and a consistent developer experience—critical to avoid overloading core systems and to apply SSO/principal propagation at scale.

### Scale with Microsoft 365 Copilot extensibility

Copilot Studio agents can be published to Microsoft 365 Copilot and extended with actions/connectors. IT can approve and manage agents centrally, and makers can add SAP tools (via connectors) to ground responses in real data. This aligns SAP extensions with Microsoft 365 governance and discoverability. 

### Tangible productivity upside

Microsoft highlights customers building SAP‑aware copilots to accelerate routine tasks and collaboration, with broad AI adoption already underway. While ROI varies by scenario, the direction of travel is clear: combining SAP process data with Microsoft 365 context reduces handoffs and speeds decision‑making. 


## What to integrate: high‑value SAP scenarios for agents

1) **Sales order intelligence**: List orders by status, customer, or date; drill into header/line details; share to channel; trigger follow‑ups. (OData: `SalesOrderSet`; RFC/BAPI alternative via SAP ERP connector).

2) **Product and ATP lookups**: Search by category, price, or material; confirm availability; propose substitutions. (OData entity sets from SAP Gateway or S/4HANA).   
3) **Business partner and supplier checks**: Find suppliers/customers by name, city, or role; fetch contact details.   
4) **Approvals and postings**: Kick off approvals or post to SAP via BAPIs (e.g., create SO, post time) using the SAP ERP connector through the on‑premises data gateway. 
5) **Analytics on HANA as knowledge**: For read‑only Q&A on curated HANA data sets, use Copilot Studio's SAP HANA knowledge source (real‑time reasoning without copying data). 
6) **Incident and ticket management**: Integrate with SAP Solution Manager or ITSM systems to create, update, or query tickets.
7) **HR and expense queries**: Access SuccessFactors or Concur data for leave balances, expense status, etc. (OData services).
8) **Custom workflows**: Build tailored processes that combine SAP data with Microsoft 365 actions (e.g., notify a team in Teams when a high‑value order is delayed).


## How it works: reference architecture patterns

**Pattern A — OData via API Management (cloud)**  
Expose S/4HANA OData services through SAP Integration Suite API Management or import OData directly into Azure API Management; secure with Entra ID (OAuth 2.0), apply policies, and consume from Copilot Studio using the SAP OData connector (option: "Entra ID via Azure APIM"). Best for modern OData APIs and consistent SSO/governance. [documentation](https://learn.microsoft.com/en-us/power-platform/sap/connect/sap-odata-connector)

**Pattern B — RFC/BAPI via on‑premises data gateway (hybrid)**  
Use the SAP ERP connector through the on‑premises data gateway to call RFCs/BAPIs/IDocs in ECC or S/4HANA. Ideal when required operations aren't exposed via OData or when you need deep SAP function modules. Supports SAP/Windows/Entra ID auth. [Read more](https://learn.microsoft.com/en-us/power-platform/sap/connect/sap-erp-connector)

Microsoft's reference architectures show how both patterns coexist alongside custom/APIM gateways, with M365 Copilot/Copilot Studio as the conversational front end. [Read more a](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/sap/sap-power-platform-architecture-workflow), [b](https://learn.microsoft.com/en-us/power-platform/architecture/reference-architectures/arch-pattern-sap)


## Security and identity (SSO and principal propagation)

Establish Entra ID ↔ SAP trust using SAP Cloud Identity Services (IAS/IPS) and OAuth/SAML flows; for OData behind SAP APIM or Azure APIM, apply principal propagation so the end‑user identity is mapped to their named SAP user—preserving SAP authorizations. [SAP Documentation](https://help.sap.com/docs/cloud-identity-services/cloud-identity-services/integrating-service-with-microsoft-azure-ad)

Microsoft and SAP provide step-by-step guides for Entra ID SSO to SAP BTP, as well as scenarios where Azure API Management fronts SAP OData, including direct OData import and production-ready policy patterns. Documentation [Read more a](https://learn.microsoft.com/en-us/entra/identity/saas-apps/sap-btp-provisioning-tutorial),[b](https://learn.microsoft.com/en-us/azure/api-management/sap-api),[c](https://community.sap.com/t5/technology-blog-posts-by-members/up-level-your-sap-odata-apis-with-azure-api-management/ba-p/13563562)


## Example: the same scenario, seen two ways

### A) For business users — "Sales operations in Teams, no context‑switch"

**Scenario**: A sales manager asks in Teams: *"List undelivered sales orders for Contoso placed this week, and show header + top 5 items."* The Copilot Studio agent (published to Teams/M365 Copilot) resolves intent, calls an SAP OData tool, returns a table, and offers quick actions (share to channel, export, kick off an email) without leaving Teams—impact: fewer clicks, faster status checks, and less time hunting through SAP GUI or reports. 

### B) For developers — "Guided implementation"

**Goal**: Implement the "Sales Orders" flow using OData through API Management + Copilot Studio.

1. **Expose SAP OData with API Management**  
   - Option 1 (Azure APIM): Import your SAP OData `$metadata` to automatically scaffold operations; configure backend, policies, and OAuth.
   - Option 2 (SAP Integration Suite APIM): Create API provider/proxy/product; apply security/threat‑protection policies; publish for consumption.

2. **Secure with Entra ID + principal propagation**  
   - Use OAuth2 SAML Bearer or equivalent policy to exchange the Entra token for an SAP‑trusted token; enforce per‑user access in SAP. 

3. **Connect from Copilot Studio**  
   - In your Copilot Studio solution, add the **SAP OData connector** and choose **"Microsoft Entra ID via Azure API Management"** for SSO; for on‑prem ECC or BAPIs, use the **SAP ERP connector** through the **on‑premises data gateway**. 

4. **Create tools (actions) and agent flows**  
   - Build an **Agent Flow** (Power Automate‑backed) that takes filter parameters, calls your OData entity set, and returns structured JSON.  
   - Add the flow as a **Tool** to the agent and describe inputs/outputs so generative orchestration can auto‑select it.

   **Example OData filter built in the flow**:
   ```text
   $filter=CustomerName eq 'Contoso' and DeliveryStatus eq 'Undelivered' and OrderDate ge 2025-09-28
   &$top=20&$orderby=OrderDate desc
   ```
   (Entity names depend on your backend service; import metadata to confirm.)

5. **Design the conversational topic**  
   - Create a **Topic** that captures user intent ("get undelivered orders"), extracts entities (customer, date range, status), composes the filter string, invokes the tool, and formats the response as a table. 
6. **Publish to Teams and Microsoft 365 Copilot**  
   - Publish the agent; connect Teams and Microsoft 365 channels; let admins review/approve in the app store; share the install link with target users. 

7. **Govern and monitor**  
   - Manage connectors/actions via Integrated Apps; monitor API usage in APIM; apply DLP and tenant governance in Power Platform; iterate on prompts/tools using Copilot Studio analytics. 

**Alternative (RFC/BAPI)**: For operations that require BAPIs/IDocs (e.g., `BAPI_SALESORDER_CREATEFROMDAT2`), install the on‑premises data gateway and SAP .NET Connector (NCo 3.1), configure the **SAP ERP connector**, and call the function from an Agent Flow. 


## Design choices and trade‑offs

- **OData vs. RFC/BAPI**: Prefer OData for read scenarios and modern S/4HANA services with API management and OAuth; use RFC/BAPI when deep SAP functions are required and you can deploy the on‑premises gateway.   
- **SAP APIM vs. Azure APIM**: Both are viable; some customers run both and catalog APIs centrally (avoid "API sprawl"). Choose based on network topology, governance tooling, and where you want the enforcement point.   
- **Identity**: Align on Entra ID as the primary IdP with SAP IAS as proxy for SAP cloud services; implement principal propagation so SAP authorizations remain intact.   
- **Knowledge vs. actions**: For read‑only analytical Q&A on curated datasets, HANA knowledge sources can be efficient; for transactional workflows, use tools/actions via connectors. 


## Checklist to get started (both roles)

**Business owner**
- Prioritize 2–3 high‑impact questions (e.g., "What's shipping late today?"). Keep scope tight for your first agent.  
- Decide the channel (Teams/M365 Copilot) and audiences for rollout and testing. 

**Developer/architect**
1. Inventory the SAP API you need (OData service or BAPI) and choose Pattern A or B. 
2. Set up SSO and principal propagation with Entra ID + APIM.  
3. Configure the SAP OData or SAP ERP connector in Copilot Studio/Power Automate (gateway as needed).   
4. Build Agent Flows, wire them as Tools, and author Topics. 
5. Publish to Teams/M365 Copilot; enable admin review and user install.
6. Monitor usage, gather feedback, and iterate.



## Additional resources

- [**Field demo** — "Simplifying SAP Access with Gen AI" (Aditheos): end‑to‑end pattern, agent flows, Teams channel.](https://aditheos.com/2025/06/26/simplifying-sap-access-with-gen-ai-built-on-copilot-studio-integrated-via-sap-btp-azure-apim-delivered-in-teams-copilot/)  
- [**SAP OData connector** and **SAP ERP connector** docs (auth options, gateway, setup).](https://learn.microsoft.com/en-us/power-platform/sap/connect/sap-odata-connector)[12](https://learn.microsoft.com/en-us/power-platform/sap/connect/sap-erp-connector)  
- [**Azure API Management** — Import SAP OData metadata directly; policy‑based governance.](https://learn.microsoft.com/en-us/azure/api-management/sap-api)  
- [**SAP Integration Suite API Management** — API gateway, products, policies, lifecycle.](https://help.sap.com/docs/sap-btp-guidance-framework/integration-architecture-guide/applying-api-management)  
- [**Principal propagation** patterns (Entra ID ↔ SAP).](https://community.sap.com/t5/technology-blog-posts-by-sap/principal-propagation-between-azure-ad-and-an-on-premise-sap-system-through/ba-p/13503731)  
- [**Publish agents to Teams/M365 Copilot** and **Copilot extensibility**.](https://learn.microsoft.com/en-us/microsoft-copilot-studio/publication-add-bot-to-microsoft-teams)[6](https://www.microsoft.com/en-us/microsoft-copilot/blog/copilot-studio/publish-your-microsoft-copilot-studio-agents-to-microsoft-365-copilot/)[11](https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/)  
- [**Architecture references** for SAP + Power Platform/Copilot Studio.](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/sap/sap-power-platform-architecture-workflow)[15](https://learn.microsoft.com/en-us/power-platform/architecture/reference-architectures/arch-pattern-sap)


## Conclusion

Integrating SAP systems with Copilot Studio agents represents a significant advancement in enterprise productivity. By combining SAP's robust business processes and data directly into Microsoft 365 and Teams, organizations can eliminate context switching, accelerate decision-making, and enhance user adoption of critical business systems.

This integration is now practical and secure through first-party connectors, API management solutions, and established identity patterns that preserve SAP's authorization model. The architecture patterns outlined—whether using OData via API Management or RFC/BAPI via on-premises gateways—provide flexible implementation options suitable for various SAP landscapes.

Organizations should begin with focused, high-value scenarios that solve real business pain points, then expand as users experience the benefits of AI-assisted, in-context SAP interactions. With proper governance and security controls in place, this approach not only streamlines operations but also maximizes the return on existing investments in both SAP and Microsoft technologies.

The future of enterprise productivity lies in these intelligent, contextual experiences that bring critical business systems directly to users, rather than forcing them to navigate multiple interfaces. By connecting SAP's process depth with Microsoft's collaboration breadth, Copilot Studio agents deliver on the promise of AI that works for people—not the other way around.


