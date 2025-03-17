---
layout: post
title: Dynamics 365 Customer Service Voice Channel
description: 
date: 2023-02-04
author: admin
image: ./images/archive.jpg
tags: [archive]
featured: false
toc: true

---


# Dynamics 365 Customer Service Voice Channel

## Motivation

When you create a free Dynamics Customer Service trial, you will get sixty minutes of PSTN Calls (US Toll-free Numbers).

After 60 minutes, you can bring your SIP-Trunk via Azure Communication Services or buy a dialing plan via Microsoft.  
If you are in Europe, you must go with the SIP-Trunk integration. This is a straightforward and menu-based setup. Your SIP-Trunk provider should give you an FQDN of "your" Session Border Controller and a Port.  
Even though direct routing in Azure Communication Services is still in preview, Microsoft fully supports it on a GA level if you use it with **Dynamics 365 Customer Service Enterprise**.

![Figure 1: Microsofts disclaimer]({{site.baseurl}}/images/cldpxogo006jqj1nv0ryg1vic.md/6b47b582-97b7-4e0a-9c87-986524d5c412.png)

Figure 1: Microsofts disclaimer

## Configurations steps

### Azure Communication Services

First, go to your OmniChannel Admin Center.  
In the site map, select **Phone numbers** in **General settings**.

![Figure 2: Click on "Get Started" to start]({{site.baseurl}}/images/cldpxogo006jqj1nv0ryg1vic.md/f48764b0-14e9-4b3f-b1cf-11b95795bfd7.png)

Figure 2: Click on "Get Started" to

* create a new resource

* select your Azure Subscription

* select a new resource group or create a new one.

* Give the new resource a meaningful name.

![Figure 3: Create a new resource ]({{site.baseurl}}/images/cldpxogo006jqj1nv0ryg1vic.md/60869aa4-5edb-4b49-9745-2f75a9697fcb.png)

Figure 3: Create a new resource.

Leave the Omnichannel Admin Center window open, open another tab for the [**Azure Portal**](https://portal.azure.com/), and configure the SBC/Port for Direct Routing.

![Figure 4: Create a new Session Border Controller Configuration]({{site.baseurl}}/images/cldpxogo006jqj1nv0ryg1vic.md/b94c9a4f-b9d8-4312-b1b8-f319a5e60b9e.png)

Figure 4: Create a new Session Border Controller Configuration

![Figure 5: enter SBC FQDN and Port]({{site.baseurl}}/images/cldpxogo006jqj1nv0ryg1vic.md/0279c8da-9e3e-46d8-b166-299296d8d581.png)

Figure 5: enter SBC FQDN and Port

![Figure 6: and a number pattern for outbound]({{site.baseurl}}/images/cldpxogo006jqj1nv0ryg1vic.md/55c0f812-7bb6-4587-9b01-d259b9212a1c.png)

Figure 6: and a number pattern for outbound

Go back to your Omnichannel Admin Center tab and configure your phone numbers.

![Figure 7: Add Phone Numbers - part 1]({{site.baseurl}}/images/cldpxogo006jqj1nv0ryg1vic.md/9289a02d-5c62-4497-b660-b3a78fda2919.png)

Figure 7: Add Phone Numbers - part 1

![Figure 8: Add Phone Numbers - part 2]({{site.baseurl}}/images/cldpxogo006jqj1nv0ryg1vic.md/b117e437-7c38-429d-9a05-604b616f82dd.png)

Figure 8: Add Phone Numbers - part 2

![Figure 9: Add Phone Numbers - part 3]({{site.baseurl}}/images/cldpxogo006jqj1nv0ryg1vic.md/bd9f14b0-d0ce-479a-81cb-357c1e8169c9.png)

Figure 9: Add Phone Numbers - part 3

![Figure 10: Add Phone Numbers - part 4]({{site.baseurl}}/images/cldpxogo006jqj1nv0ryg1vic.md/473850da-e777-4a33-a0d0-68ee4d0a38b1.png)

Figure 10: Add Phone Numbers - part 4

The new phone number will be displayed in the **Phone numbers** list and is ready for setup. You can now [connect it to a voice workstream](https://learn.microsoft.com/en-us/dynamics365/customer-service/voice-channel-inbound-calling), [configure outbound calling](https://learn.microsoft.com/en-us/dynamics365/customer-service/voice-channel-outbound-calling#configure-phone-numbers-for-outbound-calling), or even [assign it to an agent](https://learn.microsoft.com/en-us/dynamics365/customer-service/voice-channel-outbound-calling#assign-personal-phone-numbers-to-agents).

SMS is not supported with direct routing

## Carrier Setup

### Production Environment

if you are deploying for production, you should go for a carrier with post-paid contracts and a managed SBC Solution on the carrier site. Here you will get an FQDN and Port of the Carrier side, and you are done.

### Development Environment

For example, I will describe how to configure a development direct routing connection via [TELNYX](https://portal.telnyx.com/#/login/sign-in).

#### Add a Sip Connection

#### Create a new sip connection via Voice, SIP Routing, and select MS Teams SBC

![Figure 11: Create new SIP Connection]({{site.baseurl}}/images/cldpxogo006jqj1nv0ryg1vic.md/faaf4349-8bce-4ed8-b32a-e6b1db6b3f2b.png)

Figure 11: Create a new SIP Connection

#### **Assign a number to the Telnyx SBC Connection**

You are now required to assign a Number to the Azure Communications Resource connection you created.

1. If you have not done so, you'll need to purchase a number from Telnyx.

2. Once you have a number, navigate to the **Numbers** page of your Telnyx Mission Control Portal and assign your Azure Communications Resource connection to the desired DID, as shown below.

![Figure 12: Assign numbers]({{site.baseurl}}/images/cldpxogo006jqj1nv0ryg1vic.md/8332fe52-56a2-4065-bf23-601310566560.png)

Figure 12: Assign numbers

#### **Add your SIP Connection to your Outbound Voice Profile**

Create an Outbound Voice Profile and assign it to the connection you created above.

![Figure 13: Assign Outbound Voice Profile]({{site.baseurl}}/images/cldpxogo006jqj1nv0ryg1vic.md/91c69d1d-8196-4b47-8027-b2075e79514c.png)

Figure 13: Assign Outbound Voice Profile

## Test the implementation

Configure some workstreams with the newly created numbers and test inbound and outbound calls.

## Additional Resources

Consider the following additional kick-starters:

[Dynamics 365 Customer Service with Power Virtual Agents - Part 1 (automation with text chat)](https://the.cognitiveservices.ninja/dynamics-365-customer-service-with-power-virtual-agents-part-1-automation-with-text-chat)

[Dynamics 365 Customer Service with Power Virtual Agents - Part 2 (automation with voice/voice bots)](https://the.cognitiveservices.ninja/dynamics-365-customer-service-with-power-virtual-agents-part-2-automation-with-voicevoice-bots)

[Multilingual IVR Replacement for Dynamics 365 Customer Service (Voice Bot)](https://the.cognitiveservices.ninja/multilingual-ivr-replacement-for-dynamics-365-customer-service-voice-bot)

[Microsofts documentation](https://learn.microsoft.com/en-us/dynamics365/customer-service/voice-channel-bring-your-own-number?tabs=omnichanneladmincenter)
