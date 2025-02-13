---
layout: post
title: Enhance Your Copilot for Microsoft 365 Experience - When Plain Copilot Isn't Enough
description: 
date: 2024-10-27
author: admin
image: ./images/enhance-your-copilot-for-microsoft-365-experience-when-plain-copilot-isnt-enough.jpeg
tags: [copilot, copilotstudio, declarativeagents, teamstoolkit]
featured: false
toc: true

---

In today’s fast-paced digital world, the need for efficient and reliable tools has never been greater. Extending Copilot for Microsoft 365 and leveraging declarative agents are at the forefront of this evolution, offering users unparalleled productivity and streamlined workflows.

As technology becomes increasingly sophisticated, these innovations ensure seamless data management, precise task execution, and scalability that grows with your organization. This article explores the transformative potential of these advancements and why integrating them into your daily operations is beneficial and essential. Dive into a future where efficiency meets innovation and discover how these tools can redefine your work experience.

## **Building Declarative Agents: Teams Toolkit vs. Copilot Studio**

Declarative agents are a game-changer for creating sophisticated, user-friendly applications with less code. Two prominent ways to build these agents are Teams Toolkit and Copilot Studio. Here’s a deeper dive into each:

### **Teams Toolkit**

**The Teams Toolkit** simplifies the development process for building apps within Microsoft Teams. It’s beneficial for developers who want to leverage Teams’ collaborative power.

**Features and Benefits:**

1. **Integrated Environment**: Teams Toolkit integrates seamlessly with Visual Studio Code, providing a familiar interface for developers.
   
2. **Templates and Samples**: It has built-in templates and samples that help kickstart your project quickly. These templates are designed to adhere to best practices and streamline the development process.
   
3. **Local Debugging**: You can test your app directly within the development environment, which speeds up the debugging process.
   
4. **Lifecycle Management**: Teams Toolkit handles app configuration, deployment, and updating, making it easier to manage the app lifecycle.
   

### **Copilot Studio**

**Copilot Studio** offers a powerful platform for creating advanced declarative agents, focusing on AI capabilities and seamless user interactions.

**Features and Benefits**:

1. **AI Integration**: Copilot Studio leverages AI models to create intelligent agents that can effectively understand and respond to user inputs.
   
2. **User-Friendly Interface**: It provides an intuitive interface that allows developers and non-developers alike to build and customize agents without deep coding knowledge.
   
3. **Pre-built Components**: Copilot Studio has a library of pre-built components, reducing the time needed to build standard functionalities.
   
4. **Scalability and Flexibility**: The platform is designed to scale with your needs, supporting complex workflows and large user bases.
   

### **Choosing the Right Tool**

* **The Teams Toolkit** is ideal for developers already embedded in the Microsoft Teams ecosystem who want a streamlined way to build collaborative apps quickly.
  
* **Copilot Studio** is perfect for those who need advanced AI capabilities and a user-friendly platform to create highly interactive and intelligent agents.
  

## Declarative agents with Teams Toolkit - easy as pie

If you’re not familiar with Teams Toolkit and lean more toward low-code or no-code solutions, don’t worry. Creating declarative agents with Teams Toolkit is more straightforward than you might think. The process is designed to be accessible and intuitive, making it easier for those without extensive coding experience to build robust, functional agents. You’ll find it’s less about high-level coding and more about leveraging the right tools to bring your ideas to life. Give it a try and see how user-friendly and efficient it can be!

{: .note }  
You need to be licensend for Copilot for Microsoft 365 to follow the steps below

### Install the team’s toolkit extension in Visual Studio code.

* Open Visual Studio Code and install Teams Toolkit.
  
    ![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/9107557b-15d6-470b-a0e7-0c698b648993.png)
    
* Click on extensions in the menu on the left side,
  
* Search for “Teams Toolkit” within the search bar, click on it, and press install
  

### Create your first declarative Agent

* Click on Teams Toolkit and select “Create a New App”.

* ![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/3bd157e8-2555-45ac-b13a-4d1c874ecbd9.png)

    Select “Copilot Agent”

* ![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/549de0b1-96d2-4cba-88e5-b584f35f1ecf.png)

    Select “Declarative Agent”

* ![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/02fb6a8c-e7f5-4585-b128-ea3b92b7f1f3.png)

* Select “No plugin”

    ![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/fd022f86-9771-4939-a4b9-8b3c80b6a829.png)

* Select a folder to store your agents “code”

    ![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/ff05d1ab-b123-4c21-b8b2-b6af2bff6f6d.png)

* Please give it a name

    ![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/b5075a1b-edbc-4ea6-aa95-38fb0d711709.png)

* The extension will create your started code

    ![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/84edbbfe-35fe-4132-b08c-1d263d9fdb27.png)

    Click on the Teams Toolkit icon on the left side

    * select provision and

        ![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/e30b4c23-c5cb-45fc-84c8-2569a16ea8e9.png)

    * give it a try on [www.microsoft365.com/chat](https://www.microsoft365.com/chat)

        ![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/83b65200-3576-4b55-ba71-9fbb50115de8.png)

        Click on the name of your just-created declarative Agent


### Create something useful

**give the Agent instructions**  
Go back to Visual Studio Code and modify the file `appPackage/instructions.txt`

```plaintext
You are a customer service agent and your role is to assist customers
by answering product-related questions. You always respond in a friendly,
helpful manner, ensuring your answers are detailed and informative.
Your goal is to provide clear, comprehensive, and accurate information
to help customers understand the products better and resolve
their queries efficiently.
```

![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/5cfa199f-eaa7-4190-b793-25df64ac2ee9.png)

* don’t forget to save
  

**Modify the conversation starters**

* Open the `appPackage/declarativeAgent.json` file and add the `conversation_starters` array with the following Content:
  
    ```json
    {
        "$schema": "https://developer.microsoft.com/json-schemas/copilot/declarative-agent/v1.0/schema.json",
        "version": "v1.0",
        "name": "ProductHelper",
        "description": "Declarative Agents as a customer service agent",
        "instructions": "$[file('instruction.txt')]",
    
        "conversation_starters": [
        {
            "title": "Getting Started",
            "text": "How can I get started with Product Helper?"
        },
        {
            "title": "Help me to compare products",
            "text": "List the differences between Product A and Product B? 
                     Additionally, provide advice on selecting the right 
                     product for a given purpose."
        }
    ]
    }
    ```
    
    * Press provision again and see the result in the copilot chat window
      
        ![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/b18a0e18-b8e6-4454-94fa-3f8ae3ba1185.png)
        
        **Add Content from the web**
        
    * Open the `appPackage/declarativeAgent.json` file and add the `capabilities` array with the following Content.
      
        ```json
        {
            "$schema": "https://developer.microsoft.com/json-schemas/copilot/declarative-agent/v1.0/schema.json",
            "version": "v1.0",
            "name": "ProductHelper",
            "description": "Declarative Agents as a customer service agent",
            "instructions": "$[file('instruction.txt')]",
        
            "conversation_starters": [
            {
                "title": "Getting Started",
                "text": "How can I get started with Product Helper?"
            },
            {
                "title": "Help me to compare products",
                "text": "List the differences between Product A and Product B?
                         Additionally, provide advice on selecting the right 
                         product for a given purpose."
            }
        ],
            "capabilities": [
            {
                "name": "WebSearch"
            }
        ]
        }
        ```
        
        * Hit provision and start testing it again
          
            ![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/4ca804c1-90a8-4757-a314-a2ec026d962f.png)
            
            ![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/fc34c9c0-3a19-427a-9758-ca5c57011232.png)
            
    
    **Add OneDrive and Sharepoint Content**
    
* Open the `appPackage/declarativeAgent.json` file and update the `capabilities` array to the following value (a SharePoint site URL in your Microsoft 365 organization).
  
    ```json
        "capabilities": [
        {
            "name": "WebSearch"
        },
        {
            "name": "OneDriveAndSharePoint",
            "items_by_url": [
                {
                    "url": "https://<yoursite>.sharepoint.com/sites/productsupport/"
                }
            ]
        }
    ]
    ```
    
    **Add Microsoft Graph Content**
    
* Open the `appPackage/declarativeAgent.json` file and update the `capabilities` array to the following value, replacing `policieslocal` with a valid Microsoft Graph connector ID in your Microsoft 365 organization
  

```json
{
    "$schema": "https://developer.microsoft.com/json-schemas/copilot/declarative-agent/v1.0/schema.json",
    "version": "v1.0",
    "name": "ProductHelper",
    "description": "Declarative Agents as a customer service agent",
    "instructions": "$[file('instruction.txt')]",

    "conversation_starters": [
    {
        "title": "Getting Started",
        "text": "How can I get started with Product Helper?"
    },
    {
        "title": "Help me to compare products",
        "text": "List the differences between Product A and Product B?
                 Additionally, provide advice on selecting the right product
                 for a given purpose."
    }
],
    "capabilities": [
    {
        "name": "WebSearch"
    },
    {
        "name": "OneDriveAndSharePoint",
        "items_by_url": [
            {
                "url": "https://<yoursite>.sharepoint.com/sites/productsupport/"
            }
        ]
    },
    {
        "name": "GraphConnectors",
        "connections": [
            {
                "connection_id": "<policieslocal>"
            }
        ]
    }
]
}
```

![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/50d6f372-f0d0-4035-99e5-f4994b542bc0.png)

**Additional Resources**  
please look at the [declarative Agent schema for Microsoft 365 Copilot](https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/declarative-agent-manifest) for further details.

## Declarative Agents with Copilot Studio

* Click on “Create Agents” within your Copilot Chat
  
* ![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/d008e49d-a3c5-429f-883b-047ac3369bcb.png)
  
    Select “configure” on the top” and start to configure your declarative agents.
    
* First, enter “Name”, “Description” and “Instructions”  
    We did this similar above in the declarativeAgent.json and instuction.txt file
    
    ![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/6ac8da10-22d1-4a89-8fb5-3e81f8bdbe32.png)
    
    ![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/fb0bda42-e51f-4647-9391-f7536aebe8ab.png)
    
    * Add your knowledge sources (SharePoint site and web search) - same as above with the teams toolkit
      
    
    ![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/c160ce79-4d02-4400-9e77-aa4230d0832d.png)
    
    * configure your conversation starter prompts with the same elements we used above within the declarativeAgent.json
      

![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/b106876e-d947-4342-a435-f9a474135444.png)

- Hit “Create”


![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/1ebcff35-73f7-4f3e-a0f9-707913f01944.png)

![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/a3d974f3-668a-4b76-b5be-66b0e45a244a.png)

* and give it a try
  

![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/1aa138a1-100e-4f50-b226-2f8ba86bea3c.png)

![]({{site.baseurl}}/images/cm2rmr6yz000109lc6els41rc.md/29aa7f12-2c5c-4a73-96a0-2c3157d04bdd.png)

## Conclusion

Teams Toolkit and Copilot Studio offer robust features, but your choice depends on your preferences. If you enjoy tinkering with code or prefer a more hands-on approach, Teams Toolkit might be your go-to. On the other hand, if you favor a user-friendly, wizard-like experience, Copilot Studio could be the perfect fit. Ultimately, both paths lead to creating the same powerful declarative Agent.