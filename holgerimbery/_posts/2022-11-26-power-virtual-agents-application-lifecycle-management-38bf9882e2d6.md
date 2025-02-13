---
layout: post
title: Power Virtual Agents Application Lifecycle Management
description: 
date: 2022-11-26
author: admin
image: ./images/archive.jpg
tags: [archive]
featured: false
toc: true

---


# Power Virtual Agents Application Lifecycle Management

a Step-by-Step Kickstarter to building automated software development lifecycle workflows for Power Virtual Agent and the Power Platform

This step-by-step guide will focus on best practices to automate building and deploying your Power Virtual Agent using "[GitHub Actions for Power Platform](https://github.com/marketplace/actions/powerplatform-actions)".

We will use at least four environments within this guide:  

* "development" per developer to build your bot,  
* "build" to generate a build artifact,  
* "test" to test your solution as a managed solution and  
* "production" to run the bot as a managed solution.  
A GitHub repository to store your solution and all your workflow files.

## Excursus: words on governance

Please consider a governance solution like "[Landing Zones for Power Platform](https://cloudblogs.microsoft.com/powerplatform/2022/02/18/north-star-architecture-and-landing-zones-for-power-platform/#:~:text=Within%20the%20context%20of%20the%20North%20Star%20Architecture%2C,regardless%20of%20citizen%20developer%20or%20professional%20developer%20persona.)" to create and manage your environments (Role-based Access Control [RBAC], apply policies, including data loss prevention, allowing connectors, or denying some), primarily if you work with fusion teams of pro and low-code developers. "Landing Zones for Power Platform" is Microsoft Reference architecture to govern Power Platform Deployments.

![Figure 2: deployment of your landing zones]({{site.baseurl}}/images/clay0x7bd000308m50jmmgnga.md/tubuzupcw.png)

Figure 2: deployment of your landing zones

![Figure 3: assign policies to your landing zones]({{site.baseurl}}/images/clay0x7bd000308m50jmmgnga.md/xh2ci3sup.png)

Figure 3: assign policies to your landing zones

### The idea behind the workflows

![Figure 4: GitHub Actions Workflow]({{site.baseurl}}/images/clay0x7bd000308m50jmmgnga.md/rfee74e0h.png)

Figure 4: GitHub Actions Workflow

[1] We will export the solution from your build environment to a new branch of your GitHub repository with the first workflow and a manual trigger.  
After inspecting the changes on GitHub, we will create a pull request and merge the pull request.  
[2] After merging a second workflow, we automatically build a managed solution within your build environment and import the managed solution into your test environment.  
After end-to-end testing, we create a new release on GitHub, and  
[3] the third workflow will automatically import the solution into your production environment.

### Authentication basics and solution

#### Create a service principal account

![Figure 5: Create a new App registrations on Azure]({{site.baseurl}}/images/clay0x7bd000308m50jmmgnga.md/s5ob26nmb.png)

Figure 5: Create new App registrations on Azure

To create a service principal account, we need to set up an App Registration in Azure Active Directory.

In the [Azure portal](https://portal.azure.com/), select "Azure Active Directory" in the left pane and select "App registrations", and click on "New registration".

On the "Register an application" page, enter your application's registration information:

* In the Name section, enter a meaningful application name like "Botplatform"

* Select "Accounts in any organizational directory" option from the Supported account types section.

* Click on "Register" to create the application.

Upon creation of the application registration, please note and save the "Directory (tenant) ID" and the "Application (client) ID" of the application.

On the navigation panel of the Overview page, select "API permissions".

* Choose "+ Add a permission", and in the "Microsoft APIs" tab, choose "Dynamics CRM".

* In the "Request API permissions" form, select "Delegated permissions", check "user_impersonation", and then choose "Add permissions".

* Back in the "Request API permissions" form, choose "PowerApps Runtime Service", select "Delegated permissions", check "user_impersonation", and then choose "Add permissions" again.

* For the third time in the "Request API permissions" form, choose "APIs my organization uses". Search for "PowerApps-Advisor" using the search field and select "PowerApps-Advisor" in the results list. Select "Delegated permissions", check "Analysis.All" rights, and then choose "Add permissions" for the last time.

Next, proceed to create a client secret. In the navigation panel, select "Certificates & secrets":

* Below "Client secrets", select "+ New client secret".

* In the form, enter a description and select "Add". Record the secret string; *you will not be able to view the secret again* once you leave the form.

#### Create an application user

![Figure 6: Create a new application user]({{site.baseurl}}/images/clay0x7bd000308m50jmmgnga.md/f461zbnui.png)

Figure 6: Create a new application user

To deploy solutions as part of a CI/CD pipeline, an "Application user" needs access to the environment. An "Application user" represents an unlicensed user that is authenticated using the application registration completed in the previous steps.

* Navigate to your environment on [Power Platform Admin Center](https://admin.powerplatform.microsoft.com/)

* Navigate to "Settings" &gt; "Users + permissions" &gt; "Application User".

* Select "+ new app user". A panel will open on the right-hand side of the screen.

* Select "+ Add an app". A list of all the application registrations in your Azure AD tenant is shown. Proceed to select the application name from the list of registered apps.

* Under "Business unit", in the dropdown box, select your environment as the business unit.

* Under "Security roles", select System administrator, and then select "create". This will allow the service principal access to the environment.

With the "App registration" and the "Application User", we can use "GitHub Actions" to manage our environments. Yes, *environments* as we need several to work safely and professionally. Please register this Application User in every environment you deploy (dev, staging, testing, and production).

#### Create a Solution

![Figure 7: Create a new solution in Power Platform Admin Center]({{site.baseurl}}/images/clay0x7bd000308m50jmmgnga.md/pwpvir7lm.png)

Figure 7: Create a new solution in Power Platform Admin Center

A solution is a kind of "application container".  
In this "box", you will find everything related to your project.  
Within the solution, you will find all your bots, flows, connector references, and other stuff a developer produced.

* Navigate to [https://make.powerapps.com](https://make.powerapps.com/) and sign in with your credentials. Click the "environment selector dropdown" in the header and select your development environment.

* Click the "Solutions" area in the left navigation and click the "New solution" button to create a new solution.

* In the side panel that appears, enter the application's name, and click the "Add Publisher" option.

* Select the publisher you just created on the new solution panel and click "Create" to create a new *unmanaged* solution in the environment.

* Select your solution in the solutions list and click the "Edit" button.

* Your new solution will be empty, and you need to add your bot. Click the "+ Add existing" and select your bot.

* After adding your bot use the tree dots menu item and "+ add required objects" to get everything into the solution.

![Figure 8: Add everything to the solution]({{site.baseurl}}/images/clay0x7bd000308m50jmmgnga.md/grgey7a1e.png)

Figure 8: add everything to the solution

#### Create a new GitHub secret for Service Principal Authentication

![Figure 9: Create a new GitHub Secret]({{site.baseurl}}/images/clay0x7bd000308m50jmmgnga.md/7ko-2iafc.png)

Figure 9: Create a new GitHub Secret

* Navigate to your repository and click "Settings", then expand "Secrets", and then "click Actions".

* On the Secrets page, name the secret "POWERPLATFORMSPN". Use the client secret from the application registration created in Azure Active Directory, enter it into the Value field, and then select "Add secret". The client secret will be referenced in the YML files used in your GitHub actions.

### Workflows

create four yml-files in the .github/workflow directory of your repository

#### export from dev, unpack, prepare, commit, and push to a new branch

> please update CLIENT_ID and TENANT_ID with your id´s and exchange the value for solution_name. Or store them as a secret in GitHub and integrate the secret here like the "PowerPlatformSPN" secret.

export-branch-solution.yml

name: export-and-branch-solution

```yaml
name: export-and-branch-solution
# Export solution from DEV environment
# unpack it and prepare, commit, and push a git branch with the changes

on:
  workflow_dispatch:
    inputs:
      # Change this value
      solution_name:
        description: 'name of the solution to worked on from Power Platform'
        required: true
        default: DemoEnvironment
       #Do Not change these values
      solution_exported_folder:
        description: 'folder name for staging the exported solution *do not change*'
        required: true
        default: out/exported/
      solution_folder:
        description: 'staging the unpacked solution folder before check-in *do not change*'
        required: true
        default: out/solutions/
      solution_target_folder: 
       description: 'folder name to be created and checked in *do not change*'
       required: true
       default: solutions/
      DEV_ENVIRONMENT_URL:
        description: 'Development environment url.'
        type: string
        required: true 
env:
#edit your values here
  CLIENT_ID: 'your_client_id'
  TENANT_ID: 'your_tenant_id'

jobs:
  export-from-dev:
    runs-on: windows-latest
    # or you can say runs-on: ubuntu-latest
    env:
      RUNNER_DEBUG: 1

    steps:
    - uses: actions/checkout@v2
      with:
        lfs: true

    - name: who-am-i action
      uses: microsoft/powerplatform-actions/who-am-i@0.4.0
      with:
        environment-url: ${{inputs.DEV_ENVIRONMENT_URL}}
        app-id: ${{env.CLIENT_ID}}
        client-secret: ${{ secrets.PowerPlatformSPN }}
        tenant-id: ${{env.TENANT_ID}}

    - name: export-solution action
      uses: microsoft/powerplatform-actions/export-solution@0.4.0
      with:
        environment-url: ${{inputs.DEV_ENVIRONMENT_URL}}
        app-id: ${{env.CLIENT_ID}}
        client-secret: ${{ secrets.PowerPlatformSPN }}
        tenant-id: ${{env.TENANT_ID}}
        solution-name: ${{ github.event.inputs.solution_name }}
        solution-output-file: ${{ github.event.inputs.solution_exported_folder}}/${{ github.event.inputs.solution_name }}.zip

    - name: unpack-solution action
      uses: microsoft/powerplatform-actions/unpack-solution@0.4.0
      with:
        solution-file: ${{ github.event.inputs.solution_exported_folder}}/${{ github.event.inputs.solution_name }}.zip
        solution-folder: ${{ github.event.inputs.solution_folder}}/${{ github.event.inputs.solution_name }}
        solution-type: 'Unmanaged'
        overwrite-files: true

    - name: branch-solution, prepare it for a PullRequest
      uses: microsoft/powerplatform-actions/branch-solution@v0
      with:
        solution-folder: ${{ github.event.inputs.solution_folder}}/${{ github.event.inputs.solution_name }}
        solution-target-folder: ${{ github.event.inputs.solution_target_folder}}/${{ github.event.inputs.solution_name }}
        repo-token: ${{ secrets.GITHUB_TOKEN }}
        allow-empty-commit: true
```

to start this manual flow, go to "Action", select the flow, click "Run workflow" and insert your values into the fields.

![Figure 10: export to a new branch dialog]({{site.baseurl}}/images/clay0x7bd000308m50jmmgnga.md/xzqout-i9.gif)

Figure 10: export to a new branch dialog

#### Convert the solution to managed, upload the solution to the GitHub artifacts and deploy to the xxx environment

reusable basic flow

release-solution-to-xxx-reusable.yml

```yaml
name: release-solution-to-xxx-reusable
# Reusable workflow
# convert solution to managed (using a build PowerPlatform environment for the conversion)
# upload the solution to the GitHub artifacts and deploy to the xxx environment
on:
  workflow_call:
    inputs: 
      #Do Not change these values
      #Values are set by the caller
      #caller sample: release-action-call.ymnl
      solution_name:
        description: 'The solution name.'
        type: string
        default: DemoEnvironment       
      solution_shipping_folder:
        description: 'folder name for staging the exported solution *do not change*'        
        type: string
        default: out/ship/
      solution_outbound_folder:
        description: 'staging the unpacked solution folder before check-in *do not change*'
        type: string
        default: out/solutions/
      solution_source_folder: 
       description: 'folder name to be created and checked in *do not change*'
       type: string
       default: solutions/
      solution_release_folder:
       description: 'folder where the released binaries are going to be hosted *do not change*'
       type: string
       default: out/release
      BUILD_ENVIRONMENT_URL:
        description: 'Build environment url.'
        type: string
        required: true      
      TARGET_ENVIRONMENT_URL: 
        description: 'target environment url.'
        type: string
        required: true
      CLIENT_ID: 
        description: 'The client id'
        type: string
        required: true
      TENANT_ID: 
        description: 'The tenant id'
        type: string
        required: true
    secrets:
      envSecret:
        description: 'The secret value for authentication using SPN'
        required: true

jobs:
  convert-to-managed:
    runs-on: windows-latest
    # or you can say runs-on: ubuntu-latest
    env:
      RUNNER_DEBUG: 1

    steps:
    - uses: actions/checkout@v2
      with:
        lfs: true

    - name: Pack solution
      uses: microsoft/powerplatform-actions/pack-solution@0.4.0
      with:
        solution-folder: ${{ inputs.solution_source_folder}}/${{ inputs.solution_name }}
        solution-file: ${{ inputs.solution_outbound_folder}}/${{ inputs.solution_name }}.zip
        solution-type: Unmanaged

    - name: Import solution as unmanaged to build env
      uses: microsoft/powerplatform-actions/import-solution@0.4.0
      with:
        environment-url: ${{inputs.BUILD_ENVIRONMENT_URL}}
        app-id: ${{inputs.CLIENT_ID}}
        client-secret: ${{ secrets.envSecret }}
        tenant-id: ${{inputs.TENANT_ID}}
        solution-file: ${{ inputs.solution_outbound_folder}}/${{ inputs.solution_name }}.zip
        force-overwrite: true
        publish-changes: true

    - name: Export solution as managed
      uses: microsoft/powerplatform-actions/export-solution@0.4.0
      with:
        environment-url: ${{inputs.BUILD_ENVIRONMENT_URL}}
        app-id: ${{inputs.CLIENT_ID}}
        client-secret: ${{ secrets.envSecret }} 
        tenant-id: ${{inputs.TENANT_ID}}
        solution-name: ${{ inputs.solution_name }}
        managed: true
        solution-output-file: ${{ inputs.solution_shipping_folder}}/${{ inputs.solution_name }}.zip

    - name: Upload the ready to ship solution to GH artifact store
      uses: actions/upload-artifact@v2
      with:
        name: managedSolutions
        path: ${{ inputs.solution_shipping_folder}}/${{ inputs.solution_name }}.zip

  release-to-target:
    needs: [ convert-to-managed ]
    runs-on: windows-latest
    env:
      RUNNER_DEBUG: 1

    steps:
    - uses: actions/checkout@v2
      with:
        lfs: true

    - name: Fetch the ready to ship solution from GH artifact store
      uses: actions/download-artifact@v2
      with:
        name: managedSolutions
        path: ${{ inputs.solution_release_folder}}
    - name: Import solution to target env
      uses: microsoft/powerplatform-actions/import-solution@0.4.0
      with:
        environment-url: ${{inputs.TARGET_ENVIRONMENT_URL}}
        app-id: ${{inputs.CLIENT_ID}}
        client-secret: ${{ secrets.envSecret }}
        tenant-id: ${{inputs.TENANT_ID}}
        solution-file: ${{ inputs.solution_release_folder}}/${{ inputs.solution_name }}.zip
        force-overwrite: true
```

create a starter flow for "deploy to test" and "deploy to production"

> please update CLIENT_ID, TENANT_ID, BUILD_ENVIRONMENT_URL and TARGET_ENVIRONMENT_URL with your id´s and exchange the value for solution_name. Or store them as a secret in GitHub and integrate it here like the "PowerPlatformSPN" secret.

release-to-test.yml

```yaml
name: Release action to test
# Call the reusable workflow release-solution-to-xxx-reusable.yml
# Release your solution to staging.

on:
  pull_request:
    types:
      - closed
  workflow_dispatch:
  
  
jobs:
  Release-solution-staging:
    uses: ./.github/workflows/release-solution-to-xxx-reusable.yml
    with:
      #You can specify the solution name here
      solution_name: DemoEnvironment
      #Update your values here
      BUILD_ENVIRONMENT_URL: 'yourvalue'
      TARGET_ENVIRONMENT_URL: 'yourvalue'
      CLIENT_ID: 'yourvalue'
      TENANT_ID: 'yourvalue'  
    secrets:
     envSecret: ${{ secrets.PowerPlatformSPN }}
```

release-to-production.yml

```yaml
name: Release action production
# Call the reusable workflow release-solution-to-xxx-reusable.yml
# Release your solution to staging.

on:
  release:
    types: [published]
  workflow_dispatch:
  
  
jobs:
  Release-solution-staging:
    uses: ./.github/workflows/release-solution-to-xxx-reusable.yml
    with:
      #You can specify the solution name here
      solution_name: DemoEnvironment
      #Update your values here
      BUILD_ENVIRONMENT_URL: 'yourvalue'
      TARGET_ENVIRONMENT_URL: 'yourvalue'
      CLIENT_ID: 'yourvalue'
      TENANT_ID: 'yourvalue'  
    secrets:
     envSecret: ${{ secrets.PowerPlatformSPN }}
```

both actions are triggered automatically (merge or release) and can triggered manually (workflow_dispatch). For a manual run, go to "Action", select the flow, click on "Run workflow" and insert your values into the fields

#### Optional: Deploy a solution to a new development environment

deploy-development.yml

```yaml
name: deploy development environment
# Reusable workflow
# deploy solution to a development environment

on:
  workflow_dispatch:
    inputs: 
      #Do Not change these values

      solution_name:
        description: 'The solution name.'
        type: string
        default: DemoEnvironment       
      solution_outbound_folder:
        description: 'staging the unpacked solution folder before check-in *do not change*'
        type: string
        default: out/solutions/
      solution_source_folder: 
       description: 'folder name to be created and checked in *do not change*'
       type: string
       default: solutions/
      DEV_ENVIRONMENT_URL:
        description: 'Development environment url.'
        type: string
        required: true      
      CLIENT_ID: 
        description: 'The client id'
        type: string
        required: true
      TENANT_ID: 
        description: 'The tenant id'
        type: string
        required: true

jobs:
  convert-to-unmanaged:
    runs-on: windows-latest
    # or you can say runs-on: ubuntu-latest
    env:
      RUNNER_DEBUG: 1

    steps:
    - uses: actions/checkout@v2
      with:
        lfs: true

    - name: Pack solution
      uses: microsoft/powerplatform-actions/pack-solution@0.4.0
      with:
        solution-folder: ${{ inputs.solution_source_folder}}/${{ inputs.solution_name }}
        solution-file: ${{ inputs.solution_outbound_folder}}/${{ inputs.solution_name }}.zip
        solution-type: Unmanaged

    - name: who-am-i action
      uses: microsoft/powerplatform-actions/who-am-i@0.4.0
      with:
        environment-url: ${{inputs.DEV_ENVIRONMENT_URL}}
        app-id: ${{inputs.CLIENT_ID}}
        client-secret: ${{ secrets.PowerPlatformSPN }}
        tenant-id: ${{inputs.TENANT_ID}}

    - name: Import solution as unmanaged to dev env
      uses: microsoft/powerplatform-actions/import-solution@0.4.0
      with:
        environment-url: ${{inputs.DEV_ENVIRONMENT_URL}}
        app-id: ${{inputs.CLIENT_ID}}
        client-secret: ${{ secrets.PowerPlatformSPN }}
        tenant-id: ${{inputs.TENANT_ID}}
        solution-file: ${{ inputs.solution_outbound_folder}}/${{ inputs.solution_name }}.zip
        force-overwrite: true
        publish-changes: true
```

to start this manual flow, go to "Action", select the flow, click "Run workflow" and insert your values into the fields.

![Figure 11: Dialog to deploy new Development Environment]({{site.baseurl}}/images/clay0x7bd000308m50jmmgnga.md/1bwc1jm_r.gif)

Figure 11: Dialog to deploy new Development Environment

### Assets

Please find sample scripts in my GitHub repository [ALM-for-PVA](https://github.com/the-cognitiveservices-ninja/ALM-for-PVA)

### Additional Information - a curated list

[Landing Zones for Power Platform](https://github.com/microsoft/industry/tree/main/foundations/powerPlatform) - a Reference Architecture  
[Power Platform GitHub Actions](https://learn.microsoft.com/en-us/power-platform/alm/devops-github-actions) - ALM for Developers
