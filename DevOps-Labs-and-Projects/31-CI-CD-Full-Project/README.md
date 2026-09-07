# End-to-End CI/CD + GitOps Project — Complete Practical Documentation

> **Purpose of this document:**  
> This is the complete practical record of the Django Todo CI/CD project from **the very beginning to the final working application**.
>
> If I come back to this project after 1 month, I should be able to read this README from top to bottom and understand:
>
> - What the project is
> - Why each tool was used
> - How every component connects
> - What files were created/changed
> - What commands were executed
> - What problems happened
> - Why those problems happened
> - How they were fixed
> - How the final deployment works
> - How to explain the project in an interview

---

# 📚 Table of Contents

1. [Project Goal](#-project-goal)
2. [What We Built](#-what-we-built)
3. [Final Architecture](#-final-architecture)
4. [Technology Stack](#-technology-stack)
5. [Project Repository](#-project-repository)
6. [Project Structure](#-project-structure)
7. [Understanding the Application](#-understanding-the-application)
8. [Dockerization](#-dockerization)
9. [Dockerfile Explanation](#-dockerfile-explanation)
10. [Django Test](#-django-test)
11. [SonarQube](#-sonarqube)
12. [Jenkins Setup](#-jenkins-setup)
13. [Jenkins Credentials](#-jenkins-credentials)
14. [GitHub SSH with Jenkins](#-github-ssh-with-jenkins)
15. [Jenkins Pipeline](#-jenkins-pipeline)
16. [Jenkinsfile Complete Explanation](#-jenkinsfile-complete-explanation)
17. [Docker Image Versioning](#-docker-image-versioning)
18. [Docker Hub](#-docker-hub)
19. [Kubernetes](#-kubernetes)
20. [Kubernetes Deployment](#-kubernetes-deployment)
21. [Kubernetes Service](#-kubernetes-service)
22. [Minikube](#-minikube)
23. [Argo CD](#-argo-cd)
24. [GitOps](#-gitops)
25. [Complete CI/CD Flow](#-complete-cicd-flow)
26. [Build #10](#-build-10)
27. [Build #11](#-build-11)
28. [Troubleshooting](#-troubleshooting)
29. [Important Commands](#-important-commands)
30. [How to Verify Everything](#-how-to-verify-everything)
31. [Important Concepts](#-important-concepts)
32. [Interview Explanation](#-interview-explanation)
33. [Common Interview Questions](#-common-interview-questions)
34. [Final Project Status](#-final-project-status)
35. [What I Learned](#-what-i-learned)

---

# 🎯 Project Goal

The goal of this practical was to take a Django Todo application and build a complete automated deployment pipeline.

Instead of manually doing:

    Code
    ↓
    Build
    ↓
    Test
    ↓
    Docker Build
    ↓
    Push Image
    ↓
    Deploy Kubernetes

we automated the process.

The final idea is:

    Developer
        ↓
    GitHub
        ↓
    Jenkins
        ↓
    Test + Code Quality
        ↓
    Docker Image
        ↓
    Docker Hub
        ↓
    Update Kubernetes Manifest
        ↓
    GitHub
        ↓
    Argo CD
        ↓
    Kubernetes
        ↓
    Live Application

This project therefore combines:

    CI = Jenkins

    CD / GitOps = Argo CD

---

# 🧠 What We Actually Built

We started with a Django Todo application.

We then connected the following components:

    GitHub
       ↓
    Jenkins
       ↓
    Docker
       ↓
    Django Tests
       ↓
    SonarQube
       ↓
    Docker Hub
       ↓
    Kubernetes
       ↓
    Argo CD

The final deployment runs the Todo application inside Kubernetes with **3 replicas**.

The application is exposed through a Kubernetes `NodePort` Service.

---

# 🏗️ Final Architecture

The complete architecture is:

    ```mermaid
    flowchart LR

        A[Developer] -->|git push| B[GitHub]

        B -->|Source Code| C[Jenkins]

        C --> D[Checkout]
        D --> E[Verify Repository]
        E --> F[Docker Build]
        F --> G[Django Tests]
        G --> H[SonarQube Analysis]
        H --> I[Quality Gate]

        I -->|Pass| J[Docker Hub]

        I --> K[Update deploy/deploy.yaml]

        K -->|git push| B

        B -->|GitOps Source| L[Argo CD]

        L -->|Sync| M[Kubernetes / Minikube]

        M --> N[Deployment]

        N --> O[Pod 1]
        N --> P[Pod 2]
        N --> Q[Pod 3]

        O --> R[Todo Service]
        P --> R
        Q --> R

        R --> S[Live Django Todo App]
    ```

---

# 🔄 Simplified Architecture

If I forget everything else, remember this:

    Developer
       ↓
    GitHub
       ↓
    Jenkins
       ↓
    Build + Test + SonarQube
       ↓
    Docker Hub
       ↓
    Update Kubernetes YAML in GitHub
       ↓
    Argo CD
       ↓
    Kubernetes
       ↓
    Todo Application

---

# 🛠️ Technology Stack

| Technology | Why We Used It |
|---|---|
| Python | Application programming language |
| Django | Web application framework |
| Git | Version control |
| GitHub | Stores source code and Kubernetes manifests |
| Jenkins | CI automation |
| Docker | Packages application into container |
| Docker Hub | Stores Docker images |
| SonarQube | Static code analysis |
| Kubernetes | Runs and manages containers |
| Minikube | Provides local Kubernetes cluster |
| Argo CD | GitOps continuous delivery |

---

# 📦 Project Repository

GitHub repository:

    Yuvii2102/cicd-end-to-end

The important remote configuration was:

    git remote set-url origin git@github.com:Yuvii2102/cicd-end-to-end.git

We verified GitHub SSH authentication successfully.

The response was:

    Hi Yuvii2102! You've successfully authenticated, but GitHub does not provide shell access.

This means SSH authentication was working correctly.

---

# 📁 Project Structure

The final project contains:

    cicd-end-to-end/
    │
    ├── Dockerfile
    ├── Jenkinsfile
    ├── README.md
    ├── docker-compose.yml
    ├── db.sqlite3
    ├── manage.py
    ├── sonar-project.properties
    │
    ├── staticfiles/
    │
    ├── todoApp/
    │
    ├── todos/
    │   ├── models.py
    │   ├── views.py
    │   ├── urls.py
    │   └── templates/
    │       └── todos/
    │           └── index.html
    │
    └── deploy/
        ├── deploy.yaml
        ├── service.yaml
        └── pod.yaml

---

# 🌐 Application

The application is a Django Todo application.

The application originally displayed:

    Todo List - Abhishek

We changed it to:

    Todo List - Yuvraj

This small change was extremely useful because it allowed us to visually prove that the new application version was actually deployed.

The final browser showed:

    Todo List - Yuvraj

Therefore we knew the new code had travelled through the pipeline.

---

# 🐳 Dockerization

The first major step was containerizing the Django application.

Instead of running Django directly on the machine, we created a Docker image.

The Docker image contains:

    Python
    Django
    Application source code
    Database migration result
    Application configuration

The image can then be run consistently in different environments.

---

# 📜 Dockerfile

The Dockerfile was changed from the generic:

    FROM python:3

to:

    FROM python:3.10

The final Dockerfile is:

    FROM python:3.10
    RUN pip install django==3.2
    COPY . .
    RUN python manage.py migrate
    EXPOSE 8000
    CMD ["python","manage.py","runserver","0.0.0.0:8000"]

---

# 🧠 Dockerfile Explanation

## 1. Base Image

    FROM python:3.10

This tells Docker to start with Python 3.10.

We specifically used Python 3.10 because the project and SonarQube configuration use Python 3.10.

---

## 2. Install Django

    RUN pip install django==3.2

This installs Django version 3.2 inside the image.

---

## 3. Copy Application

    COPY . .

This copies the project files into the Docker image.

---

## 4. Run Migration

    RUN python manage.py migrate

This applies the Django database migrations while creating the image.

---

## 5. Expose Port

    EXPOSE 8000

Django runs on port 8000.

---

## 6. Start Application

    CMD ["python","manage.py","runserver","0.0.0.0:8000"]

This starts Django and binds it to all interfaces.

The important part is:

    0.0.0.0

Without this, the application may only listen internally.

---

# 🧪 Django Testing

We added a Django model test.

The test is:

    from django.test import TestCase
    from .models import Todo


    class TodoModelTest(TestCase):

        def test_todo_creation(self):
            todo = Todo.objects.create(
                title="Learn CI/CD"
            )

            self.assertEqual(todo.title, "Learn CI/CD")

The purpose of the test is simple:

    Create Todo
        ↓
    Check Todo title
        ↓
    Test passes

The commit created for this was:

    e54c143 Add Django model test

---

# 🔬 Why Run Tests Inside Docker?

The Jenkins pipeline runs:

    docker run --rm todo-app:${BUILD_NUMBER} python manage.py test

This means the tests execute using the same Docker environment that contains the application.

The basic idea is:

    Build Image
        ↓
    Run Tests Inside Image
        ↓
    If tests pass → continue
        ↓
    If tests fail → pipeline stops

---

# 🔎 SonarQube

SonarQube was added to perform static code analysis.

SonarQube helps us identify code-quality problems and gives the project a Quality Gate.

Our SonarQube project is:

    todo-app

---

# 📜 sonar-project.properties

The configuration is:

    sonar.projectKey=todo-app
    sonar.projectName=todo-app
    sonar.sources=todoApp,todos
    sonar.python.version=3.10
    sonar.exclusions=**/migrations/**,**/staticfiles/**,**/*.pyc

---

# 🧠 SonarQube Configuration Explanation

## Project Key

    sonar.projectKey=todo-app

This uniquely identifies the project inside SonarQube.

## Project Name

    sonar.projectName=todo-app

This is the project name displayed in SonarQube.

## Sources

    sonar.sources=todoApp,todos

These are the application source directories that SonarQube analyzes.

## Python Version

    sonar.python.version=3.10

This tells SonarQube which Python version the project uses.

## Exclusions

    sonar.exclusions=**/migrations/**,**/staticfiles/**,**/*.pyc

These files/directories are excluded from analysis.

---

# 🐘 SonarQube + PostgreSQL

SonarQube was running using Docker.

Two containers were used:

    sonarqube
    sonarqube-db

The database container used:

    postgres:15

SonarQube itself used:

    sonarqube:community

After a machine reboot, the containers could be started again using:

    docker start sonarqube-db
    docker start sonarqube

---

# 🌐 SonarQube URL

SonarQube was available on:

    http://100.48.56.207:9000

We also verified the service using curl and received HTTP status:

    200

---

# 🔗 Jenkins + SonarQube

Jenkins was configured with:

    Name:
    SonarQube

    URL:
    http://localhost:9000

The SonarQube token was stored in Jenkins using:

    sonarqube-token

The scanner was configured as:

    SonarQubeScanner

Version:

    SonarQube Scanner 8.1.0.6389

---

# 🚦 Quality Gate

The pipeline does not blindly continue after SonarQube analysis.

It waits for the Quality Gate.

The Jenkins stage is:

    stage('Quality Gate') {
        steps {
            timeout(time: 5, unit: 'MINUTES') {
                waitForQualityGate abortPipeline: true
            }
        }
    }

The meaning is:

    SonarQube Analysis
          ↓
    Quality Gate
          ↓
       PASS?
       /   \
     YES    NO
      ↓      ↓
    Continue  Stop Pipeline

In our successful builds, the Quality Gate passed.

---

# 🤖 Jenkins

Jenkins is the CI engine in this project.

Jenkins version:

    2.568.3

The Jenkins job is:

    todo-app-ci

Jenkins is responsible for:

    Checkout
    Build
    Test
    SonarQube
    Quality Gate
    Docker Image Push
    Kubernetes Manifest Update

Jenkins does NOT directly perform the final Kubernetes deployment in this GitOps design.

Instead, Jenkins updates Git.

Argo CD then handles deployment.

---

# 🐳 Jenkins + Docker

Jenkins was configured so that the Jenkins user could execute Docker commands.

Docker version:

    29.1.3

The Docker group contained:

    ubuntu
    jenkins

This allowed Jenkins to execute commands such as:

    docker build

    docker run

    docker tag

    docker push

    docker login

---

# 🔐 Jenkins Credentials

We created three important credentials.

## GitHub

Credential ID:

    github-ssh

Type:

    SSH Username with private key

Username:

    git

Description:

    GitHub SSH access for Jenkins

---

## SonarQube

Credential ID:

    sonarqube-token

This stores the SonarQube authentication token.

---

## Docker Hub

Credential ID:

    dockerhub-credentials

This stores the Docker Hub username and password/token.

---

# 🔑 Why Use Jenkins Credentials?

We should NEVER write passwords directly in the Jenkinsfile.

Bad:

    docker login -u yuvi2102 -p MY_PASSWORD

Better:

    withCredentials(...)

Jenkins injects the secret only when needed.

This keeps credentials outside the source code.

---

# 🔐 Jenkins GitHub SSH

There are two different SSH contexts to understand.

The Ubuntu user has its own SSH configuration.

Jenkins is a separate operating-system user.

Therefore Jenkins uses the Jenkins credential:

    github-ssh

The private key is temporarily exposed to the pipeline through:

    SSH_KEY

The Git push uses:

    GIT_SSH_COMMAND="ssh -i $SSH_KEY -o StrictHostKeyChecking=no"

This allows Jenkins to authenticate with GitHub.

---

# 📜 Complete Jenkinsfile

The final working Jenkinsfile is:

    pipeline {
        agent any

        stages {

            stage('Checkout') {
                steps {
                    echo 'Checking out source code...'

                    checkout scm
                }
            }

            stage('Verify Repository') {
                steps {
                    sh '''
                        echo "Repository contents:"
                        ls -la

                        echo ""
                        echo "Git commit:"
                        git log -1 --oneline
                    '''
                }
            }

            stage('Build Docker Image') {
                steps {
                    sh '''
                        echo "Building Docker image..."

                        docker build -t todo-app:${BUILD_NUMBER} .

                        echo "Tagging image for Docker Hub..."

                        docker tag todo-app:${BUILD_NUMBER} yuvi2102/todo-app:${BUILD_NUMBER}
                    '''
                }
            }

            stage('Run Django Tests') {
                steps {
                    sh '''
                        echo "Running Django tests..."

                        docker run --rm todo-app:${BUILD_NUMBER} python manage.py test
                    '''
                }
            }

            stage('SonarQube Analysis') {
                steps {
                    script {
                        def scannerHome = tool 'SonarQubeScanner'

                        withSonarQubeEnv('SonarQube') {
                            sh "${scannerHome}/bin/sonar-scanner"
                        }
                    }
                }
            }

            stage('Quality Gate') {
                steps {
                    timeout(time: 5, unit: 'MINUTES') {
                        waitForQualityGate abortPipeline: true
                    }
                }
            }

            stage('Push Docker Image') {
                steps {
                    withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-credentials',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )]) {
                        sh '''
                            echo "Logging in to Docker Hub..."

                            echo "$DOCKER_PASSWORD" | docker login \
                                -u "$DOCKER_USERNAME" \
                                --password-stdin

                            echo "Pushing Docker image..."

                            docker push yuvi2102/todo-app:${BUILD_NUMBER}

                            echo "Docker image pushed successfully!"
                        '''
                    }
                }
            }

            stage('Update Kubernetes Manifest') {
                steps {
                    withCredentials([sshUserPrivateKey(
                        credentialsId: 'github-ssh',
                        keyFileVariable: 'SSH_KEY',
                        usernameVariable: 'GIT_USERNAME'
                    )]) {
                        sh '''
                            echo "Updating Kubernetes image tag..."

                            sed -i "s|image: yuvi2102/todo-app:.*|image: yuvi2102/todo-app:${BUILD_NUMBER}|" deploy/deploy.yaml

                            echo ""
                            echo "Updated Kubernetes image:"
                            grep "image:" deploy/deploy.yaml

                            echo ""
                            echo "Configuring Git..."

                            git config user.name "Jenkins"
                            git config user.email "jenkins@localhost"

                            echo ""
                            echo "Committing Kubernetes manifest..."

                            git add deploy/deploy.yaml

                            git commit -m "Update Kubernetes image to ${BUILD_NUMBER}" || true

                            echo ""
                            echo "Pushing updated manifest to GitHub..."

                            GIT_SSH_COMMAND="ssh -i $SSH_KEY -o StrictHostKeyChecking=no" git push origin HEAD:main

                            echo ""
                            echo "Kubernetes manifest pushed successfully!"
                        '''
                    }
                }
            }
        }

        post {

            success {
                echo '✅ CI/CD Pipeline completed successfully!'
            }

            failure {
                echo '❌ CI/CD Pipeline failed!'
            }

            always {
                sh '''
                    echo "Cleaning temporary Docker images..."

                    docker rmi todo-app:${BUILD_NUMBER} || true

                    docker rmi yuvi2102/todo-app:${BUILD_NUMBER} || true
                '''
            }
        }
    }

---

# 🧠 Jenkinsfile Stage-by-Stage Explanation

## Stage 1 — Checkout

    checkout scm

Jenkins downloads the source code from GitHub.

---

## Stage 2 — Verify Repository

Commands:

    ls -la

    git log -1 --oneline

This verifies:

- Repository contents exist.
- Jenkins checked out the expected code.
- We can see the latest commit.

---

## Stage 3 — Build Docker Image

Command:

    docker build -t todo-app:${BUILD_NUMBER} .

Suppose Jenkins build number is:

    11

The image becomes:

    todo-app:11

Then it is tagged for Docker Hub:

    yuvi2102/todo-app:11

---

## Stage 4 — Run Django Tests

Command:

    docker run --rm todo-app:${BUILD_NUMBER} python manage.py test

This runs the Django test suite.

If the test fails:

    Pipeline stops

If the test passes:

    Continue

---

## Stage 5 — SonarQube Analysis

Jenkins uses the configured scanner:

    SonarQubeScanner

and the configured server:

    SonarQube

The scanner reads:

    sonar-project.properties

and analyzes:

    todoApp
    todos

---

## Stage 6 — Quality Gate

Jenkins waits for SonarQube.

If the Quality Gate fails:

    abortPipeline: true

The pipeline stops.

If it passes:

    Continue

---

## Stage 7 — Push Docker Image

Jenkins logs in to Docker Hub using the Jenkins credential.

Then:

    docker push yuvi2102/todo-app:${BUILD_NUMBER}

For Build #11:

    docker push yuvi2102/todo-app:11

---

## Stage 8 — Update Kubernetes Manifest

Jenkins executes:

    sed -i "s|image: yuvi2102/todo-app:.*|image: yuvi2102/todo-app:${BUILD_NUMBER}|" deploy/deploy.yaml

This changes the Docker image version in the Kubernetes manifest.

For example:

    image: yuvi2102/todo-app:10

becomes:

    image: yuvi2102/todo-app:11

Then Jenkins:

    git add deploy/deploy.yaml

    git commit -m "Update Kubernetes image to 11"

and pushes it to GitHub.

---

# 🏷️ Docker Image Versioning

We did NOT use only:

    latest

Instead we use Jenkins Build Number.

Example:

    Build #10
        ↓
    yuvi2102/todo-app:10

    Build #11
        ↓
    yuvi2102/todo-app:11

    Build #12
        ↓
    yuvi2102/todo-app:12

This gives every build a unique version.

---

# 🐳 Docker Hub

Docker Hub repository:

    yuvi2102/todo-app

Images created during the practical included:

    yuvi2102/todo-app:10

    yuvi2102/todo-app:11

The successful Build #11 pushed:

    yuvi2102/todo-app:11

---

# ☸️ Kubernetes

Kubernetes is responsible for running the application containers.

We used:

    Minikube

as the Kubernetes environment.

---

# 🚀 Starting Minikube

Command:

    minikube start

Then verify:

    kubectl get nodes

Expected result:

    NAME       STATUS   ROLES           AGE   VERSION
    minikube   Ready    control-plane   ...   v1.35.1

The important part is:

    STATUS = Ready

---

# 📦 Kubernetes Deployment

File:

    deploy/deploy.yaml

The important configuration is:

    apiVersion: apps/v1
    kind: Deployment

    metadata:
      name: todo-app

    spec:
      replicas: 3

      selector:
        matchLabels:
          app: nginx

      template:
        metadata:
          labels:
            app: nginx

        spec:
          containers:
          - name: todo
            image: yuvi2102/todo-app:11

            ports:
            - containerPort: 8000

---

# 🧠 Deployment Explanation

## Deployment Name

    todo-app

This identifies the Kubernetes Deployment.

## Replicas

    replicas: 3

Kubernetes tries to maintain three Pods.

## Selector

    app: nginx

The Deployment manages Pods with this label.

## Container

Container name:

    todo

## Image

Example:

    yuvi2102/todo-app:11

## Container Port

    8000

Django listens on port 8000.

---

# 🧩 Deployment → ReplicaSet → Pods

Remember this relationship:

    Deployment
        ↓
    ReplicaSet
        ↓
    Pods
        ↓
    Containers

The Deployment manages the desired number of replicas.

In our project:

    Deployment
        ↓
    3 Pods
        ↓
    Django containers

---

# 🌐 Kubernetes Service

File:

    deploy/service.yaml

The configuration is:

    apiVersion: v1
    kind: Service
    metadata:
      name: todo-service
    spec:
      type: NodePort
      selector:
        app: nginx
      ports:
        - protocol: TCP
          port: 80
          targetPort: 8000
          nodePort: 31000

---

# 🧠 Service Explanation

There are three important ports.

## Service Port

    port: 80

The Service listens on port 80.

## Target Port

    targetPort: 8000

The Service forwards traffic to the application container's port 8000.

## NodePort

    nodePort: 31000

The Service can be accessed through NodePort 31000.

---

# 🔀 Kubernetes Networking

The traffic flow is:

    Browser
       ↓
    NodePort 31000
       ↓
    Service port 80
       ↓
    targetPort 8000
       ↓
    Django Pod
       ↓
    Django application

---

# 🔗 Service Selector

The Service has:

    selector:
      app: nginx

The Pods also have:

    labels:
      app: nginx

Therefore the Service finds those Pods.

The Service endpoints were:

    10.244.0.90:8000
    10.244.0.91:8000
    10.244.0.92:8000

This confirms that the Service was connected to the three application Pods.

---

# 🖥️ Minikube Service

The Service was available through:

    http://192.168.49.2:31000

We tested it using curl.

The application responded with a redirect to:

    /todos/

This was expected Django behavior.

---

# 🔁 Port Forwarding

We also used:

    kubectl port-forward svc/todo-service 8000:80 --address=0.0.0.0

This means:

    Server port 8000
          ↓
    Kubernetes Service port 80

Then the browser could access:

    http://100.48.56.207:8000/todos/

---

# ⚠️ Important Port-Forward Lesson

When we tried to run the port-forward again, we got:

    Unable to listen on port 8000
    bind: address already in use

This happened because the previous port-forward was already running.

It does NOT necessarily mean Kubernetes is broken.

It means:

    Port 8000
        ↓
    Already being used by another process

If needed, find the process with:

    sudo lsof -i :8000

or:

    sudo ss -ltnp | grep :8000

Then stop the old process if necessary.

---

# 🚀 Argo CD

Argo CD is the GitOps component of this project.

Its job is to watch Git and synchronize Kubernetes with the desired state stored in Git.

The basic idea:

    Git
      ↓
    Argo CD
      ↓
    Kubernetes

---

# 🧠 Why Argo CD?

Without GitOps, Jenkins could directly execute:

    kubectl apply -f deploy/

But in this project we use a GitOps model.

Instead:

    Jenkins
       ↓
    Updates Kubernetes YAML
       ↓
    GitHub
       ↓
    Argo CD
       ↓
    Kubernetes

Git becomes the source of truth.

---

# 📦 Argo CD Installation

First we created the namespace:

    kubectl create namespace argocd

Then installed Argo CD:

    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

There was a warning related to the ApplicationSet CRD annotation length, but the main Argo CD components became Running.

---

# 🔎 Argo CD Version

The UI showed:

    v3.5.2

---

# 🌐 Argo CD Service

We changed the Argo CD server Service to NodePort:

    kubectl patch svc argocd-server -n argocd -p '{"spec":{"type":"NodePort"}}'

The exposed ports were:

    80:30994

    443:31761

---

# 🔌 Argo CD Port Forwarding

We also accessed the Argo CD UI through:

    kubectl port-forward svc/argocd-server -n argocd 8081:443 --address=0.0.0.0

Then accessed the UI through the server IP on port 8081.

Because Argo CD uses a self-signed certificate in this setup, the browser showed a certificate warning.

We accepted the warning and opened the UI.

---

# 📱 Argo CD Application

We created an Argo CD application:

    todo-app

Important configuration:

    Project:
    default

    Repository:
    https://github.com/Yuvii2102/cicd-end-to-end.git

    Revision:
    main

    Path:
    deploy

    Cluster:
    https://kubernetes.default.svc

    Namespace:
    default

    Auto-Sync:
    Enabled

---

# 🧠 What Does "Path: deploy" Mean?

The Kubernetes manifests are stored inside:

    deploy/

The folder contains:

    deploy.yaml
    service.yaml
    pod.yaml

Argo CD watches that path in Git.

Therefore when Jenkins changes:

    deploy/deploy.yaml

Argo CD can detect the change.

---

# 🔄 What Does Auto-Sync Mean?

Auto-Sync means Argo CD can automatically synchronize Kubernetes with the Git state.

For example:

Git says:

    image: yuvi2102/todo-app:11

Kubernetes currently has:

    image: yuvi2102/todo-app:10

Argo CD detects the difference and synchronizes the cluster.

After synchronization:

    Kubernetes → yuvi2102/todo-app:11

---

# 🌳 GitOps Concept

The most important GitOps concept in this project is:

> **Git is the source of truth.**

Git contains the desired Kubernetes configuration.

Argo CD compares:

    Desired State
    =
    Git

with:

    Actual State
    =
    Kubernetes

If they are different:

    Argo CD → Synchronize

---

# 🔄 GitOps Diagram

    ```mermaid
    flowchart LR

        A[GitHub<br/>Desired State] --> B[Argo CD]

        B --> C{Compare}

        C -->|Same| D[Healthy + Synced]

        C -->|Different| E[Sync Kubernetes]

        E --> F[Kubernetes]

        F --> G[Application]

        F -->|Actual State| C
    ```

---

# 🔥 The Most Important Part of the Project

The most important chain to remember is:

    Code Change
        ↓
    GitHub
        ↓
    Jenkins
        ↓
    Docker Build
        ↓
    Django Test
        ↓
    SonarQube
        ↓
    Quality Gate
        ↓
    Docker Hub
        ↓
    Update deploy.yaml
        ↓
    GitHub
        ↓
    Argo CD
        ↓
    Kubernetes
        ↓
    New Pods
        ↓
    Service
        ↓
    Live Application

---

# 🧪 Build #10 — First Complete Successful Pipeline

Build #10 was an important milestone.

It successfully completed:

    Checkout                 ✓
    Verify Repository        ✓
    Docker Build             ✓
    Django Tests             ✓
    SonarQube Analysis       ✓
    Quality Gate             ✓
    Docker Hub Push          ✓
    Kubernetes Manifest      ✓
    Git Push                 ✓
    Argo CD Sync             ✓
    Kubernetes Deployment    ✓

The Docker image was:

    yuvi2102/todo-app:10

The Kubernetes deployment was updated to use version 10.

---

# 🧪 Build #11 — Final Verified Version

Build #11 was another complete successful pipeline.

The Docker image was:

    yuvi2102/todo-app:11

Django tests passed.

SonarQube analysis passed.

Quality Gate passed.

Docker image was pushed successfully.

Jenkins updated:

    deploy/deploy.yaml

to:

    image: yuvi2102/todo-app:11

Jenkins committed the change and pushed it to GitHub.

---

# 🔄 Build #11 Argo CD Issue

After Build #11, GitHub already showed:

    image: yuvi2102/todo-app:11

But Kubernetes initially still showed:

    yuvi2102/todo-app:10

This was because Argo CD had not immediately refreshed the Git state.

We verified GitHub using:

    git show origin/main:deploy/deploy.yaml | grep "image:"

It showed:

    image: yuvi2102/todo-app:11

Therefore:

    GitHub = 11
    Kubernetes = 10

The problem was synchronization/refresh, not the Docker image.

---

# 🔄 Hard Refresh of Argo CD

We forced an Argo CD refresh using:

    kubectl -n argocd annotate application todo-app argocd.argoproj.io/refresh=hard --overwrite

After the refresh and synchronization, Kubernetes updated to:

    yuvi2102/todo-app:11

---

# ☸️ Final Kubernetes Pods

After Build #11, the Pods were:

    todo-app-f48b6bf6-qd8pt   1/1 Running

    todo-app-f48b6bf6-qvrwq   1/1 Running

    todo-app-f48b6bf6-zsg4p   1/1 Running

This proves the Deployment was maintaining three running replicas.

---

# ✅ Rollout Verification

We used:

    kubectl rollout status deployment/todo-app

The result confirmed:

    deployment "todo-app" successfully rolled out

Therefore the new version was successfully deployed.

---

# 🐛 Troubleshooting — Jenkins Git Push

One of the most important errors was:

    error: src refspec main does not match any

---

# ❓ Why Did This Happen?

Jenkins checks out code in a detached HEAD state.

Conceptually:

    GitHub main
        ↓
    Jenkins checkout
        ↓
    Detached HEAD

Jenkins may not have a normal local branch named:

    main

Therefore:

    git push origin main

failed.

---

# ✅ The Fix

Instead of pushing the local branch:

    git push origin main

we pushed the current checked-out commit:

    git push origin HEAD:main

Meaning:

    Current Jenkins HEAD
           ↓
        remote main

This fixed the pipeline.

---

# 🐛 Troubleshooting — Python Version

The Dockerfile originally used:

    FROM python:3

We changed it to:

    FROM python:3.10

This gave us a specific Python version and matched:

    sonar.python.version=3.10

---

# 🐛 Troubleshooting — Kubernetes Still Running Old Image

Problem:

    GitHub → image: 11

    Kubernetes → image: 10

Reason:

    Argo CD had not refreshed/synchronized the latest Git state.

Fix:

    kubectl -n argocd annotate application todo-app argocd.argoproj.io/refresh=hard --overwrite

Then verify:

    kubectl get deployment todo-app -o jsonpath='{.spec.template.spec.containers[0].image}'

Expected:

    yuvi2102/todo-app:11

---

# 🐛 Troubleshooting — Local Git Behind Remote

Because Jenkins pushes commits to GitHub, the remote `main` branch can contain commits that the local machine does not have.

We encountered this situation.

The fix was:

    git pull --rebase origin main

followed by:

    git push origin main

This synchronized the local branch with GitHub.

---

# 🐛 Troubleshooting — Port Already in Use

Error:

    Unable to listen on port 8000
    bind: address already in use

Reason:

    Another port-forward process was already listening on port 8000.

Check:

    sudo lsof -i :8000

or:

    sudo ss -ltnp | grep :8000

If the existing port-forward is working, there is no need to start another one.

---

# 🧠 Important Difference: Docker Image vs Kubernetes Manifest

This is very important.

Docker Hub contains:

    yuvi2102/todo-app:11

GitHub contains:

    image: yuvi2102/todo-app:11

Kubernetes uses the value from the manifest.

So:

    Docker Hub
       ↓
    Contains image

    GitHub
       ↓
    Says which image Kubernetes should use

    Argo CD
       ↓
    Makes Kubernetes match Git

---

# 🧠 Important Difference: Jenkins vs Argo CD

This is one of the most important interview concepts.

## Jenkins

Jenkins handles:

    CI

and prepares the deployment change.

It performs:

    Checkout
    Build
    Test
    SonarQube
    Quality Gate
    Docker Push
    Manifest Update

## Argo CD

Argo CD handles:

    GitOps CD

It performs:

    Git Monitoring
    Desired State Comparison
    Kubernetes Synchronization

---

# 🧠 Jenkins Does Not Directly Deploy Kubernetes

In this project, Jenkins does not primarily do:

    kubectl apply

Instead:

    Jenkins
       ↓
    Changes deploy.yaml
       ↓
    GitHub
       ↓
    Argo CD
       ↓
    Kubernetes

This is what makes the deployment GitOps-based.

---

# 🧠 What Is the Source of Truth?

The answer is:

    GitHub

Specifically, the Kubernetes manifests in:

    deploy/

Argo CD watches this desired configuration.

---

# 🔄 Complete CI/CD Mermaid Diagram

    ```mermaid
    flowchart TD

        A[Developer] -->|Push Code| B[GitHub]

        B -->|Webhook / Job Trigger| C[Jenkins]

        C --> D[Checkout Source]

        D --> E[Verify Repository]

        E --> F[Build Docker Image]

        F --> G[Run Django Tests]

        G --> H[SonarQube Analysis]

        H --> I[Quality Gate]

        I -->|Failed| X[Stop Pipeline]

        I -->|Passed| J[Push Docker Image]

        J --> K[Docker Hub]

        I --> L[Update Kubernetes Manifest]

        L --> M[Git Commit]

        M --> B

        B --> N[Argo CD]

        N --> O[Compare Desired vs Actual State]

        O --> P[Kubernetes]

        P --> Q[Deployment]

        Q --> R[Pod 1]
        Q --> S[Pod 2]
        Q --> T[Pod 3]

        R --> U[Service]
        S --> U
        T --> U

        U --> V[Live Django Application]
    ```

---

# 🧩 Component Responsibilities

| Component | Responsibility |
|---|---|
| Developer | Writes/modifies code |
| GitHub | Stores application source and Kubernetes manifests |
| Jenkins | Automates CI |
| Docker | Packages application |
| Django Tests | Validate application behavior |
| SonarQube | Analyze code quality |
| Quality Gate | Decide whether pipeline can continue |
| Docker Hub | Stores versioned images |
| Kubernetes | Runs containers |
| Minikube | Provides Kubernetes cluster |
| Argo CD | Synchronizes Git state to Kubernetes |
| Service | Provides stable network access |
| Pods | Run Django containers |

---

# 📌 Important Files

## Dockerfile

Responsible for:

    Creating application image

---

## Jenkinsfile

Responsible for:

    CI/CD automation logic

---

## sonar-project.properties

Responsible for:

    SonarQube configuration

---

## deploy/deploy.yaml

Responsible for:

    Kubernetes Deployment

---

## deploy/service.yaml

Responsible for:

    Kubernetes Service

---

## deploy/pod.yaml

Contains:

    Kubernetes Pod configuration

This file contains an older image reference and was left unchanged during the practical.

---

# 📦 Kubernetes Files

The main deployment files are:

    deploy/
    ├── deploy.yaml
    ├── service.yaml
    └── pod.yaml

The Argo CD application watches this directory.

---

# 🧠 Deployment File vs Service File

Remember:

    Deployment
        =
    Manages Pods

    Service
        =
    Provides networking to Pods

Therefore:

    Deployment → "Run my application"

    Service → "Give my application a stable network endpoint"

---

# 🧠 Pod vs Deployment

A Pod is where the container runs.

A Deployment manages the desired number of Pods.

In our project:

    Deployment
        ↓
    3 Pods
        ↓
    3 Django containers

---

# 🧠 Service vs Pod IP

Pod IPs can change.

Therefore users should not depend directly on:

    10.244.x.x

The Service gives a stable endpoint.

The Service selects Pods using labels.

---

# 🧠 NodePort

NodePort exposes the Service using a port on the Kubernetes node.

Our NodePort:

    31000

So the flow is:

    Node IP:31000
          ↓
       Service
          ↓
        Pods

---

# 🧠 Why Three Replicas?

The Deployment uses:

    replicas: 3

This means Kubernetes tries to keep three copies of the application running.

Benefits include:

- Better availability
- Load distribution
- Rolling updates
- If one Pod fails, Kubernetes can create another

---

# 🔄 Rolling Deployment

When the image changes:

    :10 → :11

Kubernetes performs a rollout.

Conceptually:

    Old Pods
    ┌─────┐ ┌─────┐ ┌─────┐
    │ :10 │ │ :10 │ │ :10 │
    └─────┘ └─────┘ └─────┘

              ↓

    New Pods gradually created

              ↓

    New Pods
    ┌─────┐ ┌─────┐ ┌─────┐
    │ :11 │ │ :11 │ │ :11 │
    └─────┘ └─────┘ └─────┘

This is one reason Kubernetes Deployments are useful.

---

# 🔍 Useful Kubernetes Verification Commands

Check nodes:

    kubectl get nodes

Check Pods:

    kubectl get pods

Check Pods with more details:

    kubectl get pods -o wide

Check Deployments:

    kubectl get deployments

Check Services:

    kubectl get svc

Check Endpoints:

    kubectl get endpoints

Check Deployment image:

    kubectl get deployment todo-app -o jsonpath='{.spec.template.spec.containers[0].image}'

Check rollout:

    kubectl rollout status deployment/todo-app

Describe Deployment:

    kubectl describe deployment todo-app

Describe Pod:

    kubectl describe pod <pod-name>

View Pod logs:

    kubectl logs <pod-name>

---

# 🔍 Useful Git Commands

Check repository:

    git status

Check remote:

    git remote -v

View commits:

    git log --oneline

View latest commit:

    git log -1 --oneline

Pull latest GitHub changes:

    git pull --rebase origin main

Push:

    git push origin main

View GitHub version of Kubernetes manifest:

    git show origin/main:deploy/deploy.yaml | grep "image:"

---

# 🔍 Useful Docker Commands

Check Docker:

    docker --version

List images:

    docker images

Build image:

    docker build -t todo-app:1 .

Run container:

    docker run --rm todo-app:1

Run Django tests:

    docker run --rm todo-app:1 python manage.py test

Tag image:

    docker tag todo-app:1 yuvi2102/todo-app:1

Login:

    docker login

Push:

    docker push yuvi2102/todo-app:1

List containers:

    docker ps

List all containers:

    docker ps -a

---

# 🔍 Useful Minikube Commands

Start:

    minikube start

Check status:

    minikube status

Get IP:

    minikube ip

Open Service:

    minikube service todo-service --url

Stop:

    minikube stop

---

# 🔍 Useful Argo CD Commands

Check Argo CD namespace:

    kubectl get pods -n argocd

Check Argo CD services:

    kubectl get svc -n argocd

Refresh application:

    kubectl -n argocd annotate application todo-app argocd.argoproj.io/refresh=hard --overwrite

Check application:

    kubectl get application -n argocd

---

# 🌐 Final Application Access

The Kubernetes Service was port-forwarded using:

    kubectl port-forward svc/todo-service 8000:80 --address=0.0.0.0

The final application URL was:

    http://100.48.56.207:8000/todos/

The browser displayed:

    Todo List - Yuvraj

This was the final visual confirmation.

---

# 🧪 Final Verification Checklist

After everything is running, verify in this order.

## 1. Minikube

    minikube status

Expected:

    Running

---

## 2. Kubernetes Node

    kubectl get nodes

Expected:

    minikube   Ready

---

## 3. Pods

    kubectl get pods

Expected:

    3 Pods
    Running

---

## 4. Deployment

    kubectl rollout status deployment/todo-app

Expected:

    successfully rolled out

---

## 5. Service

    kubectl get svc

Expected:

    todo-service
    NodePort
    80:31000/TCP

---

## 6. Docker Image

    kubectl get deployment todo-app -o jsonpath='{.spec.template.spec.containers[0].image}'

Expected final version:

    yuvi2102/todo-app:11

---

## 7. Argo CD

Expected:

    Healthy
    Synced

---

## 8. Application

Open:

    http://100.48.56.207:8000/todos/

Expected:

    Todo List - Yuvraj

---

# 🧠 If I Forget the Whole Project

Remember this one picture:

    ┌─────────────┐
    │  Developer  │
    └──────┬──────┘
           │
           ▼
    ┌─────────────┐
    │   GitHub    │
    └──────┬──────┘
           │
           ▼
    ┌─────────────┐
    │   Jenkins   │
    └──────┬──────┘
           │
           ├── Build
           ├── Test
           ├── SonarQube
           ├── Quality Gate
           │
           ▼
    ┌─────────────┐
    │ Docker Hub  │
    └─────────────┘

           Jenkins
              │
              ▼
       Update deploy.yaml
              │
              ▼
          ┌────────┐
          │ GitHub │
          └────┬───┘
               │
               ▼
          ┌─────────┐
          │ Argo CD │
          └────┬────┘
               │
               ▼
       ┌────────────────┐
       │   Kubernetes   │
       └───────┬────────┘
               │
          ┌────┴────┐
          │         │
          ▼         ▼
       Pod 1      Pod 2      Pod 3
          │         │         │
          └────┬────┴────┬────┘
               │
               ▼
          Todo Service
               │
               ▼
        Django Todo App

---

# 🎤 Interview Explanation — Short Version

If the interviewer says:

**"Tell me about your CI/CD project."**

Say:

    I worked on an end-to-end CI/CD and GitOps project for a Django
    Todo application.

    The source code is maintained in GitHub. Jenkins is used for
    continuous integration. When a code change is pushed, Jenkins
    checks out the source code, builds a Docker image, runs Django
    tests and performs SonarQube analysis.

    Jenkins waits for the SonarQube Quality Gate. If it passes,
    Jenkins pushes a versioned Docker image to Docker Hub.

    Jenkins then updates the Kubernetes deployment manifest with the
    Jenkins build number and pushes that change back to GitHub.

    Argo CD watches the Kubernetes manifests in GitHub and follows
    the GitOps approach. When the manifest changes, Argo CD
    synchronizes the Kubernetes cluster.

    Kubernetes deploys the new image using a Deployment with three
    replicas, and the application is exposed through a NodePort
    Service.

    So the complete flow is:

    GitHub → Jenkins → Test → SonarQube → Docker Hub
    → Git Manifest Update → Argo CD → Kubernetes → Application

---

# 🎤 Interview Explanation — Detailed Version

If the interviewer asks you to explain the project deeply:

    The project is a Django Todo application deployed using an
    automated CI/CD pipeline with a GitOps deployment model.

    GitHub is used as the source-code repository and also stores
    the Kubernetes manifests.

    Jenkins is used for continuous integration. The pipeline first
    checks out the repository and verifies the latest commit.

    Then Jenkins builds a Docker image using the Dockerfile. The
    image is tagged using the Jenkins BUILD_NUMBER so every build
    has a unique version.

    After building the image, Jenkins runs the Django test suite
    inside the Docker container.

    If the tests pass, Jenkins runs SonarQube analysis. Jenkins
    waits for the SonarQube Quality Gate. If the Quality Gate fails,
    the pipeline stops.

    If the Quality Gate passes, Jenkins authenticates with Docker
    Hub and pushes the versioned image.

    After that Jenkins modifies deploy/deploy.yaml and changes the
    Docker image tag to the current BUILD_NUMBER.

    Jenkins commits the Kubernetes manifest change and pushes it
    back to GitHub.

    Argo CD watches the deploy directory in GitHub. Since Git is
    the source of truth, Argo CD detects the changed desired state
    and synchronizes Kubernetes.

    Kubernetes then performs a rolling update and starts Pods using
    the new Docker image.

    The application runs with three replicas and is exposed using
    a Kubernetes NodePort Service.

    Finally, the application can be accessed through the exposed
    service and the updated Todo application is visible.

---

# 🎤 Common Interview Question 1

## Why did you use Jenkins?

Answer:

    Jenkins is used to automate the Continuous Integration process.

    It automatically performs source checkout, Docker build,
    application testing, SonarQube analysis, Quality Gate validation
    and Docker image publishing.

---

# 🎤 Common Interview Question 2

## Why Docker?

Answer:

    Docker packages the Django application and its runtime
    dependencies into a portable container image.

    This gives us a consistent environment between build and
    deployment.

---

# 🎤 Common Interview Question 3

## Why Docker Hub?

Answer:

    Docker Hub acts as the container image registry.

    Jenkins pushes the successfully built and tested image to
    Docker Hub so Kubernetes can pull and run it.

---

# 🎤 Common Interview Question 4

## Why SonarQube?

Answer:

    SonarQube performs static code analysis and helps us maintain
    code quality.

    The Jenkins pipeline waits for the Quality Gate before
    continuing to the image publishing stage.

---

# 🎤 Common Interview Question 5

## What happens if SonarQube Quality Gate fails?

Answer:

    The Jenkins pipeline stops because we configured:

    waitForQualityGate abortPipeline: true

    Therefore an image will not be promoted through the remaining
    pipeline stages when the Quality Gate fails.

---

# 🎤 Common Interview Question 6

## Why use BUILD_NUMBER?

Answer:

    BUILD_NUMBER gives every Jenkins build a unique identifier.

    For example:

    Build 10 → todo-app:10
    Build 11 → todo-app:11

    This makes image versions traceable.

---

# 🎤 Common Interview Question 7

## Why not use latest?

Answer:

    Using unique version tags makes it easier to identify exactly
    which build is deployed.

    With latest, it can be harder to determine which application
    version is actually running.

---

# 🎤 Common Interview Question 8

## What is GitOps?

Answer:

    GitOps means Git is used as the source of truth for the desired
    infrastructure or application state.

    In this project Jenkins updates the Kubernetes manifest in GitHub,
    and Argo CD watches GitHub and synchronizes Kubernetes with that
    desired state.

---

# 🎤 Common Interview Question 9

## Why use Argo CD?

Answer:

    Argo CD provides GitOps-based continuous delivery for Kubernetes.

    Instead of Jenkins directly applying Kubernetes manifests,
    Jenkins updates Git and Argo CD detects the change and
    synchronizes Kubernetes.

---

# 🎤 Common Interview Question 10

## Why Jenkins and Argo CD together?

Answer:

    Jenkins and Argo CD have different responsibilities.

    Jenkins handles:

    Build
    Test
    Code Quality
    Docker Image
    Manifest Update

    Argo CD handles:

    GitOps
    Kubernetes Synchronization
    Deployment

---

# 🎤 Common Interview Question 11

## Why three replicas?

Answer:

    Three replicas provide multiple instances of the application.

    If one Pod fails, Kubernetes can maintain the desired replica
    count by creating another Pod.

    It also supports rolling updates.

---

# 🎤 Common Interview Question 12

## What is the difference between Deployment and Service?

Answer:

    A Deployment manages the desired number of Pods.

    A Service provides stable networking and forwards traffic to
    the appropriate Pods.

---

# 🎤 Common Interview Question 13

## Why NodePort?

Answer:

    NodePort exposes the Kubernetes Service through a port on the
    Kubernetes node.

    In this project the NodePort is:

    31000

---

# 🎤 Common Interview Question 14

## What is targetPort?

Answer:

    targetPort is the port on the application Pod where the
    Service forwards traffic.

    Our Django application listens on:

    8000

    Therefore:

    Service port 80
        ↓
    targetPort 8000

---

# 🎤 Common Interview Question 15

## Why did Jenkins use HEAD:main?

Answer:

    Jenkins checks out the repository in a detached HEAD state.

    Therefore a local main branch may not exist.

    Instead of:

    git push origin main

    we use:

    git push origin HEAD:main

    This pushes the currently checked-out commit to the remote
    main branch.

---

# 🎤 Common Interview Question 16

## How did you troubleshoot when Kubernetes was still using image 10?

Answer:

    First I checked the manifest in GitHub:

    git show origin/main:deploy/deploy.yaml | grep "image:"

    It showed image 11.

    Kubernetes was still using image 10, so I identified that
    Argo CD had not refreshed the latest Git state.

    I forced a hard refresh using:

    kubectl -n argocd annotate application todo-app argocd.argoproj.io/refresh=hard --overwrite

    After synchronization Kubernetes updated to image 11.

---

# 🎤 Interview Question 17

## How do you verify which image Kubernetes is running?

Use:

    kubectl get deployment todo-app -o jsonpath='{.spec.template.spec.containers[0].image}'

If the output is:

    yuvi2102/todo-app:11

then the Deployment is configured to use image 11.

---

# 🎤 Interview Question 18

## How do you verify the application rollout?

Use:

    kubectl rollout status deployment/todo-app

If successful:

    deployment "todo-app" successfully rolled out

---

# 🧠 The Three Most Important Things to Remember

If you remember only three things from this project, remember these.

## 1. Jenkins = CI

    Build
    Test
    SonarQube
    Quality Gate
    Docker Push
    Manifest Update

## 2. GitHub = Source of Truth

    Application Code
    +
    Kubernetes Manifest

## 3. Argo CD = GitOps Deployment

    GitHub
       ↓
    Argo CD
       ↓
    Kubernetes

---

# 🔥 Full Pipeline in One Line

    Developer → GitHub → Jenkins → Docker Build → Django Tests → SonarQube → Quality Gate → Docker Hub → Update Kubernetes YAML → GitHub → Argo CD → Kubernetes → 3 Pods → Service → Live Application

---

# 🏆 Final Project Result

The final application successfully ran inside Kubernetes.

The final Docker image:

    yuvi2102/todo-app:11

The final Kubernetes Deployment used:

    yuvi2102/todo-app:11

The Deployment maintained:

    3 replicas

The Service used:

    NodePort 31000

Argo CD showed:

    Healthy
    Synced

Kubernetes rollout:

    Successfully rolled out

Final application:

    Todo List - Yuvraj

Final access:

    http://100.48.56.207:8000/todos/

---

# 📊 Final Project Status

| Component | Status |
|---|---|
| Django Application | ✅ Working |
| GitHub | ✅ Working |
| Git SSH | ✅ Working |
| Jenkins | ✅ Working |
| Jenkins Docker Access | ✅ Working |
| Docker Build | ✅ Working |
| Django Tests | ✅ Passing |
| SonarQube | ✅ Working |
| Quality Gate | ✅ Passing |
| Docker Hub | ✅ Working |
| Kubernetes | ✅ Working |
| Minikube | ✅ Working |
| Deployment | ✅ Working |
| Service | ✅ Working |
| Argo CD | ✅ Working |
| GitOps | ✅ Working |
| Rolling Update | ✅ Working |
| Final Application | ✅ Working |

---

# 🧠 Complete Mental Model

When I return to this project later, think about it like this:

    ┌─────────────────────────────────────────────┐
    │              APPLICATION SIDE              │
    │                                             │
    │  Django Code → GitHub → Jenkins             │
    │                         │                   │
    │                         ▼                   │
    │                 Build Docker Image           │
    │                         │                   │
    │                         ▼                   │
    │                  Run Django Tests            │
    │                         │                   │
    │                         ▼                   │
    │                    SonarQube                 │
    │                         │                   │
    │                         ▼                   │
    │                   Quality Gate               │
    │                         │                   │
    │                         ▼                   │
    │                    Docker Hub                │
    │                                             │
    └──────────────────────┬──────────────────────┘
                           │
                           │
                           ▼
    ┌─────────────────────────────────────────────┐
    │                GITOPS SIDE                  │
    │                                             │
    │ Jenkins updates deploy/deploy.yaml          │
    │                     │                       │
    │                     ▼                       │
    │                  GitHub                     │
    │                     │                       │
    │                     ▼                       │
    │                 Argo CD                     │
    │                     │                       │
    │                     ▼                       │
    │                Kubernetes                   │
    │                     │                       │
    │             ┌───────┼───────┐               │
    │             ▼       ▼       ▼               │
    │           Pod 1   Pod 2   Pod 3              │
    │             │       │       │               │
    │             └───────┼───────┘               │
    │                     ▼                       │
    │                  Service                    │
    │                     │                       │
    │                     ▼                       │
    │              Django Application             │
    │                                             │
    └─────────────────────────────────────────────┘

---

# 🏁 Final Conclusion

This practical was not just about learning individual tools.

The real learning was understanding how the tools work together.

The application starts as source code in GitHub.

Jenkins automatically takes that source code and performs the CI process:

    Checkout
    ↓
    Build
    ↓
    Test
    ↓
    Analyze
    ↓
    Quality Gate

After the code passes validation, Jenkins creates and pushes a versioned Docker image.

Then Jenkins updates the Kubernetes manifest with that image version and pushes the manifest back to GitHub.

Argo CD watches that Git repository and treats Git as the desired state.

Argo CD then synchronizes Kubernetes.

Kubernetes creates the required Pods and performs the rolling update.

The Kubernetes Service exposes the application.

Finally, the updated Django application becomes available to the user.

The complete project can therefore be remembered as:

    CODE
      ↓
    GITHUB
      ↓
    JENKINS
      ↓
    BUILD
      ↓
    TEST
      ↓
    SONARQUBE
      ↓
    QUALITY GATE
      ↓
    DOCKER HUB
      ↓
    UPDATE GIT MANIFEST
      ↓
    ARGO CD
      ↓
    KUBERNETES
      ↓
    PODS
      ↓
    SERVICE
      ↓
    LIVE APPLICATION

## 🚀 This is the complete end-to-end CI/CD + GitOps practical.
