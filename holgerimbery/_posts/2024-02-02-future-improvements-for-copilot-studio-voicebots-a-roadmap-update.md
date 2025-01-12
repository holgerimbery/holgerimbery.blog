---
layout: post
title: Future Improvements for CoPilot Studio Voicebots - A  Roadmap Update
description: 
date: 2024-02-02
author: admin
image: ./images/future-improvements-for-copilot-studio-voicebots-a-roadmap-update.jpeg
tags: [customerservice, roadmap, dynamics365, copilotstudio]
featured: false
toc: true

---


Voice bots, also known as voice-based virtual assistants, are revolutionizing customer service by offering a range of benefits that enhance the customer experience and operational efficiency.

In the fast-paced world of customer service, voice bots have emerged as a critical tool for delivering instant, round-the-clock support. By leveraging natural language processing and machine learning, these bots can understand and respond to customer inquiries with remarkable accuracy, simulating a human-like interaction. This reduces wait times, frees up human agents to handle complex issues, and ensures consistent service during peak hours or off-hours.

Moreover, voice bots can handle multiple customers simultaneously, scaling as demand fluctuates, which is something human agents cannot do. This scalability ensures that customer service quality does not diminish during high-volume periods. Additionally, voice bots can collect and analyze data from interactions, providing valuable insights into customer needs and preferences, which can inform business strategies and improve service over time.

## What is upcoming?

Dynamics 365 Customer Service, in conjunction with Copilot Studio, represents an ideal pairing for automating customer service processes. This combination offers a comprehensive suite of tools that streamline interactions and workflows, enhancing the overall efficiency and effectiveness of customer service operations. While voice bots are an integral component of this automation landscape, they currently do not offer the same breadth of capabilities as their web chatbot counterparts. However, the gap is beginning to close, thanks to the continuous advancements and updates outlined in Microsoft's release plan. These updates signal a promising evolution in the capabilities of voice bots, suggesting that they will soon reach parity with web chatbots in terms of functionality and versatility. As these technologies mature, we can anticipate a future where voice bots play an increasingly pivotal role in customer service automation, driving the potential for more dynamic and responsive customer interactions.

Source Microsoft Roadmap Planner: (wording by the vendor)

### [CoPilot Studio Updates](https://releaseplans.microsoft.com/en-us/?app=Microsoft+Copilot+Studio#plan-1231093f-28ba-ee11-a569-00224827e905)

**IVR in OmniChannel for Customer Service (April 2024)**  
Native voice integration in Microsoft Copilot Studio will dramatically improve the experience of building voice-enabled bots for customers using the voice channel in Omnichannel for Customer Service. Including voice responses and analysis in your bot can increase the ways in which your customers interact with your business. Voice integration can provide faster, more efficient resolutions to common questions, improving your deflection rate and customer satisfaction scores.

**Feature Details**

Microsoft Copilot Studio incorporates native voice authoring capabilities with the Voice channel in Dynamics Omnichannel for Customer Service integrations.

These capabilities include:

* Dual-tone multi-frequency (DTMF) input, including single and multi-digit processing, allows users to interact with the bot using their phone keypad
    
* Silence detection for prompts, including retries and prompts, and configurable actions for no response
    
* Barge-in control for determining whether the bot can be [interrupted](https://learn.microsoft.com/en-us/azure/ai-services/speech-service/speech-synthesis-markup) or not
    
* SSML support for configuring how the bot sounds on a per-message basis, including playing audio files to the user instead of text-to-speech
    
* Long-running operation latency message
    
* Enhanced speech recognition based on bot content
    

### Dynamics 365 Customer Service Updates

[Interoperability of third-party interactive voice response (IVR)](https://learn.microsoft.com/en-us/azure/ai-services/speech-service/speech-synthesis-markup)(May 2024)  
Interoperability of third-party interactive voice response (IVR) enables organizations to provide continuous self-service to their customers. Self-service improves the call deflection rate so that human agents have more time to engage in meaningful and impactful conversations with their customers.

**Feature Details**

Integrating third-party IVR technologies with the voice channel in Dynamics 365 Customer Service allows organizations to enhance customer satisfaction and contact center productivity. This includes support for escalating from IVR to agents, sharing contextual data through Dataverse, and custom UX controls for presenting data to agents. The interoperability documentation adheres to an in-front-of-the-switch architecture, accommodating Nuance Cloud IVR capabilities as they currently exist and enabling other CCaaS vendors to orchestrate calls between IVR and Omnichannel for Customer Service using SIP operations.

**Use cases**

* Customers can carry out self-service tasks using third-party IVRs.
    
* Customer intent and context for calling are accurately identified through industry-specific natural language models.
    
* Customers can be transferred, along with custom-defined context data, to an agent who is fully informed and prepared to continue the conversation and resolve cases.
    
* Call intent and customer data can be utilized for appropriate call routing.
    

**Benefits**

As we progress into an AI-driven world with enhanced speed and information, experiences become more seamless and automated. This integration enables customers to reap the following benefits:

* Boost call center productivity by increasing the proportion of call deflections and self-service calls.
    
* Cut costs by optimizing the workforce.
    
* The average time spent on calls escalated from IVR to agents is decreased, thanks to context availability.
    

**Geographic areas**

This feature will be released into the following Microsoft Azure geographic area:

* United States
    

## Conclusion

As outlined in Microsoft's release plan, the future of voice bots in customer service looks promising, with significant advancements on the horizon. The integration of CoPilot Studio with Dynamics 365 Customer Service is set to enhance the capabilities of voice bots, bringing them closer to the functionality and versatility of their web chatbot counterparts. The upcoming updates will improve the customer experience, boost operational efficiency, and provide valuable customer insights. As these technologies evolve, we can expect voice bots to play a more significant role in customer service automation, shaping the future of customer interactions.