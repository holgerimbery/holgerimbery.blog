---
layout: post
title: "Enhancing Customer Support with Dynamics 365 Copilot"
datePublished: Sat Jul 15 2023 07:18:21 GMT+0000 (Coordinated Universal Time)
date: 2023-07-15
slug: enhancing-customer-support-with-dynamics-365-copilot
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-07-15-enhancing-customer-support-with-dynamics-365-copilot

---

Copilot for Dynamics 365 Customer Service is an AI-powered tool designed to enhance the agent experience. By providing real-time, AI-driven assistance, agents can swiftly resolve issues, effectively manage cases, and automate routine tasks. This enables them to concentrate on delivering exceptional customer service and fostering genuine human-to-human interactions.

 Important
 
 The AI-generated content serves as a suggestion. It is your responsibility to review and edit the proposed material to ensure its accuracy and appropriateness before sharing the responses.

## **Prerequisites**

To use this preview, it must be enabled, and your tenant must be eligible.

## **Enable Copilot features**

Follow these steps to enable the Copilot features:

1\. In the Customer Service Admin Center, choose one of the following navigation options:

* Agent Experience &gt; Productivity &gt; Copilot Help Pane (preview)
    
* Operations &gt; Insights &gt; Copilot Help Pane (preview)
    

![]({{site.baseurl}}/images/clk3of002000p0al1gam0awij.md/c693c9f0-e5f8-4092-9eca-a7fadd66ba49.png)

*Figure: copilot help pane*

2\. Click "Manage" in the Copilot Help Pane (preview).

3\. Select the following options:

* **Make Copilot available to agents:** This displays the "Ask a Question" tab on the Copilot Help Pane (preview) when agents sign in.  
    Agents can ask questions conversationally, and the copilot answers the questions based on internal and external knowledge base sources and trusted domains.
    
* **For customer chat:** This displays the one-click response generation button on both the conversation panel for a conversation and on the "Ask a Question" tab on the Copilot Help Pane. Copilot understands the context and drafts the response based on the knowledge resources configured for your organization.
    
* **For email:** This displays the "Write an email" tab on the Copilot Help Pane (preview). Copilot assists agents in creating email responses based on the case context.
    

![]({{site.baseurl}}/images/clk3of002000p0al1gam0awij.md/be13a771-57f6-47b4-9316-675fd9c66981.png)

*Figure: enable features*

4\. Click Add Web Address in Web Resources to add trusted domains. You can add up to five trusted web domains for the copilot to search and generate responses. To limit the content you want Copilot to use, specify up to two levels, represented by a forward slash (/) after the .com part of the URL.

![knowledge sources]({{site.baseurl}}/images/clk3of002000p0al1gam0awij.md/d456b3db-513d-4b06-8c45-3737f14c0e46.png)

*Figure: knowledge sources*

## **Enable summarization of cases and conversations.**

Copilot-generated case and conversation summaries enhance agent collaboration and productivity in the following ways:

* **Case summaries** assist agents in comprehending the context of a case, allowing them to address customer concerns efficiently. Agents receive a brief case summary, including the case title, customer, case subject, product, priority, case type, and case description.
    
* **Conversation summaries** empower agents to collaborate effectively with other agents and contacts by enabling them to review an ongoing chat or a transcribed voice conversation quickly.
    

1. In the Customer Service Admin Center, choose one of the following navigation options:
    
    * Agent Experience &gt; Productivity &gt; Summaries (preview)
        
    * Operations &gt; Insights &gt; Summaries (preview)
        
    
    Next, click on "Manage" in Summaries (preview).
    
    ![summaries pane]({{site.baseurl}}/images/clk3of002000p0al1gam0awij.md/7188a353-7167-481f-acb6-a398bf9b1142.png)
    
    *Figure: summaries pane*
    
2. Finally, select "Make case summaries available to agents" to show a case summary on the Case page.
    
3. For the copilot to automatically trigger a conversation summary, select the following options:
    
    * **When an agent joins a conversation**: Generates a summary when an agent enters the conversation. This applies to transferred conversations or when an agent invites a collaborator to join the conversation.
        
    * **When a conversation ends**: Generates a summary when the conversation ends.
        
        * Select **Allow Agents to Create a Case with a button in the summary** to allow agents to see the **Create Case** button in the conversation summary. A new case is created when the agent selects **Create case**.
            
    * **On-demand, by selecting a button to summarize the conversation**: Generate a summary at any point in the conversation whenever the agent chooses the copilot. **Summarize the conversation**.
        

![enable features]({{site.baseurl}}/images/clk3of002000p0al1gam0awij.md/6cde828d-aa37-4f33-b4c2-6a3093bd2fe5.png)

*Figure: enable features*

Perform the [Display case summary steps on custom case forms](https://learn.microsoft.com/en-us/dynamics365/customer-service/copilot-powerapps-settings) for the Copilot case summary to be displayed on customized case forms.

## **Ask a question**

When you sign in to any of the Customer Service agent apps, copilot becomes activated on the right pane with the **Ask a Question** tab in focus. Copilot acts as your partner that can help answer questions without you having to search knowledge sources or other articles for information.

![]({{site.baseurl}}/images/clk3of002000p0al1gam0awij.md/22c3ac5c-dfe0-4ee7-841e-922387ad7916.png)

You can ask free-form questions as you would ask a colleague or supervisor who might know the answers.

![]({{site.baseurl}}/images/clk3of002000p0al1gam0awij.md/f65688f6-dd80-44eb-adad-b6177ddcb41e.png)

![]({{site.baseurl}}/images/clk3of002000p0al1gam0awij.md/77edf9f2-f6c8-4aa1-b4bd-63f4c1049988.png)

With copilot, you can perform the following actions:

* **Ask a direct question**: Copilot displays the pertinent response from the wealth of knowledge sources set up by your organization.
    
* **Ask follow-up turn-by-turn questions**: If the copilot doesn't provide the correct answer right away, you can engage in a conversation and guide the copilot to deliver the accurate response in a natural, conversational manner.
    
* **Ask the copilot for a better response**: Copilot can also rephrase answers based on additional guidance. For example, you can ask, "Can you summarize your response?" or "Can you provide a detailed explanation for each of the steps you mentioned?"
    

If you are satisfied with the copilot's response, use it in whole or in part to address the customer's inquiry.

* **Manually copy** the portions of the copilot's response that you find helpful into your chat or read them aloud during a voice conversation. You can also select the copy icon to copy the content to your clipboard directly.
    
* To respond to the customer, use the "Send to Customer" option, which is available during an active digital messaging conversation. When you select "Send to Customer," an editing window will open, allowing you to modify the response provided by the copilot before sending it directly to the customer. You can also adjust customer keywords, which will help the copilot generate a more accurate response.
    
* **Select "Check Sources"** to view the pertinent knowledge or website links that Copilot has used to generate the response. You can utilize this additional information as a resource or share it with the customer.
    

## **Summarize conversations**

Copilot conversation summaries efficiently offer context and convey the actions you have already undertaken to resolve the problem. You can summarize both chat and transcribed voice interactions.

Based on the triggers enabled by your administrator, the Copilot conversation summary is generated as follows:

* Automatically when you request a consultation with another agent, transfer the conversation, or end the conversation.
    
* When you select "Summarize conversation" on the ongoing dialog.
    
* ![Summary]({{site.baseurl}}/images/clk3of002000p0al1gam0awij.md/b4b44b06-88b1-4c51-9721-199d3fc23771.png)
    

*Figure: Summary*

You can also carry out the following actions:

* Copy the summary.
    
* Select "Create case." The application will create a new case and populate the description with the summary. This option is only available if your administrator has enabled this feature.
    
* Share feedback about the summary.
    
* Close the summary card.
    

## Conclusion

Dynamics 365 Copilot enhances customer support by providing AI-powered assistance to agents, enabling them to resolve issues quickly, collaborate effectively, and automate mundane tasks. By leveraging the copilot's features, agents can focus on delivering exceptional service and fostering meaningful human-to-human interactions.
