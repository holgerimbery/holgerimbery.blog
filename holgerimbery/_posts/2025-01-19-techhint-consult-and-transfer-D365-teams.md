---
layout: post
title: Tech Hint - Consult and transfer from Dynamics 365 Customer Service / Contact Center to Microsoft Teams - a step-by-step guide for the Voice Channel 
description: 
date: 2025-01-19
author: admin
image: ./images/2025/01/thisisengineering-t4qI2IDcL5s-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@thisisengineering?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">ThisisEngineering</a> on <a href="https://unsplash.com/photos/man-in-blue-and-white-checkered-button-up-shirt-sitting-beside-man-in-yellow-shirt-t4qI2IDcL5s?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
tags: [techhint, dynamics365, customerservice, contact-center, microsoftteams]
featured: false
toc: false
---

If you have upgraded to the enhanced voice experience (vNext) in Dynamics 365 Customer Service / Contactcenter , you can empower your representatives to consult with or transfer voice calls to subject matter experts (SMEs) in Microsoft Teams. This advanced feature is facilitated through Azure Communication Services Call Automation. By leveraging this capability, SMEs can seamlessly join customer service conversations directly from Microsoft Teams, eliminating the need to configure a separate phone number. Any Teams user within your tenant who appears in the Teams search box is eligible to receive calls from your customer service representatives. This integration ensures that your team can collaborate efficiently and provide timely assistance to customers, enhancing the overall service experience.

{: .important }
To allow the representatives to consult with Microsoft Teams users, enable the External Microsoft Teams users in Consult and Transfer settings in the voice channel section of the voice workstream.

Calling services are charged on a per minute per participant basis per participant per minute. Representatives can transfer or consult with Microsoft Teams users on certain Teams clients only.

{: .warning }
If the Teams user rejects the call or is unavailable, there isn't an option to leave a voicemail for the caller and the call isn't forwarded to another number. This is because the call from Dynamics 365 is considered a group call, and Teams doesn't honor voicemail or call forwarding settings when adding a Teams user to a group call.

{: .caution }
You must user enterprise voice in Microsoft Teams to enable the consult and transfer feature via Microsoft Teams tabm, if you are using a PBX for voice calls parallel to teams, you can't use the consult and transfer feature here, you have to use the **External number** tab

## Steps to enable consult and transfer from Dynamics 365 Customer Service to Microsoft Teams

* **Enhanced Voice Channel Activation**: The enhanced voice channel must be enabled for your organization. This feature is essential to facilitate the integration between Dynamics 365 and Microsoft Teams, allowing seamless voice communication and transfer capabilities.
* **Firewall Configuration**: Ensure that the following IP address ranges are allowed through your organization's firewall:
    * **Azure Communication Services** [ip ranges](https://learn.microsoft.com/en-us/azure/communication-services/concepts/voice-video-calling/network-requirements#firewall-configuration)
    * **Microsoft Teams**: [ip ranges](https://learn.microsoft.com/en-us/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide#skype-for-business-online-and-microsoft-teams)
* **Teams Phone System Licenses**: The Teams users who will be added to calls must have the appropriate Teams Phone System Licenses assigned. This licensing is crucial to enable the voice features within Microsoft Teams that are required for the consult and transfer process.
* **Enterprise Voice Enablement**: Enterprise Voice must be enabled within your Microsoft Teams environment. This setting is vital to ensure that the consult and transfer feature operates correctly, allowing representatives to connect with subject matter experts efficiently.


```shell
    Set-CSPhoneNumberAssignment –Identity [user email address] -EnterpriseVoiceEnabled $true
```


* **External Access Policy**  must be enabled.


```shell
    Set-CsExternalAccessPolicy -Identity Global -EnableAcsFederationAccess $true
```

* **Teams and Azure Communication Services federation**  for a Teams tenant must be enabled and the Azure Communication Services resources that can connect to Teams is specified. 

    * Get the immutable resource ID of the Azure Communications Service resource
    * Check for the powershell modules for Microsoft Teams with `Get-module *teams*`, if not installed, install it with the following commands
   
   
```shell
    Install-Module -Name MicrosoftTeams
    Update-Module MicrosoftTeams
```

* **Connect to Microsoft Teams** with  `Connect-MicrosoftTeams`.

* **Get Microsoft Teams Azure Communication Services allow list** with `Get-CsTeamsAcsFederationConfiguration` 

* **Add current Azure Communications Service resource ID** to these existing resource IDs  by setting the
new Teams Azure Communications Service allow list.

```shell
    $allowlist = @('<UPDATED_ACS_RESOURCE_IDs>') Set-CsTeamsAcsFederationConfiguration -EnableAcsUsers $True -AllowedAcsResources $allowlist
```











