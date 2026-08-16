<div align="center">

## DAY 10 — DOCKER & CONTAINERIZATION

### 🚀 From Infrastructure to Containers

![Docker](https://img.shields.io/badge/Docker-Containerization-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Containers](https://img.shields.io/badge/Containers-Application%20Packaging-0db7ed?style=for-the-badge&logo=docker&logoColor=white)
![DevOps](https://img.shields.io/badge/DevOps-Learning-FF6F00?style=for-the-badge)

</div>

---

# 🐳 01 — CONTAINERIZATION

## 📚 What I Learned

**Containerization** is a way of packaging an application together with everything it needs to run.

A container can include:

- Application code
- Dependencies
- Libraries
- Configuration
- Runtime requirements

The main goal is to make an application run consistently across different environments.

### 💡 Why Containerization?

Without containers, an application may work on one machine but fail on another because of differences in:

- Operating System
- Dependencies
- Libraries
- Versions
- Configuration

With containers, the application and its required environment are packaged together.

### 🔄 Basic Idea

    Application
         ↓
    Dependencies
         ↓
    Configuration
         ↓
    📦 Container
         ↓
    🚀 Running Application

> **Key Idea:** Build once → Package once → Run consistently.

---

# 🐳 02 — WHAT IS DOCKER?

**Docker** is a platform used to build, package, distribute and run applications inside **containers**.

Instead of manually configuring every server, Docker allows us to package an application and its dependencies into a portable unit.

### 🧠 Simple Example

    Application
         ↓
    Python / Runtime
         ↓
    Required Libraries
         ↓
    Configuration
         ↓
    Docker Container

The same container can then be moved between different environments.

---

# 🔄 03 — DOCKER WORKFLOW

The basic Docker workflow I learned:

    👨‍💻 Application Code
             ↓
        📄 Dockerfile
             ↓
          🔨 Build
             ↓
        🖼️ Docker Image
             ↓
          ▶️ Run
             ↓
        🐳 Container
             ↓
       🚀 Application

### 🔑 Most Important Relationship

    Dockerfile → Image → Container

- **Dockerfile** → Instructions used to build an image
- **Image** → Blueprint/template used to create containers
- **Container** → Running instance of an image

---

# 📄 04 — DOCKERFILE

A **Dockerfile** is a text file containing instructions used to build a Docker image.

### Example

    FROM ubuntu

    RUN apt update

    CMD ["echo", "Hello Docker"]

### 🧩 Important Idea

    Dockerfile
         ↓
    Docker Engine
         ↓
    Docker Image

The Dockerfile tells Docker **how the image should be created**.

---

# 🖼️ 05 — DOCKER IMAGE

A **Docker Image** is a packaged, read-only template that contains everything required to create and run a container.

Images can be stored in a **Docker Registry**.

### Image Flow

    Dockerfile
         ↓
    Docker Image
         ↓
    Docker Registry
         ↓
    Pull Image
         ↓
    Create Container

### 🧠 Simple Understanding

> **Image = Blueprint / Template**

An image itself is not the running application.

---

# 🐳 06 — DOCKER CONTAINER

A **Docker Container** is a running instance of a Docker image.

    Docker Image
         ↓
       Container
         ↓
    Running Application

### 🧠 Simple Understanding

> **Container = Running instance of an Image**

For example:

    docker run nginx

This creates and runs a container from the `nginx` image.

---

# ⚙️ 07 — DOCKER ENGINE

**Docker Engine** is the software that manages Docker containers and images.

It is responsible for tasks such as:

- Creating containers
- Running containers
- Managing images
- Managing container lifecycle
- Providing the Docker environment

### 🔄 Docker Engine Flow

    👨‍💻 Docker CLI
           ↓
      ⚙️ Docker Engine
           ↓
      🖼️ Docker Image
           ↓
      🐳 Container

When we execute:

    docker run <image>

Docker Engine uses the specified image to create and run a container.

---

# 🧱 08 — DOCKER CONTAINER LIFECYCLE

A basic container lifecycle:

    🖼️ Image
       ↓
    🐳 Create Container
       ↓
    ▶️ Start
       ↓
    ⚙️ Running
       ↓
    ⏹️ Stop
       ↓
    🗑️ Remove

### Important Terms

| Term | Meaning |
|---|---|
| 🖼️ Image | Template used to create containers |
| 🐳 Container | Running instance of an image |
| 📄 Dockerfile | Instructions used to build an image |
| ⚙️ Docker Engine | Software that manages Docker |
| 🌐 Registry | Stores and distributes images |

---

# 🏗️ 09 — BUILDING A DOCKER IMAGE

The basic command used to build an image:

    docker build -t myapp .

### What happens?

    Dockerfile
         ↓
    docker build
         ↓
    Docker Engine
         ↓
    Docker Image

The `-t` option is used to give the image a name/tag.

---

# ▶️ 10 — RUNNING A CONTAINER

Once an image is available, it can be used to create a container.

    docker run myapp

The basic relationship is:

    Image
      ↓
    docker run
      ↓
    Container
      ↓
    Application Running

Another example:

    docker run nginx

This runs a container using the `nginx` image.

---

# 🌐 11 — DOCKER REGISTRY

A **Docker Registry** is used to store and distribute Docker images.

### Basic Workflow

    👨‍💻 Developer
          ↓
    🖼️ Build Image
          ↓
    🌐 Docker Registry
          ↓
    ☁️ Server
          ↓
    🐳 Container

A registry allows images to be stored and pulled whenever they are required.

### 🧠 Key Idea

Instead of manually copying application files and dependencies between servers, we can:

    Build Image
         ↓
    Push Image
         ↓
    Registry
         ↓
    Pull Image
         ↓
    Run Container

---

# 📜 12 — DOCKERFILE → IMAGE → CONTAINER

This is one of the most important flows from today's learning:

    📄 Dockerfile
          ↓
      🔨 docker build
          ↓
      🖼️ Docker Image
          ↓
       ▶️ docker run
          ↓
      🐳 Docker Container
          ↓
      🚀 Application

### ⭐ Remember

> **Dockerfile builds the Image.**
>
> **Image creates the Container.**
>
> **Container runs the Application.**

---

# 🏛️ 13 — OCI

**OCI** stands for **Open Container Initiative**.

OCI provides standards for container images and container runtimes.

The purpose is to create common standards so different container tools can work with compatible container technologies.

### Basic Idea

    🏛️ OCI Standards
           ↓
    Container Ecosystem
           ↓
    Docker / Podman / Buildah
           ↓
    📦 Container Images
    🐳 Containers

---

# 🛠️ 14 — DOCKER vs BUILDAH vs PODMAN

I also learned about other container tools.

| Tool | Main Purpose |
|---|---|
| 🐳 Docker | Build images + run/manage containers |
| 🔨 Buildah | Build container images |
| 🦭 Podman | Run/manage containers |

### Simple Understanding

    🐳 Docker
       ├── Build Images
       └── Run Containers

    🔨 Buildah
       └── Build Images

    🦭 Podman
       └── Run Containers

These tools work within the broader container ecosystem and can use OCI-compatible standards.

---

# 🧠 15 — IMPORTANT CONCEPTS

### 📦 Containerization

Packaging an application with everything required to run it consistently.

### 🐳 Docker

A platform used for building, packaging and running applications in containers.

### 📄 Dockerfile

A file containing instructions used to build a Docker image.

### 🖼️ Docker Image

A packaged template used to create containers.

### 🐳 Docker Container

A running instance of a Docker image.

### ⚙️ Docker Engine

Software responsible for managing Docker images and containers.

### 🌐 Docker Registry

A place used to store and distribute container images.

### 🏛️ OCI

Open Container Initiative — provides standards for container images and runtimes.

### 🔨 Buildah

Primarily used for building container images.

### 🦭 Podman

Used for running and managing containers.

---

# 🎯 16 — DOCKER IN DEVOPS

Containerization is extremely important in DevOps because it makes applications easier to package, distribute and deploy.

### DevOps Flow

    👨‍💻 Developer
          ↓
       💻 Code
          ↓
    📄 Dockerfile
          ↓
      🔨 Build
          ↓
     🖼️ Image
          ↓
    🌐 Registry
          ↓
      ☁️ Server
          ↓
     🐳 Container
          ↓
     🚀 Application

### 💡 DevOps Idea

    Develop
       ↓
    Build
       ↓
    Package
       ↓
    Store
       ↓
    Deploy
       ↓
    Run

Docker helps make this process more consistent and repeatable.

---

# 🧪 17 — BASIC DOCKER COMMANDS

### Build an Image

    docker build -t myapp .

### Run a Container

    docker run myapp

### Run Nginx Container

    docker run nginx

### Basic Command Flow

    docker build
         ↓
      Image
         ↓
    docker run
         ↓
      Container

---

# 📝 18 — QUICK REVISION

    What is Containerization?
    → Packaging an application with everything required to run it.

    What is Docker?
    → A platform for building, packaging and running applications in containers.

    What is a Dockerfile?
    → A file containing instructions to build an image.

    What is a Docker Image?
    → A packaged template used to create containers.

    What is a Container?
    → A running instance of an image.

    What is Docker Engine?
    → Software responsible for managing Docker containers and images.

    What is a Registry?
    → A place to store and distribute container images.

    What is OCI?
    → Open Container Initiative; provides standards for containers.

    What is Buildah?
    → A tool mainly used for building container images.

    What is Podman?
    → A tool used for running and managing containers.

---

# 💡 19 — KEY TAKEAWAY

> **Docker solves the "it works on my machine" problem by packaging applications and their required environment into portable containers.**

### 🔥 The Most Important Flow

    📄 Dockerfile
          ↓
       🔨 Build
          ↓
      🖼️ Image
          ↓
       ▶️ Run
          ↓
      🐳 Container
          ↓
      🚀 Application

---

<div align="center">

# 🐳 DAY 10 COMPLETE

### ☁️ Containerization → Docker → Images → Containers → OCI

**🚀 One step closer to becoming a DevOps & Cloud Engineer**

</div>
