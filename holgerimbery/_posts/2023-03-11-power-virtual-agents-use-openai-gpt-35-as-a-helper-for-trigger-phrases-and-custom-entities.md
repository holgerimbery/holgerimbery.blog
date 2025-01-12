---
layout: post
title: "Power Virtual Agents: Use OpenAI GPT-3.5 as a helper for trigger phrases and custom entities"
date: 2023-03-11
author: admin
slug: power-virtual-agents-use-openai-gpt-35-as-a-helper-for-trigger-phrases-and-custom-entities
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-03-11-power-virtual-agents-use-openai-gpt-35-as-a-helper-for-trigger-phrases-and-custom-entities

---

## Motivation

When giving a "Power Virtual Agents in a Day" workshop, we start by creating topics and custom entities with the participants. While we are defining trigger phrases and synonyms for the closed lists in the custom entities, we often get asked the same question: "How can we find enough variations to help our bot?" Fortunately, there is a satisfactory answer to this: supporting the model behind the NLU in Power Virtual Agents with another model - text-davinci-003 from OpenAI.

## Background

Trigger phrases in Power Virtual Agents are words or phrases that can be used to initiate a conversation with a bot. They can be used to start a new conversation, ask specific questions, or provide instructions to the bot. Trigger phrases are defined in the bot's topic. They are usually set up as a list of keywords that the bot will recognize and respond to. Natural language understanding helps identify a topic based on meaning and not exact words. To start learning, the bot needs 5-10 short trigger phrases.

Custom entities in Power Virtual Agents are user-defined information about a conversation topic. They allow the bot to understand user input that may not be easily recognized by the Natural Language Processing (NLP) engine. For example, a custom entity can identify a company name, product name, or any other data type unique to the conversation. To use custom entities, you can create them in the Power Virtual Agents authoring canvas. Once created, they can be added to topics as variables to capture user input that matches the entity. This input can then be used to create more powerful conversations.

## Start with OpenAI

Signup for OpenAI Playground and start exploring.

## Use OpenAI Playground to get Synonyms

e.g., if you need synonyms for personal transport vehicles, ask for them.

![Figure: Ask for synonyms]({{site.baseurl}}/images/clf3wyx2b000e08mpapv40pvj.md/69650784-420f-453b-b75f-746a24ec2dec.png)

Figure: Ask for synonyms

* use Mode: Complete

* use Model: text-davinci-003

If you are more of a python type person, use this as a start:

```python
import os
import openai

openai.api_key = os.getenv("OPENAI_API_KEY")

response = openai.Completion.create(
  model="text-davinci-003",
  prompt="give me each 5 synonyms for a motorcycle and a car",
  temperature=0.7,
  max_tokens=2044,
  top_p=1,
  frequency_penalty=0,
  presence_penalty=0
)
```

If you are more of a node.js person, this starter is for you:

```javascript
const { Configuration, OpenAIApi } = require("openai")
const configuration = new Configuration({ 
        apiKey: process.env.OPENAI_API_KEY, 
}); 
const openai = new OpenAIApi(configuration);
const response = await openai.createCompletion({ 
 model: "text-davinci-003",
 prompt: "give me each 5 synonyms for a motorcycle and a car",
 temperature: 0.7, 
 max_tokens: 2044, 
 top_p: 1, 
 frequency_penalty: 0, 
 presence_penalty: 0, 
});
```

## Use OpenAI to generate trigger phrases

e.g., you create a topic for giving your customers a precise answer to the question, where can I park my car?

Why not combine a custom entity for the vehicles with a fine list of trigger phrases?  
Use the same method and model as above.

![Figure: Ask for trigger phrases]({{site.baseurl}}/images/clf3wyx2b000e08mpapv40pvj.md/603757d2-3f2c-4210-8e62-494fc9c10a1a.png)

Figure: Ask for trigger phrases

Python and Node.js are equivalent to the example above.

## Bonus: yes and no

If you are in voice bots like me, why not create a new confirmation custom entity for yes and no's - and use it instead of Boolean?

Your bot will never fail again:

```plaintext
give me 20 ways to say yes as a array

["Yes", "Absolutely", "Sure", "Of course", "Definitely", "Agreed", "Indeed", "Indeed!", "Yep", "Yup", "Aye", "Indeed yes", "Yeah", "Yah", "Verily", "Yea", "By all means", "Affirmative", "All right", "Sure thing", "You bet"]

give me 20 ways to say no as a array

["No", "Nope", "No way", "Negative", "Not a chance", "Nah", "No can do", "No thank you", "My answer is no", "No sir", "No ma'am", "No sirree", "I'm afraid not", "Absolutely not", "Uh uh", "No thanks", "I don't think so", "Not now", "Not ever", "Nyet"]
```

## Conclusion

Let the machine work for you, do not focus on the simple tasks a machine can do for you. Start exploring the capabilities of OpenAI and make your life easier.
