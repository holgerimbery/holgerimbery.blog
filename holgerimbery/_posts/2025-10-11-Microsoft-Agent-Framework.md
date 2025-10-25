---
layout: post
title: Microsoft Agent Framework - The open‑source engine for agentic AI — why it matters for businesses, low‑code makers, and pro‑code developers
description: Microsoft has open‑sourced Agent Framework, a unified SDK and runtime for building, orchestrating, and operating multi‑agent AI systems across Python and .NET, with open standards (MCP, A2A, OpenAPI), graph‑based workflows, observability via OpenTelemetry, and enterprise‑grade durability and governance. It consolidates the strengths of Semantic Kernel and AutoGen, enabling teams to prototype locally and then ship to Azure AI Foundry Agent Service, where agents are surfaced across Microsoft 365 endpoints—without the need to rewrite code.

date: 2025-10-11

image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/10/thisisengineering-iQqRM0XJvn8-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@thisisengineering?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">ThisisEngineering</a> on <a href="https://unsplash.com/photos/woman-in-black-and-white-jacket-sitting-in-front-of-computer-monitor-iQqRM0XJvn8?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>

category: [copilotstudio, aifoundry, agents]
author: admin
featured: false
toc: true
---

{: .q-left }
> **Summary Lede**:   
> Microsoft has released Agent Framework, combining the best of Semantic Kernel and AutoGen into a unified open-source platform for building, orchestrating, and governing multi-agent AI systems. With Python and .NET support, open standards for interoperability, enterprise-grade reliability features, and seamless transition from local development to cloud deployment, Agent Framework creates a coherent path from prototype to production for businesses building agentic AI solutions.


Microsoft has introduced the open-source Agent Framework—a unified SDK and runtime for building, orchestrating, and operating multi-agent AI systems. This framework supports both Python and .NET, leverages open standards (MCP, A2A, OpenAPI), enables graph-based workflows, and provides enterprise-grade observability and governance. It consolidates the capabilities of Semantic Kernel and AutoGen, allowing teams to prototype locally and deploy seamlessly to Azure AI Foundry Agent Service, with integration across Microsoft 365 endpoints. This marks a strategic shift toward a single, modern stack for agentic applications.


## What Is Microsoft Agent Framework?

Microsoft Agent Framework is an open-source SDK and runtime designed for creating AI agents and multi-agent workflows. It merges the enterprise features of Semantic Kernel (such as connectors, telemetry, and compliance hooks) with the orchestration patterns of AutoGen (including debate, facilitator/worker, and group chat). This eliminates the need to choose between rapid experimentation and production readiness.

**Key Features:**

- **Language Support:** First-class APIs for Python and .NET, ensuring consistent concepts and developer experience.
- **Open Standards & Interoperability:** Implements MCP (Model Context Protocol) for tool/data servers, A2A (Agent-to-Agent) for cross-runtime collaboration, and OpenAPI for instant tool calling.
- **Orchestration Options:** Supports both Agent Orchestration (LLM-driven reasoning) and Workflow Orchestration (deterministic, graph-based multi-step flows with checkpointing, streaming, and human-in-the-loop).
- **Observability:** Built-in OpenTelemetry tracing for debugging and benchmarking quality, cost, and latency.
- **Extensibility:** Pluggable memory backends (Redis, Pinecone, Qdrant, Weaviate, Elasticsearch, Postgres), modular connectors (Graph, SharePoint, Fabric, Oracle, Bedrock, MongoDB, SaaS via Logic Apps), and declarative agent configurations in YAML/JSON.

Microsoft positions Agent Framework as the convergence point for its agentic AI efforts, providing a clear path from local development to Azure AI Foundry Agent Service hosting, and alignment with the Microsoft 365 Agents SDK for publishing to Copilot, Teams, and web endpoints. Industry coverage confirms that future investments will focus on Agent Framework, while AutoGen and Semantic Kernel transition to maintenance mode.


## How Agent Framework, Azure AI Foundry, and Copilot Studio Interrelate—and Why Their Integration Matters

Microsoft Agent Framework, Azure AI Foundry, and Copilot Studio form a tightly integrated ecosystem for enterprise AI solutions, each contributing unique strengths across the development and deployment lifecycle. The Agent Framework serves as the open-source foundation for building and orchestrating multi-agent systems, supporting both pro-code and low-code approaches. Azure AI Foundry provides the enterprise-grade hosting, operational controls, and scalability required for production deployment of these agents, with advanced governance, security, and compliance features. Copilot Studio empowers low-code makers to rapidly compose conversational and workflow experiences, leveraging the same agent logic and connectors defined in Agent Framework.

This integration delivers several strategic benefits:

- **Seamless Development and Deployment:** Developers can prototype agents locally using Agent Framework, then deploy them to Azure AI Foundry for robust, scalable operation—without code rewrites or loss of telemetry and governance.
- **Unified Runtime and Governance:** Both low-code (Copilot Studio) and pro-code (Agent Framework) solutions share a common runtime and governance model, ensuring consistent compliance, monitoring, and operational controls across all endpoints.
- **Maximized Reach and Adoption:** Through the Microsoft 365 Agents SDK, agent logic built in Agent Framework can be surfaced in Copilot, Teams, and other Microsoft 365 experiences, enabling organizations to meet users where they work and drive adoption.
- **Accelerated Innovation:** Low-code makers can quickly compose solutions in Copilot Studio, while specialized tasks and advanced orchestration patterns can be escalated to pro-code agents, all managed under Azure AI Foundry’s enterprise controls.

Together, these platforms create a continuum from rapid prototyping to enterprise-scale deployment, enabling organizations to innovate faster, govern more effectively, and deliver AI-powered experiences across their entire digital workplace.


## Business Impact

### For Business Leaders

1. **Standardization Without Vendor Lock-In:** Open protocols (MCP, A2A, OpenAPI) allow integration with existing APIs, data, and tools without custom glue code, ensuring portability and avoiding vendor lock-in.
2. **Built-In Governance, Risk, and Compliance:** Observability, approvals, and durability are first-class concerns. OpenTelemetry and Azure integrations enable monitoring for reliability, cost, and quality—essential for audits and production SLAs.
3. **Seamless Transition from Prototype to Production:** A unified abstraction lets teams prototype locally and deploy to Azure AI Foundry Agent Service, preserving telemetry and enterprise controls, reducing operational risk.
4. **Enterprise Reach:** Alignment with Microsoft 365 Agents SDK enables agent logic to power Copilot and Teams experiences, maximizing user adoption.



### For Low-Code Builders (Copilot Studio, Makers, Solution Owners)

- **Low-Code to Pro-Code Continuum:** Agent Framework interoperates with Copilot Studio connectors, allowing low-code composition and escalation of specialized tasks to pro-code agents under a shared runtime and governance model.
- **Declarative Agents and Reusable Building Blocks:** YAML/JSON definitions make prompts, roles, tools, and guardrails versionable and reusable, enabling safe configuration by makers and extensibility by engineers.
- **Inner-Loop Simplicity in VS Code:** The AI Toolkit and Agent Framework DevUI support local creation, visualization, and debugging of multi-agent workflows, lowering the barrier to complex automation.



### For Pro-Code Developers (Platform, App, and Data Engineers)

- **Unified Framework Across Languages:** Build in Python or .NET with parity for agents, workflows, middleware, and telemetry, eliminating split stacks and accelerating collaboration.
- **Graph-Based Workflows with Correctness Features:** Compose agents and deterministic functions as typed data-flow graphs with checkpointing, human-in-the-loop, streaming, and time-travel for replayable runs—critical for debugging non-deterministic behavior.
- **Open Tooling Ecosystem:** Use MCP for tool servers, OpenAPI for auto-ingesting REST tools, and A2A for cross-runtime collaboration, with comprehensive instrumentation via OpenTelemetry.
- **Research-to-Production Patterns:** Out-of-the-box orchestration patterns (sequential, concurrent, group chat, handoff, “Magentic” manager-specialist coordination) arrive with production durability and auditability.


## Minimal “Hello, Agent” Examples

**Python Example:**
```python
import asyncio
from agent_framework.azure import AzureOpenAIResponsesClient
from azure.identity import AzureCliCredential

async def main():
    agent = AzureOpenAIResponsesClient(credential=AzureCliCredential()).create_agent(
        name="HaikuBot",
        instructions="You are an upbeat assistant that writes beautifully.",
    )
    print(await agent.run("Write a haiku about Microsoft Agent Framework."))

asyncio.run(main())
```

**.NET (C#) Example:**
```csharp
using Azure.AI.OpenAI;
using Azure.Identity;
using Microsoft.Agents.AI;

var endpoint = Environment.GetEnvironmentVariable("AZURE_OPENAI_ENDPOINT")!;
var deployment = Environment.GetEnvironmentVariable("AZURE_OPENAI_DEPLOYMENT_NAME")!;
var agent = new AzureOpenAIClient(new Uri(endpoint), new AzureCliCredential())
    .GetOpenAIResponseClient(deployment)
    .CreateAIAgent(
        name: "HaikuBot",
        instructions: "You are an upbeat assistant that writes beautifully.");
Console.WriteLine(await agent.RunAsync("Write a haiku about Microsoft Agent Framework."));
```

These samples demonstrate the symmetrical developer experience across Python and  .NET.



## Integration Path: From Local Development to Enterprise Rollout

1. **Start Locally:** Use VS Code with the Agent Framework SDK and DevUI to build and visualize architectures and tools.
2. **Add Tools and Data:** Integrate via OpenAPI specs and MCP servers; connect enterprise systems (Graph, SharePoint, Fabric, Oracle, Bedrock, MongoDB, Logic Apps).
3. **Model State and Memory:** Employ pluggable stores (Redis, Pinecone, Qdrant, Weaviate, Elasticsearch, Postgres) and define policies declaratively (YAML/JSON).
4. **Choose Orchestration:** Select Agent Orchestration for open-ended reasoning or Workflow Orchestration for deterministic processes with checkpointing and approvals.
5. **Instrument with OpenTelemetry:** Establish quality, cost, and latency SLOs; integrate CI/CD via GitHub Actions or Azure DevOps.
6. **Deploy to Azure AI Foundry Agent Service:** Retain telemetry and controls, then publish via Microsoft 365 Agents SDK to Copilot, Teams, or web endpoints.



## What Changes with Agent Framework vs. Previous Stacks

- **Unified Abstractions:** A single mental model across experimentation and production reduces handoffs and divergence between prototypes and deployed systems.
- **Consolidated Roadmap:** Future feature investment centers on Agent Framework, with whoGen and Semantic Kernel moving to maintenance—clarifying the long-term platform choice.



## Strategic Recommendations

**For CIOs & Architecture Boards:**
- Standardize on Agent Framework for new agentic initiatives; require OpenTelemetry instrumentation and OpenAPI/MCP integration for portability and auditability.

**For Low-Code Leaders:**
- Use declarative agent configs and Copilot Studio connectors for rapid composition; escalate specialized tasks to pro-code agents via the shared runtime and Microsoft 365 Agents SDK.

**For Pro-Code Teams:**
- Establish workflow templates (sequential, concurrent, handoff, "Magentic"), standard memory adapters, and a middleware catalog (auth, PII redaction, retries). Measure with OpenTelemetry and publish sample graphs for reuse.


## Conclusion
Microsoft Agent Framework represents a significant evolution in the enterprise AI landscape, unifying the strengths of Semantic Kernel and AutoGen into a single, open-source platform for building, orchestrating, and governing multi-agent systems. By supporting both Python and .NET, embracing open standards, and providing enterprise-grade features like observability and governance, Agent Framework creates a coherent path from local prototyping to scalable cloud deployment via Azure AI Foundry. This integration, combined with Copilot Studio and the Microsoft 365 Agents SDK, enables organizations to innovate faster, govern more effectively, and deliver AI-powered experiences across their digital workplace. Businesses, low-code makers, and pro-code developers alike can leverage this unified ecosystem to drive adoption and realize the full potential of agentic AI. 

## additional resources
[Microsoft Agent Framework](https://aka.ms/AgentFramework)   
[Azure AI Foundry](https://aka.ms/AzureAIFoundry)   
[Copilot Studio](https://aka.ms/CopilotStudio)   
[Microsoft 365 Agents SDK](https://aka.ms/M365AgentsSDK)   
[OpenTelemetry](https://opentelemetry.io/)   
[Documentation](https://aka.ms/AgentFramework/docs)   
