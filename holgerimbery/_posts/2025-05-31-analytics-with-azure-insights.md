---
layout: post
title: Measuring for Improvement - Capturing Telemetry in Microsoft Copilot Studio with Azure Application Insights
description: Learn how to effectively capture and analyze telemetry data in Microsoft Copilot Studio using Azure Application Insights.
date: 2025-05-31
author: admin
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/05/yucel-moran-onSPwKgLltg-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@ymoran?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Yucel Moran</a> on <a href="https://unsplash.com/photos/a-laptop-computer-sitting-on-top-of-a-wooden-desk-onSPwKgLltg?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
      
tags: [copilotstudio, azureapplicationinsights]
featured: true
toc: true
---
{: .important} 
**Content Classification**  
Content for IT professionals - Level 100 (Implementation knowledge)   
Content for IT architects - Level 100 (Background and Implementation knowledge)   

{: .note } 
**Summary Lede**
This article explores how Microsoft Copilot Studio integrates with Azure Application Insights to provide robust telemetry capabilities for conversational AI solutions. By implementing proper measurement frameworks, organizations can gather critical data about user interactions, conversation patterns, and system performance—enabling data-driven optimization of their AI assistants. Learn how to connect, configure, and analyze telemetry to transform raw interaction data into actionable insights that continuously improve your Copilot Studio implementations.

## Why Measurement Matters in Improvement
The first step toward meaningful improvement is measurement. Whether refining an agent, enhancing a product, or optimizing a service, data-driven insights are essential. Without measurement, teams are left to guess what works and what doesn’t. Telemetry—automated data collection about system behavior and user interactions—provides the foundation for informed decision-making. It helps identify pain points, track performance, and validate changes, ensuring that improvements are both targeted and effective.

## Capturing Telemetry in Microsoft Copilot Studio
Microsoft Copilot Studio allows developers to build intelligent agents using a low-code interface. It integrates seamlessly with the Azure AI Foundry for more advanced scenarios, which supports a deeper level of customization and control. One of the key features of Copilot Studio is its built-in telemetry capabilities, which enable developers to capture detailed insights into how users interact with their bots.must firsture Application Insights is a powerful monitoring service within Azure Monitor. It provides real-time analytics on application performance, usage patterns, and exceptions. When integrated with Copilot Studio bots, it becomes a central hub for all telemetry data.

### Key Features of Application Insights
* **Live Metrics**: Monitor bot activity and real-time performance.
* **Custom Dashboards**: Visualize key metrics like user engagement, dialog completion rates, and error frequency.
* **Smart Detection**: Automatically identifies anomalies and performance issues.
* **Query Language (KQL)**: Use powerful queries to analyze telemetry data and generate reports.

## Why Use Application Insights?
Centralized Monitoring: Consolidate logs, metrics, and traces in one place.
Proactive Debugging: Detect and resolve issues before they impact users.
User Behavior Analysis: Understand how users interact with your bot to improve UX.
Scalability: Monitor bots at scale across multiple environments and regions.

## Build in Analytics Copilot Studio Analytics
These include:

* **Agent Effectiveness**: Measures user satisfaction, engagement, and resolution rates.
* **Agent Health**: Tracks handoffs, errors, and fallbacks.
* **Consumption Analytics**: Monitors message volume, channel usage, and billing.
* **Topic Analytics**: Shows topic triggers, completion rates, and drop-offs.

Best for Business users or product owners.
Quick insights into bot performance and user behavior.
Monitoring adoption, usage trends, and optimization opportunities.
It is Complementary, Not Redundant to use an additional analytics tooling like azure application insights


| Use Case	| Built-in Analytics |	Azure Insights |
|-----------------------------------|-----|-----------------------------|
| Track topic usage and completion |  yes	| yes (with custom events) |
| Understand user satisfaction	|yes	| yes (if instrumented) |
| Debug dialog transitions	| no |	yes |
| Monitor API latency or errors |	no |	yes |
| Visualize trends over time |	yes (limited) |	yes (custom dashboards) |
| Correlate with external systems |	no |	yes |
| Alerting and anomaly detection |	no |	yes |

## Best Practices for Telemetry and Insights
To get the most out of telemetry and Application Insights, consider the following best practices:

* **Log Meaningful Events**: Focus on events that reflect user intent, success/failure of dialogs, and system errors.
* **Use Correlation IDs**: Track user sessions across multiple dialogs and services.
* **Set Up Alerts**: Get notified when performance thresholds are breached.
* **Regularly Review Dashboards**: Use insights to guide development priorities and UX improvements.

## Connect your Copilot Studio agent to Application Insights
To connect your agent to Application Insights, you first need to add your instrumentation key to your agent's configuration.
See the [Azure Monitor documentation](https://go.microsoft.com/fwlink/?linkid=2227096) to find out how to locate your connection string.

Navigate to your agent's Settings section and click on the Advanced tab.
![upgit_20250530_1748610524.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/05/upgit_20250530_1748610524.png)

Look for the Application Insights configuration area, where you'll need to enter the Connection string. For instructions on retrieving your connection string, consult the Azure Monitor documentation.

![upgit_20250530_1748610584.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/05/upgit_20250530_1748610584.png)
Once you've entered the connection string, click Save to apply the changes.

Optionally, you can choose to enable one of the following settings.

* **Log activities**: If enabled, details of incoming/outgoing messages and events are logged.

* **Log sensitive Activity properties**: If enabled, the values of certain properties that could be considered sensitive on incoming/outgoing messages and events are included in logs. The properties that are considered potentially sensitive are userid, name, text and speak (text and speak properties only apply to messages).
* **Log node tools**: if enabled, an event is logged each time a node in a topic is executed


## Analyze bot telemetry with Application Insights
After you've connected your bot to Application Insights, telemetry data is logged when users interact with the bot, including testing within Copilot Studio. To see the logged telemetry data, navigate to the Logs section of your Application Insights resource in Azure.

You can use Kusto queries to query and analyze your data from here.  
See example queries.

## Example Queries for Analyzing Bot Telemetry

After connecting your Copilot Studio agent with Application Insights, you'll want to extract meaningful insights from the collected telemetry data. This is where Kusto Query Language (KQL) becomes an invaluable data exploration and analysis tool.

### Understanding Kusto Query Language (KQL)

Kusto Query Language is a powerful query language explicitly designed for analyzing large volumes of data in Azure's data analytics services. With KQL, you can filter, aggregate, and visualize your telemetry data to uncover patterns and insights about your bot's performance and user interactions.

### Introduction to Kusto Query Language
Kusto Query Language (KQL) is a read-only request language.
KQL features a syntax that's both powerful and approachable. It combines elements familiar to SQL users with unique capabilities for working with semi-structured data and time series. The language is optimized for ad hoc data exploration, pattern matching, and time-based analytics, making it ideal for telemetry analysis.

Key characteristics of KQL include:

- **Pipe-based syntax**: Commands are chained together using pipes (`|`), creating a natural data transformation workflow
- **Rich operators**: Built-in functions for filtering, aggregation, joining, and visualizing data
- **Time-intelligence**: Specialized functions for working with timestamps and time intervals
- **Dynamic data handling**: Native support for JSON-like nested data structures
- **Performance optimization**: Designed for querying billions of records with minimal latency

For Copilot Studio telemetry analysis, KQL is the primary tool for transforming raw data into actionable insights about user behavior, bot performance, and conversation patterns.


### Essential Query Examples

#### User Activity Trends

The following query generates a time-series visualization showing distinct user interactions with your bot over two weeks:

```
// Define the time range parameters
let queryStartDate = ago(14d);
let queryEndDate = now();
let groupByInterval = 1d;

// Perform the analysis
customEvents
| where timestamp > queryStartDate
| where timestamp < queryEndDate
| summarize uc=dcount(user_Id) by bin(timestamp, groupByInterval)
| render timechart
```

This query:
- Establishes a 14-day lookback period with daily aggregation intervals
- Filters the `customEvents` table to this period
- Uses `dcount()` (distinct count) to calculate unique users per day
- Groups results into daily bins using the `bin()` function
- Renders the results as a time-series chart for visual trend analysis

#### Conversation Duration Analysis

To understand how long users typically engage with your bot:

```
customEvents
| where timestamp > ago(7d)
| extend sessionId = session_Id
| summarize 
    startTime = min(timestamp), 
    endTime = max(timestamp) 
    by sessionId
| extend conversationDuration = datetime_diff('second', endTime, startTime)
| where conversationDuration > 0 and conversationDuration < 3600 // Filter out outliers
| summarize 
    averageDuration = avg(conversationDuration),
    medianDuration = percentile(conversationDuration, 50),
    p90Duration = percentile(conversationDuration, 90)
| extend 
    averageDuration = averageDuration / 60,
    medianDuration = medianDuration / 60,
    p90Duration = p90Duration / 60
```

This is a more advanced query:
- Calculates the duration of each conversation in the past week
- Filters out suspicious outliers (conversations lasting over an hour)
- Computes average, median, and 90th percentile conversation lengths in minutes
- Helps identify if most conversations are brief interactions or longer engagements

#### Topic and Intent Distribution

To understand which bot topics or intents are most frequently triggered:

```
customEvents
| where timestamp > ago(30d)
| where name == "BotMessageSend" 
| extend topicName = tostring(customDimensions.topicName)
| where isnotempty(topicName)
| summarize count() by topicName
| order by count_ desc
| render bar chart
```

This visualization helps identify:
- Which topics are most commonly accessed by users
- Potential opportunities to optimize high-traffic conversation flows
- Topics that might need additional development or refinement

### Interpreting Query Results

When analyzing your query results, consider these key aspects:

- **Trends over time**: Look for patterns in usage that might correlate with external events or product changes
- **Outliers**: Identify anomalies that could indicate exceptional user experiences (both positive and negative)
- **Distribution patterns**: Understand the typical vs. edge cases in user interactions
- **Comparative metrics**: Track how changes to your bot implementation affect key metrics

By regularly analyzing your bot's telemetry data using these queries, you can gain valuable insights that drive continuous improvement of your Copilot Studio agent's effectiveness and user experience.

 
## Channel-Specific Data Variability in Telemetry Collection

When analyzing telemetry data across different communication channels in Copilot Studio, it's essential to understand that data consistency and reliability vary significantly between platforms. This variability directly impacts the accuracy and utility of certain metrics within your Application Insights analytics.

### Authentication-Dependent User Identification

The fidelity of user identification metrics depends fundamentally on the authentication model employed by each channel:

- **Authenticated Channels**: When users maintain consistent authentication across sessions (such as in Microsoft Teams or authenticated web portals), the `user_Id` field represents a reliable unique identifier. This enables accurate tracking of:
    - Distinct user counts
    - Individual user journeys across multiple conversations
    - User-specific behavior patterns over time

- **Anonymous Interaction Models**: Many implementations (particularly public-facing webchat interfaces) generate ephemeral or session-based identifiers that change with each conversation. In these scenarios:
    - The `user_Id` field becomes merely a conversation identifier rather than a true user identifier
    - Metrics like "unique users" may actually represent "unique conversations" instead
    - Cross-session user journey mapping becomes impossible or highly unreliable

### Channel-Specific Telemetry Characteristics

Different integration channels also capture varying levels of contextual metadata:

- **Microsoft Teams**: Generally provides rich user profile information and consistent identity tracking
- **Webchat**: May offer limited user context unless custom authentication is implemented
- **SMS/Voice Channels**: Often identify users by phone number, but with limited additional context
- **Third-party Integrations**: Metadata quality depends entirely on what the external platform provides

Understanding these channel-specific data characteristics is crucial when designing analytics dashboards and interpreting telemetry results, particularly when your Copilot implementation spans multiple communication channels simultaneously.

## Filtering Test Environment Data from Production Analytics

When analyzing telemetry data, it's crucial to distinguish between genuine user interactions and development testing activities. Copilot Studio captures telemetry comprehensively across all environments, which means your analytics will include both production conversations and those initiated within the Copilot Studio testing interface.

### Why Separate Test and Production Data?

Including test conversations in your analysis can significantly skew metrics such as:
* User engagement statistics
* Average conversation length
* Common user intents
* Error rates and performance benchmarks

### Implementing Test Data Filtration

Fortunately, Copilot Studio automatically tags all telemetry with environment context through the `designMode` custom dimension. This metadata indicator allows you to isolate authentic production interactions in your analytical queries.

The following Kusto query demonstrates how to exclude all test canvas interactions from your telemetry analysis:

```
customEvents
| extend environmentType = customDimensions['designMode']
| where environmentType == "False" // Only include production conversations
```

For more targeted analysis, you could also specifically focus on test environment data by reversing the condition:

```
customEvents
| extend environmentType = customDimensions['designMode']
| where environmentType == "True" // Only analyze test conversations
```

This filtration technique ensures your insights and performance metrics accurately reflect real-world usage patterns rather than development activities.

## Custom Dimensions

When Copilot Studio captures telemetry, the granular details of interactions and system activities are primarily stored within the `customDimensions` field in Application Insights. This structured collection of key-value pairs serves as a comprehensive repository for contextual information about each event, providing essential metadata that enriches your analytical capabilities.

### Importance of Custom Dimensions

Custom dimensions significantly enhance your ability to filter, segment, and analyze telemetry data with precision. Rather than dealing with monolithic event logs, these dimensions allow you to dissect interactions based on specific attributes like user characteristics, conversation contexts, or system parameters. As demonstrated earlier with the `designMode` dimension, which helps separate production conversations from test interactions, these fields enable targeted analysis that yields more actionable insights.

### Accessing Custom Dimensions in Queries

In Kusto Query Language (KQL), you can access any custom dimension using the bracket notation:

```
customEvents
| extend dimensionValue = customDimensions['dimensionName']
```

The extensibility of this approach means you can extract and work with multiple dimensions simultaneously:

```
customEvents
| extend channelType = customDimensions['channelId']
| extend userLocale = customDimensions['locale']
| extend messageText = customDimensions['text']
| where channelType == "webchat" and userLocale startswith "en"
```

### Leveraging Custom Dimensions for Advanced Analytics

Beyond basic filtering, custom dimensions enable sophisticated analytics scenarios:

- **User Journey Mapping**: Track conversation flows by correlating events with user identifiers and timestamps
- **Channel Performance Comparison**: Analyze performance metrics across different channels (Teams, webchat, etc.)
- **Language-Specific Analysis**: Segment user interactions by locale to identify regional patterns
- **Conversation Content Analysis**: Examine message text patterns to identify common user intents or pain points   

The strategic use of these dimensions transforms raw telemetry data into structured intelligence that can guide both immediate optimizations and long-term improvements to your Copilot Studio implementations.

| ld  | Description  | Sample Values |
|-----|--------------|----------------|
| type | Type of activity | message, conversationUpdate, event, invoke |
| channelId | Channel identifier | emulator, directline, msteams, webchat |
| fromId | From Identifier | <id> |
| fromName | Username from client | John Bonham, Keith Moon, Steve Smith, Steve Gadd |
| locale | Client origin locale | en-us, zh-cn, en-GB, de-de, zh-CN |
| recipientId | Recipient identifier | <id> |
| recipientName | Recipient name | John Bonham, Keith Moon, Steve Smith, Steve Gadd |
| text | Text in message | find a coffee shop |
| designMode | Conversation happened within the test canvas | True / False |


## Conclusion
Effective measurement is the cornerstone of continuous improvement for conversational AI solutions. In the realm of Microsoft Copilot Studio, telemetry isn't merely a technical feature—it's a strategic necessity. The seamless integration with Azure Application Insights provides organizations with a powerful lens through which to observe, analyze, and enhance their AI assistant implementations. By harnessing properly configured telemetry, teams can move beyond anecdotal feedback to data-driven decision making, identifying specific areas for optimization and validating the impact of each improvement. The queries, filtering techniques, and analytical approaches outlined in this article serve as a foundation for transforming raw interaction data into actionable intelligence. With these capabilities, your Copilot Studio agents can evolve from simply functional tools into continuously improving, highly effective virtual assistants that genuinely address user needs and deliver measurable business value.
