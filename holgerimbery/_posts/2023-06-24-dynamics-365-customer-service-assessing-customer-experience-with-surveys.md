---
layout: post
title: "Dynamics 365 Customer Service: Assessing Customer Experience with Surveys"
date: 2023-06-24
author: admin
slug: dynamics-365-customer-service-assessing-customer-experience-with-surveys
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-06-24-dynamics-365-customer-service-assessing-customer-experience-with-surveys
---

## Motivation

A pre-survey and a post-survey in a customer service scenario can provide valuable information about the customer's expectations before and after interacting with the service provider. The pre-survey can help identify any potential issues or concerns that the customer may have, allowing the service provider to prepare accordingly and address those concerns during their interaction. The post-survey provides feedback on how well those concerns were addressed and overall satisfaction with the service. This feedback can improve future interactions with customers, ensuring that their needs are met and their experience is positive.

## Configure a pre-conversation survey

To configure a pre-conversation survey for the chat channel, follow these steps:

1. In the site map, navigate to Workstreams under Customer Support.
    
2. Select the workstream for the chat channel that requires configuration.
    
3. Click Edit on the page that appears.
    
4. On the Chat channel settings dialog box, locate and activate (On) the Pre-conversation survey toggle in the Behaviors tab.
    
5. In the Survey questions area, select Add and enter the details of each question:
    
    Survey question name (for internal use), Question text (less than or equal to 512 characters), Answer type as Single line, Multiple lines, or Option set with options separated by semicolon or User consent with a link to a webpage in \[link text\](link to webpage) format; you can also set the Required toggle to Yes if the response is mandatory.
    

Following these instructions, you can easily create a pre-conversation survey that users will be prompted with when accessing your chat channel widget.

![activating and configuring pre-conversation survey]({{site.baseurl}}/images/clj9x6jzi0qzy4jnv8xoxde8e.md/fcf0a5d0-86c5-4b39-a71a-35fac98e56f2.png)

Figure: activating and configuring pre-conversation survey

![Result]({{site.baseurl}}/images/clj9x6jzi0qzy4jnv8xoxde8e.md/a478ca59-c2fd-40ff-b8f6-27b0b6fad58d.png)

Figure: Result

## **Configure a post-conversation survey**

The post-conversation survey utilizes Dynamics 365 Customer Voice to create surveys. Ensure you have permission to complete surveys in Dynamics 365 Customer Voice within the same organization as Omnichannel for Customer Service and that you have done the necessary survey. Your survey will be displayed as an option for linking to the conversation.

See [documentation](https://learn.microsoft.com/en-us/dynamics365/customer-service/configure-post-conversation-survey?tabs=customerserviceadmincenter) for details.

![activating and configuring post-conversation survey]({{site.baseurl}}/images/clj9x6jzi0qzy4jnv8xoxde8e.md/652bbe77-7fc1-4caf-b058-8851a2e14ed3.png)

Figure: activating and configuring post-conversation survey

![Result]({{site.baseurl}}/images/clj9x6jzi0qzy4jnv8xoxde8e.md/56848d36-94af-4a73-a20a-06a6e730aaa3.png)

Figure: Result

If the post-conversation survey is enabled for a conversation, the pre-designed survey is shared with the customer once the conversation concludes. This survey allows you to monitor customer feedback regarding the service provided. A conversation can be considered closed when one of the following scenarios occurs:

* The agent completes the chat conversation.
    
* The customer completes the chat conversation.
    
* The system shuts the chat conversation after a predefined time.
    

For live chat conversations, customers can receive survey questions within the same conversation or via a link that directs them to an external site. For SMS and social channels, a survey link is provided.

## Conclusion

Integrating pre- and post-conversation surveys in Dynamics 365 Customer Service provides valuable insights into customer expectations and experiences. This feedback helps improve service quality and ensures a positive customer experience, ultimately enhancing customer satisfaction and loyalty.