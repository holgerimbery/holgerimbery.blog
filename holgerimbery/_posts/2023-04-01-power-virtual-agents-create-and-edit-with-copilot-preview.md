---
layout: post
title: "Power Virtual Agents - Create and Edit with Copilot (preview)"
date: 2023-04-01
author: admin
slug: power-virtual-agents-create-and-edit-with-copilot-preview
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-04-01-power-virtual-agents-create-and-edit-with-copilot-preview

---

## Motivation

Imagine you are working on a Power Virtual Agents project and wish for an experienced colleague to consult with and receive guidance from. You are in luck, as the editing canvas will come with an integrated expert on Power Virtual Agents, still in preview but in the door. You will have access to deep knowledge and expertise, ensuring that you never find yourself at a loss. This incredible resource is readily available to help you take your bot project to the next level.  

## Introducing Copilot

You can easily create and modify bot topics with Power Virtual Agents copilot. Instead of using the traditional method, you can describe what you want and let the AI build it. The AI automatically understands your requirements and automatically creates a topic with different node types and conversational responses. This feature helps you save time and effort, as you don't have to manually create multiple topics before deploying your bot.  

 Hint!  
 Do not forget to check the [conversation booster](https://the.cognitiveservices.ninja/power-virtual-agents-gpt-based-conversation-booster-preview) feature, too.

 Caution!  
 Your bot must be created in the US region.  
 Other regions, and languages other than English, aren't supported during the preview.
 
 If you are unable to see this feature, check in Settings / General
 
 ![enable feature]({{site.baseurl}}/images/clfxvkv0c00020al7d0u85lmn.md/6f2df0b6-1fd5-4daa-a771-4a9f51a185cd.png)

## **Use copilot to create a topic**

When creating a new topic, you can utilize the "Create with Copilot" feature, asking the AI to generate it. You'll need to repeat this step for every topic you want, as you can't generate multiple topics within a single description.

* Select Topics
    
* Create a new Topic by selecting "+ New Topic" and "Create with Copilot"
    

![Create a new Topic]({{site.baseurl}}/images/clfxvkv0c00020al7d0u85lmn.md/58a19e56-95d6-473d-8ab3-0174301c6d59.png)

Figure: Create a new topic

![Create it with Copilot]({{site.baseurl}}/images/clfxvkv0c00020al7d0u85lmn.md/adee681a-6f49-4a77-9755-9220b556e9d5.png)

Figure: "Create it with Copilot"

### Example: outstandings

If you want to offer help to users with outstanding, ask the copilot to generate a topic for it.

```json
"Name your topic": outstandings
"Create a topic to": ask for name, customer number offer pay in instalments or all at once and connect then to an agent
```

The result is an excellent start to work with:

![AI generated dialogflow (1)]({{site.baseurl}}/images/clfxvkv0c00020al7d0u85lmn.md/0a4392ea-66f9-4377-ac74-835cd296d86b.png)

Figure: AI-generated dialog flow (1)

![AI generated dialogflow (2)]({{site.baseurl}}/images/clfxvkv0c00020al7d0u85lmn.md/a61310ed-a622-4e33-8545-f3361da5d6b0.png)

Figure: AI-generated dialog flow (2)

The result is as expected; we have the following:

* trigger phrases
    
* two open questions and a multiple-choice question with the correct variable types
    
* and an escalation node
    

The essential work is done; refinements can be done manually or with your copilot.

## **Use copilot to edit a topic**

To use copilot to edit an existing topic, select "Edit with Copilot"

![]({{site.baseurl}}/images/clfxvkv0c00020al7d0u85lmn.md/ea873cfb-a3f0-4970-ba3b-11fe14453a3d.png)

 Tip!  
 If you have selected any nodes on your canvas, your request will be limited to those nodes.  
 For instance, if you have selected a question node, you can simply write "add a speech response" instead of "add a speech response to the question node".  
 The nodes you have selected will be displayed next to the Update button.

![Edit with Copilot]({{site.baseurl}}/images/clfxvkv0c00020al7d0u85lmn.md/bc84ed52-97d0-4ab1-9902-fb78e8326a86.png)

Figure: Edit with Copilot

## Limitation

Copilot can create Message, Question, and Condition nodes during the preview when building and iterating on topics. Other node types during the preview aren't currently supported.  
Copilot understands the required properties on Message, Question, and Condition nodes, such as the text to use when prompting the user or generating appropriate output variables. However, the copilot doesn't understand all the more advanced properties that can be configured in these nodes, such as the re-prompt and interruption settings on a Question node.

## Conclusion

Of course, this is a preview, and you can't even publish the bot without having asked for an exception, but this feature shows what the future can look like in an imposing way, having a wingman of trust always at your side.
