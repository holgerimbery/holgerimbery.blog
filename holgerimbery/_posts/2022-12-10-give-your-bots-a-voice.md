---
layout: post
title: Give your Bots a voice
description: 
date: 2022-12-10
author: admin
image: ./images/archive.jpg
tags: [archive]
featured: false
toc: true

---


# Give your Bots a voice

Enabling your chatbot to use voice on a telephone line is straightforward, and there are several solutions in the market to do so.

This guide will focus on a solution called Voice.Ai and Power Virtual Agents as a bot platform. Other Platforms will work similarly.

## Motivation

Voice enabling any chatbot is technically easy, and you should consider doing so.

* Imagine giving your customers a text-based chatbot on your website and serving them on your phone before they reach your contact center.

* Imagine serving your customers and employees immediately in their native language without extra effort.

* Imagine there is no need for additional resources, but your customers and employees will feel more directly addressed. #domorewithless

* Imagine your employees can refocus on delivering value to your customers instead of being a voice interface of a QnA collection.

* Imagine you can achieve this without paying your contact center vendor additional licenses.

But I must be very direct and not gloss over things; your Bot needs to deliver **real value** to your customers. You must be creative about the dialog design, use slot filling to make the dialog natural, and avoid creating a bot that can only answer one specific question.  
You must create process flows to serve your customers and achieve human parity.

## Prerequisites

To use this Kickstarter and explore this topic, you need to sign up for [Voice.Ai Connect Cloud](https://voiceaiconnect.audiocodes.io/login) and acquire a Phone Number or configure your sip trunk by following the [documentation](https://techdocs.audiocodes.com/voice-ai-connect/#VAIG_Cloud/overview_cloud.htm).

Let's give the (Power Virtual Agents) Bot a voice. Retrieve your Web channel Secret (in PVA-UI: Settings/Security/Web Channel Security)

![Figure 0.1: retrieve your Web channel Secret]({{site.baseurl}}/images/clbhy3eik05fcmlnvhhvq7v8n.md/eprxmtgqc.webp)

Figure 0.1: retrieve your Web channel Secret

then go to your Voice.AI Configuration Interface.

### Bot Configuration

Add Bot

![Figure 0.2: Add details for your bot.]({{site.baseurl}}/images/clbhy3eik05fcmlnvhhvq7v8n.md/ssg2myt3b.webp)

Figure 0.2: Add details for your Bot.

![Figure 0.3: Select TTS, STT and Voice Font]({{site.baseurl}}/images/clbhy3eik05fcmlnvhhvq7v8n.md/aipvyfaa8.webp)

Figure 0.3: Select TTS, STT, and Voice Font

Configure Routing

![Figure 0.4: configure routing "inbound"]({{site.baseurl}}/images/clbhy3eik05fcmlnvhhvq7v8n.md/kcvttvbvi.webp)

Figure 0.4: configure routing "inbound"

![Figure 0.5: configure routing "transfer"]({{site.baseurl}}/images/clbhy3eik05fcmlnvhhvq7v8n.md/ojrjtgtox.webp)

Figure 0.5: configure routing "transfer"

## Give it a Voice

### Voice Basics

voice enabling a chatbot is a low effort from a technical standpoint, but there are at least three significant differences between a chatbot and a voice bot.

It would be best to create a Bot that tells the user everything without pictures, links, or emoticons.  
Consider the one-breath rule; make the Bot's answer short and to the point.  
Use handover to a human as a last line of defense but use it immediately when your Bot fails.

### API Documentation

The API of Voice.AI Connect is publicly available; please follow the [link](https://techdocs.audiocodes.com/voice-ai-connect/#VAIG_Combined/conversation_flow.htm?TocPath=Bot%2520integration%257C_____1) to get more insides.

### Caller/Callee IDs

You have one handy identification element on the phone channel you should consider integrating into your Bot, e.g., to greet the user or avoid unnecessary questions - the Caller ID.  
With the Caller ID, you can link your CRM Data to the Bot and have instant insides by hand when a user calls you. No need to ask for the name (you need to verify it) and no need to ask for details you already know.

If your Bot serves several phone lines, e.g., for different purposes (sales, customer service, HR), you can even use the Callee ID to route to a specific bot skill.

In PVA, you can retrieve both IDs via a small composer integration and create a new composer topic.

![Figure 0.6: new topic in composer]({{site.baseurl}}/images/clbhy3eik05fcmlnvhhvq7v8n.md/ta8sbucrb.png)

Figure 0.6: new topic in the Composer

Follow the steps to install Bot framework Composer and connect to Power Virtual Agents.

Create a new "Dialog" in Bot framework Composer, and select event-driven and event received as options.

![Figure 1: Create a new "Event received" dialog in Composer]({{site.baseurl}}/images/clbhy3eik05fcmlnvhhvq7v8n.md/fbun6wpp-.png)

Figure 1: Create a new "Event received" dialog in Composer

#### Create variables in Power Virtual Agent

Go back to Power Virtual Agents UI and create two variables within a new topic for each of them. This feels a little dirty to do so, but it is the way to do it before we all get the new unified authoring canvas we see in the preview.

![Figure 2: Create a variable bot.caller in PVA]({{site.baseurl}}/images/clbhy3eik05fcmlnvhhvq7v8n.md/s5lkvdwhn.png)

Figure 2: Create a variable bot.caller in PVA

ensure you create a "bot" variable and select "external sources can set values".

![Figure 3.0: variable as "Bot" variable ]({{site.baseurl}}/images/clbhy3eik05fcmlnvhhvq7v8n.md/bbznw5mo3.png)

Figure 3.0: variable as "Bot" variable

![Figure 3: Create a variable bot.callee]({{site.baseurl}}/images/clbhy3eik05fcmlnvhhvq7v8n.md/fn9amyh37.png)

Figure 3: Create a variable bot.callee

and back to the Composer and create the flow in your newly created "dialog"

#### Create dialog flow with Composer

![Figure 4: Create Composer Flow to extract caller ID from channeldata]({{site.baseurl}}/images/clbhy3eik05fcmlnvhhvq7v8n.md/2yrubo81u.png)

Figure 4: Create Composer Flow to extract caller ID from channeldata

Nothing special, create a switch and three "set a property node" (to manipulate the JSON data and store it in a variable.

You can check the adaptive code in Bot framework Composer by selecting show code in the canvas.

![Figure 5: check if condition is true]({{site.baseurl}}/images/clbhy3eik05fcmlnvhhvq7v8n.md/dww1dqc4d.png)

Figure 5: check if the condition is true

Select Publish on the left side in Composers Menu and publish your composer code to PVA.

#### Use Caller and Callee ID in Power Virtual Agent

We can use the newly created variables everywhere (messages, as input for Power Automate Flows, etc.) in PVA as we stored the Caller ID and Callee ID as variables.

### Hangup

Another Dialog you can create with the Composer is a Hangup to close the phone line after a successful dialog with a user. Therefore you select Send Activity as a Dialog event.

![Figure 6: hangup dialog]({{site.baseurl}}/images/clbhy3eik05fcmlnvhhvq7v8n.md/33riopihf.png)

Figure 6: hangup dialog

Why not integrate a feedback system and perform a clean hangup after the user confirms that there are no open points anymore?

### Play Music

It would be best if you created a third Composer dialog to play music, announcements, or fancy jingles. Your sound file needs to be accessible as a public URL.

![Figure 7: playsound dialog]({{site.baseurl}}/images/clbhy3eik05fcmlnvhhvq7v8n.md/c0zaakhlr.png)

Figure 7: playsound dialog

### Call Transfer

You could analyze the sentiment of the caller to hand over to an agent or when the caller asks for a human or fails to answer.

This can be done without the Composer. You only need to create a new topic without trigger phrases and link to it from other topics.

![Figure 8: Calltransfer Topic]({{site.baseurl}}/images/clbhy3eik05fcmlnvhhvq7v8n.md/cpp46yrkn.png)

Figure 8: Calltransfer Topic

## conclusion

Technically, telephony is just another channel for your Bot. Still, it gives your employees a superpower in customer service, 24 hours available, and the ability to answer everything quickly and correctly (if your Bot is providing real value).
