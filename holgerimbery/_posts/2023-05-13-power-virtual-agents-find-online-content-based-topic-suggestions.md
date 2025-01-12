---
layout: post
title: "Power Virtual Agents: Find Online Content-Based Topic Suggestions"
date: 2023-05-13
author: admin
slug: power-virtual-agents-find-online-content-based-topic-suggestions
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-05-13-power-virtual-agents-find-online-content-based-topic-suggestions

---

Power Virtual Agents is a powerful tool that allows users to populate their chatbots with existing web pages or files. With AI-assisted authoring technology, this feature recognizes a webpage's or online file's structure and content and segregates relevant content blocks related to a support issue or question. This article explains how to use the Suggested Topics feature in three easy steps and how to extract content from web pages or online files. Additionally, it discusses single-turn and multi-turn topic suggestions and how to add them to an existing bot.

There are three main steps to using the feature:

* [Select Suggest topics on the Topics page to extract content](https://learn.microsoft.com/en-us/power-virtual-agents/advanced-create-topics-from-web#extract-content-from-webpages-or-online-files).
    
* [Add the suggested topics to your bot](https://learn.microsoft.com/en-us/power-virtual-agents/advanced-create-topics-from-web#add-suggested-topics-to-an-existing-bot).
    
* [Enable the suggested topics](https://learn.microsoft.com/en-us/power-virtual-agents/advanced-create-topics-from-web#enable-topics-in-your-bot).
    

You can [test the topics in the test chat](https://learn.microsoft.com/en-us/power-virtual-agents/authoring-test-bot), but you'll need to [publish your bot for customers](https://learn.microsoft.com/en-us/power-virtual-agents/publication-fundamentals-publish-channels) to see the latest changes.  

## **Single-turn and multi-turn topic suggestions**

Power Virtual Agents can detect and analyze the structure of documents during content extraction. Depending on the type of content, it can generate either single-turn or multi-turn topics. Single-turn topics are typically associated with simple question-and-answer pairs, such as those found on FAQ pages. On the other hand, multi-turn topics are associated with more complex dialogues, such as when navigating a troubleshooting page or a reference manual. The structure of the original content, including its hierarchy of headings and subheadings, will help determine which type of topic is generated.

## **Extract content from web pages or online files**

First, point to the web pages or online files from which you'd like to extract content. Once the extraction is complete, you will be directed to the Suggested Topics page. Here, you will be able to review topics that were extracted from the web pages or online files. To access the Suggested Topics page, open the navigation menu and select Topics. Then, select Suggest topics. Once on the Suggested Topics page, you can add the topics to your bot for further use.

![]({{site.baseurl}}/images/clhlp6q1l02g0l9nv8l11fwce.md/ed40cb87-1bd4-4cfd-85b4-a4e9334fbec8.png)

Figure: Suggest topics

Once you have finished adding URLs to webpages and online files, click "Start" to begin the extraction process. This can take several minutes, depending on the number and complexity of the web pages or files you have added. A message will appear at the top of the screen indicating that the extraction is in progress and may take some time.

![]({{site.baseurl}}/images/clhlp6q1l02g0l9nv8l11fwce.md/ec4a2acc-3dc5-49ac-bf1a-0316fa95a874.png)

Figure: raw data

![]({{site.baseurl}}/images/clhlp6q1l02g0l9nv8l11fwce.md/b5c7ce2c-6baf-48e4-843d-0f5a7cb6120f.png)

Figure: Enter URL

* Once extraction is complete, go to the **Suggested** tab.  
    Several suggestions will appear.
    

![]({{site.baseurl}}/images/clhlp6q1l02g0l9nv8l11fwce.md/6e13d686-b03a-4289-8990-f99c83c9d5cc.png)

Figure: Suggested

## **Add suggested topics to an existing bot**

Once the extraction process is finished, the topic suggestions will be displayed on the Suggested tab. You can review them individually to decide which ones you want to use for your bot or add suggestions without checking them.

* Select the name of the suggested topic.
    
* Review the trigger phrase and suggested **Message** node
    

## Activate the topics

Do not forget to enable the added topics.

## Conversation booster (preview)

**Use the feature described in this article in production while waiting for the new, still in preview, conversation booster feature (**[**article with step-by-step guide**](https://the.cognitiveservices.ninja/power-virtual-agents-gpt-based-conversation-booster-preview)**).** conversation booster is a dynamic content integration feature, while this here is static.

## Conclusion

In conclusion, Power Virtual Agents' Suggested Topics feature is a powerful tool that allows users to extract content from web pages and online files and add them to their chatbots. The AI-assisted authoring technology recognizes a webpage's or online file's structure and content and segregates relevant content blocks related to a support issue or question. This feature can generate both single-turn and multi-turn topics, depending on the type of content. By following the three easy steps outlined in the article, users can add suggested topics to their existing bots and enable them for use. Overall, this feature can save time and effort in creating chatbot content and improve the user experience for customers seeking support.