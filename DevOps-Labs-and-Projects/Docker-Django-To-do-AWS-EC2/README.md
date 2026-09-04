# Dockerized Django Todo Application Deployment on AWS EC2

## 📌 Practical Overview

In this practical, I deployed a Django Todo application from GitHub on an AWS EC2 instance using Docker.

The application was:

1. Cloned from GitHub
2. Inspected and prepared for Docker
3. Built into a Docker image
4. Troubleshooted when the first Docker build failed
5. Fixed by changing the Python base image
6. Built successfully
7. Started as a Docker container
8. Tested from inside EC2
9. Verified using Docker logs
10. Exposed through EC2 port `8000`
11. Allowed through the AWS Security Group
12. Accessed from a web browser

The final result was the Django Todo website running from a Docker container on AWS EC2.

---

# 🏗️ Final Architecture

    GitHub
       │
       │ git clone
       ▼
    AWS EC2
       │
       │ docker build
       ▼
    Docker Image
    django-todo:latest
       │
       │ docker run
       │ -p 8000:8000
       ▼
    Docker Container
       │
       ▼
    Django Application
       │
       ▼
    EC2 Port 8000
       │
       ▼
    AWS Security Group
       │
       │ TCP 8000 allowed
       ▼
    Internet
       │
       ▼
    Web Browser
       │
       ▼
    Django Todo Website

---

# 1. 🎯 Objective

The objective of this practical was to deploy a Django Todo application using Docker on an AWS EC2 instance and expose it so that it could be accessed from a browser.

The target was:

    http://EC2-PUBLIC-IP:8000

The Django application redirects the root URL `/` to `/todos/`.

Therefore, the final application URL becomes:

    http://EC2-PUBLIC-IP:8000/todos/

---

# 2. 📦 Project Used

GitHub repository:

    https://github.com/iam-veeramalla/Jenkins-Zero-To-Hero.git

Application directory:

    python-jenkins-argocd-k8s

The project contained files such as:

    python-jenkins-argocd-k8s/
    │
    ├── deploy/
    ├── staticfiles/
    ├── todoApp/
    ├── todos/
    ├── Dockerfile
    ├── Jenkinsfile
    ├── README.md
    ├── db.sqlite3
    ├── docker-compose.yml
    └── manage.py

Important:

Although this repository contains a `Jenkinsfile`, Jenkins was NOT used for this practical.

This practical was performed directly using Docker commands on the AWS EC2 instance.

---

# 3. ☁️ Connect to AWS EC2

I connected to my AWS EC2 instance.

The terminal prompt looked similar to:

    jenkins@ip-172-31-69-255:~$

The EC2 instance was used as the Docker host.

---

# 4. 📥 Clone the Repository

I cloned the GitHub repository using:

    git clone https://github.com/iam-veeramalla/Jenkins-Zero-To-Hero.git

This downloaded the complete project to the EC2 instance.

---

# 5. 📂 Enter the Project Directory

After cloning the repository:

    cd Jenkins-Zero-To-Hero/python-jenkins-argocd-k8s

Now the terminal was inside the Django application directory.

---

# 6. 🔍 Check the Project Files

I checked the files using:

    ls

Important files found:

    Dockerfile
    manage.py
    db.sqlite3
    todoApp/
    todos/
    Jenkinsfile
    docker-compose.yml
    README.md

The most important files for this Docker deployment were:

    Dockerfile
    manage.py
    db.sqlite3
    todoApp/
    todos/

---

# 7. 🐳 Inspect the Dockerfile

The original Dockerfile was:

    FROM python:3

    RUN pip install django==3.2

    COPY . .

    RUN python manage.py migrate

    EXPOSE 8000

    CMD ["python","manage.py","runserver","0.0.0.0:8000"]

### Dockerfile Explanation

`FROM`:

    FROM python:3

Defines the base Python image.

`RUN`:

    RUN pip install django==3.2

Installs Django 3.2.

`COPY`:

    COPY . .

Copies the project files into the Docker image.

Migration:

    RUN python manage.py migrate

Runs Django database migrations during image creation.

`EXPOSE`:

    EXPOSE 8000

Documents that the application uses port 8000.

`CMD`:

    CMD ["python","manage.py","runserver","0.0.0.0:8000"]

Starts the Django application on port 8000.

---

# 8. 🔨 First Docker Build Attempt

I attempted to build the Docker image using:

    docker build -t django-todo .

Docker started building the image.

The installation of Django was successful:

    Successfully installed asgiref-3.12.1 django-3.2 pytz-2026.3.post1 sqlparse-0.6.0

Docker then reached:

    Step 4/6 : RUN python manage.py migrate

But the build failed.

---

# 9. ❌ Docker Build Error

The important error was:

    ModuleNotFoundError: No module named 'distutils'

The traceback showed:

    File "/usr/local/lib/python3.14/site-packages/django/__init__.py"

This indicated that the `python:3` image was pulling a newer Python version.

The application uses:

    Django 3.2

Django 3.2 was not compatible with that newer Python environment because it expected the old `distutils` module.

---

# 10. 🧠 Understanding the Problem

The problem was not Docker itself.

The problem was:

    Python Version
           +
    Django 3.2
           =
    Compatibility Issue

The Dockerfile used:

    FROM python:3

The `python:3` tag can point to a newer Python release.

For this older Django application, it was better to explicitly specify a compatible Python version.

---

# 11. 🛠️ Fix the Dockerfile

I opened the Dockerfile:

    vim Dockerfile

I changed:

    FROM python:3

to:

    FROM python:3.10

The final Dockerfile became:

    FROM python:3.10

    RUN pip install django==3.2

    COPY . .

    RUN python manage.py migrate

    EXPOSE 8000

    CMD ["python","manage.py","runserver","0.0.0.0:8000"]

I saved and exited Vim using:

    ESC
    :wq
    ENTER

---

# 12. 🔨 Build the Docker Image Again

After fixing the Python version, I ran:

    docker build -t django-todo .

This time the Docker build completed successfully.

The final output included:

    Successfully built 1d4c6c8513be
    Successfully tagged django-todo:latest

This confirmed that the Docker image was successfully created.

---

# 13. 🖼️ Verify the Docker Image

I checked the available Docker images:

    docker images

The image appeared similar to:

    REPOSITORY    TAG       IMAGE ID
    django-todo   latest    1d4c6c8513be

The Docker image was now:

    django-todo:latest

---

# 14. ▶️ Run the Docker Container

I started the Django application using:

    docker run -d -p 8000:8000 django-todo

Docker returned a container ID similar to:

    b79a3dbaa65edd5de5b781e4e78a3653193ac4f9f2b22ba614cc3ee10f2c788e

The container was now running in the background.

---

# 15. 🧠 Understand the docker run Command

The command was:

    docker run -d -p 8000:8000 django-todo

### `docker run`

Creates and starts a container from a Docker image.

### `-d`

Means detached mode.

The container runs in the background.

### `-p 8000:8000`

Maps the host port to the container port.

Syntax:

    -p HOST_PORT:CONTAINER_PORT

Therefore:

    -p 8000:8000

means:

    EC2 Host Port 8000
            │
            ▼
    Docker Container Port 8000
            │
            ▼
    Django Application Port 8000

This is the main Docker port mapping used in this practical.

---

# 16. 🔍 Verify the Running Container

I checked the running containers:

    docker ps

The output showed:

    CONTAINER ID   IMAGE         COMMAND                  STATUS
    b79a3dbaa65e   django-todo   "python manage.py ru…"   Up

The port mapping showed:

    0.0.0.0:8000->8000/tcp

This confirmed:

    EC2 :8000
       │
       ▼
    Docker :8000
       │
       ▼
    Django :8000

The container was successfully running.

---

# 17. 🧪 Test the Application From EC2

I tested the application locally from the EC2 server:

    curl http://localhost:8000

The request reached Django, but the Todo HTML did not appear directly.

Instead, Django returned a redirect.

The Docker logs later showed:

    "GET / HTTP/1.1" 302 0

---

# 18. 🔎 Check Docker Container Logs

I checked the container logs using:

    docker logs laughing_chatelet

The container name was:

    laughing_chatelet

The logs showed:

    Watching for file changes with StatReloader

Django also displayed a warning:

    System check identified some issues:

    todos.Todo: (models.W042) Auto-created primary key used when not defining a primary key type

This was only a warning.

It did NOT stop the application.

---

# 19. ✅ Verify Django Was Receiving Requests

The most important log line was:

    [03/Sep/2026 02:13:27] "GET / HTTP/1.1" 302 0

Another request showed:

    [03/Sep/2026 02:13:44] "GET / HTTP/1.1" 302 0

This confirmed that Django was:

    Running
       ↓
    Listening on port 8000
       ↓
    Receiving HTTP requests
       ↓
    Returning an HTTP response

---

# 20. 🧠 Understand HTTP 302

The response:

    302

means:

    HTTP Redirect

The Django application redirects:

    /

to:

    /todos/

Therefore:

    http://EC2-PUBLIC-IP:8000

redirects to:

    http://EC2-PUBLIC-IP:8000/todos/

This was NOT an application failure.

It was normal behavior of the Django application.

---

# 21. 🔍 Verify the Container Again

I ran:

    docker ps

The container was still running:

    STATUS: Up

And the port mapping remained:

    0.0.0.0:8000->8000/tcp

At this point:

    Docker Image        ✅
    Docker Container    ✅
    Django Application  ✅
    Port 8000           ✅
    Docker Mapping      ✅

---

# 22. ☁️ Configure AWS Security Group

Docker port mapping alone does not automatically make the application accessible from the internet.

AWS also needs to allow incoming traffic to port 8000.

I went to:

    AWS Console
        ↓
    EC2
        ↓
    Instances
        ↓
    Select EC2 Instance
        ↓
    Security
        ↓
    Security Groups
        ↓
    Inbound Rules
        ↓
    Edit Inbound Rules

I added:

    Type:        Custom TCP
    Port Range:  8000
    Source:      0.0.0.0/0
    Description: Django Todo App

Then I saved the inbound rule.

---

# 23. 🧠 Why the AWS Security Group Was Required

There are two different layers involved.

### Docker Port Mapping

The Docker command:

    docker run -d -p 8000:8000 django-todo

creates:

    Host Port 8000
           ↓
    Container Port 8000

### AWS Security Group

The AWS Security Group allows:

    Internet
       ↓
    AWS EC2
       ↓
    TCP Port 8000

Both are needed.

The complete path is:

    Internet
       ↓
    AWS Security Group
       ↓
    EC2 :8000
       ↓
    Docker :8000
       ↓
    Django :8000

---

# 24. 🌐 Access the Website

The EC2 public IP was:

    3.236.80.61

I opened:

    http://3.236.80.61:8000

The Django application redirected to:

    http://3.236.80.61:8000/todos/

The Todo application successfully appeared in the browser.

The page displayed the Django Todo List application.

---

# 25. 🎉 Final Result

The Django Todo application was successfully running inside Docker and accessible from the internet.

Final flow:

    Browser
       ↓
    EC2 Public IP :8000
       ↓
    AWS Security Group
       ↓
    EC2
       ↓
    Docker Port Mapping
       ↓
    Docker Container
       ↓
    Django Application
       ↓
    Todo Website

---

# 26. 📝 Complete Command History

These are the commands used from beginning to end.

### Clone repository

    git clone https://github.com/iam-veeramalla/Jenkins-Zero-To-Hero.git

### Enter project

    cd Jenkins-Zero-To-Hero/python-jenkins-argocd-k8s

### Check files

    ls

### Edit Dockerfile

    vim Dockerfile

### Build Docker image

    docker build -t django-todo .

### Check Docker images

    docker images

### Run Docker container

    docker run -d -p 8000:8000 django-todo

### Check running containers

    docker ps

### Test Django application

    curl http://localhost:8000

### Check container logs

    docker logs laughing_chatelet

### Check container again

    docker ps

---

# 27. 🐳 Final Dockerfile

    FROM python:3.10

    RUN pip install django==3.2

    COPY . .

    RUN python manage.py migrate

    EXPOSE 8000

    CMD ["python","manage.py","runserver","0.0.0.0:8000"]

---

# 28. 📚 Dockerfile Instructions Learned

### FROM

    FROM python:3.10

Defines the base image.

---

### RUN

    RUN pip install django==3.2

Executes a command during the image build.

---

### COPY

    COPY . .

Copies the project files into the Docker image.

---

### RUN migrate

    RUN python manage.py migrate

Runs Django database migrations during the Docker image build.

---

### EXPOSE

    EXPOSE 8000

Documents that the application uses port 8000.

Important:

`EXPOSE` does NOT publish the port to the internet by itself.

---

### CMD

    CMD ["python","manage.py","runserver","0.0.0.0:8000"]

Starts the Django application.

---

# 29. 🧠 `EXPOSE` vs `-p`

This is an important Docker interview concept.

### EXPOSE

Dockerfile:

    EXPOSE 8000

Means:

    The application uses port 8000.

It does not actually publish the port.

### `-p`

Docker command:

    docker run -p 8000:8000 django-todo

Actually maps:

    Host Port 8000
          ↓
    Container Port 8000

Therefore:

    EXPOSE 8000
          ↓
    Documents the application port

    -p 8000:8000
          ↓
    Publishes/maps the port

---

# 30. 🧠 Why `0.0.0.0:8000`?

The Dockerfile uses:

    CMD ["python","manage.py","runserver","0.0.0.0:8000"]

The application needs to listen on:

    0.0.0.0

rather than only:

    127.0.0.1

Why?

Because the Django application is running inside a Docker container.

Listening on:

    0.0.0.0:8000

allows Django to receive connections through the container's network interface.

The traffic can then flow through:

    EC2 :8000
       ↓
    Docker :8000
       ↓
    Django :8000

---

# 31. 🔧 Troubleshooting Performed

## Problem 1: Docker Build Failed

Error:

    ModuleNotFoundError: No module named 'distutils'

### Cause

The Dockerfile used:

    FROM python:3

This pulled a newer Python version that was incompatible with Django 3.2.

### Solution

Changed:

    FROM python:3

to:

    FROM python:3.10

Then rebuilt:

    docker build -t django-todo .

The build succeeded.

---

## Problem 2: `curl` Did Not Show the Todo Page

Command:

    curl http://localhost:8000

The application returned:

    302

### Investigation

Checked:

    docker logs laughing_chatelet

The logs showed:

    "GET / HTTP/1.1" 302 0

### Explanation

Django was redirecting:

    /

to:

    /todos/

Therefore, the application was working correctly.

The browser followed the redirect and displayed the Todo application.

---

# 32. 🎯 Interview Questions and Answers

## Q1. How do you build a Docker image?

Answer:

    docker build -t django-todo .

This builds an image using the Dockerfile in the current directory.

---

## Q2. How do you run a Docker container?

Answer:

    docker run -d -p 8000:8000 django-todo

---

## Q3. What does `-p 8000:8000` mean?

Answer:

It maps the host port 8000 to the container port 8000.

    Host :8000
       ↓
    Container :8000

---

## Q4. How do you check running containers?

Answer:

    docker ps

---

## Q5. How do you check container logs?

Answer:

    docker logs <container-name>

Example:

    docker logs laughing_chatelet

---

## Q6. What is the difference between `EXPOSE` and `-p`?

Answer:

`EXPOSE` documents the port used by the container.

    EXPOSE 8000

`-p` actually publishes/maps the container port to the host.

    -p 8000:8000

---

## Q7. Why did you use Python 3.10?

Answer:

The application uses Django 3.2.

The newer Python version caused:

    ModuleNotFoundError: No module named 'distutils'

Therefore, Python 3.10 was used as a compatible base image.

---

## Q8. Why is `0.0.0.0:8000` used?

Answer:

It makes Django listen on all network interfaces inside the container so that Docker can forward traffic to it.

---

## Q9. Why did you need an AWS Security Group rule?

Answer:

Docker exposes the port on the EC2 host, but AWS must also allow incoming network traffic to that port.

The Security Group was configured to allow:

    TCP 8000
    Source: 0.0.0.0/0

---

## Q10. How did you expose the application publicly?

Answer:

First, Docker port mapping:

    docker run -d -p 8000:8000 django-todo

Then AWS Security Group:

    Custom TCP
    Port: 8000
    Source: 0.0.0.0/0

Then the browser:

    http://EC2-PUBLIC-IP:8000

---

# 33. 🧠 Important Concepts Learned

### Docker Image

A Docker image is the packaged template used to create containers.

Image created:

    django-todo:latest

Command:

    docker build -t django-todo .

---

### Docker Container

A container is a running instance of an image.

Command:

    docker run -d -p 8000:8000 django-todo

---

### Port Mapping

    -p HOST_PORT:CONTAINER_PORT

Example:

    -p 8000:8000

Means:

    Host 8000
       ↓
    Container 8000

---

### Docker EXPOSE

    EXPOSE 8000

Documents the container port.

It does not make the port publicly accessible by itself.

---

### AWS Security Group

Controls network traffic reaching the EC2 instance.

We allowed:

    TCP 8000
    Source: 0.0.0.0/0

---

### Docker Logs

Used to troubleshoot the running application:

    docker logs laughing_chatelet

---

### Docker PS

Used to check running containers:

    docker ps

---

### CURL

Used to test the application from the EC2 server:

    curl http://localhost:8000

---

# 34. 🔄 Complete End-to-End Request Flow

When the browser requests:

    http://EC2-PUBLIC-IP:8000

the traffic flows through:

    🌐 Browser
         │
         ▼
    EC2 Public IP
         │
         ▼
    AWS Security Group
         │
         │ TCP 8000 allowed
         ▼
    EC2 Host Port 8000
         │
         ▼
    Docker Port Mapping
         │
         │ 8000:8000
         ▼
    Docker Container Port 8000
         │
         ▼
    Django Application
         │
         ▼
    HTTP 302 Redirect
         │
         ▼
    /todos/
         │
         ▼
    Todo Website

---

# 35. 🏆 Complete Practical Timeline

    Step 1
    Clone GitHub repository
        ↓
    Step 2
    Enter Django project
        ↓
    Step 3
    Inspect Dockerfile
        ↓
    Step 4
    docker build
        ↓
    Step 5
    Build failed
        ↓
    Step 6
    Identify Python/Django compatibility problem
        ↓
    Step 7
    Change Python 3 → Python 3.10
        ↓
    Step 8
    docker build
        ↓
    Step 9
    Docker image created successfully
        ↓
    Step 10
    docker run -d -p 8000:8000
        ↓
    Step 11
    docker ps
        ↓
    Step 12
    curl localhost:8000
        ↓
    Step 13
    Check Docker logs
        ↓
    Step 14
    Understand HTTP 302 redirect
        ↓
    Step 15
    Configure AWS Security Group
        ↓
    Step 16
    Open EC2 Public IP :8000
        ↓
    Step 17
    Django Todo Website appears
        ↓
    🎉 PRACTICAL COMPLETED

---

# 36. 📋 Final Cheat Sheet

## Commands

    git clone https://github.com/iam-veeramalla/Jenkins-Zero-To-Hero.git

    cd Jenkins-Zero-To-Hero/python-jenkins-argocd-k8s

    ls

    vim Dockerfile

    docker build -t django-todo .

    docker images

    docker run -d -p 8000:8000 django-todo

    docker ps

    curl http://localhost:8000

    docker logs laughing_chatelet

    docker ps

---

# 37. ☁️ AWS Configuration

AWS Security Group inbound rule:

    Type: Custom TCP
    Port: 8000
    Source: 0.0.0.0/0

---

# 38. 🌐 Final Browser URL

Use:

    http://YOUR-EC2-PUBLIC-IP:8000

Django redirects to:

    http://YOUR-EC2-PUBLIC-IP:8000/todos/

Example:

    http://3.236.80.61:8000

Redirects to:

    http://3.236.80.61:8000/todos/

---

# 39. 🎓 What I Can Explain in an Interview

If asked:

"How did you deploy this application?"

I can answer:

    I cloned the Django Todo application from GitHub onto an AWS EC2
    instance. I inspected the Dockerfile and initially tried to build
    the image using python:3. The build failed because Django 3.2 was
    incompatible with the newer Python version and produced a
    distutils error.

    I fixed the issue by changing the base image to Python 3.10.
    Then I rebuilt the Docker image successfully using:

  
