---
layout: post
title: "Dynamics 365 Customer Service: Design Your Own Live Chat Experience"
date: 2023-06-17
slug: dynamics-365-customer-service-design-your-own-live-chat-experience
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-06-17-dynamics-365-customer-service-design-your-own-live-chat-experience

---

## Motivation

As an escalation point, live chat is a critical aspect of text chatbots, providing a human touch to the interaction. While chatbots can handle basic inquiries, they may lack the capacity to manage complex or emotionally charged situations. By incorporating live chat options, customers can be directed to a human representative who can offer personalized assistance and address their concerns more effectively. This guarantees that customers receive the help they need and are likelier to have a positive experience with the company. Furthermore, live chat allows businesses to gain feedback from clients in real-time, which can inform improvements in their bot's capabilities and overall customer service strategy.

Microsoft offers an option to create a custom live chat widget, which can be linked to your Dynamics 365 Customer Service account. Each custom live chat widget element can be tailored for functionality and user interface.

Depending on your requirement and outcome, you can customize the chat widget using the customizable live chat widget 2.0.

## Utilize the Customizable Live Chat Widget 2.0.

The customizable Live Chat Widget 2.0 allows you to modify all aspects of the widget, including font, colors, and styling, enabling you to align the widget with your brand image. This tailored widget aids in building trust and credibility, setting your brand apart, nurturing positive emotional connections, and enhancing the value customers associate with your product.

The Live Chat Widget 2.0 is developed using the Omnichannel Chat SDK and Live Chat Widget UI Component Library.

## Revise the live chat widget script to enable Live Chat Widget 2.0.

To utilize Live Chat Widget 2.0 and script-based customization, alter the code snippet of the out-of-the-box Live Chat Widget 2.0 as follows:

* Open the chat workstream in the Customer Service Admin Center and select "Copy Live Chat Widget 2.0 Script" to copy the code snippet.
    
* Create a new JavaScript function that includes all component styling. For more information, refer to the [Omnichannel Chat Widget documentation](https://github.com/microsoft/omnichannel-chat-widget).
    
* Add "v2" after the script attribute.
    
* Include the "data-customization-callback" attribute and reference the JavaScript function lcw you create above.
    

The revised code snippet will appear as follows:

![Code snippet]({{site.baseurl}}/images/clizx3li406ew35nvcm66477p.md/1ed6a584-69b2-48d9-920f-0367ebd71893.png)

Figure: code snippet

![Resulting Chat Window]({{site.baseurl}}/images/clizx3li406ew35nvcm66477p.md/21768743-851e-4025-b3f8-2453e83046a5.png)

Figure: Resulting Chat Window

## Conclusion

Dynamics 365 Customer Service allows businesses to design their live chat experience using the customizable Live Chat Widget 2.0, which provides extensive customization options. Implementing these customizations can help strengthen brand identity, build trust, and enhance customer satisfaction.