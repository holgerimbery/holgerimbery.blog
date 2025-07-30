---
layout: post
title: Copilot Studio Kit - you can't improve what you can't measure
description: Copilot Studio Kit enhances Microsoft Copilot Studio with powerful tools for testing, monitoring, and optimizing AI agents. This solution enables organizations to measure agent performance through automated testing, conversation analytics, and advanced monitoring, allowing data-driven improvements to custom AI solutions. By providing robust quality assurance and governance capabilities, the Kit helps ensure AI agents deliver reliable, high-quality responses while meeting enterprise requirements for scalability and compliance.
date: 2025-08-02
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/07/wander-fleur-4i2crgbc0Gs-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@wanderfleur?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Wander Fleur</a> on <a href="https://unsplash.com/photos/clear-acrylic-ruler-on-white-paper-4i2crgbc0Gs?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
category: [copilotstudio, copilotstudio-kit, applicationlifecyclemanagement, agents, testing, monitoring, optimization]
author: admin
featured: true
toc: true
---

{: .q-left }
> **Content Classification**  
Content for IT decision makers - Level 100 (Background knowledge)  
Content for IT professionals - Level 100 (Background & Integration knowledge)   
Content for IT architects - Level 100 (Background & Integration knowledge)

{: .q-left }
> **Summary Lede**  
Copilot Studio Kit enhances Microsoft Copilot Studio with powerful tools for testing, monitoring, and optimizing AI agents. This solution enables organizations to measure agent performance through automated testing, conversation analytics, and advanced monitoring, allowing data-driven improvements to custom AI solutions. By providing robust quality assurance and governance capabilities, the Kit helps ensure AI agents deliver reliable, high-quality responses while meeting enterprise requirements for scalability and compliance.

## Introduction
The Copilot Studio Kit is an extension of Microsoft Copilot Studio that provides additional tools to support the development and management of custom AI agents. Created by Microsoft’s Power CAT team, the kit adds functionality that goes beyond the core platform, including tools for automated testing, performance analysis, and agent lifecycle management.

This document outlines the main components of the Copilot Studio Kit and explains how they can be used to improve the reliability and maintainability of AI agents. It covers the technical features, practical use cases, and potential benefits for teams working with Copilot Studio.

At the end of the document, you’ll find a step-by-step installation guide to help you set up the Copilot Studio Kit and begin using its tools in your own environment


## Business Benefits of Copilot Studio Kit

**Faster Time-to-Market and Improved Efficiency**: The Copilot Studio Kit significantly accelerates the development and deployment of custom AI agents by streamlining the testing and optimization process. Teams can automate extensive test scenarios and prompt tuning, which optimizes development workflows and reduces the time required to transition from design to production. This faster iteration cycle enables businesses to roll out AI solutions and updates more quickly, thereby gaining a time-to-market advantage over their competitors.  
**Enhanced Quality and Reliability**: With robust automated testing frameworks, the kit enables the development and deployment of custom agents to be more efficient and reliable. By validating agent responses through batch tests (including multi-turn conversations) and catching issues early (using tools like the Agent Review Tool), organizations can ensure higher quality outputs. This leads to AI agents that consistently perform well, thereby improving end-user satisfaction and trust in the solutions. In essence, the Copilot Studio Kit introduces a quality assurance layer that reduces errors and unexpected behaviors in production.  
**Cost Savings through Automation**: The automation capabilities of the kit translate to direct operational efficiency. By automating repetitive and complex testing tasks, the need for manual testing and extensive trial-and-error is minimized. This reduces manual intervention in the deployment process, allowing development teams to focus on innovation rather than tedious validation work. Over time, the efficiency gains can lead to considerable cost savings, as fewer developer hours are spent on debugging and maintenance. Moreover, the optimized prompts and improved agent performance can reduce costly failures or miscommunications when the AI agents are in use.  
**Competitive Advantage and Governance**: Adopting the Copilot Studio Kit can give organizations a competitive edge by leveraging its unique functionalities, which set it apart from standard development toolsets. Companies using the kit can build more sophisticated and reliable AI agents than those who rely solely on out-of-the-box capabilities, thereby differentiating their services and enhancing their offerings. Additionally, the kit provides enterprise-level governance tools – for example, Agent Inventory offers a tenant-wide view of all AI agents and their configurations, which is crucial for oversight in large organizations. This big-picture visibility, combined with the Agent Value Dashboard that categorizes agents by their role and impact, enables business leaders to align AI agent deployments with strategic objectives and compliance requirements. In short, the kit not only boosts technical outcomes but also ensures that an organization's AI initiatives are well-managed and strategically directed.

## Technical Benefits of Copilot Studio Kit

**Robust Automated Testing Framework:**

From a technical perspective, one of the most significant advantages of the Copilot Studio Kit is its comprehensive test automation framework. Developers can configure test cases and entire test sets to run against their agents using Copilot Studio APIs.

The kit supports multiple test types:
- Response matching
- Attachment presence
- Topic coverage
- Generative answer correctness

It also supports multi-turn testing, allowing for the end-to-end validation of complex conversational exchanges, which is critical for verifying that an AI agent performs well throughout a dialogue.

Test runs produce detailed results, including:
- Logs of observed responses
- Latency measurements
- Aggregate success metrics

This provides developers with granular insight into performance and correctness. All these capabilities make it much easier to ensure an AI agent meets its requirements and performance targets before deployment.  

**Seamless Integration and Scalability:** 

The Copilot Studio Kit is designed to work seamlessly within the broader Microsoft Power Platform and Azure ecosystem, which brings notable technical benefits in integration and scalability.

- **Data Storage and Integration**:
    - Test result data and conversation analytics are stored in Microsoft Dataverse
    - Scales to enterprise data volumes and can be easily queried or integrated with other business data
    - Integrates with Azure Application Insights to enrich test results with runtime telemetry
    - Helps developers correlate AI behavior with system metrics

- **Enhanced SharePoint Integration**:
    - Unlike the default approach of linking a SharePoint site as a data source
    - The kit's SharePoint synchronization feature brings documents directly into the AI agent's knowledge base
    - Supports large files, PDFs, and even SharePoint pages with improved indexing
    - Expands content support and ensures better performance in retrieving answers

- **DevOps Integration**:
    - Supports Power Platform Pipelines for automated deployments
    - Introduces CI/CD practices to agent development
    - Pipeline-integrated tests automatically validate agents before promotion to production
    - Only agents that pass required test thresholds are deployed forward
    - Adds a "quality gate" to AI agent deployment
    - Ensures consistent scalability across development teams and multiple environments  

**Built-In AI Guidance for Prompt Engineering:**

Another technical benefit is the inclusion of AI-assisted design tools, particularly the Prompt Advisor. Crafting effective prompts is crucial for getting good results from generative AI, and the Prompt Advisor in the kit helps makers do this in a scientifically informed way.

The Prompt Advisor:
- Utilizes a large language model to assess prompt quality
- Provides detailed rationale for confidence scores
- Highlights potential issues in the prompt
- Suggests refined prompts using proven techniques
- Enables iterative selection and testing

This guided prompt optimization enables even non-expert developers to enhance their agent's instructions, resulting in improved AI performance. Technically, this closes the loop between prompt design and outcome validation by providing immediate feedback and recommendations, thereby:
- Accelerating the tuning process
- Enhancing model responses
- Eliminating the need for external tools  

**Comprehensive Monitoring and Analytics:**

The Copilot Studio Kit introduces enhanced analytics that go beyond those provided by the base Copilot Studio. Specifically, it adds:

- **Conversation KPIs**
    - Aggregates conversation outcomes (resolution rates, escalation rates, user satisfaction)
    - Records metrics in Dataverse and presents them in dashboards
    - Spares developers from manually parsing raw conversation transcripts
    - Pre-processes conversation data into meaningful metrics

- **Conversation Analyzer Tool**
     - Allows developers to run custom analyses on conversation logs using prompts
    - Applies AI to analyze AI interactions
    - Uncovers deeper insights or extracts specific information
    - Can spot trends, identify user needs, or debug complex interactions

Together, these analytics features provide a richer monitoring ecosystem, helping maintain and improve AI agents over time with data-driven insights. 

**Customizable User Experience Components:** 

While the focus of Copilot Studio Kit is often on backend and testing features, it also offers technical benefits for the user interface and experience design.   

The Webchat Playground is a tool that enables makers to easily customize the UI of the chat interface where the agent interacts with users. Through a straightforward GUI, developers can easily tweak:
- Colors
- Fonts
- Avatars (thumbnails/initials)
- Other style elements to match their company's branding or the desired user experience

The tool then automatically generates the corresponding HTML/CSS for the chat widget.  

Similarly, the Adaptive Cards Gallery offers a collection of 12 pre-built adaptive card templates for common scenarios, showcasing how dynamic content can be presented within conversations.  

These templates:
- Accelerate the development of rich, interactive responses (saving developers from designing cards from scratch)
- Demonstrate advanced techniques, such as data binding in cards, which developers can emulate and extend in their own solutions

Technically, these features ensure that custom agents are not just functionally powerful but also capable of delivering a polished user experience with minimal effort. This extensibility and ease of customization are a technical boon for developers who want to integrate agents into various channels (such as Teams and the web) with a consistent look and feel and interactivity.

## Key Features of Copilot Studio Kit
The Copilot Studio Kit comprises multiple features and tools that collectively enhance the Copilot Studio platform. The key features are outlined below, each addressing specific aspects of development, testing, content integration, or governance for AI  agents:
### Testing and Quality Tools  
**Testing Capabilities**: 

Enables the configuration and execution of batch test sets against agents. Makers can define various test cases and automatically verify if agent responses meet expectations. Test results include detailed data—such as:

- Response content
- Latency measurements
- Aggregate success metrics

This helps debug and improve agent performance. The testing framework supports various test types:
- Exact response match
- Attachment presence
- Topic coverage

It utilizes AI-based evaluation for generative answers, where an AI Builder model compares the agent's answer to a sample or criteria for correctness. 

Notably, Copilot Studio Kit supports multi-turn testing, allowing for the end-to-end validation of multi-step conversational flows, which is key to ensuring complex dialogues work as intended.  

**Automated Testing with Power Platform Pipelines**: 

Introduces integration with Power Platform ALM (Application Lifecycle Management) pipelines to automate the testing and deployment of agents. This feature enables a continuous integration/continuous deployment (CI/CD) approach:
- Whenever an agent is moved to a new environment (e.g., from development to production), a suite of automated tests can run first
- Only if the agent passes all required tests will the pipeline allow the deployment to proceed

This adds a "quality gate" in the release process, ensuring that only agents meeting quality standards go live, thereby:
- Increasing reliability
- Reducing manual verification efforts

It's an advanced feature for organizations looking to operationalize their AI agents with the same rigor as other software deployments.

### Analytics and Insight Tools
**Conversation KPIs**: 
Offers built-in key performance indicators (KPIs) to track how custom agents are performing in conversations. This feature:

- Aggregates data such as conversation outcomes, resolutions, escalations, and customer satisfaction signals
- Stores metrics in Dataverse records for reporting purposes
- Complements Copilot Studio's existing analytics with pre-calculated metrics
- Presents trends and statistics on a dashboard, including:
    - Success rate of AI in answering questions
    - Average turn count per conversation
    - Other key performance metrics

Instead of combing through raw conversation logs, developers and stakeholders can quickly visualize performance trends. This simplification helps in understanding and improving conversation outcomes without requiring deep manual analysis of transcripts. 

**Conversation Analyzer**: 

A tool (currently in preview) that allows makers to perform deeper analysis on conversation transcripts using natural language queries. This feature:

- Lets you ask questions or apply custom prompts to stored conversation data
- Derives additional insights beyond standard metrics
- Enables developers to find specific cases (e.g., unresolved issues)
- Helps summarize how users are asking about particular products

Essentially, it leverages AI to analyze AI interactions, providing a powerful way to:
- Debug conversation patterns
- Research trends in dialogues
- Explore beyond predefined KPIs
- Drive improvements in the agent's knowledge and behavior

This exploratory analysis capability helps makers continuously refine their agents based on actual conversation data. 

### Governance and Management Tools (continued)

**Agent Value Summary Dashboard**: 

A strategic analysis tool (new in the kit) that helps classify and evaluate all agents within an organization based on their type, behavior, and value contribution. The Agent Value component:

- Collects attributes of each agent:
    - Whether it's customer-facing or internal
    - Informational or transactional in nature
    - Other classification metrics
- Measures usage and impact metrics
- Presents a dashboard that visualizes:
    - Each agent's value contribution
    - Alignment with business objectives

This helps organizations:
- Identify which agents are delivering the most value
- Determine which might need reinvestment or improvement
- Understand how each agent fits into the overall strategy

In essence, it treats AI agents as portfolio assets that can be measured and compared for strategic decision-making. 
### Knowledge Integration and Content Management
**SharePoint Synchronization**: 

Enables the selective, periodic synchronization of content from SharePoint into the custom agent's knowledge base as files. This feature:

- Retrieves documents from specified SharePoint locations and ingests them into the Copilot's Dataverse storage
- Serves as an alternative to the live SharePoint connector at runtime, which may have limitations
- Supports larger files and more file formats than the out-of-the-box method, including:
    - Improved handling of PDF files
    - Content from SharePoint pages (.aspx pages)
- Provides improved indexing of documents for better answer retrieval performance and accuracy

In practice, SharePoint Synchronization ensures that:
- The agent's knowledge base remains up-to-date with the latest company information
- Performance is maintained when retrieving information during conversations
- The agent can utilize a broader and richer set of enterprise knowledge 

### Prompt Design and User Experience Tools
**Prompt Advisor**: 

An interactive prompt engineering assistant that helps makers craft more effective prompts for their AI agent. Within the Copilot Studio Kit, the Prompt Advisor:

- Enables developers to input a draft prompt (instructions/query that the agent uses)
- Utilizes a large language model to analyze the prompt
- Provides a confidence score with detailed reasoning
    - For example, highlighting if the prompt is too vague or potentially ambiguous
- Generates suggested improvements or alternative phrasings
    - Applies best practices in prompt design (adding context, specifying format)
- Allows makers to experiment with suggestions and immediately test them

This feature effectively trains makers in AI prompt writing while directly improving the agent's performance by refining its instructions.  

**Webchat Playground**: 
A design tool to customize the appearance and behavior of the agent's chat interface. Through an easy-to-use graphical interface, makers can:

- Adjust visual elements such as:
    - Chat window's color scheme
    - Font styles
    - Avatar icons (thumbnails/initials)
    - Other UI settings to match their brand

As changes are made, the Webchat Playground generates the corresponding HTML/CSS configuration that implements those styles in the actual copilot web chat component. This:

- Saves developers from manually coding the UI
- Allows quick previews of the look and feel

Ultimately, it ensures that deploying a agent doesn't compromise on user experience or branding – organizations can deliver an AI assistant that is both smart and visually consistent with their applications. 

**Adaptive Cards Gallery**: 

A collection of pre-designed Adaptive Card templates within the Copilot Studio Kit for use in agent responses. Adaptive Cards are reusable UI snippets that bots can send to present information with rich formatting. The gallery includes:

- A dozen templates for various scenarios (e.g., FAQs, ticket status updates, form inputs)
- Advanced card designs with dynamic data binding examples
- Ready-to-use cards that demonstrate how an agent can display query results in formatted layouts

Makers can:
- Use these out-of-the-box cards to quickly add sophisticated response formats
- Learn from the templates to build their own custom cards
- Access sample code/structures on the agent side to handle card interactions

This feature highlights the extensibility of the agent's UI while speeding up the development of complex conversational interfaces.

### Governance and Management Tools
**Agent Inventory**: 

A management feature that provides administrators with a tenant-wide view of all Copilot Studio custom agents deployed within their organization. The Agent Inventory:

- Aggregates details about each agent, including:
    - Which features it's using (e.g., which capabilities are enabled)
    - Authentication method
    - Connected knowledge sources
    - Orchestration mode (how it processes user input)
    - And more

- Presents information in a dashboard format that can also be exported

This is especially valuable for larger organizations with multiple AI agents developed by different teams. With Agent Inventory, an admin or Center of Excellence can:

- Quickly audit the AI landscape
- Identify the number of agents in production
- Ensure agents meet compliance standards (by checking settings such as authentication)
- Discover duplicate efforts

It serves as both an inventory and audit tool, supporting governance and helping to avoid sprawl as AI usage expands within the enterprise.

**Agent Review Tool**: 

A solution quality analyzer that reviews the configuration of a agent and flags potential issues or anti-patterns. This tool:

- Examines the agent's solution (topics, prompts, actions, etc.) for known pitfalls
- Detects issues that could affect performance or security
- Identifies problems like overlapping topics that might cause confusion
- Flags common setup mistakes

Findings are reported with:
- Clear severity levels
- Recommended fixes for each issue

This is analogous to a code analysis or linting tool, but specifically for AI agent setups. By using the Agent Review Tool, developers can:

- Identify misconfigurations or suboptimal designs early
- Ensure deployed agents adhere to best practices
- Improve robustness and security of custom agents
- Prevent avoidable issues before going live
- Follow guided remediation steps to fix problems

This feature ultimately helps ensure quality and consistency across AI agent implementations.

## Installation Guide
The Power CAT Copilot Studio Kit offers two deployment options: through AppSource marketplace or direct download from GitHub. Before proceeding with installation, several prerequisites must be met to ensure proper functionality. This solution leverages Power Platform components and requires appropriate licensing arrangements.

### System Prerequisites
- An active Power Platform environment that includes Dataverse for data storage.
    Dataverse serves as the repository for all configuration settings and test data within the Power CAT Copilot Studio Kit.
- Installation must be performed by a user with **system administrator** privileges in the target environment.
- Valid license that supports model-driven Power Apps applications.
- Sufficient licensing to execute Power Automate flows that utilize Premium connectors.
- Power Apps Component Framework (PCF) Components must be enabled in the Dataverse Environment.
    The Copilot Studio Kit uses advanced components from the Creator Kit, which requires PCF Components to be enabled.  
- Power Platform Pipelines must be enabled in the environment to utilize the CI/CD capabilities of the Copilot Studio Kit.

#### Optional requirements
* **AI Builder credits** AI Builder prompts are used with the Test Automation and Prompt Advisor features of the Kit.

     **Test Automation** : AI builder can be used to analyze an AI-generated answer and compare it with a sample answer or validation instructions. Each Test Case of type "Generative Answers" will consume 50 credits on average (based on our testing), but the exact consumption can vary based on the length of the test utterance, response and other factors.

     **Prompt Advisor**: each iteration will consume 120 credits on average (based on our testing), but can vary based on the length of the prompt being analyzed and other factors.

* **Azure Application Insights**
This integration is required to get additional telemetry details for AI-generated answers.  
[Refer to this documentation on how to integrate Azure Application Insights with Microsoft Copilot Studio](https://learn.microsoft.com/microsoft-copilot-studio/advanced-bot-framework-composer-capture-telemetry?tabs=webApp)

#### Connector requirements
[Microsoft Dataverse](https://learn.microsoft.com/connectors/commondataserviceforapps/)

### Installing the Power Cat Copilot Studio Kit (Appsource)
[Install from AppSource](http://aka.ms/DownloadCopilotStudioKit)

![upgit_20250730_1753860960.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/07/upgit_20250730_1753860960.png)

* Navigate to Copilot Studio Kit in AppSource
* Click "Get it now"
* Sign-in if required
* You are presented with Install Copilot Studio Kit view

![upgit_20250730_1753861069.png](https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2025/07/upgit_20250730_1753861069.png)

* From the drop-down list, select the environment where you want to deploy Copilot Studio Kit
* Carefully study the presented Terms and Statements, if you agree, check the boxes to indicate that and click "Install"


Post deployment steps  
After the installation finishes, proceed with these post deployment steps:

* Go to make.powerapps.com
* Go to Solutions
* Select Default Solution
* Select Connection references
* Locate "Copilot Studio Kit - Dataverse" and open it for editing.
* Ensure all required fields are filled and the selected connection is valid. Create new connection to Dataverse as required.
* Click Save

### Setting Up SharePoint Synchronization

The following configuration is optional and only necessary if you intend to use the SharePoint Synchronization feature. You can complete these steps later if needed, before utilizing this functionality.

Note that your SharePoint connection should reference the source SharePoint site, while the Dataverse URL should point to the Dataverse instance linked with your target custom agents (where content will be synchronized).

* Navigate to https://make.powerapps.com
* Access Solutions from the navigation menu
* Open the Default Solution
* Select Connection references
* Find and click on "Copilot Studio Kit - SharePoint" to edit
* Verify all required fields contain appropriate information and the SharePoint connection is valid. If needed, establish a new SharePoint connection.
* Click Save to confirm your settings

### Agent Inventory Setup

The steps below are optional and only necessary if you intend to use the Agent Inventory feature. You may complete this configuration later before utilizing this functionality.

* Navigate to [Power Apps](https://make.powerapps.com)
* Select Solutions from the left navigation panel
* Open the Default Solution
* Click on Connection references
* Find and select "Copilot Studio Kit - Power Platform for Admins" to edit
* This connection enables tenant-wide environment listing. Use credentials with Power Platform Admin permissions for complete visibility
* Verify all mandatory fields contain appropriate information and the connection is valid
* Select Save

* Next, locate and select "Copilot Studio Kit - Dataverse" 
* This connection retrieves agent information across environments. For full visibility, use credentials with System Admin permissions for all relevant environments. Note that this connection supports multiple features within the Kit
* Confirm all required fields are properly completed and the connection is functioning correctly
* Select Save

### Enabling flows
* Navigate to [Power Automate](https://make.powerautomate.com/)
* Make sure the environment with the Copilot Studio Kit is selected
* Select Solutions
* Select Copilot Studio Kit
* Select Cloud flows
* Make sure all the flows are enabled (Status = On)
*   Enable any flows that are not enabled, in the following order
    - Flows that end with "Grandchild"
    - Flows that end with "Child"
    - Rest of the flows as required, in any order

### Configure the embedded Conversation KPI dashboard
This configuration is only necessary if you intend to use the embedded Conversation KPI dashboard functionality within the Copilot Studio Kit.

During this process, you'll need to record the following information:

- Name of the workspace
- GUID of the workspace
- Name of the report
- GUID of the report

Deploying the Power BI report
- Obtain "Conversation KPIs.pbit" from the Copilot Studio Kit GitHub repository
- Launch Power BI Desktop and open the downloaded "Conversation KPIs.pbit" file
* When prompted, enter your Dataverse URL as the "Environment URL" (omit the https:// prefix) and click Load
    * If no prompt appears, manually input the "Environment URL" by selecting Home->Transform data->Edit parameters  

* Update the data by clicking Refresh and authenticate as needed
* Store the file and publish it to a Power BI workspace - Document the Report name and Workspace name
* Go to [Power BI](https://app.powerbi.com) 
* Access your published report and note the Workspace GUID and Report GUID visible in the URL
Note: If publishing to "My Workspace", use 00000000-0000-0000-0000-000000000000 as the Workspace GUID
* Click the "..." menu and select View semantic model
* Navigate to File->Settings
* Check that Data source credentials are properly configured, authenticating as necessary
* Set up an appropriate refresh schedule under the Refresh section

Updating the environment variable for report integration  
To properly configure the embedded Conversation KPIs dashboard, you must update the corresponding environment variable with the correct identifiers.

* Visit Power Apps and select the environment where Copilot Studio Kit is installed
* Navigate to Solutions, then Default Solution
* Click on Environment variables
* Find and select the Conversation KPIs Report variable
* Update the Default Value by replacing the placeholders with your actual Workspace name, Workspace GUID, Report Name and Report GUID that you documented earlier
* Save your changes

### Opening the Power CAT Copilot Studio Kit application
* Navigate to the Power Apps portal at make.powerapps.com
* In the environment selector, choose the environment where you installed the Copilot Studio Kit
* Click on the Apps section in the navigation menu
* Search for and select "Power CAT Copilot Studio Kit" from the list of available apps
* Click the "Play" button to launch the application
### Configuring User Access for Power CAT Copilot Studio Kit

Once you've completed the Power CAT Copilot Studio Kit installation process, you'll need to assign appropriate security roles to users who will work with the system to design agents and execute tests.

While the recommended approach is to manage security permissions through Entra ID groups and team assignments, you can also manually assign roles directly to individual users if needed.

Power CAT Copilot Studio Kit provides three security roles with different permission levels:

| Role | Capabilities |
|------|--------------|
| Power CAT Copilot Studio Kit Administrator | Complete access to all Power CAT Copilot Studio Kit tables and standard Copilot Studio tables, including Conversation Transcripts. |
| Power CAT Copilot Studio Kit Configurator | Full permissions on user-owned records within Power CAT Copilot Studio Kit and Copilot Studio tables. |
| Power CAT Copilot Studio Kit Tester | Limited permissions focused on test creation and execution capabilities. |

Follow the rest of the installation steps in the [documentation](https://github.com/microsoft/Power-CAT-Copilot-Studio-Kit/blob/main/SETUP_USERS_AND_TEAMS.md) to assign these roles to users or groups as needed, ensure that the appropriate users have access to the Power CAT Copilot Studio Kit features.
and [configure](https://github.com/microsoft/Power-CAT-Copilot-Studio-Kit/blob/main/CONFIGURE_COPILOTS.md) your agents to use the Copilot Studio Kit features.


## Links
[Copilot Studio Kit Github Repository & Documentation](https://github.com/microsoft/Power-CAT-Copilot-Studio-Kit/blob/main/README.md)

## Conclusion
The Copilot Studio Kit significantly enhances the capabilities of Microsoft Copilot Studio, offering a comprehensive toolkit that delivers both immediate and long-term value to organizations developing AI copilots. From a business perspective, the kit accelerates time-to-market, reduces development costs, and enhances the reliability of AI solutions, all of which contribute to a greater return on investment and a competitive edge in deploying AI-driven services. From a technical standpoint, it offers a robust, scalable framework for testing and optimization, integrates smoothly with enterprise data and DevOps workflows, and introduces advanced tools for prompt engineering and analytics. In summary, the Copilot Studio Kit is a comprehensive solution that enhances Copilot Studio with testing automation, AI-powered validation, performance tracking, and governance features. By leveraging this kit, organizations can develop custom AI agents with confidence, faster, smarter, and with better oversight – ultimately enabling them to harness Microsoft's Copilot technology to its full potential reliably and efficiently.
