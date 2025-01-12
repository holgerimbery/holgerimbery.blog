---
layout: post
title: "Power Virtual Agents and PowerFX: A Sneak Peek"
date: 2023-05-20
author: admin
slug: power-virtual-agents-and-powerfx-a-sneak-peek
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-05-20-power-virtual-agents-and-powerfx-a-sneak-peek

---

Power Virtual Agents and PowerFX are two powerful tools that can create complex logic for bots to manipulate data. With these tools, you can create bots with more complex logic without the need for extensive development. PowerFx is a low-code language that allows users to set the value of a variable, parse strings, and use expressions in conditions. In this article, we take a sneak peek at the capabilities and applications of Power Virtual Agents and PowerFX, including how to use variables and literal values in formulas and how to use PowerFX to set a variable as a condition.

Please refer to the [comprehensive overview](https://learn.microsoft.com/en-us/power-platform/power-fx/overview) and [formula reference](https://learn.microsoft.com/en-us/power-platform/power-fx/formula-reference).

 Important

 This article contains Power Virtual Agents preview functionality and is subject to change.

 Note!  

 Power Fx formulas in Power Virtual Agents use US-style numbering. That is, the decimal separator is a period or dot, as in `12,567.892`. This means [**Power Fx parameters must be separated by commas (,)**](https://learn.microsoft.com/en-us/power-platform/power-fx/expression-grammar#separators).

## **Use variables in a formula.**

To use a variable in a Power Fx formula, you must add a prefix to its name to indicate the variable's scope:

* For [system variables](https://learn.microsoft.com/en-us/power-virtual-agents/preview/authoring-variables#system-variables), use `System.`
  
* For [global variables](https://learn.microsoft.com/en-us/power-virtual-agents/preview/authoring-variables-bot), use `Global.`
  
* For [topic variables](https://learn.microsoft.com/en-us/power-virtual-agents/preview/authoring-variables), use `Topic.`
  

For example, to use the system variable [`Conversation.Id`](http://Conversation.Id) in a formula, you'd need to refer to it as [`System.Conversation.Id`](http://System.Conversation.Id).

![]({{site.baseurl}}/images/clhvwrsyx029408nv61zsfy8u.md/e33e92da-801f-4002-a5d1-e9fbb9e94cb0.png)

Figure: Set Variable Value

## **Use literal values in a formula.**

In addition to using variables in a PowerFx formula, you can enter literal values. To use a literal value in a formula, enter it in the format corresponding to its [type](https://learn.microsoft.com/en-us/power-virtual-agents/preview/authoring-variables#variable-types). The following table lists the data types and the format of their corresponding literal values.

| Type | Format examples |
| --- | --- |
| String | `"hi"`, `"hello world!"`, `"chatbot"` |
| Boolean | Only `true` or `false` |
| Number | `1`, `532`, `5.258`, `-9201` |
| Table | `[1]`, `[45, 8, 2]`, `["cats", "dogs"]` |
| Record | `{ id: 1 }`, `{ message: "hello" }`, `{ name: "John", info: { age: 25, weight: 175 } }` |
| DateTime | `Time(5,0,23)`, `Date(2022,5,24)`, `DateTimeValue("May 10, 2022 5:00:00 PM")` |
| Choice | Not supported |
| Blank | Only `Blank()` |

## **Use Power Fx to set a variable**

we'll use a Power Fx expression to store the customer's name and output it in capital letters.

* Create a topic and add a **Question** node.
  
* For **Enter a message**, enter. `What is your name?`.
  
* Under **Identify**, select the entity **Person name**.
  
* Select the box under **Save response as**, and then select the variable `Var1` and name it `customerName`.
  

![]({{site.baseurl}}/images/clhvwrsyx029408nv61zsfy8u.md/b2474955-9137-4b45-917a-65f0e820f94b.png)

Figure: Question Node

* Under the **Question** node, select **+** and then select **Set a variable value**.
  
* Please select the box under **Set variable**, and then select **Create new** and name it `capsName`.
  
* In the **To value** box, select the **&gt;** arrow, and then select the **Formula** tab.
  
* In the **fx** box, enter `Upper(Text(Topic.customerName))`, and then choose **Insert**.
  

![]({{site.baseurl}}/images/clhvwrsyx029408nv61zsfy8u.md/c3ec9f2f-d193-4128-8193-10d2930687e3.png)

Figure: Set Variable Value

* Under the **Question** node, select **+** and then select **Send a message**.
  
* Enter `Hello`, select **{x}**, and then select `capsName`.
  

![]({{site.baseurl}}/images/clhvwrsyx029408nv61zsfy8u.md/30e3bf3d-5441-46fa-992d-ea5807474e28.png)

Figure: Send a message to Node

![]({{site.baseurl}}/images/clhvwrsyx029408nv61zsfy8u.md/49bb993a-1caf-4faf-adc3-21b408a54d7f.png)

Figure: Result

# **Use a Power Fx formula as a condition.**

Condition nodes can be set up to analyze more complex expressions incorporating Power Fx formulas. This will enable the bot to assess more detailed requirements before action.

In this example, the bot determines if a booking date qualifies for a discount. To do that, it checks whether the booking date provided by the customer is 14 days or more from the current date.

* Create a topic and add a **Question** node.
  
* For **Enter a message**, enter `When do you want to book ?`.
  
* Under **Identify**, select the entity **Date and time**.
  
* Select the box under **Save response as**, and then select the variable `Var1` and name it `bookingDate`.
  

![]({{site.baseurl}}/images/clhvwrsyx029408nv61zsfy8u.md/def8438a-974b-41d7-a3a8-6412e32f1354.png)

Figure: Question Node

* Select the **+** icon and then select **Add a condition**.
  
* In the **Condition** node, select the **Node menu** (**⋮**) and choose **Change to formula**.
  

![]({{site.baseurl}}/images/clhvwrsyx029408nv61zsfy8u.md/4a9de0f9-0991-458d-94a4-1b573b7ae384.png)

Figure: Add Condition

* In the **Function** box, select the **&gt;** arrow, and then select the **Formula** tab.
  
* Replace the contents of the **fx** box with the formula `Topic.bookingDate > (DateAdd (Now(), 14))`, and then choose **Insert**.
  

![]({{site.baseurl}}/images/clhvwrsyx029408nv61zsfy8u.md/1e28b474-1252-470f-a835-3b5a7bfd387a.png)

Figure: Formula in condition

* Under the **Condition** node, add a **Send a message** node and enter the message `You qualify for a discount`.
  
* Under the **All Other Conditions** node, add a **Send a message** node and enter the message, `Sorry, you don't qualify for a discount`.
  

![]({{site.baseurl}}/images/clhvwrsyx029408nv61zsfy8u.md/b55e4f2c-0ae8-48d1-a01d-fb002f634fea.png)

Figure: Full Conversation Flow

![]({{site.baseurl}}/images/clhvwrsyx029408nv61zsfy8u.md/7b0a60b3-2d03-4269-b8ef-d0fff873cd4d.png)

Figure: Result

## Conclusion

In conclusion, Power Virtual Agents and PowerFX are powerful tools for creating bots with more complex logic without extensive development. UsingThese tools offer a low-code solution for those who want to create bots with complex logic without the need for extensive coding knowledge. With variables and literal values in formulas and the ability to set variables and use PowerFX as a condition, you can easily manipulate data and create more advanced bots.
