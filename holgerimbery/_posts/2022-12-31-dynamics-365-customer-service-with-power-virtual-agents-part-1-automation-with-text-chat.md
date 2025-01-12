---
layout: post
title: Dynamics 365 Customer Service with Power Virtual Agents - Part 1 (automation with text chat)
description: 
date: 2022-12-31
author: admin
image: ./images/archive.jpg
tags: [archive]
featured: false
toc: true

---

# Dynamics 365 Customer Service with Power Virtual Agents - Part 1 (automation with text chat)

 This article is the first part of a Kickstarter of two pieces and part of my ["Dynamics 365 automation with bots/voice bots 101"](https://the.cognitiveservices.ninja/series/101-d365) series; in this article and in the second part, I will focus on Power Virtual Agent in combination with Dynamics 365 Customer Service. The first article focuses on a text chat virtual agent with a handover option to a human agent, aka live chat. The second will demonstrate how to voice enable D365 and use voice bots.  
 Both pieces will demonstrate that it is possible to provide Omnichannel Customer service with human and non-human agents without a classical Contact Center installation.

## Motivation

Imagine a situation where your virtual agent is incapable of solving a query of your customer; that's the point where human-to-human interactions immediately come into play.

## Configuring the Power Virtual Agent

### Modify Escalate topic

First, we need to modify the default "Escalate" topic to display a meaningful message and handover to the human.

![Figure 1: standard escalate topic]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/nn3u9hc1g.png)

Figure 1: standard escalate topic

Modify the "Message" node with a meaningful message and insert a new "Transfer to Agent" node. By now, we leave the handover to the agent node empty, but this is where you could insert a summary for the human agent.

![Figure 2: modified escalate topic]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/j6gypwqcb.png)

Figure 2: modified escalate topic

### Publish the bot

After creating your Power Virtual Agent and modifying your "escalate" topic, it is time to publish your work to make it visible to the outside world.

![Figure 3: Publish your bot]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/qlihh1s2m.png)

Figure 3: Publish your bot

## OmniChannel Handover

### Configure Power Virtual Agent handover

It would be best if you had a working Dynamics 365 Customer Service environment to work with Omnichannel and human handover. As this is a Kickstarter, I will demonstrate how to start from nothing; you could even start with a 30-day free Dynamics 365 Customer Service trial.

First, we need to activate Agent Transfer with Omnichannel.

![Figure 4: Configure Omnichannel]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/oo2ctf9vp.png)

Figure 4: Configure Omnichannel

![Figure 5: Press enable]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/kw5pqxjcb.png)

Figure 5: Press enable

We enable voice as we will use it in the second part of this Kickstarter.  
If there is no active subscription for D365 Customer Service, we can enable a trial and select the created environment to use with Omnichannel.

![Figure 6: Start a trial if needed]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/gtsnijxan.png)

Figure 6: Start a trial if needed

![Figure 7: Enter your email address]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/fnro11b1i.png)

Figure 7: Enter your email address

![Figure 8: Launch trial]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/mqhhrbelb.png)

Figure 8: Launch trial

![Figure 9: Remember your D365 URL]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/hvtohbkt-.png)

Figure 9: Remember your D365 URL

![Figure 10: Select your new environment]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/3fm5nprrh.png)

Figure 10: Select your new environment

### Create Application Registration

After configuring these initial steps, we need to create an Application Registration in our Azure Active Directory. We go to the [Azure Portal](https://aad.portal.azure.com) and select Application registrations and "+Add".

![Figure 11: Select App registrations]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/f4604026-1ab5-4efb-a37f-4a7219baadf1.png)

Figure 11: Select App registrations

We give it a speaking name and select "Accounts in any organizational directory".

![Figure 12: Configure App registration]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/c2eltgc_d.png)

Figure 12: Configure App registration

After saving, we can get the Application ID of the Registration (red)

![Figure 13: Remember your Application ID]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/mg7srpcop.png)

Figure 13: Remember your Application ID

and paste this ID to our Agent Handover Configuration in Power Virtual Agent.

![Figure 14: paste in your Application ID]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/zvexalhyt.png)

Figure 14: paste in your Application ID

![Figure 15: find your bot connected ]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/-8rmwaros.png)

Figure 15: find your bot connected

### Setting up OmniChannel for Customer Service

We need to add some extensions to our environment, to add some features, but everything you see below will work without any extension installed.

#### **For only text (messaging) hand-off**

Install [Omnichannel Power Virtual Agent extension](https://appsource.microsoft.com/product/dynamics-365/mscrm.omnichannelpvaextension).

![Figure 16: install extensions ]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/vethbfewa.png)

Figure 16: Install extensions

If you still see the following warning after installing the Omnichannel Power Virtual Agent extension and don't need voice capabilities, you can safely ignore it.

![Figure 17: ignore warning]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/vxtmolk08.png)

Figure 17: ignore the warning

#### **For both text and voice hand-off**

Install the following extensions in this order:

1. [Power Virtual Agents telephony extension](https://appsource.microsoft.com/product/dynamics-crm/mscrm.mspva_telephony_extension)
    
2. [Omnichannel Power Virtual Agent extension](https://appsource.microsoft.com/product/dynamics-365/mscrm.omnichannelpvaextension)
    
3. [Omnichannel Voice Power Virtual Agent extension](https://appsource.microsoft.com/product/dynamics-365/mscrm.omnichannelvoicepvaextension)
    

### Configure Omnichannel for Customer Service

Next, we will create a Queue, a Workstream, and Ruleset.

First, go to https://yourtenant.crm.dynamics.com/apps

![Figure 18: Go to your D365 Dashboard]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/g2csyxxri.png)

Figure 18: Go to your D365 Dashboard

Select the "Customer Service admin center App"

![Figure 19: Check bots' existence ]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/89t3l0c2j.png)

Figure 19: Check bots' existence

### Create a Queue

We create a separate Queue for Customers asking for human-to-human interaction.

We select the Type "Messaging" as a queue type

![Figure 20: Create a queue]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/5gh12bayc.png)

Figure 20: Create a queue

![Figure 21: see "users missing" message]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/uadgecnli.png)

Figure 21: see the "users missing" message

and add some agents after completing it.

![Figure 22: add at least one user]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/bjop_s-mg.png)

Figure 22: add at least one user

### Create a Workstream

After creating the first queue, we generate a workstream to select the Work distribution mode and the fallback queue.

![Figure 23: Create and configure a workstream]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/xabayte1t.png)

Figure 23: Create and configure a workstream

Next, we create a chat widget; you could use a different, more customizable chat window configuration. You can find an example in my ["Create your first (voice-) bot"](https://the.cognitiveservices.ninja/build-your-first-voice-bot-with-microsoft-power-virtual-agent-3e71f8531c3a) article.

Click "Set up chat" and configure it accordingly to the screenshots.

![Figure 24: see "live chat required" message]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/pgid3csup.png)

Figure 24: see "live chat required" message

![Figure 25: configure live chat - part 1]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/uozmgig5l.png)

Figure 25: configure live chat - part 1

![Figure 26: configure live chat - part 2]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/cnguxjku7.png)

Figure 26: configure live chat - part 2

![Figure 27: configured live chat]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/knw3awfl1.png)

Figure 27: configured live chat

### Add a RuleSet

Next, we create a ruleset for handling the users.

![Figure 28: create a ruleset]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/ae_wje1uo.png)

Figure 28: Create a ruleset

and create a new rule.

We do not need to configure a condition, as we want to allow every user to enter the queue and assume you have a 24/7 service.

![Figure 29: create a rule]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/0urueq6dz.png)

Figure 29: Create a rule

### Add Bot to Workstream

We add our bot via smart assist bots' settings in the Advanced settings area.

![Figure 30: Add bot to workstream]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/kr9fw0qvel.png)

Figure 30: Add the bot to the workstream

### Add Context Variables

We need to add a first context variable to the workstream.  
We will use the va\_Scope Variable.

![Figure 31: test the chat, to display the context variables]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/38ogxqf_c.png)

Figure 31: test the chat to display the context variables

![Figure 32: see the context variables]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/8a4wrtdl6.png)

Figure 32: see the context variables

![Figure 33: add context variables]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/3wgxhfnhy.png)

Figure 33: add context variables

![Figure 34: Create context variable]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/cvyxqzfgf.png)

Figure 34: Create context variable

## Test handover

Let's test the handover.

Go to your workstream, copy the code for the snippet, create an empty HTML-File and paste the copied code into the body.

![Figure 35: Copy code snippet]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/60fdf04b-15f7-444e-8ac1-5e4d5b5882b4.png)

Figure 35: Copy code snippet

You will end up with something looking like this.

```xml
<!DOCTYPE html>
<html>
<head>
<title>Page Title</title>
</head>
<body>
<script id="Microsoft_Omnichannel_LCWidget" src="https://oc-cdn-public-eur.azureedge.net/livechatwidget/scripts/LiveChatBootstrapper.js" data-app-id="your data" data-lcw-version="prod" data-org-id="your data" data-org-url="https://your data.crm4.omnichannelengagementhub.com"></script>

</body>
</html>
```

Open the HTML File with your Browser and start chatting.

![Figure 36: start the dialog]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/a7e6c3f7-b9fe-40f6-98c7-9adbdf809679.png)

Figure 36: start the dialog

Ask the bot for a human agent.

![Figure 37: ask for agent]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/pcm67bgti.png)

Figure 37: ask for an agent

In your D365 Agent Dashboard, you should see an incoming chat and can talk to yourself.

![Figure 38: answer request]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/t-u8mzubz.png)

Figure 38: answer request

The agent can see the customer's dialog with the bot on the left side.

![Figure 39: Explore interface]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/usjh465yl.png)

Figure 39: Explore the interface

And can start to chat with the customer.

![Figure 40: customers' view]({{site.baseurl}}/images/clcbx9q4e0430o9nv7po24gyp.md/gyjns5x3p.png)

Figure 40: customers' view

## Conclusion

Self-service helps you provide 24/7 effective and efficient customer service; with the integration of human handover, you can keep your customer satisfaction high.