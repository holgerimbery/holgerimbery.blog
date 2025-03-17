---
layout: post
title: "Generative Answers with Power Virtual Agents"
date: 2023-07-29
author: admin
slug: generative-answers-with-power-virtual-agents
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-07-29-generative-answers-with-power-virtual-agents
---

Generative answers within Power Virtual Agents offer a convenient way for your bot to retrieve and display information from various sources, both internal and external. Unlike authored topics, generative answers do not require pre-determined subjects to be created beforehand. They can serve as your chatbot's main information source or be a fallback option when existing topics fail to address user inquiries. This feature streamlines the bot creation process by enabling you to build and launch a functional chatbot quickly without spending time manually authoring multiple topics that may not adequately address customer queries.

In previous times, if an automated bot could not understand the purpose behind a user's message, it would request that the user rephrase their query. If this happened twice without success, the bot would turn to human assistance by utilizing the system's Escalate topic. This article explains how to set up generative answers as a backup option when existing bot topics cannot resolve a user's intent.

In the next article of this series, I will explain how this feature is utilized within a topic.

## Setup generative Answers during bot creation

* Create a new bot in the editing canvas
    
* select US English as the language and
    
* enter a publicly available source into the URL field at the bottom
    

![configure generative answers while generating a new bot]({{site.baseurl}}/images/clknobi76000909ldh0067s3b.md/c7be102f-65ed-43d2-a861-781310cc83c0.png)

Benefits of doing so:

* Search web addresses using Bing and summarize relevant results with GPT.
    
* Dramatically increase the number of questions your bot can answer in seconds without the complexity of creating FAQs or topics.
    
* Reuse existing content from your organization's data.
    
* Access multiple sources (limited preview).
    
* Support internal documentation, allowing for internal knowledge sources such as SharePoint.
    

## Give it a try, even if your tenant is not enabled

It is always a got habit to start exploring new features as soon as they arise on the horizon.

To try out the feature, you can use a [demo page](https://aka.ms/pvademo) from Microsoft and your data.

![demo page for generative answers]({{site.baseurl}}/images/clknobi76000909ldh0067s3b.md/b23b42bd-6f8c-4681-8854-9d61574e9f53.png)

## Tailor the experience if your tenant is enabled

![configuration of additional resources]({{site.baseurl}}/images/clknobi76000909ldh0067s3b.md/62702f24-ef68-4228-832e-dc7c87bbcba2.png)

To add additional sources, go to the settings and add them.  
The feature works with up to 2 sublevels.

## Demo

%[https://youtu.be/_pSm0Rk8w-E] 

## Conclusion

Generative answers in Power Virtual Agents provide a more efficient and versatile way to address user inquiries by leveraging existing information sources and reducing manual topic authoring. This feature enhances the chatbot's overall functionality and improves user experience by providing quick and relevant responses to a broader range of questions.