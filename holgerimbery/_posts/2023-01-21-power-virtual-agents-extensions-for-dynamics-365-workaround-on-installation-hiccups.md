---
layout: post
title: Power Virtual Agents extensions for Dynamics 365 (workaround on installation hiccups)
description: 
date: 2023-01-21
author: admin
image: ./images/archive.jpg
tags: [archive]
featured: false
toc: true

---

# Power Virtual Agents extensions for Dynamics 365 (workaround on installation hiccups)

## Situation

You want to use Power Virtual Agent with Dynamics 365 Customer Service, and you are trying to install the extensions to activate [variables and actions](https://learn.microsoft.com/en-us/power-virtual-agents/configuration-hand-off-omnichannel#voice-based-capabilities).

![Figure 1: Message to documentation for installing the extensions]({{site.baseurl}}/images/cld5wh0dz000008mpcrvo2iqt.md/236e88ce-a85a-4ac0-8215-f67758feb1ea.png)

Figure 1: Message to [documentation](https://learn.microsoft.com/en-us/power-virtual-agents/configuration-hand-off-omnichannel#recommended-extensions) for installing the extensions.

You are following precisely the path described in the documentation,  
but you get an error message saying the solution is not compatible with your environment.  
In my case, all language settings are on en-US, but my tenant has a location in Germany.

![Figure 2: Error Message]({{site.baseurl}}/images/cld5wh0dz000008mpcrvo2iqt.md/88fe6d1e-e2a4-4d41-a4bc-314bd57a5cb8.png)

Figure 2: Error Message

## Motivation

This article is to overcome the situation for those running into the error.  
It is a "works-on-my-machine" solution and should help those who can fix it to find the root cause of it.

## Workaround

Here comes a dirty workaround to get it done in between.

Open the developer tools in your browser (Edge: CTRL+SHIFT+I) and open the Network Tab. While clicking on "install", you will see an error "400"

![Figure 3: error 400 while installing]({{site.baseurl}}/images/cld5wh0dz000008mpcrvo2iqt.md/415b6086-2fa3-489d-a191-b8d42d18cbcd.png)

Figure 3: error "400" while installing.

* right-click on the line with the error and

* select "Edit and Resend"

* Search for the Body of the "POST" Request.

![Figure 4: Body of "POST" Request]({{site.baseurl}}/images/cld5wh0dz000008mpcrvo2iqt.md/7d093278-17d7-40c3-ab0e-6ae48e040cbe.png)

Figure 4: Body of "POST" Request

* copy the body to an editor and

* find the "countryCode"; mine was set to DE,

![Figure 5: countyCode ]({{site.baseurl}}/images/cld5wh0dz000008mpcrvo2iqt.md/7934ea16-8d6f-4fd6-8b5c-312740a9efe1.png)

Figure 5: countryCode

* exchange the countryCode to "US"

```json
"countryCode" : "US"
```

* copy it back to developer tools and

* Click on the send button.

You will then recognize a result code "200" in the status line.

If you close the installation popup and go straight to the environment you want to install the extensions to, you will see that this "fix" was successful.

![Figure 6: Successful installing the extensions.]({{site.baseurl}}/images/cld5wh0dz000008mpcrvo2iqt.md/50d6d42f-310c-478b-9975-d1c2a4278e53.png)

Figure 6: Successfully installing the extensions.

![Figure 7: installed variables]({{site.baseurl}}/images/cld5wh0dz000008mpcrvo2iqt.md/d3918511-24d9-420d-83bb-daf4db8d78e3.png)

Figure 7: installed variables.

![Figure 8: Installed actions.]({{site.baseurl}}/images/cld5wh0dz000008mpcrvo2iqt.md/aa62e88f-978c-4541-90b9-9cb71908218c.png)

Figure 8: Installed actions.

## Conclusion

Do not give up when something unexpected happens. Find the root cause with the tools you have and give a first thought a try.
