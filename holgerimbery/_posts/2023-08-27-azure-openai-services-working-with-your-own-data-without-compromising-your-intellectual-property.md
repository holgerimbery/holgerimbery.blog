---
layout: post
title: "Azure OpenAi services: working with your own data without compromising your intellectual property"
date: 2023-08-27
author: admin
slug: azure-openai-services-working-with-your-own-data-without-compromising-your-intellectual-property
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-08-27-azure-openai-services-working-with-your-own-data-without-compromising-your-intellectual-property
---

## Motivation  

With Azure OpenAI services enhanced by your data, robust language models and Azure Cognitive Search work together to index your data and provide responses following your organization's policies. This ensures the protection of your intellectual property, as your data and access to it remain securely in your control.

By integrating Power Virtual Agents with Azure OpenAI, your bots can access these resources from Azure using the Generative Answers node.  
Chatting with a bot that knows your data is excellent, but using Power Virtual Agents on top, you can take automated actions along your company's processes.

##   
Background

  
Using Azure OpenAI with your data allows you to operate compatible chat models, such as GPT-3.5-Turbo and GPT-4, without the need to train or fine-tune them. Executing these models on your data enhances your ability to engage in conversations and analyze your information with increased precision and speed. As a result, you can uncover valuable insights that aid in making informed business decisions, recognizing trends and patterns, and optimizing your operations. A primary advantage of Azure OpenAI with your data is its capacity to customize the content of conversational AI.

Since the model can access and reference particular sources to bolster its responses, answers rely not solely on its pre-existing knowledge but also on the most recent information in the specified data source. This foundational data assists the model in preventing the generation of responses based on outdated or inaccurate information.

 Note:  
 To get started, you need to already have been approved for [**Azure OpenAI access**](https://learn.microsoft.com/en-us/azure/ai-services/openai/overview#how-do-i-get-access-to-azure-openai) and have an [**Azure OpenAI Service resource**](https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/create-resource) with either the gpt-35-turbo or the gpt-4 models deployed.

## Why should I use Azure Open AI services ...

**... because you control your data, and your intellectual property is not compromised.**

Your prompts (inputs) and completions (outputs), your embeddings, and your training data:

* Are NOT available to others
    
* and are NOT open to OpenAI.
    
* Are NOT used to improve OpenAI models.
    
* Are NOT used to strengthen any Microsoft or 3rd party products or services.
    
* Are NOT used for automatically improving Azure OpenAI models for your use in your resource (The models are stateless unless you explicitly fine-tune models with your training data).
    
* Your fine-tuned Azure OpenAI models are available exclusively for your use.
    

**Microsoft fully controls the Azure OpenAI Service; Microsoft hosts the OpenAI models in Microsoft's Azure environment, and the Service does NOT interact with any services operated by OpenAI (e.g., ChatGPT or the OpenAI API).**

## **How Do I work with my own data?**

To begin, connect your data source using Azure OpenAI Studio, and start asking questions and engaging in conversations based on your data.

go to: your "Azure OpenAI Studio", jump into your "playground"

Select "Chat" and "add your data"

![]({{site.baseurl}}/images/cllt3vjv5000g09mnfrj04ucn.md/963096dd-dd36-426e-9ea1-401bb5db7f81.png)

You can then add data. Your data will be stored securely in your Azure Subscription.

![]({{site.baseurl}}/images/cllt3vjv5000g09mnfrj04ucn.md/a44862b9-7396-497e-a8ec-e7e46dc18ea2.png)

## How Do I Connect a Power Virtual Agent?

To connect a Power Virtual Agent bot to your data, choose the Deploy option. The bot will be created and automatically linked to your Azure resource.

![]({{site.baseurl}}/images/cllt3vjv5000g09mnfrj04ucn.md/69f392fb-29d4-491e-b391-c36a21087649.png)

![]({{site.baseurl}}/images/cllt3vjv5000g09mnfrj04ucn.md/d3b3f08d-ef85-4b03-b7d6-83448ec9cc70.png)

The "Conversational Boosting" system topic is automatically generated when the bot is created using Azure OpenAI Studio.

![]({{site.baseurl}}/images/cllt3vjv5000g09mnfrj04ucn.md/0fd2bbab-26e5-495a-97dd-eb15a8706d47.png)

In the Power Virtual Agents editing canvas, open the Data Source Configuration panel for your topic's "Generative Answers" node:

Open the Properties panel for the "Create Generative Answers" node and select Data Source.

On the Create Generative Answers node, select Edit under Data Sources.

![]({{site.baseurl}}/images/cllt3vjv5000g09mnfrj04ucn.md/cb13d8b1-0970-416f-a5bf-de234fdabce1.png)

Edit the connection to the Azure OpenAI Service.

![]({{site.baseurl}}/images/cllt3vjv5000g09mnfrj04ucn.md/24979867-c793-4e9e-8a90-f6ae6e975036.png"left")

Once you have finished entering sources, close the menu. Be sure to save any changes made to your topic.

The topic will now generate answers from the information sources your Azure OpenAI connection defines.

 Important:  
 Information sources specified in the Generative Answers node will take precedence over those defined at the bot level, which will then serve as a fallback, not vice versa!

## Conclusion

Azure OpenAI services offer a robust and secure way to utilize advanced language models without compromising your intellectual property.  
By integrating these services with Power Virtual Agents, you can enhance your organization's conversational AI capabilities and automate processes, all while maintaining control over your data.
