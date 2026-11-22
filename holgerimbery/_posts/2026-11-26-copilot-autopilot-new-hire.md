---
layout: post
canonical_url: https://holgerimbery.blog/copilot-autopilot-new-hire
title: Autopilot Has Its Own Identity and a Manager. Treat It Like a New Hire
description: "Microsoft announced the new Copilot at Ignite 2026, including Autopilot, an agent that works on its own over days and weeks. The technology building blocks are there. The real work is management: role, limits, approvals, and review. A practical guide for IT and business leads."
date: 2026-11-26
author: admin
slug: copilot-autopilot-new-hire
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/11/liv-bruce-tKTxGPswME8-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@livbruce6?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Liv Bruce</a> on <a href="https://unsplash.com/photos/aerial-photography-of-ocean-tKTxGPswME8?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a>
tags:
  - agentid
  - autopilot
  - copilot
  - cowork
  - entra
  - frontier
  - governance
  - ignite2026
  - microsoft365
featured: true
toc: true
---

{: .q-left }
> Autopilot is the first Microsoft 365 agent that keeps working when you are not looking at it. Microsoft gave it an identity, a manager, scoped access, and its own audit trail. That covers the technology. It doesn't answer who decides what it may do, what it must confirm, or who reads its work afterward. This article argues that you should onboard Autopilot like a new hire, and shows what that looks like in practice.

## Introduction

For two years, most of my customer conversations about Copilot followed one pattern. Someone asks, Copilot answers, a person decides what to do with it. The human was in the loop because the human pressed Enter.

That changed on November 17, 2026. At Ignite, Microsoft announced the new Copilot, and one part of it breaks the old pattern: Autopilot. It is an agent that runs in your tenant, watches channels, follows up on email, and runs recurring work without waiting for a prompt. It does not answer you. It works for you, sometimes for days or weeks at a time.

I like how Microsoft built it. The controls sit on the identity stack IT already runs. But I keep hearing the same reaction in early discussions: "Great, so we switch it on for the pilot group." I would push back on that. Autopilot is not a feature you toggle. It behaves much more like a junior colleague who started on Monday, and you should plan for it that way.

## What Microsoft announced

The [Microsoft Copilot Blog post by Jared Spataro](https://www.microsoft.com/en-us/copilot/blog/2026/11/17/copilot-at-microsoft-ignite-expanding-whats-possible-with-intelligence-built-for-work/) lists five main pieces. Home, "where Chat and Cowork come together", and Office in Copilot are now generally available. Copilot Code becomes generally available "in the coming weeks". Copilot Managed Runtime, which hosts and manages the apps people build, is generally available now. And Autopilot "is beginning to roll out to Frontier customers today".

Home has one composer powered by Auto. Auto picks the model and the effort level for a task, and for bigger jobs it may suggest moving the work from Chat to Cowork. Inside Home sits Today, a view across mail, calendar, Teams threads, meetings, and tasks that prepares drafts and follow-ups for you. Today is in private preview in the Copilot app and Outlook.

Workspaces, described as "the evolution of Copilot Notebooks", are a shared space where people and agents work toward a common goal. It is available in Frontier. Copilot Code lets people describe an app, a dashboard, or a desktop widget and have Copilot build it. Those apps run on Copilot Managed Runtime, "with every app visible and managed in the Microsoft 365 admin center".

Then Autopilot. Microsoft calls it "a trusted autonomous agent that is personal to you, always on". It "lives in your tenant and has its own identity, memory, and tools". It shows up in Teams, Outlook, chats, channels, and documents, and you can @mention it. The example in the post covers the full supplier review process, from scheduling and the workback plan to meetings, follow-ups, and reaching out to stakeholders for updates.

The controls are stated in three sentences that every IT architect should read twice. "Each Autopilot has its own Microsoft Entra Agent ID and a named manager. IT can scope its access and block it at any time. Its sign-ins and actions are logged under its own name." It works within existing permissions, users decide what work it takes on, and it "can check with you before key actions".

On the commercial side, Microsoft describes a per-user subscription plus a usage-based consumption model for the hardest tasks, and says it will move more capability into the subscription over time. The post also says nearly 80% of the Fortune 500 use Cowork. That is a vendor statement, and I treat it as one.

## Why it matters

The easiest way to see the change is to look at the four ways of working that the new Copilot now covers. Microsoft frames them as asking, handing off, building, and following through. I find it more useful to look at them by risk, because the risk profile differs for each.

| Work mode | Experience | Who starts each step | Typical risk | Main control |
|---|---|---|---|---|
| Ask | Chat | The user, every time | Wrong answer that a person reads | User judgment |
| Hand off | Cowork | The user starts a task | Wrong output from a multistep task | Review of the result |
| Build | Code | The user describes an app | An app that others rely on | Admin center, app lifecycle |
| Delegate | Autopilot | The agent, on its own | Wrong action taken in your name over time | Role, scope, approvals, audit |

The first three modes all have a natural review point. You read the chat answer. You open the Cowork result. You look at the app before you share it. With Autopilot, the review point is no longer built into the interaction. If it follows up with a supplier at 7 a.m. on a Tuesday, nobody looked at that email first unless someone decided earlier that it should ask.

That is the real shift. The quality of the model matters less than the quality of the instructions and limits you give it. In my projects with Copilot Studio agents, the agents that caused trouble were almost never the ones with weak models. They were the ones where nobody had written down what the agent was for and where it should stop.

I also want to challenge part of Microsoft's framing here. Autopilot is called "personal to you". That is true for who it works for, not for who it affects. Once it posts in a channel or emails a stakeholder, colleagues and suppliers will treat it as speaking for you. A personal agent with a public voice needs more governance than a personal productivity tool, not less.

## Architecture implications

The good news first. Autopilot is not a side system. It sits on Entra, inside the tenant, with its own Microsoft Entra Agent ID. For architects, this means the agent can be treated as a first-class identity: scoped, blocked, and tracked in sign-in logs like any other identity.

The less comfortable part is "within existing permissions". Microsoft presents this as a safety feature, and in a clean tenant it is. Most tenants I see are not. Old Teams with broad membership, sites shared with "everyone except external users", forgotten mailbox delegations. A human rarely notices them. An always-on agent that watches channels and reads context will find them. So I would not read "existing permissions" as reassurance. I would read it as a reason to finish the permission cleanup you probably postponed during the first Copilot rollout.

The announcement does not say exactly how an Autopilot's permissions relate to its owner's permissions, whether scoping is per agent or by policy, or which connectors and tools it can reach by default. Microsoft has not said, so I will not guess. Ask before your pilot.

Memory is the second point. Autopilot "has its own identity, memory, and tools". Memory across weeks keeps the thread of a supplier review. It also lets information travel between tasks in ways a user may not expect. I would want to know how that memory is retained, where it is stored, and what happens to it when the agent is retired. The post does not cover that either.

Cost is the third point. Microsoft describes a subscription-plus, usage-based model for the hardest tasks. The post does not say where Autopilot falls in that model. An agent that runs recurring work without a prompt is, by design, an agent that consumes capacity without a prompt. Before scaling, I want real pilot consumption figures, not an estimate.

Finally, Workspaces and Code add more actors. Workspaces put people and agents in one shared space, and Code creates apps that live on Copilot Managed Runtime. Together, they mean your tenant will soon hold agents, apps, and shared spaces created by business users. Admin center visibility for apps is a good start. Decide early who owns that inventory.

## Governance implications

Here is where the new-hire comparison becomes practical. When someone joins a team, four things usually happen. They get a role description, access to what they need and no more, learn which decisions they can make alone, and have their manager check their work for the first few weeks. Autopilot needs the same four things.

**The role.** Write one short paragraph for each Autopilot: what work it does, for whom, and in which channels. "Runs the quarterly supplier review for the procurement team" is a role. "Helps Anna with her work" is not.

**The scope.** Use the access scoping IT has. Start narrow and widen it when there is a reason, not the other way round.

**The approval points.** Microsoft says Autopilot "can check with you before key actions". The word "can" carries a lot of weight there. Somebody has to decide what a key action is. My default list is any message to an external person, any message to a group larger than the immediate team, any change to a shared document others rely on, and anything that commits money, time, or a decision.

**The review.** New hires get feedback. So should Autopilot. A weekly look at what it did, what it sent, and where it asked for confirmation is enough in most cases.

Now the named manager. This is the part I find most promising and least defined. Microsoft says each Autopilot has a named manager. It does not say what that person must do. In my view, the named manager is accountable for the agent's role description, approves changes to its scope, reviews its activity on a fixed rhythm, is the contact when someone complains about it, and decides when it is retired. If your organization cannot name a person willing to do that, you are not ready for that Autopilot.

The second assumption I would challenge is the audit story. "Logged under its own name" is a real improvement. Security teams can see that the agent signed in and acted, and they can separate its actions from the human's. That answers "who did this". It does not answer "why did it do this", "who asked it to", or "was this within its role". The log records actions, not intent or instructions. For that, you still need the role description and the manager review. Audit tells you what happened. Management tells you whether it should have happened.

Offboarding belongs here too. When the owner of an Autopilot changes jobs, what happens to the agent, its memory, and its open tasks? IT can block an Autopilot at any time, which is good. But blocking is an emergency control. You also need a normal way to hand over or retire an agent, the same way you hand over a mailbox.

## Practical recommendations

Autopilot is rolling out to Frontier first, which gives you a natural pilot phase. Here is what I would do with it.

1. **Pick two to three real processes, not volunteers.** Choose recurring, well-understood work such as a supplier review, a weekly status collection, or follow-ups after a project meeting. Avoid starting with a group of enthusiasts who will each invent their own use.
2. **Write a role card for every Autopilot.** One paragraph with purpose, channels, allowed actions, actions that need confirmation, and actions that are not allowed. Store it where the named manager and IT can both find it.
3. **Name a manager who accepts the job.** The named manager should be someone close to the work, not the IT admin by default. Agree on what that role involves before the agent starts.
4. **Clean up permissions in the pilot scope first.** Review the Teams, sites, and mailboxes the pilot users can reach. Fix the obvious oversharing before an agent starts reading it.
5. **Define key actions and make confirmation the default.** Start with confirmation on all external messages and group communication. Remove confirmation only where the manager has seen enough good results.
6. **Connect the audit trail to someone who reads it.** Make sure the agent's sign-ins and actions reach your security monitoring, and agree on a weekly review by the named manager against the role card.
7. **Tell the people it will contact.** Colleagues and suppliers should know when a message comes from an agent.
8. **Plan the exit before the start.** Decide what happens when the owner leaves, the process ends, or the pilot stops: who blocks the agent, what happens to its memory and open tasks, and who confirms it is done.

## Conclusion

Microsoft has done the part that was hardest for customers to do themselves. Autopilot has its own identity, a named manager, scoped access, a block switch, and its own sign-in and action logs. That is a solid base, and it is better than what many organizations built for their own agents.

What Microsoft cannot do for you is decide what this agent is for. The open questions are about management: what work it may take on, what it must confirm, who reviews what it did, and how it leaves. Those are the same questions you answer for every new colleague. Treat the Frontier rollout as a probation period, and judge each Autopilot by whether its manager can explain what it did last week and why.

My recommended next step is simple. Before your tenant gets Autopilot, choose one recurring process, write its role card, and ask the person who owns that process whether they are willing to be its named manager. Their answer will tell you more about your readiness than any technical checklist.

## Sources

* Microsoft Copilot Blog, [Copilot at Microsoft Ignite: Expanding what's possible with intelligence built for work](https://www.microsoft.com/en-us/copilot/blog/2026/11/17/copilot-at-microsoft-ignite-expanding-whats-possible-with-intelligence-built-for-work/), Jared Spataro, November 17, 2026: availability of Home, Office in Copilot, Code, Copilot Managed Runtime, Workspaces, Today, and Autopilot; Autopilot identity, manager, scoping, and logging; commercial model; Cowork adoption statement
* Official Microsoft Blog, [Ignite 2026: Building the Frontier ecosystem](https://blogs.microsoft.com/blog/2026/11/17/ignite-2026-building-the-frontier-ecosystem/), November 17, 2026: wider Ignite 2026 context on the Frontier program
* Microsoft Source, [Microsoft Ignite 2026: Empowering human ambition, intelligence and trust](https://news.microsoft.com/source/2026/11/17/microsoft-ignite-2026-empowering-human-ambition-intelligence-and-trust/), November 17, 2026: Ignite 2026 announcement overview
