---
layout: post
title: Dynamics 365 customer service - configure call recording and transcription for voice bots and agent dialogues
description: 
date: 2023-02-25
author: admin
image: ./images/archive.jpg
tags: [archive]
featured: false
toc: true

---

# Dynamics 365 customer service: configure call recording and transcription for voice bots and agent dialogues

drive service improvements with data

## Disclaimer

This kick-starter guide describes the possibility of configuring call recording and call transcription. Please keep in mind the following:

Important

Many countries and states have laws and regulations that apply to the recording of PSTN (Public Switched Telephone Network), voice, and video calls, and may require that users first consent to the recording of their communications. It is your responsibility to use the call recording and transcription capabilities in compliance with the law. Before using call recording features, you must obtain consent from the parties of recorded communications in a manner that complies with all applicable laws for each participant.

## Motivation

Customer service as an enjoyable experience should be every company's goal. And every company should treat its employees in the same way as its best suppliers. Therefore, we should focus on providing both groups with the best possible (self-) service. We should never ask twice or bore them with asking things we know or the customer's address already. This is one of the use cases for transcribing calls and chats, especially when the call is between a human and a virtual agent. Suppose the virtual agent can't solve the customer's query, and the customer chooses to continue the dialogue with a human. In that case, we don't want to force the customer to tell the agent the whole story again.

We transmit the whole dialog with a (voice-) bot to the human agent and create a summary of the dialogue to give the agent a chance to greet the caller with the right words, demonstrating being well-informed.

## **Enable call recording and transcription for voice**

to enable call recording and transcription for a workstream

* open Workstreams within your "Customer Service admin center".

![Figure 1: workstream overview]({{site.baseurl}}/images/clejxxccl02pl9invf4ts678x.md/cc889ebf-c29c-4204-9a01-8cad1f8fd899.png)

Figure 1: workstream overview

* select the relevant workstream and open it.

* Click on edit in the voice channel configuration.

![Figure 2: voice channel configuration]({{site.baseurl}}/images/clejxxccl02pl9invf4ts678x.md/04598904-4cae-4db1-acde-cac6246c34c2.png)

Figure 2: voice channel configuration

* select Behaviors

* choose the feature you want to enable in the section Transcription and Recording

![Figure 3: enable features]({{site.baseurl}}/images/clejxxccl02pl9invf4ts678x.md/5d337feb-02c5-4ae2-9aad-4d88e9f6047f.png)

Figure 3: enable features

## View call transcripts after handover

If the customer asks for a handover from the voice bot to a live agent, the agent will see the full transcript after taking the call, even with the customer's sentiment. If you use the "private message to agent" feature of the Power Virtual agents, relevant data from the chat with the bot are summarized.

![Figure 4: Transcript in agent desktop]({{site.baseurl}}/images/clejxxccl02pl9invf4ts678x.md/f046b892-4cff-4f1e-b517-559c413de64f.webp)

Figure 4: Transcript in agent desktop

## View call transcripts for a specific Contact

If you want to check a call from a specific customer, for example, while working on a case.

* Select, e.g., contacts in the agent desktop.

The same applies equivalently if you go via cases, accounts, etc**.**

![Figure 5: select Contacts]({{site.baseurl}}/images/clejxxccl02pl9invf4ts678x.md/a92922b9-9a65-45b3-b2d5-32cc8f34bcca.png)

Figure 5: Select Contacts.

* Find the relevant contact.

![Figure 6: select a specific contact.]({{site.baseurl}}/images/clejxxccl02pl9invf4ts678x.md/f0b58012-7ff4-4d87-9792-ca4f6dd74bdf.png)

Figure 6: select a specific contact.

* Select the relevant call/chat and open the transcript with the three dots menu.

![Figure 7: select the relevant call/chat]({{site.baseurl}}/images/clejxxccl02pl9invf4ts678x.md/96c5a9cf-7896-445d-877b-183291042c00.png)

Figure 7: Select the relevant call/chat.

* Explore the transcript and the recording.

![Figure 8: Transcript/Recording]({{site.baseurl}}/images/clejxxccl02pl9invf4ts678x.md/87988afb-5254-47a9-8d95-eb4bd14c8109.png)

Figure 8: Transcript/Recording

## Conclusion

Telling things twice is a pain for a customer calling your company; avoid the situation where an agent asks stuff you already know in your files and things the customer already told the virtual agent. With transcription and analysis of the transcripts, you can avoid this instantly.
