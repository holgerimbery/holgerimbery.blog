---
layout: post
title: "Contact Center Intelligence one month in: what to prepare before the GA dates"
description: Reflections on Contact Center Intelligence one month after the preview, and what architects should prepare before the general availability dates.
date: 2026-11-12
author: Holger Imbery
tags:
    - Contact Center
    - Copilot Studio
    - Architecture
    - ContactCenterIntelligence
    - CopilotStudio
    - Genesys
    - CustomerService
    - Governance
canonical_url: https://holgerimbery.blog/contact-center-intelligence-month-prepare-ga-dates
slug: contact-center-intelligence-month-prepare-ga-dates
featured: true
toc: true
image_caption: Photo by <a href="https://unsplash.com/@machec?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Petr Macháček</a> on <a href="https://unsplash.com/photos/black-and-brown-headset-near-laptop-computer-BeVGrXEktIk?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/11/petr-machacek-BeVGrXEktIk-unsplash.jpg
---

# Contact Center Intelligence one month in: what to prepare before the GA dates

## 1. Introduction

For years, my talks with contact center teams went the same way. They liked what Microsoft was doing with AI in Dynamics 365 Customer Service. Then they told me, in a friendly way, that they would not move their contact center. They ran Genesys or another platform, they had a lot of routing logic, years of fine tuning, and a contract that still had a long time to run. So the AI discussion ended there.

Contact Center Intelligence (CCI) is Microsoft's offer for exactly these customers. It brings Microsoft AI to contact centers that stay on their current platform. The preview has been public for about a month now, and the roadmap points to general availability in November. For me, that means it is time to stop reading announcements and start preparing.

In this article I share how I approach that preparation. I will not repeat the feature list. Instead, I go through the questions I ask customers at the moment. Which CCI features do you really need? Which connector does your setup depend on? What does voice biometrics mean for your governance? And how will Copilot Credits show up in your cost model?

## 2. What Microsoft announced

First, I want to keep apart what is documented and what is only on the roadmap.

The [CCI What's new page on Microsoft Learn](https://learn.microsoft.com/en-us/contact-center-intelligence/implement/whats-new-contact-center-intelligence) was last updated on October 20, 2026. The October 2026 preview content covers:

- Genesys Cloud and a universal connector
- Quality assurance
- Real-time and historical dashboards
- Voice biometric authentication
- Reuse of Copilot Studio agents and Foundry

The launch post on the Dynamics 365 blog came out on October 21, 2026. I see it as background. For what is really in the preview, the Learn page is the better source.

The Customer Assist agent page on Learn (updated October 22) has one detail I think many people will miss. You create agents from the CCI portal, using the same builder as Copilot Studio. I come back to this later.

On November 4, the Copilot Studio blog said that the customer conversation harness is now in preview. If you want to see where Copilot Studio is going with agents for customer conversations, read the [Copilot Studio October update](https://www.microsoft.com/en-us/copilot/blog/copilot-studio/new-and-improved-agents-that-are-persistent-agents-for-customer-conversations-and-improved-maker-experience-in-microsoft-copilot-studio/) together with the CCI pages.

The next part comes with a warning. Two public roadmap entries, both dated October 28, point to November:

- Roadmap entry 575278, a universal connector for self service omnichannel agents, listed as rolling out, with preview in October and GA in November 2026.
- Roadmap entry 575290, Contact Center AI insights and quality, listed as in development, with GA in November 2026.

I did not read these on Microsoft's own roadmap site. I read them on a third party copy of it. Roadmap entries change often. Dates move, features get split, and the status changes without much notice. So please use these dates for planning only. Do not show them as fixed dates in a steering committee.

## 3. Why it matters

The simple summary is "Microsoft AI for contact centers that do not run on Dynamics". That is correct. But for me, it is more useful to look at what CCI is not.

CCI is not a contact center platform. It does not replace your routing, your telephony or your workforce management. It runs next to the platform you already have, and it needs a connector to talk to it. If you expect a migration project, you have the wrong picture. If you expect no integration work at all, you also have the wrong picture.

CCI is also not a separate AI tool on its own. Customer Assist agents use the same builder as Copilot Studio, and the preview includes reuse of Copilot Studio agents and Foundry. To me this says that Microsoft wants CCI to be one more place where you use the agents you already have. If you already built self service agents in Copilot Studio for your website or for Teams, that is a good reason to look at CCI. If you have not, CCI brings Copilot Studio into your contact center project anyway, planned or not.

This is the work I see people underestimate most. The contact center team and the team that runs Copilot Studio are rarely the same people. They have different change processes, different release dates and a very different view of risk. When both use the same builder, they also share the governance questions.

## 4. Architecture implications

### Map the features you need, not the features on the slide

The preview list is long. Quality assurance, dashboards, voice biometrics, agent reuse and the connectors are five different pieces of work, and each has a different owner. With every customer, I start with a simple table. One row per CCI feature. Then a column for the tool that does this job today, one for the owner, and one that says if you want to replace that tool or add to it.

Quality assurance is often the strongest case, because many teams still check only a small number of calls by hand. Dashboards are a different story. You may already pay for similar reports in your contact center platform. That is no reason to skip CCI. But you need to decide which dashboard is the leading one. If two systems show different numbers for handle time or containment, you will argue about it in your first quarterly review.

### The connector is your real dependency

The preview names Genesys Cloud and a universal connector. These two options come with very different risks.

If you run Genesys Cloud, you are on the path Microsoft mentions first. In my experience that usually means better documentation, more early customers and quicker fixes. It still means work. You need to know which events and which audio flow through the connector, which permissions it needs in Genesys, and who gets called when it stops working.

If you run another platform, you depend on the universal connector. The roadmap entry for the universal connector for self service omnichannel agents (575278) points to GA in November. Keep in mind what I said above: it is a roadmap entry, I read it on a third party copy, and it can change. The date is not the main question, though. The main question is what "universal" means for you. In most cases, a universal connector means that someone on your side builds and runs the part that is specific to your platform. Find out early who that person is. In my projects it is rarely the contact center team and rarely the Microsoft team. Projects often get stuck right there.

Before any pilot, I would answer these questions:

- Which connector do we use, and what is its documented status today (not on the roadmap)?
- Which data leaves the contact center platform, in which direction, and how fast does it need to arrive? Real time assist and historical reports need very different things.
- What happens to a customer call when the connector is down? The answer should be "the contact center keeps working, just without AI". Test this.
- Who runs the connector day to day, including monitoring and incidents?

### Agent reuse is good, until versioning bites

Using the same Copilot Studio agent in several channels sounds good. One agent, one knowledge base, one place to fix wrong answers. The downside is that everything is linked. If the same agent serves your website and your phone line, a change you make for the website can change what callers hear. Voice is also less forgiving. Long answers, links and tables do not work when a voice reads them out.

My advice is to share knowledge and topics where it makes sense. But keep the contact center agent as its own agent with its own release process. Share the parts, not always the whole agent.

## 5. Governance implications

### Voice biometrics needs a governance owner before it needs a pilot

Voice biometric authentication is the feature where I would go slowly. The feature is fine. The hard questions are just not technical ones. A voiceprint is biometric data. Depending on your country and industry, you need consent, a clear purpose, retention rules and a way to delete the data. Your data protection officer will want to see all of this before go live. Here in Germany, and in the EU in general, I expect this discussion to take longer than the technical setup.

Questions to answer first:

- How do callers sign up, and how can they say no?
- What is the other way to log in, and is it just as secure?
- Who can delete a voiceprint, and how do you prove that it is gone?
- What happens when the system accepts the wrong person? The business has to decide how much risk is OK. This is not a setting in a portal.

None of this is special to Microsoft. It is the same for every voice biometrics product. But CCI makes the feature easy to switch on, and features that are easy to switch on are the ones where people skip governance.

### Quality assurance changes what you measure about people

When software checks every call, that is not the same as a supervisor listening to a few calls each month. Works councils and employee representatives will have an opinion on this, and in Germany they also have legal rights. Talk to them early. Say clearly whether the scores are for coaching or for performance reviews, and write it down. I have seen good AI projects stopped very late because this talk happened after the pilot and not before it.

### One builder, two governance models

Customer Assist agents use the same builder as Copilot Studio. So your Copilot Studio governance (environments, data loss prevention policies, who can publish) now also applies to the contact center. Check if your environment strategy has a good place for contact center agents. Otherwise they may end up in a shared environment next to test agents from marketing. I would plan separate environments for them, with their own policies and their own makers.

### Credits and cost planning

CCI agents use the Copilot Studio builder, so Copilot Credits are part of the cost. I have not seen a CCI price list that I would plan with. So I will not give any numbers here, and your business case should not include any either until Microsoft publishes them.

What you can do now is build the structure of the cost model. Then you only need to add the prices later:

- Volume: number of interactions per month per channel, how many go to self service agents, how many use real time assist, and how many go through quality assurance.
- Growth: AI use often grows after go live, because teams find new use cases. Plan for growth over time, not for a flat number.
- Ownership: decide which cost center pays for the credits the contact center uses. If the credits come from a pool that other Copilot Studio agents also use, one busy month in the contact center can leave other teams without credits. Track it separately from the first day. That is much easier than sorting it out later.
- Alerts: set up usage alerts before go live, not after the first surprise on the bill.

For most companies, the contact center is the channel with the most volume. Small costs per interaction add up faster there than anywhere else.

## 6. Practical recommendations

If a contact center architect asked me what to do for the rest of November, I would give them this list:

1. **Build the feature map.** List the CCI features, the tool that does each job today, the owner, and whether CCI should replace that tool or add to it.
2. **Know your connector.** Genesys Cloud or universal connector. If it is the universal one, name the person who builds and runs your side of it.
3. **Use roadmap dates for planning only.** Plan for November, but base go live decisions on what is documented on Learn, not on roadmap entries.
4. **Start the voice biometrics governance work now.** Data protection, consent, fallback, deletion. This part takes the longest.
5. **Talk to employee representatives about quality assurance** before anyone sees a dashboard with agent scores.
6. **Agree on a Copilot Studio environment strategy** for contact center agents, including who is allowed to publish.
7. **Build the cost model structure** with volumes and ownership, and leave the prices empty until Microsoft publishes them.
8. **Test a failure in the pilot.** Switch off the connector and check that the contact center still works.

## 7. Conclusion

CCI fills a real gap. Many companies will never move their contact center to Dynamics 365. Until now, that meant Microsoft AI did not reach their most important customer channel. One month into the preview, the documented scope is wide, and the roadmap says GA is close.

The useful work now is not reading more announcements. Decide which features you need. Understand the connector you depend on. Get the governance for voice biometrics and quality assurance started. And build a cost model that can handle Copilot Credits without surprises. Teams that do this in November can make a calm decision when GA comes, whenever that is. Teams that wait for the GA announcement will do the same work afterwards, just with more pressure.

Sources:

- [Contact Center Intelligence: What's new (Microsoft Learn)](https://learn.microsoft.com/en-us/contact-center-intelligence/implement/whats-new-contact-center-intelligence)
- [Copilot Studio October update (Microsoft Copilot blog)](https://www.microsoft.com/en-us/copilot/blog/copilot-studio/new-and-improved-agents-that-are-persistent-agents-for-customer-conversations-and-improved-maker-experience-in-microsoft-copilot-studio/)
