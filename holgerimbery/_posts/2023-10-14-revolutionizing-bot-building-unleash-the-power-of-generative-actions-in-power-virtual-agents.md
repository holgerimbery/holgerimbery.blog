---
layout: post
title: Revolutionizing Bot Building - Unleash the Power of Generative Actions in Power Virtual Agents
date: 2023-10-14
author: admin
slug: revolutionizing-bot-building-unleash-the-power-of-generative-actions-in-power-virtual-agents
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-10-14-revolutionizing-bot-building-unleash-the-power-of-generative-actions-in-power-virtual-agents

---

 Note:  
 This article showcases a preview feature. Preview features are not intended for production use and may possess limited functionality. These features are made available prior to an official release, allowing customers to gain early access and offer feedback.

Generative answers (preview feature) can serve as a valuable resource when addressing user inquiries with Power Virtual Agents. Nevertheless, developers have conventionally depended on manually creating dialogues for each instance when invoking actions and APIs. This method is delicate and labor-intensive, as it can be challenging for developers to predict every potential action a user may require.

To address this challenge, Microsoft has announced the availability of new generative actions capabilities, now available in preview. With this new feature, bot creators can easily expose their tenant APIs, enterprise-specific Microsoft Power Automate flows, or other actions for the bot to utilize in conversations.

Here's how it works: The bot comprehends the user's request, searches its library of actions, and identifies those that can fulfill it. It then assembles and links them together and even generates questions for the user to gather any additional information needed to complete the request.

One of the key benefits of this approach is that it can save developers significant time and effort. Instead of manually crafting each dialogue, the bot can automatically generate the necessary questions and actions, allowing developers to focus on other tasks.

Furthermore, the author can observe the bot's reasoning, watch it evaluate and decide which tools to link, and see what questions it generates on the comprehensive generative actions-tracing canvas. This offers valuable insights into how the bot operates and can help developers refine and enhance its performance over time.

Generative answers and actions collectively contribute to a comprehensive transformation of bot building by increasing the productivity of bot authors. Instead of constructing and curating hundreds of dialogues for every potential user inquiry, bot authors can direct the system to the appropriate knowledge sources. There is no longer a need to anticipate and manually create dialogues for every conceivable joint action—just point to the correct set of connectors for existing APIs. The bot will assist with the rest.

Between answering user questions by chatting over proprietary company information to dynamically assembling APIs to take action and complete user requests, Power Virtual Agents and generative AI have changed bot building for the better—saving bot authors' time so they can focus on what's most valuable for their organizations.

## How to work with it in detail

### Add a plugin action

* Open your bot and select "Topics." On the Topics page, click the "+Add" button, and then choose "Plugin action (preview)."
    

![]({{site.baseurl}}/images/clnpzjx4j000009kzfhwda2l2.md/759f7083-264a-4e93-a9d9-fe450712d124.png)

* In the "Add an action (preview)" wizard now open, you can search for the plugin action you want to use within your bot.  
    Upon opening the wizard, the default list includes "Power Automate Flows" and "custom connectors" available in the environment, commonly used pre-built connectors, and Bot Framework Skills that have been registered with your bot.
    

![]({{site.baseurl}}/images/clnpzjx4j000009kzfhwda2l2.md/c308cc41-c4a0-43d2-8824-3240cc04b364.png)

* Select the action you want to use.  
    You will proceed to the wizard's next step to configure the action's connection. Once your connection has been successfully configured, click "Next."
    

![]({{site.baseurl}}/images/clnpzjx4j000009kzfhwda2l2.md/87ad8e5d-5247-4b63-ab0c-a1837739967e.png)

* Configure the display name and Description for your plugin action.  
    Typically, these are pre-populated based on the action you selected. On this page, you can decide whether you want your users to confirm the information they have provided before the plugin action is executed. This can often be helpful, particularly for actions that modify a user's data, such as inserting or updating a record in a table.
    
* To set up a confirmation, check the "Ask the user before running this action" box. You can then compose a message or create a card for your confirmation.  
    In both instances, you can use Power Fx to insert references to the input values that the user has provided.  
    The input values are stored in a Power Fx Record variable called. `Topic.Input.`  
    For example, when using the MSN Weather connector, the location entered by the user is inserted by adding `Topic.Input.Location` as a Power Fx snippet.
    
* Once you have configured your name, Description, and confirmation options, click "Next."
    

![]({{site.baseurl}}/images/clnpzjx4j000009kzfhwda2l2.md/56641ad3-9ba3-4b9e-b4dc-a16dfdfe125e.png)

* For each input on your action, you can now configure the **Display name** and **Description**.
    
* These are utilized to assist the bot in generating a question when your plugin runs, allowing it to request a value for the input from the bot user. For instance, a generated question for the location input demonstrated in the example might be, `"What location would you like to check the weather for? You can enter a City, Region, State, Country, Landmark, or Postal Code."`
    
* The Description of the input can impact the generated question. Additionally, you can modify the "Identify as" option to a specific entity type based on the input being gathered.
    

![]({{site.baseurl}}/images/clnpzjx4j000009kzfhwda2l2.md/c213b6d3-b944-4267-8584-91978b4a121e.png)

* Once you have configured your inputs, click "Next."
    

* You can now select one or more outputs that your plugin action should make available as variables for use within the topic or elsewhere in your bot.
    

* To add an output, click "Add" and then choose from the available outputs, which are determined by the action you selected at the beginning of the wizard.
    

![]({{site.baseurl}}/images/clnpzjx4j000009kzfhwda2l2.md/cab3afa5-4c2c-4088-a9ba-8651941fa02b.png)

* In addition to determining which variables are populated by your plugin action, you can also have your plugin action send a response back to the user once the action has been executed.
    
* The example demonstrates how the weather action has been run, and the bot aims to display the high and low temperatures to the user.
    
* Similar to the confirmation editor, you can insert references to output variables from the action using Power Fx, such as the `Topic.Output.responses.daily.tempLo` or `Topic.Output.responses.daily.tempHi` variable shown in this example.
    

![]({{site.baseurl}}/images/clnpzjx4j000009kzfhwda2l2.md/f8ef4e48-6669-4236-85f3-d598ecdbcb7b.png)

* Select Next to proceed to the final step in the wizard, where you can review your plugin action configuration. You can also go back to make changes.
    
* When you're satisfied with the configuration, select Add to complete adding your plugin action to your bot.
    
* Once added, your plugin can be viewed in the Plugin Actions (preview) tab on the Topics page.
    

![]({{site.baseurl}}/images/clnpzjx4j000009kzfhwda2l2.md/52549cf6-8d54-4531-b5dd-e33ab6684bc3.png)

### **Call a plugin action.**

To call a plugin action, explicitly invoke it from within a topic, just as you would with other action types, such as Power Automate Flows. Depending on your use case, you might incorporate your Flow as part of a broader topic that utilizes more nodes, or, as in the weather example, adding a single plugin action node to a topic might be all that is required.

* Go to the **Topics page.**
    
* Create a new topic, and name it **weather**.
    
* Add the following **Trigger phrases**:
    
    ```plaintext
    will it rain
    today's forecast
    get weather
    what´s the weather
    ```
    

![]({{site.baseurl}}/images/clnpzjx4j000009kzfhwda2l2.md/805c54e9-a7f0-4cd2-861e-f897de69cea1.png)

* Select "Add node (+)" and then choose "Call an action".
    
* Navigate to the "Plugin actions (preview)" tab and select the plugin action you previously created, "Get forecast for today".
    

![]({{site.baseurl}}/images/clnpzjx4j000009kzfhwda2l2.md/07e51959-4032-48a2-b5d1-222f72e31e1c.png)

* Save your work
    

### Overwriting input

* Select "Set value" on the node and choose the input you want to override.
    
* You can now enter the value you want to set the input by typing a value, selecting a variable, or using a formula.
    
* Now that this input has been overridden, the bot won't ask the user for a value.
    

![]({{site.baseurl}}/images/clnpzjx4j000009kzfhwda2l2.md/c224a0c7-8db1-4cff-8d19-ab6d4849aeaf.png)

### **Test your plugin action.**

Once you've added a plugin action to a topic, you can test it and see an output similar to the one displayed below.

![]({{site.baseurl}}/images/clnpzjx4j000009kzfhwda2l2.md/3606a40d-a958-40fd-a75a-eb27aafcb7ef.png)

GPT-driven conversations are more fluid than traditional, pre-written questions, enabling users to answer multiple questions in a single turn or modify previously entered values.

## Conclusion

In conclusion, generative actions in Power Virtual Agents revolutionize bot building by automating dialogue creation and enabling more dynamic conversations. This saves developers time and effort, allowing them to focus on other tasks while providing users with a more fluid and engaging experience.
