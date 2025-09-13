---
layout: post
title: Copilot Studio licensing
description: Microsoft Copilot Studio offers a flexible licensing model built around Copilot Credits, with pay-as-you-go and subscription options to suit different organizational needs. This comprehensive guide explains how credits are consumed, tracked, and managed across various AI agent activities, helping organizations make informed decisions about their Copilot Studio implementation.

date: 2025-09-13
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/09/igal-ness-9wY2ofzQ9Us-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@igalness?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Igal Ness</a> on <a href="https://unsplash.com/photos/person-holding-fan-of-100-us-dollar-bill-9wY2ofzQ9Us?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>

category: [copilotstudio]
author: admin
featured: true
toc: true
---
{: .q-left }
> **Summary Lede**: Microsoft Copilot Studio offers a flexible licensing model built around Copilot Credits, with pay-as-you-go and subscription options to suit different organizational needs. This comprehensive guide explains how credits are consumed, tracked, and managed across various AI agent activities, helping organizations make informed decisions about their Copilot Studio implementation.


## Understanding Microsoft Copilot Studio Licensing

Microsoft Copilot Studio represents an evolution in conversational AI technology, providing organizations with a comprehensive platform to create, customize, and deploy intelligent AI agents. Built on Microsoft's Power Platform, Copilot Studio enables both technical and non-technical users to develop conversational experiences through natural language instructions or traditional graphical interfaces.

This article examines the licensing structure that supports Copilot Studio deployments, with particular attention to the credit-based consumption model that Microsoft has implemented. By understanding how Copilot Credits work, how they're consumed across different agent activities, and the available licensing options, organizations can make informed decisions about their Copilot Studio implementation strategy while effectively managing costs and resources.

The licensing approach reflects Microsoft's focus on flexibility, allowing organizations to scale their AI capabilities according to actual usage patterns rather than being locked into rigid licensing tiers. Whether you're considering a small-scale implementation or an enterprise-wide deployment, this factual overview provides the essential information needed to navigate the licensing considerations for Microsoft Copilot Studio.

## How to License Copilot Studio

Licensing for Copilot Studio is based on the consumption of Copilot Credits. These credits serve as the common currency across Copilot Studio capabilities and are required whenever users interact with Copilot Studio agents or when agents perform tasks on behalf of users.

There are two main licensing models for Copilot Studio and a usage rights option for Microsoft 365 Copilot users:

### Copilot Studio Pay-as-you-go Meter

- The pay-as-you-go meter allows organizations to pay based on the actual number of Copilot Credits consumed in a billing month.
- No up-front license commitment is required, providing flexibility and scalability.
- Pricing: $0.01 per Copilot Credit.
- Meter counts the total number of Copilot Credits consumed by agents.
- To build and manage agents under this model, users must have the Copilot Studio Author role (assigned via the Power Platform Admin Center). There is no additional cost for this role.

### Copilot Studio Copilot Credit Pack Subscription License

- Copilot Credits can also be purchased in advance through a subscription license.
- Each credit pack provides 25,000 Copilot Credits per month.
- Pricing: $200 per pack per month.
- It is recommended to set up the pay-as-you-go meter as a backup in case of overages.
- To build and manage agents, a Copilot Studio User License (at no additional cost) is required for each user. It is recommended to acquire tenant and user licenses together to simplify the onboarding process.

### Microsoft 365 Copilot License

- Users with a Microsoft 365 Copilot license can create and publish plugins for M365 Copilot.
- Pricing: $30 per user/month (as part of Microsoft 365 Copilot).
- Includes unlimited* usage for Copilot Studio features within Microsoft 365 experiences.
- Limited to creating and publishing plugins only within Microsoft 365 environments.
- Cannot publish agents to external channels outside of Microsoft 365 experiences.
- Access to Power Platform connectors and Dataverse for Copilot Studio is included.
- *Usage limits may be adjusted by Microsoft as the product evolves.

### Licensing Overview Table

| Feature/Plan                                      | Pay-as-you-go Meter           | Credit Pack Subscription      | Microsoft 365 Copilot Use Rights |
|---------------------------------------------------|-------------------------------|------------------------------|----------------------------------|
| Pricing                                           | $0.01 per Copilot Credit      | $200 per 25,000 credits/mo   | $30 per user/month               |
| Included Copilot Credits                          | Pay-as-you-go                 | 25,000 per pack/month        | Unlimited*                       |
| Generative AI                                     | Yes                           | Yes                         | Limited*                         |
| Create & publish agents/flows anywhere            | Yes                           | Yes                         | No                               |
| Create & publish plugins for M365 Copilot         | No                            | No                          | Yes                              |
| Power Platform connectors (standard, premium, custom) | Yes                       | Yes                         | Yes                              |
| Dataverse for Copilot Studio                      | Yes                           | Yes                         | Yes                              |
| Managed Environments                              | Yes                           | Yes                         | Yes (for Copilot Studio features)|
| Available channels                                | Internal & external           | Internal & external          | Microsoft 365 experience         |

* Microsoft reserves the right to update limits as the product evolves.

## Copilot Credits and Their Usage

### What Are Copilot Credits?

Copilot Credits function as the measurement unit for computational resources consumed when Copilot Studio agents perform various operations. These credits quantify the processing power, memory, and system resources required for an agent to retrieve information from knowledge bases, respond to user prompts, execute logic, and perform actions or custom skills through connectors and flows.

The credit consumption model is designed to reflect the actual resource utilization rather than simple interaction counts. The number of credits consumed for any given operation depends on several factors, including:

- The complexity of the task being performed
- The amount of data being processed
- The sophistication of the AI models being leveraged
- The computational resources required for completion

This granular approach to resource measurement enables organizations to pay specifically for what they use, rather than relying on arbitrary user or transaction counts. Credits provide a standardized currency across all Copilot Studio capabilities, creating a consistent way to measure and compare different types of agent activities regardless of their technical implementation.

For planning purposes, organizations should consider that more complex tasks—such as those requiring extensive reasoning, multiple data sources, or sophisticated generative AI capabilities—will typically consume more credits than simpler informational responses or basic data retrievals.

### How Credits Are Consumed

Copilot Studio implements a consumption-based model where credits are utilized each time an agent performs operations or responds to user inquiries. The credit consumption mechanism operates according to the following principles:

- Each agent interaction, whether responding to a user query or executing a programmed action, consumes a specific quantity of Copilot Credits based on the computational resources required.
- The complexity and resource requirements of the task directly influence the number of credits consumed. More sophisticated operations that require extensive processing, multiple data retrievals, or advanced AI capabilities will consume a proportionally higher number of credits.
- Credit consumption occurs regardless of whether the agent is engaged in direct user interaction or performing background automated tasks as part of a scheduled workflow or system process.
- The consumption calculation takes into account factors such as the volume of data processed, the types of AI models utilized, and the computational intensity of the operations performed.
- Different agent capabilities and features have varying credit consumption rates, with more advanced capabilities generally requiring more credits per operation than simpler functions.

Organizations should note that credit consumption represents actual resource utilization rather than arbitrary interaction counts, providing a more accurate reflection of system usage. This approach enables precise cost allocation based on the actual computational work performed by the Copilot Studio environment.

### Details for Each Licensing Model

#### Pay-as-you-go Meter

The pay-as-you-go licensing option provides organizations with maximum flexibility by implementing a consumption-based billing model. Under this approach:

- Organizations are billed at the end of each monthly billing cycle based on the actual number of Copilot Credits consumed during that period. This eliminates the need for estimating usage in advance.
- There is no up-front financial commitment required, allowing organizations to scale their usage according to immediate needs without pre-purchasing capacity.
- Users who need to create, modify, or manage Copilot Studio agents must be assigned the Copilot Studio Author role through the Power Platform Admin Center. This role assignment does not incur any additional licensing costs.
- This consumption-based model is particularly beneficial for organizations with variable AI agent usage patterns or those in the early stages of implementation, when usage patterns may be challenging to predict.

#### Credit Pack Subscription

The Credit Pack Subscription model offers organizations a predictable approach to managing their Copilot Studio costs through advance credit purchases:

- Organizations can acquire Copilot Credits in predefined packages, with each pack containing 25,000 credits that are valid for one month. This approach provides cost predictability for financial planning purposes.
- The subscription model is particularly beneficial for organizations that can reasonably forecast their monthly usage patterns and prefer a consistent monthly expenditure rather than variable billing.
- If actual usage exceeds the quantity of credits purchased through subscription packs in a given month, the system automatically transitions to using the pay-as-you-go meter to cover the overage. This ensures service continuity while maintaining accurate usage accounting.
- Each user who needs to build, modify, or manage Copilot Studio agents must be assigned a Copilot Studio User License. While these user licenses do not incur additional costs beyond the credit packs, they must be allocated appropriately to ensure appropriate access controls and usage tracking.
- This hybrid approach of subscriptions with pay-as-you-go overflow capability provides both the benefits of advance purchasing and the flexibility to accommodate unexpected usage spikes without service interruption.

### Tracking and Managing Credit Consumption

- [The Copilot Studio Agent Usage Estimator](https://microsoft.github.io/copilot-studio-estimator/) can be used to forecast credit consumption.
- All agent activity is visible in the [activity map](https://learn.microsoft.com/en-us/microsoft-copilot-studio/authoring-review-activity), showing actions such as triggers, topics, connectors, and flows.
- Admins can view usage details at the organization/tenant level in the Power Platform Admin Center (PPAC) in the Billing > License> Copilot Studio> Summary tab.
- Organizations can control agent sharing and publishing permissions.
- Capacity is enforced monthly; unused credits do not carry over.
- Exceeding purchased capacity may result in technical enforcement, including service denial.

## Tracking and Managing Credit Consumption

### Estimating and Monitoring Usage

- The Copilot Studio Agent Usage Estimator provides guidance on expected credit consumption but is not a binding offer.
- The activity map in Copilot Studio shows a visual representation of agent actions for each session.

### Credit Consumption: For What and How Are Credits Consumed

Copilot Credits are consumed whenever Copilot Studio agents perform actions, respond to prompts, or use AI tools and flows. The number of credits used depends on the type and complexity of the activity. The following table provides an overview of typical activities and their corresponding credit consumption categories:

| Activity Type                                 | Example Features/Actions                                      | Credit Consumption Category         |
|-----------------------------------------------|---------------------------------------------------------------|-------------------------------------|
| Agent responds to user prompt                 | Classic answer, generative answer                             | Yes                                 |
| Agent retrieves information                   | Data lookup, knowledge base query                             | Yes                                 |
| Agent performs custom skill or action         | Executes Power Platform connector, plugin, or agent flow      | Yes                                 |
| Use of generative AI tools                    | Text generation, summarization, translation                   | Yes (varies by tool complexity)     |
| Content processing in agent flows             | Document processing, invoice/receipt processing, OCR          | Yes                                 |
| Power Automate cloud flows (as agent action)  | Automated workflow triggered by agent                         | No (if within included limits)      |
| Testing agent in embedded test chat           | Running flows or actions in test environment                  | No (test chat credits not counted)  |

Credits are consumed for most agent activities that involve responding to users, retrieving information, or executing actions and custom skills. This includes the use of generative AI tools, content processing, and integration with external systems via connectors and agent flows. The complexity of the action determines the number of credits used. Notably, Power Automate cloud flows do not consume Copilot Credits if they are within the included limits of the subscription, and actions performed in the agent's embedded test chat do not count toward credit consumption. Monitoring and understanding these categories helps organizations estimate and manage their Copilot Studio usage effectively.

### Admin Controls

- Admins can view detailed usage reports in the Power Platform Admin Center.
- Permissions can be set to control who can share or publish agents.
- Publishing of agents using generative AI features can be turned off at the tenant level.

### Capacity Enforcement

- All purchased Copilot Studio capacity is enforced monthly.
- Unused credits do not roll over to the next month.
- Customers exceeding their purchased capacity should adjust their purchase quantity to remain compliant.
- Technical enforcement, including service denial, may occur if usage exceeds purchased capacity.


## Dataverse for Copilot Studio
Microsoft Dataverse is a secure, scalable, and cloud-based data platform that enables users to store, manage, and model business data used in applications across the Microsoft ecosystem. It is the foundational data layer for the Microsoft Power Platform, including Copilot Studio, Power Apps, Power Automate, Power BI, and it also underlies Dynamics 365 applications. Furthermore, Dataverse allows integration with Outlook and SharePoint. Learn more.  

### Dataverse default and accrued subscription capacity entitlements
Copilot Studio's default subscription capacity leverages the same tenant and infrastructure and will accrue across a single tenant. Every tenant with a Copilot Studio license receives default capacity.  

| Copilot Studio capacity per tenant | Default per tenant |
|-----------------------------------|-------------------|
| Dataverse Database capacity | 5 GB |
| Dataverse File capacity | 20 GB |
| Dataverse Log capacity | 2 GB |
   
Copilot Studio, Power Apps, Power Automate, Power Pages, and Dynamics 365 Sales, Customer Service, and Field Service applications leverage the same tenant and infrastructure. Dataverse capacity (Dataverse Database, Dataverse File, and Dataverse Log) is accrued across the tenant and shared among relevant application workloads.  
   
### Dataverse capacity types and purposes

| Dataverse Capacity Type | Purpose |
|-------------------------|---------|
| Database | Stores and manages table definitions and data |
| File | Stores attachments to notes or emails in Power Apps, Dynamics 365 Sales, Customer Service, and Field Service applications. These include documents, offline files, videos, PDF files, and other essential files required by an organization. |
| Log | Records table and column data changes over time for use in analysis and reporting purposes. Log capacity is designed to help organizations meet their auditing, compliance, and governance policies. |
      
The first Power Apps, Power Automate, Copilot Studio, Power Pages, or Dynamics 365 Sales, Customer Service, and Field Service subscription provides the one-time default capacity entitlement for the tenant. For example, if a new customer purchases Power Apps Premium, the tenant will receive 10 GB of default Dataverse Database capacity. Additional subscriptions do not add to the tenant's default capacity. When additional subscriptions are added to the tenant, additional Dataverse capacity may accrue to the tenant.  Example: Assume that a new customer purchases 10 Power Apps Premium licenses and 20 Power Apps per app licenses. The total tenant-wide pooled capacity will be as follows (note 1 GB = 1,024MB):
       
### Default and Accrued Capacity Allocation
| Capacity Type | Default/tenant | Accrued/10 Enterprise USL | Total Tenant-wide capacity |
|---------------|----------------|---------------------------|----------------------------|
| Dataverse Database capacity | 10 GB | 10*250MB + 20*50MB = 3.5GB | 10GB + 3.5GB = 13.5GB |
| Dataverse File capacity | 20 GB | 10*2GB + 20*400MB = 28GB | 20GB + 28GB = 48GB |
| Dataverse Log capacity | 2 GB | NA | 2GB |
| Managed Environments | 1 | NA | 1 |  

### Managed Environments 
Managed Environments provide enhanced governance and control capabilities for organizations using the Power Platform, including Copilot Studio. These environments allow administrators to enforce policies, manage resources, and monitor usage across multiple environments within a single tenant.   
Managed Environments functionality is bundled with these Power Platform licenses and consumption-based options. When a Managed Environment is activated, any active usage within that environment must be covered by one of these license types or consumption meters:

- Full Power Apps and Power Automate licenses
- Copilot Studio complete license
- Power Apps per app consumption meter² and Copilot Studio consumption meter
- Copilot Studio entitlements via Microsoft 365 Copilot license (restricted to Copilot Studio-related capabilities)
- Dynamics 365 Premium, Enterprise, and Team Members' comprehensive licenses

¹*Full licenses refer to complete Power Apps, Power Automate, and Copilot Studio licenses, excluding the restricted Power Apps and Power Automate capabilities included with certain Dynamics 365 licenses.*

²*While the Power Apps per-app consumption meter fulfills the requirement for Power Apps usage in the environment, it only covers Power Apps activities. Any Power Automate workflows must be separately licensed through dedicated Power Automate licenses.*

## additional Resources as of September 2025
- [Copilot Studio Licensing Guide](https://go.microsoft.com/fwlink/?linkid=2320995)
- [Power Platform Licensing Guide](https://go.microsoft.com/fwlink/?LinkId=2085130)

## Conclusion

Microsoft Copilot Studio's licensing model, centered around Copilot Credits, offers a flexible and scalable approach to deploying AI agents across various organizational needs. By understanding the different licensing options—pay-as-you-go, credit pack subscriptions, and Microsoft 365 Copilot use rights—organizations can choose the model that best aligns with their usage patterns and budgetary considerations. The consumption-based credit system ensures that costs are directly tied to actual resource utilization, promoting efficient use of AI capabilities. Additionally, the integration with Dataverse and the availability of managed environments enhance the overall functionality and governance of Copilot Studio deployments. As organizations continue to explore the potential of conversational AI, a clear understanding of licensing and credit consumption will be crucial for maximizing the benefits of this powerful platform while effectively managing costs.

