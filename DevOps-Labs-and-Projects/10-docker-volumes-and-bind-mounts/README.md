<p align="center">

# 🐳 Docker Volumes & Bind Mounts

### Persistent Storage for Docker Containers

**AWS EC2 • Ubuntu • Docker**

</p>

---

## 📌 Overview

Docker containers are **ephemeral by default**.

This means that when a container is removed, the data stored inside its writable container layer can also be lost.

To keep data persistent and share data between the host and containers, Docker provides storage mechanisms such as:

* 📦 Docker Volumes
* 📁 Bind Mounts
* 💾 Temporary filesystem mounts

In this hands-on practice, I worked with a **Docker Named Volume** and mounted it inside an NGINX container.

---

# 🧠 1. Docker Volume

A **Docker Volume** is storage managed by Docker.

Docker stores the volume data in Docker's own storage area on the host.

### Simple idea

```text
Docker Host
│
├── Docker Engine
│
├── Containers
│
└── Docker Volume
      │
      └── yuvi
           │
           ▼
       Container
       /app
```

The volume is managed by Docker rather than directly by the user.

---

# 🔄 2. Why Do We Need Volumes?

Without persistent storage:

```text
Container
   │
   └── Application Data
           │
           ▼
      Container Removed
           │
           ▼
        Data Lost ❌
```

With a Docker volume:

```text
              Docker Host
                   │
             Docker Volume
                "yuvi"
                   │
                   ▼
             ┌───────────┐
             │ Container │
             │           │
             │   /app    │
             └───────────┘
```

The container can be removed while the volume can remain available.

---

# 🛠️ 3. Creating a Docker Volume

First, I created a Docker named volume called `yuvi`.

```bash
docker volume create yuvi
```

Output:

```text
yuvi
```

The volume was successfully created.

---

# 🔍 4. Listing Docker Volumes

To see available Docker volumes:

```bash
docker volume ls
```

Output:

```text
DRIVER    VOLUME NAME
local     yuvi
```

The `yuvi` volume is using Docker's `local` volume driver.

---

# 🔎 5. Inspecting the Volume

To get detailed information about the volume:

```bash
docker volume inspect yuvi
```

The inspection showed information similar to:

```json
[
    {
        "CreatedAt": "2026-08-19T08:47:11Z",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/yuvi/_data",
        "Name": "yuvi",
        "Options": null,
        "Scope": "local"
    }
]
```

### Important fields

| Field        | Meaning                                      |
| ------------ | -------------------------------------------- |
| `Name`       | Name of the volume                           |
| `Driver`     | Storage driver used by Docker                |
| `Mountpoint` | Location where Docker stores the volume data |
| `Scope`      | Scope of the volume                          |

The important mount point in this experiment was:

```text
/var/lib/docker/volumes/yuvi/_data
```

---

# 🐳 6. Building the Docker Image

I also built the Docker image used during the exercise:

```bash
docker build -t volumedemo .
```

The build completed successfully:

```text
Successfully built d618a7dee113
Successfully tagged volumedemo:latest
```

---

# ⚠️ 7. First Docker Run Attempt

I first tried:

```bash
docker run -d --mount source=yuvi,target=/app
```

Docker returned:

```text
docker: 'docker run' requires at least 1 argument
```

### Why?

`docker run` requires an **IMAGE**.

The command specified the mount but did not specify an image.

The general syntax is:

```bash
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
```

---

# ⚠️ 8. Second Attempt

I then tried:

```bash
docker run -d --mount source=yuvi,target=/app .
```

This produced:

```text
docker: invalid reference format
```

The `.` was not interpreted as a valid Docker image reference in this command.

---

# ✅ 9. Correct Docker Volume Mount

I then used the NGINX image:

```bash
docker run -d --mount source=yuvi,target=/app nginx:latest
```

Docker downloaded the NGINX image because it was not available locally.

```text
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
```

After downloading the image, Docker created the container successfully.

The command returned a container ID similar to:

```text
1a3034e8d48bd95dc5c72d9ae0fa1ce97b4a5b01ef5c055cf93e5372937f82e9
```

---

# 🔗 10. Understanding the `--mount` Option

The command:

```bash
docker run -d --mount source=yuvi,target=/app nginx:latest
```

can be understood as:

```text
--mount
   │
   ├── source=yuvi
   │       │
   │       └── Docker Volume
   │
   └── target=/app
           │
           └── Directory inside container
```

So the relationship becomes:

```text
Docker Volume
     │
     │ source=yuvi
     ▼
┌─────────────────┐
│ NGINX Container │
│                 │
│      /app       │
└─────────────────┘
       target
```

---

# 📋 11. Checking Running Containers

After starting the container, I checked the running containers:

```bash
docker ps
```

Output:

```text
CONTAINER ID   IMAGE          COMMAND                  CREATED
1a3034e8d48b   nginx:latest   "/docker-entrypoint…"   About a minute ago

STATUS              PORTS     NAMES
Up About a minute   80/tcp    confident_feistel
```

This confirmed that the NGINX container was running.

---

# 🔍 12. Inspecting the Container

I inspected the container using:

```bash
docker inspect 1a3034e8d48b
```

The inspection showed:

```json
"Mounts": [
    {
        "Type": "volume",
        "Source": "yuvi",
        "Target": "/app"
    }
]
```

This proves that the Docker volume was successfully attached to the container.

---

# 📦 13. Important `docker inspect` Output

The detailed mount information showed:

```json
"Mounts": [
    {
        "Type": "volume",
        "Name": "yuvi",
        "Source": "/var/lib/docker/volumes/yuvi/_data",
        "Destination": "/app",
        "Driver": "local",
        "Mode": "z",
        "RW": true,
        "Propagation": ""
    }
]
```

### What this means

| Property    | Value                                | Meaning                    |
| ----------- | ------------------------------------ | -------------------------- |
| Type        | `volume`                             | Docker named volume        |
| Name        | `yuvi`                               | Volume name                |
| Source      | `/var/lib/docker/volumes/yuvi/_data` | Host-side volume location  |
| Destination | `/app`                               | Container directory        |
| Driver      | `local`                              | Docker local volume driver |
| RW          | `true`                               | Container can read/write   |

---

# 🧩 14. Complete Volume Architecture

```mermaid
flowchart LR

    A[Docker Host / EC2] --> B[Docker Engine]

    B --> C[Named Volume: yuvi]

    C --> D[/var/lib/docker/volumes/yuvi/_data]

    C --> E[NGINX Container]

    E --> F[/app]

    C -. mounted into .-> F
```

---

# 📁 15. What Is a Bind Mount?

A **Bind Mount** allows you to connect a specific directory or file from the Docker host directly into a container.

Unlike a named volume:

```text
Docker Volume
    │
    └── Managed by Docker
```

A bind mount uses a path that you choose:

```text
Host Directory
      │
      ▼
Container Directory
```

Example:

```text
Host
/home/ubuntu/myapp
        │
        │ bind mount
        ▼
Container
/app
```

---

# 🔄 16. Volume vs Bind Mount

| Feature                              | Docker Volume | Bind Mount         |
| ------------------------------------ | ------------- | ------------------ |
| Managed by Docker                    | ✅ Yes         | ❌ No               |
| Uses host path directly              | ❌ No          | ✅ Yes              |
| Easy to manage                       | ✅ Yes         | ⚠️ Depends         |
| Good for persistent application data | ✅ Yes         | ✅ Yes              |
| Good for development                 | ✅ Yes         | ⭐ Very useful      |
| Host path required                   | ❌ No          | ✅ Yes              |
| Example                              | `yuvi`        | `/home/ubuntu/app` |

---

# 🐳 17. Bind Mount Syntax

A bind mount can be created using:

```bash
docker run -d \
  --mount type=bind,source=/home/ubuntu/app,target=/app \
  nginx:latest
```

Here:

```text
type=bind
    │
    ├── source=/home/ubuntu/app
    │        │
    │        └── Directory on Docker Host
    │
    └── target=/app
             │
             └── Directory inside Container
```

### Architecture

```mermaid
flowchart LR

    A[Docker Host] --> B[/home/ubuntu/app]

    B -->|Bind Mount| C[NGINX Container]

    C --> D[/app]
```

> **Note:** In the provided hands-on history and screenshots, the executed mount was a **named Docker volume** (`yuvi`). An actual `type=bind` command was not executed in this session. The bind-mount section above documents the next concept for practice.

---

# ⚔️ 18. Volume vs Bind Mount — Simple Example

### Docker Volume

```bash
docker volume create yuvi
```

Then:

```bash
docker run -d \
  --mount source=yuvi,target=/app \
  nginx:latest
```

Docker manages the storage location.

---

### Bind Mount

```bash
docker run -d \
  --mount type=bind,source=/home/ubuntu/app,target=/app \
  nginx:latest
```

You explicitly choose the host directory.

---

# 🧠 19. Commands Practiced

```bash
# Create a Docker volume
docker volume create yuvi

# List Docker volumes
docker volume ls

# Inspect a Docker volume
docker volume inspect yuvi

# Build Docker image
docker build -t volumedemo .

# Run container with named volume
docker run -d --mount source=yuvi,target=/app nginx:latest

# Check running containers
docker ps

# Inspect container
docker inspect 1a3034e8d48b
```

---

# 📝 20. Docker Command History

The terminal history from this hands-on exercise showed:

```bash
1  docker volume create yuvi
2  docker volume ls
3  docker volume inspect yuvi
4  git clone https://github.com/iam-veeramalla/Docker-Zero-to-Hero.git
5  ls
6  cd Docker-Zero-to-Hero/
7  ls
8  cd ex
9  cd examples
10 cd first-docker-file/
11 ls
12 docker build -t volumedemo .
13 docker run -d --mount source=yuvi,target=/app
14 docker run -d --mount source=yuvi,target=/app .
15 docker run -d --mount source=yuvi,target=/app nginx:latest
16 docker ps
17 docker inspect 1a3034e8d48b
18 history
```

---

# 🎯 21. What I Learned

### Docker Volumes

* A Docker volume provides persistent storage.
* Docker manages the volume.
* Volumes can survive container removal.
* `docker volume create` creates a named volume.
* `docker volume ls` lists volumes.
* `docker volume inspect` provides detailed volume information.

### `--mount`

The `--mount` option connects storage to a container.

```text
source → Where the storage comes from
target → Where the storage appears inside the container
```

Example:

```bash
--mount source=yuvi,target=/app
```

### Bind Mounts

* Bind mounts connect a specific host path to a container path.
* They are useful when the host directory itself needs to be accessed by the container.
* They are especially useful during development.

---

# 💡 22. Key Takeaways

```text
Docker Container
      │
      │ needs persistent data
      ▼
┌──────────────────────────┐
│     Persistent Storage   │
├──────────────────────────┤
│                          │
│  Docker Volume           │
│       OR                 │
│  Bind Mount              │
│                          │
└──────────────────────────┘
```

### Remember:

> **Volume = Docker manages the storage**

> **Bind Mount = You manage the host path**

---

# 🚀 23. Hands-On Result

I successfully:

* ✅ Created a Docker named volume
* ✅ Listed the volume
* ✅ Inspected the volume
* ✅ Built the `volumedemo` image
* ✅ Practiced the `--mount` syntax
* ✅ Troubleshot incorrect `docker run` commands
* ✅ Pulled the NGINX image
* ✅ Started an NGINX container
* ✅ Verified the running container using `docker ps`
* ✅ Verified the volume mount using `docker inspect`
* ✅ Confirmed `yuvi` → `/app` volume mapping
* 📚 Learned the concept of bind mounts

---

<p align="center">

## 🐳 Docker Storage Practice Complete

### Volumes → Mounts → Container Storage → Bind Mounts

</p>

<p align="center">

# 🎯 DOCKER VOLUMES & BIND MOUNTS COMPLETE

</p>
