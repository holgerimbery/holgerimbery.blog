---
layout: post
title: Creating an Agent for Microsoft Copilot Chat Using SharePoint as a Knowledge Source
description: explore how to create an intelligent agent for Microsoft Copilot Chat using SharePoint as a knowledge source. By leveraging SharePoint's robust document management capabilities, you can enhance information retrieval, automate responses, and improve overall efficiency in your organization.
date: 2025-03-01
author: admin
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/02/patrick-robert-doyle-OvXht_wi5Ew-unsplash.jpg
image_caption: 'Photo by <a href="https://unsplash.com/@teapowered?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Patrick Robert Doyle</a> on <a href="https://unsplash.com/photos/interior-building-OvXht_wi5Ew?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>'
      
tags: [copilotstudio, copilotchat, sharepoint, knowledgemanagement]
featured: false
toc: true
---
{: .note }
**summary lede**:  
This article explores how to create an intelligent agent for Microsoft Copilot Chat using SharePoint as a knowledge source. By leveraging SharePoint's robust document management capabilities, you can enhance information retrieval, automate responses, and improve overall efficiency in your organization.

## Why Should Business Users Read This Article?

- **Centralized Knowledge Management**: Learn how to centralize your organization's knowledge, making it easier for employees to find and access critical information.
- **Enhanced Efficiency**: Discover ways to automate common queries and tasks, reducing your team's workload and improving productivity.
- **Cost-Effective Solutions**: Understand the pay-as-you-go model for Microsoft Copilot Chat, ensuring you only pay for the resources you use.
- **Practical Guidance**: Follow step-by-step instructions to set up SharePoint as a knowledge source and create an intelligent agent tailored to your business needs.


## Introduction

In the modern workplace, efficient information management is essential. Microsoft SharePoint, a robust collaboration and document management platform, can be integrated with Copilot Studio to create intelligent agents. These agents can help users retrieve information, answer queries, and automate tasks by leveraging the knowledge stored in SharePoint. This article will guide you through using SharePoint as a knowledge source in Copilot Studio to create an agent for Microsoft Copilot Chat and explain how the pay-as-you-go model works for calculating consumption costs.

## Why Use SharePoint as a Knowledge Source?

SharePoint is widely used for storing and managing documents, policies, and other critical information. By integrating SharePoint with Copilot Studio, you can:

## Centralize Knowledge: Ensure all relevant information is stored in one place.

* **Enhance Accessibility**: Make it easier for users to find and access information.
* **Improve Efficiency**: Automate responses to common queries, reducing the workload on human agents.
Setting Up SharePoint as a Knowledge Source

## Prepare Your SharePoint Site:

Ensure your SharePoint site is well-organized and contains all necessary documents and information.
Use modern SharePoint pages and supported file types such as Word documents, PowerPoint presentations, and PDFs.
Remember to set permissions and access levels to ensure the agent can retrieve information correctly and not share sensitive information. Consider using Microsoft Purview to secure your data by setting up sensitivity labels.

## Understanding Microsoft Purview and Sensitivity Labels

### Microsoft Purview

Microsoft Purview is a comprehensive data governance solution that helps organizations manage, protect, and gain insights from their data. It provides tools for data discovery, classification, and lineage tracking, ensuring that data is handled in compliance with regulatory requirements and organizational policies. Using Microsoft Purview, businesses can achieve better data visibility, enhance data security, and streamline data management processes.

### Importance of Sensitivity Labels

Sensitivity labels are a critical feature in Microsoft Purview that allows organizations to classify and protect sensitive information. These labels can be applied to documents, emails, and other data types to enforce protection policies such as encryption, access restrictions, and visual markings. Sensitivity labels help ensure that sensitive information is only accessible to authorized users, reducing the risk of data breaches and ensuring compliance with data protection regulations. Organizations can safeguard their data by implementing sensitivity labels and maintaining trust with their stakeholders.

## Creating an Agent in Copilot Studio

Describe Your Agent:

Use the Describe tab in Copilot Studio to create your agent using natural language. Provide details about the agent's name, description, and instructions.
For example, you might describe your agent: "Your name is KnowledgeBot. You help users find information stored in SharePoint. You should respond in a friendly and professional manner."

## Configure Your Agent:

![add a SharePoint site as a knowledge source](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/02/upgit_20250215_1739638958.png)
*add a SharePoint site as a knowledge source*

Switch to the Configure tab to add more details and customize your agent's behavior.
* Navigate to the Knowledge tab.
* Select "Add knowledge" and choose "SharePoint."
* Enter the URL of your SharePoint site (e.g., holgerimbery.sharepoint.com/sites/policies) without the https:// prefix.
* Configure the authentication settings to ensure the agent can access the SharePoint site

## Test and Publish Your Agent:

Test your agent to ensure it retrieves information correctly and responds as expected.
Once satisfied, publish your agent to make it available to users. You can deploy it in environments like Microsoft Teams or a web app.

## Understanding Pay-As-You-Go for Microsoft Copilot Chat

Microsoft Copilot Chat offers a pay-as-you-go model for agents, allowing you to pay only for what you use.  
Here's how it works:

* Metered Billing:
Agents are priced based on usage, meaning you are charged for the actual consumption of resources.
This model ensures cost efficiency, as you only pay for the agent's interactions and tasks.

* Cost Calculation:
Costs are calculated based on the number of interactions, the complexity of tasks, and the amount of data processed.
For example, a simple query might cost less than a complex data analysis task.

* Monitoring and Management:
IT admins can monitor usage and manage costs through the Copilot Control System.
This system provides detailed reports on agent usage, helping you optimize performance and control expenses.

## When to Start Using Microsoft 365 Copilot

While Microsoft 365 Copilot Chat is excellent for handling basic queries and automating simple tasks, there comes a time when upgrading to the full Microsoft 365 Copilot is beneficial. Consider switching when your organization requires more advanced capabilities, such as complex data analysis, deeper integration with other Microsoft 365 services, and enhanced customization options. The full Microsoft 365 Copilot offers a broader range of features and greater flexibility, making it ideal for businesses looking to maximize productivity and efficiency.

## Conclusion

Integrating SharePoint with Copilot Studio to create an intelligent agent for Microsoft Copilot Chat can significantly enhance your organization's knowledge management capabilities. Following the steps outlined in this article, you can centralize your organization's knowledge, making it easier for employees to find and access critical information. This integration improves efficiency by automating responses to common queries and reduces the workload on your team, thereby boosting productivity.

Understanding the importance of Microsoft Purview and sensitivity labels is crucial for maintaining data security and compliance. Microsoft Purview provides comprehensive data governance solutions, ensuring your data is managed, protected, and utilized in compliance with regulatory requirements. Sensitivity labels further enhance data security by classifying and protecting sensitive information, ensuring that only authorized users have access.

Creating an agent in Copilot Studio involves describing your agent using natural language, configuring its behavior, and adding SharePoint as a knowledge source. This process ensures your agent can effectively retrieve and provide information stored in SharePoint. Testing and publishing your agent ensures it performs as expected and is ready for deployment in environments like Microsoft Teams or a web app.

The pay-as-you-go model for Microsoft Copilot Chat offers a cost-effective solution that charges based on actual usage. This model ensures that you only pay for the agents' interactions and tasks, making it a financially efficient option for businesses. Monitoring and managing usage through the Copilot Control System helps optimize performance and control expenses.

As your organization grows and requires more advanced capabilities, consider upgrading to the full Microsoft 365 Copilot. This upgrade provides more advanced features, deeper integration with other Microsoft 365 services, and enhanced customization options, making it ideal for maximizing productivity and efficiency.

By leveraging SharePoint's robust document management capabilities and integrating it with Copilot Studio, you can create an intelligent agent that enhances information retrieval, automates responses, and improves overall efficiency in your organization. This comprehensive approach ensures that your business remains competitive and well-equipped to handle the demands of modern information management.

