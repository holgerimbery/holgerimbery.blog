---
layout: post
title: "Dynamics 365 Customer service - always an answer to every question"
date: 2023-03-18
author: admin
slug: dynamics-365-customer-service-always-an-answer-to-every-question
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-03-18-dynamics-365-customer-service-always-an-answer-to-every-question
---

## Motivation

Envision every agent provide your customer with precise and compliant answers to their inquiries that are in line with your corporate policies. To facilitate this, we can implement a knowledge base with frequent questions and answers. This is just the initial step; customers will still need to wait for an available agent to resolve their query, even if a knowledgebase article has already answered it. To maximize efficiency, why not replace the human agent with a (voice-) bot and free up the human agent to focus on complex queries that require a human touch? Always provide a route to a human agent if any unexpected issues arise.

## Create Knowledgebase Articles

Use the Dynamics 365 Customer Service function Knowledge base to create articles for frequent customer queries and translate them (automatized) to every language you serve your customers in.

## Enable your (voice-) bots to use the Knowledgebase

Use a topic to access the Knowledgebase, e.g., the fallback topic, and create a new action.

![Figure: New action to search the Knowledgebase]({{site.baseurl}}/images/clfdy68r702hvr3nv1z11hmvh.md/806cd43a-562c-48e1-b77d-1d1922885508.png)

Figure: New action to search the Knowledgebase

You will find a template called "**Search Dynamics 365 knowledge article flow,"** which we can use and modify when you have installed the [Dynamics 365 Customer Service extensions for Power Virtual Agents](https://the.cognitiveservices.ninja/dynamics-365-customer-service-with-power-virtual-agents-part-1-automation-with-text-chat#heading-setting-up-omnichannel-for-customer-service).

* Select this template, create a copy, and make the needed connections to use the "Dataverse" and the "Content Conversion" Connector.

The flow itself is self-explaining and ready to use for text-based chatbots but will not give a good voice channel experience; this is the reason for creating a copy of it.

* Open the flow with edit and search for "Process each article in search result"

* Open it and jump to "Append title to article text result"

![Figure: Find "Append title to article text result"]({{site.baseurl}}/images/clfdy68r702hvr3nv1z11hmvh.md/7c62c896-3f8e-44dc-be49-5dc5a343460c.png)

Figure: Find "Append title to article text result"

* remove everything but the variable "title"

* This will remove some nice formatting and a markdown based on "heading 2" which we cannot use in the voice channel.

![Figure: Edit "Append title to article text result"]({{site.baseurl}}/images/clfdy68r702hvr3nv1z11hmvh.md/b5087a3c-7ea8-4a4b-87a3-22da7fdf1b9c.png)

Figure: Edit "Append title to article text result"

* save the result and update the call an action node in your Power Virtual Agents topic.

* Place the filter string in into the input part, "statecode eq 3" will give only published articles back

* You will find three new variables to textResult, jsonResult, and articleCount as the output of the called Power Automate Flow.

* e.g., place textResult in a message node to read the search result to the caller in the voice channel.

Do not forget to end the new topic with a redirect to EndofConversation.

## Troubleshooting

If the Power Automate flow ends in a dead end, check if Dataverse search is enabled.

* Goto [Power Platform admin center](https://admin.powerplatform.microsoft.com/)

* Select your environment.

* Goto Setting

* Select features and check "Search"

![Figure: Dataverse Search]({{site.baseurl}}/images/clfdy68r702hvr3nv1z11hmvh.md/ac65a50b-983a-4b9a-938a-fde5fa71311a.png)

Figure: Dataverse Search

## Conclusion

having knowledge base articles about solving customers' queries is a first step. Still, by making them accessible for a (voice-) bot in front of your contact center, you reduce the customer's waiting time on the phone or in the chat and take the load from agents answering frequently asked questions. You can make more with less!
