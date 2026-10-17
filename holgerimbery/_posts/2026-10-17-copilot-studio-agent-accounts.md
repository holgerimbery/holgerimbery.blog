---
layout: post
canonical_url: https://holgerimbery.blog/copilot-studio-agent-accounts
title: "Agents With Their Own Accounts: What Changes When Copilot Studio Agents Stop Borrowing Your Identity"
description: Microsoft's October 15, 2026 announcement gives Copilot Studio agents their own accounts, shared business process memory, and triggers. I argue that each of these agents should be treated like a service account with a job description, and that organizations should decide early which agents they want to own.
date: 26-10-17
author: admin
slug: copilot-studio-agent-accounts
image: /images/2026/10/andy-brown-7wN8vcq2_BA-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@basallt?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Andy Brown</a> on <a href="https://unsplash.com/photos/a-hand-holding-a-yellow-box-with-a-sticker-on-it-7wN8vcq2_BA?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
tags:
  - agentaccounts
  - agentgovernance
  - copilotstudio
  - entraagentid
  - frontier
  - gdpr
  - githubcopilotharness
  - identity
  - memory
  - triggers
featured: true
toc: true
---

{: .q-left }
> On October 15, 2026, Microsoft announced agent accounts, business process memory, and triggers for Copilot Studio. This is less about what these agents can do and more at what they are: a new kind of principal in your tenant, with its own credentials and memory. 

## Introduction

In my customer projects, Copilot Studio discussions tend to end up at the same question: whose identity does the agent use when it does something? So far the honest answer has been "it depends", and that becomes a problem once agents run recurring processes and keep working when nobody is looking.

I think an agent with its own account should be treated as a new principal, much closer to a service account than to a product feature. In practice that means giving each agent a job description, with scoped permissions, a named human owner, clear limits for its memory, a budget, and a plan for retiring it. If you cannot write that down, I would not give the agent an account yet. Keep in mind that Microsoft is rolling these features out through the Frontier program, which is early access, so details may still change.

## What Microsoft announced

The announcement is a [Microsoft Copilot Blog post](https://www.microsoft.com/en-us/copilot/blog/copilot-studio/delegate-shared-business-processes-to-agents-that-are-more-persistent-and-proactive-with-microsoft-copilot-studio/) by Jason Moore, Vice President of Product for Microsoft Copilot Studio, published October 15, 2026. It describes managed agents that belong to the organization and persist beyond any one person's role or tenure.

**Agent accounts.** Microsoft says agent accounts let agents work in Microsoft 365 with their own credentials, "similar to how any person would". People can reach the agent in Microsoft Teams and Outlook, @mention it in comments in Word, Excel, and PowerPoint, and hand it tasks that it continues between their interactions. Accounts also let agents work with other agents, tools, apps, and services using their own approved credentials and scoped permissions, without relying on any individual user's or maker's credentials. Work is attributed to the agent, and administrators can scope access and manage the lifecycle of these agents.

**Business process memory.** Microsoft says this memory carries users' preferences and business process context into each new cycle of a process. Anything about the process that one person tells the agent becomes a shared resource for everyone else. Makers guide how the retained context is used through instructions, and they decide which business records and policies are authoritative.

**Triggers in the GitHub Copilot harness.** Any agent built on the GitHub Copilot harness can be started by an external signal, such as an email, or on a set cadence, without an additional prompt.

Microsoft also says that additional access policies, quality, cost management, and lifecycle controls specific to these agents are planned for the coming months. Agent refinements and a browser-enabled cloud computer for agents are also described as coming.

{: .warning }
Neither the announcement nor the what's new page covers licensing, pricing, regional availability, or retention for agent accounts or business process memory. Please check these points in your own tenant before you plan anything.

## Why it matters

When an agent runs on the **user's credentials**, it sees only what that user can see. This is safe, but it is awkward for shared processes, because the result depends on who happened to ask.

When an agent runs on the **maker's credentials**, it works for everyone but acts as one person. I have seen this go wrong more than once. The maker changes role, a connection breaks, and a process stops without anyone noticing. Or the audit log shows a named employee doing things that person never did.

When an agent runs on a **shared service account**, attribution stays blurred. If several agents share one, nobody can tell which agent did what.

Agent accounts address all three cases. My reading is that they give org-owned agents a much clearer, platform-supported answer to the question of who did what. That helps with audits, incident response, and German works councils, who will want to know that agent activity cannot be mistaken for employee activity.

There is a second change. An agent that you can email and @mention behaves like a colleague, so users will treat it like one. They will tell it things in passing, expect it to remember, and assume that someone is responsible for it. Every one of these expectations needs a governance answer.

The third change comes from triggers. Nobody has to start the agent anymore, so it can run at 03:00 on a Sunday because an email arrived. Risk and cost are no longer tied to office hours, and your monitoring should reflect that.

## Architecture implications

### Agent accounts and Microsoft Entra Agent ID

How do agent accounts relate to the Microsoft Entra Agent ID that Copilot Studio already creates? Here I separate what is documented from what is not.

The [What's new in Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/whats-new) page says that starting in July 2026, Copilot Studio automatically creates a Microsoft Entra Agent ID for every new agent, and you can no longer opt out at the environment level. The [Microsoft Entra Agent IDs for Copilot Studio agents](https://learn.microsoft.com/en-us/microsoft-copilot-studio/admin-use-entra-agent-identities) page explains that connector permissions are attached to the agent identity as API permissions, that admins can target them with Conditional Access, and that deleting an agent also deletes its Agent ID. That page states that it describes agents powered by the standard harness, and the [App registration, agent identities, and authentication](https://learn.microsoft.com/en-us/microsoft-copilot-studio/govern-agents-identities-overview) page says the timing of Agent ID provisioning depends on the harness. The same page describes Entra Agent IDs as service principals with an "Agent" subtype and says that no one in your tenant, including tenant administrators, can generate tokens with the agent identity.

The October 15 post does not say whether an agent account is built on the Entra Agent ID, sits next to it, or is something else. It also does not say whether an agent account needs a license, has a mailbox in the usual sense, or shows up as a user object. The [Agent 365 identity integration page](https://learn.microsoft.com/en-us/microsoft-agent-365/builder/identity) refers to Agent 365 identity concepts such as agentic users, but I have not found any Microsoft statement that links them to Copilot Studio agent accounts.

For now I would govern the Entra Agent IDs you already have and confirm the identity model of agent accounts in your own tenant. I would not design an access model on the assumption that the two are the same object.

{: .note }
Microsoft's pages give different dates for this change: March 18, 2026 on a Microsoft Entra page, May 2026 on the Copilot Studio identity pages, and July 2026 (no opt-out) on the what's new page. Check your older agents, because some may still use legacy app registrations.

### Credentials move from people to agents

With borrowed credentials, the agent's access was inherited from a person. With agent accounts, someone has to design it. In my experience the first permission list is almost always too broad, because the maker lists everything the process might ever need. I prefer to derive permissions from the process steps: for each step, which system it touches and whether it reads or writes. Grant that, and review it after the first few cycles.

### Memory changes the data model

Copilot Studio already offers memory for agents on the GitHub Copilot harness. According to the what's new page for June 2026, it captures user preferences and patterns and "stores them per user". Business process memory works differently on purpose, because what one person tells the agent becomes available to everyone who works with it.

It is a shared knowledge base written through conversations, so the choice of authoritative records is the key design decision. If the instructions do not state clearly that the ERP record wins over a remembered comment, sooner or later a remembered comment will win.

### Triggers change the runtime profile

Triggers make the agent event-driven, which raises the usual questions. What happens when 400 emails arrive in an hour, when the same signal arrives twice, or when a run cannot finish? I did not find published limits, retry behavior, or concurrency controls for these triggers in the sources I read, so I would test all three before going live.

## Governance implications

### A named human owner, not just a sponsor

According to the identity documentation, Copilot Studio adds the agent owner to the Entra Agent ID as a sponsor with limited permissions, for "governance traceability" and "accountability for agent lifecycle". That is a sensible default, but the maker is rarely the person who owns the business process. I would record both, plus a deputy.

### Shared memory, retention, and the right to be forgotten

I expect the hardest discussions here, at least in the EU. People will tell the agent things about other people, for example "Don't send the forecast to Martin before Thursday, he's on leave." That is personal data under the GDPR, about someone who never talked to the agent.

The sources do not say where business process memory is stored, how long it is kept, whether Microsoft Purview retention and eDiscovery cover it, or how a single entry can be found and deleted. If someone makes an erasure request under Article 17 or an access request under Article 15, you need to be able to say what the agent remembers about that person. Until Microsoft documents this, I would use instructions to keep personal data out of memory, tell users clearly that the memory is shared, and involve the data protection officer before the pilot starts. In many cases a data protection impact assessment will be appropriate.

{: .caution }
Do not assume that business process memory follows the retention and deletion rules of Teams chats or Exchange mail. Microsoft has not documented this. Treat it as an open question and check it before any personal data reaches the agent.

### Triggers and cost when nobody is watching

The what's new page for August 2026 says that agents, workflows, and apps powered by the GitHub Copilot harness use usage-based billing measured in Copilot Credits. Triggers are part of that harness. My reading is that every triggered run can therefore consume credits, even when no person is involved.

The failure modes are familiar: a mail loop between two agents, or a five-minute test schedule nobody changed back. Microsoft says that cost management controls for these agents are planned, which suggests they are not all available yet. Until they are, I would use the agent usage estimator before going live and review consumption per agent every week. I wrote about the wider cost picture in my [October 10, 2026 article on agent FinOps](https://holgerimbery.blog/agent-finops-microsoft-ecosystem).

### Lifecycle and retirement

These agents are meant to outlive the projects that built them, so I would set a review date when each agent is created. If the owner does not confirm that the agent is still needed, switch off the triggers first, then remove the permissions, then delete the agent. The documentation confirms that deleting an agent deletes its Entra Agent ID. Whether it also removes the agent account and its business process memory is not documented yet, so test this during a pilot.

## Practical recommendations

### Pick the right processes first

Microsoft suggests starting with one shared business process, and I agree. Good candidates are **stable**, **clearly owned**, and **recurring**, and mistakes in them are **visible and easy to reverse**. Weekly reporting, triage of incoming contracts, and collecting status updates before a steering meeting are typical examples.

I would avoid processes with unclear ownership, processes that touch special categories of personal data, one-off projects, and anything where the agent would make a final decision with legal effect on a person. In Microsoft's example, the finance team keeps authority over allocations and spending. I would treat that as a rule for every org-owned agent.

### Personal agent or org-owned agent

I use the following table with customers. If most answers fall into the right column, the agent should be org-owned.

| Question | Personal agent | Org-owned agent |
|---|---|---|
| Who benefits? | One person | A team or function |
| Should it outlive its creator? | No | Yes |
| Whose access should it use? | The user's | Its own, scoped |
| Should memory be shared? | No, per user | Yes, per process |
| Does it start on its own? | Rarely | Often, by trigger |
| Who is accountable? | The user | A named process owner |
| Audit needs | Low | High, actions attributed to the agent |

Mixed answers often mean two agents that are easier to govern separately.

### A short readiness checklist

Before I give an agent its own account, I want the following points answered in writing:

* **Job description.** A paragraph on what the agent does, for whom, and what it must never do.
* **Owner and deputy.** A named process owner and a deputy, in addition to the maker.
* **Permissions.** Systems and actions derived from the process steps, with read and write listed separately.
* **Identity.** The agent's Entra Agent ID checked in the Microsoft Entra admin center, and Conditional Access reviewed.
* **Memory rules.** Instructions that name the authoritative records, and a notice to users that memory is shared.
* **Data protection.** Data protection officer informed, a documented decision on an impact assessment, and a process for erasure and access requests.
* **Triggers.** Sources, schedule, and expected volume documented, with a plan for duplicates and bursts.
* **Budget.** Expected Copilot Credits per cycle and a named person who reviews usage.
* **Review date.** The date when the owner must confirm that the agent is still needed.
* **Exit plan.** The order for switching off triggers, removing access, and deleting the agent.

### Use the Frontier phase to collect evidence

If your tenant is in the Frontier program, I would use the next weeks to answer the open questions rather than build a showcase. How does an agent account appear in Microsoft Entra? What do the audit logs show? Can you delete a memory entry? What does a triggered run cost?

## Conclusion

With these features, Copilot Studio agents become participants in a process instead of tools that people use. Microsoft calls them digital teammates. I find that description useful as long as we follow it through: a teammate has a role, a manager, limits, and at some point leaves.

Borrowed credentials have been a weak spot in many agent projects I have seen, so clear attribution is a real improvement. But several controls are still on the way, and the documentation on identity, memory retention, and trigger limits is incomplete. Start with one stable, clearly owned, recurring process, write the job description before you build, keep personal data out of shared memory, watch credit consumption, and set a retirement date on day one.

## Sources

- Microsoft Copilot Blog (Copilot Studio), [Delegate shared business processes to agents that are more persistent and proactive with Microsoft Copilot Studio](https://www.microsoft.com/en-us/copilot/blog/copilot-studio/delegate-shared-business-processes-to-agents-that-are-more-persistent-and-proactive-with-microsoft-copilot-studio/), October 15, 2026: agent accounts, business process memory, triggers in the GitHub Copilot harness, planned controls, agent refinements, browser-enabled cloud computer, budget agent example, Frontier program rollout
- Microsoft Learn, [What's new in Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/whats-new), last updated October 5, 2026: automatic Microsoft Entra Agent ID for every new agent from July 2026 without environment opt-out, per-user memory for GitHub Copilot harness agents (June 2026), usage-based billing in Copilot Credits (August 2026), agent usage estimator (April 2026)
- Microsoft Learn, [Microsoft Entra Agent IDs for Copilot Studio agents](https://learn.microsoft.com/en-us/microsoft-copilot-studio/admin-use-entra-agent-identities): connector permissions on the agent identity, Conditional Access, deletion of the Agent ID with the agent, move from app registrations, scope limited to the standard harness
- Microsoft Learn, [App registration, agent identities, and authentication](https://learn.microsoft.com/en-us/microsoft-copilot-studio/govern-agents-identities-overview): Agent IDs as service principals with an "Agent" subtype, provisioning timing by harness, agent owner added as sponsor, no token generation by tenant users
- Microsoft Learn, [Agent identity integration for Copilot Studio](https://learn.microsoft.com/en-us/microsoft-agent-365/builder/identity), last updated May 19, 2026: automatic Agent IDs, Agent 365 registry and governance integration, reference to agentic users
- Microsoft Learn, [Recreate Copilot Studio agents with Microsoft Entra Agent ID](https://learn.microsoft.com/en-us/entra/agent-id/migrate-copilot-studio-agents-to-agent-id): legacy service principals, March 18, 2026 date for automatic agent identities, agent-specific audit trails and lifecycle governance
- holgerimbery.blog, [agent FinOps in the Microsoft ecosystem](https://holgerimbery.blog/agent-finops-microsoft-ecosystem), October 10, 2026: my earlier article on agent cost management

