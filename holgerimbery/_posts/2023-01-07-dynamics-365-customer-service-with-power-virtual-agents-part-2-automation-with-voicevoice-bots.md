---
layout: post
title: Dynamics 365 Customer Service with Power Virtual Agents - Part 2 (automation with voice/voice bots)
description: 
date: 2023-01-07
author: admin
image: ./images/archive.jpg
tags: [archive]
featured: false
toc: true

---


# Dynamics 365 Customer Service with Power Virtual Agents - Part 2 (automation with voice/voice bots)

 This article is the second part of a Kickstarter of two pieces and part of my ["Dynamics 365 automation with bots/voice bots 101"](https://the.cognitiveservices.ninja/series/101-d365) series.  
 In this article, I will focus on Dynamics 365 Customer Service with telephony and the integration of voice-bots with a handover to a human agent.

## Prerequisites

Please follow the instructions of the first part, "[**Dynamics 365 Customer Service with Power Virtual Agents - Part 1 (automation with text chat)**](https://the.cognitiveservices.ninja/dynamics-365-customer-service-with-power-virtual-agents-part-1-automation-with-text-chat)", to create a Dynamics 365 Customer Service environment and configure the handover with a bot.

We work here with two queues, one for the user calling the voice bot, the voice bot being the one and only agent, and a second queue for the handover to the human agent(s).

## Enable your Dynamics 365 Customer Service environment with Voice.

In part one, we created a free Dynamics Customer Service trial; with this trial, you will get sixty free minutes of PSTN Calls (US Toll-free Numbers)

After 60 minutes, you can bring your SIP-Trunk via Azure Communication Services or buy a dialing plan via Microsoft. If you are in Europe, you must go with the SIP-Trunk integration. This is a straightforward and menu-based setup. Your SIP-Trunk provider should give you an FQDN of "your" Session Border Controller and a Port.

## Configure Dynamics 365 Customer Service

### Configure Azure Communication Services' direct routing

Remember, even if it says preview, the combination of D365 and ACS direct routing is full GA.

![]({{site.baseurl}}/images/clclxco3q0c118jnv7w6h3ojb.md/b8445221-f024-4eca-a9f4-ff338b5382c9.png)

Go to your OmniChannel Admin Center

![Figure 1: Add ACS]({{site.baseurl}}/images/clclxco3q0c118jnv7w6h3ojb.md/fcc45d7b-5ca1-4d3b-9f9c-da99d2076a1a.webp)

Figure 1: Add ACS

![Figure 2: Create a new Resource]({{site.baseurl}}/images/clclxco3q0c118jnv7w6h3ojb.md/f814a9a7-e57b-4c56-838f-d4893c31ec5b.webp)

Figure 2: Create a new Resource

Leave the Omnichannel Admin Center window open, open another tab for the [Azure Portal](https://portal.azure.com), and configure the SBC/Port for Direct Routing.

![Figure 3: Create a new Session Border Controller Configuration]({{site.baseurl}}/images/clclxco3q0c118jnv7w6h3ojb.md/b0a3408d-0cf7-492a-8399-a900c8d1aa83.png)

Figure 3: Create a new Session Border Controller Configuration

![Figure 4: enter SBC FQDN and Port]({{site.baseurl}}/images/clclxco3q0c118jnv7w6h3ojb.md/913eaa78-b353-4d8a-b731-87440ccd02b5.png)

Figure 4: enter SBC FQDN and Port

![Figure 5: and a number pattern for outbound]({{site.baseurl}}/images/clclxco3q0c118jnv7w6h3ojb.md/1f34e31e-63a7-43b6-9a1d-1813f013a187.png)

Figure 5: and a number pattern for outbound

Go back to your Omnichannel Admin Center tab and configure your phone numbers.

![Figure 6: Add Phone Numbers - part 1]({{site.baseurl}}/images/clclxco3q0c118jnv7w6h3ojb.md/ea5063e1-65bb-47f0-91f6-d63a4af1c05d.webp)

Figure 6: Add Phone Numbers - part 1

![Figure 7: Add Phone Numbers - part 2]({{site.baseurl}}/images/clclxco3q0c118jnv7w6h3ojb.md/7a3ce02c-1cf1-41a4-8fce-b75500f5bc50.webp)

Figure 7: Add Phone Numbers - part 2

![Figure 8: Add Phone Numbers - part 3]({{site.baseurl}}/images/clclxco3q0c118jnv7w6h3ojb.md/702385e8-6965-4924-ae62-2c0143136b62.webp)

Figure 8: Add Phone Numbers - part 3

![Figure 9: Add Phone Numbers - part 4]({{site.baseurl}}/images/clclxco3q0c118jnv7w6h3ojb.md/8fd3f705-0858-43ba-bb0b-1a65c5ba3912.webp)

Figure 9: Add Phone Numbers - part 4

We will modify a queue and a workstream already in place for this Kickstarter.

### Modify the "**Demo voice call"** workstream

Go to your Customer Service admin center, then to workstreams, and rename the workstream "Demo voice call workstream" to something more specific.

![Figure 10: pick one of your fresh phone numbers]({{site.baseurl}}/images/clclxco3q0c118jnv7w6h3ojb.md/4aad757d-bcaf-42c6-9fdd-aad194cdfc9a.webp)

Figure 10: pick one of your fresh phone numbers

instead of agents, we add our bot, which we create in part 1

![Figure 11: add your bot]({{site.baseurl}}/images/clclxco3q0c118jnv7w6h3ojb.md/f4ff067b-ab6c-48a4-8a88-223ba1e205f4.png)

Figure 11: add your bot

![Figure 12: Bot configured]({{site.baseurl}}/images/clclxco3q0c118jnv7w6h3ojb.md/9c7bb18a-7a75-41a6-a912-9b5eed66acc6.png)

Figure 12: Bot configured

## Modify your bot

By now, your bot is only able to transfer a call. This is the time to teach the bot something valuable; you could look at my "[Create your first (voice-)bot](https://the.cognitiveservices.ninja/build-your-first-voice-bot-with-microsoft-power-virtual-agent-3e71f8531c3a)" example to implement some QnA or processes.

## Test the implementation

Take your phone and call the number you remembered from above.  
You will land in a queue where the bot is the only agent.  
Follow the dialog of your bot, now on the phone, and ask, "I want to talk to an agent"

The bot will transfer your call to a human agent, and you will see the incoming call on your agent dashboard.

![Figure 13: incoming call]({{site.baseurl}}/images/clclxco3q0c118jnv7w6h3ojb.md/dd3a46d0-589b-46c8-a223-6b60ef93dc55.png)

Figure 13: incoming call

Press Accept and see the complete agent experience.

![Figure 14: Full Agent Desktop (Dashboard)]({{site.baseurl}}/images/clclxco3q0c118jnv7w6h3ojb.md/79c27537-75b7-4d4b-84ee-999f292e05d8.png)

Figure 14: Full Agent Desktop (Dashboard)

After taking the call, the agent can see the transcript of the dialog with the voice bot on the left and the standard Dynamics 365 Customer Service details on the right. Your customer was identified via Caller ID, and the correct Contact is shown here.

We have here recording and sentiment analysis enabled; the sentiment is shown on the top left as an emoticon.

## Conclusion

We configured Dynamics 365 Customer Service and Power Virtual Agent as human-to-human and bot-to-human customer service solutions.

There is no need for a third-party solution to manage the phone call. Everything will be handled via Azure Communication Services and Dynamics 365 Customer Service.

Azure Communications services are billed based on your [consumption](https://azure.microsoft.com/en-us/pricing/details/communication-services/), and there are no setup fees.