---
layout: post
title: personalized customer experience with voice bots and Dynamics 365 Customer Service
description: 
date: 2023-02-18
author: admin
image: ./images/archive.jpg
tags: [archive]
featured: false
toc: true

---


# personalized customer experience with voice bots and Dynamics 365 Customer Service

## Motivation

Imagine calling a company you have a contract with and doing regular business with. From the beginning, their automated self-service platform knows anything related to your last transaction.  
No need to say your name, customer number, or anything else more than once to verify your identity.  
It sounds like a dream, no, just reality, if the company would combine Dynamics 365 Customer service and Power Virtual Agents with the phone channel and use some 1st party extensions and variables in your voice bot.

## Prerequisites

All you need, besides you already have Dynamics 365 Customer Service & Power Virtual Agents and the Voice Channel via Azure communication services installed, is installing three extensions to Power Virtual Agent:  
[**Power Virtual Agents telephony extension**](https://appsource.microsoft.com/product/dynamics-crm/mscrm.mspva_telephony_extension)  
[**Omnichannel Power Virtual Agent extension**](https://appsource.microsoft.com/product/dynamics-365/mscrm.omnichannelpvaextension)  
[**Omnichannel Voice Power Virtual Agent extension**](https://appsource.microsoft.com/product/dynamics-365/mscrm.omnichannelvoicepvaextension)

If you struggle with the D365. PVA or the Voice Channel, look at my previously released articles.  
[**Dynamics 365 Customer Service with Power Virtual Agents - Part 1 (automation with text chat)**](https://the.cognitiveservices.ninja/dynamics-365-customer-service-with-power-virtual-agents-part-1-automation-with-text-chat)  
[**Dynamics 365 Customer Service with Power Virtual Agents - Part 2 (automation with voice/voice bots)**](https://the.cognitiveservices.ninja/dynamics-365-customer-service-with-power-virtual-agents-part-2-automation-with-voicevoice-bots)  
[**Dynamics 365 Customer Service Voice Channel**](https://the.cognitiveservices.ninja/dynamics-365-customer-service-voice-channel)

## Solution

After installing the three extensions, you can use variables and actions to retrieve information about the caller stored in Dynamics 365.

### Use of variables

With [**Power Virtual Agents telephony extension**](https://appsource.microsoft.com/product/dynamics-crm/mscrm.mspva_telephony_extension)**,** you can use the caller ID (the caller's phone number) to identify the user. Consider using a second factor (voice fingerprinting or a question to verify the customer number, etc.) for authentication if required.

With the other extension, you will get "bot.msdyn\_" variables with all information about the caller. You can find them in your PVA variables.

![Figure 1: Available variables after installing the extensions]({{site.baseurl}}/images/cle9xudpl018ojcnv5uw4dewq.md/e0922ce9-2526-4b7e-98e3-893969b621c8.png)

Figure 1: Available variables after installing the extensions.

### Example 1: Personalized greeting based on caller id

Right after sending the first greeting, you can check if the bot.CustomerPhoneNumber is not empty.  
If it's empty, the caller is not sending one, or we are not in the phone channel if you use the same bot for text and voice.

![Figure 2: personalized greeting]({{site.baseurl}}/images/cle9xudpl018ojcnv5uw4dewq.md/caba74d4-a254-44fa-916c-7461b388271b.png)

Figure 2: personalized greeting

If there is a phone number, and the caller is a returning contact (number in your database), you can use bot.msdyn\_CustomerName to greet the caller by name.

Please consider handling exceptions like:

* no caller ID, but we are in the phone channel,

* caller ID is present, but a new caller is calling,

* etc.

### Example 2: callback without asking for the phone number

If you want to offer a callback, a phone number is stored in the variable bot.CustomerPhoneNumber, as the caller transmitted the caller id. Just ask for confirmation that the caller wants to have the callback on the number currently used for dialing in.

![Figure 3: Confirmation of user for callback]({{site.baseurl}}/images/cle9xudpl018ojcnv5uw4dewq.md/d87b9770-e969-4f41-984e-935bcca8b404.png)

Figure 3: Confirmation of user for callback

![Figure 4: Message to the user with phone number]({{site.baseurl}}/images/cle9xudpl018ojcnv5uw4dewq.md/d297c7db-a5a9-4ee2-a297-ebc66bfecfe5.png)

Figure 4: Message to the user with phone number

### Available variables

You can use a whole list of variables, which are well-documented in Microsoft [documentation](https://learn.microsoft.com/en-us/dynamics365/customer-service/context-variables-for-bot#context-variables-for-power-virtual-agents-bots). If your agents filled the data in their customer CRM data, the preferred language (to create a language routing) and the survey consent (to avoid bothering the caller) are available.

## Conclusion

It is easy to provide personalized customer service with data you have already collected, making your customer feel more welcome without a tailored response.
