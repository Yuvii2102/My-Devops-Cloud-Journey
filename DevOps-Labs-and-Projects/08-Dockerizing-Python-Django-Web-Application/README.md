<p align="center">

# 🐳 Containerizing a Python Django Web Application

### AWS EC2 • Docker • Python • Django • Dockerfile • Containers • Port Mapping • Security Groups

</p>

---

# 📌 Project Overview

In this hands-on project, I containerized a **Python Django Web Application** using **Docker** and ran it on an **AWS EC2 instance**.

The Django project was available inside the `Docker-Zero-to-Hero` repository.

The complete flow was:

    Django Application
            ↓
        Dockerfile
            ↓
       Docker Build
            ↓
       Docker Image
            ↓
      Docker Container
            ↓
         Port 8000
            ↓
       AWS EC2 Instance
            ↓
      Security Group :8000
            ↓
        Web Browser
            ↓
       /demo/ endpoint
            ↓
      Django Application

---

# 🎯 Objective

The objective of this project was to understand how to:

- Containerize a Django application
- Create a Dockerfile
- Install Python inside a Docker image
- Create a Python virtual environment inside the image
- Install Django dependencies
- Build a Docker image
- Run the Docker image as a container
- Map port `8000`
- Configure the AWS EC2 Security Group
- Access the Django application from a web browser
- Understand the difference between the EC2 host and Docker container
- Troubleshoot Docker, networking and Django URL issues

---

# ☁️ Environment Used

| Component | Details |
|---|---|
| Cloud | AWS |
| Server | EC2 |
| Operating System | Ubuntu |
| Containerization | Docker |
| Application | Python Django |
| Application Port | 8000 |
| Docker Image | django-app:latest |
| Container Port | 8000 |
| Host Port | 8000 |

---

# 📂 Step 1 — Navigate to the Django Project

The Django project was located inside:

    ~/Docker-Zero-to-Hero/examples/python-web-app

Command:

    cd ~/Docker-Zero-to-Hero/examples/python-web-app

Check the current directory:

    pwd

Output:

    /home/ubuntu/Docker-Zero-to-Hero/examples/python-web-app

Check the project files:

    ls -la

Output:

    total 20
    drwxrwxr-x 3 ubuntu ubuntu 4096 Aug 18 13:33 .
    drwxrwxr-x 5 ubuntu ubuntu 4096 Aug 18 13:33 ..
    -rw-rw-r-- 1 ubuntu ubuntu  377 Aug 18 13:33 Dockerfile
    drwxrwxr-x 4 ubuntu ubuntu 4096 Aug 18 13:33 devops
    -rw-rw-r-- 1 ubuntu ubuntu   14 Aug 18 13:33 requirements.txt

The project structure was:

    python-web-app/
    │
    ├── Dockerfile
    ├── requirements.txt
    │
    └── devops/
        ├── manage.py
        ├── db.sqlite3
        │
        ├── devops/
        │   ├── settings.py
        │   ├── urls.py
        │   ├── asgi.py
        │   ├── wsgi.py
        │   └── __init__.py
        │
        └── demo/
            ├── tests.py
            ├── apps.py
            ├── urls.py
            ├── views.py
            ├── admin.py
            ├── models.py
            └── __init__.py

---

# 🐍 Step 2 — Check requirements.txt

Command:

    cat requirements.txt

The file contained:

    Django
    tzdata

`requirements.txt` contains the Python packages required by the Django application.

---

# 🐳 Step 3 — Check the Dockerfile

Command:

    cat Dockerfile

Dockerfile used:

    FROM ubuntu

    WORKDIR /app

    COPY requirements.txt /app/
    COPY devops /app/

    RUN apt-get update && apt-get install -y python3 python3-pip python3-venv

    SHELL ["/bin/bash", "-c"]

    RUN python3 -m venv venv1 && \
    source venv1/bin/activate && \
    pip install --no-cache-dir -r requirements.txt

    EXPOSE 8000

    CMD source venv1/bin/activate && python3 manage.py runserver 0.0.0.0:8000

---

# 🧠 Dockerfile Explanation

### FROM ubuntu

    FROM ubuntu

Uses Ubuntu as the base image.

### WORKDIR

    WORKDIR /app

Sets `/app` as the working directory inside the container.

### COPY requirements.txt

    COPY requirements.txt /app/

Copies the Python dependency file into the image.

### COPY devops

    COPY devops /app/

Copies the Django application into the Docker image.

### Install Python

    RUN apt-get update && apt-get install -y python3 python3-pip python3-venv

Installs:

- Python 3
- pip
- Python virtual environment support

### SHELL

    SHELL ["/bin/bash", "-c"]

Uses Bash for the following commands.

This allows the Dockerfile to use `source`.

### Create virtual environment

    RUN python3 -m venv venv1 && \
    source venv1/bin/activate && \
    pip install --no-cache-dir -r requirements.txt

This:

1. Creates a virtual environment called `venv1`
2. Activates the virtual environment
3. Installs Django and `tzdata`

### EXPOSE

    EXPOSE 8000

Documents that the Django application uses port `8000`.

### CMD

    CMD source venv1/bin/activate && python3 manage.py runserver 0.0.0.0:8000

Starts the Django development server on port `8000`.

The important part is:

    0.0.0.0:8000

`0.0.0.0` allows Django to listen on all network interfaces inside the container.

---

# ⚠️ Step 4 — Docker Permission Problem

Initially, while trying to build the image, this command was used:

    docker build .

The error was:

    DEPRECATED: The legacy builder is deprecated and will be removed in a future release.

    permission denied while trying to connect to the Docker API at
    unix:///var/run/docker.sock

This meant that the Ubuntu user did not have permission to communicate with the Docker daemon.

After resolving the Docker permission issue, Docker commands worked successfully.

---

# 🏗️ Step 5 — Build the Docker Image

From inside:

    ~/Docker-Zero-to-Hero/examples/python-web-app

the image was built using:

    docker build -t django-app .

The build completed successfully.

Important output:

    Successfully built 99a99b69fcaa
    Successfully tagged django-app:latest

Therefore:

    Image Name : django-app
    Tag        : latest
    Image ID   : 99a99b69fcaa

---

# 🆔 Step 6 — Find the Docker Image ID

Command:

    docker images

Output:

    IMAGE               ID             DISK USAGE   CONTENT SIZE   EXTRA
    django-app:latest   99a99b69fcaa        411MB          109MB
    ubuntu:latest       678c6550cc43        160MB           45.3MB

The Docker image ID was:

    99a99b69fcaa

The image could therefore be run using either the image name or image ID.

Using the image name:

    docker run -p 8000:8000 -it django-app

Using the image ID:

    docker run -p 8000:8000 -it 99a99b69fcaa

---

# 🚀 Step 7 — Run the Docker Container

The command actually used was:

    docker run -p 8000:8000 -it django-app

Explanation:

    docker run
        ↓
    Creates and starts a container

    -p 8000:8000
        ↓
    Maps host port 8000 to container port 8000

    -it
        ↓
    Runs the container interactively

    django-app
        ↓
    Docker image being used

The port mapping was:

    EC2 Host Port 8000
            ↓
    Docker Container Port 8000
            ↓
    Django Server

---

# ✅ Step 8 — Django Started Successfully

After starting the container, Django displayed:

    Watching for file changes with StatReloader
    Performing system checks...

    System check identified no issues (0 silenced).

    You have 18 unapplied migration(s). Your project may not work properly until you apply the migrations for app(s): admin, auth, contenttypes, sessions.
    Run 'python manage.py migrate' to apply them.

    August 18, 2026 - 14:37:41
    Django version 6.1, using settings 'devops.settings'
    Starting WSGI development server at http://0.0.0.0:8000/
    Quit the server with CONTROL-C.

This confirmed that the Django application was successfully running inside the Docker container.

---

# ⚠️ Django Migration Warning

Django showed:

    You have 18 unapplied migration(s).

This was a warning and not a Docker failure.

Django suggested:

    python manage.py migrate

The application was still able to start successfully for this hands-on test.

---

# 🌐 Step 9 — First Browser Test

The EC2 public IP was opened in the browser using:

    http://<EC2-PUBLIC-IP>:8000

Initially, the browser showed:

    This site can't be reached

and:

    ERR_CONNECTION_TIMED_OUT

This meant that the application was not yet reachable from the Internet.

---

# 🔐 Step 10 — Configure the AWS Security Group

The EC2 instance was using an AWS Security Group.

An inbound rule was required for Django:

    Type     : Custom TCP
    Port     : 8000
    Source   : 0.0.0.0/0

This allows incoming TCP traffic on port `8000`.

The network flow became:

    Internet
        ↓
    TCP Port 8000
        ↓
    AWS Security Group
        ↓
    EC2 Instance
        ↓
    Docker Host Port 8000
        ↓
    Docker Container Port 8000
        ↓
    Django

---

# ❌ Step 11 — Django 404 Error

After fixing the network access, the browser successfully reached Django.

However, opening:

    http://<EC2-PUBLIC-IP>:8000/

displayed:

    Page not found (404)

Django showed:

    Request Method: GET
    Request URL: http://<EC2-PUBLIC-IP>:8000/

It also showed the available URL patterns:

    1. demo/
    2. admin/ [name='admin']

This proved that:

    Docker was working
    ↓
    EC2 networking was working
    ↓
    Security Group was working
    ↓
    Django was working

The problem was only that the root `/` URL was not defined.

---

# 🔎 Step 12 — Find the Correct Django Endpoint

The application had the URL pattern:

    demo/

Therefore this URL:

    http://<EC2-PUBLIC-IP>:8000/

was not the correct application endpoint.

The correct endpoint was:

    http://<EC2-PUBLIC-IP>:8000/demo/

---

# 🎉 Step 13 — Final Successful Result

The browser was opened at:

    http://<EC2-PUBLIC-IP>:8000/demo/

The Django application successfully loaded.

The final page displayed:

    Free DevOps Course By Abhishek

and:

    Agenda

    Learn DevOps with strong foundational knowledge and practical understanding

    Please Share the Channel with your friends and colleagues

This confirmed that the Django application was successfully containerized and accessed through the AWS EC2 public IP.

---

# 🏆 Final Architecture

    🌐 Web Browser
            │
            │ HTTP :8000
            ▼
    ┌───────────────────────┐
    │   AWS Security Group  │
    │                       │
    │   TCP 8000 → ALLOW    │
    └───────────┬───────────┘
                │
                ▼
    ┌───────────────────────┐
    │       AWS EC2         │
    │                       │
    │    Public IP          │
    │       :8000           │
    └───────────┬───────────┘
                │
                │ Docker Port Mapping
                │ 8000:8000
                ▼
    ┌───────────────────────┐
    │    Docker Container   │
    │                       │
    │        /app           │
    │         │             │
    │   Python + Django     │
    │         │             │
    │       :8000           │
    └───────────┬───────────┘
                │
                ▼
        Django Application
                │
                ▼
              /demo/

---

# 🔄 Complete Project Flow

    Django Source Code
            ↓
        Dockerfile
            ↓
    docker build -t django-app .
            ↓
       Docker Image
      django-app:latest
            ↓
    docker run -p 8000:8000 -it django-app
            ↓
      Docker Container
            ↓
    Django Server 0.0.0.0:8000
            ↓
       AWS EC2 :8000
            ↓
    Security Group :8000
            ↓
        Web Browser
            ↓
          /demo/
            ↓
    Django Web Application

---

# 🧾 Complete Commands Used

### Navigate to the project

    cd ~/Docker-Zero-to-Hero/examples/python-web-app

### Check current directory

    pwd

### List files

    ls -la

### Check Dockerfile

    cat Dockerfile

### Check requirements

    cat requirements.txt

### Check Django project files

    find devops -maxdepth 2 -type f

### Build Docker image

    docker build -t django-app .

### List Docker images

    docker images

### Run using image name

    docker run -p 8000:8000 -it django-app

### Run using image ID

    docker run -p 8000:8000 -it 99a99b69fcaa

### Django migration command

    python manage.py migrate

### Browser test

    http://<EC2-PUBLIC-IP>:8000/

### Final working URL

    http://<EC2-PUBLIC-IP>:8000/demo/

---

# 🧩 Important Concepts Learned

| Concept | Meaning |
|---|---|
| Dockerfile | Instructions used to build a Docker image |
| Docker Image | Read-only template used to create containers |
| Docker Container | Running instance of a Docker image |
| `docker build` | Builds a Docker image |
| `docker images` | Lists Docker images |
| `docker run` | Creates and starts a container |
| `-p 8000:8000` | Maps host port 8000 to container port 8000 |
| `EXPOSE 8000` | Documents the application's container port |
| `WORKDIR /app` | Sets the working directory inside the container |
| `COPY` | Copies files into the Docker image |
| `RUN` | Executes commands during image building |
| `CMD` | Command executed when the container starts |
| `0.0.0.0` | Allows Django to listen on all container interfaces |
| Security Group | Controls network access to EC2 |
| EC2 Public IP | Used to access the application externally |
| `/demo/` | Actual Django application endpoint |

---

# 🆚 EC2 Host vs Docker Container

One important concept learned was that the EC2 host and Docker container have different filesystem environments.

The project existed on the EC2 host at:

    /home/ubuntu/Docker-Zero-to-Hero/examples/python-web-app

When the Docker image was built, the Django application was copied into:

    /app

inside the Docker image/container.

Therefore, when inside the container, running:

    cd ~/Docker-Zero-to-Hero/examples/python-web-app

resulted in:

    bash: cd: /root/Docker-Zero-to-Hero/examples/python-web-app: No such file or directory

This happened because the EC2 host directory does not automatically exist inside the container.

The concept is:

    EC2 HOST
        │
        │ docker build
        ▼
    Docker IMAGE
        │
        │ docker run
        ▼
    Docker CONTAINER
        │
        ▼
       /app

The container has its own filesystem environment.

---

# 🐳 What Docker Did for the Django Application

Before containerization:

    EC2
     │
     ├── Python
     ├── pip
     ├── Virtual Environment
     ├── Django
     ├── Dependencies
     └── Django Application

After containerization:

    Docker Image
     │
     ├── Ubuntu
     ├── Python
     ├── pip
     ├── Virtual Environment
     ├── Django
     ├── Dependencies
     └── Django Application
             │
             ▼
         Container

Docker packaged the Django application's environment and dependencies into a Docker image and then ran that image as a container.

---

# 🔥 Troubleshooting

| Problem | What Happened | Solution |
|---|---|---|
| Docker permission denied | Ubuntu user could not access Docker daemon | Resolved Docker permission issue |
| Browser timeout | Port 8000 was not reachable externally | Added TCP port 8000 to EC2 Security Group |
| Django 404 | Root `/` route was not defined | Opened `/demo/` |
| Container path not found | EC2 host path was not available inside container | Understood host/container filesystem separation |
| Migration warning | Django had unapplied migrations | Django suggested `python manage.py migrate` |

---

# 🧠 Most Important Learning

The complete request path was:

    Browser
        ↓
    http://<EC2-PUBLIC-IP>:8000/demo/
        ↓
    AWS EC2
        ↓
    Security Group allows TCP 8000
        ↓
    EC2 Port 8000
        ↓
    Docker Port Mapping
        ↓
    Container Port 8000
        ↓
    Django
        ↓
    /demo/
        ↓
    Django Web Application

The most important Docker command was:

    docker run -p 8000:8000 -it django-app

The Django server was started using:

    python3 manage.py runserver 0.0.0.0:8000

The final working browser endpoint was:

    http://<EC2-PUBLIC-IP>:8000/demo/

---

# 📌 Final Project Status

    ✅ Django Application
            ↓
    ✅ Dockerfile Created
            ↓
    ✅ requirements.txt Configured
            ↓
    ✅ Python Installed Inside Image
            ↓
    ✅ Python Virtual Environment Created
            ↓
    ✅ Django Dependencies Installed
            ↓
    ✅ Docker Image Built
            ↓
    ✅ Image Tagged: django-app:latest
            ↓
    ✅ Container Started
            ↓
    ✅ Port 8000 Mapped
            ↓
    ✅ AWS Security Group Configured
            ↓
    ✅ EC2 Network Access Working
            ↓
    ✅ Django Application Reached
            ↓
    ✅ /demo/ Endpoint Opened
            ↓
    🎉 Django Application Successfully Containerized

---

# 🏁 Key Takeaways

### 1. Dockerfile

A Dockerfile defines how a Docker image is created.

### 2. Docker Image

A Docker image is a template containing the application and its required environment.

### 3. Docker Container

A Docker container is a running instance of a Docker image.

### 4. Port Mapping

    -p 8000:8000

means:

    Host Port 8000
          ↓
    Container Port 8000

### 5. 0.0.0.0

Django was configured to listen on:

    0.0.0.0:8000

so that it could receive connections through the container network.

### 6. AWS Security Group

Port `8000` had to be allowed in the EC2 Security Group for external browser access.

### 7. Django URL

The root URL:

    /

returned `404` because no root URL was configured.

The actual application endpoint was:

    /demo/

---

# 🎯 Final Result

The **Python Django Web Application was successfully containerized using Docker and deployed on an AWS EC2 instance**.

The complete final flow was:

    Python Django Application
            ↓
        Dockerfile
            ↓
       Docker Build
            ↓
       Docker Image
            ↓
      Docker Container
            ↓
         Port 8000
            ↓
       AWS EC2 Instance
            ↓
      Security Group :8000
            ↓
        Web Browser
            ↓
          /demo/
            ↓
    🎉 Django Application Working

---

<p align="center">

# 🐳 DJANGO CONTAINERIZATION COMPLETE 🚀

### AWS EC2 + Docker + Python + Django

</p>
