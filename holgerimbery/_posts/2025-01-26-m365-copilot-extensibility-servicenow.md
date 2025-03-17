---
layout: post
title: Extending Microsoft 365 Copilot with Copilot Studio with ServiceNow as an example 
description: Extending Copilot for M365 with Copilot Studio gives you the ability to create tailored solutions that meet your specific needs and improve overall efficiency.
date: 2025-01-26 10:28
author: admin
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/01/linkedin-sales-solutions-46bom4lObsA-unsplash.jpg
image_caption: 'Photo by <a href="https://unsplash.com/@linkedinsalesnavigator?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">LinkedIn Sales Solutions</a> on <a href="https://unsplash.com/photos/two-women-sitting-at-a-table-looking-at-a-computer-screen-46bom4lObsA?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>'     
tags: [copilotstudio, copilot, servicenow, copilot extensibility]
summary:
featured: false
toc: true
---

## Summary for fast readers

{: .note}
Extending Copilot for M365 with Copilot Studio gives you the ability to create tailored solutions that meet your specific needs and improve overall efficiency. As an example, we will integrate ServiceNow into Copilot using a connector action.  
**Benefit**: Your users can interact with Service Now without the need to leave the Microsoft 365 environment, and IT team can solve issues faster by leveraging the power of Copilot and ServiceNow.

<p><iframe src="https://www.youtube.com/embed/xJkC_UQfZjU" loading="lazy" frameborder="0" allowfullscreen></iframe></p>

## Motivation 
Microsoft 365 Copilot is a versatile tool that uses AI to boost productivity and streamline tasks. With Copilot Studio, users can now customize and extend the capabilities of Microsoft 365 Copilot to better fit their needs. This article explores the various ways to extend Copilot using Copilot Studio, including creating actions with connectors, conversational prompts, and flows.

## Copilot Studio Overview

![upgit_20250126_1737892567.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/01/upgit_20250126_1737892567.png)

Copilot Studio is a platform that allows users to build and customize Copilot agents, specialized assistants designed to perform specific tasks within Microsoft 365. 

The extensibility options in Copilot Studio include:
* Connector Actions
* Conversational Actions
* Prompt Actions
* Flow Actions

### Connector Actions
Connector actions enable Copilot to interact with external systems, retrieve data, or perform actions. These actions are single-turn interactions that can be authenticated and include parameters, cards, and other functionalities. 

![upgit_20250126_1737892633.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/01/upgit_20250126_1737892633.png)

To create a connector action:
- Select the Agent: In Copilot Studio, choose the agent you wish to extend.
- Add Action: Navigate to the Actions tab and select "+ Add Action."
- Choose Connector: Select "Connector" from the list of available action types.
- Configure Connector: Choose the appropriate connector from the list and configure it to perform the desired action.

Connector actions are ideal for integrating external data sources and services into Microsoft 365 Copilot, enhancing its ability to provide relevant and timely information.

### Conversational Actions
Conversational actions allow Copilot to engage in more complex interactions with users. These actions interpret user requests, determine the best action, and generate responses based on predefined logic. 

![upgit_20250126_1737892660.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/01/upgit_20250126_1737892660.png)

To create a conversational action:
- Select the Agent: Choose the agent you wish to extend in Copilot Studio.
- Add Action: Navigate to the Actions tab and select "+ Add Action."
- Choose Conversational: Select "Conversational" from the list of available action types.
- Define Logic: Provide natural language instructions defining conversational flow and responses.

Conversational actions are helpful for scenarios that require multi-turn interactions and more sophisticated responses, such as customer support or guided workflows.

### Prompt Actions
Prompt actions enable Copilot to generate responses based on user prompts. These actions are designed to return generative responses that address specific user queries. 

![upgit_20250126_1737892699.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/01/upgit_20250126_1737892699.png)

To create a prompt action:
- Select the Agent: Choose the agent you wish to extend in Copilot Studio.
- Add Action: Navigate to the Actions tab and select "+ Add Action."
- Choose Prompt: Select "Prompt" from the list of available action types.
- Define Prompt: Provide the prompt text and configure the response logic.

Prompt actions are ideal for scenarios where users need quick, context-specific answers to their questions.

### Flow Actions
Flow actions integrate Power Automate flows with Microsoft 365 Copilot, allowing users to automate processes and workflows. To define custom processes, these actions use the "Run from Copilot" trigger and "Respond to Copilot" action. 

![upgit_20250126_1737892733.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/01/upgit_20250126_1737892733.png)

To create a flow action:
- Select the Agent: Choose the agent you wish to extend in Copilot Studio.
- Add Action: Navigate to the Actions tab and select "+ Add Action."
- Choose Flow: Select "Flow" from the list of available action types.
- Create Flow: The flow editor defines the trigger, actions, and responses.

Flow actions are perfect for automating repetitive tasks and integrating complex workflows into Microsoft 365 Copilot.

## Example: Extending Microsoft 365 Copilot with ServiceNow Integration via a Connector Action

As an example of extending Microsoft 365 Copilot, let's consider integrating ServiceNow into Copilot using a connector action. ServiceNow is a popular IT service management platform for creating, managing, and resolving incidents, requests, and other IT-related tasks.

### Service Now developer Account
To start with a service now integration, you may start with a developer account. You can create a free developer account at [ServiceNow Developer](https://developer.servicenow.com/).

![upgit_20250126_1737892884.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/01/upgit_20250126_1737892884.png)


* Start by creating a Xanadu Developer instance. 

![upgit_20250126_1737893089.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/01/upgit_20250126_1737893089.png)

* After some minutes, you will get the instance ready.
And you can log in to the instance.

![upgit_20250126_1737893476.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/01/upgit_20250126_1737893476.png)

* You can see the instance is ready to use.


### Create a Connector Action in Copilot Studio

To integrate ServiceNow with Microsoft 365 Copilot, we will create a connector action that retrieves incident information from ServiceNow and displays it in Copilot.

* **Create a New Agent**: Create a new agent for the ServiceNow integration in Copilot Studio.

* **Add Connector Action**: Navigate to the Actions tab and select "+ Add Action."

![upgit_20Create](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/01/upgit_20250126_1737893728.png)

* **Choose Connector**: Select "Connector" from the list of available action types.

![upgit_20250126_1737893775.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/01/upgit_20250126_1737893775.png)

*  **Configure Connector**: Choose and configure the ServiceNow connector to authenticate with your ServiceNow instance.

![upgit_20250126_1737893893.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/01/upgit_20250126_1737893893.png)
* **Extend the description** to help the action to identify your needs

* **Configure Action**

![upgit_20250126_1737894432.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/01/upgit_20250126_1737894432.png)

* **Please fill in the missing details** to prepare the action.

![upgit_20250126_1737894707.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/01/upgit_20250126_1737894707.png)

* **Review and Test the Action**: Verify the action settings and test them to ensure they retrieve incident information from ServiceNow.

![upgit_20250126_1737896485.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/01/upgit_20250126_1737896485.png)

* **Create a new connection** to the ServiceNow instance.

![upgit_20250126_1737896616.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/01/upgit_20250126_1737896616.png)

* **Publish the action** to make it available in Copilot.




### Test the Connector Action in the Copilot Chat
After creating the connector action, you can test it in the Copilot Chat to verify that it retrieves incident information from ServiceNow.

* **Test the Action** to get the incidents from the ServiceNow instance

* **Ask for the latest incidents** to get the incidents from the ServiceNow instance

![upgit_20250126_1737897285.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/01/upgit_20250126_1737897285.png)

* **See the incidents** in Service Now for reference

![upgit_20250126_1737897463.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/01/upgit_20250126_1737897463.png)



### Move to your production environment
After you have tested your action in the Copilot Studio, you can move it to your production environment. Make sure to select the right authentication method and permissions for the action.


## Conclusion
The extensibility of Microsoft 365 Copilot with Copilot Studio allows users or system administrators to create tailored solutions that meet their specific needs and improve overall efficiency. By leveraging connector actions, conversational actions, prompt actions, and flow actions, users can enhance the capabilities of Microsoft 365 Copilot to suit their workflows better. Whether integrating external data sources, engaging in complex interactions, generating prompt responses, or automating workflows, Copilot Studio provides the tools necessary to extend the functionality of Microsoft 365 Copilot. As we saw in this article, integrating ServiceNow with Copilot is just one example of the endless possibilities for customization and enhancement offered by Copilot Studio.
