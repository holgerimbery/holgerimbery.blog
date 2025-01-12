---
layout: post
title: Enhancing Customer Connections The Power of Preferred Agent Routing in Dynamics 365 Customer Service
description: 
date: 2024-04-27
author: admin
image: ./images/enhancing-customer-connections-the-power-of-preferred-agent-routing-in-dynamics-365-customer-service.jpeg
tags: [dynamics365, customerservice]
featured: false
toc: true

---



In the dynamic world of omnichannel contact centers, the concept of preferred agent routing stands out as a cornerstone for delivering exceptional customer service. This strategic approach fosters a sense of familiarity and personalization by connecting customers with agents they've interacted with and streamlines the resolution process through the efficient use of agent expertise. As we delve into the intricacies of this system, we'll explore how it enhances customer satisfaction, optimizes operational efficiency, and ultimately contributes to the success of modern customer service paradigms. Join us as we unpack the significance of preferred agent routing and its impact on the customer experience in today’s service landscape.

## How to enable it in Dynamics 365 Customer Service

Dynamics 365 Customer Service allows customers to direct work items from a particular contact to their chosen agents or relationship managers.

Contacts and their preferred agents can be set up in the Customer Service admin center. If a contact has not been configured, assigning a preferred agent to that contact is not possible. Only agents can be mapped to contacts.

## **Prerequisites**

To configure preferred agent routing, you must possess the Omnichannel Administrator role and have access to the Contact entity. Additionally, if you hold a custom role, access to the **msdyn\_preferredagen**t and **msdyn\_preferredagentcustomeridentity** entities is required. Also, verify that the agent designated for contact is a member of the queue where work items are directed.

## **Configure preferred agent for contacts**

1. In the Customer Service admin center site map, click on **Routing**.
    
2. On the next page, click **Manage** next to **Preferred Agent Routing**.
    
    ![]({{site.baseurl}}/images/clvhthjnp000609mjgdcudpms.md/17e99276-3f69-4a02-ab9f-9917f02289eb.png)
    
      
    
3. Activate **Enable preferred agent routing**.
    
4. Choose who receives the work item if the preferred agent is not available:
    
    * **Next best agent based on assignment logic**: Work items are routed based on the assignment rules, making this option ideal for live chats and voice calls.
        
    * **No one. Let the work remain unassigned in the queue**: The work item remains in the queue until it is either picked up by an agent or manually assigned to another agent. This method is ideal for conversations over asynchronous channels.
        
5. Assign contacts and their preferred agents in the **Preferred Agents matrix** section by following these steps:
    
    1. Click **Add a Contact** to include a contact.
        
    2. In **Contact full name**, type the name of the contact, and choose a name from the dropdown list.
        
    3. Click **Add User** to link agents to the contact.
        
        ![]({{site.baseurl}}/images/clvhthjnp000609mjgdcudpms.md/e7c08836-d983-4ed0-97e1-9610f92992a6.png)
        
          
        
    
    Each contact can have up to three preferred agents assigned to them. The sequence of the agents dictates which agent receives the work item first if the primary agent is unavailable. To reorder the agents, select an agent and utilize the 'Move Up' or 'Move Down' buttons.
    
6. Save and close.
    

## **How routing to a preferred agent works**

When a contact has a designated preferred agent, the system automatically attempts to assign the conversation to an available preferred agent whose presence aligns with one of the permitted presences set in the workstream. This process bypasses the usual checks for agent capacity, skills, and assignment rules. In the event that no preferred agents are available and the Next best agent based on assignment logic is selected as the fallback, the system then seeks an agent who matches the predefined assignment strategy.

It is important to note that routing to preferred agents applies solely to conversations managed via push-based workstreams.

## Conclusion

preferred agent routing in Dynamics 365 Customer Service significantly enhances the customer experience by promoting personalized service and efficient issue resolution. Businesses can foster stronger relationships and higher satisfaction levels by enabling customers to interact with familiar agents. Implementing this system requires careful configuration and understanding of the prerequisites and settings, but the payoff in customer loyalty and operational efficiency is well worth the effort. As customer expectations evolve, leveraging advanced routing options like this will be crucial for businesses aiming to excel in a competitive service landscape.