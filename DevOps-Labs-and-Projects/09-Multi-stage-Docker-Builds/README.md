<p align="center">

# 🐳 Multi-Stage Docker Build | Reduce Image Size  | Distroless Container Images

### 🚀 Go Application • Docker • Ubuntu EC2 • Multi-Stage Build • Scratch

</p>

<p align="center">

![Docker](https://img.shields.io/badge/Docker-Multi--Stage-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Go](https://img.shields.io/badge/Go-Golang-00ADD8?style=for-the-badge&logo=go&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-EC2-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-EC2-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)

</p>

---

# 📌 Overview

In this hands-on Docker lab, I learned how to use **Multi-Stage Docker Builds** to dramatically reduce the size of a Docker image.

I used a simple **Go Calculator application** and created two Docker images:

1. 🐳 A normal Docker image
2. 🚀 A Multi-Stage Docker image

The normal image was approximately **1.01 GB**, while the Multi-Stage image was only **3.94 MB**.

This demonstrated how we can keep the heavy build environment separate from the lightweight runtime environment.

---

# 🎯 Objectives

- Understand Docker image size.
- Build a Go application using Docker.
- Understand normal Docker builds.
- Understand Multi-Stage Docker builds.
- Separate build and runtime environments.
- Use `COPY --from=build`.
- Use `CGO_ENABLED=0`.
- Use `scratch` as a minimal runtime image.
- Compare Docker image sizes.
- Understand why smaller container images are useful.

---

# 🧠 What is a Multi-Stage Docker Build?

A **Multi-Stage Docker Build** allows us to use multiple `FROM` instructions in a single Dockerfile.

The main idea is:

```text
Build the application
        ↓
Create the binary
        ↓
Throw away the build environment
        ↓
Copy only the binary
        ↓
Run it in a minimal image
```

Instead of shipping the compiler, dependencies, source code and build tools inside the production container, we keep those things in a separate **build stage**.

---

# 🆚 Normal Docker Build vs Multi-Stage Build

## ❌ Normal Docker Build

```text
┌───────────────────────────────────────┐
│             Ubuntu Image              │
│                                       │
│  Go Compiler                          │
│  Build Tools                          │
│  Dependencies                         │
│  Source Code                          │
│  Compiled Application                 │
│                                       │
│          ❌ Large Image               │
└───────────────────────────────────────┘
```

## ✅ Multi-Stage Docker Build

```text
              BUILD STAGE
        ┌─────────────────────────┐
        │         Ubuntu          │
        │                         │
        │     Install Go          │
        │     Copy Source         │
        │     Compile App         │
        │                         │
        │       /app              │
        └───────────┬─────────────┘
                    │
                    │ COPY --from=build
                    ▼
             FINAL STAGE
        ┌─────────────────────────┐
        │        scratch          │
        │                         │
        │         /app            │
        │                         │
        │      🪶 Tiny Image      │
        └─────────────────────────┘
```

---

# 📁 Project Structure

```text
Docker-Zero-to-Hero/
└── examples/
    └── golang-multi-stage-docker-build/
        ├── Dockerfile
        ├── README.md
        ├── calculator.go
        │
        └── dockerfile-without-multistage/
            ├── Dockerfile
            └── calculator.go
```

---

# 🚀 Step 1 — Clone the Repository

I cloned the Docker learning repository:

```bash
git clone https://github.com/iam-veeramalla/Docker-Zero-to-Hero.git
```

Check the directory:

```bash
ls
```

Output:

```text
Docker-Zero-to-Hero
```

---

# 📂 Step 2 — Navigate to the Docker Examples

```bash
cd Docker-Zero-to-Hero/
```

Check the contents:

```bash
ls
```

```text
README.md
commands.md
examples
networking.md
volumes.md
```

Go inside the examples directory:

```bash
cd examples
```

Check the available examples:

```bash
ls
```

```text
first-docker-file
golang-multi-stage-docker-build
python-web-app
```

Navigate to the Go Multi-Stage project:

```bash
cd golang-multi-stage-docker-build/
```

Check the files:

```bash
ls
```

```text
Dockerfile
README.md
calculator.go
dockerfile-without-multistage
```

---

# 🐹 Step 3 — Try Running the Go Application

I first tried to run the Go application directly:

```bash
go run calculator.go
```

But Go was not installed on the EC2 instance.

The terminal showed:

```text
Command 'go' not found
```

---

# 📥 Step 4 — Install Go

I installed Go using:

```bash
sudo apt install golang-go
```

This installed Go and its required dependencies.

---

# 🐳 Step 5 — Check the Non-Multi-Stage Project

I entered the directory containing the normal Dockerfile:

```bash
cd dockerfile-without-multistage/
```

Check the files:

```bash
ls
```

Output:

```text
Dockerfile
calculator.go
```

---

# ⚠️ Step 6 — Docker Was Not Installed

I tried to build the image:

```bash
docker build -t simplecalculator .
```

But Docker was not installed.

The terminal showed:

```text
Command 'docker' not found
```

---

# 📦 Step 7 — Install Docker

I installed Docker:

```bash
sudo apt install docker.io
```

After installation, Docker was available on the EC2 instance.

---

# ⚠️ Step 8 — Docker Permission Error

When I tried:

```bash
docker build -t simplecalculator .
```

I received:

```text
permission denied while trying to connect to the docker API
at unix:///var/run/docker.sock
```

This happened because the current Ubuntu user did not yet have permission to access the Docker socket.

---

# 🔧 Step 9 — Check Docker Service

I checked whether Docker was running:

```bash
sudo systemctl status docker
```

Docker was successfully running:

```text
Active: active (running)
```

---

# 👤 Step 10 — Fix Docker Permission

I added the current user to the Docker group:

```bash
sudo usermod -aG docker $USER
```

Then refreshed the group membership:

```bash
newgrp docker
```

I verified Docker access:

```bash
docker ps
```

Output:

```text
CONTAINER ID   IMAGE   COMMAND   CREATED   STATUS   PORTS   NAMES
```

The Docker permission problem was fixed.

---

# 🏗️ Step 11 — Build the Normal Docker Image

From:

```text
dockerfile-without-multistage/
```

I executed:

```bash
docker build -t simplecalculator .
```

The build process used:

```dockerfile
FROM ubuntu AS build

RUN apt-get update && apt-get install -y golang-go

ENV GO111MODULE=off

COPY . .

RUN CGO_ENABLED=0 go build -o /app .

ENTRYPOINT ["/app"]
```

The build completed successfully:

```text
Successfully built d213087fc647
Successfully tagged simplecalculator:latest
```

---

# 📊 Step 12 — Check the Normal Image

I checked the available Docker images:

```bash
docker images
```

The result showed:

```text
IMAGE                     DISK USAGE
simplecalculator:latest   1.01GB
ubuntu:latest             160MB
```

The normal application image was approximately:

# ❌ 1.01 GB

---

# 📸 Normal Docker Image

<p align="center">

<img src="./images/multi-stage-01-normal-image.png" width="900">

</p>

---

# 🧩 Step 13 — Create the Multi-Stage Dockerfile

I returned to the main project:

```bash
cd ..
```

Then opened the Dockerfile:

```bash
vim Dockerfile
```

I changed it to a Multi-Stage Dockerfile.

---

# 🐳 Multi-Stage Dockerfile

```dockerfile
########################################
# BUILD STAGE
########################################

FROM ubuntu AS build

RUN apt-get update && apt-get install -y golang-go

ENV GO111MODULE=off

COPY . .

RUN CGO_ENABLED=0 go build -o /app .


########################################
# FINAL STAGE
########################################

FROM scratch

# Copy the compiled binary from the build stage
COPY --from=build /app /app

# Run the compiled application
ENTRYPOINT ["/app"]
```

---

# 🧠 Understanding the Multi-Stage Dockerfile

## 1️⃣ Build Stage

```dockerfile
FROM ubuntu AS build
```

This creates a build stage named:

```text
build
```

This stage contains the environment required to compile the Go application.

---

## 2️⃣ Install Go

```dockerfile
RUN apt-get update && apt-get install -y golang-go
```

Go is installed only in the **build stage**.

The final image does not need the Go compiler.

---

## 3️⃣ Set Go Environment

```dockerfile
ENV GO111MODULE=off
```

This configures the Go environment used by this example.

---

## 4️⃣ Copy Source Code

```dockerfile
COPY . .
```

The application source code is copied into the build stage.

---

## 5️⃣ Compile the Application

```dockerfile
RUN CGO_ENABLED=0 go build -o /app .
```

This compiles the Go application and creates:

```text
/app
```

The important part is:

```text
CGO_ENABLED=0
```

This allows the Go application to be built as a standalone binary suitable for the minimal runtime stage used in this lab.

---

# 🪶 Step 14 — Create the Final Runtime Stage

The second stage starts with:

```dockerfile
FROM scratch
```

`scratch` is an empty base image.

Instead of copying the entire Ubuntu environment into the final image, we copy only the compiled application.

```dockerfile
COPY --from=build /app /app
```

This means:

```text
BUILD STAGE
     │
     │ /app
     │
     ▼
FINAL STAGE
     │
     └── /app
```

The final image does not contain the Go compiler or the build environment.

---

# 🚀 Step 15 — Set the Entry Point

```dockerfile
ENTRYPOINT ["/app"]
```

This tells Docker to execute `/app` when the container starts.

---

# 📸 Multi-Stage Dockerfile

<p align="center">

<img src="./images/multi-stage-02-dockerfile.png" width="900">

</p>

---

# ⚠️ Step 16 — First Multi-Stage Build Attempt

I initially executed:

```bash
docker build -t simplecalculator-multistage
```

Docker returned:

```text
docker: 'docker build' requires 1 argument
```

It also displayed:

```text
Usage: docker build [OPTIONS] PATH | URL | -
```

The problem was that I forgot to specify the build context.

---

# ✅ Step 17 — Correct Multi-Stage Build Command

The correct command is:

```bash
docker build -t simplecalculator-multistage .
```

The `.` means:

```text
Use the current directory as the Docker build context.
```

---

# 🔨 Step 18 — Multi-Stage Build Process

Docker executed the following steps:

```text
Step 1/8 : FROM ubuntu AS build

Step 2/8 : RUN apt-get update && apt-get install -y golang-go

Step 3/8 : ENV GO111MODULE=off

Step 4/8 : COPY . .

Step 5/8 : RUN CGO_ENABLED=0 go build -o /app .

Step 6/8 : FROM scratch

Step 7/8 : COPY --from=build /app /app

Step 8/8 : ENTRYPOINT ["/app"]
```

The build completed successfully:

```text
Successfully built 23d9aada258f
Successfully tagged simplecalculator-multistage:latest
```

---

# 📸 Multi-Stage Build Output

<p align="center">

<img src="./images/multi-stage-03-build.png" width="900">

</p>

---

# 📊 Step 19 — Compare Docker Images

I checked the images:

```bash
docker images
```

The final result was:

| Image | Disk Usage | Content Size |
|---|---:|---:|
| `simplecalculator:latest` | **1.01 GB** | 250 MB |
| `simplecalculator-multistage:latest` | **3.94 MB** | 1.47 MB |
| `ubuntu:latest` | 160 MB | 45.3 MB |

---

# 📉 Image Size Comparison

```text
NORMAL IMAGE
simplecalculator
████████████████████████████████████████
1.01 GB


MULTI-STAGE IMAGE
simplecalculator-multistage
▏
3.94 MB
```

The image size went from approximately:

```text
1.01 GB
   ↓
3.94 MB
```

This is a dramatic reduction in image size.

---

# 📸 Final Image Comparison

<p align="center">

<img src="./images/multi-stage-04-image-comparison.png" width="900">

</p>

---

# 🏗️ Multi-Stage Architecture

```text
                         GO SOURCE CODE
                              │
                              ▼
                ┌───────────────────────────┐
                │       BUILD STAGE         │
                │                           │
                │       FROM ubuntu         │
                │                           │
                │       Install Go          │
                │       Copy Source         │
                │       Build Application   │
                │                           │
                │          /app             │
                └─────────────┬─────────────┘
                              │
                       COPY --from=build
                              │
                              ▼
                ┌───────────────────────────┐
                │       FINAL STAGE         │
                │                           │
                │        FROM scratch       │
                │                           │
                │           /app            │
                │                           │
                │        3.94 MB            │
                └─────────────┬─────────────┘
                              │
                              ▼
                     RUN APPLICATION
```

---

# 🔄 Complete Multi-Stage Flow

```mermaid
flowchart TD

    A[Go Source Code] --> B[Docker Build]

    B --> C[Build Stage]

    C --> D[Ubuntu Base Image]

    D --> E[Install Golang]

    E --> F[Copy Source Code]

    F --> G[CGO_ENABLED=0 go build]

    G --> H[/app Binary]

    H --> I[Final Stage]

    I --> J[scratch]

    J --> K[Copy /app]

    K --> L[Minimal Docker Image]

    L --> M[Run Container]
```

---

# 🔄 Normal Build vs Multi-Stage Build

| Feature | Normal Build | Multi-Stage Build |
|---|---|---|
| Build Environment | Included in image | Separate stage |
| Go Compiler | Included | Build stage only |
| Build Dependencies | Included | Build stage only |
| Source Code | May remain | Not required in final image |
| Runtime Base | Ubuntu | `scratch` |
| Image Size | Large | Extremely small |
| Efficiency | Lower | Higher |
| Runtime Contents | More | Minimal |

---

# 🧪 Commands Used

## Update Packages

```bash
sudo apt update
```

## Clone Repository

```bash
git clone https://github.com/iam-veeramalla/Docker-Zero-to-Hero.git
```

## Install Go

```bash
sudo apt install golang-go
```

## Install Docker

```bash
sudo apt install docker.io
```

## Check Docker Service

```bash
sudo systemctl status docker
```

## Fix Docker Permission

```bash
sudo usermod -aG docker $USER
newgrp docker
```

## Check Running Containers

```bash
docker ps
```

## Build Normal Image

```bash
docker build -t simplecalculator .
```

## Build Multi-Stage Image

```bash
docker build -t simplecalculator-multistage .
```

## List Docker Images

```bash
docker images
```

## Edit Dockerfile

```bash
vim Dockerfile
```

---

# ⚠️ Errors I Faced and Solutions

## ❌ Error 1 — Go Not Installed

```text
Command 'go' not found
```

### Solution

```bash
sudo apt install golang-go
```

---

## ❌ Error 2 — Docker Not Installed

```text
Command 'docker' not found
```

### Solution

```bash
sudo apt install docker.io
```

---

## ❌ Error 3 — Docker Permission Denied

```text
permission denied while trying to connect to the docker API
```

### Solution

```bash
sudo usermod -aG docker $USER
newgrp docker
```

Then:

```bash
docker ps
```

---

## ❌ Error 4 — Missing Build Context

### Wrong

```bash
docker build -t simplecalculator-multistage
```

### Correct

```bash
docker build -t simplecalculator-multistage .
```

### Why?

Docker requires a build context.

The `.` means:

```text
Current directory
```

---

# 🧠 Important Docker Concepts Learned

## 🐳 Docker Image

A Docker image is a packaged template containing the application and everything required to run it.

---

## 📦 Docker Container

A container is a running instance of a Docker image.

---

## 🏗️ Build Stage

The build stage contains tools required to create the application.

Example:

```dockerfile
FROM ubuntu AS build
```

---

## 🚀 Runtime Stage

The runtime stage contains only the files required to run the application.

In this project:

```dockerfile
FROM scratch
```

---

## 🔀 `COPY --from`

This allows us to copy files from another build stage.

```dockerfile
COPY --from=build /app /app
```

Meaning:

```text
Take /app from the stage called "build"
and copy it to /app in the final image.
```

---

## 🪶 `scratch`

`scratch` is an empty base image.

It contains no normal Linux userspace.

For a statically compiled Go binary like the one created in this lab, it can be used as the final runtime image.

---

## ⚙️ `CGO_ENABLED=0`

The Dockerfile uses:

```bash
CGO_ENABLED=0
```

while compiling the Go application.

This helps produce a standalone binary that can run in the minimal `scratch` image used in this project.

---

# 🔐 Why Smaller Docker Images Matter

Smaller images can provide practical advantages:

- ⚡ Faster image transfer
- 🚀 Faster deployment
- 💾 Lower storage requirements
- 📦 Smaller deployment artifacts
- 🔐 Fewer unnecessary runtime components
- 🌐 Faster distribution between environments

---

# 🎯 Main Lesson

The most important concept from this hands-on is:

```text
DON'T SHIP THE BUILD ENVIRONMENT
              ↓
       BUILD THE APPLICATION
              ↓
       KEEP ONLY THE ARTIFACT
              ↓
      RUN IT MINIMALLY
```

Instead of shipping:

```text
Ubuntu
+
Go Compiler
+
Build Dependencies
+
Source Code
+
Build Tools
+
Application
```

we can ship:

```text
Minimal Runtime
+
Compiled Application
```

---

# 📈 Final Result

```text
┌─────────────────────────────────────┐
│         NORMAL DOCKER BUILD         │
│                                     │
│     simplecalculator:latest        │
│                                     │
│            1.01 GB                  │
└──────────────────┬──────────────────┘
                   │
                   │ Multi-Stage Build
                   ▼
┌─────────────────────────────────────┐
│       MULTI-STAGE DOCKER BUILD      │
│                                     │
│   simplecalculator-multistage       │
│                                     │
│             3.94 MB                 │
└─────────────────────────────────────┘
```

### 🔥 Result

```text
1.01 GB
   ↓
3.94 MB
```

---

# 📚 What I Learned From This Hands-On

- ✅ How to install Go on Ubuntu.
- ✅ How to install Docker on Ubuntu.
- ✅ How to check the Docker service.
- ✅ How to fix Docker socket permission issues.
- ✅ How to build a Docker image.
- ✅ How Docker build context works.
- ✅ How to create a normal Docker image.
- ✅ How to create a Multi-Stage Dockerfile.
- ✅ How to create separate build and runtime stages.
- ✅ How `COPY --from=build` works.
- ✅ How `CGO_ENABLED=0` is used in the Go build.
- ✅ How `scratch` can be used as a minimal runtime image.
- ✅ How to compare Docker image sizes.
- ✅ Why smaller Docker images are useful.
- ✅ How Multi-Stage Builds improve container efficiency.

---

# 🏆 Hands-On Achievement

```text
                 🐳 DOCKER
                    │
                    ▼
           MULTI-STAGE BUILD
                    │
          ┌─────────┴─────────┐
          │                   │
          ▼                   ▼
     BUILD STAGE         FINAL STAGE
          │                   │
       Ubuntu              scratch
          │                   │
     Install Go             /app
          │                   │
     Compile App              │
          │                   │
          └─────────┬─────────┘
                    │
                    ▼
             3.94 MB IMAGE
```

---

# 💡 Final Takeaway

> **Build with a full environment, but run with only what the application needs.**

Multi-Stage Docker Builds allow us to separate the **development/build environment** from the **production/runtime environment**.

This hands-on demonstrated a reduction from:

```text
1.01 GB
```

to:

```text
3.94 MB
```

using:

```dockerfile
FROM ubuntu AS build
```

for the build stage and:

```dockerfile
FROM scratch
```

for the final runtime stage.

---

<p align="center">

# 🐳 MULTI-STAGE DOCKER BUILD COMPLETE 🚀

### 1.01 GB → 3.94 MB 🔥

</p>
