---
layout: post
title: Integrating AI Builder Prompts into a Copilot Studio Agent
description: Learn how to integrate AI Builder prompts into Microsoft Copilot Studio agents to enhance workflows and productivity.
date: 2025-04-14
author: admin
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/04/callum-hill-oamw52SCGi0-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@inkyhills?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Callum Hill</a> on <a href="https://unsplash.com/photos/person-in-black-leather-jacket-holding-brown-and-black-hiking-shoes-oamw52SCGi0?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
      
tags: [copilotstudio, aibuilder]
featured: true
toc: true
---

{: .note } 
**summry lede**: 
Integrating AI capabilities into business processes is becoming increasingly essential. 
Microsoft Copilot Studio offers a powerful platform for building intelligent agents to streamline workflows and enhance productivity. One key feature of Copilot Studio is the ability to integrate AI Builder prompts, which leverage natural language understanding and generative AI models to perform specific tasks. 
This article will guide you through integrating AI Builder prompts into a Copilot Studio agent.

## Introduction
AI Builder prompts are an advanced and versatile feature that empowers the creation of natural language-based actions, significantly enhancing the functionality and intelligence of your Copilot agents. These prompts are designed to be interpreted by cutting-edge AI models, enabling them to perform diverse tasks with remarkable precision and efficiency.

For example, AI Builder prompts can be utilized to:
- **Summarize lengthy text**: Condense extensive documents, emails, or reports into concise and relevant summaries, saving time and improving comprehension.
- **Extract critical information**: Identify and retrieve key details from unstructured data, such as customer inquiries, support tickets, or business documents, ensuring faster and more accurate responses.
- **Classify data into categories**: Automatically organize incoming data, such as emails, feedback, or survey responses, into predefined categories for better analysis and streamlined workflows.

By integrating AI Builder prompts into your Copilot Studio agent, you can unlock a new level of dynamism and intelligence. These prompts allow you to customize the agent's behavior to address specific business needs, ensuring it can handle complex workflows and deliver actionable insights. Whether your goal is to streamline operational processes, enhance decision-making, or improve customer interactions, AI Builder prompts provide a robust and adaptable solution.

Incorporating these prompts into your Copilot Studio agent expands its capabilities and ensures that it remains responsive and aligned with your organizational objectives. This integration enables you to create intelligent agents tailored to your unique requirements, driving productivity and delivering measurable value across your business operations.

## Steps to Incorporate AI Builder Prompts

### example sentiment analysis and response generation 
Our goal is to use Generative AI to draft a comprehensive and contextually appropriate response to the user based on the issue raised in a ticket, email, or other forms of communication. By leveraging the capabilities of AI Builder prompts, we aim to ensure that the response is accurate, empathetic, and aligned with the user's expectations.

The process involves analyzing the sentiment and content of the user's input to determine the appropriate tone and structure of the response. For instance, if the issue raised indicates dissatisfaction or a negative experience, the AI-generated response will include an apology and a clear acknowledgment of the problem. Additionally, it will inform the user that a ticket has been created and that the team is actively working to resolve the issue.

On the other hand, if the sentiment is positive or neutral, the response will focus on acknowledging the input professionally and courteously without unnecessarily apologizing. This ensures that the communication remains relevant and efficient while maintaining a positive user experience.

By integrating this approach into your Copilot Studio agent, you can automate the generation of high-quality responses that effectively address user concerns, reduce response times, and enhance overall customer satisfaction. This streamlines workflows and strengthens the relationship between your organization and its users.

### Steps to Integrate AI Builder Prompts
- Add another node with the (+) button in a given topic.

![upgit_20250414_1744628276.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/04/upgit_20250414_1744628276.png)

- After pressing the (+) button, the + changes to an X as shown. Choose Call an action and select Create a prompt.

![upgit_20250414_1744628331.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/04/upgit_20250414_1744628331.png)
You can do it manually or use the integrated copilot.

![upgit_20250414_1744629416.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/04/upgit_20250414_1744629416.png)
Do not forget to give the prompt a name.

example prompt
```
Add content
You are tasked with analyzing the sentiment of the provided input and generating an appropriate response. If the sentiment indicates a negative experience, include an apology and inform the user that a ticket has been created to address the issue.



### Instructions:

1. **Sentiment Analysis**: Evaluate the tone of the input to determine if it is positive, negative, or neutral.

2. **Response Generation**:

   - If the sentiment is negative, include an apology and mention that a ticket has been created to resolve the issue.

   - If the sentiment is positive or neutral, acknowledge the input appropriately without an apology.

3. **Ticket Notification**: Clearly state that a ticket has been created and that the team is working on resolving the issue if applicable.



### Output Format:

Your response should follow this structure:



#### Sentiment Analysis Result:

- **Sentiment**: [Positive/Negative/Neutral]



#### Response:

- [Appropriate response based on the sentiment]

- **Ticket Status**: A ticket has been created, and we are working on resolving the issue.


Provide your input for analysis here: Details
 ```


- Add an Input, called "Details". Press "Add Content" it will open the dialog shown below.
select "Text" and give the variable a name and an example value. 

![upgit_20250414_1744629649.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/04/upgit_20250414_1744629649.png)


- Test your prompt 

- Intigrate the prompt into the agent by defining the input and output.
![upgit_20250414_1744629760.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/04/upgit_20250414_1744629760.png)


## Other Use Cases

- **Summarizing Text**: Create a prompt action summarizing lengthy documents or emails, providing users with concise and relevant information.
- **Extracting Information**: Use prompts to extract key details from customer inquiries or support tickets, enabling faster and more accurate responses.
- **Classifying Data**: Implement prompts to categorize incoming data, such as emails or feedback, into predefined categories for better organization and analysis.

## Conclusion

Integrating AI Builder prompts into a Copilot Studio agent is a transformative step toward creating intelligent, responsive, and highly capable agents that align with your business objectives. By leveraging the power of natural language understanding and generative AI models, these prompts enable your agents to perform a wide range of tasks with precision and efficiency. Whether summarizing lengthy documents, extracting critical information, or classifying data into meaningful categories, AI Builder prompts provide the flexibility and adaptability needed to address diverse business challenges.

The integration process outlined in this article equips you with the knowledge and tools to seamlessly incorporate AI Builder prompts into your Copilot Studio agents. By following these steps, you can enhance your agents' functionality, ensuring they are capable of handling complex workflows and delivering actionable insights that drive productivity and innovation.

Moreover, this integration empowers your organization to stay ahead in a competitive landscape by automating repetitive tasks, improving decision-making processes, and fostering better customer interactions. The ability to customize prompts to meet specific business needs ensures that your agents remain aligned with your strategic goals, providing measurable value across various operations.

As AI continues to evolve, the potential applications of AI Builder prompts will only expand, offering new opportunities to optimize workflows and enhance user experiences. Adopting this technology today allows your organization to capitalize on these advancements, ensuring long-term success and adaptability in an ever-changing business environment. Start integrating AI Builder prompts into your Copilot Studio agents now and unlock the full potential of intelligent automation for your enterprise.

## Additional Information Sources

- **AI Builder Documentation**:  
   Access detailed guides and API references for AI Builder on the [AI Builder Documentation](https://learn.microsoft.com/ai-builder/).
