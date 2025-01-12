---
layout: post
title: "Azure OpenAI Services: Mastering the Art of Text Creation and Modification"
date: 2023-04-22
author: admin
slug: azure-openai-services-text-creation-and-modification
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-04-22-azure-openai-services-text-creation-and-modification

---

Learn how to generate or manipulate text using Azure OpenAI service. This powerful tool provides various models with an easy-to-use and efficient text-in, text-out interface. The model can accurately **cre**ate a completion that reflects the context or pattern provided by inputting a text prompt. Explore the capabilities of completions with [Azure OpenAI Studio's Playground](https://oai.azure.com/), and discover how to control the variance by adjusting the temperature setting. Follow the guidelines to create effective prompts for content creation, classification, and conversation tasks.

 If you missed it, how to get [onboarded to Azure OpenAi Service](https://the.cognitiveservices.ninja/azure-openai-services-getting-started) is the first article of this series.

To get started, try entering something simple, like:

`write a tagline for a new flower shop`

```plaintext
write a tagline for a new flower shop
"Bringing beauty to your life, one bloom at a time!"
```

The completion results may vary because the API is stochastic in its design. This means that when calling the API, the outcome could be slightly different each time, even if the prompt is the same. It is possible to control this potential variance by adjusting the temperature setting. This "text in, text out" interface allows the model to be "programmed" by providing instructions or just a few examples of the desired outcome. The task's complexity and the prompt's quality are likely to determine the model's success. Generally, it is advisable to consider how one would write a word problem for a middle school student when crafting a prompt. Providing sufficient information allows the model to identify what is desired and how it should respond.

## Basics

OpenAI's models are incredibly versatile, generating original stories, performing complex text analysis, and more. However, it is essential to be explicit when providing a prompt to the model, as it cannot read your mind and accurately interpret your desired output. Showing, rather than simply telling, is the key to providing an effective prompt. The model can more accurately identify the task and respond appropriately by providing an example prompt such as "Give me a list of cat breeds" and indicating the expected output. Failing to do so may lead to the model producing an outcome that does not fulfill the desired purpose, limiting its effectiveness in tasks such as content creation, classification, etc.

It is essential to adhere to three basic guidelines to create effective prompts.

**Show and tell**  
Give examples of what you mean. If you want the model to rank a list of items alphabetically, provide a few lists and ensure it understands what you are asking it to do. If you want the model to classify a paragraph by sentiment, give a few paragraphs and ensure it understands what it is being asked to do. This way, you can ensure that the model is adequately trained and has the best chance of achieving accurate results.

**Provide quality data**  
It is essential to ensure a sufficient number of examples available to build a successful classifier or model that will follow the intended pattern. Furthermore, it is necessary to carefully proofread all examples, as the model is usually sufficiently advanced to recognize typos or minor spelling mistakes and provide the appropriate response. However, the model might interpret such mistakes as intentional, influencing the answer.

**Check your settings**  
The temperature and top\_p parameters are fundamental features of a model that can be used to adjust the level of randomness in the generated response. Increasing the temperature value will tend to create more varied and unexpected responses while decreasing it will cause the model to be more deterministic and precise. Similarly, increasing the top\_p value will allow the model to consider more options when selecting a response. Decreasing it will cause the model to be more likely to choose the most obvious one. It is important to note that these features should not be used to measure the model's "cleverness" or "creativity" as this is not their intended purpose. Instead, these settings should be adjusted to achieve the desired level of randomness or precision in the model's generated responses.

## Classification

In the first experiment, we will utilize the API to create a text classifier that can accurately identify the sentiment of responses. We will need to provide the API with a description of the task and a few examples of the types of sentiments we would like the classifier to recognize. Once the classifier is trained, we can use it to assess the sentiment of any response confidently.

```plaintext
This is a feedback sentiment classifier
feedback: "Thank you for your service. I was a good experience".
Sentiment: Positive

feedback: "I´m totaly disappointed, nothing happened after calling you"
Sentiment: Negative

feedback: "it was 👍"
Sentiment: Positive

feedback: "everything was as expected"
Sentiment: Neutral

feedback: "After calling you, one of your staff solved me issue. everything is working now. Thank you"
Sentiment:
```

![Result of the experiment - feedback]({{site.baseurl}}/images/clgrwfyc005frlcnv7vmi89p6.md/fb1be3b4-e0c6-4cfb-aff8-73fbd6c36b36.png)

Figure: Result of the experiment - feedback  
It's worth paying attention to several features in this example:

* **Use plain language to describe your inputs and outputs.** We use simple language for the input "Feedback" and the expected output "Sentiment." For best practices, start with plain language descriptions. While you can often use shorthand or keys to indicate the input and output, when building your prompt, it's best to start by being as descriptive as possible and then working backward, removing extra words as long as the performance of the prompt is consistent.
    
* In this example, we provide multiple outcomes "Positive", "Negative" and "Neutral." A neutral result is significant because there will be many cases where a human would have difficulty determining if something is positive or negative and situations where it's neither. Show the API how to respond to any case.
    
* **You can use text and emojis.** The classifier is a mix of text and emoji 👍. The API reads emojis and can even convert expressions to and from them.
    
* **You need fewer examples for familiar tasks.** For this classifier, we only provided a handful of examples. This is because the API already understands sentiment and the concept of a tweet. If you're building a classifier for something the API might not be familiar with, it might be necessary to provide more examples.
    

## Generation

One of the API's most potent and effective capabilities is generating new ideas or versions of the input. Providing the API with a few story ideas can create additional thoughts in the form of business plans, character descriptions, and marketing slogans. We have seen it successfully generate such ideas with only a handful of initial examples.

```plaintext
Ideas involving chatbots and customer service
1. 24/7Chatbots are available 24 hours a day and serving always with the same quality
2.
```

![Result of Generation experiment]({{site.baseurl}}/images/clgrwfyc005frlcnv7vmi89p6.md/033da7d3-1b63-4b47-9457-bb773e5e7930.png)

Figure: Result of Generation experiment

In this example, we supplied the API with a brief description of the list and a model. We then asked the API to produce the second item in the list by inputting the number two.

Although this is a straightforward prompt, there are several details worth noting:

* **We explained the intent of the list**  
    It is essential to provide information that describes it upfront to ensure the API completes the list. This allows it to focus on listing items that fit the criteria rather than attempting to decipher the underlying pattern.
    
* **Our example sets the pattern for the rest of the list**  
    Due to the supplied one-sentence description, the API will try to adhere to the same style for the remaining items in the list. Making that configuration at the outset is necessary to get a more detailed response.
    
* **We prompt the API by adding an incomplete entry.**  
    When the API encounters the number 2. followed by a sudden interruption in the prompt, it attempts to interpret the context and determine what should come next. Considering the preceding example with number one and the initial title of the list, the most logical response is to continue adding items to the list.
    

## Conversation

The API is incredibly proficient in conversing with humans and itself. With minimal guidance, we have witnessed the API act as a customer service chatbot capable of responding to questions with accuracy and poise, as well as a witty conversationalist that can tell jokes and make puns. The secret to the API's success lies in providing instructions on how it should act **and** delivering relevant examples.

```plaintext
Herbert is a chatbot that reluctantly answers questions

###
User: How many pounds are in a kilogram?
Herbert: This again? There are 2.2 pounds in a kilogram. Please make a note of this.
###
User: What does HTML stand for?
Herbert: Was Bing too busy? Hypertext Markup Language. The T is for try to ask better questions in the future.
###
User: When did the first airplane fly?
Herbert: On December 17, 1903, Wilbur and Orville Wright made the first flights. I wish they'd come and take me away.
###
User: Who was the first man in space?
Herbert:
```

![Result of Conversation experiment]({{site.baseurl}}/images/clgrwfyc005frlcnv7vmi89p6.md/e01500e0-4048-45a5-bd7c-359a2ee28976.png)

Figure: Result of Conversation experiment

To create an amusing and helpful chatbot, we provide a few examples of questions and answers showing the API how to reply.

## Transformation

The following experiment illustrates the procedure for converting English to French using the API. We demonstrate how to effectively utilize the API to convert English words and phrases into their French equivalents.

```plaintext
English: I do not speak French.
French: Je ne parle pas français.
English: See you later!
French: À tout à l'heure!
English: Where is a good restaurant?
French: Où est un bon restaurant?
English: What rooms do you have available?
French: Quelles chambres avez-vous de disponible?
English:
```

This example works because the API already has a grasp of French, so there's no need to try to teach it this language. Instead, we need to provide enough examples that API understands it's converting from one language to another.

## Summarization

The API can identify the underlying meaning of the text and rephrase it into multiple different forms. As an example of its capabilities, the API can take a section of text and form an understandable explanation for young children. This serves to demonstrate the API's comprehensive knowledge of the language.

![Result of Summarization experiment]({{site.baseurl}}/images/clgrwfyc005frlcnv7vmi89p6.md/03b246a7-5f96-4523-a056-cf12d03e2a26.png)

Figure: Result of Summarization experiment

We enclosed the text to be summarized within three sets of quotation marks. It is essential to provide a concise explanation of our purpose and the intended audience of the summary, both before and after the text, to prevent the automatic summarization tool from producing results that stray too far from the original content.

## Completion

While all prompts result in completions, it can be helpful to think of text completion as its task in instances where you want the API to pick up where you left off. For example, if given this prompt, the API will continue thinking about vertical farming. You can lower the temperature setting to keep the API more focused on the intent of the prompt or increase it to let it go off on a tangent.

```plaintext
Vertical farming provides a novel solution for producing food locally, reducing transportation costs and
```

![Result of experiment Completion]({{site.baseurl}}/images/clgrwfyc005frlcnv7vmi89p6.md/181f4b42-7381-4306-8ae1-2e61e47743e7.png)

Figure: Result of experiment Completion

## Conclusion

In conclusion, the Azure OpenAI service is a powerful tool for generating and manipulating text. It provides various models with an easy-to-use and efficient text-in, text-out interface. To effectively use this service, following the guidelines for creating effective prompts and adjusting settings such as temperature and top\_p parameters to achieve the desired level of randomness or precision in the model's generated responses is recommended. The API's capabilities include classification, generation, conversation, transformation, summarization, and completion. With the proper instructions and examples, the API can accurately identify sentiment, generate new ideas, converse with humans, translate languages, summarize text, and complete prompts.

Within the following weeks, you will find in this blog a loose path of easy-to-follow experiments in this series.
