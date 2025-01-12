---
layout: post
title: The Chitchat of the other kind - ChatGPT in Power Virtual Agents
description: 
date: 2023-01-14
author: admin
image: ./images/archive.jpg
tags: [archive]
featured: false
toc: true

---



# The Chitchat of the other kind - ChatGPT in Power Virtual Agents

(By now) more weekend fun than a scenario to implement in a production environment.

## Motivation

While working with bots, you must consider two points,  
*how to present the answer* and  
*where does the answer come from?*  
With all articles you might have read in the last few days about openai´s ChatGPT, you could think - why not integrate this in my installation as a last line of defense to answer when my system is incapable of doing so - at least for chitchat.

This article demonstrates the "how". But do not forget to read the entire article and find some thoughts about the "why" in the conclusions.

## OpenAi

To use openai, you need to create an account with them at [www.openai.com](https://www.openai.com) and generate an API token.

After creating an account and adding some funds as pocket money,  
Click top right on your account and the on "View API Keys"

![Figure 1: Account Settings]({{site.baseurl}}/images/clcvull7h000e08lah4j09h1t.md/4664512c-840a-435f-ab83-0732928e4538.png)

Figure 1: Account Settings

Generate a new API Key

![Figure 2: Create new secret key]({{site.baseurl}}/images/clcvull7h000e08lah4j09h1t.md/dbc8f7fd-39a2-4d29-bf3b-ed431bc339f8.png)

Figure 2: Create new secret key

## Power Virtual Agent

### Activate the Fallback topic in Power Virtual Agent

Power Virtual Agent has a built-in topic that can be a hook to the outside world, the “Fallback” system topic.

To activate the “Fallback” system topic, go to Settings within the editing canvas (click on the cog symbol), then System fallback, and then “+Add”.

![Figure 3: activated fallback topic]({{site.baseurl}}/images/clcvull7h000e08lah4j09h1t.md/06a5384d-111f-4ce0-bd65-66f283725526.png)

Figure 3: activated fallback topic

### Edit the fallback topic

Create a message box with a meaningful message and a new action.

![Figure 4: Fallback topic with message and action node]({{site.baseurl}}/images/clcvull7h000e08lah4j09h1t.md/13c47fb9-fa50-4740-9884-aa51c3b1d875.png)

Figure 4: Fallback topic with message and action node

In Power Automate, create a new text-based variable, "UnrecognizedUserInput"

![Figure 5: text variable as input]({{site.baseurl}}/images/clcvull7h000e08lah4j09h1t.md/fb5dac90-8575-4757-900d-e3c03938f5e8.png)

Figure 5: text variable as input

and an HTTP Node.

 The syntax for openai is straightforward. We need to authenticate ourselves within the header and give the model, the question, the temperature, and max\_tokens as the body. \[[documentation](https://beta.openai.com/docs/api-reference/completions/create)\].  
 temperature: Higher values mean the model will take more risks. Try 0.9 for more creative applications, and 0 (argmax sampling) for ones with a well-defined answer.

![Figure 6: syntax sample]({{site.baseurl}}/images/clcvull7h000e08lah4j09h1t.md/d6d5e346-8c55-4adf-8595-a5aad0e05fa8.png)

Figure 6: syntax sample

I translated this to Power Automate; it will look like the following in the HTTP node.  
The token you created above goes directly behind Bearer in the header.

![Figure 7: complete HTTP Request]({{site.baseurl}}/images/clcvull7h000e08lah4j09h1t.md/806f894e-f4f6-4ae4-a7ff-7e67808a012d.png)

Figure 7: complete HTTP Request

As a next step, we create a String variable.

![Figure 8: Initialize a Variable]({{site.baseurl}}/images/clcvull7h000e08lah4j09h1t.md/d2165238-f8d9-4a39-9794-54987a13e3b8.png)

Figure 8: Initialize a Variable  
Create a "Parse JSON node" to analyze the Body of the answer we get from openai.

![Figure 9: Parse JSON]({{site.baseurl}}/images/clcvull7h000e08lah4j09h1t.md/7e4eca1c-ee81-4113-859f-122160a3994c.png)

Figure 9: Parse JSON  
You can use the following as a schema or generate it with the Body of the outcome of the previous step.

```json
{
    "type": "object",
    "properties": {
        "id": {
            "type": "string"
        },
        "object": {
            "type": "string"
        },
        "created": {
            "type": "integer"
        },
        "model": {
            "type": "string"
        },
        "choices": {
            "type": "array",
            "items": {
                "type": "object",
                "properties": {
                    "text": {
                        "type": "string"
                    },
                    "index": {
                        "type": "integer"
                    },
                    "logprobs": {},
                    "finish_reason": {
                        "type": "string"
                    }
                },
                "required": [
                    "text",
                    "index",
                    "logprobs",
                    "finish_reason"
                ]
            }
        }
    }
}
```

After this, we create an "Apply to each" node with a "Set variable"

and we close by creating an output value.

![Figure 10: Last step]({{site.baseurl}}/images/clcvull7h000e08lah4j09h1t.md/3c79006b-2a35-4681-aefd-7230e0d84ca6.png)

Figure 10: Last step

Back to Power Virtual Agent, we adjust the created action to the correct input and output values and create a new message box to speak/display the answer on openai.

![Figure 11: Completing Action Node]({{site.baseurl}}/images/clcvull7h000e08lah4j09h1t.md/4105f3df-e4a8-407c-a5b6-38e0e9843a62.png)

Figure 11: Completing Action Node

## Test the result

Let´s test the result within our configured channels as text chat or voice with Dynamics Customer Service 365 or AudioCodes VoiceAI.

![Figure 12: Output]({{site.baseurl}}/images/clcvull7h000e08lah4j09h1t.md/f6a4b736-6565-4b37-9073-305e505186c2.png)

Figure 12: Output

## Conclusion

ChatGPT gives us answers, most of the time correct answers, and the models are getting better and better.

Is there a downside? Why should we integrate it or why should we not to do so?

Do the user or us will "like" the answer or is it appropriate? Here we have no control; we do not own the model.

**If you check the logs of your bots, you will see questions asked by users you would not even expect in your darkest dreams.**

There are situations where a technically correct answer is not the answer you will give to your users when they are, e.g., in highly emotional situations.
