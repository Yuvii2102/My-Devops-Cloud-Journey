<div align="center">

# 🐳 Docker – Running My First Container

### 🚀 My First Docker Hands-On Lab

<img src="https://img.shields.io/badge/Docker-Container-blue?style=for-the-badge&logo=docker" />
<img src="https://img.shields.io/badge/AWS-EC2-orange?style=for-the-badge&logo=amazonaws" />
<img src="https://img.shields.io/badge/Ubuntu-Linux-E95420?style=for-the-badge&logo=ubuntu" />
<img src="https://img.shields.io/badge/Docker%20Hub-Push%20%26%20Pull-2496ED?style=for-the-badge&logo=docker" />

</div>

---

## 📌 Overview

In this hands-on lab, I installed Docker on an Ubuntu EC2 instance, verified the Docker service, cloned a Docker learning repository, created and edited a Dockerfile, built my first Docker image, ran a container, logged in to Docker Hub, pushed the image, pulled it back, ran it again, and finally tagged and pushed the image to my own Docker Hub account.

The application used in this lab is a simple Python program:

```python
print("Hello World")
```

The Docker project was cloned from the `Docker-Zero-to-Hero` repository and the example used was `examples/first-docker-file`.

---

# 🏗️ Docker Hands-On Flow

```text
Ubuntu EC2
    │
    ▼
Install Docker
    │
    ▼
Verify Docker Service
    │
    ▼
Run hello-world Container
    │
    ▼
Clone Docker Repository
    │
    ▼
Create / Edit Dockerfile
    │
    ▼
Build Docker Image
    │
    ▼
Run My First Container
    │
    ▼
Docker Login
    │
    ▼
Push Image to Docker Hub
    │
    ▼
Pull Image from Docker Hub
    │
    ▼
Run Pulled Image
    │
    ▼
Tag Image with My Docker Hub Username
    │
    ▼
Push to My Docker Hub Repository
```

---

# 1️⃣ Update Ubuntu Packages

First, I updated the Ubuntu package lists.

```bash
sudo apt update
```

This ensures the system has the latest available package information.

---

# 2️⃣ Install Docker

Docker was installed using:

```bash
sudo apt install docker.io -y
```

The `-y` option automatically confirms the installation.

---

# 3️⃣ Check Docker Service

I checked whether the Docker service was running:

```bash
sudo systemctl status docker
```

This helps verify the Docker daemon status.

---

# 4️⃣ Start Docker Service

Docker was started using:

```bash
sudo systemctl start docker
```

---

# 5️⃣ Test Docker Installation

I tested Docker using the official `hello-world` image:

```bash
docker run hello-world
```

This verifies that Docker can download an image and create a container.

---

# 6️⃣ Add Ubuntu User to Docker Group

To run Docker commands without repeatedly using `sudo`, I added the `ubuntu` user to the Docker group:

```bash
sudo usermod -aG docker ubuntu
```

---

# 7️⃣ Logout

The group membership needs to be refreshed, so I logged out:

```bash
logout
```

After reconnecting to the EC2 instance, Docker commands could be used directly.

---

# 8️⃣ Check Current Directory

After reconnecting:

```bash
pwd
```

Output:

```text
/home/ubuntu
```

---

# 9️⃣ List Files and Directories

```bash
ls
```

---

# 🔟 Clone Docker-Zero-to-Hero Repository

https://github.com/iam-veeramalla/Docker-Zero-to-Hero

I cloned the Docker learning repository:

```bash
git clone https://github.com/iam-veeramalla/Docker-Zero-to-Hero.git
```

The repository was successfully cloned into:

```text
Docker-Zero-to-Hero
```

The cloned repository contains:

```text
README.md
commands.md
examples
networking.md
volumes.md
```

---

# 1️⃣1️⃣ Verify Current Directory

```bash
pwd
```

---

# 1️⃣2️⃣ List Repository

```bash
ls
```

Expected directory:

```text
Docker-Zero-to-Hero
```

---

# 1️⃣3️⃣ Enter Docker Repository

```bash
cd Docker-Zero-to-Hero/
```

---

# 1️⃣4️⃣ List Repository Contents

```bash
ls
```

Output:

```text
README.md
commands.md
examples
networking.md
volumes.md
```

---

# 1️⃣5️⃣ Enter Examples Directory

```bash
cd examples
```

---

# 1️⃣6️⃣ List Examples

```bash
ls
```

Output:

```text
first-docker-file
golang-multi-stage-docker-build
python-web-app
```

---

# 1️⃣7️⃣ Enter First Docker File Example

```bash
cd first-docker-file/
```

---

# 1️⃣8️⃣ Check Files

```bash
ls
```

Files:

```text
Dockerfile
app.py
```

---

# 1️⃣9️⃣ Check Python Application

I viewed the Python application:

```bash
cat app.py
```

Content:

```python
print("Hello World")
```

---

# 2️⃣0️⃣ Check Files Again

```bash
ls
```

Output:

```text
Dockerfile
app.py
```

---

# 2️⃣1️⃣ Incorrect Directory Command

I initially tried:

```bash
cd ~examples
```

This produced:

```text
-bash: cd: ~examples: No such file or directory
```

The issue was that `~` represents the home directory. It does not mean "go to the examples folder."

---

# 2️⃣2️⃣ Move One Directory Back

I corrected the navigation using:

```bash
cd ..
```

This took me back to:

```text
/home/ubuntu/Docker-Zero-to-Hero/examples
```

---

# 2️⃣3️⃣ Verify Location

```bash
pwd
```

Output:

```text
/home/ubuntu/Docker-Zero-to-Hero/examples
```

---

# 2️⃣4️⃣ List Directories

```bash
ls
```

Output:

```text
first-docker-file
golang-multi-stage-docker-build
python-web-app
```

---

# 2️⃣5️⃣ Return to First Docker Example

```bash
cd first-docker-file/
```

---

# 2️⃣6️⃣ List Files

```bash
ls
```

Output:

```text
Dockerfile
app.py
```

---

# 2️⃣7️⃣ Incorrectly Tried to Enter Dockerfile

I initially ran:

```bash
cd Dockerfile
```

This produced:

```text
-bash: cd: Dockerfile: Not a directory
```

A `Dockerfile` is a **file**, not a directory, so `cd` cannot be used on it.

---

# 2️⃣8️⃣ Open Dockerfile in Vim

I opened the Dockerfile using:

```bash
vim Dockerfile
```

The Dockerfile was edited using Vim.

The build later showed the Dockerfile instructions being executed:

```dockerfile
FROM ubuntu:latest
WORKDIR /app
COPY . /app
RUN apt-get update && apt-get install -y python3 python3-pip
ENV NAME World
CMD ["python3", "app.py"]
```

## The Docker build output confirms these six instructions were processed successfully.

# 2️⃣9️⃣ First Docker Build Attempt

I first tried:

```bash
docker build -t abhsihekf5/my-first-docker-image:latest
```

This failed because Docker requires a build context.

Error:

```text
docker: 'docker build' requires 1 argument
```

The Docker command syntax requires a path, URL, or `-`.

---

# 3️⃣0️⃣ Correct Docker Build Command

I corrected it by adding `.` at the end:

```bash
docker build -t abhsihekf5/my-first-docker-image:latest .
```

The `.` means:

```text
Current directory
```

Docker then successfully built the image.

The build completed with:

```text
Successfully built fbc9c71b9288
Successfully tagged abhsihekf5/my-first-docker-image:latest
```

---

# 🐳 What Happens During `docker build`

```text
Dockerfile
    │
    ├── FROM ubuntu:latest
    ├── WORKDIR /app
    ├── COPY . /app
    ├── RUN apt-get update && apt-get install -y python3 python3-pip
    ├── ENV NAME World
    └── CMD ["python3", "app.py"]
             │
             ▼
        Docker Image
```

---

# 3️⃣1️⃣ Run My First Docker Container

I ran:

```bash
docker run -it abhishekf5/my-first-docker-image
```

Because the image was available on Docker Hub under this name, Docker pulled it when it was not available locally.

The output showed:

```text
Unable to find image 'abhishekf5/my-first-docker-image:latest' locally
```

Then Docker downloaded the image layers.

Finally:

```text
Hello World
```

was displayed.

---

# 3️⃣2️⃣ Login to Docker Hub

I logged in using:

```bash
docker login
```

Docker provided a web-based login flow and authentication succeeded:

```text
Login Succeeded
```

---

# 3️⃣3️⃣ Push Docker Image to Docker Hub

I pushed the image using:

```bash
docker push abhishekf5/my-first-docker-image
```

Docker automatically used the `latest` tag.

```text
The push refers to repository [docker.io/abhishekf5/my-first-docker-image]
```

The push completed successfully.

---

# 3️⃣4️⃣ Push Image with Explicit `latest` Tag

I also used:

```bash
docker push abhishekf5/my-first-docker-image:latest
```

The image was successfully pushed again.

```text
latest: digest: sha256:5d937d6b494b7990f06819c02f98c68badd109e5b31ee56451753bf5934f0447
```

---

# 3️⃣5️⃣ Pull Image from Docker Hub

I pulled the image using:

```bash
docker pull abhishekf5/my-first-docker-image:latest
```

Docker confirmed:

```text
Status: Image is up to date for abhishekf5/my-first-docker-image:latest
```

---

# 3️⃣6️⃣ Run Pulled Image

I then ran:

```bash
docker run abhishekf5/my-first-docker-image:latest
```

Output:

```text
Hello World
```

This confirmed that the Docker image could be pulled from Docker Hub and successfully executed as a container.

---

# 3️⃣7️⃣ View Docker Images

I checked all local Docker images using:

```bash
docker images
```

The output included:

```text
abhishekf5/my-first-docker-image:latest
abhsihekf5/my-first-docker-image:latest
hello-world:latest
ubuntu:latest
```

---

# 3️⃣8️⃣ Tag Image with My Docker Hub Username

My Docker Hub username is:

```text
yuvi2102
```

So I created a new tag:

```bash
docker tag abhishekf5/my-first-docker-image:latest yuvi2102/my-first-docker-image:latest
```

This changed the image reference to my own Docker Hub namespace.

---

# 3️⃣9️⃣ Push Image to My Docker Hub Repository

I pushed the newly tagged image:

```bash
docker push yuvi2102/my-first-docker-image:latest
```

Docker reported:

```text
The push refers to repository [docker.io/yuvi2102/my-first-docker-image]
```

The layers were mounted from the existing repository:

```text
Mounted from abhishekf5/my-first-docker-image
```

The final image was successfully pushed with the `latest` tag.

---

# 🧠 Important Docker Commands Learned

| Command                          | Purpose                      |
| -------------------------------- | ---------------------------- |
| `sudo apt update`                | Update package information   |
| `sudo apt install docker.io -y`  | Install Docker               |
| `sudo systemctl status docker`   | Check Docker service         |
| `sudo systemctl start docker`    | Start Docker service         |
| `docker run hello-world`         | Test Docker                  |
| `sudo usermod -aG docker ubuntu` | Add user to Docker group     |
| `pwd`                            | Show current directory       |
| `ls`                             | List files and directories   |
| `git clone`                      | Clone Git repository         |
| `cd`                             | Change directory             |
| `cat`                            | Display file contents        |
| `vim`                            | Edit a file                  |
| `docker build`                   | Build an image               |
| `docker run`                     | Create and run a container   |
| `docker login`                   | Login to Docker Hub          |
| `docker push`                    | Push image to registry       |
| `docker pull`                    | Download image from registry |
| `docker images`                  | List local images            |
| `docker tag`                     | Create another image tag     |

---

# 🧩 Docker Image vs Container

```text
              Dockerfile
                  │
                  ▼
          docker build
                  │
                  ▼
             Docker Image
                  │
             docker run
                  │
                  ▼
             Container
```

### Docker Image

A Docker image is the packaged application environment used to create containers.

### Docker Container

A container is a running instance created from a Docker image.

In this lab:

```text
Image:
abhishekf5/my-first-docker-image:latest
```

and later:

```text
yuvi2102/my-first-docker-image:latest
```

---

# 🌍 Docker Hub Flow

```text
Local Docker Image
       │
       │ docker push
       ▼
   Docker Hub
       │
       │ docker pull
       ▼
 Local Docker Image
       │
       │ docker run
       ▼
     Container
```

---

# 🔍 Problems I Encountered and Fixed

## ❌ Problem 1 – Wrong `cd` Command

Command:

```bash
cd ~examples
```

Error:

```text
-bash: cd: ~examples: No such file or directory
```

### ✅ Fix

```bash
cd ..
```

---

## ❌ Problem 2 – Trying to `cd` into Dockerfile

Command:

```bash
cd Dockerfile
```

Error:

```text
-bash: cd: Dockerfile: Not a directory
```

### ✅ Fix

Use:

```bash
vim Dockerfile
```

or:

```bash
cat Dockerfile
```

---

## ❌ Problem 3 – Missing Docker Build Context

Command:

```bash
docker build -t abhsihekf5/my-first-docker-image:latest
```

Error:

```text
docker: 'docker build' requires 1 argument
```

### ✅ Fix

```bash
docker build -t abhsihekf5/my-first-docker-image:latest .
```

The `.` specifies the current directory as the build context.

---

# 🎯 Final Working Architecture

```text
                    AWS EC2
                       │
                       ▼
                    Ubuntu
                       │
                       ▼
                  Docker Engine
                       │
                       ▼
                 Dockerfile
                       │
                       ▼
              docker build
                       │
                       ▼
             Docker Image
                       │
          ┌────────────┴────────────┐
          ▼                         ▼
      docker run                docker push
          │                         │
          ▼                         ▼
      Container                Docker Hub
          │                         │
          ▼                         ▼
     Hello World              yuvi2102/
                              my-first-docker-image
                                      │
                                      ▼
                                 docker pull
                                      │
                                      ▼
                               docker run
                                      │
                                      ▼
                                Hello World
```

---

# ✅ What I Successfully Completed

* ✅ Installed Docker on Ubuntu EC2
* ✅ Started and verified Docker
* ✅ Tested Docker with `hello-world`
* ✅ Added the Ubuntu user to the Docker group
* ✅ Cloned the Docker-Zero-to-Hero repository
* ✅ Navigated through the Docker example
* ✅ Inspected `app.py`
* ✅ Edited the Dockerfile
* ✅ Built my first Docker image
* ✅ Fixed the missing Docker build context issue
* ✅ Ran my first Docker container
* ✅ Logged in to Docker Hub
* ✅ Pushed an image to Docker Hub
* ✅ Pulled the image from Docker Hub
* ✅ Ran the pulled image
* ✅ Listed local Docker images
* ✅ Tagged the image with my Docker Hub username
* ✅ Pushed the final image to my Docker Hub repository

---

# 🏁 Final Result

My first Docker application successfully produced:

```text
Hello World
```

The complete journey was:

```text
Install Docker
      ↓
Create Dockerfile
      ↓
Build Image
      ↓
Run Container
      ↓
Login to Docker Hub
      ↓
Push Image
      ↓
Pull Image
      ↓
Run Image
      ↓
Tag Image
      ↓
Push to My Docker Hub
```

<div align="center">

## 🐳 MY FIRST DOCKER CONTAINER COMPLETE 🚀

### `yuvi2102/my-first-docker-image:latest`

</div>
