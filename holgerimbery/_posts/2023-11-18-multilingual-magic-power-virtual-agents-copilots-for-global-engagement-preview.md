---
layout: post
title: "Multilingual Magic: Power Virtual Agents / CoPilots for Global Engagement (preview)"
date: 2023-11-18
author: admin
slug: multilingual-magic-power-virtual-agents-copilots-for-global-engagement-preview
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-11-18-multilingual-magic-power-virtual-agents-copilots-for-global-engagement-preview

---

Multilingual bots are chatbots capable of communicating with customers in various languages while maintaining all content within a single bot. Often, they can automatically detect the preferred language and respond accordingly, offering customers a more personalized and engaging experience. This long-awaited feature is now on the horizon for Power Virtual Agents / Copilot Studio as a preview feature. There is no need to develop a separate bot for each required language.

 Disclaimer: This is a preview feature. Preview features are not intended for production use and may have limited functionality. Multilingual bots are not supported in the following scenarios:
 
 * Power Virtual Agents classic bots
     
 * Voice bots with Dynamics Omnichannel
     

## How to implement

To implement a bot as a multilingual bot:

* Open the desired bot.
    
* Expand the Languages (Preview) section in the side navigation pane.
    
* Click on Add Languages.
    

![]({{site.baseurl}}/images/clp3vr11t000f08l9ai5p9xss.md/f645727c-bf0a-461e-adc1-a41a01cba4d1.png)

* Select an additional language you wish to utilize.
    

![]({{site.baseurl}}/images/clp3vr11t000f08l9ai5p9xss.md/455d3242-51fa-46ee-bb26-e982748683af.png)

* Press "add languages"
    

![]({{site.baseurl}}/images/clp3vr11t000f08l9ai5p9xss.md/dcef9c37-eee3-442a-bc8f-c6009b7cbc86.png)

* download the language file after creation or after modification of your bot
    

![]({{site.baseurl}}/images/clp3vr11t000f08l9ai5p9xss.md/54ef1971-6efa-438a-aea3-a08a62d94a2a.png)

* You may want to use a translation tool to convert the .resx file or manually translate the strings.  
    One such tool you could use is, for example, [ResxTranslator](https://github.com/stevencohn/ResxTranslator)
    
* Upload the translated content and proceed to work with your bot as usual.
    

![]({{site.baseurl}}/images/clp3vr11t000f08l9ai5p9xss.md/32f9737f-2dc6-4bef-81a3-66f9b13798d9.png)

* Select the language on top of your "test chatbot" window to test your translated bot.
    

![]({{site.baseurl}}/images/clp3vr11t000f08l9ai5p9xss.md/886dc4e7-a044-4645-a274-5f2e050cbb1f.png)

## Next steps

When creating content, you can configure the bot to switch the spoken language during a conversation. This logic can be placed in any topic within the bot.

To change the bot's current language, set the User.Language variable value to one of your bot's secondary languages. This choice will immediately alter the language spoken by your bot.

## Conclusion

Power Virtual Agents now offers a preview feature for creating multilingual bots, allowing businesses to engage with customers in various languages using a single bot. By implementing and translating language files, companies can provide a more personalized and engaging experience for their global audience.
