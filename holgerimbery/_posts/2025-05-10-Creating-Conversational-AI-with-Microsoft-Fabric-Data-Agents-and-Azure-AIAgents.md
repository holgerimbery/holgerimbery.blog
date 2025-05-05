---
layout: post
title: Creating Conversational AI with Microsoft Fabric Data Agents and Azure AI Agents
description: Learn how to build conversational AI applications using Microsoft Fabric Data Agents and Azure AI Agents.
date: 2025-05-10
author: admin
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/05/birmingham-museums-trust-vgTENcD9TvE-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@birminghammuseumstrust?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Birmingham Museums Trust</a> on <a href="https://unsplash.com/photos/grayscale-photo-of-industrial-machine-vgTENcD9TvE?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
tags: [fabric, dataagent]
featured: true
toc: true
---

{: .important} 
**Content Classification**  
Content for IT decision makers - Level 100 (Background knowledge)  
Content for IT professionals - Level 100 (Implementation knowledge)   
Content for IT architects - Level 100 (Background and Implementation knowledge)   

{: .note } 
**Summary Lede**
In this comprehensive guide explores how to build powerful conversational AI solutions by combining Microsoft Fabric Data Agents with Azure AI Agents. This integration creates intelligent systems that allow users to interact with enterprise data through natural language, democratizing access to insights across organizations. Whether you're a developer, data scientist, or business analyst, you'll discover how to leverage these technologies to transform raw data into interactive, AI-powered experiences that drive better decision-making and enhance user engagement.

## Overview
As organizations increasingly seek to democratize data access and empower users with AI-driven insights, Microsoft offers a powerful solution through the integration of Microsoft Fabric Data Agents and Azure AI Agents. This combination enables the creation of conversational AI experiences that allow users to interact with enterprise data using natural language.

## What is a Microsoft Fabric Data Agent?
A Fabric Data Agent is a feature within Microsoft Fabric that allows users to build conversational interfaces over enterprise data sources such as:

* Lakehouses
* Warehouses
* Power BI semantic models
* KQL databases

These agents enable users to ask questions in plain English and receive data-driven answers, even if they lack technical expertise or familiarity with the data structure.

## Key Features:
* **Multi-source support**: Up to five data sources can be connected to a single agent.
* **Natural language to SQL (NL2SQL)**: Translates user queries into SQL to retrieve relevant data.
* **Security-aware**: Respects user permissions and access controls.
* **OneLake integration**: Simplifies data source selection and management.

## Creating a Fabric Data Agent: Step-by-Step Kickstarter

Before diving into the creation process, ensure you have:
- Microsoft Fabric capacity (F64 or higher recommended for production)
- Appropriate permissions in your Fabric workspace
- Data sources prepared in your Fabric environment

### Step 1: Create a New Data Agent

1. Sign in to [Microsoft Fabric](https://app.fabric.microsoft.com)
![upgit_20250505_1746446650]https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/05/upgit_20250505_1746446650.png
2. Navigate to your workspace
3. Click the **+ New Workspace** button
![upgit_20250505_1746446755](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/05/upgit_20250505_1746446755.png)
3. Click the **+ New Item** button
5. Select **Data Agent** from the menu options
![upgit_20250505_1746447089](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/05/upgit_20250505_1746447089.png)

6. Provide a name for your agent in the creation dialog

### Step 2: Configure Data Sources

1. In the Data Agent Studio, select **Add data source**
2. Choose from available sources in your OneLake catalog:
    - Lakehouse
    - Warehouse
    - KQL Database
    - Power BI Semantic Model
3. You can add up to five different data sources to a single agent

### Step 3: Select and Configure Tables

1. For each data source, browse and select specific tables
2. Configure table properties:
    - Set a descriptive display name for each table
    - Add descriptions to help the AI understand the data context
    - Configure column properties and descriptions
    - Define relationships between tables if applicable

### Step 4: Test Your Agent

1. Use the built-in chat interface to test queries
2. Review the generated SQL to ensure accuracy
3. Refine your configurations based on test results

### Step 5: Publish and Share

1. Click the **Publish** button in the top right
2. Set permissions for who can access the agent
3. Obtain the agent endpoint URL for integration with other services

### Step 6: Monitor and Refine

1. Review usage analytics in the Fabric portal
2. Gather user feedback on response quality
3. Iteratively improve table descriptions and configurations

Once published, your agent becomes available through its endpoint URL, which can be integrated with Azure AI Agents or other services to create sophisticated conversational AI experiences.

### Additional Resources
* [Microsoft Learn Article](https://learn.microsoft.com/en-us/fabric/data-science/how-to-create-data-agent)
* [Data agent concept](https://learn.microsoft.com/en-us/fabric/data-science/concept-data-agent)
* [Data agent scenario](https://learn.microsoft.com/en-us/fabric/data-science/data-agent-scenario)

## What is an Azure AI Agent?
Azure AI Agents are a powerful tool for building conversational AI applications. They allow developers to create intelligent agents that can understand and respond to user queries in natural language. These agents can be integrated with various data sources, including Microsoft Fabric Data Agents, to provide users with real-time insights and information.
Azure AI Agents leverage the capabilities of Azure OpenAI Service, enabling developers to build sophisticated conversational interfaces that can handle complex queries and provide personalized responses.

## Key Features:
* **Natural Language Understanding**: Azure AI Agents can understand user queries in natural language, making it easier for users to interact with data.
* **Integration with Azure OpenAI Service**: Leverage the power of Azure OpenAI to enhance the conversational capabilities of your agents.
* **Customizable Workflows**: Developers can create custom workflows and logic to handle specific user queries and scenarios.
* **Multi-Channel Support**: Azure AI Agents can be deployed across various channels, including web, mobile, and messaging platforms.

## Integrating with Azure AI Agents and Microsoft Fabric Data Agents
The integration of Microsoft Fabric Data Agents with Azure AI Agents allows organizations to create conversational AI applications that can interact with enterprise data in real-time. This integration enables users to ask questions in natural language and receive instant answers, making it easier to access and analyze data.
The Fabric Data Agent acts as a bridge between the user and the underlying data sources, translating user queries into SQL and retrieving relevant data. This process is seamless and secure, ensuring that users only access data they are authorized to view.

Integration Workflow:
* Create and publish a Fabric Data Agent.
* Connect the Fabric agent to an Azure AI Agent using the endpoint URL.
* Configure the Azure AI Agent to use the Fabric tool via the Azure AI Foundry portal or SDKs.
* Deploy the solution, enabling users to query enterprise data securely and conversationally.
This integration supports multiple SDKs (Python, C#, JavaScript) and REST APIs, making it flexible for developers.

## Use Cases
* **Customer Support**: Use Azure AI Agents to provide real-time support to customers by querying product databases and providing instant answers.
* **Business Intelligence**: Enable business users to ask questions about sales data, inventory levels, and other key metrics using natural language.
* **Data Exploration**: Allow data scientists and analysts to explore large datasets by asking complex queries in natural language.
* **Internal Tools**: Create internal tools that allow employees to access data and insights without needing technical expertise.
* **Conversational Interfaces**: Build chatbots or virtual assistants that can interact with users and provide data-driven insights.


## Microsoft Fabric + Copilot Studio
Microsoft Fabric also integrates with Copilot Studio, a low-code/no-code platform that allows users to create conversational interfaces over enterprise data. This integration simplifies the process of building conversational AI applications, making it accessible to business users and non-technical teams.
Copilot Studio provides a user-friendly interface for creating conversational flows, enabling users to design and deploy chatbots without writing code. This approach is ideal for organizations looking to quickly prototype and deploy conversational AI solutions without extensive development resources.

## Key Features:
* **Low-Code/No-Code Interface**: Users can create conversational flows using a visual interface, reducing the need for coding skills.
* **Integration with Microsoft Fabric**: Seamlessly connect to Microsoft Fabric data sources and leverage their capabilities.
* **Real-Time Data Access**: Enable users to query enterprise data in real-time and receive instant answers.
* **Pre-built Templates**: Access a library of pre-built templates for common use cases, accelerating development time.
* **Collaboration Tools**: Facilitate collaboration between business users and IT teams, ensuring that solutions meet organizational needs.


## Comparison: Fabric Data Agent + Azure AI Agent vs. Fabric + Copilot Studio

<div class="table-container">
  <table>
 <th>Feature</th><th>Fabric + Azure AI Agent</th><th>Fabric + Copilot Studio</th>
    <tr><td>Integration Complexity</td><td>Requires setup of both Fabric and Azure AI Agent, including endpoint configuration and SDK usage.</td><td>More streamlined with low-code/no-code interface in Copilot Studio.</td></tr>
    <tr><td>Customization</td><td>Highly customizable with SDKs and APIs.</td><td>Customization through visual flows and Power Platform connectors.</td></tr>
    <tr><td>Security</td><td>Enterprise-grade with Identity Passthrough and RBAC.</td><td>Inherits Microsoft 365 and Power Platform security model.</td></tr>
    <tr><td>User Experience</td><td>Developer-focused, ideal for embedding in custom apps.</td><td>Business-user friendly, ideal for internal tools and workflows.</td></tr>
    <tr><td>Use Case Fit</td><td>Best for advanced analytics and integration into broader AI ecosystems.</td><td>Best for rapid prototyping and business process automation.</td></tr>
  </table>    
</div>

While both approaches leverage Microsoft Fabric’s powerful data capabilities, the choice depends on your audience and goals. Azure AI Agent integration is ideal for developers building custom AI solutions, whereas Copilot Studio is better suited for business users creating internal tools with conversational interfaces.

## Conclusion
The combination of Microsoft Fabric Data Agents and Azure AI Agents provides a powerful framework for building conversational AI applications. By leveraging the capabilities of both platforms, organizations can create intelligent agents that empower users to interact with data in natural language, driving insights and decision-making across the enterprise.

For teams seeking a more streamlined approach, integrating Copilot Studio with Microsoft Fabric offers a significantly easier implementation path, particularly for business-focused use cases that don't require extensive customization. This low-code alternative accelerates development while still delivering powerful conversational capabilities over enterprise data.

Regardless of which integration path you choose, these technologies democratize data access, enabling users at all levels to harness the power of AI-driven insights without needing deep technical expertise. The key is selecting the approach that best aligns with your team's technical capabilities, customization requirements, and long-term objectives.


