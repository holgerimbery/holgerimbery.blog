---
layout: post
title: Exploring Copilot Studio Features - Classic Orchestration and Generative Orchestration
description: exploring the features of Copilot Studio, focusing on classic and generative orchestration methods. This article is for you if you are a new user of Copilot Studio and want to learn about the fundamentals of the tool or if you are a seasoned user and want a recap on the functionality.
date: 2025-02-22
author: admin
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/02/larisa-birta-slbOcNlWNHA-unsplash.jpg
image_caption: 'Photo by <a href="https://unsplash.com/@larisabirta?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Larisa Birta</a> on <a href="https://unsplash.com/photos/people-playing-violin-inside-dim-room-slbOcNlWNHA?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>'
tags: [copilotstudio]
featured: false
toc: true
---
{: .note }
**summary lede**:  
In this article, we explore the features of Copilot Studio, focusing on classic and generative orchestration methods. This is for you if you are a new user of Copilot Studio and want to learn about the fundamentals of the tool or if you are a seasoned user and want a recap on the functionality. Classic orchestration relies on predefined triggers, topics, and actions to guide conversations, making it suitable for straightforward interactions. On the other hand, generative orchestration uses AI to dynamically manage conversations, allowing for more natural and comprehensive responses. We discuss using triggers, topics, actions, and knowledge in both methods and provide guidelines on when to use each orchestration type. You can create efficient and engaging conversational agents in Copilot Studio by understanding these features.


Copilot Studio offers a range of features designed to create robust and responsive conversational agents. Two key orchestration methods in Copilot Studio are classic orchestration and generative orchestration. Understanding the differences between these methods and how to effectively use triggers, topics, actions, and knowledge is essential for building an efficient conversational agent. This article delves into these features, providing detailed explanations and examples.

## Triggers
Triggers are the starting point for any conversation in Copilot Studio. They are designed to initiate topics based on user input, ensuring the conversation begins in the most relevant context. Triggers are selected based on matching a user query with predefined trigger phrases. 

Here’s when to use triggers:
* **Automatically Start a Topic**: The corresponding topic is activated when a user's query matches a trigger phrase.  
**For example**, if a user asks, "Where can I find the nearest store?", a trigger phrase like "nearest store" can activate a topic that provides store locations.
* **Ensure Relevant Responses**: You can guide the conversation towards the most relevant topic by defining specific phrases. For instance, the trigger phrase "order status" can direct users to a topic that helps them check their order status.  
**Example**: Suppose you have a topic called "Store Locations". You can set trigger phrases such as "find a store", "store near me", or "nearest store". When a user types any of these phrases, the "Store Locations" topic is triggered, and the agent provides the necessary information.

## Topics
Topics are the core of the conversation in Copilot Studio. They guide the flow based on the user's needs and can be selected based on the description of their purpose.   
Here’s when to use topics:
* **Organize Conversation Flows**: Each topic should cover a specific area or purpose, making it easier to manage and update.  
**For example**, you might have separate topics for "Order Status", "Product Information", and "Customer Support".
* **Match User Intent**: Topics are chosen based on how well they align with the user's query and the overall purpose of the conversation. This ensures that the user receives the most relevant information.  
**Example**: 
    * If a user asks, "How can I return a product?" The agent can match this query to a topic called "Returns and Refunds." This topic would then guide the user through returning a product, providing step-by-step instructions.
    * For a topic called "Product Information", you could have trigger phrases like "tell me about product X" or "features of product Y". When a user asks, "What are the features of product Y?", the "Product Information" topic is activated, and the agent provides detailed information about the product.

## Actions
Actions are specific tasks that the agent can perform within a topic. They can only be called explicitly from within a topic.   
Here’s when to use actions:  
* **Perform Specific Tasks**: Actions are designed to execute particular functions, such as retrieving data or performing calculations.   
**For example**, an action might be used to check the status of an order in a database.
* **Enhance Topic Functionality**: By incorporating actions, you can make topics more dynamic and responsive to user needs. Actions can be prebuilt connector actions, custom connector actions, Power Automate cloud flows, AI Builder prompts, Bot Framework skills, or REST API connections.
**Example**: 
    * In a topic called "Order Status", you might have an action that retrieves the current status of an order from your database. The action is called when the user provides their order number, and the agent returns the order status.
    * In a topic called "Appointment Scheduling", you could have an action that checks available time slots in a calendar system. When a user asks to schedule an appointment, the action retrieves available slots and presents them to the user for selection.

## Knowledge
Knowledge serves as a fallback or supplementary resource. It can be used when no topics match a user's query or can be called explicitly from within a topic.  
Here’s when to use knowledge:
* **Provide Additional Information**: If a user's query doesn't match any topic, the agent can search the knowledge base for relevant information. This ensures that the user still receives a helpful response.
* **Proactively Assist Users**: The agent can choose to search the knowledge base proactively to answer user queries, ensuring comprehensive support.
**Example**:
    * If a user asks a question that doesn't match predefined topics, such as "What are the store hours on holidays?", the agent can search the knowledge base for information on holiday hours and provide the user with an accurate answer.
    * For a query like "What is the return policy?", if no specific topic matches, the agent can search the knowledge base and provide detailed information about the return policy, including conditions and timeframes.

## Generative Orchestration


{: .caution}
Generative Orchestration is a preview features, this features aren't meant for production use and may have restricted functionality. 

{: .warning}
Enabling generative orchestration can impact how billing is calculated.

Generative orchestration is a powerful feature in Copilot Studio that enhances agents' ability to manage conversations more naturally and fluidly. The agent can choose the best actions, knowledge, and topics to answer user queries or respond to event triggers.   
Here’s when to use generative orchestration:
* **Create Natural Conversations**: Generative orchestration enables the agent to fill in inputs using details from the conversation history, making interactions more seamless. For example, if a user asks about the nearest store in Berlin and then asks for the weather there, the agent infers that the user wants the weather in Berlin.
* **Chain Multiple Actions or Topics**: The agent can combine multiple actions or topics to provide comprehensive responses. For instance, if a user says, "I need to get store hours and find my nearest store," the agent can handle both requests in a single interaction.
Ask Follow-Up Questions: When the agent is unsure about details, it can ask follow-up questions to clarify and gather the necessary information.  
**Example**: 
    * If a user asks, "Can you help me find a store and tell me the store hours?", generative orchestration allows the agent to find the nearest store and then provide the store hours, even if these tasks are handled by different topics or actions.
    * If a user starts with "I need help with my order" and then asks, "Can I return it?", generative orchestration can seamlessly transition from an "Order Status" topic to a "Returns and Refunds" topic, ensuring the user gets comprehensive assistance without needing to repeat themselves.

## Comparing Classic and Generative Orchestration
To better understand the differences between classic and generative orchestration, let's compare their behaviors:


| Behavior | Classic Orchestration | Generative Orchestration |
|----------|-----------------------|--------------------------|
| Topics | Topics are selected based on matching a user query with trigger phrases | Topics are selected based on the description of their purpose |
| Actions | Actions can only be called explicitly from within a topic | The agent can choose to call actions based on their name and description |
| Knowledge | Knowledge can be used as a fallback when no topics match a user's query (or called explicitly from within a topic) | The agent can choose to proactively search knowledge to answer a user's query |
| Use of Multiple Topics, Actions, Knowledge Sources | Agent tries to select a single topic to respond to the user, falling back to knowledge if configured | The agent can use a combination of topics, actions, and knowledge |
| Asking Users for Input | You must use question nodes in topics to author messages prompting the user for any required information | The agent can automatically generate questions to prompt users for any missing information required to fill inputs for topics and actions |
| Responding to a User | You must use message nodes in topics to author messages responding to the user (or call an action from a topic) | The agent automatically generates a response, using the available information from topics, actions, and knowledge that it has called |

## Enabling Generative Orchestration
To enable generative orchestration in Copilot Studio, follow these steps:
* **Navigate to Your Agent**: Open Copilot Studio and select the agent you want to configure.
* **Access Settings**: Go to the settings menu for your agent.
* **Enable Generative Mode**: Find the option to enable generative orchestration and toggle it on. This setting allows your agent to use generative AI to orchestrate between topics, actions, and knowledge sources.

## Guidelines for Using Classic and Generative Orchestration
### When to Use Classic Orchestration
Simple and Direct Interactions: Use classic orchestration for straightforward interactions where user queries can be easily matched to specific topics using trigger phrases.
Controlled Responses: Classic orchestration is ideal if you need precise control over the conversation flow and responses, as it relies on predefined triggers and actions.
Limited Scope: For agents with a limited scope of topics and actions, classic orchestration ensures that each query is directed to the most relevant topic without unnecessary complexity.  

**Examples**:
* FAQ Bots:
Scenario: A bot designed to answer frequently asked questions about a product or service.
Example: "What is your return policy?" or "How do I reset my password?" These queries can be matched to specific, predefined responses.
* Appointment Scheduling:
Scenario: A bot that helps users schedule appointments.
Example: "I want to book a doctor's appointment next Monday." The bot can use predefined triggers to guide the user through scheduling.
* Order Status:
Scenario: A bot that provides order status updates.
Example: "Where is my order?" or "Has my package shipped?" The bot can match these queries to specific responses based on the order status.

### When to Use Generative Orchestration
Complex and Dynamic Interactions: Use generative orchestration for more complex interactions where user queries may span multiple topics or require dynamic responses.
Natural Conversations: Generative orchestration is the better choice if you want the agent to handle conversations more naturally, filling in details from the conversation history and asking follow-up questions.
Comprehensive Responses: Generative orchestration offers greater flexibility for agents who need to provide comprehensive responses by combining multiple topics, actions, and knowledge sources.

**Examples**:
* Customer Support:
Scenario: A bot that handles complex customer support queries.
Example: A user describes an issue with their product that involves multiple troubleshooting steps. The bot can dynamically generate responses based on the conversation history and provide a comprehensive solution.
* Virtual Assistants:
Scenario: A virtual assistant that helps users with various tasks.
Example: "Can you help me plan my day?" The bot can pull information from the user's calendar, suggest tasks, and ask follow-up questions to refine the plan.
* Personalized Recommendations:
Scenario: A bot that provides personalized recommendations based on user preferences.
Example: "I'm looking for a new book to read." The bot can ask about the user's interests and previous reads and generate a list of book recommendations.

## Conclusion
Classic and generative orchestration are essential features in Copilot Studio that enable you to create responsive and dynamic conversational agents. By understanding the differences between these methods and how to effectively use triggers, topics, actions, and knowledge, you can build conversational agents that provide accurate and relevant information to users. Whether you need to guide users through specific tasks or handle complex interactions, classic and generative orchestration offers the flexibility and control you need to create engaging conversational experiences.

