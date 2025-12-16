---
layout: post
title: Copilot Studio - voice in customer service - an experimental approach with ACSforMCS
description: Exploring the integration of Azure Communication Services with Microsoft Copilot Studio to create a voice channel for customer interactions.
date: 2025-08-09
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/08/victoria-strukovskaya-UkEN39LOTw8-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@struvictoryart?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Victoria Strukovskaya</a> on <a href="https://unsplash.com/photos/gray-telephone-UkEN39LOTw8?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
      
tags: [copilotstudio, voicechannel, customerservice]
author: admin
featured: false
toc: true
---
{: .q-left }
> **Summary Lede** 
ACSforMCS bridges Azure Communication Services with Microsoft Copilot Studio, providing an open-source, experimental alternative to traditional contact center solutions for voice interactions. This lightweight integration enables organizations of all sizes to implement AI-powered voice capabilities without the complexity and cost of complete Dynamics 365 Contact Center implementations. Ideal for small to medium-sized businesses, educational institutions, or specific use cases requiring voice automation, the project provides a flexible and scalable foundation for creating intelligent voice channels that connect customers with the AI-powered assistance they need.

{: .note }
**Update 2025-09-17**: One-Click Deployment to Azure is now available via  Deploy-to_Azure Button and Release Package.   
**Update 2025-09-13**: ACSforMCS is working stable as a Azure Web App. For Details and Deployment Options check the [GitHub repositories Wiki pages](https://github.com/holgerimbery/ACSforMCS/wiki). It offers Production and Development modes while running as a Web App with exposed monitoring endpoints while running in Development mode (Secured via API Key).


## The Power of Telephony in Customer Service

In today's digitally transformed landscape, it might be tempting to dismiss telephony as an outdated communication channel. However, the reality presents a more nuanced picture. Voice communication remains a fundamental pillar of effective customer service across industries, maintaining its relevance even as newer digital channels proliferate.

Research consistently demonstrates that for complex issues, emotionally sensitive matters, or situations requiring immediate resolution, customers frequently prefer the directness and human connection of a voice call. The synchronous nature of phone conversations enables real-time clarification, nuanced understanding, and emotional reassurance that asynchronous text-based channels cannot match.

This preference isn't merely anecdotal. According to multiple customer experience studies, voice remains the preferred channel for approximately 40% of consumers when they encounter complex service issues. This statistic holds even among younger demographics, who otherwise tend to embrace digital-first interactions for simpler matters.

What makes telephony uniquely valuable is its capacity for conveying tone, urgency, and empathy—critical elements in de-escalating frustrated customers or explaining intricate procedures. Additionally, voice communication accommodates individuals with varying technological comfort levels, accessibility needs, or those who simply value the efficiency of speaking over typing.

For organizations seeking to deliver truly customer-centric service experiences, the key lies not in choosing between digital channels and telephony but in thoughtfully integrating voice capabilities within a comprehensive omnichannel strategy. This integration enables customers to seamlessly transition between channels, based on the nature of their inquiry and personal preferences.

### Why Telephony Still Matters

Voice calls enable customer service representatives to resolve issues more efficiently, foster a sense of rapport, and tailor the customer experience. In regulated industries or high-stakes scenarios, a phone call can be the most secure and efficient means of communication. But traditional contact centers often struggle with siloed systems, outdated infrastructure, and limited scalability.

The immediacy of voice interaction creates opportunities for meaningful connection that text-based channels cannot replicate. When a customer service representative can hear frustration, confusion, or relief in a caller's voice, they can adjust their approach accordingly—slowing down their explanation, offering additional reassurance, or celebrating a resolution with appropriate enthusiasm. These subtle human touches have a significant impact on customer satisfaction and loyalty.

Furthermore, voice channels excel at complex problem-solving through collaborative dialogue. The natural back-and-forth of conversation allows for clarifying questions, real-time hypothesis testing, and immediate feedback that would require multiple exchanges over chat or email. This efficiency translates to faster resolution times and reduced customer effort—two critical metrics in service excellence.

Security considerations also favor telephony in many scenarios. Voice biometrics provide a sophisticated authentication method, allowing sensitive information to be verbally verified without creating permanent digital records. For industries handling confidential data—such as healthcare, financial services, and legal services—voice communication offers a balance of security and personalization that's difficult to achieve through other channels.

Despite these advantages, many organizations operate contact centers with fragmented technology stacks that undermine efficiency. Customer service representatives frequently toggle between multiple systems, lack contextual customer data, and struggle with telephony platforms that don't integrate with CRM systems or knowledge bases. This technological disconnect not only frustrates customer service representatives but also creates disjointed customer experiences that fail to meet modern expectations.

### Enter Dynamics 365 Customer Service or Dynamics 365 Contact Center
Microsoft's Dynamics 365 Customer Service and the newly enhanced Dynamics 365 Contact Center (where you can bring your own CRM) offer a modern, AI-powered alternative to legacy systems. These platforms integrate telephony directly into the customer service representative's experience, enabling seamless voice interactions alongside chat, email, and social channels.

With the latest updates, Dynamics 365 Contact Center now supports full Teams Phone extensibility—including Teams Calling Plans, Direct Routing, and Operator Connect—enabling organizations to unify their telephony and collaboration infrastructure in one place. This means simplified deployment, centralized billing, and enhanced capabilities, such as compliance recording, dial plan configuration, and AI-driven call insights.

### AI-Powered Voice Agents: The New Frontier
Recent innovations showcased at events - Agents, agents, agents! They highlight how AI voice agents are transforming the delivery of services. Custom agents and autonomous agents are now capable of handling up to 80% of everyday service tasks, offering proactive, personalized, and scalable support.

These agents are built using platforms like Copilot Studio, which allow organizations to define specialized roles, integrate Azure AI models, fine-tune responses for accuracy and relevance, and hand over to a human when needed.

## An Alternative Approach for Voice Interaction with Customers and Copilot Studio
Sometimes, a full-fledged contact center solution is not needed. In these cases, you can use Copilot Studio and Azure Communication Services to create a voice channel that allows customers to interact with your business via voice calls. This approach is beneficial for small businesses or specific use cases where a complete contact center solution would be overkill.

By leveraging these tools, organizations can create customized voice experiences that meet their unique needs, without the complexity and cost associated with traditional contact centers.



## ACSforMCS - Azure Communication Services for Microsoft Copilot Studio

I started an open-source project called [ACSforMCS](https://github.com/HolgerImbery/ACSforMCS) to explore the integration of Azure Communication Services with Microsoft Copilot Studio. This project aims to provide an alternative approach to creating voice channels for customer interactions, without relying on a comprehensive Dynamics 365 Contact Center solution. The project is still in its early stages, but it has the potential to offer a lightweight, cost-effective solution for organizations seeking to enhance customer engagement through voice. You can use it under the MIT License. 


### Project Background

The genesis of this project came from observing a gap in the market. While enterprise-level solutions like Dynamics 365 Contact Center offer comprehensive features, many organizations, such as tiny to medium-sized businesses, educational institutions, or specific departments within larger companies, need voice interaction capabilities without the overhead of a complete contact center deployment.

Azure Communication Services (ACS) provides a robust foundation for communication capabilities, offering voice, video, and chat functionality through reliable APIs. Meanwhile, Microsoft Copilot Studio excels at creating conversational AI experiences with its intuitive low-code interface and powerful natural language processing capabilities. The combination of these technologies creates an opportunity to build scalable, cost-effective voice solutions that leverage the best of both worlds.

### Bridging the Technology Gap

The ACSforMCS project positions itself as a transitional solution for organizations eager to explore and implement voice interaction capabilities while awaiting a fully integrated first-party voice channel within Microsoft Copilot Studio. This experimental bridge addresses an immediate need in the market, allowing businesses to test, refine, and deploy voice-enabled AI assistants without waiting for official product roadmap developments.

By providing this intermediate pathway, the project enables forward-thinking organizations to gain valuable experience with AI-powered voice technologies, collect user feedback, and develop internal expertise. This practical knowledge will prove invaluable when first-party solutions eventually become available, positioning early adopters to make informed decisions about migration and implementation strategies.

The experimental nature of the project also encourages innovation and community-driven development, with each deployment potentially contributing insights that could inform the direction of official solutions. For Microsoft partners and customers invested in the Copilot Studio ecosystem, ACSforMCS represents an opportunity to extend platform capabilities while maintaining alignment with the broader Microsoft AI and communication technology stack.


### Technical Approach

ACSforMCS bridges these platforms through a modular architecture that:

1. **Establishes inbound telephony** via Azure Communication Services phone numbers
2. **Processes voice interactions** using Azure Speech Services for speech-to-text and text-to-speech
3. **Route conversations** to the appropriate Copilot Studio bots based on customer intent
4. **Handover to a human** using a simple transfer mechanism by sending a special formated message
4. **Manages session state** to maintain context throughout customer interactions


### Deployment Flexibility

One of the core principles of ACSforMCS is deployment flexibility.  
Organizations can:   

- Start with a local development environment for testing and proof of concept
- Deploy to Azure for production scenarios with automated scaling

This graduated approach allows businesses to build confidence in the solution before fully committing, making voice AI technology more accessible to organizations at various stages of their digital transformation journey.

### Use Cases and Applications

The project can already demonstrate value in several scenarios:

- **Appointment scheduling systems** for healthcare providers and service businesses
- **Information hotlines** providing automated answers to common questions with escalation paths
- **Simple ordering systems** for restaurants and retail businesses
- **Initial customer screening** before routing to specialized departments
- **After-hours support** when human agents aren't available

By leveraging Copilot Studio's capabilities, these voice interactions can access the same knowledge bases, Power Platform automations, and backend systems as their text-based counterparts, creating a truly omnichannel experience.

You can start slowly to build confidence in the technology and then scale up as needed, from a local test deployment to a fully Azure-based and automatically scalable solution.

### Getting Started with ACSforMCS
Check the [GitHub repository](https://github.com/HolgerImbery/ACSforMCS) for detailed documentation and setup instructions.
The code is heavily commented to help you understand the integration points and how to customize the solution for your specific needs.

## Conclusion
The ACSforMCS project represents an exciting opportunity to explore the intersection of voice communication and AI-driven customer service. By leveraging Azure Communication Services and Microsoft Copilot Studio, organizations can create tailored voice experiences that enhance customer engagement without the complexity of traditional contact center solutions.
As the project evolves, it will continue to focus on providing a lightweight, scalable foundation for voice interactions that meet the needs of diverse organizations. Whether you're a small business looking to implement voice capabilities or an IT professional exploring innovative solutions, ACSforMCS offers a promising avenue for enhancing customer service through voice technology.
Stay tuned for updates as the project progresses, and feel free to contribute or provide feedback on the GitHub repository.

