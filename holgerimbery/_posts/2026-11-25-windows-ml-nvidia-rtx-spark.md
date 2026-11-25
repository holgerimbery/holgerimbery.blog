---
layout: post
canonical_url: https://holgerimbery.blog/windows-ml-nvidia-rtx-spark
title: "Windows ML and Foundry Local on NVIDIA RTX Spark Laptops"
description: "How Windows ML works on the new NVIDIA RTX Spark laptops, how it compares with Foundry Local, and which other options exist, based on my own tests on a Surface Laptop Ultra with 128 GB."
date: 26-11-25
author: admin
slug: windows-ml-nvidia-rtx-spark
image: https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/2026/11/kevin-ku-w7ZyuGYNpRQ-unsplash.jpg
image_caption: Photo by <a href="https://unsplash.com/@ikukevk?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Kevin Ku</a> on <a href="https://unsplash.com/photos/closeup-photo-of-eyeglasses-w7ZyuGYNpRQ?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a>
tags:
  - foundrylocal
  - localai
  - nvidia
  - onnx
  - rtxspark
  - surface
  - surfacelaptopultra
  - tensorrt
  - windows
  - windowsml
  - windowsonarm
featured: true
toc: true
---

{: .q-left }
> In [Local AI Development with the Surface Laptop Ultra](https://holgerimbery.blog/surface-laptop-ultra-local-ai-developer-setup) I described how I set up my Surface Laptop Ultra with 128 GB for local AI work, and I measured how fast the local coding models run on it. This article looks one level deeper, at the software that runs the models. I explain what Windows ML is, why it suits the new NVIDIA RTX Spark laptops, how it compares with Foundry Local, and which other options exist. I use my own laptop and my own test results as the reference throughout.

## The hardware: NVIDIA RTX Spark

NVIDIA and Microsoft announced RTX Spark on May 31, 2026, at NVIDIA GTC Taipei during Computex. NVIDIA calls it a superchip. It combines an NVIDIA Blackwell RTX GPU with 6,144 CUDA cores and fifth-generation Tensor Cores with FP4 support, and a 20-core NVIDIA Grace CPU. The two are connected through NVLink-C2C. MediaTek worked with NVIDIA on the CPU design.

NVIDIA rates the chip at up to 1 petaflop of FP4 AI performance (with sparsity) and up to 128 GB of unified memory. Microsoft says it can run models with up to 120B parameters locally. RTX Spark PCs also join the Copilot+ PC category, with an NPU next to the GPU.

The CPU is Arm. So these are Windows on Arm laptops, like the Snapdragon-based Surface devices of the last few years, but with a much stronger GPU and far more memory. Microsoft says it tuned Windows for the chip. The changes include better scheduling across all 20 cores, the Microsoft Power and Thermal Framework, a higher limit on how much system memory the GPU can use, better handling of large memory pages, and a Prism emulator tuned for the chip so x64 apps keep running.

NVIDIA lists devices from Microsoft Surface, ASUS, Dell, HP, Lenovo, and MSI, with Acer and GIGABYTE to follow. Microsoft opened pre-orders for Surface Laptop Ultra and the Surface RTX Spark Dev Box on October 7, 2026.

## My reference device: Surface Laptop Ultra with 128 GB

I use one machine for everything in this article: my own Surface Laptop Ultra with the full RTX Spark N1X chip and 128 GB of memory.

| Item | My laptop |
|---|---|
| Processor | NVIDIA RTX Spark N1X, 20 core Grace CPU |
| GPU | NVIDIA Blackwell RTX, 6,144 cores |
| NPU | NVIDIA NPU |
| Memory | 128 GB LPDDR5x unified memory |
| Storage | 1 TB (Windows shows about 931 GB) |
| OS | Windows 11 Pro |
| Device class | Copilot+ PC, Secured-core PC |

Microsoft's store lists the version with the 6,144-core GPU and 20-core CPU from $3,699.99. The 128 GB option sits at the top of the range.

I bought the 128 GB model for one reason. The GitHub Copilot app needs at least 96 GB of free memory (RAM and GPU combined) to run its local model, MAI Code 1.1 Flash. On a 64 GB laptop, that model does not run.

### How the 128 GB is split on my laptop

Unified memory means the CPU and the GPU use the same memory. It does not mean the GPU gets all 128 GB. This is what my laptop shows:

| Where | What it shows |
|---|---|
| Settings > System > About | Installed RAM: 128 GB (64 GB usable) |
| Task Manager > Performance > GPU | Dedicated GPU memory 62.5 GB, Shared GPU memory 48 GB |
| llama.cpp device list | 112,350 MiB of GPU memory (about 110 GB) |

So Windows, WSL, and all my apps share 64 GB, and the GPU has its own 64 GB. The GPU can borrow more from the Windows side. CUDA counts both parts together, which is why llama.cpp sees about 110 GB. A model that does not fit into the dedicated 62.5 GB can still load, but it then takes memory away from Windows and my apps. I keep the models I use every day inside the dedicated share.

Reviewers report that the split can be changed in the NVIDIA app. I keep the 64/64 split for daily work.

### How to read a model name

Model names look cryptic, but most of them are built from the same few parts. Take Qwen3.6-35B-A3B, one of the models reviewers tested on this laptop. Qwen3.6 is the family and version. 35B means 35 billion parameters in total. A3B means only about 3 billion of them are active for each token.

| Part | Example from this article | What it means | What it affects |
|---|---|---|---|
| Family and version | Qwen3.6, MAI Code 1.1, Gemma 4 | Who made the model and which release | Quality, license, tool support |
| Total parameters | 35B, 120B, 137.9B | Size of the model in billions of weights | Memory, quality |
| Active parameters | A3B, A12B | Weights used per token in a mixture of experts (MoE) model | Speed of writing the answer |
| Precision | 16 bit, FP8, NVFP4, 4 bit | How many bits each weight uses | Memory, speed, small quality loss |
| llama.cpp quant label | Q2_K, Q4_K_M | Compression type inside a GGUF file | Same as precision; the label can be misleading |
| Variant | Flash, Coder, Instruct, VL | Tuned for a job: speed, coding, chat, or images | Fit for the task |
| File format | GGUF, ONNX | How the model file is packaged | Which runtime can run it |

What this means in practice:

* **Memory** comes from total parameters times bits per weight. A 120B model at 4-bit needs about 60 GB for its weights alone.
* **Writing speed** depends mostly on how many weights are read for each token. That is why MoE models are fast. The New Stack measured about 40 tokens per second for Gemma 4 26B-A4B (MoE) at 8-bit, and 8 to 9 tokens per second for the dense Qwen 3.8 27B at 8-bit, on a 64 GB laptop.
* **Reading the prompt** depends on GPU compute. Low precision formats such as FP8 and FP4 run faster on the Tensor Cores of the RTX Spark GPU.
* **Fewer bits** save memory and add speed, but cost some quality. MAI Code 1.1 Flash runs at about 3.3 bits per weight on average, and Microsoft reports 70.8 percent on SWE-Bench Verified for it, against 72.6 percent for the cloud version. llama-bench labels the file "Q2_K", which undersells it, because some parts use about 4 bits.
* **Context length** is often missing from the name, but long context needs extra memory. Microsoft measured a peak of 75.5 GB for MAI Code 1.1 Flash at the full 256K context.

My two local coding models show the trade-off between size, precision, and speed. Flint NVFP4 has 39.8B parameters in NVFP4 and writes 107 tokens per second. MAI Code 1.1 Flash has 137.9B parameters at about 3.3 bits and writes 77 tokens per second.

### Which model sizes fit

On top of the model weights come the memory for long context, the app, and Windows. This is the guide I use on my laptop:

| Model size | What I use it for | How it runs |
|---|---|---|
| 7B to 14B, 4 bit or FP8/NVFP4 | Code completion, tests, docs, short agent tasks | Easily |
| 20B to 35B, 4 bit | My daily local coding agent | Best mix of quality and speed |
| 60B to 70B, 4-bit | Harder problems, more context | Works, but slower and uses a lot of memory |
| 100B to 120B, heavily compressed | Tests | Possible, but not for all day use |
| Large models at full precision | Training, research | Not a good fit for this laptop |

Because MoE models are fast for their size, a 30B to 35B MoE model is my daily choice.

## What Windows ML is

Microsoft Learn describes Windows ML as "the unified and high-performance local AI inferencing framework for Windows, powered by ONNX Runtime." In plain words, it is the Windows-supported copy of ONNX Runtime, the open-source engine that runs models in the ONNX format. On top of that, Windows delivers and updates the parts that are specific to each chip.

Windows ML became generally available on September 23, 2025. Microsoft first showed it at Build 2025.

Three ideas carry the design.

**One runtime, shipped by Windows.** An app can use Windows ML as a shared system component. The app stays small, and all apps on the device share the same runtime. An app can also bring its own copy if it needs a fixed version. Windows ML runs on x64 and Arm64 PCs.

**Execution providers.** An execution provider (EP) is a plug-in that knows how to run model operations fast on one type of chip. The chip makers build and maintain the EPs. Windows downloads, registers, and updates them. The app does not have to ship them.

**The same ONNX APIs.** Code that already uses ONNX Runtime keeps the same APIs. What changes is who ships and maintains the runtime and the EPs.

These are the EPs that Microsoft Learn lists for Windows ML 2.x:

| Execution provider | Vendor | Typical chip |
|---|---|---|
| NvTensorRtRtx | NVIDIA | RTX GPU |
| AMD GPU | AMD | Radeon GPU |
| VitisAI | AMD | Ryzen AI NPU |
| OpenVINO | Intel | NPU, GPU, CPU |
| QNN | Qualcomm | Snapdragon NPU and GPU |
| WebGPU (experimental) | Microsoft | Any DirectX 12 GPU |
| CPU and DirectML (legacy) | Microsoft | Included |

The vendor EPs are downloaded on demand on Windows 11 version 24H2 (build 26100) or later.

Since October 7, 2026, Windows ML also runs GGUF models through llama.cpp. GGUF is the file format most open models use in the llama.cpp community. Microsoft added a Text Generation API that takes GGUF and ONNX language models and picks the right engine. It also offers an OpenAI-compatible local endpoint. The GGUF support, the Text Generation API, a Speech Recognition API, and a new Windows ML Runtime API are all labeled experimental.

## TensorRT for RTX in Windows ML

On NVIDIA hardware, the ONNX path in Windows ML uses the TensorRT for RTX execution provider. TensorRT is NVIDIA's inference optimizer. It was built for data center GPUs, and TensorRT for RTX is the version NVIDIA rebuilt for PCs.

**Compiling on the device.** TensorRT for RTX builds the final engine for the exact GPU on the user's PC, in seconds. NVIDIA says these device-specific engines can be up to 20 percent faster than generic ones.

**FP4 and FP8.** It uses FP8 and FP4 on the Tensor Cores. That matters on RTX Spark, because the 1 petaflop figure is an FP4 number, and smaller number formats need less memory.

**Small package.** The library is just under 200 MB. With Windows ML, the app does not ship it.

**Faster than the old path.** NVIDIA measured more than 50 percent higher throughput than the previous DirectML path, on a GeForce RTX 5090.

**Caching.** Precompiled model files and a kernel cache avoid compiling again on every start. NVIDIA also describes about 75 times less copy time when inputs and outputs stay on the GPU.

For RTX Spark, Microsoft wrote at launch that it and NVIDIA "worked to unlock the power of the GPU for local AI workloads through Windows ML, enabling AI developers to leverage TensorRT natively in Windows." NVIDIA's porting page for RTX Spark lists a TensorRT RTX execution provider download next to CUDA Toolkit 13.4 for Windows on Arm.

## Windows ML on my laptop today

The first place I used Windows ML on my laptop was the GitHub Copilot app. It has a model provider called Windows ML. Through it, I downloaded two local coding models, MAI Code 1.1 Flash and Flint NVFP4. GitHub lists these requirements:

| Model | Free memory (RAM and GPU combined) | Free disk space |
|---|---|---|
| MAI Code 1.1 Flash | 96 GB | 60 GB |
| Flint NVFP4 | 48 GB | 23 GB |

The feature is in public preview. It needs an NVIDIA GPU and llama.cpp. The models are GGUF files, and they run on llama.cpp with CUDA. I installed the Windows Arm64 CUDA build of llama.cpp myself and pointed the `LLAMACPP_SERVER_PATH` variable to it.

This shows something about Windows ML on RTX Spark today. For large language models, the path that works in a shipping product runs through GGUF and llama.cpp on CUDA, not through ONNX and TensorRT for RTX.

### Speed of the local models on my laptop

I measured both models with `llama-bench.exe`, the test tool that comes with llama.cpp. I closed the GitHub Copilot app, plugged in the charger, and set the power mode to Best performance. Each test ran three times, once with an empty context and once with 16,384 tokens already in the context. Coding agents always send a lot of context, so the second number is closer to daily work.

The results with llama.cpp build 12387:

| Model | File size | Reading the prompt | Writing the answer | Reading, 16K context | Writing, 16K context |
|---|---|---|---|---|---|
| Flint NVFP4 (39.8B, NVFP4) | 21.3 GB | 2,750 tokens/s | 107 tokens/s | 2,424 tokens/s | 88 tokens/s |
| MAI Code 1.1 Flash (137.9B, about 3.3 bits) | 52.4 GB | 1,386 tokens/s | 77 tokens/s | 1,236 tokens/s | 66 tokens/s |

The backend showed CUDA for every test, so the GPU did all the work.

Both models write faster than I can read. 66 tokens per second for a model with almost 138 billion parameters is more than I expected from a laptop. At over 1,200 tokens per second, MAI Code 1.1 Flash reads a 16,000 token context in about 13 seconds. With 16,000 tokens in the context, writing got about 15 percent slower for MAI Code 1.1 Flash and about 18 percent slower for Flint NVFP4.

MAI Code 1.1 Flash is heavily compressed. Microsoft shrank it from about 276 GB at 16-bit to about 53 GB, about 3.3 bits per weight on average. Microsoft reports 70.8 percent on SWE-Bench Verified for the local version, against 72.6 percent for the cloud version. I still keep hard problems for the larger cloud models.

These are my numbers on my laptop. Other drivers, llama.cpp builds, or power settings give different results. Reviewers measured 14 to 25 percent lower AI speed on battery, so I run long sessions only with the charger plugged in.

### Smart App Control and llama.cpp

My first test failed. Windows showed a "Bad Image" message for a llama.cpp file. The Code Integrity log showed that Smart App Control had blocked it. Smart App Control was on by default on my new laptop. It blocks programs that Microsoft's cloud service doesn't recognize and that have no valid signature. The llama.cpp builds are not signed, and new ones come out several times a day.

Microsoft's FAQ says "there is currently no way to bypass Smart App Control protection for individual apps." It is on or off. I turned it off, because this laptop is my developer workstation. In return, I only take llama.cpp from its official GitHub releases page, and I keep Microsoft Defender on.

This matters for anyone planning to run local AI on managed devices. With Smart App Control on, the local models in the GitHub Copilot app do not run. Foundry Local and cloud models still work.

## Why Windows ML suits RTX Spark laptops

After a few weeks with the laptop, these are the reasons I build on Windows ML.

### 1. RTX Spark is a new platform

RTX Spark pairs an Arm CPU with a full NVIDIA GPU. Most AI code on Windows was written for x64 with an NVIDIA or AMD graphics card, or for Arm with a Qualcomm NPU. I saw what that means on my own laptop. Many CUDA install guides assume x64; emulation does not cover drivers, and every tool that talks to the GPU needs a real Arm64 version. NVIDIA's own porting guide lists the steps: check dependencies for Arm64, pick a porting strategy, build, test, and check "the NVIDIA and CUDA software paths used by your application."

With Windows ML, Microsoft and NVIDIA own the engine and the NVIDIA provider. My app calls the same API on an RTX Spark laptop, a Snapdragon laptop, and an Intel desktop with a GeForce card. The app still has to be built for Arm64, but I do not port an inference engine.

### 2. One app build for a mixed fleet

Few companies will buy only RTX Spark laptops. A typical fleet has Intel and AMD laptops, some Snapdragon Copilot+ PCs, a few workstations with RTX cards, and now some RTX Spark devices for developers and creators. Microsoft's GA announcement says Windows ML supports different hardware "without multiple app builds." It also says that not shipping runtimes and EPs saves "tens to hundreds of megabytes" in app size. An app can set a policy, for example, prefer the GPU for speed or prefer the NPU for battery life, and let the runtime choose.

### 3. Unified memory needs a runtime that keeps data on the GPU

Large shared memory only helps if the runtime doesn't copy data back and forth all the time. The ONNX Runtime device APIs in Windows ML let an app keep inputs and outputs on the GPU. NVIDIA's copy time numbers come from exactly this pattern. The new Windows ML Runtime API (experimental) adds "zero-copy paths" for images, video frames, audio, and text.

### 4. Updates arrive without an app release

TensorRT for RTX and the RTX Spark drivers change often. On my laptop, NVIDIA released the first RTX Spark driver on October 16, 2026, and a newer one less than a month later. Windows ML installs and updates the EPs on the device. NVIDIA said at launch that TensorRT optimizations reach users "as soon as they're ready." For a business app that ships every quarter, that helps. For a fixed version in a validated or offline setup, Microsoft offers a "bring your own EP" option.

### 5. Tools for the full path from model to app

Microsoft's October 7, 2026 update for Windows ML names RTX Spark and Surface Laptop Ultra directly. It adds GGUF support, the task APIs, the Runtime API, and the Windows ML CLI. The CLI analyzes, optimizes, quantizes, compiles, and benchmarks a model for a chosen EP. Microsoft's example targets `nv_tensorrt_rtx`:

```powershell
winml analyze -m .\resnet18.onnx --device gpu --ep nv_tensorrt_rtx
winml build   -m .\resnet18.onnx -o .\app-model --device gpu --ep nv_tensorrt_rtx --no-quant
winml perf    -m .\app-model\model.onnx --device gpu --ep nv_tensorrt_rtx
```

The full path looks like this:

```text
PyTorch with CUDA         ->  train or fine-tune on the RTX Spark GPU
        |
        v
torch.onnx.export         ->  portable ONNX model
        |
        v
winml analyze/build/perf  ->  model prepared for nv_tensorrt_rtx
        |
        v
Windows ML in the app     ->  TensorRT for RTX on RTX Spark
                              QNN on Snapdragon, OpenVINO on Intel
```

## Windows ML and Foundry Local compared

Foundry Local is the other Microsoft option for local AI on this laptop, and I use both. They are related, but they do different jobs.

**What Foundry Local is.** Microsoft describes it as "an end-to-end local AI solution for shipping applications that run entirely on your device." It includes an SDK for C#, C++, JavaScript, Rust, and Python; a curated catalog of models; model download and caching; and automatic hardware selection. The catalog includes chat models such as GPT OSS, Qwen, DeepSeek, Mistral, and Phi, as well as Whisper for speech-to-text. Models are versioned, so an app can pin a version. Foundry Local offers an OpenAI-compatible API and an optional local web server. It runs on Windows, macOS on Apple Silicon, and Linux, and needs no Azure subscription.

**How the two connect.** On Windows, the package `Microsoft.AI.Foundry.Local.WinML` uses Windows ML execution providers for acceleration, and inference runs through ONNX Runtime. Learn says a model can resolve to "a CUDA variant on NVIDIA." So on my laptop, Foundry Local sits on top of the same runtime layer that Windows ML provides. The choice is between a ready model service and direct control over the runtime.

| Aspect | Windows ML | Foundry Local |
|---|---|---|
| What it is | Runtime (ONNX Runtime plus EPs, GGUF through llama.cpp) | Model service: SDK, catalog, runtime |
| Models | Any ONNX model you bring; GGUF (experimental) | Curated catalog, versioned |
| Model types | Any: vision, audio, language, custom | Chat and speech to text |
| Hardware choice | App sets a policy or picks the EP | Automatic, best variant per device |
| Model download | App's job | Built in, cached |
| API | ONNX Runtime API; Text Generation API (experimental) | OpenAI compatible; native SDK |
| Platforms | Windows only (x64, Arm64) | Windows, macOS, Linux |
| Size in the app | Shared Windows part, or self-contained | About 20 MB |
| Control over TensorRT settings | Full | Limited, the SDK decides |
| Smart App Control on | ONNX path works; llama.cpp builds are blocked | Works |

### How I use Foundry Local on this laptop

In my setup, Foundry Local is the second model runner. The GitHub Copilot app uses its own Windows ML models. For my own apps and tests, I wanted a separate runner with a standard API, so I picked Foundry Local. My apps always talk to the model through its OpenAI-compatible API. That way, the app does not depend on one tool, and I can switch to another runner or a cloud model later without rewriting the app.

Two things I learned while setting it up. The current command to check the service is `foundry server status`, while some older Microsoft pages still say `foundry service status`. And Foundry Local picks a new port every time it starts, so I set the port myself with `foundry server start --port <port>`.

I do not use Foundry Local for daily coding in the GitHub Copilot app. The Foundry Local catalog has small and mid-size models, and the larger 30B to 35B MoE models run through llama.cpp. Microsoft says the catalog is "intentionally curated," and that its models are "small enough to distribute to end users." That makes sense for an app that must also run on a 16 GB Copilot+ PC. It also means the catalog does not try to fill a 128 GB laptop. Microsoft says Foundry Local is not meant "for general-purpose model experimentation."

Microsoft also describes Foundry Local as "lightweight, single-user inference," not a server. That fits a laptop. On my laptop, Foundry Local and the Copilot app models share the same GPU memory, so I do not run both at the same time.

Foundry Local is also my fallback. If the Copilot app models do not run, for example because Smart App Control is on or a llama.cpp build has a problem, Foundry Local still gives the GitHub Copilot app a local model through its model provider settings.

### When I use which

I use Foundry Local when the job is a known open chat or speech model inside an app, and when the same app should also run on smaller PCs or on a Mac. I use Windows ML directly when I need a model that isn't in the catalog, a larger model that only the 128 GB laptop can hold, a model that isn't a chat model (image, audio, or a custom classifier), or control over how TensorRT for RTX runs it. Some apps will use both, for example, Foundry Local for a general assistant and Windows ML for a custom vision model.

## Gaps in Windows ML on RTX Spark

These are the gaps I see on my laptop today.

**Many new parts are experimental.** The Text Generation API, the Speech Recognition API, GGUF support, and the Runtime API are labeled experimental. Microsoft asks developers to "review the supported scenarios and known limitations before relying on them in production." The stable part is the ONNX Runtime core with its EPs. The local models in the GitHub Copilot app are in public preview.

**No NVIDIA NPU provider is listed.** The Surface Laptop Ultra tech specs list an NVIDIA NPU, and Microsoft says RTX Spark PCs join the Copilot+ PC category. The table on Microsoft Learn that maps chips to EPs (last updated November 10, 2026) lists NPU providers only for Intel, Qualcomm, and AMD. So Windows ML apps on RTX Spark run on the GPU or the CPU. The GPU is fast, but it is not the low-power path that an NPU gives on other Copilot+ PCs.

**The NVIDIA EP requirements do not name RTX Spark.** The Windows ML execution providers page states the requirement for NvTensorRtRtx as "NVIDIA GeForce RTX 30XX and above" with a minimum driver and CUDA version. It does not name RTX Spark or Arm64. Microsoft's launch post and NVIDIA's porting page both point to TensorRT for RTX on RTX Spark.

**Smart App Control blocks llama.cpp.** As described above, the GGUF path through llama.cpp does not run while Smart App Control is on. On company devices, this is an IT decision.

**Model work is still the developer's job.** Learn says: "Windows ML handles execution provider distribution, not model optimization." Models still need to be converted, quantized, and tested.

**The first start can be slow.** Learn warns that compiling for an EP can turn into a "multi-second (or even multi-minute) cold start." Microsoft's answer is to precompile and cache the model.

**Memory runs short in long sessions.** Microsoft measured a peak of 75.5 GB for MAI Code 1.1 Flash at the full 256K context. That is more than the 62.5 GB the GPU has on my laptop, so a very long session borrows memory from Windows. A model that loads fine at the start of a task can run short later.

**EP license terms apply.** Each EP comes with its vendor's license. For TensorRT for RTX, that means NVIDIA's software license terms.

## Other options on RTX Spark

Windows ML and Foundry Local are not the only ways to run AI on this laptop. RTX Spark brings the NVIDIA stack to Windows on Arm, opening several other paths.

### Windows AI APIs

These are built-in models and task APIs that ship with Windows. They need very little code, and the app does not manage a model at all. The app gets only the models Microsoft ships. Learn notes that Phi Silica, the built-in language model, is a Limited Access Feature that needs an unlock token, and that it will be replaced by Aion Instruct, which won't need one.

### TensorRT for RTX SDK directly

An app can skip Windows ML and use NVIDIA's TensorRT for RTX SDK. It has C++ and Python APIs, its own ONNX parser, and a command-line tool. It offers every NVIDIA setting, for example, engines without weights that load the weights later. The app then runs only on NVIDIA; the developer ships and updates the library, and every other PC in the fleet needs a separate path. This fits apps that only make sense on NVIDIA hardware, like high-end video or 3D tools.

### CUDA and PyTorch in WSL

This is where model work happens: training, fine-tuning, and testing. Microsoft's October post says NVIDIA publishes CUDA-enabled PyTorch packages for Windows on Arm64. When I set up my laptop, the picture was less clear. Maruhana, a developer who wrote about the same laptop, found no Windows on Arm CUDA version on the official PyTorch download pages and built PyTorch himself. Inside WSL, the normal Linux PyTorch used the GPU right away.

So on my laptop, all model work happens in WSL 2 with Ubuntu 24.04. NVIDIA's CUDA on WSL guide says the Windows driver "is the only driver you need to install," so I install no NVIDIA driver inside Linux. I give WSL 40 GB of the 64 GB that Windows has. This is a developer setup, not a way to ship features in Windows apps. The result of the model work moves to Windows ML as an ONNX or GGUF file.

### llama.cpp and Ollama

llama.cpp is the small C and C++ engine behind much of the open model community. NVIDIA lists it for Windows on Arm, and Microsoft says it worked with NVIDIA on llama.cpp speed, including CUDA graphs, NVFP4, and speculative decoding. On my laptop, llama.cpp is already in use because the GitHub Copilot app needs it. It is also the fastest way to try a new open model on the day it comes out.

Ollama wraps llama.cpp in an easy-to-use local server. I have not installed it. The information is mixed. NVIDIA lists Ollama for Windows on Arm, and two hands-on reports saw it use the GPU on this laptop. But Ollama's own development documentation says "Windows ARM does not support additional acceleration libraries at this time." Before I download large models into it, I want to see with `ollama ps` that it really uses the GPU.

### Self-bundled ONNX Runtime

An app can ship the open-source ONNX Runtime and pick EPs itself. It then loses the automatic EP download and updates. The "bring your own EP" option in Windows ML covers most of the same need inside the supported Windows stack.

### DirectML and WebGPU

DirectML is now marked "legacy" in the Windows ML documentation. NVIDIA's TensorRT for RTX numbers are measured against it. The WebGPU EP is experimental. Neither is a main path for this laptop.

### Docker

Docker Desktop for Windows on Arm is marked Early Access by Docker. Docker documents GPU support for "a Windows machine with an NVIDIA GPU" with WSL 2, but says nothing about Arm64. I found no official statement that GPU containers work on Windows on Arm, so I treat it as untested.

### The cloud

Microsoft Foundry and Azure stay the place for frontier models, large jobs, and shared services. In the GitHub Copilot app, I use cloud models for architecture across several repositories, hard bugs, large migrations, security reviews, and tasks that need a lot of context. Microsoft's own Surface page talks about reserving the cloud for larger AI workloads.

## All options in one table

| Option | Good for | Hardware | Who updates it | Effort |
|---|---|---|---|---|
| Windows ML | Own models in Windows apps | All Windows PCs | Windows | Medium |
| Foundry Local | Catalog chat and speech models in apps | Windows, macOS, Linux | Microsoft | Low |
| Windows AI APIs | Built-in tasks | Mainly Copilot+ PCs | Windows | Low |
| TensorRT for RTX SDK | Full NVIDIA tuning | NVIDIA RTX only | Developer | High |
| CUDA and PyTorch in WSL | Training, fine-tuning | NVIDIA, developer devices | Developer | High |
| llama.cpp | Trying open GGUF models | Broad | Developer | Low to medium |
| Ollama | Easy local server | Broad, GPU use to be checked on Arm | Developer | Low |
| Self-bundled ONNX Runtime | Fixed versions | All Windows PCs | Developer | Medium to high |
| Cloud (Microsoft Foundry) | Frontier models, scale | Any device online | Microsoft | Low to medium |

## What this means for IT and architects

For IT, the Surface Laptop Ultra is a Copilot+ PC and a Secured-core PC, managed like any other Windows 11 device. Windows ML is a Windows part; its EPs are certified by Microsoft, and Foundry Local models can be pinned to a version. That is easier to manage than a separate Python environment with its own CUDA build for every app. Smart App Control is the point to decide early, because the llama.cpp path does not work while it is on.

For architects, the change is in cost and data. Local inference avoids per-token charges and keeps data on the device. On my laptop, a 138B parameter coding model writes 66 tokens per second with 16,000 tokens of context. That changes which work can stay off the cloud. These laptops are expensive, though, and most people will not get one. AI features still need to work on a normal Copilot+ PC or in the cloud. The 128 GB laptop then simply does more of the work locally.

## What I use and what comes next

On my laptop, Windows ML is the base for local AI. The GitHub Copilot app runs MAI Code 1.1 Flash and Flint NVFP4 through its Windows ML provider for daily coding. Foundry Local is my second choice for my own apps and prototypes, and my fallback when the Copilot app models don't run. Model work, PyTorch, and CUDA run in WSL. Hard problems still go to cloud models. Ollama and GPU containers stay out until I have seen them use the GPU on Windows on ARM.

Next, I will take one of my apps that runs on a Foundry Local catalog model and build the same feature with a larger model through Windows ML on this laptop. Then I will compare quality, speed, and memory use side by side, and test the ONNX path with TensorRT for RTX against the GGUF path with llama.cpp.

## Sources

- Holger Imbery, [Local AI Development with the Surface Laptop Ultra](https://holgerimbery.blog/surface-laptop-ultra-local-ai-developer-setup), November 17, 2026: my setup, memory split, llama.cpp GPU memory, GitHub Copilot app requirements and Windows ML provider, llama-bench results, Smart App Control, Foundry Local use, model size guide, WSL and PyTorch, Ollama and Docker status, reviewer and community findings, MAI Code 1.1 Flash compression, benchmark, and memory figures from Microsoft
- Windows Experience Blog, [Introducing a powerful new chapter for Windows PCs, accelerated by NVIDIA RTX Spark](https://blogs.windows.com/windowsexperience/2026/05/31/introducing-a-powerful-new-chapter-for-windows-pcs-accelerated-by-nvidia-rtx-spark/), May 31, 2026: RTX Spark specifications, Windows changes for the chip, Windows ML and TensorRT statement, Copilot+ PC category, OEM list
- NVIDIA Newsroom, [NVIDIA and Microsoft Reinvent Windows PCs for the Age of Personal AI](https://nvidianews.nvidia.com/news/nvidia-microsoft-windows-pcs-agents-rtx-spark), May 31, 2026: GPU and CPU details, NVLink-C2C, MediaTek, OEM availability
- Microsoft Devices Blog, [Pre-order our most powerful Surface devices ever](https://blogs.windows.com/devices/2026/10/07/pre-order-our-most-powerful-surface-devices-ever/), October 7, 2026: pre-order date, Surface RTX Spark Dev Box
- Microsoft Learn, [Tech specs: Surface Laptop Ultra](https://learn.microsoft.com/en-us/surface/tech-specs/surface-laptop-ultra-1stedition): processor options, NVIDIA NPU, memory options
- Microsoft, [Surface Laptop Ultra product page](https://www.microsoft.com/en-us/surface/devices/surface-laptop-ultra): local agents, cloud for larger workloads, Copilot+ PC
- Microsoft Store, [Surface Laptop Ultra configuration page](https://www.microsoft.com/en-us/store/configure/surface-laptop-ultra/8wg5vqp0x4b8): starting price per processor option
- Microsoft Learn, [What is Windows ML?](https://learn.microsoft.com/en-us/windows/ai/new-windows-ml/overview), last updated November 13, 2026: definition, shared runtime, x64 and Arm64, same ONNX APIs, system requirements
- Microsoft Learn, [Windows ML execution providers](https://learn.microsoft.com/en-us/windows/ai/new-windows-ml/supported-execution-providers): EP list, download on demand, NvTensorRtRtx requirements, DirectML legacy, WebGPU experimental
- Microsoft Learn, [Accelerate AI models with Windows ML](https://learn.microsoft.com/en-us/windows/ai/new-windows-ml/accelerate-ai-models), last updated November 10, 2026: EP definition, bring your own EP, chip to EP table, cold start, model optimization
- Microsoft Learn, [What is Foundry Local?](https://learn.microsoft.com/en-us/azure/foundry-local/what-is-foundry-local), last updated October 22, 2026: Foundry Local definition, SDKs, curated catalog, about 20 MB runtime, OpenAI-compatible API, single user, platforms
- Microsoft Learn, [Get started with Foundry Local](https://learn.microsoft.com/en-us/windows/ai/foundry-local/get-started), last updated September 21, 2026: WinML package, hardware variants, Phi Silica and Aion Instruct
- Windows Developer Blog, [Windows ML is generally available](https://blogs.windows.com/windowsdeveloper/2025/09/23/windows-ml-is-generally-available-empowering-developers-to-scale-local-ai-across-windows-devices/), September 23, 2025: GA date, one app build, app size, device policies
- Microsoft Foundry on Windows Blog, [AI Development on Windows: from PyTorch and llama.cpp to Windows ML](https://devblogs.microsoft.com/foundry-on-windows/build-on-winml-oct-7-26/), October 7, 2026: GGUF and llama.cpp in Windows ML, task APIs, Runtime API, Windows ML CLI, PyTorch on Windows Arm64, experimental status
- NVIDIA Technical Blog, [Deploy High-Performance AI Models in Windows Applications on NVIDIA RTX AI PCs](https://developer.nvidia.com/blog/deploy-ai-models-faster-with-windows-ml-on-rtx-pcs/), September 23, 2025: TensorRT for RTX EP, throughput against DirectML, caching, copy time
- NVIDIA Technical Blog, [NVIDIA TensorRT for RTX Introduces an Optimized Inference AI Library on Windows 11](https://developer.nvidia.com/blog/nvidia-tensorrt-for-rtx-introduces-an-optimized-inference-ai-library-on-windows/), May 19, 2025: compiling on the device, FP4 and FP8, package size
- NVIDIA Technical Blog, [Run High-Performance AI Applications with NVIDIA TensorRT for RTX](https://developer.nvidia.com/blog/run-high-performance-ai-applications-with-nvidia-tensorrt-for-rtx/), June 12, 2025: standalone SDK, engines without weights
- NVIDIA Blog, [NVIDIA and Microsoft Advance Development on RTX AI PCs](https://blogs.nvidia.com/blog/rtx-ai-garage-computex-microsoft-build/), May 19, 2025: optimizations reach users as soon as they are ready
- NVIDIA Developer, [Port Your Windows Application to RTX Spark](https://developer.nvidia.com/topics/ai/local-ai/port-apps): porting steps, CUDA Toolkit 13.4, TensorRT RTX EP, Ollama and llama.cpp for Windows on Arm
- Earlier article on this blog: [Building On-Prem AI Agents with Azure Local, Foundry Local, and Microsoft Agent Framework](https://holgerimbery.blog/building-on-prem-ai-agents-with-azure-local-foundry-local-and-microsoft-agent-framework), April 11, 2026: Foundry Local as a shared inference runtime in the data center
