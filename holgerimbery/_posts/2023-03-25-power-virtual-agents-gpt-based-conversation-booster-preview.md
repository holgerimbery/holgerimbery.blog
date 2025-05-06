---
layout: post
title: "Power Virtual Agents - GPT based conversation booster (preview)"
date: 2023-03-25
author: admin
slug: power-virtual-agents-gpt-based-conversation-booster-preview
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-03-25-power-virtual-agents-gpt-based-conversation-booster-preview

---

## Motivation

When designing and creating a chatbot with Power Virtual Agents, a situation can occur that users may ask questions that your bot does not have an answer for.  
To ensure that users have access to the information they need, the boosted conversations feature in Power Virtual Agents (preview) can source and display information from external sources, even if a topic has not been created.

This preview capability incorporates the latest AI technology from Azure OpenAI, including using OpenAI's GPT technology. [**Learn more about Azure OpenAI**](https://learn.microsoft.com/en-us/legal/cognitive-services/openai/transparency-note).

 **Caution**  
 Your bot must be created in the US region.  
 Other regions, and languages other than English, aren't supported during the preview.

 **Important (to cite Microsoft)**  
 [**Preview features**](https://go.microsoft.com/fwlink/?linkid=2189520) aren't meant for production use and may have restricted functionality.
 
 The boosted conversations capability also uses Bing Search to retrieve information from publicly available URLs. Your use of Bing Search is governed by the [**Microsoft Services Agreement**](https://go.microsoft.com/fwlink/?linkid=2178408) and the [**Microsoft Privacy Statement**](https://go.microsoft.com/fwlink/?LinkId=521839).

## Solution

Previously, if the bot could not determine the user's intent after two prompts, the system "escalate" topic was used to escalate to a live agent. Now, with the boosted conversations feature, the bot can provide the user with information from external sources, eliminating the need for escalation.

### Activate boosted conversation.

* Create a new bot on your [Power Virtual Agents Website](https://web.powerva.microsoft.com)
    
* Select **Try the unified canvas (preview)**.
    
    ![Create new bot]({{site.baseurl}}/images/clfny97200d0iswnv7pq0fmzm.md/8be9b856-c521-4899-93ed-8fad97a6fb6c.png)
    
    Figure: Create a new bot
    
* Give your bot a name and enter the website you want to use for retrieving data from
    
    ![]({{site.baseurl}}/images/clfny97200d0iswnv7pq0fmzm.md/5fb7318e-13b7-4188-b184-cbcef58bdcd6.png)
    

Figure: enter name and website

Once your bot is created and ready to use, you can check its Overview page to ensure Boost conversations are enabled and the URL is correct.  
  
To change these settings, expand "Settings" from the side navigation pane and select "AI Capabilities".  
Use the checkbox for Boost conversations to enable or disable the capability and add/change the URL.  
Additionally, you can choose the level of content moderation for the bot from the Bot content moderation option, understanding that a higher level of moderation will result in more relevant answers. In comparison, a lower level of moderation will provide more answers, but some could be irrelevant or undesirable.

### Use boosted conversation

Time to check the implementation and ask your bot some questions not covered by topics.

<p><iframe src="https://www.youtube.com/embed/_QLckAWJC0I" loading="lazy" frameborder="0" allowfullscreen></iframe></p>


## Hints

### **URL considerations**

URLs can have up to two levels of depth.

### **Publishing**

During this preview, you won't be able to publish bots that have **Boost conversations** enabled. But your administrator can make a support request to get publishing enabled.

## Conclusion

This preview feature gives a lovely inside on Microsofts Roadmap for Power Virtual Agents and keeps the interest in following tech news high.
