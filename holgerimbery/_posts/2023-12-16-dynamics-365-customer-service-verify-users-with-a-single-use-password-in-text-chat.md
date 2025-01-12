---
layout: post
title: Dynamics 365 Customer Service - Verify Users with a Single-Use Password in Text Chat
date: 2023-12-16
author: admin
slug: dynamics-365-customer-service-verify-users-with-a-single-use-password-in-text-chat
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-12-16-dynamics-365-customer-service-verify-users-with-a-single-use-password-in-text-chat

---

## Motivation

In the digital world, ensuring the security and integrity of user data is paramount. One of the key ways to achieve this is through user authentication in text and voice chats and the use of One-Time Passwords (OTPs). Let's delve into the benefits of these security measures.

### User Authentication in Text Chats

User authentication in text chats is more than just a login process. It's a crucial security measure with several benefits:

1. **Identity Verification**: Authentication verifies the identity of the user, ensuring that the person behind the screen is indeed who they claim to be. This is a critical step in maintaining the integrity of user data and preventing unauthorized access.
    
2. **Data Protection**: User authentication protects sensitive data from falling into the wrong hands. This is particularly important in text chats where personal or confidential information may be shared.
    
3. **Accountability**: Authenticated users have their actions tracked and logged. This level of accountability can deter misuse and is invaluable when auditing is required.
    

### The Power of One-Time Passwords

One-Time Passwords (OTPs), typically sent via email or text message, are another powerful tool in the cybersecurity arsenal. Here's why:

1. **Prevent Replay Attacks**: OTPs are valid for only one login session or transaction, preventing replay attacks where an attacker might try to reuse a password intercepted in transit.
    
2. **Ease of Use**: OTPs do not require users to remember complex passwords, making them user-friendly while still maintaining a high level of security.
    

While these methods significantly enhance security, it's important to remember that no system is entirely foolproof. Continual updates and reviews of security protocols are necessary to address emerging threats. In the ever-evolving landscape of cybersecurity, staying one step ahead is the key to safeguarding your digital assets.

## Implementation

To start with the basics to identify the user, we implement a pre-conversation survey in our text chat workstream. How to set this up, was described in an [earlier article](https://the.cognitiveservices.ninja/dynamics-365-customer-service-effortlessly-detect-clients-in-conversations).  
In this example, we ask three questions.  
The user´s name, the email address (for returning/registered customers), and the consent for our T&Cs.

![]({{site.baseurl}}/images/clq80jcqw000i08ju3yew0dvp.md/e1c2067b-e4fa-4930-a595-dca894977ee8.png)

### Prerequisites

* Create a flow to check if the entered name is a contact in your D365 contact database and if yes, if the entered email address is identical to the email address in the account record.
    
* Add this flow to the "Conversation Start" topic with a question, asking the user. to authenticate.
    

![]({{site.baseurl}}/images/clq80jcqw000i08ju3yew0dvp.md/41f3bb8d-bc59-4425-baf8-aa68908f095f.png)

### Authentication as a topic

* Create a new topic without trigger phrases and integrate it into the true condition of the "start conversation" topic.
    
* first, use the checked email and inject it into a flow  
    "generate the verification code"
    

![]({{site.baseurl}}/images/clq80jcqw000i08ju3yew0dvp.md/dbc090a5-35db-4300-9c6d-c124118888fb.png)

* The generated code is the output of the flow and is stored in a variable. The flow itself sends the code to the user's registered email address.
    
* Ask the user to input the code using a question node.
    
    ![]({{site.baseurl}}/images/clq80jcqw000i08ju3yew0dvp.md/c8351c89-8719-4604-94e2-2bfc8f810fd9.png)
    
    * Verify the code using another flow, "Validate the code."
        

![]({{site.baseurl}}/images/clq80jcqw000i08ju3yew0dvp.md/8fbe48fe-ee9f-40ce-9707-59942328b1cb.png"left")

### Flow 1: generate verification code

![]({{site.baseurl}}/images/clq80jcqw000i08ju3yew0dvp.md/9b5fea2b-a471-4a40-9e3c-5ecb6bf8c327.png)

* Create the flow as shown above with `CodeLength`.
    

![]({{site.baseurl}}/images/clq80jcqw000i08ju3yew0dvp.md/9eb3e1e2-4304-417f-9397-6753f7c9575f.png)

* Use a formula like:
    

`plaintext substring(replace(guid(), '-', ''), 0, min(variables('CodeLength'), 32))`to create the verification code.

![]({{site.baseurl}}/images/clq80jcqw000i08ju3yew0dvp.md/2458197e-4fb3-4f07-a752-5578418389c0.png)

* Use an email template like the following to send the code to the user:
    

### Flow 2: Validate the code.

Use a simple check to verify the code and return a Boolean value the topic.

![]({{site.baseurl}}/images/clq80jcqw000i08ju3yew0dvp.md/44382631-3a35-4c4c-b3af-71518eea635a.png)

## Conclusion

In the digital age, ensuring the security of user data is paramount. User authentication in text chats using One-Time Passwords (OTPs) is one method to achieve this. This helps verify identity, protect sensitivity, and deter misuse by maintaining accountability. To implement user authentication in your Dynamics 365 Customer Service text chat workstream, create a pre-conversation survey to collect usernames and email addresses and integrate two flows: one to send an OTP to the user and another to validate the code.