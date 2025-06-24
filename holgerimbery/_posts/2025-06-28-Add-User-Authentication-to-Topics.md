---
layout: post
title: Add User Authentication to Topics
date: 2025-06-28 06:19
category: 
author: 
tags: []
summary: 
---

As organizations increasingly rely on conversational AI to streamline operations and enhance user experiences, securing access to sensitive information becomes paramount. Microsoft Copilot Studio offers a powerful feature that allows developers to add end-user authentication to specific topics within their bots, ensuring that only authorized users can access protected content or perform sensitive actions.

In Microsoft Copilot Studio, authentication can be configured both at the agent level and at the topic level. While agent-level authentication secures the entire bot experience, topic-level authentication allows for more granular control, enabling secure access only when specific sensitive topics are triggered. This is especially important in business scenarios where certain workflows—like accessing personal employee data, financial records, or customer-specific information—require additional security. For example, in an HR copilot, viewing payroll details should prompt user authentication, even if general HR queries do not. This ensures compliance with data protection policies and minimizes unnecessary access to confidential information.

## prepare the basics
Configure manual authentication with Microsoft Entra ID
You need to configure user authentication with Microsoft Entra ID before you can use authentication in your topics.

Follow the instructions in Configure user authentication with Microsoft Entra ID.

## Add user authentication with the Sign in system topic
When you create an agent, Copilot Studio automatically adds a system topic called Sign in. To use it, you must set your agent's authentication to manual and require users to sign in. When a customer starts a conversation with the agent, the Sign in topic triggers and prompts the user to sign in. You can customize the Sign in topic as appropriate for your agent.



Open your agent in Copilot Studio, select Settings at the top of the page, and then select Security.

Select Authentication.

Select Authenticate manually, and then select Require users to sign in.

Configure all manual authentication fields, as required.

Select Save.


## Add user authentication with a custom topic
The Sign in topic authenticates the user at the beginning of the conversation. To allow the user to sign in later, you can add an Authenticate node to any custom topic.

When customers enter their user name and password, they might be prompted to enter a validation code. After they sign in, they're not prompted again, even if they reach another Authenticate node.

Select Settings at the top of the page, and then select Security.

Select the Authentication tile.

 Note

You must select Authenticate manually to add user authentication to a custom topic.

Clear the Require users to sign in checkbox.

Configure all manual authentication fields, as required.

Select Save.

Select Topics at the top of the page.

Select Add node (  ) > Advanced > Authenticate.

Test your topic with a user configured with your identity provider.