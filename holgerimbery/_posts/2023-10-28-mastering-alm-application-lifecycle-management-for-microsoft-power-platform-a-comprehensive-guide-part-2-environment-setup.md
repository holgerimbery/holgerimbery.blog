---
layout: post
title: Mastering ALM (Application LifeCycle Management) for Microsoft Power Platform - A Comprehensive Guide (Part 2 - environment setup)
date: 2023-10-28
author: admin
slug: mastering-alm-application-lifecycle-management-for-microsoft-power-platform-a-comprehensive-guide-part-2-environment-setup
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-10-28-mastering-alm-application-lifecycle-management-for-microsoft-power-platform-a-comprehensive-guide-part-2-environment-setup
 
---

This is the second part of a series of articles, [part 1 (basics and background)](https://the.cognitiveservices.ninja/mastering-alm-application-lifecycle-management-for-microsoft-power-platform-a-comprehensive-guide-part-1-the-basics) was published before.

## Reminder: **Environment strategy**

You must establish separate app development and production environments to adhere to application lifecycle management (ALM) principles. While basic ALM can be achieved with separate development and production environments, I recommend maintaining at least one additional test environment distinct from your development and production environments. A separate test environment enables end-to-end validation, encompassing solution deployment and application testing. Some organizations may require additional settings for user acceptance testing (UAT), systems integration testing (SIT), and training.

Distinct development environments can be beneficial in isolating changes from one work effort before it is completed, preventing premature check-ins. They can also help reduce instances where one person's changes negatively impact another's work.

Every organization is unique, so carefully assess your organization's specific environmental needs.

**There are several methods for establishing Application Lifecycle Management. We will focus on a lightweight approach in the first part of the series.**

## Prepare the basics

### Creating developer environments

* Go to [make.powerapps.com](http://make.powerapps.com)
  
* At the sign-in screen, input your account details and click "Sign in."
  
* If prompted to stay signed in, select "Yes."  
    You now were logged in and on the Power Apps Home Page.
    

Developer environments are extremely useful for testing features or simply developing a solution, as they are designed to be short-lived environments. You should never work within your default environment, as it is intended to serve as a personal productivity playground.

* In this series, we will create three distinct developer environments:
  
    `Dev`: The environment where we develop a solution.
    
    `Test`: The environment where we test the solution.
    
    `Prod`: The environment where we deploy our solution for production.
    
* To create developer environments, there are two methods available:
  
    * Through the Power Platform Admin Center
      
    * Using the Power Platform Command Line Interface (CLI)
      
    
    Here, we will create the environments using the Power Platform Admin Center.
    
    * Navigate to the Power Platform Admin Center.
      
    * Close the Welcome/Tour pop-up by clicking the "X" in the top right corner of the pop-up screen.
    
* Click on "Environments" in the left navigation.
  
* Click on "New" in the top navigation.
  
    ![]({{site.baseurl}}/images/clo9zpucx000709l67t48cywk.md/8334aca2-bfa4-4b60-a3a9-b8d09afdef4b.png)
    
* When the dialog window appears on the right-hand side, enter the following information:
  
    Name: Dev
    
    Region: (choose your preferred region)
    
    Type: Developer
    
    Purpose: (a description of your choice)
    
* Select "yes" to add dataverse data store, and select "Next" and "Save"
  
* ![]({{site.baseurl}}/images/clo9zpucx000709l67t48cywk.md/c311fd78-5951-40d9-8dde-fd559ed32bd0.png)
  
    repeat the same for a `test (test)` and for a `production (prod)` environment
    

### Creating a GitHub account (if you didn't have one)

* Go to the [GitHub](https://github.com/) website
  
* Click on "Sign up" in the top right corner.
  
* Enter your email address (use your personal email address) and click "Continue."
  
* Create a password and then click "Continue."
  
* Enter a username and then click "Continue."
  
* Choose whether you want to receive product updates or not, and then , and then click "Continue."
  
* Solve the puzzle to verify your account, solve the puzzle, and click "Create an account."
  
* Enter the code that was sent to your email address, and then proceed to the welcome screen
  

### Creating a repository

* Create a new repository with a meaningful name
  

![]({{site.baseurl}}/images/clo9zpucx000709l67t48cywk.md/f935f66d-4b8b-48b2-bea7-43c2005c6ff6.png)

### Creating a codespace

A codespace is a cloud-hosted development environment accessible from anywhere. It includes everything you need, such as a text editor, terminal, and debugger. Codespaces are powered by Visual Studio Code and operate in a containerized environment. Utilizing a codespace enables you to work independently of location and maintain a clean working environment.

* Navigate to your newly created repository, locate the &lt;&gt; Code button, and click on it.
  
    ![]({{site.baseurl}}/images/clo9zpucx000709l67t48cywk.md/26b68c01-7ab5-4c5a-9c75-69755151b42f.png)
    
* In the Code pop-up, select the "Codespaces" tab.
  
* Click on "Create codespace on the main".
  
    ![]({{site.baseurl}}/images/clo9zpucx000709l67t48cywk.md/696b5235-6136-4509-a2e9-678285b5ad6a.png)
    

A codespace will be created for you in a new tab. This process might take a few seconds. Upon completion, you will have a fully functional Visual Studio Code environment within your browser.

### Installing the Power Platform Tools extension

To work with your solution and save it to the repository, you need to install the "Power Platform Tools" extension.

* Select the "Extensions" icon on the left.
  
* Type "Power Platform Tools" into the search box.
  
* Click "Install."
  

![]({{site.baseurl}}/images/clo9zpucx000709l67t48cywk.md/1e6cf384-be58-4b9d-a9e7-6dc5b170de83.png)

### Connecting to the Power Platform environment

> Remember, this is only the first step, later we will work with pipelines and proper authentication with a service account.

* Click on the Power Platform icon in the left navigation.
  
* You will notice that it says, "No auth profiles found on this computer." We will create one.
  
    ![]({{site.baseurl}}/images/clo9zpucx000709l67t48cywk.md/78825e39-69f8-4db6-97ca-7a353b5e41c7.png)
    
* Click on the hamburger menu icon in the top left corner, then hover over "Terminal" and click "New Terminal."
  
* A terminal window will now open for you.
  
* Type the following command in the terminal and press Enter:
  
    ```plaintext
        pac auth create --deviceCode
    ```
    
* You will be prompted to use a web browser for authentication. Copy (Ctrl + C) the code provided in the terminal, and then Ctrl + click on the link also provided in the terminal.
  
    ![]({{site.baseurl}}/images/clo9zpucx000709l67t48cywk.md/f64885c2-5e71-4dba-af44-b9738220a9f0.png)
    
* Once you click on the link, a new browser tab will open. Paste the code into the browser and click "Next."
  
    ![]({{site.baseurl}}/images/clo9zpucx000709l67t48cywk.md/f6e9546e-f18e-446e-b7c2-9fc3b48c90e1.png)
    
* Sign in. Click "Continue."
  
* You will see a prompt confirming that you have successfully signed in to the Power Platform CLI - pac. Close the browser tab and return to your codespace.
  
* Refresh the Auth Profiles section by clicking the "Refresh" button next to "Auth Profiles."
  
* ![]({{site.baseurl}}/images/clo9zpucx000709l67t48cywk.md/57624b10-cd54-4296-b83d-2b7c6b9cce4f.png)
  
    After completing these steps, you should see your Authentication Profile and your Environments, allowing you to work with your environments effectively.
    
* To test this:
  

```plaintext
pac org list
```

You will receive a list of all the environments you have access to.

```plaintext
pac org select --environment "unique-name of environment"
```

You select your development environment and can work within this environment.

```plaintext
pac org who
```

You will receive information about your selected environment

### Power Platform CLI (pac)

please find the [full documentation](https://learn.microsoft.com/en-us/power-platform/developer/cli/introduction) of the tool on Microsoft Learn

## Next steps

Keep an eye out for the upcoming article, where you'll learn about solutions, creating a "solution," and mastering the process of exporting, importing, and cloning your solutions to the repository. Additionally, you'll discover how to work with the code in the repository, all while maintaining a lightweight approach.

## Conclusion

Mastering ALM for Microsoft Power Platform is crucial for efficient app development and management. You can create a streamlined workflow by setting up separate environments, utilizing GitHub repositories, and leveraging codespaces. Stay tuned for future articles to learn more about solutions and enhance your ALM skills.