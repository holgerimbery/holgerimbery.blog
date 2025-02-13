---
layout: post
title: Create Your ownGPT in a Protected Way and Advance Its Potential (Part 5) - Refine and enhance knowledge on your own data
date: 2023-10-07
author: admin
slug: create-your-owngpt-in-a-protected-way-and-advance-its-potential-part-5-refine-and-enhance-knowledge-on-your-own-data
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-10-07-create-your-owngpt-in-a-protected-way-and-advance-its-potential-part-5-refine-and-enhance-knowledge-on-your-own-data

---

 ***5\. part of a series  
 building the foundation -*** [***part 1***](https://the.cognitiveservices.ninja/create-your-owngpt-in-a-protected-way-and-advance-its-potential-part-2-incorporating-your-own-data-to-create-unique-experiences) ***&  
 adding your own data -*** [***part 2***](https://the.cognitiveservices.ninja/create-your-owngpt-in-a-protected-way-and-advance-its-potential-part-1-a-simple-web-chat-experience-targeting-chatgpt-through-aoai) ***&***  
 ***adding a chat history -*** [***part 3***](https://the.cognitiveservices.ninja/create-your-owngpt-in-a-protected-way-and-advance-its-potential-part-3-activate-chat-history-for-adding-a-more-convenient-way-to-work) ***&***  
 adding channels and ***taking actions on the results*** [***part 4***](https://the.cognitiveservices.ninja/create-your-owngpt-in-a-protected-way-and-advance-its-potential-part-4-adding-additional-channels-and-take-action-on-your-data)
 
 ***were published before.***

## Motivation

When working with your own data and your ownGPT, you can enhance the results and improve the user experience by taking a few small steps in data preparation.

## Prepare Data Locally

To prepare your data locally, follow the steps in this section. This method is suitable for small data sets.  
For much larger sets, use Azure machine learning

### Setup

To prepare your local machine, you need to install the necessary packages. You can find them in the requirements.txt file in the repository of part 1 of this series.

### Configuration

To create a config file, name it "config.json" and use the following format. The file should contain a list of JSON objects. Each object should have two keys: one for the local data path and another for the target search service and index.

```json
[
    {
        "data_path": "<local path or blob URL>",
        "location": "<azure region, e.g. 'westus2'>", 
        "subscription_id": "<subscription id>",
        "resource_group": "<resource group name>",
        "search_service_name": "<search service name to use or create>",
        "index_name": "<index name to use or create>",
        "chunk_size": 1024, // set to null to disable chunking before ingestion
        "token_overlap": 128 // number of tokens to overlap between chunks
        "semantic_config_name": "default",
        "language": "en" // setting to set language of your documents. Change if your documents are not in English. Look in data_preparation.py for SUPPORTED_LANGUAGE_CODES,
        "vector_config_name": "default" // used if adding vectors to index
    }
]
```

> Note:
> 
> `data_path` can be either a local path to files on your machine or an Azure Blob URL. An Azure Blob URL has the format `https://<storage account name>.`[`blob.core.windows.net/<container`](http://blob.core.windows.net/%3Ccontainer) `name>/<path>/`. If you use a blob URL, the data will be downloaded from Blob Storage to a temporary directory on your machine before the data preparation starts.

### Create Indexes and Ingest Data

> Disclaimer:
> 
> To avoid compromising the quality of the responses, please ensure that your data does not contain any duplicate pages.

* Run the data preparation script, passing in your config file. You can set njobs for parallel parsing of your files.
    
    `python data_preparation.py --config config.json --njobs=4`
    

## Use Azure Machine Learning to Prepare Data

### Setup

* Install the [Azure ML CLI v2](https://learn.microsoft.com/en-us/azure/machine-learning/concept-v2?view=azureml-api-2)
    

### Prerequisites

* Azure Machine Learning (AML) Workspace with associated Keyvault
    
* Azure Cognitive Search (ACS) resource
    
* (Optional if processing PDF) [Azure AI Document Intelligence](https://learn.microsoft.com/en-us/azure/ai-services/document-intelligence/overview?view=doc-intel-3.1.0) resource
    
* (Optional if adding embeddings for vector search) Azure OpenAI resource with Ada (text-embedding-ada-002) deployment
    
* (Optional) Azure Blob Storage account
    

## Configure

* Create secrets in the AML Keyvault for the Azure Cognitive Search resource admin key, Document Intelligence access key, and Azure OpenAI API key (if applicable).
    
* Create a configuration file, such as `aml_config.json`. The format can be a single JSON object or a list of JSON objects, with each object specifying a combination of Key Vault secrets, chunking settings, and index configurations.
    

```json
{
        "chunk_size": 1024,
        "token_overlap": 128,
        "keyvault_url": "https://<keyvault name>.vault.azure.net/",
        "document_intelligence_secret_name": "myDocIntelligenceKey",
        "document_intelligence_endpoint": "https://<document intelligence resource name>.cognitiveservices.azure.com/",
        "embedding_key_secret_name": "myAzureOpenAIKey",
        "embedding_endpoint": "https:/<azure openai resource name>.openai.azure.com/openai/deployments/<Ada deployment name>/embeddings?api-version=2023-06-01-preview",
        "index_name": "<new index name>",
        "search_service_name": "<search service name>",
        "search_key_secret_name": "mySearchServiceKey"
}
```

### Create an Azure Machine Learning Datastore.

If your data is stored in Azure Blob Storage, you can initially create an AML Datastore that will be utilized to connect to your data during the ingestion process. Update the `datastore.yml` file with your storage account information, including the account key. Afterward, execute the following command, incorporating the resource group and workspace name of your AML workspace:

```powershell
az ml datastore create --resource-group <workspace resource group> --workspace-name <workspace name> --file datastore.yml
```

### Submit the data processing pipeline job

In `pipeline.yml`, update the inputs to reference your config file name and the datastore you created. If you are using data stored locally, comment out the datastore path and uncomment the local path, updating it to point to your local data location. Afterward, submit the pipeline job to your AML workspace:

```powershell
az ml job create --resource-group <workspace resource group> --workspace-name <workspace name> --file pipeline.yml
```

## Convert PDFs to Text

If your data is in PDF format, you must convert it from PDF to .txt format. You can use your own script for this task or utilize the provided conversion code (see repository in part 1) here.

### Setup

* Create a [Form Recognizer](https://learn.microsoft.com/en-us/azure/applied-ai-services/form-recognizer/create-a-form-recognizer-resource?view=form-recog-3.0.0) resource in your subscription
    
* Ensure that you have the Form Recognizer SDK.
    
    `pip install azure-ai-formrecognizer`
    
* Run the following command to obtain an access key for your Form Recognizer resource.
    
    `az cognitiveservices account keys list --name "<form-rec-resource-name>" --resource-group "<resource-group-name>"`
    
    Copy one of the keys provided by this command.
    

### Create Indexes and Ingest Data from PDFs using Form Recognizer.

Provide your Form Recognizer resource name and key when executing the data preparation script:

```powershell
python data_preparation.py --config config.json --njobs=4 --form-rec-resource <form-rec-resource-name> --form-rec-key <form-rec-key>
```

By default, this will utilize the Form Recognizer Read model.

Consider using the Form Recognizer Layout model if your documents contain numerous tables and significant layout information. Although it is more expensive and slower to run, it preserves higher-quality table information. Additionally, the Layout model helps maintain formatting information in your document, such as titles and subheadings, making citations more readable. Pass in the argument to use the Layout model instead of the default Read model. `--form-rec-use-layout`.

```powershell
python data_preparation.py --config config.json --njobs=4 --form-rec-resource <form-rec-resource-name> --form-rec-key <form-rec-key> --form-rec-use-layout
```

## Conclusion

Refining and enhancing your ownGPT with your own data can significantly improve the user experience and the quality of generated responses. By preparing data locally or using Azure Machine Learning, you can efficiently process and index your data, incorporating additional features like PDF conversion and table recognition. This approach allows you to unlock the full potential of your ownGPT model, ultimately creating a more robust and personalized AI tool.
