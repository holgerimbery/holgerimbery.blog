---
layout: post
title: "Testing Copilot Studio Agents: Copilot Studio Kit vs. Agent Evaluation (Preview)"
description: "Choosing the right testing tool for your Copilot Studio agents: A detailed comparison of Copilot Studio Kit and Agent Evaluation (preview) to help you decide when to use each tool for optimal agent quality."
date: 2026-02-14 08:09:12 +0100
author: admin
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/02/cdc-CfS6A4U5g8M-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@cdc?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">CDC</a> on <a href="https://unsplash.com/photos/person-holding-white-plastic-container-CfS6A4U5g8M?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
      
tags: [copilotstudio, agentevaluation, testing]
featured: true
toc: true
---

{: .q-left }
> **Summary Lede**  
> Copilot Studio agents deserve testing at scale—but which tool fits your team? **Agent Evaluation** brings lightweight, AI-powered checks into the Studio authoring UI for rapid iteration, while **Copilot Studio Kit** delivers enterprise-grade multi-turn validation, plan verification, and telemetry for production gates. This guide cuts through the hype and shows you exactly when to reach for each tool—and why the best teams use both together.

**Why Read This**
Choosing the right testing tool can make or break your Copilot Studio agent quality strategy. **This article goes deeper** into how Copilot Studio Kit and Agent Evaluation complement—and differ in—their testing approaches. If you've read my earlier piece on [*Ship Copilot Studio Agents with Confidence: Master Automated Testing with the Copilot Studio Kit*](./ship-copilot-studio-agents-with-confidence-master-automated-testing-with-the-copilot-studio-kit) (2026-01-31), which focused on Kit capabilities alone, this comparison will help you decide *when* to use Kit, *when* to use Agent Evaluation, and *when* to use both together. Perfect for teams scaling from dev iteration to production release gates.

## Validation vs. Verification in AI Agent Testing

Before diving into the two tools, it's worth clarifying a critical distinction in quality assurance: **verification** and **validation** address different concerns when testing conversational agents. **Verification** answers the question "Did we build it right?"—it focuses on ensuring your agent behaves as designed, follows intended logic flows, and produces outputs that match specifications. In practical terms, verification tests check that your agent's instructions are correctly implemented, that topics route to the right handlers, and that expected responses are generated for known inputs. **Validation**, by contrast, asks "Did we build the right thing?"—it assesses whether your agent actually meets user needs, provides accurate and helpful information, and performs well in real-world scenarios. Validation is inherently broader and more subjective; it often involves human judgment, user feedback, and quality metrics like relevance, groundedness, and user satisfaction. The Copilot Studio Kit excels at verification through structured test cases and telemetry analysis, while Agent Evaluation bridges both worlds by enabling quality assessments that combine deterministic checks (verification) with AI-based graders that approximate validation concerns. Most production-grade agent programs require both: verification to catch implementation bugs and ensure consistency, and validation to ensure the agent truly solves the problem it was designed to solve.

Microsoft provides two complementary approaches to test Copilot Studio agents:

- **Copilot Studio Kit** (Power CAT): A Dataverse-backed, installable toolkit that runs batch tests via the **Direct Line API**, enriches results with **Application Insights**/**Dataverse**, and supports **multi‑turn** and **plan validation** scenarios, plus Excel import/export and dashboards. ([Kit overview](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/kit-overview), [Test capabilities](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/kit-test-capabilities), [Run tests](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/kit-run-tests), [GitHub repo](https://github.com/microsoft/Power-CAT-Copilot-Studio-Kit))

- **Agent Evaluation (preview)**: A **built‑in** Copilot Studio experience for creating **evaluation sets**, generating prompts with AI, selecting **test methods** (exact/partial, similarity/intent, AI‑judged quality metrics), and running structured checks directly from the authoring UI. ([Microsoft Copilot Blog announcement](https://www.microsoft.com/en-us/microsoft-copilot/blog/copilot-studio/build-smarter-test-smarter-agent-evaluation-in-microsoft-copilot-studio/), [Preview documentation](https://learn.microsoft.com/en-us/microsoft-copilot-studio/analytics-agent-evaluation-intro), [What’s new](https://www.microsoft.com/en-us/microsoft-copilot/blog/copilot-studio/whats-new-in-copilot-studio-october-2025/))

Used together, **Agent Evaluation** accelerates inner‑loop quality checks during design, while **Copilot Studio Kit** anchors enterprise‑grade testing, telemetry, and CI/CD gates prior to production.


## What Each Option Provides

### Copilot Studio Kit (Power CAT)

The Copilot Studio Kit is a comprehensive, installable testing framework built on Microsoft's Power CAT (Power Customer Advisory Team) architecture. It extends Copilot Studio's native capabilities by providing infrastructure for large-scale, automated agent validation.

**How it works:**  
The Kit operates through a structured workflow: you define test cases within **Agents**, organize them into **Test Sets**, and execute these sets as **Test Runs** on demand or via scheduled processes. Test execution occurs through the **Direct Line API**, which simulates authentic user interactions with your published agent. Results are enriched with telemetry from **Application Insights** and **Dataverse**, capturing detailed diagnostic information, including which topics were invoked, confidence scores for intent matching, and end-to-end latency measurements. This multi-layer instrumentation enables root-cause analysis of test failures and performance anomalies.

**Test types:**  
The Kit supports multiple validation approaches to accommodate different agent behaviors.   
*Response Match* tests verify that agent outputs match expected text or patterns.  
*Attachment/Adaptive Card* tests validate that rich response elements (cards, files, structured outputs) are generated correctly.   
*Topic Match* tests confirm that conversations trigger the intended dialog flows.   
*Generative Answers* tests assess responses from generative models embedded in agents.   

Beyond single-turn exchanges, the Kit handles **Multi‑turn** conversations - sequences of user inputs and agent responses within a single session - and **Plan validation**, which verifies that generative orchestration components select and invoke the correct tools, actions, and connected agents in the proper sequence.

**Run management:**  
Once you execute a Test Run, the Kit provides tools for iterative validation work. You can duplicate previous runs to establish baselines, re-run enrichment steps (regenerating Application Insights correlations and Dataverse transcripts) without re-executing the entire test, and analyze aggregate pass/fail statistics or drill down into individual case results to identify failure patterns and trends.

**Artifacts and maintenance:**  
The Kit's source code, configuration schemas, and runbooks are maintained in the [Power CAT GitHub repository](https://github.com/microsoft/Power-CAT-Copilot-Studio-Kit), where you can review implementation details, file issues, and contribute improvements.

### Agent Evaluation (Preview) in Copilot Studio

Agent Evaluation is a feature integrated directly into the Copilot Studio authoring environment, designed to facilitate the systematic evaluation of conversational agents during development. Unlike external toolkits or custom test harnesses, Agent Evaluation operates natively within the Studio UI, allowing authors to create, manage, and execute test cases without leaving the design context. This approach is intended to lower the barrier to agent testing and encourage more frequent, iterative validation as part of the authoring workflow.

**How it works:**
Agent Evaluation introduces the concept of **evaluation sets**, which are collections of test prompts and expected responses. Authors can create these sets manually, import them from CSV files, or generate them automatically using AI based on the agent's metadata or knowledge sources. This flexibility supports both targeted test case authoring and rapid bootstrapping of test coverage. Additionally, logs from the **Test Pane** - the interactive testing interface within Copilot Studio - can be reused to create evaluation sets, streamlining the conversion of ad hoc tests into structured checks.

For each test case, authors define the user prompt, the expected answer, and the **success criteria**. The evaluation process can then be run directly within Studio, producing aggregate and per-case results that are immediately accessible for inspection and troubleshooting. This tight integration with the authoring environment is intended to support a rapid feedback loop, enabling authors to identify and address issues early in the development cycle.

**Test methods:**
Agent Evaluation supports several methods for assessing agent responses:

- **Lexical matching**: This includes exact and partial string matching between the agent's response and the expected answer. Lexical methods are useful for scenarios where deterministic outputs are required, such as FAQ responses or compliance-driven answers.
- **Similarity/Intent matching**: These methods use semantic similarity algorithms or intent classification to determine whether the agent's response is sufficiently close in meaning to the expected answer, even if the wording differs. This is particularly relevant for conversational agents that employ generative models or paraphrasing.
- **AI-judged quality metrics**: Agent Evaluation can apply AI-based graders to assess qualitative aspects of responses, such as relevance, completeness, and groundedness. These metrics provide a more nuanced view of agent performance, especially in open-ended or knowledge-intensive scenarios.

**Notes:**
It is important to note that Agent Evaluation is currently in public preview. As such, its feature set, supported test methods, and grading criteria may evolve based on user feedback and ongoing development. The tool is not intended to replace Responsible AI (RAI) or safety reviews, which remain essential for production deployments of conversational agents. Instead, Agent Evaluation is best viewed as a complementary capability for improving agent quality during the iterative design and testing phases. ([Preview docs](https://learn.microsoft.com/en-us/microsoft-copilot-studio/analytics-agent-evaluation-intro))


## Side‑by‑Side Comparison

| Dimension | Copilot Studio Kit | Agent Evaluation (preview) |
|---|---|---|
| **Workspace** | Separate model‑driven app (Dataverse) you install | Built directly into Copilot Studio authoring UI |
| **Test data authoring** | Dataverse entities; **Excel** import/export | Create/import CSV; reuse Test Pane; **AI‑generate** prompts |
| **Execution** | Via **Direct Line API** with cloud flows/enrichment | Run directly in Studio |
| **Test methods** | Response/Attachment/Topic match; **Generative Answers**; **Multi‑turn**; **Plan validation** | Exact/Partial match; **Similarity/Intent**; **AI quality** graders |
| **Observability** | Enrichment with **App Insights** + **Dataverse** (topics, intent scores, latencies) | Aggregate pass/fail and scores with drill‑downs in Studio |
| **CI/CD fit** | Strong for release gates, duplication, and re‑runs | Strong for inner loop; roadmap for broader scenarios |
| **Adjacent features** | Part of a broader kit (Compliance Hub, KPIs, SharePoint sync) | Focused on evaluation inside Studio |
| **Maturity** | Generally available toolkit (maintained by Power CAT) | **Public preview** (subject to change) |



## When to Use What

### Prefer **Agent Evaluation (preview)** when
1. You want **fast, in‑Studio** feedback while iterating on instructions, topics, or knowledge.
2. Your scenarios are **single‑turn** (FAQ‑style) and benefit from **lexical/semantic/quality** scoring.
3. You need **AI‑generated** test prompts to bootstrap coverage quickly.

### Prefer **Copilot Studio Kit** when
1. You must validate **multi‑turn, end‑to‑end** flows in one conversation context.
2. You need to verify **generative orchestration plans** (correct tools/actions/connected agents).
3. You require **deep telemetry** (topics, intent scores, latencies) and **App Insights** correlation.
4. You manage **release gates** with repeatable Test Runs and re‑runs of enrichment steps.


## Practical Scenarios

- **Inner‑loop tuning for HR FAQ** → Use **Agent Evaluation** with **Similarity** and **AI quality** graders; generate 25 prompts from metadata, add a few gold answers, iterate on failures.
- **Pre‑release regression for tool‑using policy agent** → Use **Copilot Studio Kit**: **Multi‑turn** + **Plan validation**; App Insights + Dataverse enrichment to diagnose routing/tool‑selection issues.
- **Semantic drift watch** → Weekly **Agent Evaluation** runs for **relevance/groundedness**; investigate dips by reviewing knowledge changes.
- **CI pipeline across multiple agents** → Nightly **Kit** Test Runs with Excel‑managed test sets; export failures for triage; duplicate runs after fixes; investigate latencies via App Insights.


## Strengths & Limitations

**Copilot Studio Kit  -  strengths**  
Multi‑turn, plan validation, deep observability (App Insights + Dataverse), and release‑friendly run management.

**Copilot Studio Kit  -  limitations**  
Separate installation/governance; relies on Direct Line and cloud flows; AI Builder needed for AI‑based answer analysis.

**Agent Evaluation  -  strengths**  
Native UI, AI‑generated test sets, flexible lexical/semantic/AI graders; quick to adopt.

**Agent Evaluation  -  limitations**  
Public preview; multi‑turn on the roadmap; does not replace RAI/safety reviews.

## Decision Guide (Quick Reference)

- **Need fast Studio‑native checks while editing?** → **Agent Evaluation (preview)**  
- **Need enterprise regression, multi‑turn, plan validation, telemetry?** → **Copilot Studio Kit**  
- **Mature teams:** Use both - Evaluation for inner loop; Kit for outer loop, and promotion gates.


## Helpful How‑Tos & Deep‑dives (Clickable Links)

- Copilot Studio Kit: [Overview](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/kit-overview) · [Test capabilities](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/kit-test-capabilities) · [Run tests](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/kit-run-tests) · [GitHub repo](https://github.com/microsoft/Power-CAT-Copilot-Studio-Kit) · Community guides: [Forward Forever](https://forwardforever.com/test-your-custom-copilot-with-power-cat-copilot-studio-kit/), [Matthew Devaney (MS Auth setup)](https://www.matthewdevaney.com/configure-ms-auth-for-test-automation-in-copilot-studio-kit/)
- Agent Evaluation (preview): [Blog announcement](https://www.microsoft.com/en-us/microsoft-copilot/blog/copilot-studio/build-smarter-test-smarter-agent-evaluation-in-microsoft-copilot-studio/) · [Preview docs](https://learn.microsoft.com/en-us/microsoft-copilot-studio/analytics-agent-evaluation-intro) · [What’s new](https://www.microsoft.com/en-us/microsoft-copilot/blog/copilot-studio/whats-new-in-copilot-studio-october-2025/) · Community guides: [How‑to](https://sharepoint247.com/ai/how-to-evaluate-your-copilot-studio-agent/), [Tips & pitfalls](https://dev.to/balagmadhu/agent-evaluation-in-action-tips-pitfalls-and-best-practices-5cje)

## Conclusion

Testing conversational agents in Microsoft Copilot Studio requires a nuanced approach, as development team needs can vary significantly by project stage and agent complexity. The Copilot Studio Kit and Agent Evaluation (preview) are two distinct tools that address different aspects of the testing process.

The Copilot Studio Kit is designed for scenarios where comprehensive, repeatable, and instrumented testing is required. It is particularly well-suited for validating multi-turn conversations, verifying orchestration plans, and collecting detailed telemetry for analysis. Because it operates as a separate, installable solution and integrates with Dataverse and Application Insights, it is most appropriate for teams that need to enforce quality gates before production releases or require historical tracking of test results. The Kit's support for Excel-based test management and its extensibility through source code access make it a practical choice for organizations with established DevOps practices or those managing multiple agents at scale.

Agent Evaluation (preview), on the other hand, is integrated directly into the Copilot Studio authoring environment. Its primary focus is to provide rapid feedback during agent development and tuning, especially for single-turn or FAQ-style interactions. The ability to generate test prompts with AI and apply a range of grading methods (from exact match to semantic similarity and quality metrics) makes it accessible to authors who may not have a background in test automation. However, as a preview feature, its capabilities and scope are still evolving, and it does not currently address multi-turn or orchestration scenarios in depth.

In practice, many teams will find value in using both tools: Agent Evaluation for quick, iterative checks during agent design, and Copilot Studio Kit for more thorough validation prior to deployment. Understanding the intended use cases, technical requirements, and current limitations of each tool will help teams select the most appropriate approach for their workflow. As the Copilot Studio platform continues to evolve, the boundaries between these tools will likely shift, but the need for systematic, context-aware testing will remain a constant requirement for delivering reliable conversational agents.
