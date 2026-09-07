# 🚀 End-to-End CI/CD Pipeline for a Django Todo Application

This project demonstrates a complete **CI/CD pipeline** for a Django Todo application using:

- GitHub
- Jenkins
- Docker
- Docker Hub
- SonarQube
- Kubernetes
- Minikube
- Argo CD

The main goal of this project is to understand how a code change can automatically travel through the entire software delivery process:

**Developer → GitHub → Jenkins → Tests → SonarQube → Docker → Docker Hub → Kubernetes → Argo CD → Live Application**

---

# 📌 Project Overview

This project uses a Django Todo application and implements an automated CI/CD pipeline.

Whenever new code is pushed to GitHub:

1. Jenkins checks out the latest source code.
2. Jenkins verifies the repository.
3. Jenkins builds a Docker image.
4. Django tests are executed inside the Docker container.
5. SonarQube performs code analysis.
6. Jenkins waits for the SonarQube Quality Gate.
7. The Docker image is pushed to Docker Hub.
8. Jenkins updates the Kubernetes deployment manifest with the new image tag.
9. Jenkins pushes the updated Kubernetes manifest back to GitHub.
10. Argo CD detects the Git change.
11. Argo CD synchronizes the Kubernetes cluster.
12. Kubernetes performs a rolling update.
13. The new version of the application becomes available.

---

# 🏗️ Architecture

    mermaid
    flowchart LR
        A[Developer] --> B[GitHub Repository]
        B --> C[Jenkins]

        C --> D[Checkout]
        D --> E[Build Docker Image]
        E --> F[Django Tests]
        F --> G[SonarQube Analysis]
        G --> H[Quality Gate]

        H --> I[Docker Hub]
        H --> J[Update Kubernetes Manifest]

        J --> B

        B --> K[Argo CD]
        K --> L[Kubernetes / Minikube]

        L --> M[Todo Deployment]
        M --> N[Todo Service]
        N --> O[Live Django Application]

---

# 🔧 Technologies Used

| Technology | Purpose |
|---|---|
| Git | Version control |
| GitHub | Source code repository |
| Jenkins | CI/CD automation |
| Docker | Application containerization |
| Docker Hub | Container image registry |
| SonarQube | Static code analysis |
| Kubernetes | Container orchestration |
| Minikube | Local Kubernetes cluster |
| Argo CD | GitOps continuous delivery |
| Django | Application framework |
| Python 3.10 | Application runtime |

---

# 📁 Project Structure

    cicd-end-to-end/
    ├── Dockerfile
    ├── Jenkinsfile
    ├── README.md
    ├── docker-compose.yml
    ├── db.sqlite3
    ├── manage.py
    ├── sonar-project.properties
    ├── staticfiles/
    ├── todoApp/
    ├── todos/
    │   ├── models.py
    │   ├── views.py
    │   ├── urls.py
    │   └── templates/
    │       └── todos/
    │           └── index.html
    └── deploy/
        ├── deploy.yaml
        ├── service.yaml
        └── pod.yaml

---

# 🐍 Django Application

The application is a simple Todo application built using Django.

The application contains the normal Django project structure with:

- Models
- Views
- URLs
- Templates
- Database
- Static files

The application was also modified to display:

    Todo List - Yuvraj

This modification was useful for verifying that the complete CI/CD pipeline actually deployed the latest application version.

---

# 🐳 Dockerization

The application is packaged into a Docker image.

The Dockerfile used in the project is:

    FROM python:3.10
    RUN pip install django==3.2
    COPY . .
    RUN python manage.py migrate
    EXPOSE 8000
    CMD ["python","manage.py","runserver","0.0.0.0:8000"]

## Dockerfile Explanation

`FROM python:3.10`

Uses Python 3.10 as the base image.

`RUN pip install django==3.2`

Installs the required Django version.

`COPY . .`

Copies the application source code into the container.

`RUN python manage.py migrate`

Runs Django database migrations while building the image.

`EXPOSE 8000`

Documents that the Django application listens on port 8000.

`CMD`

Starts the Django development server and makes it accessible outside the container.

---

# 🧪 Django Test

A Django model test was added to verify Todo creation.

    from django.test import TestCase
    from .models import Todo


    class TodoModelTest(TestCase):

        def test_todo_creation(self):
            todo = Todo.objects.create(
                title="Learn CI/CD"
            )

            self.assertEqual(todo.title, "Learn CI/CD")

This test verifies that a Todo object can be created successfully and that its title is stored correctly.

The test was committed with:

    e54c143 Add Django model test

---

# 🔍 SonarQube Configuration

The project contains a `sonar-project.properties` file.

    sonar.projectKey=todo-app
    sonar.projectName=todo-app
    sonar.sources=todoApp,todos
    sonar.python.version=3.10
    sonar.exclusions=**/migrations/**,**/staticfiles/**,**/*.pyc

## Configuration Explanation

`sonar.projectKey`

Identifies the project inside SonarQube.

`sonar.projectName`

Defines the project name displayed in SonarQube.

`sonar.sources`

Specifies the application source directories.

`sonar.python.version`

Tells SonarQube that the project uses Python 3.10.

`sonar.exclusions`

Excludes migration files, static files and compiled Python files from analysis.

---

# 🏗️ Jenkins Pipeline

The Jenkins job used for this project is:

    todo-app-ci

Jenkins is responsible for implementing the Continuous Integration part of the project and also preparing the deployment change for GitOps.

The pipeline contains these stages:

    Checkout
        ↓
    Verify Repository
        ↓
    Build Docker Image
        ↓
    Run Django Tests
        ↓
    SonarQube Analysis
        ↓
    Quality Gate
        ↓
    Push Docker Image
        ↓
    Update Kubernetes Manifest

---

# 📜 Jenkinsfile

The working Jenkinsfile is:

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

# 🔢 Dynamic Docker Image Tagging

The pipeline uses Jenkins `BUILD_NUMBER` to create unique Docker image versions.

For example:

    Build #10
    → yuvi2102/todo-app:10

    Build #11
    → yuvi2102/todo-app:11

This is better than continuously using a fixed tag such as `latest` because every build has a unique version.

---

# 🐳 Docker Hub

The Docker image repository is:

    yuvi2102/todo-app

The pipeline pushes images such as:

    yuvi2102/todo-app:10
    yuvi2102/todo-app:11

The Docker Hub credentials are stored in Jenkins using the credential ID:

    dockerhub-credentials

The Docker password is not written directly inside the Jenkinsfile.

Instead, Jenkins injects it securely using:

    withCredentials

---

# 🔐 Jenkins Credentials

The Jenkins pipeline uses credentials instead of hardcoding secrets.

## GitHub SSH Credential

Credential ID:

    github-ssh

Type:

    SSH Username with private key

Username:

    git

Description:

    GitHub SSH access for Jenkins

## SonarQube Credential

Credential ID:

    sonarqube-token

This token allows Jenkins to communicate with SonarQube securely.

## Docker Hub Credential

Credential ID:

    dockerhub-credentials

This is used for authenticating with Docker Hub before pushing images.

---

# 🔑 GitHub SSH Authentication

The Ubuntu server was able to authenticate with GitHub using SSH.

The successful authentication response was:

    Hi Yuvii2102! You've successfully authenticated, but GitHub does not provide shell access.

This confirms that SSH authentication with GitHub was working.

Jenkins uses its own Jenkins credential rather than depending on the Ubuntu user's SSH configuration.

---

# ⚙️ Jenkins Configuration

Jenkins version used:

    2.568.3

Jenkins can access Docker:

    Docker version 29.1.3

The Jenkins user was added to the Docker group so that Jenkins can execute Docker commands.

The Docker group contained:

    ubuntu
    jenkins

---

# 🔎 SonarQube Configuration in Jenkins

The Jenkins global SonarQube server configuration is:

    Name:
    SonarQube

    URL:
    http://localhost:9000

The SonarQube token is stored using the Jenkins credential:

    sonarqube-token

The scanner tool is configured as:

    Name:
    SonarQubeScanner

    Version:
    SonarQube Scanner 8.1.0.6389

---

# 🧹 SonarQube Quality Gate

The pipeline does not simply run SonarQube analysis and continue.

It waits for the Quality Gate:

    waitForQualityGate abortPipeline: true

This means:

    Code
      ↓
    SonarQube Analysis
      ↓
    Quality Gate
      ↓
    Continue only if the gate passes

If the Quality Gate fails, the pipeline can be stopped before the Docker image is pushed.

In the successful builds, the SonarQube Quality Gate passed.

---

# ☸️ Kubernetes

Kubernetes is used to run the application containers.

Minikube is used as the Kubernetes cluster.

The cluster was started using:

    minikube start

The cluster was verified using:

    kubectl get nodes

The result showed:

    NAME       STATUS   ROLES           AGE   VERSION
    minikube   Ready    control-plane   10d   v1.35.1

This confirms that the Kubernetes node was ready.

---

# 📦 Kubernetes Deployment

The deployment file is:

    deploy/deploy.yaml

The important configuration is:

    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: todo-app
      labels:
        app: nginx
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

The important part is:

    replicas: 3

This means Kubernetes runs three application Pods.

The image is dynamically updated by Jenkins for every successful build.

For example:

    Build 10 → yuvi2102/todo-app:10

    Build 11 → yuvi2102/todo-app:11

---

# 🌐 Kubernetes Service

The application is exposed through:

    deploy/service.yaml

Configuration:

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

## Service Explanation

The Django application listens on:

    8000

The Kubernetes Service exposes:

    80

The NodePort is:

    31000

Traffic flow:

    Browser
       ↓
    NodePort 31000
       ↓
    Service port 80
       ↓
    Pod port 8000
       ↓
    Django Application

---

# 📊 Kubernetes Deployment Verification

The Kubernetes Service was:

    todo-service   NodePort   10.105.124.47   <none>   80:31000/TCP

The application had three endpoints:

    10.244.0.90:8000
    10.244.0.91:8000
    10.244.0.92:8000

This confirms that the Service had three application Pods behind it.

The deployment successfully rolled out:

    deployment "todo-app" successfully rolled out

---

# 🔄 Kubernetes Rolling Update

When Jenkins changes:

    image: yuvi2102/todo-app:10

to:

    image: yuvi2102/todo-app:11

Argo CD detects the Git change and updates Kubernetes.

Kubernetes then creates Pods using the new image and gradually replaces the old Pods.

This provides a rolling deployment rather than manually deleting everything.

After Build #11, the running Pods were:

    todo-app-f48b6bf6-qd8pt   1/1 Running
    todo-app-f48b6bf6-qvrwq   1/1 Running
    todo-app-f48b6bf6-zsg4p   1/1 Running

---

# 🌳 GitOps with Argo CD

Argo CD is responsible for the Continuous Delivery part of the pipeline.

The important concept is:

    Git Repository
          ↓
       Argo CD
          ↓
      Kubernetes

Argo CD continuously watches the desired state stored in Git.

If Git says:

    image: yuvi2102/todo-app:11

Argo CD ensures that Kubernetes eventually runs that version.

---

# 🚀 Argo CD Installation

The namespace was created using:

    kubectl create namespace argocd

Argo CD was installed using:

    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

The main Argo CD components became Running.

Argo CD version shown in the UI:

    v3.5.2

---

# 🌐 Argo CD UI

The Argo CD server was exposed as a NodePort using:

    kubectl patch svc argocd-server -n argocd -p '{"spec":{"type":"NodePort"}}'

The service exposed:

    80:30994
    443:31761

The UI was also accessed using port forwarding:

    kubectl port-forward svc/argocd-server -n argocd 8081:443 --address=0.0.0.0

The Argo CD UI was accessed through the server IP and port 8081.

---

# 📱 Argo CD Application

The Argo CD application is:

    todo-app

Configuration:

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

Argo CD eventually showed:

    Healthy
    Synced

---

# 🔄 Complete GitOps Flow

The most important part of this project is understanding how the image update reaches Kubernetes.

Suppose Build #11 succeeds.

Jenkins builds:

    todo-app:11

Then tags it:

    yuvi2102/todo-app:11

Jenkins pushes it:

    Docker Hub
    yuvi2102/todo-app:11

Then Jenkins changes:

    deploy/deploy.yaml

from the previous image version to:

    image: yuvi2102/todo-app:11

Jenkins commits the change and pushes it to:

    GitHub main

Argo CD detects the Git change.

Argo CD synchronizes the Kubernetes cluster.

Kubernetes updates the Deployment.

New Pods are created using:

    yuvi2102/todo-app:11

The application then runs the latest version.

---

# 🔁 End-to-End Pipeline Flow

    Developer changes code
            ↓
        git push
            ↓
        GitHub
            ↓
        Jenkins
            ↓
        Checkout
            ↓
        Verify Repository
            ↓
        Docker Build
            ↓
        Django Tests
            ↓
        SonarQube Analysis
            ↓
        Quality Gate
            ↓
        Docker Hub Push
            ↓
        Update deploy/deploy.yaml
            ↓
        Git Push
            ↓
        GitHub main
            ↓
        Argo CD detects change
            ↓
        Argo CD Sync
            ↓
        Kubernetes Deployment
            ↓
        3 Pods
            ↓
        Kubernetes Service
            ↓
        Django Application
            ↓
        User

---

# 🧠 CI vs CD in This Project

## Continuous Integration

Jenkins handles the CI portion.

CI includes:

    Checkout
    ↓
    Build
    ↓
    Test
    ↓
    SonarQube Analysis
    ↓
    Quality Gate

The purpose is to verify that the code is healthy before it is released.

## Continuous Delivery / Deployment

Argo CD handles the GitOps deployment portion.

The flow is:

    Git
     ↓
    Argo CD
     ↓
    Kubernetes
     ↓
    Application

So the responsibilities are separated:

    Jenkins
    = Build + Test + Quality + Image + Manifest Update

    Argo CD
    = GitOps Deployment

---

# 🛠️ Important Commands Used

## Start Minikube

    minikube start

## Check Kubernetes Nodes

    kubectl get nodes

## Apply Deployment

    kubectl apply -f deploy/deploy.yaml

## Apply Service

    kubectl apply -f deploy/service.yaml

## Check Pods

    kubectl get pods

## Check Deployment

    kubectl get deployment

## Check Services

    kubectl get svc

## Check Endpoints

    kubectl get endpoints

## Check Rollout

    kubectl rollout status deployment/todo-app

## Check Current Kubernetes Image

    kubectl get deployment todo-app -o jsonpath='{.spec.template.spec.containers[0].image}'

## View GitHub Manifest

    git show origin/main:deploy/deploy.yaml | grep "image:"

## Refresh Argo CD Application

    kubectl -n argocd annotate application todo-app argocd.argoproj.io/refresh=hard --overwrite

---

# 🌐 Accessing the Todo Application

The Kubernetes Service can be tested using Minikube.

The Minikube Service URL was:

    http://192.168.49.2:31000

The application was also exposed through Kubernetes port forwarding:

    kubectl port-forward svc/todo-service 8000:80 --address=0.0.0.0

Then the application was accessed through:

    http://100.48.56.207:8000/todos/

The final application displayed:

    Todo List - Yuvraj

This was the final proof that the application change successfully passed through the complete CI/CD pipeline.

---

# 🔀 Why Port 8000?

The Django application listens on:

    8000

The Kubernetes Service maps:

    Service port 80
        ↓
    targetPort 8000

When using port forwarding:

    Local port 8000
        ↓
    Service port 80
        ↓
    Django container port 8000

---

# ⚠️ Normal Django Redirect

When testing:

    curl -I http://localhost:8000/todos

The response was:

    HTTP/1.1 301 Moved Permanently
    Location: /todos/

This is normal Django URL behavior.

The correct browser URL is:

    /todos/

So:

    http://100.48.56.207:8000/todos/

---

# 🐛 Troubleshooting Encountered

## 1. Jenkins Git Push Failed

The first Git push attempt failed with:

    error: src refspec main does not match any

### Why?

Jenkins checks out the repository in a detached HEAD state.

Therefore Jenkins does not necessarily have a local branch named `main`.

### Incorrect approach

    git push origin main

### Correct approach

    git push origin HEAD:main

This pushes the commit currently checked out by Jenkins to the remote `main` branch.

---

# 🐛 2. Dockerfile Python Version Problem

The original Dockerfile used:

    FROM python:3

It was changed to:

    FROM python:3.10

This provided a stable Python version matching the project configuration and SonarQube configuration.

---

# 🐛 3. Kubernetes Image Did Not Immediately Change

After Jenkins Build #11, GitHub showed:

    image: yuvi2102/todo-app:11

But Kubernetes was initially still running:

    yuvi2102/todo-app:10

### Why?

Argo CD had not immediately refreshed the Git state.

A hard refresh was triggered using:

    kubectl -n argocd annotate application todo-app argocd.argoproj.io/refresh=hard --overwrite

After synchronization, Kubernetes updated to:

    yuvi2102/todo-app:11

---

# 🐛 4. Port 8000 Already in Use

When trying to run:

    kubectl port-forward svc/todo-service 8000:80 --address=0.0.0.0

again, the command returned:

    Unable to listen on port 8000
    bind: address already in use

### Why?

The existing port-forward process was already using port 8000.

This means the original port-forward was still running.

There was no need to start another one.

---

# 🐛 5. Local Git Branch Was Behind GitHub

Jenkins modifies and pushes:

    deploy/deploy.yaml

Therefore GitHub can contain commits that the local Ubuntu branch does not have.

The local branch was synchronized using:

    git pull --rebase origin main
    git push origin main

This brought the local branch up to date with GitHub.

---

# 🧩 Important Kubernetes Concepts Learned

## Deployment

A Deployment manages application Pods and maintains the desired number of replicas.

In this project:

    replicas: 3

Therefore three application Pods are maintained.

## Pod

A Pod is the smallest deployable unit in Kubernetes.

The Django container runs inside the Pod.

## Service

A Service provides stable networking to the Pods.

The Service selects Pods using:

    selector:
      app: nginx

## NodePort

NodePort exposes the Service through a port on the Kubernetes node.

In this project:

    nodePort: 31000

## Argo CD

Argo CD watches Git and synchronizes the desired state into Kubernetes.

---

# 🧠 Most Important Interview Explanation

If asked:

**"Explain your CI/CD project."**

A good answer is:

    I built an end-to-end CI/CD pipeline for a Django Todo application.

    The source code is maintained in GitHub. Jenkins is used for
    continuous integration. Whenever a change is pushed, Jenkins checks
    out the code, builds a Docker image, runs Django tests, performs
    SonarQube analysis and waits for the Quality Gate.

    If the Quality Gate passes, Jenkins pushes the versioned Docker image
    to Docker Hub. Jenkins then updates the Kubernetes deployment
    manifest with the current Jenkins build number and pushes that
    manifest back to GitHub.

    Argo CD follows a GitOps approach. It watches the Kubernetes manifests
    in GitHub and synchronizes the desired state into the Kubernetes
    cluster.

    Kubernetes then performs the deployment using the new Docker image.
    The application runs with three replicas and is exposed through a
    Kubernetes NodePort Service.

    So the complete flow is:

    GitHub → Jenkins → Docker → Tests → SonarQube → Docker Hub
    → GitHub Manifest Update → Argo CD → Kubernetes → Application

---

# 🎯 Why Use Jenkins and Argo CD Together?

Jenkins and Argo CD have different responsibilities.

Jenkins is responsible for:

    Build
    Test
    Code Quality
    Docker Image
    Updating Git

Argo CD is responsible for:

    Deployment
    Synchronization
    GitOps
    Kubernetes desired state

This separation makes the pipeline cleaner.

Instead of Jenkins directly running:

    kubectl apply

Jenkins updates Git.

Argo CD sees the Git change and performs the deployment.

That is the main GitOps idea demonstrated by this project.

---

# 🏷️ Why Use Build Numbers as Image Tags?

Instead of:

    yuvi2102/todo-app:latest

the project uses:

    yuvi2102/todo-app:10
    yuvi2102/todo-app:11
    ...

This gives each build a unique version.

For example:

    Build 10 → Version 10
    Build 11 → Version 11
    Build 12 → Version 12

This makes it easier to identify which application version is running.

---

# 🔄 Why Update the Kubernetes Manifest?

The Kubernetes Deployment contains the Docker image version.

For example:

    image: yuvi2102/todo-app:11

When a new image is created, Kubernetes needs to know which image version to deploy.

Jenkins updates this value automatically.

Therefore:

    New Build
        ↓
    New Docker Image
        ↓
    New Image Tag
        ↓
    Update Kubernetes Manifest
        ↓
    Git Commit
        ↓
    Argo CD
        ↓
    Kubernetes

---

# 🏆 Final Successful Build

Build #11 successfully completed the complete pipeline.

The image was:

    yuvi2102/todo-app:11

The pipeline successfully completed:

    Checkout
    ✓

    Repository Verification
    ✓

    Docker Build
    ✓

    Django Tests
    ✓

    SonarQube Analysis
    ✓

    Quality Gate
    ✓

    Docker Hub Push
    ✓

    Kubernetes Manifest Update
    ✓

    GitHub Push
    ✓

    Argo CD Sync
    ✓

    Kubernetes Rollout
    ✓

The final Kubernetes Pods were running successfully.

---

# 🎉 Final Result

The final live application showed:

    Todo List - Yuvraj

This confirmed that the code change made in the Django application successfully traveled through:

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
    Kubernetes Manifest
       ↓
    GitHub
       ↓
    Argo CD
       ↓
    Kubernetes
       ↓
    Todo Application

---

# 💡 Key Takeaways

From this project, I learned:

- How Jenkins performs CI automation.
- How to create a Docker image for a Django application.
- How to run Django tests inside a Docker container.
- How SonarQube integrates with Jenkins.
- How Quality Gates protect the pipeline.
- How to push Docker images to Docker Hub.
- How Jenkins credentials protect secrets.
- How Kubernetes Deployments manage Pods.
- How Kubernetes Services expose applications.
- How NodePort works.
- How Minikube provides a Kubernetes environment.
- How Argo CD implements GitOps.
- How Git can act as the source of truth for Kubernetes.
- How Jenkins can update Kubernetes manifests.
- How Kubernetes performs rolling updates.
- How to troubleshoot Jenkins Git authentication and detached HEAD issues.
- How to troubleshoot Argo CD synchronization.
- How to verify the complete CI/CD deployment.

---

# 🚀 Final Architecture Summary

    ┌───────────────┐
    │   Developer   │
    └───────┬───────┘
            │
            │ git push
            ▼
    ┌───────────────┐
    │    GitHub     │
    └───────┬───────┘
            │
            ▼
    ┌───────────────┐
    │    Jenkins    │
    └───────┬───────┘
            │
            ├── Checkout
            │
            ├── Docker Build
            │
            ├── Django Tests
            │
            ├── SonarQube
            │
            ├── Quality Gate
            │
            ├── Docker Hub Push
            │
            └── Update Git Manifest
                       │
                       ▼
                  ┌──────────┐
                  │  GitHub  │
                  └────┬─────┘
                       │
                       ▼
                 ┌──────────┐
                 │ Argo CD  │
                 └────┬─────┘
                      │
                      ▼
              ┌─────────────────┐
              │    Kubernetes   │
              │    / Minikube   │
              └────────┬────────┘
                       │
                       ▼
                 ┌───────────┐
                 │ Deployment│
                 │ 3 Replicas │
                 └─────┬─────┘
                       │
                       ▼
                 ┌───────────┐
                 │  Service  │
                 │ NodePort  │
                 └─────┬─────┘
                       │
                       ▼
                ┌──────────────┐
                │ Django Todo  │
                │     App      │
                └──────────────┘

---

# ✅ Project Status

    GitHub                    ✅
    Jenkins                   ✅
    Docker                    ✅
    Docker Hub                ✅
    Django Tests              ✅
    SonarQube                 ✅
    Quality Gate              ✅
    Kubernetes                ✅
    Minikube                  ✅
    Argo CD                   ✅
    GitOps                    ✅
    Rolling Deployment        ✅
    Final Application         ✅

---

# 🏁 Conclusion

This project demonstrates a complete real-world style CI/CD and GitOps workflow.

The important idea is not just running Jenkins or Kubernetes individually.

The important part is connecting everything together:

    Code
      ↓
    Build
      ↓
    Test
      ↓
    Analyze
      ↓
    Package
      ↓
    Push
      ↓
    Update Git
      ↓
    Synchronize
      ↓
    Deploy
      ↓
    Run

The final result is an automated pipeline where a developer can make a code change, push it to GitHub, and the change can travel through Jenkins, Docker, SonarQube, Docker Hub, Argo CD and Kubernetes until the updated application is running.

**This is the complete end-to-end CI/CD project. 🚀**
