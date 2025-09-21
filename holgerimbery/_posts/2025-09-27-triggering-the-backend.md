---
layout: post
title: Triggering the Backend - Integrating Azure AI Foundry with Microsoft Copilot Studio
description: Exploring the integration of Azure AI Foundry models into Microsoft Copilot Studio for enhanced custom agent capabilities.

date: 2025-09-20
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/09/anton-dmitriev-kBKOaghy8mU-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@adamanium?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Anton Dmitriev</a> on <a href="https://unsplash.com/photos/shallow-focus-photo-of-man-fixing-steel-cable-kBKOaghy8mU?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
      

category: [copilotstudio, aifoundry]
author: admin
featured: true
toc: true
---

{: .q-left }
> **Summary Lede**: 
> This article explores the integration of Azure AI Foundry models into Microsoft Copilot Studio, providing practical implementation strategies for enhancing custom agents with advanced AI capabilities. It covers two main integration approaches—using Azure Functions with Agent Flows for complex scenarios and direct model integration for simpler use cases—along with three detailed use case examples: email classification, visual issue detection in (IT) support, and (legal) document summarization.


In my [previous article](https://holgerimbery.blog/which-tool-to-choose), I explored the distinct advantages of two powerful platforms for custom agent development. Today, I'll delve deeper into the practical implementation of integrating AI Foundry capabilities into Copilot Studio, examining three distinct use case scenarios that demonstrate this powerful combination.

Throughout this technical exploration, I'll provide schematic representations of the integration pathways rather than exhaustive step-by-step tutorials. I intend to illustrate the architectural patterns and key connection points that enable these systems to work together effectively. This approach will provide you with a comprehensive understanding of the underlying mechanics without becoming entangled in platform-specific implementation details that may change over time.

By focusing on the conceptual framework, you'll gain transferable knowledge that can be applied across various environments and adapted as these technologies continue to evolve.

## Enhancing Copilot Studio with Azure AI Foundry Integration

The combination of Copilot Studio and Azure AI Foundry creates a robust ecosystem for developing intelligent agents with advanced capabilities. This integration unlocks sophisticated AI functionalities while maintaining the user-friendly interface of Copilot Studio.

### Integration Methodologies

There are two principal approaches for incorporating Azure AI Foundry models into your Copilot Studio environment:

1. **Azure Function + Agent Flows (Power Automate Framework)** (the robust way)
    - Encapsulate Foundry model logic within Azure Functions
    - Orchestrate interactions via agent flow
    - Enable complex processing pipelines and custom business logic
    - Facilitate more sophisticated error handling and retry mechanisms

    [Take a look at the excursion one below the article](https://holgerimbery.blog/triggering-the-backend#excursion-1-bring-your-own-model-to-microsoft-copilot-studio-using-azure-functions-and-agent-flows-the-robust-way)

1. **Direct Model Integration (BYOM)** (the easy way)
    - Leverage Azure AI Foundry models directly within Copilot Studio prompts
    - Maintain simplicity while accessing advanced model capabilities
    - Streamlined implementation with minimal middleware

    [Please take a look at the excursion two below the article](https://holgerimbery.blog/triggering-the-backend#excursion-2-using-azure-ai-foundry-models-directly-in-copilot-studio-the-easy-way).


## Use Case 1: Email Classification with Azure AI Foundry Model
**Business Benefit**  
Automates triage of incoming emails (e.g., support, sales, HR) by classifying them into categories and routing them to the correct department. Reduces manual workload and improves response time.

**Implementation Steps** (see excursion 1 below the article for details)

* Deploy Model in Azure AI Foundry
* Expose via Azure Function
* Use sample code to wrap the model in a Function App.
* Create Agent Flow
* Build an autonomous Copilot Studio Agent


## Use Case 2: Visual Issue Detection in IT Support
**Business Benefit**  
Automates triage of IT tickets with screenshots. Uses vision models to detect UI errors, reducing manual analysis and speeding up resolution.

**Implementation Steps** (see excursion one below the article for details)

* Deploy a vision model in Azure AI Foundry (e.g., OCR + layout classification).
* Expose via Azure Function
* Use sample code to wrap the model in a Function App.
* Create Agent Flow to hand over the image to the Function and parse results.
* Build Copilot Studio Agent

## Use Case 3: Legal Document Summarization
**Business Benefit**  
Accelerates legal review by summarizing long contracts or compliance documents using domain-specific LLMs.

**Implementation Steps** (see excursion two below the article for details)

* Deploy summarization model in Azure AI Foundry.
* Note down the endpoint and deployment name.
* Create a Prompt with the Prompt Tool in Copilot Studio.
* Write a summarization prompt
* Select model from Foundry.
* Add document upload node 
* Pass document to model.
* Return summary to user.

## Conclusion: Expanding Horizons with Integrated AI Solutions

The integration between Copilot Studio and Azure AI Foundry enables organizations to create sophisticated, context-aware agents that leverage specialized models while maintaining the governance benefits of the Copilot Studio platform.

This article has demonstrated two implementation approaches:
- A robust method using Azure Functions and Agent Flows for complex scenarios
- A streamlined direct integration for simpler use cases

Both approaches follow consistent architectural patterns that can be adapted to various technical environments and security requirements. The flexibility allows teams to select the implementation that aligns with their resources and business needs.

These integration patterns provide a blueprint for building agents that can transform business processes across multiple domains. I encourage you to start with simpler implementations and gradually incorporate more sophisticated capabilities as you become comfortable with the technology stack.

By focusing on the architectural concepts rather than platform-specific details, you've gained knowledge that remains applicable even as these technologies evolve.


---

Comprehensive documentation for advanced readers, extensively enriched with links and code samples.

## Excursion 1: Bring your own Model to Microsoft Copilot Studio using Azure Functions and Agent Flows (the robust way)


### Encapsulate an Azure AI Foundry Model with an Azure Function for Use by a Copilot Studio Agent (via Agent Flow)

Below is a **field‑tested, enterprise‑grade pattern** to encapsulate an **Azure AI Foundry** model behind an **Azure Function** and expose it to a **Microsoft Copilot Studio** agent via an **agent flow**. The guide includes step‑by‑step instructions, security options, code samples, and documentation links for every significant step. Assume that the code is an example and may need adjustments for your scenario.

### Target Architecture

![upgit_20250921_1758438210.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/09/upgit_20250921_1758438210.png)


- Copilot Studio invokes a **published agent flow** as a tool. The flow issues an HTTP call to your Azure Function and returns the model result to the conversation. See [Call an agent flow from an agent](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-use-flow) and [Use agent flows with your agent](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-flow).
- The Function acts as a **thin façade** that standardizes request/response, handles auth, guardrails, logging, and retries, and then calls the **Azure AI Foundry** inference endpoint (serverless or managed) using either an API key or **Microsoft Entra ID** (preferred). See [How to use Models inference endpoints](https://learn.microsoft.com/azure/ai-foundry/foundry-models/how-to/inference) and [Endpoints for Azure AI Foundry Models](https://learn.microsoft.com/en-us/azure/ai-foundry/foundry-models/concepts/endpoints).

### Prerequisites

1. **A deployed model in Azure AI Foundry** (e.g., serverless “Models inference endpoint” or Azure OpenAI deployment). See [Models inference endpoints](https://learn.microsoft.com/azure/ai-foundry/foundry-models/how-to/inference).
2. **An Azure Function App** with HTTP trigger (any language; example below shows .NET isolated). See [Azure Functions HTTP trigger](https://learn.microsoft.com/en-us/azure/azure-functions/functions-bindings-http-webhook-trigger).
3. **Copilot Studio** environment with permission to create **agent flows** and add tools. See [Use agent flows with your agent](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-flow).


### Step 1 — Get or Deploy a Model Endpoint in Azure AI Foundry

- Azure AI Foundry provides a **uniform inference API** through the **Models inference endpoint** (e.g., `https://<resource>.services.ai.azure.com/models`). You pass the **deployment name** (or model) in the request payload; the service routes to the right model. See [How to use Models inference endpoints](https://learn.microsoft.com/azure/ai-foundry/foundry-models/how-to/inference).
- You can also use **Azure OpenAI** endpoints (e.g., `https://<resource>.openai.azure.com/openai/deployments/<deployment>`) if your scenario uses OpenAI models. See [How to use Models inference endpoints](https://learn.microsoft.com/azure/ai-foundry/foundry-models/how-to/inference).
- Official SDKs (**Azure AI Inference**) are available if you prefer a typed client; otherwise, use REST with either **API key** or **Entra ID** token. See the SDK [README](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/ai/azure-ai-inference/README.md) and [PyPI package](https://pypi.org/project/azure-ai-inference/).

### Step 2 — Wrap the Model Behind an Azure Function (HTTP)

Create a **Function** that:
- Accepts a normalized JSON payload from Agent (e.g., `prompt`, `system`, `temperature`).
- Authenticates to the Foundry endpoint (**Managed Identity** recommended; API key also supported).
- Calls the **chat completions** (or relevant) route.
- Returns a clean JSON response for your agent flow.

**Why a Function?** It gives you a single, governed surface for **policy**, **observability**, **rate limiting** (optionally via API Management), and **schema stability**, insulating your Agent from model churn. See [Azure Functions HTTP trigger](https://learn.microsoft.com/en-us/azure/azure-functions/functions-bindings-http-webhook-trigger) and [Expose AI endpoints via API Management](https://www.beneathabstraction.com/post/expose-ai-endpoints-via-api-management/).

### Example: .NET 8 Isolated Azure Function (HTTP Trigger)

**App settings (Configuration)**
- `AI_ENDPOINT` — e.g., `https://<resource>.services.ai.azure.com/models` (Foundry inference) **or** the Azure OpenAI deployment URL. See [How to use Models inference endpoints](https://learn.microsoft.com/azure/ai-foundry/foundry-models/how-to/inference).
- `AI_MODEL_OR_DEPLOYMENT` — inference “model” (e.g., `mistral-large`) or Azure OpenAI deployment name.
- `AI_API_VERSION` — the API version you target (per your endpoint).
- Optional: `AI_API_KEY` — if you decide to use key auth (store in Key Vault ideally). See [Authentication in Azure AI services](https://learn.microsoft.com/en-us/azure/ai-services/authentication) and [azure-ai-inference (auth)](https://pypi.org/project/azure-ai-inference/).

**Auth choice**
- **Preferred**: Use **Managed Identity** on the Function and request a token for the scope `https://cognitiveservices.azure.com/.default`, then send **Bearer** token to the AI endpoint. See the Azure OpenAI/Foundry Entra ID guidance ([doc](https://github.com/MicrosoftDocs/azure-ai-docs/blob/main/articles/ai-foundry/openai/how-to/managed-identity.md)) and community thread ([SO example](https://stackoverflow.com/questions/79570023/using-managed-identity-to-call-azure-openai-endpoint-instead-of-azure-openai-key)).

**Alternative**: Use an **API key** header (the official SDKs accept a key credential). See [SDK README](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/ai/azure-ai-inference/README.md) and [PyPI](https://pypi.org/project/azure-ai-inference/).

```csharp
// .NET 8 isolated function - Chat façade
using System.Net;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using Azure.Core;
using Azure.Identity;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;

public class InvokeModel
{
    private readonly HttpClient _http;
    private readonly ILogger _log;
    private readonly string _endpoint = Environment.GetEnvironmentVariable("AI_ENDPOINT")!;
    private readonly string _modelOrDeployment = Environment.GetEnvironmentVariable("AI_MODEL_OR_DEPLOYMENT")!;
    private readonly string _apiVersion = Environment.GetEnvironmentVariable("AI_API_VERSION")!;
    private readonly string _apiKey = Environment.GetEnvironmentVariable("AI_API_KEY"); // optional

    public InvokeModel(ILoggerFactory loggerFactory, IHttpClientFactory httpClientFactory)
    {
        _log = loggerFactory.CreateLogger<InvokeModel>();
        _http = httpClientFactory.CreateClient();
    }

    public record ChatRequest(string prompt, string? system, float? temperature);
    public record ChatMessage(string role, string content);

    [Function("invoke-model")]
    public async Task<HttpResponseData> Run(
        [HttpTrigger(AuthorizationLevel.Function, "post", Route = "invoke")] HttpRequestData req)
    {
        var body = await JsonSerializer.DeserializeAsync<ChatRequest>(req.Body, new JsonSerializerOptions { PropertyNameCaseInsensitive = true });
        if (body is null || string.IsNullOrWhiteSpace(body.prompt))
        {
            var bad = req.CreateResponse(HttpStatusCode.BadRequest);
            await bad.WriteStringAsync("Missing 'prompt'.");
            return bad;
        }

        // Build OpenAI-compatible chat payload
        var messages = new[]
        {
            new ChatMessage("system", body.system ?? "You are a helpful assistant."),
            new ChatMessage("user", body.prompt)
        };

        var payload = new
        {
            // For Azure AI Foundry "Models inference endpoint", pass the model name here:
            // For Azure OpenAI deployment-style endpoints, you typically omit "model" and hit the deployment route.
            model = _modelOrDeployment,
            messages,
            temperature = body.temperature ?? 0.2f,
        };

        var url = BuildUrl();
        var request = new HttpRequestMessage(HttpMethod.Post, url);
        request.Content = new StringContent(JsonSerializer.Serialize(payload), Encoding.UTF8, "application/json");

        await AddAuthAsync(request);

        var res = await _http.SendAsync(request);
        var outResp = req.CreateResponse(res.StatusCode);
        outResp.Headers.Add("Content-Type", "application/json");
        var content = await res.Content.ReadAsStringAsync();
        await outResp.WriteStringAsync(content);
        return outResp;
    }

    private string BuildUrl()
    {
        // If using Azure AI Foundry "models" endpoint (single endpoint for all deployments)
        //   e.g., https://<resource>.services.ai.azure.com/models?api-version=<version>
        // If using Azure OpenAI deployment endpoint:
        //   e.g., https://<resource>.openai.azure.com/openai/deployments/<deployment>/chat/completions?api-version=<version>
        var separator = _endpoint.Contains('?') ? '&' : '?';
        return $"{_endpoint}{separator}api-version={_apiVersion}";
    }

    private async Task AddAuthAsync(HttpRequestMessage request)
    {
        if (!string.IsNullOrWhiteSpace(_apiKey))
        {
            // API key auth (used by Azure AI Inference SDKs)
            request.Headers.Add("api-key", _apiKey);
            return;
        }

        // Managed Identity / Entra ID token
        var credential = new DefaultAzureCredential();
        var token = await credential.GetTokenAsync(new TokenRequestContext(
            new[] { "https://cognitiveservices.azure.com/.default" })); // MI scope
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token.Token);
    }
}
```

- **HTTP trigger** is the correct binding for exposing a serverless Web API from a Function. See [HTTP trigger docs](https://learn.microsoft.com/en-us/azure/azure-functions/functions-bindings-http-webhook-trigger).
- **Key vs token**: The **Azure AI Inference** clients accept an **API key** or a **token credential**; the token flow uses the standard **Bearer** header. See [SDK README](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/ai/azure-ai-inference/README.md) and [Authentication in Azure AI services](https://learn.microsoft.com/en-us/azure/ai-services/authentication).
- For **Managed Identity** with Azure OpenAI/Foundry resources, use the `cognitiveservices.azure.com` scope; see the guidance [here](https://github.com/MicrosoftDocs/azure-ai-docs/blob/main/articles/ai-foundry/openai/how-to/managed-identity.md) and [here](https://stackoverflow.com/questions/79570023/using-managed-identity-to-call-azure-openai-endpoint-instead-of-azure-openai-key).


### Step 3 — Secure the Function Endpoint

Standard options (you can combine them):

1. **Function keys (fastest):** Keep the default `AuthorizationLevel.Function` and pass the `code=` query string from your agent flow HTTP action. Simple, but **per‑app/shared secret**. See [HTTP trigger docs](https://learn.microsoft.com/en-us/azure/azure-functions/functions-bindings-http-webhook-trigger).
2. **Microsoft Entra ID (recommended for enterprise):** Turn on **App Service Authentication** on the Function App and require **Entra ID** tokens. Then use a **Power Platform custom connector** (OAuth 2.0) or an HTTP action with OAuth to obtain tokens when the flow runs. See [Securing Azure Functions](https://learn.microsoft.com/en-us/azure/azure-functions/security-concepts) and Microsoft’s blog on [Calling Entra ID‑protected Azure Functions using a Custom Connector](https://www.microsoft.com/en-us/power-platform/blog/power-apps/calling-azure-ad-protected-azure-functions-using-a-custom-connector/).
3. **Front with API Management** for throttling, quotas, and per‑consumer subscription keys; point the agent flow to APIM instead of the Function. See [Exposing Azure AI Foundry endpoints with APIM](https://www.beneathabstraction.com/post/expose-ai-endpoints-via-api-management/).

Additional platform guidance: [Securing Azure Functions](https://learn.microsoft.com/en-us/azure/azure-functions/security-concepts).


### Step 4 — Create the Agent Flow That Calls Your Function

There are two good ways to connect Copilot Studio to your Function:

#### Option A (most common): Agent flow (Power Automate) + HTTP action
1. In **Tools**, create a **agent low** that accepts inputs (e.g., `prompt`, `system`, `temperature`).
2. Add an **HTTP** action to call your Function URL; configure auth as per Step 3 (Function key or OAuth).
3. Parse the JSON response and output a simplified object (`answer`, `usage`, `latency`).
4. **Publish** the flow.
5. In **Copilot Studio**, open your agent → **Tools** → **Add a tool** → choose **Flow** → pick your published flow. Provide a **clear tool description** so the orchestrator knows when to use it. See [Call an agent flow from an agent](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-use-flow).

Related learning content: [Make HTTP requests to connect to an API (exercise)](https://microsoft.github.io/TechExcel-Designing-your-own-copilot-using-copilot-studio/docs/Ex04/Ex04.html).

#### Option B (direct): Add a REST API tool or Custom Connector
- In Copilot Studio, you can add tools via a **REST API connection** (direct endpoint definition) or a **Custom connector** you created in Power Platform (ideal for OAuth / Entra ID). See [Add tools to custom agents](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-plugin-actions) and [Use connectors in Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-connectors).

{: .tip }
**When to choose which?**  
**Agent flow**: easiest, handles transformations and branching; great for orchestration and retries. See [Call an agent flow](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-use-flow).  
**Custom connector / REST tool**: best when you want **direct tool use** without a flow or when you need **OAuth 2.0** against your **Entra ID‑protected Function**. See [Add tools to custom agents](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-plugin-actions) and the Entra ID custom connector blog above.


### Step 5 — Suggested Request/Response Contracts

**Request from agent flow to Function**
```json
{
  "prompt": "Summarize this text: ...",
  "system": "You are a concise enterprise assistant.",
  "temperature": 0.2
}
```

**Response from Function to agent flow** (OpenAI‑style)
```json
{
  "choices": [
    { "message": { "role": "assistant", "content": "Here is the summary..." } }
  ],
  "usage": { "prompt_tokens": 123, "completion_tokens": 87, "total_tokens": 210 }
}
```

- Azure AI Foundry’s **Models inference endpoint** accepts **OpenAI‑compatible** message arrays and a top‑level **`model`** parameter for routing. See [How to use Models inference endpoints](https://learn.microsoft.com/azure/ai-foundry/foundry-models/how-to/inference).


### Step 6 — End‑to‑End Test

1. **Test the Function** in Postman or `curl` with either API key or Bearer token (Managed Identity via a dev tool or user token). See [Managed identity guidance](https://github.com/MicrosoftDocs/azure-ai-docs/blob/main/articles/ai-foundry/openai/how-to/managed-identity.md).
2. **Test the agent flow** manually: provide a sample prompt; confirm HTTP 200 and response shape. See [HTTP request exercise](https://microsoft.github.io/TechExcel-Designing-your-own-copilot-using-copilot-studio/docs/Ex04/Ex04.html).
3. **Attach the flow as a tool** to your agent and test in Copilot Studio; verify that the orchestrator picks the tool when relevant. See [Call an agent flow from an agent](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-use-flow).


### Security & Operations Checklist

- **Prefer Entra ID + Managed Identity** from Function → model endpoint; avoid persisting model API keys. See [Managed identity guidance](https://github.com/MicrosoftDocs/azure-ai-docs/blob/main/articles/ai-foundry/openai/how-to/managed-identity.md) and [Authentication options](https://learn.microsoft.com/en-us/azure/ai-services/authentication).
- **App Service Authentication** on the Function to require OAuth; use a **custom connector** with OAuth for Copilot Studio if you need per‑user consent/authorization. See [Securing Azure Functions](https://learn.microsoft.com/en-us/azure/azure-functions/security-concepts) and [Entra ID‑protected Functions via Custom Connector](https://www.microsoft.com/en-us/power-platform/blog/power-apps/calling-azure-ad-protected-azure-functions-using-a-custom-connector/).
- **Observability**: Add Application Insights telemetry; consider **API Management** for token/quota governance across consumers. See [APIM front‑door example](https://www.beneathabstraction.com/post/expose-ai-endpoints-via-api-management/).
- **Network**: If you must use private endpoints, plan how **Power Platform** will reach them (e.g., APIM with VNet or hybrid connectivity); otherwise keep the Function public but locked via OAuth and IP restrictions as needed. See [APIM article](https://www.beneathabstraction.com/post/expose-ai-endpoints-via-api-management/).


### Useful Documentation & References

- **Copilot Studio (tools, flows, connectors)**
  - [Call an agent flow from an agent](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-use-flow)
  - [Use agent flows with your agent](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-flow)
  - [Use connectors in Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-connectors)
  - [Add tools to custom agents (REST API connection, Custom connector, etc.)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-plugin-actions)
  - [Make HTTP requests to connect to an API (exercise)](https://microsoft.github.io/TechExcel-Designing-your-own-copilot-using-copilot-studio/docs/Ex04/Ex04.html)

- **Azure AI Foundry / Inference**
  - [How to use Models inference endpoints](https://learn.microsoft.com/azure/ai-foundry/foundry-models/how-to/inference)
  - [Endpoints for Azure AI Foundry Models](https://learn.microsoft.com/en-us/azure/ai-foundry/foundry-models/concepts/endpoints)
  - [Azure AI Inference client SDK (README)](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/ai/azure-ai-inference/README.md) • [PyPI package](https://pypi.org/project/azure-ai-inference/)

- **Azure Functions**
  - [HTTP trigger](https://learn.microsoft.com/en-us/azure/azure-functions/functions-bindings-http-webhook-trigger)
  - [Securing Azure Functions](https://learn.microsoft.com/en-us/azure/azure-functions/security-concepts)

- **Power Platform custom connector with Entra ID**
  - [Calling Entra ID‑protected Azure Functions using a Custom Connector](https://www.microsoft.com/en-us/power-platform/blog/power-apps/calling-azure-ad-protected-azure-f,unctions-using-a-custom-connector/)

- **(Optional) API Management front‑door**
  - [Expose Azure AI Foundry endpoints via API Management](https://www.beneathabstraction.com/post/expose-ai-endpoints-via-api-management/)

## Excursion 2: Using Azure AI Foundry Models Directly in Copilot Studio (the easy way)
To integrate an Azure AI Foundry model into the Copilot Studio Prompt Tool, you need to connect your deployed AI Foundry model as an external endpoint and then reference it within your Copilot Studio prompt flow. 

### Deploy Your AI Foundry Model as an Endpoint

Publish your trained model in Azure AI Foundry as a REST API endpoint.
Note the endpoint URL and the required authentication method (typically Azure Active Directory token or API key).

### Connect the Model in Copilot Studio

1. Open your agent in Copilot Studio.
2. Navigate to tools and select "Add Tool".
![upgit_20250921_1758436712.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/09/upgit_20250921_1758436712.png)
3. Choose "Prompt" as the tool type.   
4. In the prompt configuration, click on the model dropdown and select "Azure AI Foundry Models".
![upgit_20250921_1758436795.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/09/upgit_20250921_1758436795.png)
5. Select "Azure AI Foundry" as the model type.
![upgit_20250921_1758436584.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/09/upgit_20250921_1758436584.png)
6. Enter the endpoint URL, deployment name, and authentication details (API key or token).
7. Save your changes.

### Use the Tool in Your Agent Flow
1. Generate a prompt that utilizes the connected model.
2. Add the tool to your agent

