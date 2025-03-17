---
layout: post
title: The New Voice Capabilities of Copilot Studio - A Comprehensive Overview
description: 
date: 2024-07-27
author: admin
image: ./images/the-new-voice-capabilities-of-copilot-studio-a-comprehensive-overview.jpeg
tags: [copilot, dynamics365, copilotstudio, contact-center]
featured: false
toc: true

---

{: .note }
This article is the second in a mini-series. In the [first part](https://holgerimbery.blog/enhance-customer-service-with-dynamics-365s-integrated-voice-channel), I discussed integrating the voice channel for Dynamics 365 Contact Center and Dynamics 365 Customer Service Premium.

## Introduction

In the rapidly evolving landscape of artificial intelligence, **Copilot Studio** has consistently been at the forefront, pushing the boundaries of what is possible. The latest addition to its impressive suite of features is the introduction of **new voice capabilities**. This innovative feature has the potential to revolutionize the way we interact with AI, making it more natural, intuitive, and user-friendly.

## Advanced Speech Recognition and DTMF Support

The cornerstone of these new voice capabilities is an advanced speech recognition system. This cutting-edge technology accurately transcribes spoken words into text. It’s designed to work effectively even in noisy environments or when dealing with various accents, demonstrating the robustness and versatility of the technology that powers Copilot Studio.

In addition to speech, Copilot Studio also supports Dual-Tone Multi-Frequency (DTMF) input. This feature allows users to interact with the AI by pressing keys on their phone keypad. This dual mode of interaction - voice, and keypad - ensures that users have multiple ways to communicate with the AI, enhancing accessibility and convenience.

## Multilingual Support

One of the most impressive features of the new voice capabilities is the multilingual support. Copilot Studio can understand and respond to commands in multiple languages. This makes it a truly global AI companion, capable of serving users from around the world. By breaking down language barriers, this feature makes AI technology accessible to a much broader audience.

## Real-Time Responses and Error Handling

Another noteworthy feature is the ability to provide real-time responses. As soon as a user finishes speaking, Copilot Studio can immediately process the command and provide a response. This real-time interaction significantly enhances the user experience, making the conversation with the AI feel more like a conversation with a human.

Copilot Studio is equipped with a comprehensive error handling mechanism in case of any issues. It provides detailed error codes to help troubleshoot and diagnose runtime errors, ensuring a smooth and seamless user experience.

## Getting Started with Voice Capabilities

Users must configure their Copilots for Voice in Copilot Studio to get started with the new voice capabilities. This involves creating a new copilot, configuring the voice-related settings, and connecting the copilot to Omnichannel for Customer Service. Users also have the option to build a voice-enabled copilot from a template, which includes specific voice system topics for handling voice scenarios.

### Create a new Copilot

create a new bot on https://copilotstudio.microsoft.com

![]({{site.baseurl}}/images/clz3xugxg000209l8gr335ait.md/9b73b744-ebf1-447c-b9c4-4c25502443a0.png)

### Configure Voice Settings

* go to Settings &gt; Copilot Details &gt; Voice
    
* Mark "Use voice as a primary author mode"
    

![]({{site.baseurl}}/images/clz3xugxg000209l8gr335ait.md/da7563e8-5ff0-4d5c-b8d6-a47a969f829b.png)

### Configure Telefony Channel

* Go to Channels &gt; Channels, click "Telephony" and activate it.
    

![]({{site.baseurl}}/images/clz3xugxg000209l8gr335ait.md/1e626750-6ade-4f4d-a975-75e2700cef29.png)

### Configure Handover to Dynamics 365 Customer Service or Dynamics 365 Contact Center

* go to Channels &gt; Customer Engagement Hub &gt; Dynamics 365 Customer Service
    
    ![]({{site.baseurl}}/images/clz3xugxg000209l8gr335ait.md/5e24c101-d8f7-4e7c-b065-1546fe2334b5.png)
    
* If you have activated it, the result should look similar to the picture below.
    

![]({{site.baseurl}}/images/clz3xugxg000209l8gr335ait.md/42014edc-d8ec-43f8-8162-655654a24c32.png)

* Navigate to the Dynamics 365 "Customer Service Admin Center" or "Contact Center Admin Center," proceed to your voice workstream, and click 'Add bot.'
    
* Then, select the bot you have recently created. The outcome should resemble the screenshot provided.
    

![]({{site.baseurl}}/images/clz3xugxg000209l8gr335ait.md/a45eb71c-3f56-4f26-8d06-8fd47fe59bee.png)

### Greet your calling customer by name

To greet a caller by name, you can utilize the caller ID and an associated contact in Dynamics Customer Service by adding a variable to a text node.

![]({{site.baseurl}}/images/clz3xugxg000209l8gr335ait.md/78b6c953-b40b-4b5c-9e7b-35e1fb4e4604.png)

![]({{site.baseurl}}/images/clz3xugxg000209l8gr335ait.md/dcd07062-256b-4035-8aad-0017f567b467.png)

![]({{site.baseurl}}/images/clz3xugxg000209l8gr335ait.md/f09f5e9f-fc17-49b8-bb51-33fd6063dab2.png)

![]({{site.baseurl}}/images/clz3xugxg000209l8gr335ait.md/b935b8cf-dcc9-4efb-853f-7f6dc0771ab2.png)

## Testing Your Voice-Enabled Copilot

Once the copilot is set up, users can test it using text inputs that simulate a user’s input through speech or DTMF. This allows users to see the speech response in the text output and verify voice features such as Barge-in and DTMF in their text input.

![]({{site.baseurl}}/images/clz3xugxg000209l8gr335ait.md/cce0c1c4-6785-465a-baa3-e9bc6b766cde.png)

![]({{site.baseurl}}/images/clz3xugxg000209l8gr335ait.md/f5f14115-7e90-4ba9-b360-fd882ec7268d.png)

## Conclusion

The new voice capabilities of Copilot Studio mark a significant advancement in AI technology. They offer enhanced speech recognition, multilingual support, and real-time responses for contact centers. These features make interactions with AI more natural and intuitive and broaden accessibility for users worldwide. Following the steps outlined in this article, companies can easily configure and test their voice-enabled copilots, ensuring a seamless and efficient experience. As AI continues to evolve, innovations like these will undoubtedly play a crucial role in shaping the future of human-computer interaction.