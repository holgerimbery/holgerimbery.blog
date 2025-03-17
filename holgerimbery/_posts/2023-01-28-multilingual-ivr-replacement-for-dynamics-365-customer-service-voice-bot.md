---
layout: post
title: Multilingual IVR Replacement for Dynamics 365 Customer Service (Voice Bot)
description: 
date: 2023-01-28
author: admin
image: ./images/archive.jpg
tags: [archive]
featured: false
toc: true

---

# Multilingual IVR Replacement for Dynamics 365 Customer Service (Voice Bot)

 ***Imagine serving your customers and employees immediately in their native language, without waiting in Contact Center Queues, 24/7, with your new self-service voice bot factory. Always with a human agent as an escalation target.***

## Prerequisites

* Having Dynamics 365 Customer Service installed and an Application Registration in place. Please find a detailed description in my article "[**Dynamics 365 Customer Service with Power Virtual Agents - Part 1 (automation with text chat**)](https://the.cognitiveservices.ninja/dynamics-365-customer-service-with-power-virtual-agents-part-1-automation-with-text-chat)."
* Having the voice channel deployed with some phone numbers. Please find a detailed description in my article "[**Dynamics 365 Customer Service with Power Virtual Agents - Part 2 (automation with voice/voice bots)**](https://hashnode.com/preview/63a2eae17c853fb9ce043f9f)**.**"

* Bot Framework Composer must be installed locally.

## Architecture

The basic idea behind our concierge is to have a cascade of bots living in separate queues. Please keep in mind to always create an escalation to a human path.

We start with a selector for the language and forward the outcome to a queue for that specific language. You could create another bot for that queue or bring human agents to that queue. This mechanism can be used for a cascade of bots with different skills in several languages and can be your foundation of a bot factor in front of your human agents.

![Figure 1: Architecture]({{site.baseurl}}/images/cldfwz8y0000e0ajydlt7752t.md/d3b39795-75c9-48cd-a6bc-42498c662b15.png)

Figure 1: Architecture

## Create the first level of the cascade

### Create a concierge bot in Power Virtual Agents

Create your "concierge" bot with English (US) language in your Omnichannel-enabled environment.

![Figure 2: Create a bot]({{site.baseurl}}/images/cldfwz8y0000e0ajydlt7752t.md/48a8ab4a-b8a8-4216-8681-667205e637f3.png)

Figure 2: Create a bot

### Create a new topic in Bot Framework Composer

Create a new topic with Bot Framework Composer.

![Figure 3: Create a new composer topic]({{site.baseurl}}/images/cldfwz8y0000e0ajydlt7752t.md/af55aa73-f29d-4087-81f0-94d493e20d64.png)

Figure 3: Create a new composer topic

![Figure 4: Add dialog]({{site.baseurl}}/images/cldfwz8y0000e0ajydlt7752t.md/d50bed99-f0fa-43c6-8ee6-7734b7c62d65.png)

Figure 4: Add dialog

![Figure 5: Give dialog a name]({{site.baseurl}}/images/cldfwz8y0000e0ajydlt7752t.md/ffa14854-420b-4545-a521-5ac7d7ec6302.png)

Figure 5: Give the dialog a name

![Figure 6: goto BeginDialog]({{site.baseurl}}/images/cldfwz8y0000e0ajydlt7752t.md/651de35e-a541-48b1-a7fd-958b953d1522.png)

Figure 6: goto BeginDialog

select the **Add** (+) node, and then select **Send a response**.

![Figure 7: add "Send a response"]({{site.baseurl}}/images/cldfwz8y0000e0ajydlt7752t.md/2af2dd28-0894-4a50-9174-05d7792db60f.png)

Figure 7: add "Send a response"

```xml
<speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xml:lang="en-US"><voice name="en-US-AriaNeural"><lang xml:lang="en-US">Hello! Welcome to customer support.</lang></voice></speak>
```

 The variable ${virtualagent.msdyn\_CustomerName} is available for authenticated customers. see [Identify customers automatically](https://learn.microsoft.com/en-us/dynamics365/customer-service/record-identification-rule)

select **Add** (+) node, point to **Ask a question**, and then choose **Multi-choice**.

![Figure 8: add "Ask a question"]({{site.baseurl}}/images/cldfwz8y0000e0ajydlt7752t.md/91c2e560-39f3-4b89-9b13-3069d65611e5.png)

Figure 8: add "Ask a question"

```xml
<speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xml:lang="en-US"><voice name="en-US-JennyMultilingualNeural"><lang xml:lang="en-US">Press or say 1 for English.</lang><break strength="medium"/><lang xml:lang="fr-FR">Appuyez ou dites 2 pour le français.</lang><break strength="medium"/><lang xml:lang="de-DE">Sagen oder drücken Sie 3 für Deutsch</lang></voice></speak>
```

Select the **User input** box

![Figure 9: modify user input box]({{site.baseurl}}/images/cldfwz8y0000e0ajydlt7752t.md/1cc7a3f7-c469-4f79-afba-484b266c50ca.png)

Figure 9: modify user input box

![Figure 10: edit array of choices]({{site.baseurl}}/images/cldfwz8y0000e0ajydlt7752t.md/c024f853-fcdc-43b7-bb80-a30c41a836c6.png)

Figure 10: edit array of choices

Property:

```plaintext
conversation.language_choice
```

Array of **choices**

```plaintext
1, 2, 3, one, two, three, un, deux, trois, eins, zwei, drei
```

Select the **Add** (+) node, select **Create a condition**, and then select **Branch Switch (multiple options)**

![Figure 11: create conditions]({{site.baseurl}}/images/cldfwz8y0000e0ajydlt7752t.md/70d1703d-7539-4848-bc4b-e61cb6ed0a9f.png)

Figure 11: create conditions

Condition:

```plaintext
conversation.language_choice
```

Value:

```plaintext
Value: 1, 2, 3, One, Two, Three, Un, deux, trois, eins, zwei, drei
```

Enter here one choice per value.

Select the **Add** (+) node and then select **Manage properties** &gt; **Set a property**

![Figure 12: set properties]({{site.baseurl}}/images/cldfwz8y0000e0ajydlt7752t.md/3f9a3604-5439-40de-a032-bd5249ac9138.png)

Figure 12: set properties

and enter the following details:

Condition:

```plaintext
virtualagent.va_CustomerLocale
```

Value:

```plaintext
en-US
```

Repeat the steps to **Set a property** for fr-FR, de-DE.

The value for the virtualagent.va_CustomerLocale variable will be updated with the language selected by the caller.

 set the va_CustomerLocale context variable with the locale codes for the languages that you want to support. see: [**Supported locations and locale codes**](https://learn.microsoft.com/en-us/dynamics365/customer-service/voice-channel-region-availability#supported-languages-and-locale-codes)

Select the **Add** (+) node, and then select **Begin a Power Virtual Agent topic**.

![Figure 13: add a "begin a new dialog" node]({{site.baseurl}}/images/cldfwz8y0000e0ajydlt7752t.md/6c29b202-3144-4cda-b713-061e0e47efe7.png)

Figure 13: add a "begin a new dialog" node

Select "Escale" in the Dialog name.

Publish the bot in Bot Framework composer, go back to PVA editing canvas, refresh, find the topic and publish in PVA.

![Figure 14: new composer topic in PVA]({{site.baseurl}}/images/cldfwz8y0000e0ajydlt7752t.md/0bd827a0-1c47-4e54-830e-779e83677ec9.png)

Figure 14: new composer topic in PVA

### Configure the greeting topic in Power Virtual Agents

Open the **Greeting** topic in the authoring canvas and delete everything except the trigger phrases.

Select **Add node** (+), and then select **Redirect to another topic**. Choose the topic you created above.

![Figure 15: modify greeting]({{site.baseurl}}/images/cldfwz8y0000e0ajydlt7752t.md/226ca585-eff8-4c57-92af-52b09f5a3a46.png)

Figure 15: modify greeting

### Configure the transfer to the next queue by using the escalate topic

open the **Escalate** topic in the authoring canvas, and delete all the default messages except the trigger phrases.

Select Add **node (+)**, select **End the conversation**, and then select **transfer to agent**.

![Figure 16: escalate topic for handover]({{site.baseurl}}/images/cldfwz8y0000e0ajydlt7752t.md/bf1f6e57-35f3-4918-8ad2-b791b258cbd4.png)

Figure 16: escalate topic for handover

Save and publish.

Check your application registration on [AAD Portal](aad.portal.azure.com) and remember the Application ID.  
(See prerequisite)

![Figure 17: Application Registration]({{site.baseurl}}/images/cldfwz8y0000e0ajydlt7752t.md/dac213c4-8fb3-4cc0-8457-526c13916371.png)

Figure 17: Application Registration

Go to **Settings**, **Agent transfer**, select **Omnichannel, enable it and configure the transfer with the Application ID.**

![Figure 18: configure omnichannel]({{site.baseurl}}/images/cldfwz8y0000e0ajydlt7752t.md/ab5e3283-a64e-44a2-9db3-6c55c6f39ef2.png)

Figure 18: configure omnichannel

### Configure workstreams and queues

In Dynamics 365 Customer Service Admin Center configure a voice workstream, a voice queue, and their routing rules.

Please find my Articles:

* [**Dynamics 365 Customer Service with Power Virtual Agents - Part 1 (automation with text chat)**](https://hashnode.com/preview/63a2c5097a49d4b565493409)

* [**Dynamics 365 Customer Service with Power Virtual Agents - Part 2 (automation with voice/voice bots)**](https://hashnode.com/preview/63a2eae17c853fb9ce043f9f)

as a reference.

Use the configured bot as the **bot** in the workstream settings as an escalation target for the bot; we need to configure three additional queues - one each for English, French, and German and add the required agents, or if you want to use a bot, add the bot.

Configure a voice workstream with English as the primary language and French and German as additional languages.

In the route to queues rule set of the workstream, use **Conversation.CustomerLanguage** as the criteria to route the incoming call to different language queues based on the option selected by the customer.

## Test implementation

As a customer, call the number registered with the voice workstream with a phone with a registered CallerID and one without. Hear the greeting and make your choice.

## next steps

You can use this mechanism to cascade; please feel free to add additional bots and escalations to give your customer a choice of targets to consult. Do not forget it is better to have a bot doing the job immediately instead of waiting for an agent.
