---
layout: post
title: Use the Model Context Protocol (MCP) with Copilot Studio 
description: The Model Context Protocol (MCP) is an open protocol designed to standardize how applications provide context to large language models (LLMs). It enables seamless connections to data sources and tools through a client-server architecture, offering features like pre-built integrations, flexibility, security, extensibility, and interoperability.

date: 14-04-2025
author: admin
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/04/resume-genius-IESB4iFVuzA-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@resumegenius?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Resume Genius</a> on <a href="https://unsplash.com/photos/a-woman-shaking-hands-with-another-woman-sitting-at-a-table-IESB4iFVuzA?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
      
tags: [copilotstudio, mcp, modelcontextprotocol, ai, openai, azureopenai]
featured: true
toc: true
---
{: .note }
**Summary lede**: The article introduces the Model Context Protocol (MCP) and its integration with Copilot Studio. MCP is an open protocol designed to standardize how applications provide context to large language models (LLMs). It enables seamless connections to data sources and tools through a client-server architecture, offering features like pre-built integrations, flexibility, security, extensibility, and interoperability.


## Copilot Studio and the Model Context Protocol (MCP)
Model Context Protocol (MCP) enables users to seamlessly integrate with existing knowledge servers and data sources directly within Copilot Studio. By connecting to an MCP server, users can unlock a wide range of capabilities. These integrations allow Copilot Studio to dynamically interact with the MCP server, ensuring that users can leverage the latest tools. This connection simplifies workflows, enhances productivity, and provides a standardized approach to managing AI-driven tasks within the Studio environment.

Connecting to an MCP server provides access to a variety of resources and tools. These include:

- **Resources**: File-like data that client applications can read, such as API responses or file contents.
- **Tools**: Functions that a language model can call to perform specific tasks.
- **Prompts**: Predefined templates designed to accomplish particular objectives efficiently.

{: .note }
Currently, Copilot Studio supports only tools, and this functionality is still in the preview stage as of the original publication date. To utilize MCP, Generative Orchestration must be activated.

## Overview of the Model Context Protocol (MCP)
The Model Context Protocol (MCP) is an open and versatile protocol specifically designed to standardize how applications provide context to large language models (LLMs). Imagine MCP as the AI equivalent of a USB-C port—a universal connector that simplifies and unifies the way AI applications interact with various data sources and tools. Just as USB-C enables seamless connections between devices and peripherals, MCP provides a consistent and reliable framework for integrating AI models with diverse resources.

By adopting MCP, developers and organizations can eliminate the complexities of managing multiple, incompatible integrations. MCP ensures that AI applications can access the right context, whether it comes from local files, databases, APIs, or other external services. This standardization not only streamlines workflows but also enhances the flexibility, security, and scalability of AI-driven solutions. MCP is a game-changer for those looking to harness the full potential of LLMs in a structured and efficient manner.

### Core Architecture
At its foundation, the Model Context Protocol (MCP) operates on a client-server framework, enabling seamless interaction between applications and data sources. The architecture is composed of the following components:

**MCP Hosts**: Applications such as Claude Desktop, integrated development environments (IDEs), or AI-powered tools that require access to data via MCP.

**MCP Clients**: Protocol clients that establish and maintain one-to-one connections with MCP servers.

**MCP Servers**: Lightweight applications that expose specific functionalities and resources through the standardized MCP framework.

**Local Data Sources**: Files, databases, and services stored on your local machine that MCP servers can securely access and utilize.

**Remote Services**: External platforms or systems accessible over the internet, such as APIs, which MCP servers can connect to for additional capabilities.

## Unique Values of MCP
MCP provides several unique values that make it a powerful tool for integrating AI models with various data sources and tools:

- **Built-in Integrations**: MCP includes a variety of ready-to-use integrations, enabling your LLM to connect with data sources effortlessly. This minimizes the setup and maintenance workload.
- **Adaptability**: MCP supports seamless transitions between different LLM providers and platforms, giving you the freedom to select the most suitable options for your requirements.
- **Data Security**: MCP adheres to industry-standard security practices, ensuring that your data remains protected within your infrastructure while being accessed by AI systems.
- **Unified Approach**: MCP offers a consistent framework for linking AI models to data sources, simplifying development and ensuring compatibility across diverse tools and systems.
- **Customizability**: MCP is built to be customizable, allowing developers to design unique integrations and tools that align with the protocol. This ensures MCP evolves alongside the needs of AI applications.
- **Cross-Compatibility**: MCP fosters seamless interaction between various AI models, tools, and data sources, eliminating compatibility challenges within your AI ecosystem.
- **Community-Driven Development**: As an open protocol, MCP thrives on contributions and feedback from the developer community, ensuring it remains relevant and practical for real-world applications.
- **Comprehensive Resources**: MCP offers detailed documentation and robust support to help developers implement the protocol efficiently, enabling faster adoption and utilization.
- **Future-Ready**: MCP is designed to evolve with advancements in AI and data technologies, ensuring its relevance as new tools and innovations emerge.


## How does MCP work in combination with Copilot Studio?
Each tool published by the MCP server is automatically added as an action in Copilot Studio. Name, description, inputs, and outputs are inherited from the server. As tools are updated or removed on the MCP server, Copilot Studio dynamically reflects these changes, ensuring users always have the latest versions and that obsolete tools are removed. A single MCP server can integrate and manage multiple tools, each accessible as an action within Copilot Studio.

## Supported transports
In MCP, transports are the foundation for client-server communication. Transports handle the mechanics of sending and receiving messages. Currently, Copilot Studio only supports the Server-Sent Events (SSE) transport. The feature is currently in environments in preview regions with plans to make it available across all environments shortly.

## Create a custom MCP connector
With your MCP server configured, the next step involves setting up a custom connector using Power Apps or Power Automate. This connector acts as a bridge, enabling seamless communication between your MCP server and Copilot Studio. To create this custom connector, you will need an OpenAPI specification YAML file that defines the API of your MCP server.

Follow these steps to configure the custom connector:

1. Navigate to the **Agents** section in the left-hand navigation menu of Copilot Studio.

2. From the list of available agents, select the agent you wish to configure.

3. Open the **Actions** tab for the selected agent.

4. Click on **Add an action** to initiate the process.

5. Choose the **New action** option from the available choices.

6. Select **New custom connector**. This action will redirect you to Power Apps, where you can create the custom connector.
![upgit_20250414_1744614402.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/04/upgit_20250414_1744614402.png)


7. In Power Apps, click on **New custom connector** and select the **Import OpenAPI file** option.
![upgit_20250414_1744614969.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/04/upgit_20250414_1744614969.png)

8. Locate the OpenAPI specification YAML file for your MCP server on your local machine and upload it by selecting **Import**.

9. Once the file is successfully imported, click **Continue** to finalize the setup process in Power Apps.

For detailed guidance on creating custom connectors in Power Apps, refer to the official documentation: [Import the OpenAPI definition](https://learn.microsoft.com/en-us/connectors/custom-connectors/define-openapi-definition).

By completing these steps, your custom connector will be ready for use in Copilot Studio, enabling smooth integration with your MCP server and its associated tools.


{. note}
Make sure your custom connector includes the tags, Agentic, and McpSse, so that they appear in Copilot Studio after creation.


### example schema file
```yaml
swagger: '2.0'

info:
  title: Contoso
  description: MCP Test Specification, showing the MVP spec to work in Copilot Studio
  version: 1.0.0
host: contoso.com
basePath: /
schemes:
  - https
definitions:
  QueryResponse:
    type: object
    properties:
      jsonrpc:
        type: string
      id:
        type: string
      method:
        type: string
      params:
        type: object
      result:
        type: object
      error:
        type: object
paths:
  /sse:
    get:
      summary: MCP Server Actions
      parameters:
        - in: query
          name: sessionId
          type: string
          required: false
      produces:
        - application/json
      responses:
        '200':
          description: Immediate Response
          schema:
            $ref: '#/definitions/QueryResponse'
        '201':
          description: Created and will follow callback
      operationId: InvokeMCP
      tags:
        - Agentic
        - McpSse
securityDefinitions: {}
security: []
```

## Add an existing MCP action to an agent
To integrate an existing MCP action into an agent within Copilot Studio, follow these detailed steps:

1. Navigate to the **Agents** section in the left-hand navigation menu.

2. From the list of available agents, select the specific agent you wish to configure.

3. Access the **Actions** tab for the chosen agent.

4. Click on **Add an action** to begin the process.

5. Choose the **Connector** option. This will display a list of available connectors, including those based on MCP.


6. Locate and select the desired MCP connector from the list of options.

7. Complete the authorization process by providing any required credentials or configuration details.

8. Once the connection is successfully authorized, click **Next** to finalize the integration.

By completing these steps, the selected MCP action will be added to your agent, enabling seamless interaction with the MCP server and its associated tools.


## Conclusion
The Model Context Protocol (MCP) represents a significant step forward in standardizing how AI applications interact with data sources and tools. Its integration with Copilot Studio unlocks new possibilities for developers and organizations, enabling seamless workflows, enhanced productivity, and a unified approach to managing AI-driven tasks. By leveraging MCP, users can simplify complex integrations, ensure data security, and future-proof their AI solutions.

## Additional Resources
For more information on MCP and its integration with Copilot Studio, explore the following resources:

- [Model Context Protocol (MCP) Overview](https://learn.microsoft.com/en-us/mcp/overview)
- [Copilot Studio Documentation](https://learn.microsoft.com/en-us/copilot-studio)
- [Creating Custom Connectors in Power Apps](https://learn.microsoft.com/en-us/connectors/custom-connectors/define-openapi-definition)
- [Server-Sent Events (SSE) in MCP](https://learn.microsoft.com/en-us/mcp/sse)
- [OpenAPI Specification](https://swagger.io/specification/)
- [Best Practices for Secure AI Integrations](https://learn.microsoft.com/en-us/security/ai-integrations)

These resources provide detailed guidance and insights to help you maximize the potential of MCP and Copilot Studio in your AI projects.

