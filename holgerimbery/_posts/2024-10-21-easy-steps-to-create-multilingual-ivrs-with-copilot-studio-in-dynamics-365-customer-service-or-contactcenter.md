---
layout: post
title: Easy Steps to Create Multilingual IVRs with Copilot Studio in Dynamics 365 Customer Service or ContactCenter
description: 
date: 2024-10-21
author: admin
image: ./images/easy-steps-to-create-multilingual-ivrs-with-copilot-studio-in-dynamics-365-customer-service-or-contactcenter.jpeg
tags: [copilotstudio, customerservice, dynamics365]
featured: false
toc: true

---

For effective multilingual customer service, it is essential to have voice Copilot custom agents that can operate in multiple languages, particularly when you want to offer customers the option to choose their preferred language on the phone. Although Copilot Studio does not currently support the creation of multilingual voice custom agents for Dynamics 365 Customer Service or Dynamics 365 Contact Center out of the box, there is a straightforward way to achieve the functionality of a multilingual IVR (Intelligent Voice Response System) using Copilot Studio.

Leveraging Copilot Studio's built-in capabilities, you can create a multilingual IVR system in under five minutes. This approach ensures your customers can seamlessly interact in their chosen language, enhancing their overall experience and satisfaction.

## Why do we need to do this

Copilot Studio cannot create bots in the voice channel using multiple languages.

![]({{site.baseurl}}/images/cm2iy07ml001y08me9sokaz7m.md/32feb528-28c0-4f03-ab15-ff2ed31e3fd1.png)

## How to create a multilingual IVR

You can create a bot for your Voice Channel in one language and utilize SSML tags to give it a multilingual appearance.

* Begin by establishing a Workstream as a concierge service in your primary language. Then, connect the Workstream to the phone number you wish to make available to your customers.
    
    ![]({{site.baseurl}}/images/cm2iy07ml001y08me9sokaz7m.md/d3921049-8b21-457a-81b5-48642e5140d2.png)
    
* Incorporate a multilingual voice into your Voice Profile for that particular Workstream.
    
* For your additional languages, create separate workstreams and assign them phone numbers not published to your customers.
    
* Create a Bot for your Concierge Workstream and modify the greeting System Topic.
    
* Add a Message Node as your IVR Text with SSML Tags to change the language.
    
    ![]({{site.baseurl}}/images/cm2iy07ml001y08me9sokaz7m.md/5c9f01f4-f20f-4528-8078-03862e019db9.png)
    
    ```xml
    <voice name="en-US-AvaMultilingualNeural">
    <lang xml:lang="en-US">Press 1 for English. </lang>
    <break strength="medium" />
    <lang xml:lang="fr-FR">Appuyez 2 pour le français .</lang>
    <break strength="medium" />
    <lang xml:lang="de-DE">Drücken Sie 3 für Deutsch. </lang>
    </voice>
    ```
    
* Choose the same multilingual voice selected in your concierge workstream's voice profile.
    
* Create a question node and a condition as described in the screenshots.
    
    ![]({{site.baseurl}}/images/cm2iy07ml001y08me9sokaz7m.md/dda57bab-6c53-43f1-8cab-693959cb68b8.png)
    

![]({{site.baseurl}}/images/cm2iy07ml001y08me9sokaz7m.md/d21f3930-c384-4375-a47a-574cdad1827c.png)

* Utilize the Transfer Conversation Node to forward calls for all languages other than your primary one to the "hidden" phone numbers associated with your workstreams in those languages. Do not forget to end the topic with an “End current topic” node.
    
    ![]({{site.baseurl}}/images/cm2iy07ml001y08me9sokaz7m.md/bc82bef8-49c5-4d0a-9cd3-5f526991e47d.png)
    
    Once saved and published, the final result should mirror the dialogue in the attachment, noting that sound is absent between seconds 18 and 20.
    

<p><iframe src="https://www.youtube.com/embed/ndv2lBOfBc4" loading="lazy" frameborder="0" allowfullscreen></iframe></p> 

    

## Conclusion

Creating a multilingual IVR system using Copilot Studio in Dynamics 365 Customer Service or Contact Center is a practical solution for businesses aiming to enhance customer satisfaction by offering services in multiple languages. Following the outlined steps, you can efficiently set up a system that allows customers to interact in their preferred language, improving their overall experience. This approach addresses the current limitations of Copilot Studio and demonstrates a commitment to providing inclusive and accessible customer service. As businesses expand globally, implementing such multilingual capabilities becomes increasingly important in maintaining competitive advantage and fostering positive customer relationships.