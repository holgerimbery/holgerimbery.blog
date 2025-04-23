---
layout: post
title: Implementing Pay-As-You-Go Payment for Copilot Studio Agents and Agent Flows
description: This article explores the implementation of a pay-as-you-go (PAYG) payment model for Copilot Studio agents and agent flows, highlighting its economic advantages, practical setup guidance, and monitoring strategies. By adopting the PAYG model, organizations can optimize resource allocation, reduce upfront costs, and maintain operational continuity while leveraging advanced AI capabilities.
date: 2025-04-26
author: admin
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/04/blake-wisz-q3o_8MteFM0-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@blakewisz?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Blake Wisz</a> on <a href="https://unsplash.com/photos/woman-holding-magnetic-card-q3o_8MteFM0?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
      
tags: [copilotstudio, pay-as-you-go, copilotstudioagentflow, azure, subscription]
featured: true
toc: true
---
{: .note}
Summary lede: Implementing a pay-as-you-go (PAYG) payment model for Copilot Studio agents and agent flows offers a cost-effective and flexible approach to managing AI-driven workloads. This article explores the economic advantages of the PAYG model, such as cost efficiency, scalability, and accessibility, making it an ideal choice for organizations with dynamic or variable demands. Additionally, it provides practical guidance on setting up PAYG payment, including linking to an Azure subscription, configuring the PAYG meter, and monitoring usage effectively.
By adopting the PAYG model, businesses can optimize their resource allocation, reduce upfront costs, and maintain operational continuity. The article also highlights key implementation steps and tools to help organizations seamlessly integrate PAYG payment into their Copilot Studio environment, ensuring transparency and control over expenses while leveraging advanced AI capabilities.


## Why implemented a pay-as-you-go payment model?
The PAYG payment model offers several advantages:

- **Cost Efficiency**:
PAYG allows organizations to avoid upfront costs and only pay for what they use. This is particularly beneficial for businesses with fluctuating workloads, as they can scale their usage up or down based on demand.
- **Flexibility**:
With PAYG, there is no need for long-term commitments. Organizations can start using Copilot Studio agents and agent flows without the need for extensive planning or budgeting for licenses.
- **Scalability**:
The PAYG model supports business continuity by allowing organizations to scale their usage seamlessly. If the message pack capacity is exceeded, the PAYG meter ensures that operations continue without interruption.
- **Transparency**:
Detailed monitoring and reporting tools provide transparency into usage patterns and costs, enabling organizations to optimize their resource allocation and manage expenses effectively.
- **Accessibility**:
PAYG makes advanced AI capabilities accessible to a broader range of organizations, including small and medium-sized enterprises that may not have the budget for large upfront investments.
By implementing a PAYG payment model, organizations can leverage the full potential of Copilot Studio agents and agent flows while maintaining control over their costs and ensuring flexibility to adapt to changing business needs.

## Setting Up Pay-As-You-Go Payment
### Linking to an Azure Subscription

To get started with PAYG, you need to link your Copilot Studio environment to an Azure subscription.
This can be done through the Power Platform admin center by setting up a billing policy.

Navigate to the Power Platform admin center, 
select your environment,
![upgit_20250423_1745394535.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/04/upgit_20250423_1745394535.png)

and configure the billing policy to link it to your Azure subscription.
![upgit_20250423_1745394604.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/04/upgit_20250423_1745394604.png)
![upgit_20250423_1745394689.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/04/upgit_20250423_1745394689.png)

![upgit_20250423_1745394760.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/04/upgit_20250423_1745394760.png)

### Configuring the Pay-As-You-Go Meter
The PAYG meter tracks the number of messages consumed by your agents. Messages are the unit of consumption and are counted based on the complexity of tasks performed by the agents.
At the end of each month, your organization will be billed for the actual number of messages consumed, without any upfront license
commitment.
Navigate to the Power Platform admin center, 
and select the environment you would like to monitor
![upgit_20250423_1745395239.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/04/upgit_20250423_1745395239.png)

### Monitoring and Managing Usage

Utilize the comprehensive monitoring, reporting, and alerting mechanisms provided by Copilot Studio to manage your capacity effectively.
Ensure that you adjust your purchased quantity as needed to remain in compliance and avoid service denial due to exceeding purchased capacity.

## Rates for Pay-As-You-Go Payment
Here is a table summarizing the rates for different Copilot Studio license plans:

### Costs
<div class="table-container">
  <table>
        <tr><th>License Plan</th><th>Rate</th></tr>
    <tr><td>Pay-As-You-Go</td><td>$0.01 per message</td></tr>
    <tr><td>Message Packs</td><td>~$200 per tenant, per month</td></tr>  
  </table>
</div>


### Message scenarios
The following table illustrates the differences in the subscription models for the cost of Copilot Studio events.
<div class="table-container">
  <table>
    <tr><th>Copilot Studio Feature</th><th>Billing Rate</th><th>Use in Microsoft 365 Copilot Scenarios¹</th><th>Autonomous Triggers²</th></tr>
    <tr><td>Classic Answer</td><td>1 message</td><td>No charge</td><td>N/A</td></tr>   
    <tr><td>Generative Answer</td><td>2 messages</td><td>No charge</td><td>2 messages</td></tr>
    <tr><td>Agent Action</td><td>5 messages</td><td>No charge</td><td>5 messages</td></tr>
    <tr><td>Tenant Graph Grounding for Messages</td><td>10 messages</td><td>No charge</td><td>10 messages</td></tr>
    <tr><td>Agent Flow Actions (per 100 actions)</td><td>13 messages</td><td>13 messages</td><td>13 messages</td></tr>
    <tr><td>AI Tools</td><td></td><td></td><td></td></tr>
    <tr><td>Text and Generative AI Tools (Basic)</td><td>1 message (per 10 responses)</td><td>1 message (per 10 responses)</td><td>1 message (per 10 responses)</td></tr>
    <tr><td>Text and Generative AI Tools (Standard)</td><td>15 messages (per 10 responses)</td><td>15 messages (per 10 responses)</td><td>15 messages (per 10 responses)</td></tr>
    <tr><td>Text and Generative AI Tools (Premium)</td><td>100 messages (per 10 responses)</td><td>100 messages (per 10 responses)</td><td>100 messages (per 10 responses)</td></tr>
    </table>
</div>


(1) Interactive use of classic answers, generative answers, tenant graph grounding and agent actions by authenticated Microsoft 365 Copilot users, in Microsoft 365 apps and services, are included at no extra cost.

(2) autonomous triggers refer to events or conditions that automatically initiate an agent to take action, without requiring a user to manually invoke it.

**Classic answers**: These events are predefined responses manually authored by agent makers. They're static and don't change unless manually updated. They're typically used where precise and controlled responses are the only ones we want the agent to generate.

**Generative answers**: These events are dynamically generated using AI models, such as Generative Pretrained Transformers (GPTs). They can adapt and change based on the context and the knowledge sources they're connected to. They're useful for handling a wide range of topics and providing more flexible and natural interactions.

**Tenant graph grounding for messages**: These events provide higher quality grounding for your agents using retrieval-augmented generation (RAG) over your tenant-wide Microsoft Graph, including external data synced into Microsoft Graph through connectors. This results in more relevant and improved responses and ensures that the grounding information is up-to-date. This capability is optional, and you can turn it on or off for each agent. For more information, see Tenant graph grounding.

**Agent actions**: These events are steps, such as triggers, deep reasoning, and topics, that appear on the activity map in Copilot Studio when you test an autonomous agent. These events don't include knowledge search, knowledge retrieval, or AI Builder prompts.

**Text and generative AI tools**: Prompt tools embedded within an agent enable the creator to direct the underlying model to perform intelligent document and image processing tasks, behave in a task-specific manner, or generate scenario-specific outputs. There are three types of tools -basic, standard, and premium- which are based on the underlying LLM of the prompts. The premium text and generative AI tools item are used to charge for advanced reasoning in agents. For more information, see AI Builder licensing in Microsoft Copilot Studio: Message management.

**Agent flow actions**: Item used to charge for agent flows which enhance AI agents with agent flows, which are predefined sequences of flow actions to execute repetitive tasks quickly, without requiring agent reasoning and orchestration at each step. For more information, see Agent flows overview.

Each interaction with an agent might utilize multiple message types simultaneously. For example, an agent grounded in a tenant graph could use 12 messages (10 messages for tenant graph grounding, and 2 messages for generative answers) to respond to a single complex prompt from a user

## Conclusion

Implementing a pay-as-you-go payment model for Copilot Studio agents and agent flows represents a strategic approach to AI resource management that aligns costs directly with value received. By eliminating upfront investments and long-term commitments, organizations can experiment, scale, and optimize their AI implementations with minimal financial risk.

The PAYG model particularly benefits organizations with variable workloads or those just beginning their AI journey. The transparent billing based on actual usage allows for precise budgeting and cost attribution across departments or projects. Additionally, the seamless integration with Azure subscription provides a familiar framework for organizations already operating within the Microsoft ecosystem.

As AI capabilities continue to evolve, the flexibility of PAYG ensures organizations can quickly adapt to new features and usage patterns without renegotiating licensing terms. By monitoring consumption patterns and understanding the different message scenarios, businesses can make informed decisions about their AI investments and potentially transition to message packs when usage stabilizes at predictable levels.

Ultimately, the PAYG model democratizes access to advanced AI capabilities, enabling businesses of all sizes to leverage Copilot Studio's powerful agents and agent flows to drive innovation and operational efficiency in a financially sustainable manner.