---
layout: post
title: "Creating Multilingual Chatbots with Power Virtual Agents: 3 Workarounds to Get Started"
date: 2023-06-10
author: admin
slug: creating-multilingual-chatbots-with-power-virtual-agents-3-workarounds-to-get-started
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-06-10-creating-multilingual-chatbots-with-power-virtual-agents-3-workarounds-to-get-started

---

## Motivation

Two of our "Power Virtual Agents in a Day" guests' most frequently asked questions can be answered in three distinct ways. Herein, I will discuss the answers to these queries:

1. How can I utilize Power Virtual Agents in a language not supported by the platform's 23 available languages?
    
2. Can I develop a single chatbot on Power Virtual Agents that can respond to different languages instead of creating separate bots for each language?
    

  
Today, Power Virtual Agents support [23 languages](https://learn.microsoft.com/en-us/power-virtual-agents/authoring-language-support), including those in preview, with one language designated for each chatbot. To accomplish more, a workaround is necessary.

## Three workarounds

### Using a Power Automate flow

![language detection and custom question answering via Power Automate]({{site.baseurl}}/images/clipw6kkm000909labxg80bz9.md/9c2799d9-46ac-4fb6-a0e4-07363f275180.webp)

*Figure: language detection and custom question answering via Power Automate*

Use Power Automate to expand Power Virtual Agent into a multilingual QnA Resolver. This solution involves Power Automate, Azure's Custom Question Answering, and Microsoft Translator v2 service. It addresses both questions; however, remember that the bot can respond to queries in any language, but its user interface will remain in your main bot's language.

I authored an article a few months ago that provides a [step-by-step guide](https://the.cognitiveservices.ninja/extend-power-virtual-agent-with-azure-cognitive-services-eab95018b7f6). You can use it but need an Azure subscription to host the additional services.

### Use Dynamics 365 Customer Service and create a multilingual IVR for voice-enabled PVA

![multiple cascaded bots]({{site.baseurl}}/images/clipw6kkm000909labxg80bz9.md/044ec5a9-bb85-46d6-8815-858159ba1663.webp)

*Figure: multiple cascade bots*

Using vario..us workstreams and cascaded queues, create a concierge bot capable of directing the dialogue in different languages to different bots. This approach benefits from compatibility with voice via telephony.

The fundamental concept behind the concierge is establishing a cascade of bots residing in separate queues. Always remember to include an escalation path to a human agent.

Begin with a language selector and forward the result to a queue designated for that specific language. You can create another bot for that queue or assign human agents. This method can be employed for a cascade of bots with diverse skills in multiple languages, serving as the foundation for a bot factory that supports your multilingual users and our human agents. As an example, please find my step-by-step guide for configuring this with a 3-language selector. The downside is that this is only available with D365 Customer Service.

### Translation Bot on a relay

![translation relay with an Azure Service Bot]({{site.baseurl}}/images/clipw6kkm000909labxg80bz9.md/dabc36f5-b268-4923-ba5b-2f0955fafa9b.jpeg)

*Figure: translation relay with an Azure Service Bot*

For this approach, you will need an Azure Service Bot and Azure Cognitive Services Translator to work with your Power Virtual Agents. It may seem daunting, but this is the ultimate solution until Microsoft releases a [multilingual version](https://portal.productboard.com/fdeco3ykgkwvchtg4qbdowug/c/9-single-bot-multi-language-support) of Power Virtual Agents.

The basic idea involves connecting your Power Virtual Agents Bot through the DirectLine API and utilizing all its topics in various languages. This is done using a middleware (Azure Bot) to translate messages between the user and the Power Virtual Agents Bot. The middleware will use Cognitive Services to translate the text throughout the conversation.  
Microsoft created an excellent [step-by-step guide](https://github.com/microsoft/PowerVirtualAgentsSamples/tree/master/MultilingualBotSample) and a repository on [GitHub](https://github.com/microsoft/PowerVirtualAgentsSamples/tree/master/MultilingualBotSample) with all elements to set this up. You will even find ARM templates to deploy the resources you need.

## Conclusion

Creating multilingual chatbots with Power Virtual Agents is achievable through three workarounds: using Power Automate flow, implementing Dynamics 365 Customer Service with a multilingual IVR, and employing a Translation Bot on a relay.

Each method has advantages and limitations, but all offer viable solutions to support multiple languages in your chatbot until an official multilingual version becomes [available](https://portal.productboard.com/fdeco3ykgkwvchtg4qbdowug/c/9-single-bot-multi-language-support).