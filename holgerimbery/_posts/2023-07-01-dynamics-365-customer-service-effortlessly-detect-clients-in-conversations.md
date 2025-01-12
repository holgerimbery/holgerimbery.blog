---
layout: post
title: "Dynamics 365 Customer Service: Effortlessly Detect Clients in Conversations"
date: 2023-07-01
author: admin
slug: dynamics-365-customer-service-effortlessly-detect-clients-in-conversations
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-07-01-dynamics-365-customer-service-effortlessly-detect-clients-in-conversations
---

You can better assist customers by automatically identifying them and viewing their account and case details on the Active Conversation page. One way to achieve this is by setting up pre-conversation questions in the appropriate chat widgets. See here my blog article "[Assessing Customer Experience with Surveys](https://the.cognitiveservices.ninja/dynamics-365-customer-service-assessing-customer-experience-with-surveys)".

The utilization of customer responses can be leveraged to execute detailed searches within records and display the corresponding results. The search operation is conducted for an account or contact using the Name, Email, or Phone Number fields. Concerning accounts, the Phone Number refers to the Phone field on the Account Summary page; for contacts, it relates to the Mobile Number field on the Contact Summary page. In cases where an active case is being handled, a search is performed using the Case Number field.

Upon receiving an incoming conversation request from a customer, an agent gets contextual information regarding that request along with details about that particular customer, if available. Once they accept this incoming message, a notification indicates that they are engaged in an active conversation, displaying all relevant information about the customer and case details accordingly. If there exists one active case related to either contact or account identified during this process, it will automatically become linked with this conversation; however, should another issue arise which requires attention from a different case manager, such cases may also be manually attached as needed.

Regarding voice calls coming into your system through phone numbers specified within mobile phone fields or account phone fields relating to specific contacts, these calls can be effortlessly identified by your team members, allowing them to provide timely and appropriate responses.

## How to Set It Up

Use the following question names to create pre-conversation questions.

---

Entity:  
Account  
  
Mapping:  
Question context key: Name  
Attribute logical name: name  
  
Question context key: Email  
Attribute logical name: emailaddress1  
  
Question context key: Phone  
Attribute logical name: telephone1 (**Phone** field on the **Account Summary** page)  
  
answer type:  
single line

---

Entity:  
Contact

Mapping:  
Question context key: Name  
Attribute logical name: fullname

Question context key: Email  
Attribute logical name: emailaddress1

Question context key: Phone  
Attribute logical name: telephone1  
(Mobile Phone field on the Contact Summary page)

answer type:  
single line

---

Entity:  
Incident

Mapping:  
Question context key: CaseNumber  
Attribute logical name: ticketnumber

answer type:  
single line

---

![pre-conversation survey]({{site.baseurl}}/images/cljjoi85l000709l873ex3ovi.md/5f64818a-d37e-4331-9a1b-03c9cf66c7e7.png)

Figure: pre-conversation survey

![configuration of pre-conversation survey]({{site.baseurl}}/images/cljjoi85l000709l873ex3ovi.md/cfdeed7c-cbd8-4d64-9a85-1c498a503dc3.png)

Figure: configuration of pre-conversation survey

## Link the customer and case to conversations when the bot escalates or concludes the conversations

When a bot concludes a customer conversation, it can connect a case number with the dialogue. The bot can create or retrieve this case number based on specific customer information like their name, email address, or phone number.

When the bot determines that escalation to a human agent is necessary, it can link the customer and case number to their conversation. This allows all relevant information to be easily accessed in one place when an agent accepts an escalation request through the Active Conversation section. The summary of this escalation provides agents with essential context that can quicken resolution times and improve overall support.

Values must be assigned to associated attributes such as names and phone numbers to establish these links between customers and cases. The bot will then search for matching records within corresponding entities like customers and cases before linking them if there's only one match found. Context parameters must also be set for automatically identifying customers during conversation transfer by bots.

Entity to be linked Variable name to be set by bot Attribute for Dynamics 365 entity to match with corresponding variable name in bot

| **Entity to be linked** | **Variable name to be set by bot** | **Attribute for Dynamics 365 entity to match with corresponding variable name in bot** |
| --- | --- | --- |
| account | Name, Email, Phone | name, emailaddress1, telephone1 |
| contact | Name, Email, Phone | name, emailaddress1, telephone1 |
| case | CaseNumber | tickernumber |

For information on creating context variables for Azure and Power Virtual Agents bots, refer to the [guide on configuring context variable](https://learn.microsoft.com/en-us/dynamics365/customer-service/context-variables-for-bot#configure-context-variables-for-power-virtual-agents-bot)s for the bot.

## Conclusion

Dynamics 365 Customer Service enables businesses to detect clients in conversations, improving the support experience effortlessly. By setting up pre-conversation questions and linking customer and case details, agents can access relevant information quickly, leading to faster resolution times and enhanced customer satisfaction.