---
layout: post
title: Transform your AI assistants with the ability to generate answers, perform actions, and additional features using Microsoft Power Virtual Agents
date: 2023-06-03
author: admin
slug: transform-your-ai-assistants-with-the-ability-to-generate-answers-perform-actions-and-additional-features-using-microsoft-power-virtual-agents
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-06-03-transform-your-ai-assistants-with-the-ability-to-generate-answers-perform-actions-and-additional-features-using-microsoft-power-virtual-agents

---

Bots are handy tools in today's fast-paced digital world, serving as virtual assistants to help users accomplish various tasks. These bots primarily perform two essential functions: answering user queries or completing actions by calling backend APIs. In the past, both experiences had to be painstakingly crafted using hand-built dialogues. Bot builders would have to anticipate every possible question or action a user might request and then construct specific conversations to address each.

However, with the advent of generative AI and Power Virtual Agents, bot building has become much simpler and more efficient. Now, instead of manually creating complex dialogues for each potential interaction with a user, developers can point their bots towards a knowledge source - an internal SharePoint site or external website - from which the bot can draw upon generative answers that provide rich multi-turn chat experiences.

This approach is not just limited to answering queries but also to completing actions. By pointing their bots towards tenant API collections for specific business needs, developers can leverage the new generative actions engine that allows intelligent calling upon relevant APIs when requests come in.

These powerful features have revolutionized how bots are built today and offer immense advantages in terms of efficiency and effectiveness over traditional methods. Let's delve deeper into each feature to understand its workings better.

## Use your data in conversations with generative answers.

Earlier the year, I wrote about the [conversation booster](https://the.cognitiveservices.ninja/power-virtual-agents-gpt-based-conversation-booster-preview), which allowed bot builders to point to their public website and get answers for the users from them. But now, you can reference various sources of information, such as external websites, internal SharePoint sites, or documents. This enables multi-turn conversations over this knowledge. You can also personalize the bot's responses and customize settings according to your preferences.

Additionally, you can create custom topics that draw data from your backend systems (such as billing or customer relationship management systems) and use our new generative answers node to enable chatbot conversations about this custom data.

* Create a new bot in the latest editing canvas and enter the first web source to get answers from
    

![first external source for generative answers]({{site.baseurl}}/images/clifwxq4501iubynv6ip6awlc.md/504caebc-8b3b-4c31-be1c-0e25c2a7a71f.png)

*Figure: the first external source for generative answers*

* head over to the Settings/AI Capabilities page to tailor the feature to your needs, e.g., add additional information sources.
    

![]({{site.baseurl}}/images/clifwxq4501iubynv6ip6awlc.md/b48b573c-a2a3-4dac-8562-6a259c120690.png)

*Figure: Generative answers configuration and settings page with multiple data sources.*

* scroll down to "Advanced configuration" to modify the feature, if needed
    
    ![Advanced configuration]({{site.baseurl}}/images/clifwxq4501iubynv6ip6awlc.md/91d5d310-4c79-4f4e-aaa6-4974706dccf4.png)
    
    *Figure: Advanced Configuration*
    
    ![conversational boosting topic]({{site.baseurl}}/images/clifwxq4501iubynv6ip6awlc.md/b968487b-9235-49e2-b5d1-644708104b95.png)
    
    *Figure: conversational boosting topic*  
    

You will find a result similar to the screenshot below

![Result]({{site.baseurl}}/images/clifwxq4501iubynv6ip6awlc.md/b4302629-3d7a-4024-b74a-83b17a593ab5.png)

*Figure: Result*  
  
Additionally, by connecting your company's Microsoft Azure OpenAI Service instance with Power Virtual Agents with just a few clicks, your bots can utilize all those capabilities.  
Please find [additional resources](https://the.cognitiveservices.ninja/series/openai-on-azure) on Azure OpenAI Service in this blog.  

## Use generative actions to turn the conversation into action.

In a limited Preview version, bot makers can utilize generative actions capabilities to integrate their tenant APIs, enterprise-specific Microsoft Power Automate flows, or other actions into their bots. In the generative actions-tracing canvas, creators can observe how the bot evaluates and decides which tools to use and what questions to ask. The bot can comprehend the user's inquiry and search through its action library to identify which can best satisfy the request. It then automatically assembles and links them together while creating follow-up questions for the user if more information is needed.

![]({{site.baseurl}}/images/clifwxq4501iubynv6ip6awlc.md/66df5ad2-42ae-4bb5-b15a-c5256f7e8e33.png)

*Figure: Test generative actions tracing and watch the chain log progress.  
*

Generative answers and actions have revolutionized bot building by increasing productivity among bot authors. Previously, constructing many dialogues for every possible question was necessary; however, this task is no longer required with generative AI and Power Virtual Agents. Instead, the system can be directed toward relevant knowledge sources to provide answers to user queries. Additionally, rather than manually creating dialogues for frequently used actions, existing APIs can be connected to address these needs. Combining the ability to chat over company information with dynamically assembling APIs to complete user requests has greatly improved bot building by allowing authors more time to focus on high-value tasks within their organizations.  
  
To register for this limited preview, you need to follow [this process](https://aka.ms/PVAPreviewSignUp).

## Conclusion

Microsoft Power Virtual Agents have transformed bot-building by leveraging generative efficiency AI to generate answers and perform cations. This innovation streamlines the development process and allows developers to focus on high-value organizational tasks. With the ability to draw from multiple knowledge sources and dynamically assemble APIs, Power Virtual Agents have revolutionized how bots are built and you.