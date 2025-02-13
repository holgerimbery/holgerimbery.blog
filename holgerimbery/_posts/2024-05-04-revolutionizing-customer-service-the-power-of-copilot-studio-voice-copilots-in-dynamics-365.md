---
layout: post
title: Revolutionizing Customer Service The Power of Copilot Studio Voice Copilots in Dynamics 365
description: 
date: 2024-05-04
author: admin
image: ./images/revolutionizing-customer-service-the-power-of-copilot-studio-voice-copilots-in-dynamics-365.jpeg
tags: [dynamics365, customerservice, voicebot]
toc: true

---


In today's fast-paced business world, delivering outstanding customer service is essential. Companies need efficient and effective solutions to handle customer inquiries, streamline processes, and improve user experiences. This is where Copilot Studio Voice Bots come into play. These intelligent voice bots are a cutting-edge addition to the Dynamics 365 suite. They utilize advanced natural language processing (NLP) and machine learning (ML) algorithms to interact smoothly with customers. Whether resolving common issues, automating routine tasks, or routing requests to the appropriate department, Copilot Studio Voice Bots help businesses offer personalized and efficient support. In this blog, we'll explore how these voice bots transform customer service within the Dynamics 365 ecosystem.

Conversational IVR bots are created to route customer calls to the right department, solve problems, gather information, and offer recommendations. Copilot Studio makes it easy to build IVR bots, which can also be used on other platforms like chat and voice.

Copilot Studio's voice bots offer several key features, including:

* The capability to customize voices within the Omnichannel for Customer Service framework.
    
* The integration of Boolean-type questions in Copilot Studio, designed to not prompt users with the standard "Options are Yes or No."
    
* The functionality that allows callers to interrupt bot messages at any point.
    

<details data-node-type="hn-details-summary"><summary>Hint</summary><div data-type="detailsContent">Microsoft Dynamics 365 still needs to have a bot in the classic flavor.</div></details>

## Create a classic bots

You need to create a classic bot to use it in Dynamics 365 Customer Service Omnichannel.

![]({{site.baseurl}}/images/clvrrpnz3000409la52j69nui.md/89cc2684-7aa7-4b24-b7aa-c8ee65b45eb4.png)

![]({{site.baseurl}}/images/clvrrpnz3000409la52j69nui.md/03001c35-f38d-479b-b47c-f24adac4b4cf.png)

![]({{site.baseurl}}/images/clvrrpnz3000409la52j69nui.md/ec1acbe2-6d57-4cf8-8a33-41061545d770.png)

## **Prerequisites**

For the Copilot Studio bot to function properly, the following prerequisites are necessary:

* The bot should be published, and the settings for Agent transfers must be configured to select Omnichannel.
    
* In the Omnichannel section of the Agent transfers settings, the Enable voice option must be activated.
    

## **Configure a bot for voice**

* In the Customer Service admin center, navigate to the workstream you set up for the voice channel. Then, in the **Bot section,** click **Add Bot**.
    
* Choose a bot from the Name dropdown menu in the Add Bot pane.
    
    ![]({{site.baseurl}}/images/clvrrpnz3000409la52j69nui.md/36321334-b52d-4e05-9342-ca0bf58aa470.png)
    
* Select **Save and close**. The bot is added to the workstream.
    
    ![]({{site.baseurl}}/images/clvrrpnz3000409la52j69nui.md/df23e4fd-d0d1-4f2a-9307-ddd879c0ed24.png)
    
    ![]({{site.baseurl}}/images/clvrrpnz3000409la52j69nui.md/b906290b-759d-4c27-aea5-f4b9a7ad8db0.png)
    

### **Configure handoff from Copilot Studio to Omnichannel for Customer Service**

* In Copilot Studio, open the bot that you've configured to integrate with Omnichannel for Customer Service.
    
* Go to **Manage** and select **Agent transfers**.
    
* In the **Agent transfers** section, select **Omnichannel**, and on the Omnichannel panel that appears, do the following:
    
    * Select **Enable**. One of the following messages will appear:
        
        * A message confirming that Omnichannel is enabled will be displayed at the top of the page.
            
        * If you're using Application Lifecycle Management (ALM), you might see the message: "We can't determine if omnichannel integration is enabled for the environment". For more information, see Bots with ALM.
            
    * Turn on the **Enable voice** toggle.
        
    * Select **See how to register a new Application ID**, and follow the instructions to register an application identifier.
        
        * Select **App Registration**.
            
        * Select **New registration**.
            
        * Enter the name of your bot, and then select **Register**.
            
        * ![]({{site.baseurl}}/images/clvrrpnz3000409la52j69nui.md/f6294a7f-fefb-418d-93a8-6180d0301abe.png)
            
            Copy the **Application ID** to the clipboard.
            
            ![]({{site.baseurl}}/images/clvrrpnz3000409la52j69nui.md/50d50e9f-8bb7-468f-8cd1-a2d0631221b1.png)
            
    * Navigate to Copilot Studio, insert the copied ID into the Application ID field, and then choose 'Add your bot'. Once the bot is added, a confirmation message will appear, and the bot will be listed.
        
    
    ![]({{site.baseurl}}/images/clvrrpnz3000409la52j69nui.md/85a520cf-8726-4529-adeb-4fd92919b3b0.png)
    
    To use details from Dynamics 365 Customer Service within the custom copilot, install the addon packages:  
    [  
    ](https://appsource.microsoft.com/en-us/product/dynamics-365/mscrm.omnichannelvoicepvaextension?tab=Overview)**Omnichannel Power Virtual Agent Extension:**[https://appsource.microsoft.com/product/dynamics-365/mscrm.omnichannelpvaextension  
    ](https://appsource.microsoft.com/en-us/product/dynamics-365/mscrm.omnichannelvoicepvaextension?tab=Overview)
    
* **Power Virtual Agents telephony extension:**[  
    https://appsource.microsoft.com/en-us/product/dynamics-365/mscrm.mspva\_telephony\_extension](https://appsource.microsoft.com/en-us/product/dynamics-365/mscrm.omnichannelvoicepvaextension?tab=Overview)
    
    [  
    ](https://appsource.microsoft.com/en-us/product/dynamics-365/mscrm.omnichannelvoicepvaextension?tab=Overview)**Omnichannel Voice Power Virtual Agent Extension:**
    
    https://appsource.microsoft.com/en-us/product/dynamics-365/mscrm.omnichannelvoicepvaextension?tab=Overview
    

## Example: personalized greeting

Using CallerID as an identifier, the system greets the caller with the name stored in the associated record in Dynamics.

![]({{site.baseurl}}/images/clvrrpnz3000409la52j69nui.md/be1a2e25-e073-4024-84cd-ce9a1eeeff49.png)

## Conclusion

Copilot Studio Voice Bots in Dynamics 365 are reshaping the customer service landscape by providing businesses with advanced tools to enhance interaction and efficiency. These bots simplify the management of customer inquiries through intelligent automation and improve the overall customer experience by offering personalized and timely responses. By leveraging the capabilities of Copilot Studio Voice Bots, companies can ensure they stay at the forefront of customer service technology, driving both satisfaction and loyalty. This integration signifies a significant step forward in utilizing AI to streamline and optimize customer service processes.