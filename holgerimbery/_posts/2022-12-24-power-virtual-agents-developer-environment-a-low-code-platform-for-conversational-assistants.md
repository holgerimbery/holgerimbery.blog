---
layout: post
title: Power Virtual Agents - a low-code platform for conversational assistants
description: 
date: 2022-12-24
author: admin
image: ./images/archive.jpg
tags: [archive]
featured: false
toc: true

---

# Power Virtual Agents - a low-code platform for conversational assistants

 Power Virtual Agents are part of Microsofts Power Platform and an ideal start for developing conversational (voice-)bots.  
 It is not just another low-code bot platform with a SaaS-based deployment model.  
 It is part of a robust environment,
 
 * with Power Automate to connect to hundreds of backend systems and a reliable link to Microsofts Azure Services,
     
 * with an Analytics system based on Power BI and the possibility of using Azure Synapse for deeper analytics,
     
 * with built-in process mining capability and
     
 * with multiple channels to connect to several communications methods or to hand over to human agents - based on a third party (Audiocodes Voice Ai) or first party solution (D365)
     

Recently, I ran a workshop (Power Virtual Agent in a Day) with clients.  
I demonstrated Power Virtual Agents, and we allowed the participants to explore PVAs capabilities.

We built together their first bot in 6 hours.  
One question came up, and I was wondering that none of them knew the answer: **How can I start, with no upfront investment, to explore Power Virtual Agents?**  
The answer to this question is what you can read below.

## How to start

Microsoft offers a series of developer programs with free access to tools starting with Power Virtual Agents.

### Create a personal Microsoft account

If you have no personal Microsoft Account, this is the time to create [one](https://outlook.live.com/).

### Microsoft Office Developer Program

Register for a Developer Account in the [Microsoft Office Developer Program](https://developer.microsoft.com/microsoft-365/dev-program).

You will get a renewable sandbox with 25 E5 Microsoft Office subscriptions. The sandbox will be renewed if you are developing and not violating the program's rules.

With this Plan, you will get SharePoint, Microsoft Teams, and a lot more to have an ecosystem for starting to develop Power Virtual Agents.

### Power Apps Developer plan

Register for the [Power Apps Developer plan](https://powerapps.microsoft.com/en-au/developerplan/), and you will get an additional environment with Dataverse Storage. The additional Environment can be used to try out Application Lifecycle Management via GitHub.

### Register for Power Virtual Agents

Use the admin account of your Developer Tenant you created in the second step to start a free trial for Power Virtual Agents.

### GitHub Account

If you do not already have one, [create one](https://github.com/signup); GitHub is an excellent place to store your "source code" and set up CI/CD Pipelines with GitHub Actions to start with Applications Lifecycle Management.

A good starting point for GitHub actions and Power Virtual Agents is my article "[Power Virtual Agent Application Lifecycle Management](https://the.cognitiveservices.ninja/power-virtual-agents-application-lifecycle-management-38bf9882e2d6)" and the documentation of [GitHub Actions](https://docs.github.com/en/actions) and the [Power Platform Action](https://learn.microsoft.com/en-us/power-platform/alm/devops-github-actions).

### Register for an Azure Trial

To use Azure Services, you can [register](https://azure.microsoft.com/en-us/free/) for an Azure Trial and get a little budget to explore Azure Services as a Power Platform extension. With this, you could start to integrate, e.g., Azure Cognitive Service for Language, as described in my article "[Extend Power Virtual Agent with Azure Cognitive Services](https://the.cognitiveservices.ninja/extend-power-virtual-agent-with-azure-cognitive-services-eab95018b7f6)"

### Register for an AI Builder Trial

To access AI Builder, you can [register](https://powerapps.microsoft.com/en-us/ai-builder/) for a free trial and use sentiment, e.g., analysis within your bots. A little Kickstarter for this is in my beginner-level Kickstarter, "[Build your first (voice-) bot with Power Virtual Agent](https://the.cognitiveservices.ninja/build-your-first-voice-bot-with-microsoft-power-virtual-agent-3e71f8531c3a#heading-optional-ai-builder-feedback-system-with-sentiment-analysis)".

### Voice AI Connect Cloud

To give your Power Virtual Agent a voice, you can register for AudioCodes Voice AI Connect Cloud; there is no free trial, but you get a little credit upfront, and using the service for development is not a huge investment. To use it in production, you should consider using the "enterprise" version, as this will give you more flexibility.  
You can get a first hands-on experience with it [here](https://the.cognitiveservices.ninja/build-your-first-voice-bot-with-microsoft-power-virtual-agent-3e71f8531c3a#heading-configure-your-bot-in-audiocodes-voiceai) and [here](https://the.cognitiveservices.ninja/give-your-bots-a-voice).

### Rubber Duck Debugger

If you're not familiar with "rubberducking", as you are not a developer or have never listened to a [CS50 course at Harvard](https://pll.harvard.edu/course/cs50-introduction-computer-science?delta=0), do yourself a favor and read [this article](https://en.wikipedia.org/wiki/Rubber_duck_debugging) on problem-solving. It will empower you!!

### Visual Studio Code

finally, if you need an editor, try Microsofts Visual Studio Code editor; it is free and has many extensions. This editor is your companion if you start with ALM for Power Platform and use GitHub.

I recommend you use the following:

* Microsofts [Power Platform Tools](https://marketplace.visualstudio.com/items?itemName=microsoft-IsvExpTools.powerplatform-vscode)
    
* Christopher Schleidens: [Github Actions](https://marketplace.visualstudio.com/items?itemName=cschleiden.vscode-github-actions)
    
* [CS50´s Duck Debugger](https://marketplace.visualstudio.com/items?itemName=CS50.ddb50)
    

## Build your first (voice-) bot and extend it

Having a new and "free" development environment, start to build and share :-).

As an inspiration on where to start, you could build something with these [kickstarters](https://the.cognitiveservices.ninja) and extend them to something valuable for your business.

## Conclusion

Starting with low-code development of (voice-) bots is straightforward with Power Virtual Agents, with no upfront investment. You can even extend your trials after the initial period if needed.