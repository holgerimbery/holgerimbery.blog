---
layout: post
title: Add User Authentication to Topics
description: Learn how to add user authentication to specific topics in Microsoft Copilot Studio, enhancing security for sensitive information access.
date: 2025-06-28
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/06/ed-hardie-RMIsZlv8qv4-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@edhardie?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Ed Hardie</a> on <a href="https://unsplash.com/photos/a-screenshot-of-a-phone-RMIsZlv8qv4?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
category: [copilotstudio, agent, authentication]
author: admin
featured: true
toc: true
---

{: .important}
**Content Classification**  
Content for IT architects - Level 100 (Background & Integration knowledge)

{: .important}
**Summary Lede**:
In the evolving landscape of conversational AI, ensuring secure access to sensitive information is crucial. Microsoft Copilot Studio provides robust authentication features that allow developers to implement agent- and topic-level authentication, enhancing security while maintaining user experience. This article explores how to configure these authentication mechanisms effectively.


## **Introduction**
As organizations increasingly rely on conversational AI to streamline operations and enhance user experiences, securing access to sensitive information becomes paramount. Microsoft Copilot Studio offers a powerful feature that allows developers to add end-user authentication to specific topics within their bots, ensuring that only authorized users can access protected content or perform sensitive actions.

In Microsoft Copilot Studio, authentication mechanisms can be configured at two distinct levels: agent-level and topic-level. This dual-layered approach to security allows organizations to tailor access controls based on the sensitivity of the information being handled and the specific business processes involved.

### **Agent-Level Authentication**: Securing the Entire Agent Experience
Agent-level authentication is applied globally across the entire agent. This means that users must authenticate themselves before interacting with any part of the bot. This is particularly useful in scenarios where the entire bot is designed to handle sensitive or proprietary information.

**Example**: In a financial services firm, an agent designed to assist investment advisors might require agent-level authentication to ensure only authorized personnel can access the bot. This bot might provide access to client portfolios, market analysis tools, and internal investment strategies. By enforcing authentication at the agent level, the organization ensures that all interactions are traceable and secure, aligning with regulatory requirements such as FINRA or MiFID II.

### **Topic-Level Authentication**: Granular Access Control for Sensitive Workflows
Topic-level authentication, on the other hand, allows for selective security enforcement. Users can interact with general topics freely, but are prompted to authenticate when they attempt to access specific, sensitive issues. This approach is ideal for bots that serve a broad range of use cases, only some of which involve confidential data.

**Example 1**: HR Agent In a Human Resources agent, general queries like "What's the company holiday policy?" or "How do I apply for parental leave?" can be accessed without authentication. However, when a user asks to "View my latest payslip" or "Update my bank account details," the bot triggers topic-level authentication. This ensures that only the rightful employee can access or modify personal financial data, supporting compliance with GDPR and internal data governance policies.

**Example 2**: Customer Support Agent In a retail or e-commerce setting, a customer support Agent might handle general FAQs and account-specific queries. While questions like "What is your return policy?" can be answered openly, requests such as "Track my recent order" or "Update my shipping address" would require the user to authenticate. This protects customer data and prevents unauthorized access to personal order history or account settings.

**Example 3**: Healthcare Agent In a healthcare environment, a patient-facing Agent might provide general wellness tips or clinic hours without authentication. However, when a patient asks to "View my lab results" or "Schedule a follow-up appointment with Dr. Müller," topic-level authentication ensures that only the patient (or an authorized caregiver) can proceed. This is critical for compliance with HIPAA or EU health data regulations.

**Business Benefits of Layered Authentication**
Implementing both agent-level and topic-level authentication provides several strategic advantages:

Enhanced Security Posture: Sensitive data is protected without overburdening users with unnecessary authentication steps.
Regulatory Compliance: Supports adherence to industry-specific regulations and data protection laws.
Improved User Experience: Users can access general information quickly while ensuring that sensitive workflows are secure.
Operational Efficiency: Reduces the risk of data breaches and unauthorized access, which can be costly and damaging to the brand reputation.


## prepare the basics
### Configure manual authentication with Microsoft Entra ID

Before implementing authentication, you must establish the foundation by setting up Microsoft Entra ID (formerly Azure Active Directory) as your authentication provider. This prerequisite step creates the secure identity framework your agent will use to verify user credentials when accessing protected topics.

Microsoft Entra ID integration enables your agent to leverage enterprise-grade authentication mechanisms, including support for multi-factor authentication, conditional access policies, and comprehensive user management capabilities that align with your organization's security requirements.

For detailed implementation instructions and step-by-step guidance, refer to the official Microsoft documentation on configuring user authentication with Microsoft Entra ID for Copilot Studio (Configure user authentication with Microsoft Entra ID)[https://learn.microsoft.com/en-us/microsoft-copilot-studio/configuration-authentication-azure-ad].

## Add user authentication with the Sign in system topic
When you create an agent, Copilot Studio automatically adds a system topic called Sign in. You'll need to set your agent's authentication to manual and require users to sign in to use it. When a customer starts a conversation with the agent, the Sign in topic triggers and prompts the user to sign in. You can customize the Sign-in topic to suit your agent.

* Open your agent in Copilot Studio, select **Settings** at the top of the page, and then select **Security**.

* Select **Authentication**.

* Select **Authenticate manually**, and then select **Require users** to sign in.

* Configure all manual authentication fields (see below), as required.
* Select **Save**.

## Add user authentication with a custom topic
The **Sign in topic** authenticates the user at the beginning of the conversation. You can add an Authenticate node to any custom topic to allow the user to sign in later.

Customers who enter their username and password might be prompted to enter a validation code. After they sign in, they're not prompted again, even if they reach another Authenticate node.

* Select **Settings** at the page's top, then select **Security**.

{: .Note }
You must select Authenticate manually to add user authentication to a custom topic.

* Select the Authentication tile.


* Clear the "Require users to sign in" checkbox.

* Configure **all manual authentication fields**, as required.

* Select **Save**.

* Select **Topics** at the top of the page.

* Select **Add node + ** > Advanced > Authenticate.

## Manual authentication fields
The following are all the fields you can see when configuring manual authentication. Which fields you see depends on your choice of service provider.

| **Field Name**                         | **Description**                                                                                                                                                                                                                      |
|----------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Authorization URL template             | The URL template for authorization, as defined by your identity provider. For example, `https://login.microsoftonline.com/common/oauth2/v2.0/authorize`.                                                                             |
| Authorization URL query string template | The query template for authorization, as provided by your identity provider. Keys in the query string template vary, depending on the identity provider (`?client_id={ClientId}&response_type=code&redirect_uri={RedirectUrl}&scope={Scopes}&state={State}`). |
| Client ID                              | Your client ID obtained from the identity provider.                                                                                                                                                                                  |
| Client secret                          | Your client secret obtained when you created the identity provider app registration.                                                                                                                                                 |
| Refresh body template                  | The template for the refresh body (`refresh_token={RefreshToken}&redirect_uri={RedirectUrl}&grant_type=refresh_token&client_id={ClientId}&client_secret={ClientSecret}`).                                                           |
| Refresh URL query string template      | The refresh URL query string separator for the token URL, usually a question mark (`?`).                                                                                                                                             |
| Refresh URL template                   | The URL template for refresh; for example, `https://login.microsoftonline.com/common/oauth2/v2.0/token`.                                                                                                                             |
| Scope list delimiter                   | The separator character for the scope list. Empty spaces aren't supported in this field.                                                                                                                                             |
| Scopes                                 | The list of scopes you want users to have after signing in. Use the Scope list delimiter to separate multiple scopes. Only set necessary scopes and follow the least privilege access control principle.                            |
| Service provider                       | The service provider you want to use for authentication. For more information, see OAuth generic providers.                                                                                                                          |
| Tenant ID                              | Your Microsoft Entra ID tenant ID. You can refer to "Use an existing Microsoft Entra ID tenant" to learn how to find your tenant ID.                                                                                                |
| Token body template                    | The template for the token body (`code={Code}&grant_type=authorization_code&redirect_uri={RedirectUrl}&client_id={ClientId}&client_secret={ClientSecret}`).                                                                         |
| Token exchange URL (required for SSO)  | This optional field is used when configuring single sign-on.                                                                                                                                                                         |
| Token URL template                     | The URL template for tokens, as provided by your identity provider; for example, `https://login.microsoftonline.com/common/oauth2/v2.0/token`.                                                                                       |
| Token URL query string template        | The query string separator for the token URL, usually a question mark (`?`).                                                                                                                                                         |

## Conclusion
Incorporating user authentication into Microsoft Copilot Studio agents is critical for safeguarding sensitive information and ensuring compliance with industry regulations. By leveraging agent-level and topic-level authentication, organizations can create a secure yet user-friendly environment for their conversational AI applications.
This layered approach enhances security and user experience by allowing seamless access to general information while protecting sensitive workflows. As organizations continue to embrace AI-driven solutions, implementing robust authentication mechanisms will be essential for maintaining trust and security in digital interactions.      
