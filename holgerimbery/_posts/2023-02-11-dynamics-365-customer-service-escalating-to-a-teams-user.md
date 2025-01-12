---
layout: post
title: Dynamics 365 Customer Service - escalating to a Teams User
description: 
date: 2023-02-11
author: admin
image: ./images/archive.jpg
tags: [archive]
featured: false
toc: true

---


# Dynamics 365 Customer Service - escalating to a Teams User

## Motivation

Service for Customers and employees is not always limited to Dynamics 365 Customer Service. The enterprise employees must often assist agents in customer service scenarios and talk to customers directly for highly technical or VIP engagements. With Dynamics 365, you can use a whole ecosystem to work with. You can enable your agents to consult with or transfer voice calls in Omnichannel for Customer Service to subject matter experts (SMEs) in Microsoft Teams.

The SMEs can participate in customer service conversations directly from Microsoft Teams to help agents in Dynamics 365 and customers on the phone call to resolve issues expertly.

## Prerequisites

The following prerequisites must be set for Microsoft Teams users:

* **SMEs must have a phone number assigned in Microsoft Teams**:

To update the Teams phone number in the user profile, perform the following steps:

1. Sign in to the [Azure portal and go to **Azure Active Directory**](https://aad.portal.azure.com/#view/Microsoft_AAD_UsersAndTenants/UserManagementMenuBlade/~/AllUsers).

2. Select **Manage** &gt; **Users**

3. Select the required user and select **Edit** to add the phone number in the **Contact info** &gt; **Office phone** field.

    ![Figure 1: Add phone number in Business Phone field]({{site.baseurl}}/images/cldzxrf0h07s3o1nv92vf064m.md/9bf0a544-2fe2-48e8-81ab-014c503eff28.png)

    Figure 1: Add phone number in Business Phone field

    Dynamics 365 uses Graph API to retrieve the number in the **Office phone** field.

## **Enable agents to consult with Microsoft Teams users**

You'll need to enable the Consult with Microsoft Teams user setting in the voice channel section to allow the agents to consult with Microsoft Teams users.

![Figure 2: Enable consult with Teams Part 1]({{site.baseurl}}/images/cldzxrf0h07s3o1nv92vf064m.md/9de0e8f2-2906-4ac5-ad73-96860fd11cf2.png)

Figure 2: Enable consult with Teams Part 1

scroll down to the end

![Figure 3: Enable consult with Teams Part 2]({{site.baseurl}}/images/cldzxrf0h07s3o1nv92vf064m.md/99819938-40a6-463f-aec4-e3fb4a6233b1.png)

Figure 3: Enable consult with Teams Part 2

## Conclusion

extending Dynamics 365 Customer Service to MS Teams users or external users can be done with little effort when using the Microsoft ecosystem. Microsoft Dynamics, Microsoft Teams, and Power Virtual Agents can act as the holy trinity of customer service.
