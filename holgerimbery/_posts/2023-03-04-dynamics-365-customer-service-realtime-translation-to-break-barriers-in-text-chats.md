---
layout: post
title: "Dynamics 365 Customer service: Realtime translation to break barriers in text chats."
date: 2023-03-04
author: admin
slug: dynamics-365-customer-service-realtime-translation-to-break-barriers-in-text-chats
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-03-04-dynamics-365-customer-service-realtime-translation-to-break-barriers-in-text-chats


---

## Prerequisites

* You must add a web resource and ensure the required language translation services are configured.
    
* [Enable call recording and transcription for the translated voice call transcripts to be displayed.](https://the.cognitiveservices.ninja/dynamics-365-customer-service-configure-call-recording-and-transcription-for-voice-bots-and-agent-dialogues)
    

## Motivation

Imagine you operate a multilingual contact center with chat. With the real-time message translation feature, agents (human and non-human) can support customers and employees in the language they elect to be serviced in without needing all agents to speak the same language.  
When you enable language translation, messages between the customer and support agent - and messages among support agents who consult and collaborate internally, such as supervisors or SMEs - are translated. There will be no time delay in translating messages manually, even when the conversation starts with a non-human agent. Everybody in the chain can understand as they get displayed the dialogue in their preferred language.

## Implementation

### Creating a web resource for real-time translation

You need an active azure subscription for this step.

* Deploy a translation resource and get a translation key  
    according to the [documentation](https://learn.microsoft.com/en-us/azure/cognitive-services/Translator/create-translator-resource).
    
* Go to the [Microsofts GitHub repository](https://github.com/microsoft/Dynamics365-Apps-Samples/tree/master/customer-service/omnichannel/real-time-translation) and download the sample [web resource](https://github.com/microsoft/Dynamics365-Apps-Samples/blob/master/customer-service/omnichannel/real-time-translation/webResourceV2.js).
    
* Edit the downloaded file and put the translation key into it.
    

```javascript
bingTranslateApiClientSecret: '<please add your own azure translation api key>',
googleTranslateApiClientSecret: '<please add your own google translation v2 api key>',
```

* Put this JavaScript file on a web resource accessible from the internet.  
    (e.g., an azure static webapp resource)
    
* Check the availability after deploying it.
    

### Activation of Real-time translation

* Go to your Customer Service admin center.
    
* Pick productivity under Agent experience.
    
* Click on "Manage" in the section "Real-time translation".
    

![Figure 1: Select "Manage" in "Real-time translation"]({{site.baseurl}}/images/clety0boq093hrqnv8hsvcadn.md/99e74a83-8261-461f-9686-3bf549b2dcfe.png)

Figure 1: Select "Manage" in "Real-time translation"

* switch the service on
    
* configure the target language and Web Resource URL you deployed. before
    

![Figure 2: configure the service]({{site.baseurl}}/images/clety0boq093hrqnv8hsvcadn.md/f8aabf80-33d7-4eac-8beb-847b9e4fe71d.png)

Figure 2: Configure the service.

## Result

As an example - all dialogs are in English (in the screenshot, you see a caller in the voice channel talking to the voice bot and later to an human agent) and the translation is in realtime to Hindi.

![Figure: translated voice call from English to Hindi]({{site.baseurl}}/images/clety0boq093hrqnv8hsvcadn.md/fc484653-d2a6-465e-b019-52b18fbc7b04.png)

Figure: translated voice call from English to Hindi

## Conclusion

You can rapidly speed up communication between your contact center agents and your Subject Matter Experts by leveraging the automatic translation of customer queries.