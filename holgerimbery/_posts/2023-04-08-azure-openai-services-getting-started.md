---
layout: post
title: "Azure OpenAI Services: Getting started."
date: 2023-04-08
author: admin
slug: azure-openai-services-getting-started
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-04-08-azure-openai-services-getting-started

---

This is a first article of a series on Azure OpenAI Services. This article describes how to start and brings you directly to [Azure OpenAI Service Studio](https://oai.azure.com/).

![Figure: OpenAI on Azure Studio]({{site.baseurl}}/images/clg7w9yjb0bizuonvaprjcpm3.md/ddcbe3b1-aa6c-44ac-a073-7c7ddb03ce6a.png)

Figure: Azure OpenAI Service Studio

## Background

OpenAI is an artificial intelligence research laboratory that develops general artificial intelligence (AI).

Azure OpenAI provides customers with a comprehensive, managed Artificial Intelligence (AI) service that enables developers and data scientists to access OpenAI’s powerful language models, such as GPT-3 and Codex. GPT-3 models are utilized to analyze and generate natural language, while Codex models are used to analyze and generate code with accompanying plain text code commentary.

To generate content, the models are based on an autoregressive architecture, which means they analyze past observations to anticipate the most probable next word; the process is repeated by adding the newly generated content to the original text to achieve the ultimate generated outcome. The models can be applied to various tasks as the input text influences the response, making it straightforward to switch functions by altering the input text. The GPT-3 models are pre-trained with an array of publicly available free text data, which is procured from a combination of web crawling (a filtered version of Common Crawl, which includes a broad range of text from the web, making up sixty percent of the weighted pre-training dataset) and higher-quality datasets, for example, an enhanced version of the WebText dataset, two internet-based books corpora, and English-language Wikipedia. The Codex models are trained with both natural language and billions of lines of public code from GitHub. As the models are exposed to a wide range of data and knowledge and their capacity to generate dynamic content, special attention should be given to guarantee responsible use in applications. Please refer to their research papers for further information regarding OpenAI’s GPT-3 and Codex training and modeling techniques.

Privacy is a second crucial factor to consider when using OpenAI. Azure OpenAI Services provides a secure environment for organizations to store and process data and offers additional security features such as encryption, authentication, and authorization. Azure OpenAI includes access control and data protection to ensure only authorized users can access the data. Furthermore, Azure OpenAI also provides data masking and anonymization to protect sensitive data from unauthorized access.

## Onboarding

### Request Access

Azure OpenAI Services are available via an application process when writing this article. You must ask for access to Azure OpenAI Services, and there are some prerequisites for you and your tenant to get authorized.

The quickest way to onboard is via [Azure OpenAI Services Studio](https://oai.azure.com).

* Log in to your tenant.
    
* Check access rights
    

![Figure: onboarding message]({{site.baseurl}}/images/clg7w9yjb0bizuonvaprjcpm3.md/224e7ea3-ff32-4d49-84cd-56851ac83c54.png)

Figure: onboarding message

* [Request Access](https://aka.ms/oai/access)
    

![Figure: application form]({{site.baseurl}}/images/clg7w9yjb0bizuonvaprjcpm3.md/25d5234a-b626-4bc7-a160-95114b380836.png)

Figure: application form

after your application, it could take some time to get your authorization.

### Creating a Ressource

After you receive your authorization, you can create a Ressource via Azure Market Place.

![Figure: Create Ressource]({{site.baseurl}}/images/clg7w9yjb0bizuonvaprjcpm3.md/37107b5c-2aee-4b3b-8028-07a70cacebd6.png)

Figure: Create Ressource

## First steps

After getting access and creating your Ressource, you can explore Azure OpenAI Services Studio.

* Create a new deployment.
    

![Figure: Create a new deployment]({{site.baseurl}}/images/clg7w9yjb0bizuonvaprjcpm3.md/8ae78ba3-e480-4bc8-a0d0-bcd1fc379f74.png)

Figure: Create a new deployment

* select DaVinci-003 as a start and create your deployment.
    
* after the creation, you can start with GPT-3 Playground
    

![Figure: door to playground]({{site.baseurl}}/images/clg7w9yjb0bizuonvaprjcpm3.md/06865a37-2ca7-498c-8d96-d96995b7e1d7.png)

Figure: door to the playground

Start with, e.g., parsing unstructured data

![Figure: First experiment]({{site.baseurl}}/images/clg7w9yjb0bizuonvaprjcpm3.md/1443911c-86a4-4517-a9a1-0a13e7bb594c.png)

Figure: First experiment

## Next steps

Within the following weeks, you will find in this blog a loose path of easy-to-follow experiments in this series.