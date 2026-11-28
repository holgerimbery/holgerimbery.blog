---
layout: post
canonical_url: https://holgerimbery.blog/gpt-6-2-sol-astra-copilot-model-governance
title: "New Models in Copilot: Who Decides, Who Pays and Who Has to Turn Them On"
description: "GPT-6.2 Sol and GPT-6.2 Astra are rolling out in Microsoft Copilot, Copilot Cowork and Copilot Studio. The model quality is the smaller story. The bigger one is control: a subprocessor setting gates Astra, usage-based billing applies in Cowork and Copilot Studio, and model choice has become a governance and budget decision that admins need to own."
date: 26-11-30
author: admin
slug: gpt-6-2-sol-astra-copilot-model-governance
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/12/chris-leipelt-4UgUpo3YdKk-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@cleipelt?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Chris Leipelt</a> on <a href="https://unsplash.com/photos/person-holding-airplane-control-panel-4UgUpo3YdKk?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a>
tags:
  - agentfinops
  - copilotcowork
  - copilotstudio
  - governance
  - microsoft365copilot
  - microsoftfoundry
  - modelchoice
  - openai
featured: true
toc: true
---

{: .q-left }
> In [Agent FinOps in the Microsoft Ecosystem](https://holgerimbery.blog/agent-finops-microsoft-ecosystem) I looked at where agent costs show up and which controls actually stop spending. This article looks at one concrete change in the same way: OpenAI's GPT-6.2 Sol and GPT-6.2 Astra are now in Microsoft Copilot. I care less about how good the models are. I care more about who decides which people get which model, who pays for it, and which setting has to be on before a model shows up.

## Introduction

New models used to arrive in the background. Microsoft changed something under the hood, answers got a little better, and nobody outside the Copilot team had to do anything. Most of my customers still think about model updates this way.

This is no longer the case. On November 20, 2026, Microsoft announced GPT-6.2 Sol and GPT-6.2 Astra in Copilot. I read the announcement together with the matching Message Center post and the admin documentation. I found three separate places where someone has to make a choice:

* Whether a model is available depends on the surface (Chat, the Office apps, Cowork, Copilot Studio) and on the user's program (Frontier or not).
* Whether Astra is available at all depends on a data processing setting that many compliance teams have never looked at.
* Whether using a model costs extra depends on where it is used. In the Office apps, Sol is part of the license. In Cowork and Copilot Studio, both models are billed by usage.

If nobody makes these choices, the default settings make them. Most of those defaults turn the models on.

In this article, I cover what Microsoft announced, why it matters more than a normal model update, what it means for architecture and governance, and what I am doing next.

A short note on naming. Microsoft's documentation says, "Microsoft 365 Copilot is now named Microsoft Copilot." I use "Copilot" in this article and keep the product names exactly as Microsoft writes them, so you can find the settings.

## What Microsoft announced

Four Microsoft posts from the same week cover this change. Each one tells a different part of the story, so I read them side by side.

### Microsoft Foundry, November 17, 2026

The models showed up first in Foundry. The Microsoft Foundry Blog post from November 17, 2026 says "OpenAI's GPT-6.2 Astra and GPT-6.2 Sol are generally available in Microsoft Foundry". It describes the two models for different jobs. For Astra, it says "the next reasoning model in the Astra family, built for the most demanding work". For Sol, it says this is the model "teams rely on for production agents that run all day, every day".

The same post adds a cost detail that I come back to later. Both models support 12-hour prompt cache writes on Standard deployments, next to the 30-minute default. The post is clear that "The 12-hour option is opt-in", and that a 12-hour write costs more than a 30-minute one. Later reuse is billed at the lower cache-read rate.

### Microsoft Copilot, November 20, 2026

Three days later, the Microsoft Copilot Blog published "Available today: OpenAI's GPT-6.2 Sol and GPT-6.2 Astra in Microsoft Copilot". The rollout details are short:

* GPT-6.2 Sol is rolling out worldwide to eligible users in Copilot Chat, Copilot Cowork, Copilot Studio, and Copilot in Excel, PowerPoint, and Word.
* GPT-6.2 Astra is rolling out worldwide to eligible users in Copilot Cowork and Copilot Studio.
* Frontier users can also use Astra in Copilot Chat and in Copilot in Excel, PowerPoint, and Word.

The post adds that "Availability may vary by region and organization" and that admins can manage access and configure availability "through the Microsoft 365 admin center".

### The Message Center post, November 19, 2026

The blog post leaves out the two details admins need most: billing and access. The Message Center post MC1560916 ("Microsoft Copilot: GPT-6.2 Sol and Astra rolling out", published November 19, 2026) covers them. I read it in a public community archive of Message Center posts, not in the admin center itself.

On billing, it says Astra rolls out "with usage-based billing (UBB)" in Cowork and Copilot Studio, and in Frontier to Word, Excel, PowerPoint, and Chat. Sol rolls out with usage-based billing in Cowork and Copilot Studio, and "as part of the Microsoft 365 Copilot user subscription license (USL)" in Word, Excel, PowerPoint, and Chat. For Sol in the license, it adds "Limits apply to this model."

On access, it says: "Access to GPT-6.2 Astra across all surfaces requires the OpenAI subprocessor to be enabled."

On defaults, it says the models "are enabled by default for eligible licensed users who meet the applicable configuration requirements" and that "No action is required for organizations that want users to access these models."

### Excel, November 24, 2026

The What's New in Excel post for November 2026 confirms the app side: "GPT-6.2 Sol is now available in the model picker in Copilot in Excel." It lists Frontier models in the Excel picker with usage-based billing, Astra among them. And it states a useful rule: "Usage-based billing models appear in the model picker only when your admin has enabled usage-based billing and allocated credits."

This table puts all four posts together.

| Surface | GPT-6.2 Sol | GPT-6.2 Astra | How it is paid |
|---|---|---|---|
| Copilot Chat | All eligible users | Frontier users | Sol: license. Astra: usage |
| Word, Excel, PowerPoint | All eligible users | Frontier users | Sol: license. Astra: usage |
| Copilot Cowork | All eligible users | All eligible users | Usage for both |
| Copilot Studio | All eligible users | All eligible users | Usage for both |
| Microsoft Foundry | Generally available | Generally available | Azure, per token |

On every Copilot surface, Astra also needs the OpenAI subprocessor setting to be on.

## Why it matters

### The model picker is now a billing boundary

The line between "included in the license" and "billed per use" used to run between products. Copilot in Word was licensed. Copilot Studio agents consumed credits. That rule was easy to remember.

With GPT-6.2, the line runs through the model picker instead. In Word, Sol is part of the license. In the same Word window, a Frontier user who picks Astra is on usage-based billing. The Excel post shows how this works: a usage-billed model only appears in the picker once usage-based billing is on and credits are allocated.

So what users see in the picker is the result of an admin setting. Say you turned on usage-based billing for Cowork a few months ago and gave everyone a broad policy. Then you may already have decided about Astra in the Office apps for your Frontier users, without anyone talking about Astra.

### "No action is required" means the defaults decide

The Message Center post says no action is required for organizations that want users to have these models. For eligible users with the right configuration, the models are on by default.

That helps adoption. It does not help a works council, a data protection officer, or a finance team that expected to be asked first. In German enterprises in particular, I regularly see AI rollouts that were approved for a specific scope. A new model in the picker can count as a change to that scope, even though the product name stays the same.

### Astra depends on a setting that was switched on in July

I expect this part to surprise people the most. The Microsoft Learn page on OpenAI as a subprocessor says that, as of July 24, 2026, "OpenAI operated models are enabled for all users for eligible commercial customers", unless an admin selects "No users".

The Message Center post says Astra "across all surfaces requires the OpenAI subprocessor to be enabled". Put the two together, and Astra will simply appear in many commercial tenants, because the setting it depends on was turned on by default four months ago. Tenants that set it to "No users" will not see Astra at all. In both cases, the result comes from a choice made (or not made) in July, long before anyone knew about Astra.

### Limits and helpdesk tickets

For Sol in the license, the Message Center post says limits apply. Microsoft adds that they "are implemented in such a way that the vast majority of users are not expected to reach them", and recommends that admins "Inform helpdesk and support teams that users may encounter usage-limit notifications."

This is good advice. A power user who sees a limit notification for the first time will open a ticket. If the helpdesk does not know that model limits exist, that ticket can get passed around for days.

## Architecture implications

### Same model name, different operator

The model name is the same in Foundry and in Copilot. Who runs the model is not necessarily the same, and that is the most important architecture point in this article.

The Learn page on the subprocessor setting draws a clear line. It describes "OpenAI models operated by Microsoft (Azure OpenAI)" and "OpenAI models operated by OpenAI (provided by OpenAI as a subprocessor)". It also says the setting controls "only whether OpenAI models operated by OpenAI" can be used, and that Microsoft-operated models stay available regardless.

When I read this together with the Message Center post, I come to this conclusion: GPT-6.2 Astra in Copilot reaches users through OpenAI as a subprocessor, while GPT-6.2 Astra in a Foundry deployment runs in Azure, with the deployment type you pick. The model family is the same, but the data takes a different path and different contract terms apply.

This has direct effects:

* **In-country processing.** The Learn page notes that OpenAI models delivered through the subprocessor in Copilot "are currently excluded from in-country processing commitments when applicable". If your Copilot rollout was approved because of in-country processing, that approval does not cover Astra in Copilot.
* **EU Data Boundary.** The same page says OpenAI-operated models "are included in the EU Data Boundary, except as otherwise noted in the EU Data Boundary documentation". For most of my European customers, this commitment matters more. But "except as otherwise noted" means someone has to read that documentation.
* **Government and sovereign clouds.** OpenAI-operated models are not available in GCC, GCC High, DoD, or sovereign clouds. If you run there, Astra in Copilot is not an option today.
* **Foundry residency.** In Foundry, the Data Zone Standard deployment keeps data processing in a selected data zone (US, EU, or APAC). That is a deployment choice you make per workload.

### When to build on which side

I get the question "Copilot Studio or Foundry?" in almost every customer workshop. GPT-6.2 does not change my basic answer. Both sides now offer the same model family, so the model is no longer a reason to pick one side. The other factors decide.

| Decision factor | Copilot (Chat, Cowork, Copilot Studio) | Microsoft Foundry |
|---|---|---|
| Grounding in Microsoft 365 data | Built in through Work IQ, within user permissions | You build it yourself |
| Who runs the model | Astra needs the OpenAI subprocessor | Azure deployment you choose |
| Data residency control | Tenant-level settings and commitments | Per deployment (Data Zone Standard) |
| How you pay | License (Sol in apps) or Copilot Credits | Tokens, per deployment type |
| Cost levers | Spending policies, per-agent limits | Prompt caching, deployment type, model choice |
| Evaluation tooling | Copilot Studio evaluations | Evaluation, tracing, monitoring |
| Who owns it | Microsoft 365 or Power Platform admins | Azure platform team |

The Copilot blog makes a good point here: "Work IQ grounds GPT-6.2 Sol and GPT-6.2 Astra in your files, meetings, chats, and business data", and it does that "within your existing permissions". If your scenario works with Microsoft 365 content and needs the user's own permissions, that is hard to rebuild in Foundry. I would not try.

If your scenario needs a specific residency guarantee, high volume, predictable cost per call, or a model that serves an application rather than a person, Foundry is the better fit. The Foundry post sums it up as "Same model, same code, only the deployment changes". That flexibility is the main reason to build there.

### Cost per task, not price per token

The Foundry post gives list prices for Standard deployments. For Global Standard with short context, Astra is listed at $8.00 per million input tokens and $40.00 per million output tokens. Sol is listed at $2.00 and $10.00. On list price, Astra costs four times as much as Sol per token, on both input and output. In the EU Data Zone, both are listed higher than Global Standard: Astra at $9.60 and $48.00, Sol at $2.40 and $12.00.

That ratio is not the full story. The same post says that in Foundry benchmark testing, Astra "achieved higher average accuracy than GPT-6 Astra with substantially fewer output tokens". Microsoft advises, "Look beyond price per token to cost per task, alongside quality and reliability."

I agree, and the same is true on the Copilot side, even though you see credits there instead of tokens. A model that costs more per step but finishes a Cowork task in fewer steps can be cheaper per result. A cheaper model that needs a second try is not. The only way to know is to measure real tasks, which I cover below.

### Prompt caching is a design decision

The 12-hour cache option in Foundry looks like a small feature, but it affects how I design long-running agents. Microsoft's guidance in the Foundry post is specific: choose 12 hours "when the same prefix would otherwise expire and be stored several times a day again", and keep the 30-minute default "where steady traffic already keeps the cache warm".

In practice, that means an agent with a large, stable system prompt and tool definitions, used in bursts during the working day, is a candidate for the 12-hour option. An agent with steady traffic is not, and turning the option on would only add write cost. The cache also only helps if the start of the prompt stays identical. So the order of the prompt (fixed parts first, changing parts last) affects cost, not only readability.

This option is a Foundry feature. On the Copilot side, you do not control caching. That is one more reason why you control cost there with policies, not with prompt design.

## Governance implications

### Model choice as an admin policy

I want every customer to answer one question clearly: who should get Astra, and why?

For most organizations, my answer is: not everyone, at least not at first. Microsoft describes Astra as a model for complex reasoning and multi-step work. The Foundry post suggests starting with Astra "for complex reasoning and high-stakes decisions", and evaluating Sol "for production agents, coding workflows, and high-frequency tasks where quality and cost both matter". In Copilot terms, the people who benefit most from Astra are the ones who hand off open-ended work in Cowork: analysts, finance teams preparing reports, architects writing long documents. Someone who mostly rewrites emails will not notice much difference, but will still use credits wherever Astra is billed by usage.

There are three settings you can use for this. None of them is a simple "this model for this group" switch:

* **The subprocessor assignment.** The Learn page says you can restrict access to AI provider subprocessors by user or Microsoft Entra ID security group, and that these assignments "are applied at the provider level and enforced across Microsoft Copilot and Copilot Studio experiences". You can use that to control who gets Astra. But it works for the whole provider. Restricting it also removes every other feature or model that relies on OpenAI as a subprocessor for the people outside the group.
* **Spending policies.** For Cowork, a spending policy is also an access control. If someone is not in a policy, they cannot use Cowork. In Excel, usage-billed models appear in the picker only when usage-based billing is on and credits are allocated. So how you set up your policies determines who can use Astra in Cowork at all, and how much.
* **Model profiles.** As I described in Agent FinOps in the Microsoft Ecosystem, spending policies can carry "model profiles", a saved set of at least two models attached to a policy. Microsoft documents them as "currently available only for Copilot Cowork". This is the closest thing to a model choice per group today, and it only covers Cowork.

In Copilot Studio, the decision sits somewhere else. The Learn page notes that "In Copilot Studio, creators must select the model during agent creation." So the model choice for an agent is made by the maker, inside an environment. Governance there means a clear environment setup, a hard credit limit per agent, and a simple rule about which models makers may use for which kind of agent.

### The subprocessor setting as a compliance gate

For compliance teams, the subprocessor setting is the place to start. Microsoft documents the path in the Microsoft 365 admin center: Copilot, then Settings, then View all, then "AI providers operating as Microsoft subprocessors". Changing it requires the AI Administrator or Global Administrator role.

I see three typical tenant states, and each needs a different conversation:

| Current setting | What happens with Astra | Conversation to have |
|---|---|---|
| All users (the default since July 24, 2026) | Astra appears for eligible users | Was this ever approved, and for which scope? |
| Specific users and groups | Astra appears only for those groups | Is the group still the right one for Astra? |
| No users | Astra is not available | Is that still intended, now that Astra exists? |

The first row worries me most. Many tenants are in that state without a written decision. Astra is a good reason to make that decision intentionally and document it: either confirm "All users" and note why, or move to access by group.

The Learn page also says the Microsoft Product Terms and the Data Protection Addendum apply to use of OpenAI models through Microsoft's enterprise Online Services, "except as otherwise disclosed in the Exclusions section". Your data protection officer should read that section, not my summary.

### Usage-based billing versus licensed use

The billing split is easy to follow once you see it side by side. Sol in Word, Excel, PowerPoint, and Chat is part of the user license, with limits. Sol and Astra in Cowork and Copilot Studio are billed by usage. Astra for Frontier users in the Office apps is billed by usage.

For budgeting, this means:

* **Licensed Sol has a ceiling you do not control.** The limits are set by Microsoft. You cannot raise them, and you should tell your helpdesk they exist.
* **Usage-billed models have a ceiling you do control.** In the Microsoft 365 admin center, that is the per-user limit in a spending policy. In the Power Platform admin center, it is the per-agent monthly limit with a hard stop. I covered both in detail in Agent FinOps in the Microsoft Ecosystem.
* **New models fall into existing policies.** A broad spending policy written for Cowork months ago now also covers a more expensive model choice. The limit still holds, but people may reach it sooner. That means more users will hit their monthly limit early, and more credit requests for admins.

For the license side, the overall rules for what is included and what is metered are in [Understanding Microsoft Copilot Licensing](https://holgerimbery.blog/copilot-pricing-licenses-and-credits). GPT-6.2 does not change those rules. It only adds a new place where they apply: the model picker.

### Who owns the decision

In most tenants I work with, four groups are involved in this change, and none of them owns it alone. Microsoft 365 admins manage the subprocessor setting and spending policies. Power Platform admins manage Copilot Studio environments and agent limits. The Azure platform team owns Foundry. Compliance and data protection own the approval of processing paths.

That is why I see model choice as a governance decision, not a feature switch. Someone has to own the question "which model for whom, at what cost, under which data processing terms". In my experience, it works best when one named person on the Copilot governance board owns it, and the others review. A shared mailbox is not an owner.

## Practical recommendations

This is what I am doing with my customers over the next weeks, in this order.

### 1. Read the current subprocessor state and document it

First, I check the "AI providers operating as Microsoft subprocessors" page in the Microsoft 365 admin center and note who has access to OpenAI-operated models today. If it says "All users" and nobody can point to a decision, it goes on the agenda of the next governance meeting, with Astra as the reason. I do not change the setting before that meeting. Switching it off for everyone also removes other features that rely on the provider, and that should be a conscious choice too.

### 2. Define who gets Astra with a group

Next, I define one Entra security group for Astra users, starting with people who do multi-step work in Cowork. That group is used in two places: in the subprocessor assignment, if the customer chooses group-based access, and in a Cowork spending policy with its own per-user limit. Where model profiles are available, the policy gets a profile that matches the group's purpose.

### 3. Check the spending policies against the new models

Then I go through every Cowork spending policy and ask one question: was this limit set before a more expensive model was in the picker? If yes, I look at the last full month's consumption and decide whether the limit still fits. I also check whether the "Auto-apply new services" setting is still on, as I described in Agent FinOps in the Microsoft Ecosystem.

### 4. Set rules for makers in Copilot Studio

For Copilot Studio, I write a short rule for makers: which model is the default for new agents, when Astra is allowed, and who approves it. Every production agent that uses Astra gets a monthly credit limit with a hard stop. For agents that run all day at high volume, Sol or a Foundry deployment is usually the better choice.

### 5. Brief the helpdesk

I send a short note to the helpdesk with three points. New models are in the picker. Licensed models have usage limits, and users may see limit notifications. Usage-billed models only appear when the user is in a spending policy, so "I do not see Astra" is usually a policy question, not a bug.

### 6. Test with evaluations, not opinions

This step takes the most time, and teams skip it most often. The Foundry post says it clearly: "The right model for each job should be determined through evaluations." Still, in most organizations the first opinion on a new model comes from two keen users and one skeptic after a day of trying it.

What I do instead:

* **Collect real tasks.** I take a set of tasks that people actually do today, with an expected result or clear criteria for a good result. For a Copilot Studio agent, these are real questions from its transcripts. For Cowork, these are real hand-off tasks from the pilot group.
* **Write the decision rule first.** Before running anything, I write down what "better" means. For example: equal or better quality on the criteria, with cost per task inside a defined range. If I write the rule after I see the results, I will find a reason to pick whatever I already liked.
* **Run the same set on each model.** For Copilot Studio agents, I use the built-in evaluations and run the same test set against the current model, Sol, and Astra. For Foundry workloads, I use Foundry's evaluation, tracing, and monitoring.
* **Measure cost per result.** In Cowork, users can type /cost to see what a task used. In Copilot Studio, I use the consumption reports per agent. In Foundry, I look at tokens per task, including cache reads. Price per token alone does not tell me much.
* **Count failures and retries.** A model that needs a second try one time in five costs more, and annoys users more, than its price suggests.

Running evaluations costs credits too, so I keep the test sets small and focused. A small test set that someone actually reviews tells me more than a large one that nobody looks at.

{: .caution }
Model choice affects cost per task in both directions. A more capable model can finish in fewer steps, or it can do more work than the task needed. Only a measured test on your own tasks shows which one applies to your scenario.

### 7. Revisit when the next model arrives

GPT-6.2 will not be the last model in the picker. The Excel post already lists several Frontier models with usage-based billing in one picker. I am adding a fixed item to the governance board's agenda: when a new model appears in the Message center, the board decides on audience, billing, and processing terms within a fixed time, and reuses the evaluation set from step 6 for the comparison.

## Conclusion

GPT-6.2 Sol and GPT-6.2 Astra may well be better models. But that is not what changes the work of admins. What changes it is that each model now comes with its own access rule, its own billing path, and its own data processing terms, and that the defaults turn most of this on.

Sol is simple. It reaches licensed users in the Office apps and Chat as part of the license, with limits, and in Cowork and Copilot Studio through usage-based billing. Astra needs more decisions. It depends on a subprocessor setting that was enabled by default in July; it is billed by usage wherever it appears, and it is processed differently from the same model in a Foundry deployment.

The next step I am taking is to put the subprocessor setting and the Astra audience on the agenda of each customer's Copilot governance board before the rollout reaches their users. After that comes the evaluation work; it is slower than asking a few people what they think, but it is the only way I know to make a model choice that still makes sense when finance asks about it.

## Sources

- Microsoft Copilot Blog, [Available today: OpenAI's GPT-6.2 Sol and GPT-6.2 Astra in Microsoft Copilot](https://techcommunity.microsoft.com/blog/microsoft-copilot-blog/available-today-openais-gpt-6-2-sol-and-gpt-6-2-astra-in-microsoft-copilot/4574229), November 20, 2026: rollout surfaces for Sol and Astra, Frontier access, availability may vary, admin control in the Microsoft 365 admin center, Work IQ grounding within permissions
- Microsoft Foundry Blog, [GPT-6.2 Astra and GPT-6.2 Sol now generally available in Microsoft Foundry](https://techcommunity.microsoft.com/blog/azure-ai-foundry-blog/gpt-6-2-astra-and-gpt-6-2-sol-now-generally-available-in-microsoft-foundry/4574122), November 17, 2026: general availability, model positioning, evaluation guidance, cost per task, opt-in 12-hour prompt cache writes on Standard deployments, deployment types, list prices
- Microsoft Excel Blog, [What's New in Excel (November 2026)](https://techcommunity.microsoft.com/blog/excelblog/whats-new-in-excel-november-2026/4573867), November 24, 2026: GPT-6.2 Sol in the Excel model picker, Frontier models with usage-based billing, picker visibility rule
- Microsoft Learn, [OpenAI as a subprocessor in Microsoft Online Services](https://learn.microsoft.com/en-us/copilot/implement/openai-subprocessor), read November 27, 2026: Microsoft-operated versus OpenAI-operated models, default since July 24, 2026, admin path and roles, group-based assignment, in-country processing exclusion, EU Data Boundary, cloud availability, model selection in Copilot Studio
- **Not a Microsoft page.** Community archive of Message Center post [MC1560916: Microsoft Copilot: GPT-6.2 Sol and Astra rolling out](https://mc.merill.net/message/MC1560916), published November 19, 2026: usage-based billing versus license per surface, limits for Sol in the license, subprocessor requirement for Astra, default enablement, helpdesk recommendation. Check the original post in your tenant's Message Center.
- Related articles: [Agent FinOps in the Microsoft Ecosystem](https://holgerimbery.blog/agent-finops-microsoft-ecosystem) (spending policies as access control, model profiles for Cowork, per-agent limits, /cost, Auto-apply) and [Understanding Microsoft Copilot Licensing](https://holgerimbery.blog/copilot-pricing-licenses-and-credits) (what the license includes and what is metered)
