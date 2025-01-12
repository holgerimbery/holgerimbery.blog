---
layout: post
title: "Comparing Power Virtual Agents for Microsoft Teams vs Standalone Subscription: Which One to Choose?"
date: 2023-04-29
author: admin
slug: power-virtual-agents-licensing
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-04-29-power-virtual-agents-licensing
---

## Motivation

I do Power Virtual Agents in a Day Workshop with many participants every month.  
And every month, I get asked one question most of them have:  
There is Power Virtual Agents as a standalone paid offer and Power Virtual Agents as a combined offer in Microsoft 365 subscriptions; what should I choose?  
Is it really for free, and are there differences in the offering?  
Yes, there are some significant differences.  
Please find the answer and a Conclusion in this article.

## **Power Virtual Agents for Microsoft Teams plan**

Power Virtual Agents for Microsoft Teams is a feature that allows users to create conversational interfaces **within *Microsoft Teams***, using data stored in **Microsoft *Dataverse for Teams*** and other sources through ***standard connectors***.  
This feature is available in selected Microsoft 365 subscriptions. To determine which plan is best for your needs, compare the key capabilities of the Power Virtual Agents for Microsoft Teams plan and the standalone Power Virtual Agents subscription, as presented in the comparison table provided in the article.

See the [Microsoft Power Platform Licensing Guide](https://go.microsoft.com/fwlink/?linkid=2085130) for a complete list of differences.

Also, see the [Quotas, limits, and configuration values](https://learn.microsoft.com/en-us/power-virtual-agents/requirements-quotas) topic for other capacity considerations.

| Capability | Select Microsoft 365 subscriptions. | Power Virtual Agents subscription |
| --- | --- | --- |
| Deploy bot to channels | [Microsoft Teams](https://learn.microsoft.com/en-us/power-virtual-agents/teams/publication-add-bot-to-microsoft-teams-teams) | [Any channel supported by Power Virtual Agents](https://learn.microsoft.com/en-us/power-virtual-agents/publication-fundamentals-publish-channels) |
| Power Automate connectors | [Standard connectors available for flows triggered from Power Virtual Agents](https://learn.microsoft.com/en-us/power-virtual-agents/teams/advanced-flow-teams) | [Premium connectors available for flows triggered from Power Virtual Agents](https://learn.microsoft.com/en-us/power-virtual-agents/advanced-flow) |
| Web security | [Secure access is enabled by default, with no ability to generate secrets to enable secure access](https://learn.microsoft.com/en-us/power-virtual-agents/teams/configure-web-security-teams). | [Ability to generate secrets and turn on or off secure access as wanted by the bot author](https://learn.microsoft.com/en-us/power-virtual-agents/configure-web-security) |
| Use Microsoft Bot Framework skills | Not available | [Ability to extend Power Virtual Agents bots with Microsoft Bot Framework skills](https://learn.microsoft.com/en-us/power-virtual-agents/advanced-use-skills) |
| Use a Power Virtual Agents bot as a Bot Framework skill | Not available | [Use a Power Virtual Agents bot as a skill](https://learn.microsoft.com/en-us/power-virtual-agents/advanced-use-pva-as-a-skill) |
| Integrate Microsoft Bot Framework dialogs | Not available | [Develop custom dialogs with Bot Framework Composer](https://learn.microsoft.com/en-us/power-virtual-agents/advanced-bot-framework-composer) |
| Handoff bot conversation to a live agent | Not available | [Trigger handoff to a live agent](https://learn.microsoft.com/en-us/power-virtual-agents/advanced-hand-off) |

## Conclusion

Based on the comparison table provided in the article, if you need to integrate your bot into ***other channels*** such as Microsoft Teams, require ***premium connectors***, or ***hand off conversations*** to a human, it is recommended to use the standalone version of Power Virtual Agents.  
However, if you have a select Microsoft 365 subscription and do not require these features, you can use Power Virtual Agents for Microsoft Teams to create conversational interfaces within Microsoft Teams.

Suppose you want to integrate your bot into other channels such as Microsoft Teams, e.g., to use it as a voice bot within or in front of a contact center. In that case, if you want to use premium connectors or need to use them, you want to hand them off to a human, or you want to use the bot as a skill, you must use the standalone version of Power Virtual Agents.