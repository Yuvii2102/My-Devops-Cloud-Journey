<div align="center">

# 🐳 Multi-Stage Docker Build & Distroless Images

### 🚀 DevOps Cloud Journey — Day 17

![Docker](https://img.shields.io/badge/Docker-Multi--Stage-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![DevOps](https://img.shields.io/badge/DevOps-Hands--On-success?style=for-the-badge)
![Containers](https://img.shields.io/badge/Containers-Production--Ready-0DB7ED?style=for-the-badge&logo=docker&logoColor=white)

</div>

---

# 📌 Project Overview

In this hands-on project, I learned and implemented **Multi-Stage Docker Builds** and **Distroless Docker Images** using a simple **Go Calculator application**.

The main objective was to understand how Docker images can be optimized by separating the **build environment** from the **runtime environment**.

The complete learning flow was:

```text
Dockerfile
    ↓
Normal Docker Build
    ↓
Large Docker Image
    ↓
Multi-Stage Docker Build
    ↓
Separate Build & Runtime
    ↓
Copy Only Application Binary
    ↓
Minimal Runtime Image
    ↓
Distroless / Scratch
    ↓
Smaller + Cleaner + More Secure Container
```

---

# 🧠 What Is Multi-Stage Docker Build?

Imagine that we are building a house.

During construction, we need:

```text
Bricks
Cement
Tools
Machines
Workers
Construction Equipment
```

But after the house is completed, we don't keep all the construction tools inside the house.

The same concept applies to Docker.

During application development and compilation, we may need:

```text
Compiler
Build Tools
Source Code
Dependencies
Package Manager
Development Libraries
```

But the final production container may only need:

```text
Application
Runtime
Required Libraries
```

Therefore, we can use **Multi-Stage Docker Builds**.

---

# ❌ Normal Docker Build

A normal Docker image may contain:

```text
┌──────────────────────────────┐
│          Ubuntu              │
│                              │
│  Compiler                    │
│  Build Tools                 │
│  Dependencies                │
│  Source Code                 │
│  Application                 │
│                              │
└──────────────────────────────┘
```

This can result in:

- 📦 Larger image size
- ⚡ Slower image transfer
- 🔓 Larger attack surface
- 🧹 Unnecessary packages
- 🚀 Less efficient production deployments

---

# 🚀 Multi-Stage Docker Build

A Multi-Stage Docker Build divides the Docker build process into multiple stages.

The first stage is responsible for **building the application**.

The final stage is responsible for **running the application**.

```text
                    Dockerfile
                        │
             ┌──────────┴──────────┐
             │                     │
             ▼                     ▼
       STAGE 1: BUILD        STAGE 2: RUNTIME
             │                     │
       Source Code           Minimal Image
       Compiler                    │
       Dependencies                │
             │                     │
             ▼                     │
      Application Binary           │
             │                     │
             └─────────────────────┘
                       │
                       ▼
                 Final Image
```

The main idea is:

> Build the application in one stage and copy only the required application artifact into another stage.

---

# 🧪 Practical Project — Go Calculator

For the practical implementation, I used a simple **Go Calculator application**.

Example project structure:

```text
golang-multi-stage-docker-build/
│
├── calculator.go
└── Dockerfile
```

Clone the project:

```bash
git clone <repository-url>
```

Enter the project:

```bash
cd golang-multi-stage-docker-build
```

Check the files:

```bash
ls
```

---

# 🐳 Step 1 — Normal Docker Build

Before implementing Multi-Stage Docker Build, I first understood the normal Docker build process.

Open the Dockerfile:

```bash
vim Dockerfile
```

Example normal Dockerfile:

```dockerfile
FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y golang-go

WORKDIR /app

COPY . .

RUN go build -o app

ENTRYPOINT ["./app"]
```

Save the file in Vim:

```text
ESC
:wq
ENTER
```

Build the image:

```bash
docker build -t simplecalculator .
```

Run the container:

```bash
docker run simplecalculator
```

Check the Docker images:

```bash
docker images
```

The normal image contains both the build environment and application:

```text
Ubuntu
   ↓
Go Compiler
   ↓
Dependencies
   ↓
Source Code
   ↓
Application
```

---

# ❌ Step 2 — Problem With the Normal Image

After compiling the application, the production container normally does not need:

```text
❌ Go Compiler
❌ Source Code
❌ Build Tools
❌ Package Manager
❌ Development Dependencies
```

It mainly needs:

```text
✅ Application
✅ Runtime Requirements
```

Therefore, we separate the build environment from the runtime environment.

---

# 🏗️ Step 3 — Create Multi-Stage Dockerfile

Open the Dockerfile:

```bash
vim Dockerfile
```

Use:

```dockerfile
# =========================
# Stage 1: Build
# =========================

FROM ubuntu:latest AS build

RUN apt-get update && \
    apt-get install -y golang-go

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 go build -o app


# =========================
# Stage 2: Runtime
# =========================

FROM scratch

COPY --from=build /app/app /app

ENTRYPOINT ["/app"]
```

---

# 🔍 Step 4 — Understand Stage 1

The first stage is:

```dockerfile
FROM ubuntu:latest AS build
```

This creates the **build stage**.

The stage is named:

```text
build
```

Install Go:

```dockerfile
RUN apt-get update && \
    apt-get install -y golang-go
```

Set the working directory:

```dockerfile
WORKDIR /app
```

Copy the source code:

```dockerfile
COPY . .
```

Compile the Go application:

```dockerfile
RUN CGO_ENABLED=0 go build -o app
```

This generates:

```text
/app/app
```

The build stage contains:

```text
Stage 1
│
├── Ubuntu
├── Go Compiler
├── Dependencies
├── Source Code
└── Compiled Application
```

---

# 🔍 Step 5 — Understand Stage 2

The second stage starts with:

```dockerfile
FROM scratch
```

`scratch` is an extremely minimal base image.

Now copy the compiled application from Stage 1:

```dockerfile
COPY --from=build /app/app /app
```

The important part is:

```text
--from=build
```

This means:

> Copy the required file from the previous stage named `build`.

Finally:

```dockerfile
ENTRYPOINT ["/app"]
```

runs the application.

---

# 🪄 Step 6 — The Magic of Multi-Stage Build

```text
                    STAGE 1
              ┌──────────────────┐
              │ Ubuntu           │
              │ Go Compiler      │
              │ Dependencies     │
              │ Source Code      │
              │                  │
              │ go build         │
              └────────┬─────────┘
                       │
                       │ Compiled Binary
                       ▼
                    /app/app
                       │
                       │ COPY --from=build
                       ▼
                    STAGE 2
              ┌──────────────────┐
              │ scratch          │
              │                  │
              │ /app             │
              │ Application      │
              └──────────────────┘
                       │
                       ▼
                 Final Image
```

The build environment does not become part of the final runtime image.

---

# 🔨 Step 7 — Build the Multi-Stage Image

Run:

```bash
docker build -t simplecalculator-multistage .
```

Check the image:

```bash
docker images
```

Run the container:

```bash
docker run simplecalculator-multistage
```

The Go Calculator application should execute successfully.

---

# 📊 Step 8 — Compare Image Sizes

Check:

```bash
docker images
```

Compare:

```text
simplecalculator
simplecalculator-multistage
```

Conceptually:

```text
NORMAL IMAGE

Ubuntu
├── Go Compiler
├── Dependencies
├── Source Code
└── Application

        ↓

      LARGE


MULTI-STAGE IMAGE

Minimal Runtime
└── Application

        ↓

      SMALL
```

The exact image size depends on the application and base images.

---

# 🔐 Step 9 — What Is a Distroless Image?

A **Distroless image** is a minimal container image designed to contain only the components required to run an application.

It avoids unnecessary operating-system utilities, shells, package managers, and development tools.

### Normal Image

```text
Ubuntu
├── Shell
├── apt
├── Utilities
├── Package Manager
├── Libraries
├── Compiler
├── Source Code
└── Application
```

### Distroless Runtime

```text
Distroless
├── Required Runtime
├── Required Libraries
└── Application
```

The goal is:

```text
Smaller Image
      +
Fewer Components
      +
Smaller Attack Surface
      =
Better Production Container
```

---

# ⚖️ Step 10 — Scratch vs Distroless

| Image | Description |
|---|---|
| `ubuntu` | Full Linux distribution with many utilities |
| `alpine` | Small Linux distribution |
| `scratch` | Empty/minimal base image |
| Distroless | Minimal runtime-focused image |

For statically compiled Go applications, `scratch` can work very well.

For applications that require runtime libraries, an appropriate Distroless runtime image can be more practical.

---

# 🐹 Step 11 — Go Application With Distroless

Instead of:

```dockerfile
FROM scratch
```

we can use:

```dockerfile
FROM gcr.io/distroless/static-debian12
```

Complete Dockerfile:

```dockerfile
# =========================
# Stage 1: Build
# =========================

FROM ubuntu:latest AS build

RUN apt-get update && \
    apt-get install -y golang-go

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 go build -o app


# =========================
# Stage 2: Distroless Runtime
# =========================

FROM gcr.io/distroless/static-debian12

COPY --from=build /app/app /app

ENTRYPOINT ["/app"]
```

Architecture:

```text
             Stage 1
        ┌────────────────┐
        │ Ubuntu         │
        │ Go             │
        │ Source Code    │
        │ Dependencies   │
        └───────┬────────┘
                │
                │ go build
                ▼
          Compiled Binary
                │
                │ COPY --from=build
                ▼
        ┌────────────────┐
        │ Distroless     │
        │ Runtime        │
        │                │
        │ Application    │
        └────────────────┘
```

---

# 🛡️ Step 12 — Why Use Distroless Images?

Distroless images can provide:

```text
🔒 Reduced Attack Surface
📦 Smaller Image Size
⚡ Faster Image Transfer
🧹 Fewer Unnecessary Packages
🚀 Better Production Container Design
```

Because unnecessary tools are not included, there are fewer components that could introduce vulnerabilities.

---

# 🏠 Step 13 — Real-World Analogy

Imagine sending a laptop to a customer.

### Normal Docker Image

```text
Laptop
+
Screwdriver
+
Toolkit
+
Manual
+
Factory Equipment
+
Spare Parts
```

But the customer only needs:

```text
Laptop
+
Charger
```

### Multi-Stage Docker

```text
Factory Tools
      │
      │ Build
      ▼
   Laptop
      │
      ▼
Customer
```

Docker works similarly:

```text
Build Environment
      │
      │ Compile
      ▼
Application Binary
      │
      ▼
Minimal Runtime Image
```

---

# 🔄 Step 14 — Normal Build vs Multi-Stage Build

```text
NORMAL BUILD
────────────────────────────

Ubuntu
  ↓
Install Go
  ↓
Install Dependencies
  ↓
Copy Source Code
  ↓
Build Application
  ↓
Everything Remains
  ↓
Large Final Image


MULTI-STAGE BUILD
────────────────────────────

Stage 1
  ↓
Ubuntu
  ↓
Install Go
  ↓
Copy Source
  ↓
Build Application
  ↓
Generate Binary
  ↓
Stage 2
  ↓
Minimal Runtime
  ↓
Copy Binary Only
  ↓
Small Final Image
```

---

# 🧩 Step 15 — Important Dockerfile Instructions Learned

| Instruction | Purpose |
|---|---|
| `FROM` | Defines the base image |
| `AS` | Gives a name to a build stage |
| `RUN` | Executes commands during image build |
| `WORKDIR` | Sets the working directory |
| `COPY` | Copies files into the image |
| `COPY --from` | Copies files from another build stage |
| `ENTRYPOINT` | Defines the container startup command |

---

# 🧪 Step 16 — Complete Practical Command Flow

```bash
# Update packages
sudo apt update

# Install Go if required
sudo apt install golang-go -y

# Check Go
go version

# Check Docker
docker --version

# Clone project
git clone <repository-url>

# Enter project
cd golang-multi-stage-docker-build

# Check project files
ls

# Open Dockerfile
vim Dockerfile

# Build normal image
docker build -t simplecalculator .

# Run normal image
docker run simplecalculator

# Check image size
docker images

# Edit Dockerfile for multi-stage build
vim Dockerfile

# Build multi-stage image
docker build -t simplecalculator-multistage .

# Check image size
docker images

# Run multi-stage container
docker run simplecalculator-multistage
```

---

# 🏗️ Step 17 — Complete Project Architecture

```text
                    SOURCE CODE
                         │
                         ▼
              ┌────────────────────┐
              │   Stage 1: BUILD   │
              │                    │
              │ Ubuntu             │
              │ Go Compiler        │
              │ Dependencies       │
              │ Source Code        │
              └─────────┬──────────┘
                        │
                     go build
                        │
                        ▼
               ┌─────────────────┐
               │ Compiled Binary │
               │     /app        │
               └────────┬────────┘
                        │
                 COPY --from=build
                        │
                        ▼
              ┌────────────────────┐
              │ Stage 2: RUNTIME  │
              │                    │
              │ Scratch /          │
              │ Distroless         │
              │                    │
              │ Application        │
              └─────────┬──────────┘
                        │
                        ▼
               PRODUCTION IMAGE
```

---

# 📚 Step 18 — Key Concepts Learned

### Multi-Stage Build

> Multi-stage builds allow us to separate the build environment from the runtime environment.

### Build Stage

Contains:

```text
Compiler
Dependencies
Source Code
Build Tools
```

### Runtime Stage

Contains:

```text
Application
Runtime Requirements
```

### Distroless Image

> A Distroless image provides a minimal runtime environment without unnecessary operating-system utilities and development tools.

### Main Benefits

```text
Multi-Stage Build
        │
        ├── 📦 Smaller Images
        ├── ⚡ Faster Deployment
        ├── 🧹 Fewer Dependencies
        ├── 🔒 Smaller Attack Surface
        └── 🚀 Production Friendly
```

---

# 💼 Step 19 — Interview Questions

### ❓ What is a Multi-Stage Docker Build?

**Answer:**

A Multi-Stage Docker Build uses multiple `FROM` stages in a Dockerfile. One stage is used to build the application with all required development tools and dependencies, while another stage contains only the artifacts required to run the application. This helps create smaller and more secure production images.

### ❓ What is a Distroless Image?

**Answer:**

A Distroless image is a minimal container image that contains only the runtime components required by an application and avoids unnecessary operating-system utilities and development tools. This helps reduce image size and attack surface.

### ❓ Why not use the build image in production?

**Answer:**

The build image contains compilers, source code, package managers, and development dependencies that are not required to run the application. Using a separate minimal runtime image reduces unnecessary components and improves security and efficiency.

### ❓ What does `COPY --from=build` do?

**Answer:**

`COPY --from=build` copies files or directories from a previous Docker build stage named `build` into the current stage.

### ❓ Why do we use `CGO_ENABLED=0` for this Go example?

**Answer:**

It disables CGO so that the Go application can be compiled as a statically linked binary, making it suitable for very minimal runtime images such as `scratch` or static Distroless images.

---

# 🎯 Step 20 — Final Learning Flow

```text
Docker Basics
      ↓
Dockerfile
      ↓
Normal Docker Build
      ↓
Large Image
      ↓
Identify Unnecessary Components
      ↓
Multi-Stage Docker Build
      ↓
Separate Build & Runtime
      ↓
Compile Application
      ↓
Copy Only Required Artifact
      ↓
Minimal Runtime Image
      ↓
Scratch / Distroless
      ↓
Smaller + Cleaner + More Secure
      ↓
Production-Ready Container
```

---

# 🏆 Key Takeaways

Through this hands-on project, I learned:

- 🐳 Docker image building
- 📄 Dockerfile creation
- 🔨 Normal Docker builds
- 🏗️ Multi-stage Docker builds
- 🔄 Separation of build and runtime environments
- 📦 Copying artifacts between stages
- 🐹 Building Go applications inside Docker
- 🪶 Scratch images
- 🔐 Distroless images
- 📉 Image-size optimization
- 🛡️ Reducing container attack surface
- 🚀 Production-oriented containerization

The most important concept I learned is:

```text
BUILD WITH EVERYTHING YOU NEED
              ↓
        CREATE ARTIFACT
              ↓
     THROW AWAY BUILD TOOLS
              ↓
      RUN WITH ONLY WHAT
        THE APP NEEDS
```

---

<div align="center">

# 🚀 DAY 17 COMPLETE

### 🐳 Multi-Stage Docker Build & Distroless Images

**Build Smart • Ship Small • Run Secure**

### DevOps Cloud Journey

</div>
