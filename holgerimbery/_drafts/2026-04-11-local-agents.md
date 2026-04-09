---
layout: 
title: "# Building On‑Prem AI Agents with Azure Local, Foundry Local, and Microsoft Agent Framework"
description: "A practical architecture and implementation guide for deploying AI agents on-premises using Azure Local, Foundry Local, and Microsoft Agent Framework."
date: 2026-04-11
author: admin
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/04/taylor-vick-M5tzZtFCOfs-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@tvick?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Taylor Vick</a> on <a href="https://unsplash.com/photos/cable-network-M5tzZtFCOfs?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
      
            
tags: [Azurelocal, foundrylocal, Agents, FrontierFirm, Implementation, SovereignPrivateCloud, OnPremAI, LocalInference, MicrosoftAgentFramework]
featured: true
toc: true
---

{: .q-left }
> **Summary Lede**   
> Cloud-native architecture belongs on-premises too   
On-premises and cloud-native are not contradictions—they are complementary. While enterprises have spent years building cloud-native practices in the cloud, those same principles—containerization, orchestration, API-driven integration, and infrastructure-as-code—deliver even greater value when deployed on-premises. This guide shows you how to build production AI agents that run locally using Azure Local, Foundry Local, and Microsoft Agent Framework, proving that cloud-native excellence is not constrained by your network boundary.   
If you operate in regulated industries, manage constrained connectivity, or face data residency requirements, this architecture gives you the operational consistency of the cloud without leaving your premises.

{: .note}
> This article is the second in a series on Azure Local:[Azure Local, Foundry Local, and Microsoft 365 Local: A Comprehensive Guide for IT Architects and Decision-Makers](https://holgerimbery.blog/azure-local-foundry-local-and-microsoft-365-local-a-comprehensive-guide-for-it-architects-and-decision-makers).

Enterprise teams are moving beyond “chatbots” toward agents that can retrieve internal knowledge, call tools, orchestrate workflows, and produce outcomes aligned to real business processes. The challenge is that many agent reference designs assume always‑on cloud connectivity and cloud-hosted inference. That assumption does not hold everywhere.

In regulated industries, in plants and branches with constrained connectivity, or in environments where latency and data locality are non‑negotiable, the architecture has to follow the use case. This post describes a pragmatic design you can implement today by combining:

*   **Azure Local** as the on‑prem infrastructure substrate, managed through **Azure Arc**.
*   **AKS on Azure Local** as the standardized Kubernetes runtime for agent services and supporting components.
*   **Foundry Local (preview)** as the local inference runtime exposing an **OpenAI‑compatible REST interface** for model calls.
*   **Microsoft Agent Framework (MAF)** as the agent and workflow layer, including tool integration, session/state management, middleware, and telemetry patterns.

**A critical insight: cloud-native architecture and practices are not limited to cloud deployments.** The principles—containerization, orchestration, infrastructure-as-code, API-driven integration, observability, and declarative state management—are equally valuable on‑premises. In fact, they become *more essential* when your infrastructure cannot scale elastically or rely on the implicit redundancy of cloud regions. By applying cloud-native architecture to on‑prem agent deployments, you gain consistent operational models across locations, faster iteration, clear boundaries between layers, and the ability to treat infrastructure changes as routine rather than exceptional.

One design choice drives everything that follows: **separate the agent runtime from the model runtime.** You want the agent layer (routing, tools, workflows, state, observability) to evolve independently from inference, especially when local inference is in preview and can change.

## The architecture in one picture (logical view)

A practical baseline pattern is “local inference, centralized orchestration.”

```text
+-----------------------------------+          +----------------------------------+
| AKS on Azure Local                |   HTTPS  | Foundry Local (preview)          |
|                                   +--------->| OpenAI-compatible REST server    |
|  Agent API (MAF)                  |          | + local model runtime            |
|  - routing, tools, workflows      |          +----------------------------------+
|  - state/memory, middleware       |
|  - telemetry                      |          +----------------------------------+
|                                   |<-------->| On-prem data and services        |
|  Tooling services / proxies       |          | (files, DBs, line-of-biz)        |
|  - connectors, validation         |          +----------------------------------+
+-----------------------------------+
```

This separation keeps your application surface stable. You can update agent code frequently, add tools safely behind constrained proxies, and keep governance and observability consistent—while treating inference as a managed dependency that can be placed close to hardware and data.


## Where this approach fits (and where it does not)

### This is a good fit when

*   **Data residency** requires prompts and retrieved context to remain inside an on‑prem boundary.
*   **Latency** matters because users are on the shop floor, in branches, or in operational environments where waiting on cloud round‑trips is unacceptable.
*   **Connectivity is constrained or intermittent**, and you still need useful agent behavior locally.
*   You want **cloud-native operations** on‑premises: Kubernetes packaging, GitOps delivery, policy boundaries, and consistent telemetry.

### You should pause when

*   You need **elastic inference scale** beyond local hardware capacity.
*   You require **production‑stable local inference APIs** with minimal change risk (Foundry Local is preview).
*   The problem is best solved by a **deterministic workflow** or conventional service rather than an agent.

Those bullets are the “why.” The next section explains the “why Azure Local” specifically—using a use‑case framing rather than an on‑prem philosophy.


## Why Azure Local makes sense here (the use case drives locality)

Azure Local is not the point of the architecture. It is the platform choice that becomes rational when the **agent pattern has to follow the environment**: where data and tools live, what network rules allow, what latency targets are required, and what failure modes are acceptable.

### 1) The agent needs to live where the tools and data already are

High‑value agents are typically tool-heavy. The model call is only one part of the interaction; the rest is retrieving documents, querying systems, validating constraints, and writing back outcomes. If the systems of record and the “do work” tools are on‑prem, moving the agent runtime close to those systems reduces integration complexity and shrinks the trust boundary. Azure Local provides a consistent substrate to host that runtime inside the boundary while still keeping operations modern.

### 2) Latency is a functional requirement, not a nice-to-have

In operational scenarios, predictable response time is part of usability. A troubleshooting assistant that responds in seconds is useful; one that responds in tens of seconds is often ignored. Azure Local supports placing AKS-hosted agent services and the inference runtime close to users and data sources so the slowest element is your own network and hardware—not external connectivity.

### 3) Connectivity constraints are a design input

Many environments are not “cloud connected” in the way cloud reference architectures assume. Outbound traffic may be restricted, connectivity may be scheduled, or parts of the network may be disconnected by design. Azure Local enables local execution while still aligning to Azure’s control-plane concepts via Arc whenever connectivity is available. This gives you an operational path that respects constraints instead of fighting them.

### 4) You can keep cloud-native operations without reinventing on‑prem deployment

Teams generally want repeatable delivery, policy enforcement, and consistent observability. Azure Local plus AKS on Azure Local supports containerized deployments, GitOps, namespaces, and rollouts that look and feel like modern cloud operations. The “local” decision becomes a deployment location decision—not a return to bespoke server management.

### 5) Local inference forces you to manage capacity and hardware intentionally

If inference is local, capacity planning and acceleration hardware become first-class concerns. Azure Local provides a platform to run and govern those resources, allowing you to isolate inference nodes, stage updates, and enforce change control without coupling inference lifecycle to agent code lifecycle.

### 6) The architecture stays incremental and reversible

By separating agent runtime from model runtime, you can start small, learn, and expand. You can keep your agent API stable while swapping models or changing inference node placement. Azure Local supports that incremental path from a pilot footprint to clustered deployments without forcing a redesign of your delivery model.

**Practical decision test:** Azure Local tends to be the right call when most of these are true: the authoritative tools/data are on‑prem, prompts and retrieved context must remain local, latency is a requirement, connectivity is constrained, and you want cloud-native operations in the same footprint.

With that context, we can move from “why” to “how.” The remainder of the post is an implementation runbook that assumes you want a production‑grade path even if you start with a pilot.

# Step‑by‑step implementation runbook

## Phase 0 — Define boundaries: agent vs workflow, and what “done” means

1.  **Write the outcome in business terms.**  
    Define success in measurable outcomes, not in model features. Examples include reduced downtime, faster triage, fewer escalations, shorter handling time, or improved compliance auditability.

2.  **Classify steps as agent or workflow.**

*   Use an **agent** for open-ended interpretation, conversational assistance, flexible tool use, and summarization.
*   Use a **workflow** for deterministic steps, routing, approvals, checkpoints, and auditable state transitions.

3.  **Produce a tool inventory and trust boundary map.**  
    For each tool, define authentication, authorization, validation, allowed destinations, and audit requirements.

**Operational gotcha:** Teams often prototype by giving agents broad access “to move fast.” That security debt becomes expensive later. Start with constrained proxies and allow-lists from day one.


## Phase 1 — Platform baseline: Azure Local + Arc + AKS on Azure Local

### 1.1 Establish baseline assumptions

Decide upfront:

*   Topology: pilot node, datacenter cluster, or distributed sites.
*   OS mix: Linux nodes, Windows nodes, or mixed.
*   Acceleration: CPU only vs GPU/NPU inference nodes.
*   Connectivity mode: connected, constrained, or partially disconnected.

**Operational gotcha:** Constrained connectivity changes everything about artifact flow. Treat “how will nodes pull images and models?” as a first-class requirement (private registry, artifact promotion, caching).

### 1.2 Build a minimal AKS baseline (repeatable)

Include:

*   Namespaces for separation (`platform`, `agents`, `tools`, `observability`).
*   Ingress and certificate strategy.
*   Secrets management strategy.
*   Logging/metrics pipeline.
*   Network policies and egress controls.

Example namespace baseline:

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: agents
  labels:
    pod-security.kubernetes.io/enforce: "restricted"
---
apiVersion: v1
kind: Namespace
metadata:
  name: tools
  labels:
    pod-security.kubernetes.io/enforce: "restricted"
```

**Operational gotcha:** Without early namespace boundaries and baseline policies, your cluster becomes a collection of special cases that are hard to govern and hard to migrate.


## Phase 2 — GitOps delivery (recommended even for pilots)

### 2.1 Repository layout pattern

A structure that scales:

*   `clusters/<cluster-name>/` for cluster-specific overlays
*   `platform/` for shared add-ons (ingress, monitoring, policy)
*   `workloads/agents/` for agent services
*   `workloads/tools/` for tool proxies and connectors

### 2.2 Kustomization pattern (example)

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: agents
  namespace: flux-system
spec:
  interval: 5m
  path: ./workloads/agents/overlays/prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: platform-repo
  timeout: 5m
```

**Operational gotcha:** GitOps only reduces drift if “kubectl apply in production” is the exception with a documented break-glass process.


## Phase 3 — Foundational services: state, memory, and observability

Make state explicit and intentional:

*   **Conversation state** (threads, session context) belongs in agent stores designed for that purpose.
*   **Business state** (work items, approvals, tickets) belongs in systems of record.

Common supporting components on AKS:

*   Redis for caching and rate limiting
*   PostgreSQL (or equivalent) for durable state
*   A vector store if you implement local RAG
*   OpenTelemetry collector for traces/metrics/logs

**Operational gotcha:** Agent telemetry can explode. Define retention, sampling, and content redaction policies early. In regulated environments you often cannot log raw prompts or retrieved text.


## Phase 4 — Install Foundry Local (preview) on inference nodes

Treat Foundry Local as a managed runtime dependency.

### 4.1 Placement and isolation

*   Prefer dedicated inference nodes where possible.
*   Place them where acceleration hardware lives.
*   Segment networking so AKS can reach them reliably while keeping exposure minimal.

### 4.2 Endpoint discovery (avoid hard-coded ports)

Prefer one of these:

*   **Discovery service pattern:** publish the current base URL into a config store your agent services read.
*   **Gateway pattern:** place a stable internal proxy in front of Foundry Local to normalize routing and policies.

**Operational gotcha:** Hard-coded ports work in a lab and fail after reboots, upgrades, or runtime changes. Build discovery or stable routing into the design.


## Phase 5 — Network, TLS, and identity between AKS and Foundry Local

### 5.1 Connectivity options

Common choices:

*   Direct HTTPS from agent pods to Foundry node IP/DNS
*   Internal L4/L7 proxy for stable routing and policy
*   Service mesh for mTLS and telemetry (only if you already operate one)

### 5.2 TLS strategy

Use your standard PKI approach if possible and ensure clients validate certificates by default.

**Operational gotcha:** “Works with curl -k” is a warning sign, not a milestone. Fix trust chains early so insecure shortcuts do not become permanent.

## Phase 6 — Implement the inference adapter in your MAF service

Design goal: agent code calls a model client abstraction, not a concrete endpoint.

### 6.1 Configuration pattern (ConfigMap + Secret)

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: agent-config
  namespace: agents
data:
  FOUNDRY_BASE_URL: "https://foundry-local.internal.example"
  FOUNDRY_MODEL: "local-chat-model"
  INFERENCE_TIMEOUT_SECONDS: "30"
  INFERENCE_MAX_RETRIES: "2"
---
apiVersion: v1
kind: Secret
metadata:
  name: agent-secrets
  namespace: agents
type: Opaque
stringData:
  FOUNDRY_API_KEY: "placeholder-if-required-by-client"
```

Deployment consuming it:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: maf-agent-api
  namespace: agents
spec:
  replicas: 2
  selector:
    matchLabels:
      app: maf-agent-api
  template:
    metadata:
      labels:
        app: maf-agent-api
    spec:
      containers:
      - name: api
        image: registry.local/agents/maf-agent-api:1.0.0
        envFrom:
        - configMapRef:
            name: agent-config
        - secretRef:
            name: agent-secrets
        resources:
          requests:
            cpu: "250m"
            memory: "512Mi"
          limits:
            cpu: "2"
            memory: "2Gi"
        readinessProbe:
          httpGet:
            path: /health/ready
            port: 8080
          initialDelaySeconds: 10
          periodSeconds: 10
```

### 6.2 Client policy (timeouts, retries, circuit breakers)

Start with conservative defaults:

*   Timeout: 20–60s depending on model/prompt size
*   Retries: 1–2 for transient failures only
*   Circuit breaker: open after repeated failures to prevent cascading latency
*   Concurrency limits: protect inference nodes from overload

**Operational gotcha:** Without explicit backpressure, one busy agent route can saturate inference and degrade every workload sharing the runtime.


## Phase 7 — Tool integration with constrained proxies

Do not give agents direct access to sensitive systems.

Recommended approach:

1.  Deploy tool proxy services in a dedicated namespace.
2.  Restrict outbound connectivity to approved destinations only.
3.  Enforce authorization, validation, and allow-lists in the proxy.
4.  Log every invocation with correlation IDs.

A default-deny egress policy concept:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: tools-default-deny-egress
  namespace: tools
spec:
  podSelector: {}
  policyTypes:
  - Egress
  egress: []
```

**Operational gotcha:** If you skip network controls early, you will discover “mystery dependencies” later when tools call endpoints that were never approved.

## Phase 8 — Observability: correlate agent → tools → inference

Minimum requirements:

*   Correlation ID propagated across inbound request, tool calls, inference calls, and response
*   Latency breakdown (tool time vs inference time vs orchestration time)
*   Error classification by category (tool failure, inference failure, policy block, timeout)
*   Token/prompt size metadata if available

**Operational gotcha:** Decide what is safe to log. For many environments, metadata and hashes are acceptable, but raw prompts and retrieved snippets are not.


## Phase 9 — Hardening: safety, governance, regression testing

Hardening checklist:

*   Prompt and tool regression tests for critical flows
*   Golden conversations for validation after runtime updates
*   Tool schemas and allow-lists enforced centrally
*   Timeouts on every external call
*   Rate limits per user and per route
*   Graceful degradation when inference is unavailable (fallback to workflow/human)

**Operational gotcha:** Preview inference runtimes can introduce behavior changes that are not “errors” but still break user expectations. Without regression tests, you will find out in production.


## Phase 10 — Operations: versioning, rollouts, and capacity planning

### 10.1 Independent update cadences

Operate on separate cadences:

*   Agent services: frequent updates via CI/CD
*   Inference runtime: cautious updates via staged rollout
*   Cluster/platform: regular maintenance windows

### 10.2 Rollout strategy

*   Canary agent changes with a small traffic slice and compare latency/error rates
*   Pin inference runtime versions and validate with representative load before expanding rollout

### 10.3 Capacity planning

Define explicit SLOs:

*   p95 latency target for a representative prompt
*   maximum concurrent sessions per inference node
*   acceptable queueing delay under peak load

**Operational gotcha:** Size for peaks and recovery scenarios. A thundering herd is common when shifts start, sites reconnect, or batch processes trigger.


## A practical “day‑1 to day‑30” plan

**Day 1–3: Foundation**

*   Define business outcomes and agent/workflow boundaries
*   Stand up AKS baseline namespaces, ingress, and GitOps scaffolding
*   Deploy telemetry pipeline and basic dashboards

**Day 4–10: Inference integration**

*   Install Foundry Local on inference nodes
*   Implement endpoint discovery and TLS trust
*   Add inference adapter in the MAF service with externalized configuration

**Day 11–20: Tools and data**

*   Build constrained tool proxies with allow-lists and audit logs
*   Implement retrieval paths that keep data inside the boundary
*   Add correlation IDs end-to-end

**Day 21–30: Hardening and operations**

*   Add regression tests and golden conversations
*   Implement rollouts, version pinning, and canary strategy
*   Load test and finalize a capacity plan and operational runbooks


## Conclusion

This stack is not about “on‑prem versus cloud.” It is about aligning the agent pattern to the constraints the use case imposes: data locality, tool proximity, latency targets, and network realities. Azure Local provides a consistent on‑prem platform for that pattern, AKS keeps operations cloud-native, Foundry Local enables local inference, and Agent Framework provides the application layer to build agents and workflows that map to real business outcomes. By following this architecture and implementation runbook, you can deliver production‑grade AI agents that run locally, proving that cloud-native excellence is not constrained by your network boundary. 