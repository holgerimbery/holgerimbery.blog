---
layout: post
title: Create Your ownGPT in a Protected Way and Advance Its Potential (Part 2) - Incorporating your own data to create unique experiences
date: 2023-09-16
author: admin
slug: create-your-owngpt-in-a-protected-way-and-advance-its-potential-part-2-incorporating-your-own-data-to-create-unique-experiences
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-09-16-create-your-owngpt-in-a-protected-way-and-advance-its-potential-part-2-incorporating-your-own-data-to-create-unique-experiences

---

 second part of a series  
 [part 1](https://the.cognitiveservices.ninja/create-your-owngpt-in-a-protected-way-and-advance-its-potential-part-1) (the basics and installing the gui) of the series was publish a week earlier

## Motivation

In this second part of the series, we will learn how to customize our chatGPT clone with our own data using Azure OpenAI Service (AOAI) and some Azure services. We will use Azure Blob Storage to store our data, Azure Cognitive Search to index and query it, and Azure Search Index to fine-tune our GPT model. This way, we can make our chatbot more relevant and personalized for our users.

## Add your data the easy way

* Go to [Azure OpenAI Studio](https://oai.azuer.com), head over to the playground, and choose Chat
    
* Click on the Assistant Setups entry "Add your Data"
    
* Click on "Add a data source"
    

![]({{site.baseurl}}/images/clmllxvzo000009ml4w203zmh.md/308a5f73-92f1-45da-8253-c8ecb5d52359.png)

* Choose "Upload files" and follow the wizard to create an "Azure Blob Storage," an "Azure Cognitive Search Resource" with the ARM templates of the wizard.
    
* Enable CORS
    
* and assign a meaningful name to the search index.
    
* After acknowledging the information, click "Next."
    

![]({{site.baseurl}}/images/clmllxvzo000009ml4w203zmh.md/203241fb-4b76-4bc0-9654-3befe85bf843.png)

* Next, upload some test data to the blob storage to test the installation.
    

![]({{site.baseurl}}/images/clmllxvzo000009ml4w203zmh.md/77cad8c9-a308-45bc-b788-be3c92789279.png)

* After finishing the upload, everything will be created in the background, and the Assistant setup tells you to wait some minutes
    

![]({{site.baseurl}}/images/clmllxvzo000009ml4w203zmh.md/c763d8e1-5f90-4f30-b240-b3c530b8759c.png)

Once the wizard has completed its task, you'll see the created resource in the status window beneath the wizard. You can then restrict the response to your data and verify its functionality with a brief chat session.

![]({{site.baseurl}}/images/clmllxvzo000009ml4w203zmh.md/3668284a-a164-4434-86a2-5c8764cc540c.png)

## Add the resources to the ownGPT web interface

### Test it locally first

Update your .env file and add the following details:

![]({{site.baseurl}}/images/clmllxvzo000009ml4w203zmh.md/c1db43d6-d73a-460a-9390-5f8bd395baeb.png)

restart your ownGPT by executing ./start.cmd

and try it in your browser at https://127.0.0.1:5000

The result should look similar to the picture below

![]({{site.baseurl}}/images/clmllxvzo000009ml4w203zmh.md/65b185bd-6f5f-428c-94f4-dbfab681f2be.png)

### Update the config of the Web App

* go to Settings / Applications, and add the "AZURE\_Search\*" elements from before as application settings. Do not forget to restart the web app.
    

![]({{site.baseurl}}/images/clmllxvzo000009ml4w203zmh.md/39ebdf1a-14f4-432b-88e0-6daf841156a1.png)

* Test the web app in a private browser and see that your identity provider kicks in.
    
    ![]({{site.baseurl}}/images/clmllxvzo000009ml4w203zmh.md/eb4f0ec0-2e43-4c94-bcec-c91e2d795fa5.png)
    
* The test in the web chat should then give you the same result as testing the chat interface locally.
    

## Things you should consider

With this configuration, all information is visible to all of your authenticated users; you should now limit access to information by introducing "[document-level access control](https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/use-your-data#document-level-access-control)".

Another step will be to use semantic search instead of keyword search. I will cover this in a later article in this series.

## **What's next**

Within the following weeks, we will explore together the following elements of creating your "ownGPT"

* implementing chat history
    
* adding semantic search
    
* adding additional channels
    

## Conclusion

Incorporating your own data into your chatGPT clone using Azure OpenAI Service and other Azure services can enhance its relevance and personalization. By following the steps outlined in this article, you can easily add your data, test it locally, and update your web app configuration. Remember to consider document-level access control to ensure that sensitive information is only accessible to the appropriate users.
