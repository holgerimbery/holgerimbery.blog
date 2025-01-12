---
layout: post
title: "Elevate Your Dynamics 365 Customer Service with the Voice Channel: A Simple Guide"
date: 2023-08-12
author: admin
slug: elevate-your-dynamics-365-customer-service-with-the-voice-channel-a-simple-guide
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-08-12-elevate-your-dynamics-365-customer-service-with-the-voice-channel-a-simple-guide
---

In Dynamics 365 Customer Service, representatives can use the voice channel to communicate with customers over the phone and resolve issues. Although chat, SMS messages, and social media have become popular channels for customers to seek support from organizations, phone calls remain a critical communication option. In Omnichannel for Customer Service, agents can receive and make public switched telephone network (PSTN) calls using a native calling experience in Dynamics 365. The voice channel also offers real-time AI-powered features such as live call transcription, sentiment analysis, and AI-based suggestions that help enhance agent productivity. Moreover, Omnichannel for Customer Service provides a broad range of analytics and insights, including AI-driven topic clustering and call insights.

## **Prerequisite**

You must have an active subscription to either Dynamics 365 Customer Service Voice Channel Add-on or Dynamics 365 Customer Service Digital Messaging and Voice Add-on.

## Install the voice channel

Follow the steps in the "[Set up Omnichannel for Customer Service](https://learn.microsoft.com/en-us/dynamics365/customer-service/omnichannel-provision-license#set-up-omnichannel)" guide.

In the **Voice** section, switch the "**Add voice**" toggle to "**Yes**" to enable the voice channel. Make sure to select the "**Voice and SMS Terms**" checkbox.

Save your changes and close the window.

## Connect using a new Azure Communication resource

Navigate to the Customer Service Admin Center in Dynamics 365 and follow these steps:

1. From the site map, select "Channels" in the "Customer Support" section.
    
2. Click on "Manage" for Phone numbers.
    
3. Select "Get started". The Connect to Azure Communication Services dialogue box will appear.
    
4. Choose "create new resource" and enter the necessary details:
    

* Azure subscription: Select a subscription from the dropdown list.
    
* Azure resource group: Select an existing resource group or create a new one with a unique name within your subscription.
    
* Resource name: Enter a name for the resource that contains only letters, numbers, and hyphens.
    

1. Click "Deploy" to create and deploy your new Azure resource connected to Azure Communication Services.
    

Once you have successfully created this new resource, you can use it to acquire phone numbers for your organization and enable call recording and SMS services or bring your carrier via direct routing. Your preferred option should be "bring your own carrier" if you are an enterprise customer.

## Configure Direct Routing

Connect your carrier via direct routing

* Open your Azure Communication Ressource in the Azure Portal and open "Direct Routing" under "Telefony and SMS"
    
* Open the dialogue "add domain" to add the Carrier / SBC Domain to the configuration and to verify it.
    

![]({{site.baseurl}}/images/cll7si5s4000m0aiiasahdhnq.md/523046d8-6ad1-41a8-9dcd-fbee2301b8f8.png)

When verified, go to the "Session Border Controllers" Tab

![]({{site.baseurl}}/images/cll7si5s4000m0aiiasahdhnq.md/72317cb2-ebda-4441-8f0e-32a3dc10e58a.png)

and add your carrier's SBCs

![]({{site.baseurl}}/images/cll7si5s4000m0aiiasahdhnq.md/b57b8e77-6a3f-46b2-97db-d86606d4b8a6.png)

Configure your Voice Routes according to your needs.

## Configure Phone numbers

In Dynamics 365, navigate to the Customer Service Admin Center and follow these steps:

1. In the site map, choose Channels under Customer Support.  
    The Channels page will appear.
    
2. Click Manage for Phone Numbers.
    
3. Select Advanced from the menu.
    
4. Choose Add Number for "bring your own number via Azure Direct Routing (preview)".
    

In the Add Your Own Phone Number dialogue, provide the following information:

* Phone Number: Enter the phone number you own and have configured in your SBC.
    
* Carrier: Specify the carrier to which the phone number belongs. You can create a new record if the carrier doesn't exist yet.
    
* Country/Region: Choose the country or region with which the phone number is associated.
    
* Number Type: Select whether it is a toll-free or local phone number.
    
* Calling Plans: Determine whether you can make or receive calls on the phone number.
    

> Please note that SMS is not supported with direct routing.

Select **Add number**.  
The new phone number will be displayed in the **Phone numbers** list and is ready for setup. You can now [connect it to a voice workstream](https://learn.microsoft.com/en-us/dynamics365/customer-service/voice-channel-inbound-calling), [configure outbound calling](https://learn.microsoft.com/en-us/dynamics365/customer-service/voice-channel-outbound-calling#configure-phone-numbers-for-outbound-calling), or [assign it to an agent](https://learn.microsoft.com/en-us/dynamics365/customer-service/voice-channel-outbound-calling#assign-personal-phone-numbers-to-agents).

## Conclusion

Implementing voice channels in Dynamics 365 Customer Service enhances communication with customers and boosts agent productivity. Following the steps outlined in this guide, you can easily set up and configure voice channels, connect with Azure Communication Services, and manage phone numbers for your organization. This integration allows you to leverage the power of AI-driven features and analytics to improve the customer support experience and streamline your operations.