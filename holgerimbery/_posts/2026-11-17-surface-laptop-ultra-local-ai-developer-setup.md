---
layout: post
canonical_url: https://holgerimbery.blog/surface-laptop-ultra-local-ai-developer-setup
title: "Local AI Development with the Surface Laptop Ultra"
description: "Cloud AI is powerful, but every prompt costs tokens, your code leaves the building, and nothing works without a network. A laptop that runs a strong coding model on its own GPU removes all three limits for everyday work. You can experiment freely, keep sensitive code and data on your own machine, and still use cloud models when a task really needs them."
date: 26-11-17
author: admin
slug: surface-laptop-ultra-local-ai-developer-setup
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/11/florian-olivo-4hbJ-eymZ1o-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@florianolv?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Florian Olivo</a> on <a href="https://unsplash.com/photos/lines-of-html-codes-4hbJ-eymZ1o?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
tags:
  - arm64
  - foundrylocal
  - githubcopilot
  - localai
  - localinference
  - surface
  - surfacelaptopultra
  - windowsml
  - windowsonarm
  - wsl
featured: true
toc: true
---

{: .q-left }
> In [Building On-Prem AI Agents with Azure Local, Foundry Local, and Microsoft Agent Framework](https://holgerimbery.blog/building-on-prem-ai-agents-with-azure-local-foundry-local-and-microsoft-agent-framework) I ran AI models in the data center. This article is about something else: a developer workstation. Below I describe how I set up a Surface Laptop Ultra with 128 GB of memory for local AI development, and why I made each choice. Before and during the setup I read a lot of documentation and articles. Some came from Microsoft, GitHub, NVIDIA, and Docker. Others came from reviewers and other developers. This article is what I took from all of that, together with what I saw on my that laptop. I also compare my setup with what others have published about the same laptop, and I point out where the official documents and the hands-on reports do not agree.

{: .note }
This article is about setting up one developer's workstation. It does not replace a Foundry Local or Azure Local setup in the data center, and it is not a guide for serving models to a team or to production apps. I use the laptop to write, test, and try out AI code on my own. When something needs to run for other people, it moves to the data center or the cloud.

{: .important }
I wrote this article just before Microsoft Ignite 2026, which runs from November 17 to 20, 2026, in San Francisco. At its Windows event in October, Microsoft said more local AI features for Microsoft Copilot on Windows are on the way, and it invited readers to Ignite to learn more. Some steps here may change after Ignite. I plan to update the article once the announcements are out.

## Why this laptop is different

Until now, my laptops did very little AI work themselves. They sent prompts to the cloud and showed the answers. The Surface Laptop Ultra can run large models on its own. Microsoft's tech specs list an "NVIDIA RTX Spark N1X" chip with up to a 6144-core GPU and a 20-core CPU, and up to 128 GB of LPDDR5x unified memory. On the product page Microsoft says CUDA speeds up "local agent workflows powered by models up to 120B parameters".

Unified memory means the CPU and the GPU use the same memory. That is why a laptop can load a model this big. But it also means you do not get 128 GB just for the GPU. Windows, the code editor, the browser, WSL, the model, and the memory the model needs for long prompts all share the same 128 GB.

The second point shaped almost every choice I made. This is a Windows on Arm laptop. It is not a normal Intel or AMD laptop with an NVIDIA graphics card. Windows can run most x64 apps on Arm through emulation (Microsoft calls it Prism). But Microsoft's documentation says "emulation only supports user mode code and doesn't support drivers". So any tool that needs a driver or talks to the GPU directly must have a real Arm64 version. Many CUDA install guides assume an x64 machine, so I read every guide carefully before I followed it.

## My setup at a glance

After a few evenings of testing, I settled on a mix of local and cloud tools:

1. **Windows 11** runs the drivers, the security features, and the GPU.
2. **The GitHub Copilot app** is where I do most of my work, with its local Windows ML models.
3. **WSL 2 with Ubuntu 24.04** is for Linux work and for Python with CUDA.
4. **Arm64 versions of my tools** wherever they exist. I use emulation only when there is no Arm64 version.
5. **Cloud models in the GitHub Copilot app** for big, hard, or security-related problems.
6. **Foundry Local** is my second local model runner, for my own apps and tests. Connecting it to the GitHub Copilot app is optional.
7. **Ollama** is optional. I have not installed it. If you want it, check first that it really uses the GPU.

The order is on purpose. I start with what Microsoft and GitHub built and documented for this hardware. Then I add other tools one at a time and test each one before I rely on it.

{: .note }
Two different apps have "Copilot" in their name, and both show up in this article. **The GitHub Copilot app** is GitHub's desktop app for coding agents. It is the one with the local Windows ML models, and it is the center of this setup. **The Microsoft 365 Copilot app** (Microsoft now calls it Microsoft Copilot) is for email, meetings, documents, and Cowork. It runs in Microsoft's cloud and does not use local models today. When I write about local models, worktrees, or agent sessions, I always mean the GitHub Copilot app.

| Part | What I use | Why |
|---|---|---|
| Coding agent | GitHub Copilot app | Separate worktrees, several sessions at once, local and cloud models in one list |
| Local coding model | MAI Code 1.1 Flash through Windows ML | Documented for this kind of hardware, runs on my own GPU |
| Local model runner for my apps | Foundry Local | Made by Microsoft, offers an OpenAI-compatible API |
| Linux and Python | WSL 2, Ubuntu 24.04 | Standard Linux CUDA tools work there |
| Optional runner | Ollama | Many models to choose from, but GPU use must be checked |
| Hard problems | Cloud models | Better results for architecture and security work |

## Step 1: Power, updates, and security

I set the laptop up from scratch. I did not restore a backup from my old machine. A restore would have brought back old x64 apps, and they would have run under emulation without me noticing. maruhana, a developer who wrote about his first day with this laptop on Zenn, gives the same advice for the same reason.

**Power.** Microsoft Support recommends "a minimum 115W of power" and a USB-C cable that "supports 5 amps". Microsoft's 140 W adapter gives 28 volts at 5 amps. The tech specs say this adapter only ships in some countries, so check what is in your box. I always use the 140 W adapter when I run models. A weaker dock or charger can slow the laptop down, or it may not charge at all under heavy load.

**Updates.** I ran Windows Update again and again, with a restart each time, until no updates were left. The tech specs say Surface firmware and drivers come through Windows Update. Then I opened **Settings > Windows Update > Advanced options > Optional updates** and installed every driver update listed there. Microsoft's Surface support page recommends installing all optional updates and checking that all drivers named "Surface" are installed. The Surface app shows the same update status under **Help & support**.

**NVIDIA driver.** Windows Update brings the Surface driver package, but NVIDIA releases newer graphics drivers on its own schedule. So I installed the NVIDIA app and used its **Drivers** page to get the latest RTX Spark driver. NVIDIA released the first one, version 617.42, on October 16, 2026, and says you can install it "from the NVIDIA app or our website". If you use the website, pick the RTX Spark driver. A normal GeForce driver for x64 laptops will not install, because drivers on this laptop must be native Arm64.

**Game Ready or Studio.** The NVIDIA app offers two types of driver for RTX Spark: a Game Ready driver and a Studio driver. When I set up the laptop, both had the same version (621.24, released November 12, 2026). NVIDIA says that all its drivers "provide full features and application support" for games and creative apps. Game Ready is for gamers who want support for new games on launch day. Studio is for people who care most about stability. Neither type has anything extra for AI or CUDA. I picked the Studio driver, because this is a work machine and I prefer fewer, better tested updates over game updates. You can switch between the two types in the NVIDIA app at any time.

**What I installed.** I chose **Custom installation** to see the parts. The graphics driver is always installed. I left **PhysX System Software** and **HD Audio Driver** ticked. PhysX is mostly for games but does no harm, and the HD Audio driver sends sound to monitors over HDMI or DisplayPort. I left **Clean installation** unticked, because it resets all NVIDIA settings and profiles, including the GPU memory share from Step 2. I only use it if a driver causes problems. After a restart, `nvidia-smi` in PowerShell shows the driver version.


**Security.** The laptop is a Secured-core PC with TPM 2.0 and BitLocker. In **Windows Security > Device security** I checked that Secure Boot, the TPM, and core isolation were on. Then I turned on BitLocker and saved the recovery key somewhere other than the laptop.

**Power mode.** In **Settings > System > Power & battery** I use **Balanced** for normal work. When I am plugged in and running models, builds, or containers, I switch to **Best performance**.



AI work is slower on battery. The New Stack measured about 20% to 25% less speed on battery, and The Neuron measured about 14% less. These numbers come from reviewers, not from Microsoft. My rule: long agent sessions and large models only when the charger is plugged in.

## Step 2: Plan memory and disk space

### Memory

Everything shares the same memory, so I decided in advance how much each part may use.

The first surprise was how much memory Windows gets. On my laptop, **Settings > System > About** shows **Installed RAM: 128 GB (64 GB usable)**. The other 64 GB is set aside for the GPU. Task Manager shows it as **Hardware reserved** under **Performance > Memory**, and as **Dedicated GPU memory** under **Performance > GPU**. So Windows, WSL, and all my apps share 64 GB, and the GPU has its own 64 GB for models.

The GPU can use more than its own share, though. Under **Performance > GPU**, Task Manager shows **Dedicated GPU memory** of 62.5 GB and **Shared GPU memory** of 48 GB on my laptop. The shared part is not extra memory. It is borrowed from the 64 GB that Windows uses. CUDA counts both together: llama.cpp reported 112,350 MiB of GPU memory, which is about 110 GB. So a model that is too big for the dedicated 62.5 GB can still load, but it then takes memory away from Windows, WSL, and my apps. I keep the models I use every day inside the dedicated share. MAI Code 1.1 Flash, the biggest of them at 52.4 GB, fits with room left for its context.

That room shrinks during a session. Microsoft explains that the memory a model uses to keep track of its context grows as an agent reads files and gets tool results. Microsoft measured a peak of 75.5 GB for MAI Code 1.1 Flash at the full 256K context. That is more than the 62.5 GB the GPU has of its own, so a very long session borrows memory from Windows. A model that loads fine at the start of a task can still run short of memory later.

* **The GPU share** can be changed in the NVIDIA app. I know this from reviewers, not from Microsoft. StorageReview tested with the same 64/64 split, which gave the GPU about 62.5 GB. maruhana raised the GPU share to 95.5 GB for large models and got a stability warning at the highest setting. A bigger GPU share means less memory for Windows and WSL, and the other way round.
* **WSL** gets a fixed limit (see Step 4). With 64 GB for Windows, I give WSL 40 GB.
* **The GitHub Copilot app** has a slider called **Maximum % system memory to use** for its local models. I set it so that Windows and my other tools always keep at least 24 GB to 32 GB.

For daily work I keep the 64/64 split. I only change it for a session with a very large model. Since only reviewers mention this setting, treat it with care until Microsoft or NVIDIA documents it.



### Disk space

My laptop has the 1 TB drive. Windows shows it as about 931 GB, and that space runs out faster than you think once you keep a few models around. I split it with folders, not partitions:

| Size | Use |
|---|---|
| About 200 GB | Windows, apps, and developer tools |
| About 200 GB | Code repositories, WSL, containers |
| About 350 GB | Local models |
| At least 150 GB free | Model conversion, Docker files, temporary files, updates |

Models fill a disk fast. The GitHub Copilot app alone needs 60 GB of free space for MAI Code 1.1 Flash and 23 GB for Flint NVFP4, so the two built-in models take almost a quarter of my model budget before I add anything else. Many models also come in several compressed versions (called quantizations), and keeping a few of each adds up quickly. With 1 TB I keep only one version of each model and delete models I have not used for a few weeks. I keep all my models in one folder, which makes it easy to see what takes up space. If you add Ollama later, its `OLLAMA_MODELS` environment variable lets you point it to the same place.

I do not use extra partitions. Folders are easier to resize and back up, and BitLocker protects the whole drive anyway.

## Step 3: Arm64 tools first

My rule for this laptop is simple: every tool I install must be the Arm64 version. These are the tools I installed first, all as Arm64 builds:

* Windows Terminal
* Git for Windows and the GitHub CLI
* Visual Studio Code Insiders
* PowerShell 7
* Python 3.15
* Node.js LTS
* .NET SDK
* The Microsoft 365 Copilot app, for my Microsoft 365 work and Cowork

**Why VS Code Insiders.** I use the Insiders build instead of the stable one. Microsoft describes it as the place to "get early access to the latest AI agent features in VS Code". New builds come out every day, and it installs next to the stable version, so I can switch back if a build breaks. The download page offers Arm64 builds for Windows.

**Why Python 3.15.** When I wrote this, python.org listed Python 3.15.2 as the latest Python 3 release, with an ARM64 installer for Windows. The Microsoft Learn guide for Python on Windows still uses 3.14 in its example, so check python.org for the current version.

**The Microsoft 365 Copilot app.** Microsoft now calls it Microsoft Copilot, but the Learn pages still use the old name too. I use it for email, meetings, documents, and Cowork. It is not part of the local AI setup. Cowork runs in Microsoft's cloud and does not use the models on my laptop yet. Microsoft has announced that Microsoft Copilot on Windows will be able to use local models, but that had not shipped when I wrote this.

I run winget in a normal PowerShell window, not as administrator. When a package needs admin rights, Windows asks with a UAC prompt for that package only. Some tools, like VS Code Insiders, install for your user account only and should not run as administrator. The only step in this article that needs an elevated terminal is the WSL install in Step 4.

I install everything with `winget` and add `--architecture arm64`, so winget picks the Arm64 installer. If a package has no Arm64 installer, winget stops with an error instead of quietly installing the x64 version. That is exactly what I want. Microsoft Learn uses the package IDs `Microsoft.PowerShell` and `Microsoft.VisualStudioCode`. The other IDs below are the ones I used. Package IDs change now and then, so if one is not found, run `winget search <name>`.

```powershell
winget upgrade --all

winget install --id Microsoft.WindowsTerminal --architecture arm64
winget install --id Git.Git --architecture arm64
winget install --id GitHub.cli --architecture arm64
winget install --id Microsoft.VisualStudioCode.Insiders --architecture arm64
winget install --id Microsoft.PowerShell --architecture arm64
winget install --id Python.Python.3.15 --architecture arm64
winget install --id OpenJS.NodeJS.LTS --architecture arm64
winget install --id Microsoft.DotNet.SDK.10 --architecture arm64
winget install --id Microsoft.365Copilot
```

The Microsoft 365 Copilot app is the one exception to the flag. Its winget package has a single installer for all types of Windows, so the Arm64 filter does not apply. You can also install it from the Microsoft Store.

To check that an app really runs as Arm64, open Task Manager, go to **Details**, right-click a column header, choose **Select columns**, and turn on **Architecture**. Every app should show ARM64. If one shows x64, it runs under emulation, and I look for an Arm64 version.

maruhana got a certificate error from the Microsoft Store source when he installed Python. He fixed it by adding `-s winget` to the command. I did not see that error, but it is good to know.

Then I set up Git and signed in to GitHub:

```powershell
git config --global user.name "Holger Imbery"
git config --global init.defaultBranch main
git config --global core.autocrlf input
git config --global fetch.prune true
git config --global pull.rebase false

gh auth login
gh auth status
```

My folders on the Windows side are simple:

```text
C:\Dev\
  github\
  experiments\
  models\
  datasets\
```

I never put passwords, API keys, or production data into a repository. I keep them in Windows Credential Manager, in environment variables, in `.env` files that are listed in `.gitignore`, or in a secrets manager.

## Step 4: WSL 2 for Linux work

The GitHub Copilot app documentation says that on Windows you "can also run agent sessions inside a Windows Subsystem for Linux (WSL) 2 distribution". Also, the normal Linux CUDA tools work inside WSL. So WSL is where I do my Linux and Python work.

In PowerShell, run as administrator:

```powershell
wsl --list --online
wsl --install -d Ubuntu-24.04
wsl --update
wsl --set-default-version 2
wsl --list --verbose
```

I run `wsl --list --online` first to get the exact name of the Ubuntu version from the current list. After a restart I created my Ubuntu user and installed the basic tools. From here on, the `bash` commands run in the Ubuntu terminal, not in PowerShell. I open it with `wsl -d Ubuntu-24.04` or from the Start menu:

```bash
sudo apt update
sudo apt full-upgrade -y

sudo apt install -y \
  build-essential git git-lfs curl wget unzip jq \
  pkg-config cmake ninja-build \
  python3 python3-venv python3-pip

git lfs install
```

Next I turned on systemd, and I stopped WSL from adding the Windows search path to Linux. Both settings are in the WSL documentation. This also runs in the Ubuntu terminal:

```bash
sudo tee /etc/wsl.conf >/dev/null <<'EOF'
[boot]
systemd=true

[interop]
appendWindowsPath=false
EOF
```

`appendWindowsPath=false` keeps Windows programs out of the Linux search path. That keeps Linux tools clean, but it also means Linux no longer finds `code-insiders`. I found that out when `code-insiders .` stopped working. So I add only the VS Code Insiders folder back, again in the Ubuntu terminal. Replace `<your Windows user name>` with yours:

```bash
echo 'export PATH="$PATH:/mnt/c/Users/<your Windows user name>/AppData/Local/Programs/Microsoft VS Code Insiders/bin"' >> ~/.bashrc
```

If VS Code Insiders was installed for all users, the folder is `/mnt/c/Program Files/Microsoft VS Code Insiders/bin` instead.

Then I ran `wsl --shutdown` in PowerShell so the changes take effect.

### How much memory WSL gets

WSL never sees all 128 GB. It can only use what Windows has, which is 64 GB on my laptop (see Step 2). Without a settings file, WSL takes half of that (about 32 GB) and all 20 processors. I wanted a bit more for Linux, but not so much that Windows, the GitHub Copilot app, and my editor run short.

The settings live in a file called `.wslconfig` in your user folder (`C:\Users\<your name>`). One trap: the path `%UserProfile%\.wslconfig` that you see in many guides only works in the old Command Prompt. In PowerShell, use `$env:USERPROFILE` instead. My first attempt with Notepad left an empty file, and WSL quietly kept its defaults. The safest way is to write the file straight from PowerShell:

```powershell
@"
[wsl2]
memory=40GB
processors=16
swap=8GB
localhostForwarding=true

[experimental]
autoMemoryReclaim=gradual
sparseVhd=true
"@ | Set-Content -Path "$env:USERPROFILE\.wslconfig" -Encoding utf8
```

`memory`, `processors`, `swap`, and `localhostForwarding` go under `[wsl2]`. The current WSL documentation still lists `autoMemoryReclaim` and `sparseVhd` under `[experimental]`. Docker's documentation also recommends `autoMemoryReclaim`. With it, Linux gives unused memory back to Windows instead of keeping it.

WSL only reads the file when it starts, so restart it and check that the values are active:

```powershell
Get-Content "$env:USERPROFILE\.wslconfig"
wsl --shutdown
wsl -d Ubuntu-24.04 -- bash -c "free -g; nproc"
```

`nproc` should show 16, and `free -g` a total of about 39 GB. The WSL Settings app shows the same values under **Memory and processor**. If it still shows about 32 GB, 20 processors, and 8 GB swap, WSL did not read your file. You can also set the values directly in the WSL Settings app, which writes the same file for you.


My rule: 40 GB by default. If I give the GPU less memory in the NVIDIA app, Windows gets more, and I can raise WSL to match. I always leave Windows at least 24 GB.

### Keep Linux code in the Linux file system

Microsoft says to "store your files in the WSL file system if you are working in a Linux command line". So I clone Linux projects into `~/src`, not into `/mnt/c`. In the Ubuntu terminal:

```bash
mkdir -p ~/src && cd ~/src
gh repo clone OWNER/REPOSITORY
code-insiders .
```

Building under `/mnt/c` works, but it is slower, because every file access crosses from Linux to Windows. It can also cause problems with file permissions and with tools that watch for file changes.

## Step 5: The GitHub Copilot app

The GitHub Copilot app is the center of my setup. GitHub says the app lets you "run multiple isolated agent sessions simultaneously, each with a dedicated git worktree and branch". This is the feature I care about most. Several agents can work at the same time, and none of them touches my own copy of the code or the work of another agent.

I downloaded the app from GitHub and signed in. If you use Copilot Business or Copilot Enterprise, GitHub says the app policy "must remain enabled". It is on by default. If the app does not work in your company, ask your admin whether it was turned off.

For each new task I choose:

* **Environment:** This computer (the other choice is Cloud)
* **Workspace:** New worktree
* **Mode:** Plan for bigger changes, Interactive when I want to watch each step

The app also has an Autopilot mode. I do not use it on this laptop yet. While I learn how the local model behaves, I want to see the plan and approve each change.

I only choose **Current checkout** when I want the agent to change my own working copy.



## Step 6: Turning on the local models in the GitHub Copilot app

This was the part I was most interested in, and it takes more than one click. GitHub's documentation says Windows users "with an NVIDIA GPU and sufficient memory" can install **MAI Code 1.1 Flash** and **Flint NVFP4** on their own machine from inside the app. The feature is in public preview.

### What you need, and why 128 GB matters

The requirements are clear:

| Model | Minimum free memory (RAM and GPU combined) | Minimum free disk space |
|---|---|---|
| MAI Code 1.1 Flash | 96 GB | 60 GB |
| Flint NVFP4 | 48 GB | 23 GB |

You also need an NVIDIA GPU (AMD does not work) and llama.cpp version 0.7.0 or later. The `LLAMACPP_SERVER_PATH` environment variable must point to it. MAI Code 1.1 Flash needs llama.cpp build b11669 or later, and Flint NVFP4 needs build b11803 or later.

The 96 GB requirement is the reason I bought the 128 GB model. On a 64 GB laptop, you cannot run MAI Code 1.1 Flash.

### Installing llama.cpp for Arm64 with CUDA

The local models in the GitHub Copilot app run on llama.cpp, so you install that first. GitHub's guide says to take the "Windows CUDA 13.4 ARM64 build" from the llama.cpp releases page at `https://github.com/ggml-org/llama.cpp/releases`. Newer llama.cpp releases now ship CUDA 13.5 instead, so I took the newest release (any build from b11803 on works) and downloaded the two files listed under **Windows arm64 (CUDA 13)**:

* the llama.cpp package, named like `llama-<build>-bin-win-cuda-13.5-arm64.zip`
* the CUDA runtime files, named like `cudart-llama-bin-win-cuda-13.5-arm64.zip`

Do not take the `x64` files, or the `cpu`, `vulkan`, or `opencl-adreno` versions for Arm64. Before you start, run `nvidia-smi` and check that **CUDA Version** in the top right is 13.5 or higher.

GitHub's guide uses Command Prompt. I work in PowerShell, where `%LOCALAPPDATA%` does not work. My first `mkdir` created a folder literally called `%LOCALAPPDATA%` in the wrong place. In PowerShell, create the folder like this, using your build number:

```powershell
New-Item -ItemType Directory -Force -Path "$env:LOCALAPPDATA\Programs\llama.cpp\<build>-cuda-13.5-arm64"
explorer "$env:LOCALAPPDATA\Programs\llama.cpp\<build>-cuda-13.5-arm64"
```

Unpack both ZIP files into that folder, without subfolders. When you use Extract All in File Explorer, it creates a new subfolder for each ZIP file, so change the target. When it is right, `llama-server.exe` sits next to `cudart64_13.dll`, `cublas64_13.dll`, and `cublasLt64_13.dll`.

Then set the variable, open a new PowerShell window, and check that llama.cpp can see the GPU:

```powershell
setx LLAMACPP_SERVER_PATH "$env:LOCALAPPDATA\Programs\llama.cpp\<build>-cuda-13.5-arm64\llama-server.exe"
```

```powershell
& $env:LLAMACPP_SERVER_PATH --list-devices
```

After setting the variable, restart the GitHub Copilot app, VS Code Insiders, and the GitHub Copilot CLI so they see it.


### Smart App Control blocks llama.cpp

My first test failed. Windows showed a "Bad Image" message saying `mtmd.dll` "is either not designed to run on Windows or it contains an error", with error status 0xc0e90002. The file was fine. The Code Integrity log (**Event Viewer > Applications and Services Logs > Microsoft > Windows > CodeIntegrity > Operational**) had an event 3077 for the same file, with the policy ID {0283AC0F-FFF1-49AE-ADA1-8A933130CAD6}. That is Smart App Control, which was on by default on my new laptop.

Smart App Control blocks programs that Microsoft's cloud service does not know and that have no valid signature. The llama.cpp builds are not signed, and new ones come out several times a day, so they are never known. Microsoft's FAQ is clear that "there is currently no way to bypass Smart App Control protection for individual apps". You either keep it on or turn it off.

This is a security decision, and you should make it yourself (or leave it to your IT department on a work device):

* **Keep Smart App Control on.** The built-in local models in the GitHub Copilot app will not work. Cloud models and Foundry Local still do.
* **Turn it off** in **Windows Security > App & browser control > Smart App Control settings**. Windows then stops checking unknown, unsigned programs before they run. Microsoft Defender keeps working. Recent Windows updates let you turn Smart App Control back on later without reinstalling Windows, but it will block llama.cpp again as soon as it is on.

I turned it off. This laptop is my developer workstation, and I install developer tools on it all the time that are unsigned. Microsoft itself says that Smart App Control may not be "a great experience" for developers. In return I am more careful about what I download, I only take llama.cpp from its official GitHub releases page, and I keep Microsoft Defender on.

### Adding the Windows ML provider

In the app:

1. Open **Settings**.
2. In the sidebar, click **Model providers**.
3. Click **Add provider** and select **Windows ML**.
4. Under **Available models**, click **Download** next to the model you want.
5. Set the **Maximum % system memory to use** slider.
6. Turn on **Restart models on app restart** if you want the model to load again after the app restarts.

Two more settings are in the **Experimental** section. **Windows ML local models** (under **Agents**) turns the feature on or off. **Local model auto routing** lets Copilot Fusion use local models.



### Picking the model myself or letting Copilot Fusion choose

GitHub calls Copilot Fusion "an intelligent runtime model router and orchestrator". Microsoft's announcement for local models calls the same routing **Auto**, so you may see both names. In plain words, it decides which model handles each request. When you select **Copilot Fusion** with the **Fusion Standard** level, the app sends simple tasks to MAI Code 1.1 Flash and harder tasks to cloud models. Only MAI Code 1.1 Flash works with Fusion. Flint NVFP4 you have to pick yourself.

I use both ways:

* **I pick the local model myself** when the work must stay on my laptop, or when I am offline. GitHub says a local model lets you "use Copilot offline and avoid consuming GitHub AI Credits". Microsoft adds a limit: local inference "does not make the session offline". Sign-in, remote tools, and remote MCP servers still need the network. The model runs on my laptop, but the session around it does not always.
* **I use Fusion Standard** for normal work when I am online and fine with harder tasks going to the cloud.

Fusion is not an offline mode. It sends some tasks to cloud models on purpose. When data must stay on the laptop, I select the local model myself.

### A custom agent for the local model

There is no setting that tells Fusion to prefer local models. GitHub offers another way, which it describes "as an alternative to Copilot Fusion": a custom agent that is tied to one model. This is useful when only one part of a task should run on the local model, for example writing tests for code that handles customer data, while the rest of the session uses Fusion or a cloud model.

A custom agent is a Markdown file that ends in `.agent.md`. GitHub documents custom agents for the GitHub Copilot CLI, and the Fusion page points to that guide. A file in `$env:USERPROFILE\.copilot\agents` works in every repository. A file in `.github\agents` in a repository works only there. This creates a personal agent in PowerShell 7:

```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.copilot\agents"

@"
---
name: local-coder
description: Coding agent that runs on the local model on this laptop. Use it when code or data must not leave the device.
model: <exact model ID from the model picker>
---
You write and change code in this repository. Keep changes small and explain each change in one or two sentences.
"@ | Set-Content -Path "$env:USERPROFILE\.copilot\agents\local-coder.agent.md" -Encoding utf8NoBOM
```

The `model` line does the work. GitHub describes it as the "model to use when this custom agent executes". Without it, the agent uses the default model. As with Foundry Local, I copy the exact model ID from the model picker and never type it from memory. I use `utf8NoBOM` because the file has to start exactly with `---`.

After a restart of the GitHub Copilot CLI, there are two ways to use the agent:

* **For the whole session:** enter `/agent` and select **local-coder**. Then the whole session runs on the local model.
* **For one part of a task:** write it in the prompt, for example "Use the local-coder agent to write the tests for src/billing". The main session then hands this part to the agent.

The second way has a catch. The main session still reads your prompt and decides what to hand over. If the main session runs on a cloud model, your prompt and the context it passes on go to the cloud first. So when data must stay on the laptop, I select the agent for the whole session or pick the local model myself.

{: .warning }
GitHub warns against using a downloaded local model in more than one Copilot tool (GitHub Copilot CLI, the GitHub Copilot app, and GitHub Copilot in VS Code) at the same time. Each tool loads its own copy into memory, and the laptop can run out of memory. I use the local model only in the app, and cloud models in VS Code Insiders.

### When I use local and when I use cloud

| Task | Local model | Cloud model |
|---|---|---|
| Looking around a repository, explaining code | Yes | |
| Routine code, unit tests, documentation | Yes | |
| Refactoring one small part of the code | Yes | |
| Work on data that must stay on the laptop | Yes | |
| Architecture across several repositories | | Yes |
| Hard bugs and large migrations | | Yes |
| Security design reviews | | Yes |
| Tasks that need a lot of context | | Yes |

Local is better for privacy, cost, and speed of response. Cloud is better when a correct answer matters more than those three.

### How fast the local models are on my laptop

I wanted real numbers, not marketing numbers. llama.cpp comes with its own speed test, `llama-bench.exe`, in the same folder as `llama-server.exe`. It runs each test several times and reports the average in tokens per second.

The GitHub Copilot app keeps its downloaded models in `$env:USERPROFILE\.copilot\azureml-models`. This finds the model files:

```powershell
Get-ChildItem "$env:USERPROFILE\.copilot\azureml-models" -Recurse -Filter *.gguf |
  Select-Object FullName, @{n='GB';e={[math]::Round($_.Length/1GB,1)}}
```

Before the test, close the GitHub Copilot app so the model is not loaded twice, plug in the charger, and set the power mode to **Best performance**. Then run the test for each model:

```powershell
$dir = Split-Path $env:LLAMACPP_SERVER_PATH
& "$dir\llama-bench.exe" -m "<full path to the .gguf file>" -d 0,16384 -r 3
```

`-d 0,16384` runs every test twice: once with an empty context, and once with 16,384 tokens already in the context. Coding agents always send a lot of context, so the second number is closer to daily work. `-r 3` repeats each test three times.

The results on my laptop, with llama.cpp build 12387:

| Model | File size | Reading the prompt | Writing the answer | Reading, 16K context | Writing, 16K context |
|---|---|---|---|---|---|
| Flint NVFP4 (39.8B parameters, NVFP4) | 21.3 GB | 2,750 tokens/s | 107 tokens/s | 2,424 tokens/s | 88 tokens/s |
| MAI Code 1.1 Flash (137.9B parameters, about 3.3 bits on average) | 52.4 GB | 1,386 tokens/s | 77 tokens/s | 1,236 tokens/s | 66 tokens/s |

The `backend` column showed **CUDA** for every test, so the GPU did all the work.

How I read these numbers:

* **Writing the answer** is the speed you notice. Both models write far faster than I can read. 66 tokens per second for a model with almost 138 billion parameters is more than I expected from a laptop.
* **Reading the prompt** decides how long you wait before the answer starts. At over 1,200 tokens per second, MAI Code 1.1 Flash reads a 16,000 token context in about 13 seconds.
* **Long context slows things down, but not much.** With 16,000 tokens in the context, writing got about 15% slower for MAI Code 1.1 Flash and about 18% slower for Flint NVFP4.
* **MAI Code 1.1 Flash is heavily compressed.** Microsoft shrank it from about 276 GB at 16-bit to 53 GB with mixed precision, about 3.3 bits per weight on average. Most of the model uses about 2 bits per weight, some parts about 4. llama-bench labels the file "Q2_K", which undersells it. Microsoft reports only a small quality loss: 70.8% on SWE-Bench Verified for the local version against 72.6% for the cloud version. On Terminal-Bench 2.1 the local version even scored higher, 66.29% against 62.9%. I still keep the hard problems for the bigger cloud models.
* **Microsoft's own numbers go further.** Microsoft measured reading speeds of 923.5 tokens per second at 64K context and 769.8 at 128K on this laptop, with a peak memory use of 75.5 GB at the full 256K context. My 1,236 tokens per second at 16K fits that curve. Microsoft's test also used speculative decoding, where a small helper model suggests tokens and the main model checks them. `llama-bench` does not do this, so the app may write answers faster than my test shows.

`llama-bench` does not count the time for splitting text into tokens and for sampling, so real answers in the app are a little slower. These are my numbers on my laptop. Other drivers, llama.cpp builds, or power settings will give different results.



## Step 7: Foundry Local as my second model runner

The local models in the GitHub Copilot app are only for the GitHub Copilot app. For my own apps and tests I wanted a separate model runner with a standard API. I picked Foundry Local. It comes from Microsoft and offers an OpenAI-compatible API. Microsoft Learn also has a training module for this laptop, "Understand local AI and high-performance workflows with Microsoft Surface Laptop Ultra for Business", with a unit on Foundry Local. I used Foundry Local in my on-premises agent article too, so I already knew how it works. Here it plays a smaller role. On the laptop it only serves my own tests and prototypes. It is not a stand-in for a shared Foundry Local server in the data center.

To install and check it:

```powershell
winget install Microsoft.FoundryLocal
foundry model list --verbose
foundry server status
```

`foundry model list` shows the models you can use, and `--verbose` adds the model ID. `foundry server status` shows whether the service is running and at which local address. Some older Microsoft pages still say `foundry service status`. The current command reference uses `foundry server status`.

Foundry Local picks a new port every time it starts. To keep the address the same, I set the port myself:

```powershell
foundry server start --port <port>
```

My own apps always talk to the model through this local API. That way the app does not depend on one tool. Later I can switch to another runner, such as Ollama, or to a cloud model without rewriting the app.

### Optional: connecting Foundry Local to the GitHub Copilot app

You do not have to connect Foundry Local to the GitHub Copilot app, and for daily coding I do not use it there. The GitHub Copilot app already has its own local models through the Windows ML provider, and those are the stronger choice on this laptop. The Foundry Local catalog has small and mid-size models, while the larger 30B to 35B MoE models run through llama.cpp. Both runners also share the same GPU memory, so running both at the same time only gets in the way.

There are two cases where the connection is useful:

* **As a fallback.** If the built-in local models do not run, for example because Smart App Control is on or because of a driver or llama.cpp problem, Foundry Local still gives the GitHub Copilot app a local model.
* **To try the model your app uses.** If one of your apps runs on a Foundry Local model, you can see in the GitHub Copilot app how that same model handles your code before you build on it.

If you want the connection:

1. Go to **Settings > Model providers > Add provider**.
2. Select **Foundry Local**. GitHub lists it as a supported provider. If you do not see it, select **OpenAI-compatible** instead.
3. Enter the address from `foundry server status`.
4. Add the exact model ID from `foundry model list --verbose`.
5. Start a new session and select the model.

I never type a model ID from memory. IDs change between versions, so I copy them from the tool. GitHub keeps provider credentials "in the system credential store", and the app never shows them.

## Step 8 (optional): Ollama, only after a GPU check

{: .note }
This step is optional, and I have not installed Ollama on my laptop. The GitHub Copilot app models and Foundry Local cover everything I need. I describe the step for readers who want Ollama anyway, based on the documentation and on what others report.

Most people install Ollama first. I decided to leave it out for now. The reason is that the information about it is mixed.

Some sources say it works well. Ollama's Windows documentation lists NVIDIA GPU support, and its API runs at `http://localhost:11434`. NVIDIA's guide for porting apps to RTX Spark lists Ollama for Windows on Arm. Two hands-on reports saw it use the GPU on this laptop. StorageReview ran all its NVIDIA tests "on CUDA through native Arm64 builds of llama.cpp and Ollama". maruhana saw Ollama use the GPU right after install, and a 35B mixture-of-experts model ran at about 100 tokens per second.

But Ollama's own development documentation says "Windows ARM does not support additional acceleration libraries at this time". That sentence is in the part about building Ollama yourself, so it may not apply to the normal installer. Still, it is the official text. I do not want to download large models only to find out later that Ollama was quietly using the CPU instead of the GPU.

If you install it, check it first, and only then download large models:

```powershell
ollama run <small-model> "Say hello"
ollama ps
Invoke-RestMethod http://localhost:11434/api/tags
```

`ollama ps` shows whether the loaded model runs on the GPU or the CPU. Also watch the GPU graph in Task Manager while the model answers. If it runs on the CPU, uninstall it and wait for a better version.

To connect Ollama to the GitHub Copilot app:

* Provider: **Ollama**
* Base URL: `http://localhost:11434`
* Model: the exact name from `ollama list`

One more limit. A test on DGX Spark (a related NVIDIA machine, not this laptop) found that Ollama was no faster with eight requests at once than with one. It handles requests one after another. For one developer that is fine. For a local service that several agents use at the same time, it is a problem.

## Which model sizes fit in 128 GB

All parts share the same memory, so I choose model size by what is left after Windows, my tools, and the model's working memory. My guide:

| Model size | What I use it for | How it runs |
|---|---|---|
| 7B to 14B, 4-bit or FP8/NVFP4 | Code completion, tests, docs, short agent tasks | Easily |
| 20B to 35B, 4-bit | My daily local coding agent | Best mix of quality and speed |
| 60B to 70B, 4-bit | Harder problems, more context | Works, but slower and uses a lot of memory |
| 100B to 120B, heavily compressed | Tests | Possible, but not for all-day use |
| Large models at full precision | Training, research | Not a good fit for this laptop |

The type of model matters as much as its size. A mixture-of-experts (MoE) model only uses part of itself for each word it writes. So it runs much faster than a normal (dense) model of the same size. The published tests show this clearly:

| Source | Model | Result |
|---|---|---|
| The New Stack, 64 GB laptop | Dense Qwen 3.8 27B, 8-bit | 8 to 9 tokens per second |
| The New Stack, 64 GB laptop | Same model, 4-bit | 25 to 28 tokens per second |
| The New Stack, 64 GB laptop | Gemma 4 26B-A4B (MoE), 8-bit | About 40 tokens per second |
| The Neuron, 128 GB laptop | Nemotron Super VL 120B-A12B, 3-bit | Median 33 tokens per second, about 66 GB GPU memory |
| StorageReview | Qwen3.6-35B-A3B and gpt-oss:20b | 58 to 89 tokens per second |

Reviewers used different tools and settings, so these numbers show a range, not a promise. What I use today:

* **Fast:** MAI Code 1.1 Flash in the GitHub Copilot app, or a small coding model
* **Good quality, still local:** a 30B to 35B MoE coding model at 4-bit
* **Large test:** a 70B model at 4-bit, or a 120B MoE model, with the charger plugged in
* **Hard problems:** a cloud model in the GitHub Copilot app

I always keep about 24 GB to 32 GB free for Windows, the GitHub Copilot app, the code editor, terminals, and the model runner itself.

## Docker on Arm is still early

Docker's documentation marks the Arm version of Docker Desktop for Windows as Early Access. It uses WSL 2 underneath. I installed the Arm version, not the x86-64 one, and set it up like this:

1. **Settings > General > Use the WSL 2 based engine**
2. **Settings > Resources > WSL Integration**, turned on for Ubuntu 24.04
3. Kubernetes turned off, because I do not need it here
4. Docker data on a drive path with enough free space

```powershell
docker version
docker info
docker run --rm hello-world
```

Arm images work best. An `amd64` image has to run under emulation. It can be slow, or it can fail if it needs low-level parts of the system.

Docker documents GPU support for "a Windows machine with an NVIDIA GPU" with WSL 2. The page says nothing about Arm64. I found no official statement that GPU containers work on Windows on Arm, so I treat this as untested. Only after normal containers worked did I check the GPU from WSL:

```powershell
wsl --update
wsl nvidia-smi
```

If you try a CUDA container, use an image with an `arm64` tag. Many older CUDA examples use images that only exist for amd64.

## Python and PyTorch run in WSL

NVIDIA's CUDA on WSL guide says the Windows driver "is the only driver you need to install". It also says: "Do not install any Linux display driver in WSL." I followed this exactly. The only NVIDIA driver is the one in Windows.

Inside WSL I use a separate virtual environment for each project:

```bash
mkdir -p ~/src/ai-lab && cd ~/src/ai-lab
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip setuptools wheel
```

Before I install PyTorch, CUDA tools, TensorRT-LLM, vLLM, or llama.cpp, I check four things. Is there a Linux Arm64 version? Does it support this GPU? Does it match the CUDA version of my driver? Do its other parts work on Arm64? I never copy a normal x64 CUDA install script onto this laptop.

Why WSL for Python, and not Windows itself? Because PyTorch with CUDA on Windows on Arm is still unclear. NVIDIA's developer forum post for RTX Spark mentions a CUDA 13.4 PyTorch build from NVIDIA's package index. A few days later, maruhana found no Windows on Arm CUDA version on the official PyTorch download pages. He had to build PyTorch himself, which took about an hour. Inside WSL, the normal Linux PyTorch used the GPU right away. That made the choice easy for me. I use Python on Windows for scripts and small tools. All model work happens in WSL.

## Instructions for coding agents in each repository

Local models are smaller than cloud models, so clear instructions help them even more. In each repository I add:

```text
.github/
  copilot-instructions.md
docs/
  architecture.md
  development.md
  testing.md
  security.md
```

GitHub reads instructions for the whole repository from `.github/copilot-instructions.md`. It also supports `AGENTS.md` files, and "the nearest AGENTS.md file in the directory tree will take precedence". My instructions file covers:

* How the project is built, and which language and SDK versions it uses
* The commands to build, test, format, and lint
* Which folders the agent may change
* Security rules and commands the agent must not run
* When a task counts as done
* Whether database schemas or APIs may change
* Generated files the agent must not edit

For Windows app work, Microsoft recommends the WinUI agent plugin together with the Microsoft Learn MCP Server at `https://learn.microsoft.com/api/mcp`. This way the agent uses the current Windows App SDK and not outdated patterns. I installed the plugin in PowerShell with:

```powershell
gh copilot plugin install winui@awesome-copilot
gh copilot plugin list
```

Microsoft's page for the plugin says it "does not currently integrate with VS Code Copilot Chat". It works with the GitHub Copilot CLI.

## Rules I give the agents at the start

With a laptop this strong, it is tempting to let agents do whatever they want. I start strict and loosen the rules later.

**Modes.** Plan mode for changes across several files. Interactive mode for normal work. A new worktree for each separate task.

**The agent must ask first** before it installs packages, uses the network, deletes files, changes a database, publishes a package, runs `git push`, or opens or merges a pull request.

**The agent gets no access** to SSH keys, Azure credentials, production `.env` files, password managers, or company document folders.

**Windows enforces the limits, not only my instructions.** Rules in a prompt are only requests. Microsoft points out that an agent's shell commands "inherit the access of the account running them", and a local model does not change that. So I turn on the sandbox in the GitHub Copilot app. It uses Microsoft Execution Containers (MXC), an open-source library from the Windows team that controls what the agent's processes can reach: files, network, credentials, and system features.

1. Open the settings with the gear icon and select the project on the left.
2. Turn on **Sandbox new sessions**.

From then on, every new session in that project can read and write its own working folder, while the rest of the system is mostly read-only or out of reach. In the GitHub Copilot CLI, the `/sandbox` command opens the same settings.

The sandbox has limits. Shell commands, local MCP servers, and language servers run inside it. The app's own file tools are only checked by Copilot itself, not by Windows, and remote MCP servers are outside the sandbox. So I keep both: the sandbox and the rules above.

<!-- SCREENSHOT: Project settings with Sandbox new sessions turned on -->

My first prompt in a new repository never changes anything:

> Analyze this repository without modifying files. Identify the build system, runtime dependencies, test commands, architectural boundaries, and security-sensitive areas. Propose a `copilot-instructions.md` and wait for my approval before writing it.

## How others set up the same laptop

Before writing this, I read what others published about running local AI on the Surface Laptop Ultra. Most of it is reviews with benchmarks. Only one is a real setup diary. None of them tested the GitHub Copilot app's local models or Foundry Local in any detail, so nobody else has tried that part of my setup yet.

| Source | What they did | What I learned |
|---|---|---|
| The New Stack | Unsloth Studio, Ollama, Hermes Agent on Windows, 64 GB | Battery costs 20% to 25% speed, fans are loud, MoE models are fast |
| The Neuron | Unsloth Desktop on Windows, 128 GB, models up to 120B MoE | A 120B MoE model is usable, battery costs about 14% speed |
| StorageReview | Arm64 llama.cpp and Ollama on CUDA, Codex CLI as agent | Ollama uses the GPU, the agent slows down the rest of the laptop |
| Tom's Hardware | llama.cpp built from source, timed full agent tasks | Agent tasks finished faster than on an M5 Max MacBook Pro |
| PCMag | MLPerf Client on 64 GB | Some benchmark tools do not support Arm yet |
| maruhana (Zenn) | Fresh setup, more memory for the GPU, PyTorch in WSL 2 | Check GPU use for every tool before you rely on it |

Three things stood out.

**Most people start with community tools.** Ollama, llama.cpp, Unsloth, and LM Studio come up again and again. That is the opposite of my order. I think both ways work. My way gives up some choice in return for a path that Microsoft and GitHub document for this hardware.

**Everyone who was careful checked the GPU.** Each of them tested whether a tool really used the GPU. maruhana's advice is the same as mine: look for a Windows on Arm GPU version before you install, and run a check command after you install.

**The reviews do not always agree.** The Neuron found the fans very quiet, but The New Stack found them annoying. Tom's Hardware found the laptop faster than an M5 Max MacBook Pro on agent tasks. PCMag measured about half the speed of a 16-inch M5 Max in a different test. Different tests, chargers, and memory sizes explain most of this. I would not buy based on one review.

StorageReview found one more thing worth repeating. While an agent used a local model, a browser benchmark score dropped by almost half. The agent shares the GPU and the memory with everything else on the laptop. So a local agent always slows down the rest of your work a bit. Run heavy jobs when you do not need a fast desktop.

## My final checks

When the setup was done, I ran these checks in a normal PowerShell window. `winver` opens a small window with the Windows version. Close it to go on.

```powershell
winver
wsl --version
wsl --list --verbose

git --version
gh --version
code-insiders --version
python --version
node --version
dotnet --info

nvidia-smi
& $env:LLAMACPP_SERVER_PATH --list-devices
foundry server status

docker version
docker run --rm hello-world
```

Then I tested the local AI path from start to finish:

1. Open the GitHub Copilot app and check that the Windows ML model is listed.
2. Create a small test repository.
3. Start a session with **This computer**, **New worktree**, and **Plan** mode.
4. Select the local model yourself.
5. Ask it to look at the repository and write one unit test.
6. Turn off the network and try a simple prompt again.
7. Watch the GPU and shared memory graphs in Task Manager.
8. Turn the network back on and test Copilot Fusion with Fusion Standard on its own.



Now that everything is set up, this is my advice. Start with the GitHub Copilot app and its local Windows ML models. Do Linux and Python work in WSL 2. Add Foundry Local for your own apps. Ollama and other community tools are optional. I have not installed them. If you add them, first check that they use the GPU. With 128 GB, a 30B to 35B MoE model at 4-bit gives the best mix of quality and speed for daily work. Use 70B and larger models only for tests with the charger plugged in. Keep cloud models for the problems where a correct answer matters most.

## Sources

- Microsoft Learn, [Tech specs: Surface Laptop Ultra](https://learn.microsoft.com/en-us/surface/tech-specs/surface-laptop-ultra-1stedition), last updated October 17, 2026: RTX Spark N1X chip, GPU and CPU core counts, memory and storage options, Secured-core PC, TPM 2.0, BitLocker, firmware through Windows Update, adapter only in some markets
- Microsoft, [Surface Laptop Ultra product page](https://www.microsoft.com/en-us/surface/devices/surface-laptop-ultra), accessed November 14, 2026: CUDA for local agent workflows with models up to 120B parameters
- Windows Experience Blog, [Introducing Surface Laptop Ultra: Made for world makers](https://blogs.windows.com/devices/2026/05/31/introducing-surface-laptop-ultra-made-for-world-makers/), May 31, 2026: device announcement, local models up to 120B parameters
- Windows Experience Blog, [Pre-order our most powerful Surface devices ever](https://blogs.windows.com/devices/2026/10/07/pre-order-our-most-powerful-surface-devices-ever/), October 7, 2026: pre-orders for Surface Laptop Ultra and Surface RTX Spark Dev Box
- Microsoft Support, [Surface Laptop Ultra features](https://support.microsoft.com/en-us/surface/models/surface-laptop-ultra-features), accessed November 14, 2026: at least 115 W and a 5 A USB-C cable
- Microsoft Support, [Surface charging requirements and power supplies for Surface Laptop](https://support.microsoft.com/en-us/surface/battery/surface-charging-requirements-and-power-supplies-surface-laptop), accessed November 14, 2026: 140 W adapter at 28 volts and 5 amps
- Microsoft Support, [Download drivers and firmware for Surface](https://support.microsoft.com/en-us/surface/drivers-firmware/download-drivers-and-firmware-for-surface), accessed November 14, 2026: Windows Update, optional driver updates, Surface app update status
- Microsoft Support, [Surface Laptop Ultra update history](https://support.microsoft.com/en-us/surface/updates/surface-laptop-ultra-update-history), accessed November 14, 2026: driver and firmware releases for this laptop through Windows Update
- NVIDIA, [RTX Spark Game Ready Driver 617.42](https://www.nvidia.com/en-us/geforce/news/rtx-spark-october-16-2026-game-ready-driver/), October 16, 2026: first RTX Spark driver, install from the NVIDIA app or the NVIDIA website
- NVIDIA, [Official Drivers](https://www.nvidia.com/Download/index.aspx), accessed November 14, 2026: Game Ready and Studio drivers, all drivers support games and creative apps
- Microsoft Learn, [install command (winget)](https://learn.microsoft.com/en-us/windows/package-manager/winget/install), last updated July 19, 2026: `--architecture` and `--scope` options
- Microsoft Support, [Smart App Control Frequently Asked Questions](https://support.microsoft.com/en-us/windows/security/threat-malware-protection/smart-app-control-frequently-asked-questions), accessed November 14, 2026: how Smart App Control decides, no exceptions for single apps, turning it off and back on
- Microsoft Learn, [How emulation works on Arm](https://learn.microsoft.com/en-us/windows/arm/apps-on-arm-x86-emulation), November 6, 2025: Prism, emulation only for user mode code, no drivers
- Microsoft Learn, [Windows on Arm FAQ](https://learn.microsoft.com/en-us/windows/arm/faq), accessed November 14, 2026: kernel-mode drivers must be native Arm64
- GitHub Docs, [GitHub Copilot app](https://docs.github.com/en/copilot/concepts/copilot-surfaces/github-copilot-app), accessed November 14, 2026: parallel sessions with worktrees, WSL 2 sessions, Business and Enterprise policy
- GitHub Docs, [Working with agent sessions in the GitHub Copilot app](https://docs.github.com/en/copilot/how-tos/github-copilot-app/agent-sessions), accessed November 14, 2026: Environment, Workspace, and the Interactive, Plan, and Autopilot modes
- GitHub Docs, [Adding LLM models to the GitHub Copilot app](https://docs.github.com/en/copilot/how-tos/github-copilot-app/add-llm-models), accessed November 14, 2026: supported providers, credential store, MAI Code 1.1 Flash and Flint NVFP4 requirements, llama.cpp Arm64 CUDA install, Windows ML provider steps, Experimental settings, Fusion Standard, warning about several Copilot tools
- GitHub Docs, [About GitHub Copilot Fusion](https://docs.github.com/en/copilot/concepts/models/copilot-fusion), accessed November 14, 2026: Fusion as a model router and orchestrator, local models only in Fusion Standard, custom agents as the alternative
- GitHub Docs, [Creating and using custom agents for GitHub Copilot CLI](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/create-custom-agents-for-cli), accessed November 14, 2026: `.agent.md` files, user and project folders, `/agent`, handing work to a custom agent
- llama.cpp on GitHub, [llama-bench README](https://github.com/ggml-org/llama.cpp/blob/master/tools/llama-bench/README.md), accessed November 14, 2026: prompt processing and text generation tests, `-d` for context depth, results in tokens per second, tokenization and sampling not included
- Microsoft Command Line, [Bringing local models and sandboxed tools to Windows and GitHub Copilot](https://commandline.microsoft.com/local-models-sandboxed-tools-github-windows/), October 7, 2026: Auto routing, local inference does not make the session offline, memory use that grows with context, MAI Code 1.1 Flash on-device benchmarks and speeds, speculative decoding, sandboxing with Microsoft Execution Containers, Sandbox new sessions, `/sandbox`
- Microsoft Foundry on Windows Blog, [Advancing the Quality-Efficiency Frontier for Coding AI on Windows PCs](https://devblogs.microsoft.com/foundry-on-windows/coding-ai-on-windows-pcs-quality-efficiency/), November 4, 2026: MAI Code 1.1 Flash compressed from 276 GB to 53 GB (3.31 bits per weight), mixed precision, 51 tokens per second at 120K context on RTX Spark
- Microsoft AI, [MAI Code 1.1 Flash](https://microsoft.ai/models/mai-code-1-flash/), accessed November 14, 2026: on-device and cloud benchmark results
- GitHub Docs, [Custom agents configuration](https://docs.github.com/en/copilot/reference/custom-agents-configuration), accessed November 14, 2026: the `model` property
- GitHub Docs, [Adding repository custom instructions for GitHub Copilot](https://docs.github.com/copilot/how-tos/copilot-on-github/customize-copilot/add-custom-instructions/add-repository-instructions), accessed November 14, 2026: `.github/copilot-instructions.md` and which `AGENTS.md` wins
- Microsoft Learn, [Understand local AI and high-performance workflows with Microsoft Surface Laptop Ultra for Business](https://learn.microsoft.com/en-us/training/modules/surface-laptop-ultra-business/), accessed November 14, 2026: training module with a unit on Foundry Local on this laptop
- Microsoft Learn, [Get started with Foundry Local](https://learn.microsoft.com/en-us/windows/ai/foundry-local/get-started), accessed November 14, 2026: install with winget
- Microsoft Learn, [Foundry Local CLI reference](https://learn.microsoft.com/en-us/azure/foundry-local/reference/reference-cli), accessed November 14, 2026: `foundry model list`, `foundry server status`, changing port, OpenAI-compatible server
- Microsoft Learn, [Windows ML execution providers](https://learn.microsoft.com/en-us/windows/ai/new-windows-ml/supported-execution-providers), accessed November 14, 2026: NVIDIA TensorRT for RTX support in Windows ML
- Microsoft Learn, [Advanced settings configuration in WSL](https://learn.microsoft.com/en-us/windows/wsl/wsl-config), last updated October 16, 2026: `.wslconfig` sections, `autoMemoryReclaim` and `sparseVhd` under `[experimental]`, `wsl.conf` systemd and interop settings, WSL Settings app
- Microsoft Learn, [Working across file systems](https://learn.microsoft.com/en-us/windows/wsl/filesystems), accessed November 14, 2026: keep files in the WSL file system for Linux work
- Microsoft Learn, [Set up your Python development environment on Windows](https://learn.microsoft.com/en-us/windows/dev-environment/python), accessed November 14, 2026: winget ID for VS Code, Python example still on 3.14
- Python Software Foundation, [Python Releases for Windows](https://www.python.org/downloads/windows/), accessed November 14, 2026: Python 3.15.2 as the latest Python 3 release, ARM64 installers
- Visual Studio Code, [Download Visual Studio Code Insiders](https://code.visualstudio.com/insiders/), accessed November 14, 2026: daily builds, early access to AI agent features, side-by-side install, Windows Arm64 builds
- Microsoft Learn, [Deploy the Microsoft 365 Copilot app](https://learn.microsoft.com/en-us/copilot/implement/deploy-microsoft-365-copilot-app), last updated November 3, 2026: app now named Microsoft Copilot, installer and Store options
- Microsoft Learn, [Get started with Copilot Cowork](https://learn.microsoft.com/en-us/microsoft-365/copilot/cowork/get-started), accessed November 14, 2026: Cowork in the Microsoft Copilot desktop app for Windows
- Windows Experience Blog, [Building Windows for hybrid intelligence](https://blogs.windows.com/windowsexperience/2026/10/07/building-windows-for-hybrid-intelligence/), October 7, 2026: planned local context, local actions, and local models for Copilot, invitation to Ignite
- Microsoft, [Microsoft Events](https://www.microsoft.com/en-us/events), accessed November 14, 2026: Microsoft Ignite 2026, November 17 to 20, 2026, San Francisco
- Microsoft Learn, [Install PowerShell on Windows](https://learn.microsoft.com/en-us/powershell/scripting/install/install-powershell-on-windows?view=powershell-7.6), accessed November 14, 2026: PowerShell winget ID
- Microsoft Learn, [WinUI agent plugin for GitHub Copilot CLI and Claude Code](https://learn.microsoft.com/en-us/windows/apps/develop/ai-assisted/winui-agent-plugin), July 7, 2026: plugin install command and VS Code limit
- Microsoft Learn, [Set up GitHub Copilot for Windows development](https://learn.microsoft.com/en-us/windows/apps/how-tos/ai-setup), accessed November 14, 2026: WinUI plugin with the Microsoft Learn MCP Server
- Docker Docs, [Install Docker Desktop on Windows](https://docs.docker.com/desktop/setup/install/windows-install/), accessed November 14, 2026: Arm version in Early Access, WSL 2 backend
- Docker Docs, [GPU support in Docker Desktop for Windows](https://docs.docker.com/desktop/features/gpu/), accessed November 14, 2026: NVIDIA GPU support with WSL 2, nothing about Arm64
- Docker Docs, [Docker Desktop WSL 2 backend](https://docs.docker.com/desktop/features/wsl/), accessed November 14, 2026: `autoMemoryReclaim` recommendation
- NVIDIA, [CUDA on WSL User Guide](https://docs.nvidia.com/cuda/wsl-user-guide/index.html), accessed November 14, 2026: Windows driver only, no Linux display driver in WSL
- NVIDIA Developer, [Port Windows Apps to Arm: RTX Spark Guide](https://developer.nvidia.com/topics/ai/local-ai/port-apps), accessed November 14, 2026: CUDA Toolkit 13.4 for Windows on Arm, Ollama for Windows on Arm
- NVIDIA Developer Forums, [RTX Spark: Getting Started with Development](https://forums.developer.nvidia.com/t/rtx-spark-getting-started-with-development/385976), October 15, 2026: CUDA 13.4.2 and a CUDA PyTorch build from NVIDIA's package index
- Ollama, [Windows documentation](https://github.com/ollama/ollama/blob/main/docs/windows.mdx), accessed November 14, 2026: NVIDIA support, API on port 11434, `OLLAMA_MODELS`
- Ollama, [Development documentation](https://raw.githubusercontent.com/ollama/ollama/main/docs/development.md), accessed November 14, 2026: Windows ARM and extra acceleration libraries
- **Not first-party.** The New Stack, Frederic Lardinois, [Running local AI models on Microsoft's Surface Laptop Ultra: What we found](https://thenewstack.io/surface-ultra-local-ai/), October 16, 2026: tokens per second, battery loss, fan noise
- **Not first-party.** The Neuron, Corey Noles, [I Tested Microsoft's Surface Laptop Ultra. The Local AI Performance Is Remarkable.](https://www.theneuron.ai/guides/microsoft-surface-laptop-ultra-review-the-local-ai-performance-is-remarkable/), October 23, 2026: 120B MoE results on a 128 GB laptop, battery loss
- **Not first-party.** StorageReview, Kevin O'Brien, [Microsoft Surface Laptop Ultra for Business Review](https://www.storagereview.com/review/microsoft-surface-laptop-ultra-for-business-review-rtx-spark-n1x), October 15, 2026: Arm64 Ollama and llama.cpp on CUDA, memory split, effect of an agent on the desktop
- **Not first-party.** Tom's Hardware, Jeffrey Kampman, [We test the RTX Spark Superchip in Microsoft's Surface Laptop Ultra](https://www.tomshardware.com/laptops/we-test-the-rtx-spark-superchip-in-microsofts-surface-laptop-ultra-nvidias-windows-on-arm-platform-impresses-in-local-ai-but-gaming-isnt-its-strong-suit), October 15, 2026: agent task times compared with an M5 Max MacBook Pro
- **Not first-party.** PCMag via Yahoo Tech, Brian Westover, [Microsoft Surface Laptop Ultra Review](https://tech.yahoo.com/computing/articles/microsoft-surface-laptop-ultra-review-150148958.html), November 4, 2026: MLPerf Client results, benchmark tools without Arm support
- **Not first-party.** maruhana on Zenn (Japanese), [Surface Laptop Ultra initial setup](https://zenn.dev/maruhana/articles/surface-laptop-ultra-day1-arm-cuda), October 21, 2026: fresh setup, GPU memory share, Ollama on the GPU, PyTorch in WSL 2
- **Not first-party, different hardware.** NVIDIA Developer Forums, [Measured inference benchmarks on a single DGX Spark](https://forums.developer.nvidia.com/t/measured-inference-benchmarks-on-a-single-dgx-spark-same-harness-across-ollama-llama-cpp-and-vllm-notes-data-published/379766), August 10, 2026: Ollama does not handle parallel requests together
- Earlier article on this blog: [Building On-Prem AI Agents with Azure Local, Foundry Local, and Microsoft Agent Framework](https://holgerimbery.blog/building-on-prem-ai-agents-with-azure-local-foundry-local-and-microsoft-agent-framework), April 11, 2026

**Two open questions at the time of writing:** First, Ollama's development documentation says Windows on Arm does not have the extra acceleration libraries. But NVIDIA lists Ollama for Windows on Arm, and two hands-on reports saw it use the GPU. Second, NVIDIA's forum mentions a CUDA PyTorch build for Windows on Arm. But a few days later, an independent developer found no such version on the official PyTorch download pages. Test both on your own laptop before you rely on them.
