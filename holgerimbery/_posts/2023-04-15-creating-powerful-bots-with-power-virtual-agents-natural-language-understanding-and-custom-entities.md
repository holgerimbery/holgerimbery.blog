---
layout: post
title: "Creating Powerful Bots with Power Virtual Agents' Natural Language Understanding and Custom Entities"
date: 2023-04-15
author: admin
slug: creating-powerful-bots-with-power-virtual-agents-natural-language-understanding-and-custom-entities
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-04-15-creating-powerful-bots-with-power-virtual-agents-natural-language-understanding-and-custom-entities
 

---

Power Virtual Agents is a virtual digital assistant SaaS Solution that uses Natural Language Understanding (NLU) to comprehend user intentions. NLU enables the bot to detect trigger phrases and identify entities within a user interaction, from phone numbers to zip codes and even names. Power Virtual Agents offers pre-constructed entities for commonly used data, such as ages, colors, numbers, and names, and allows for creating custom entities using closed list entities or regular expression entities. In addition, slot filling, a natural language understanding concept that saves an extracted entity to an object, which helps the bot provide more personalized and accurate responses based on the user's specific needs, can be used.

## Prebuild entities

Power Virtual Agents offers a range of pre-constructed entities, allowing it to recognize a variety of commonly used data in conversations, including ages, colors, numbers, and names. This allows the bot to understand the context of a user's input and store this information for future use.

![]({{site.baseurl}}/images/clghwcxj909huh0nveiym3byb.md/00dfdc4d-a586-4843-aaa9-c2521002fa85.png)

Figure: Prebuild entities

## Custom entities

In specific scenarios, such as when crafting a bot for a specialized task, the pre-defined entities may not be sufficient. In this instance, you must instruct the machine learning model associated with the bot to comprehend domain-specific information.

For example, if you wish to create a bot to help people find parking spots, you must enable the bot to recognize the type of "vehicle" to park during the conversation. To do this, a tailor-made entity must be generated. In this instance, one can build an entity that gives the bot an understanding of the various vehicle types.

### Closed list entities

A closed list entity allows you to create a curated group of items. This is best suited for short, manageable lists that have essential labels. In this example, you can construct an entity that gives the bot insight into the various types of vehicles. Creating an entity will display a panel where you can name the entity, add a concise description, and input the elements you want to be included.

![]({{site.baseurl}}/images/clghwcxj909huh0nveiym3byb.md/35bbddfa-47e6-41ef-aeb2-4e351a9be52a.png)

Figure: Closed List

![]({{site.baseurl}}/images/clghwcxj909huh0nveiym3byb.md/147cbbad-9d2e-4850-a3f5-c7d6d0964e85.png)

Figure: Create new custom entity "vehicles"

When you enter items, you can:

* Select each item to change its name.

* Select the trash can icon to delete the item from the list.

* Select **\+ Synonyms** (or select the listed synonyms if they've already been added) to open the **Edit Synonyms** pane.

You can add synonyms to manually expand the matching logic for each item in the entity's list.

![]({{site.baseurl}}/images/clghwcxj909huh0nveiym3byb.md/89a3f0b0-960e-46cf-b218-2de3ff9d6e79.png)

Figure: Smart matching

You can activate Smart matching for each entity, an element of the bot's language comprehension model. If this option is enabled, the bot will analyze the user's input using a flexible approach based on the items specified in the entity. Specifically, the bot will automatically correct typos and broaden its comparison rationale semantically.

### Regular expression (regex) entities

A regular expression entity enables you to create a logical pattern that can be used to match and extract information from a user's input. Regex entities can identify many items, including tracking IDs, license numbers, credit card numbers, IP addresses, number plates, and more. This is helpful in cases where a user may enter data in various formats or formats that are difficult to anticipate.

![]({{site.baseurl}}/images/clghwcxj909huh0nveiym3byb.md/c48ef559-b39b-4bfd-9d73-3fe884c1883b.png)

Figure: Regular expression

These entities are created using a set of special characters and symbols that represent a pattern to be matched. They help find words, phrases, or numbers in a piece of text or for validating that specific criteria have been met, such as verifying a phone number or email address.

![]({{site.baseurl}}/images/clghwcxj909huh0nveiym3byb.md/c44ed3c2-165d-4938-9dce-0d8539e125f3.png)

Figure: defining a regular expression

The Power Virtual Agents regex entity allows you to use the [.NET regular expression](https://learn.microsoft.com/en-us/dotnet/standard/base-types/regular-expressions) syntax to create a pattern that can be used to extract data from a user response. The pattern comprises characters representing the type of data sought, such as a date, a time, or a word. With a regex entity, you can define a way that matches a specific input type and extract the data from the user's response. The regex entity also supports using regular expression options to make the pattern case insensitive and specify whether a match should be exact or partial matches should be allowed. You can also use the regex entity to define patterns to ignore words or phrases in a user response. More examples can be found in the [Regular Expression Language - Quick Reference](https://learn.microsoft.com/en-us/dotnet/standard/base-types/regular-expression-language-quick-reference).

## Use entities in a conversation

Now that you've given the bot the knowledge about vehicles by creating that vehicle custom entity, you can start to use them when constructing a bot conversation.

* Go to the [**Topics page**](https://learn.microsoft.com/en-us/power-virtual-agents/authoring-create-edit-topics) for the bot you want to edit.

* Open the authoring canvas for the topic to which you want to add an entity.

* Select **Add node** (**+**) and then select **Ask a question**.

* Under **Identify**, select the entity you created in [Custom Entities](https://learn.microsoft.com/en-us/power-virtual-agents/advanced-entities-slot-filling#custom-entities).

![]({{site.baseurl}}/images/clghwcxj909huh0nveiym3byb.md/09c7c9f0-8a1b-4046-8af0-5183b0895c04.png)

Figure: picking custom entities

## Slot filling

Slot filling is a natural language understanding concept that saves an extracted entity to an object.

In the context of Power Virtual Agents, slot filling is the process of capturing user input and saving it to a variable. This variable is then used to guide the conversation in the dialog tree, allowing the bot to ask more specific questions and provide more relevant answers. For example, when the user is asked for a vehicle category, the bot will capture the user input, save it to a variable, and use it to determine the next step in the conversation. By keeping the user input, slot filling helps the bot to provide more personalized and accurate responses based on the user's specific needs.

![]({{site.baseurl}}/images/clghwcxj909huh0nveiym3byb.md/eb2db175-fe94-40c6-923c-96728842f285.png)

Figure: Slot filling

You can also use what is known as "proactive slot filling", where the user can specify multiple pieces of information that map to various entities. The bot can understand what data belongs to which entity automatically. In cases where it is unsure of the intended mapping, it will prompt the user to be more specific by providing choices. The user wrote, "I want to park my car" in this example. This includes the trigger phrase that the user wants to park something and provides a second piece of information—the actual type of vehicle. In this case, the bot fills in the entity for parking and the kind of vehicle.

![]({{site.baseurl}}/images/clghwcxj909huh0nveiym3byb.md/1bba9ecd-00e3-4318-81b5-06d25392b027.png)

Figure: Result of slot filling

## Conclusion

In conclusion, Power Virtual Agents offers a range of pre-constructed entities for commonly used data, such as ages, colors, numbers, and names, and also allows for creating custom entities using closed list entities or regular expression entities. These entities enable the bot to comprehend user intentions and provide more personalized and accurate responses based on the user's specific needs. In addition, slot filling, a natural language understanding concept that saves an extracted entity to an object, which helps the bot provide more specific and relevant answers, can be used. Users can use these advanced features to create more advanced and specialized bots to meet their particular needs.
