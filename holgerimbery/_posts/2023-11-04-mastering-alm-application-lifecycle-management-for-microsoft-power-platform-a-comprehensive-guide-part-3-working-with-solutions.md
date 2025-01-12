---
layout: post
title: Mastering ALM (Application LifeCycle Management) for Microsoft Power Platform - A Comprehensive Guide (Part 3 - working with solutions)
date: 2023-11-04
author: admin
slug: mastering-alm-application-lifecycle-management-for-microsoft-power-platform-a-comprehensive-guide-part-3-working-with-solutions
tags: [archive]
image: ./images/archive.jpg
featured: false
toc: true
# 2023-11-04-mastering-alm-application-lifecycle-management-for-microsoft-power-platform-a-comprehensive-guide-part-3-working-with-solutions

---

This is the third part of a series of articles, [part 1 (basics and background](https://the.cognitiveservices.ninja/mastering-alm-application-lifecycle-management-for-microsoft-power-platform-a-comprehensive-guide-part-1-the-basics) & [part 2 (preparing your environments)](https://the.cognitiveservices.ninja/mastering-alm-application-lifecycle-management-for-microsoft-power-platform-a-comprehensive-guide-part-2-environment-setup) were published before.

**Solutions** are a key feature of Power Platform that allows users to transport apps, bots, and components from one environment to another or apply customizations to existing apps.

Here are some benefits of working with solutions in Power Platform:

* Application Lifecycle Management (ALM): Solutions serve as the mechanism for implementing ALM in Power Platform and other related products, such as Power Automate. They facilitate the management of an app's lifecycle by providing a means to create, update, upgrade, and patch a solution.
  
* Customization Management: Solutions enable you to manage your customizations in an organized manner. You can create a solution and perform all your customizations within it. Then, you can effortlessly distribute your solution to other environments.
  
* Managed Properties: By utilizing managed properties, you can control which components of your managed solution are customizable. This helps safeguard your solution from modifications that might cause it to malfunction after being imported into another environment, such as testing or production.
  
* Ease of Deployment: Solutions decrease the initial investments required for traditional enterprise software development. They also reduce the range of resources and skills necessary for deployment.
  

## Idea behind

Instead of working on your application in your production environment (`prod`), we create a development environment (`dev`), import the solution file to it, work on it, and test the outcome. Every developer is responsible for their own outcome. We create a new branch in the repository, export the modified solution to it, create a pull request, and merge it after testing again in a test environment (`test`). Finally, we deploy it to your production environment (`prod`).

Create a new solution

* Go to [make.powerapps.com](http://make.powerapps.com)
  
* Select your Development Environment `dev` (top right)
  
* Choose "solutions" and then "+new Solution"
  
    ![]({{site.baseurl}}/images/clojq50t5000109kyg03rhzr5.md/d9fe797b-cdf7-4a22-b962-5d8c4787fff0.png)
    
    * give it a meaningful full name and hit "create"
      
    
    ![]({{site.baseurl}}/images/clojq50t5000109kyg03rhzr5.md/a312904c-5724-4054-b3d6-a6ef83f4e599.png)
    
    * Open the new solution and add all components associated with the project.
      
    
    ![]({{site.baseurl}}/images/clojq50t5000109kyg03rhzr5.md/b0a64905-bd05-4942-bcb9-a547c8b1f672.png)
    

(in this case, we have created a solution with a basic Power Virtual Agents bot)

![]({{site.baseurl}}/images/clojq50t5000109kyg03rhzr5.md/00f90c2b-135e-4846-8d21-d4a335178a0f.png)

## Initial export of the solution

> Remember, we are beginning with a lightweight approach. Later, we will replace this with pipelines and, for example, GitHub Actions.

* Go to your codespace on GitHub (see part 2 of this series) and open the terminal
  
* List all your environments
  

```plaintext
pac org list
```

* and select the Development Environment `dev`
  

```plaintext
pac org select --environment <Unique Name>
```

![]({{site.baseurl}}/images/clojq50t5000109kyg03rhzr5.md/5f91126a-31a8-4a87-b2e3-2fbfcf3a5c30.png)

* list all your solutions within the environment
  

```plaintext
pac solution list
```

![]({{site.baseurl}}/images/clojq50t5000109kyg03rhzr5.md/b03305fc-ebfe-46bf-a1f9-139acb9f579f.png)

* create a new path in your repository and export the solution you created in the step before
  
    ```plaintext
    mkdir Solutions
    ```
    
    ```plaintext
    pac solution export --name <name of solution> --path Solutions
    ```
    

![]({{site.baseurl}}/images/clojq50t5000109kyg03rhzr5.md/d5afec8d-0579-4471-840d-9c10f5cf20dc.png)

* unpack the solution
  
    ```plaintext
    pac solution unpack --zipfile 'Solutions/demosolution_for_article.zip' --folder 'Solutions/demosolution'
    ```
    
* find a result similar to the screenshot in your codespace
  

![]({{site.baseurl}}/images/clojq50t5000109kyg03rhzr5.md/f1cc8fda-74d1-4b93-8f99-3bc2d329b1ba.png)

* commit your code to the repository
  
    * click on the source control icon on the left
      
    * enter a meaningful commit message, hit "commit" and sync
      

![]({{site.baseurl}}/images/clojq50t5000109kyg03rhzr5.md/a18ca8d1-42ae-4fa9-9d41-1b9af3775caf.png)

* Find your first commit in your repository on GitHub.
  
    ![]({{site.baseurl}}/images/clojq50t5000109kyg03rhzr5.md/200c81c9-b9a3-4e88-80b5-56eaac6ff4c9.png)
    

## Create a new branch, export a change, and create a pull request

After working on your solution, create a new branch in your codespace.  
Do not forget to add your changes to the solution, e.g right click on your bot and select "advanced" and "+Add required objects"

![]({{site.baseurl}}/images/clojq50t5000109kyg03rhzr5.md/c3020671-a43c-458c-85e4-f3eb6e573dbd.png)

* click on "main" in the status line
  
    ![]({{site.baseurl}}/images/clojq50t5000109kyg03rhzr5.md/a6882926-e537-46f4-a208-8a12f285c91d.png)
    
* click on "+ Create new branch"
  
    ![]({{site.baseurl}}/images/clojq50t5000109kyg03rhzr5.md/96f9043a-1b22-426b-97fc-30ee696d7340.png)
    
* please give it a meaningful name and export your solution.
  
    `pac solution export --name 'demosolution_for_article' --path Solutions --overwrite`
    
    and unpack
    
    `pac solution unpack --zipfile 'Solutions/demosolution_for_article.zip' --folder 'Solutions/demosolution'`
    
* find your changes in the source control menu, give your commit a name, and commit
  

![]({{site.baseurl}}/images/clojq50t5000109kyg03rhzr5.md/93abf473-02ee-4b09-b34a-c3092514eff9.png)

* create a new pull request via codespaces vscode web.
  
    * select the GitHub icon on the left
      
    * , click on the "Create Pull Request" icon
      

![]({{site.baseurl}}/images/clojq50t5000109kyg03rhzr5.md/bc6657e6-6e48-4c01-bdcf-eef9a6f75906.png)

* Give your PR a meaningful name and describe it to assist the repository maintainer in deciding to merge the PR.
  

![]({{site.baseurl}}/images/clojq50t5000109kyg03rhzr5.md/f632f621-263f-48b9-a837-471badc22abf.png)

* the maintainer will then see the PR and can decide whether to merge or not
  

## Additional Tasks

importing a solution file from the repository to an environment  
`pac solution import --path Solutions/demosolution_for_article.zip`

clone a solution (export and unpack) in one step  
`pac solution clone --name 'demosolution_for_article.zi'p --outputDirectory 'Solutions/cloned-demosolution'`

publish a solution  
`pac solution publish`

please find the complete documentation on the [Microsoft Learn page](https://learn.microsoft.com/en-us/power-platform/developer/cli/introduction)

## Next step

In the following article of this series, we will accomplish the same tasks using GitHub Actions to eliminate the manual steps.

## Conclusion

Solutions in Power Platform play a crucial role in Application Lifecycle Management, customization management, and deployment. By following the steps detailed in this article, you can effectively create, export, and manage solutions in your development environment. As you progress, you can further automate these tasks using tools like GitHub Actions to streamline your workflow and enhance productivity.