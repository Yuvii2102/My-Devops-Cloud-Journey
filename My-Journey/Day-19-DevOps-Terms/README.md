<div align="center">

# 🚀 60 DevOps Terms — Easy One-Line Cheat Sheet

</div>

## 🔧 DevOps Basics

| #  | Term                  | Easy Meaning                                                          |
| -- | --------------------- | --------------------------------------------------------------------- |
| 1  | **DevOps**            | Development + Operations working together to deliver software faster. |
| 2  | **CI**                | Developers regularly add their code to one shared place.              |
| 3  | **CD**                | Automatically move tested code toward production.                     |
| 4  | **Pipeline**          | A series of automatic steps: **build → test → deploy**.               |
| 5  | **Artifact**          | The final file created after building an application.                 |
| 6  | **Repository (Repo)** | A place where code is stored.                                         |
| 7  | **Version Control**   | Keeps track of changes made to code.                                  |
| 8  | **Git**               | A tool used to track and manage code changes.                         |
| 9  | **GitHub**            | A website where Git repositories can be stored and shared.            |
| 10 | **Branch**            | A separate line of code used to work on a feature or change.          |

---

## 🐳 Docker

| #  | Term                 | Easy Meaning                                                     |
| -- | -------------------- | ---------------------------------------------------------------- |
| 11 | **Docker**           | A tool used to run applications inside containers.               |
| 12 | **Image**            | A package/template used to create a container.                   |
| 13 | **Container**        | A running application created from an image.                     |
| 14 | **Dockerfile**       | A file containing instructions to create a Docker image.         |
| 15 | **Docker Registry**  | A place where Docker images are stored.                          |
| 16 | **Docker Hub**       | A public website for storing and sharing Docker images.          |
| 17 | **Volume**           | Storage used to keep container data safe.                        |
| 18 | **Containerization** | Putting an application and everything it needs into a container. |

---

## ☸️ Kubernetes

| #  | Term                 | Easy Meaning                                              |
| -- | -------------------- | --------------------------------------------------------- |
| 19 | **Kubernetes (K8s)** | A tool that manages containers.                           |
| 20 | **Cluster**          | A group of machines working together.                     |
| 21 | **Node**             | A machine inside a Kubernetes cluster.                    |
| 22 | **Pod**              | The smallest unit that runs an application in Kubernetes. |
| 23 | **Deployment**       | Makes sure the required number of Pods are running.       |
| 24 | **ReplicaSet**       | Makes sure the correct number of Pods are available.      |
| 25 | **Service**          | Gives Pods a stable way to communicate.                   |
| 26 | **Ingress**          | Sends outside web traffic to the correct Service.         |
| 27 | **Namespace**        | Used to separate resources inside a Kubernetes cluster.   |
| 28 | **ConfigMap**        | Stores normal application settings.                       |
| 29 | **Secret**           | Stores sensitive information like passwords and tokens.   |
| 30 | **HPA**              | Automatically increases or decreases Pods based on load.  |

---

## ☁️ AWS / Cloud

| #  | Term                | Easy Meaning                                            |
| -- | ------------------- | ------------------------------------------------------- |
| 31 | **Cloud Computing** | Using servers and other IT resources over the internet. |
| 32 | **EC2**             | A virtual server in AWS.                                |
| 33 | **VPC**             | Your private network inside AWS.                        |
| 34 | **Subnet**          | A smaller network inside a VPC.                         |
| 35 | **Security Group**  | A firewall that controls traffic to AWS resources.      |
| 36 | **IAM**             | Controls who can access AWS resources.                  |
| 37 | **Load Balancer**   | Distributes traffic between multiple servers.           |
| 38 | **Auto Scaling**    | Automatically adds or removes servers when needed.      |

---

## 🏗️ Terraform

| #  | Term                | Easy Meaning                                                          |
| -- | ------------------- | --------------------------------------------------------------------- |
| 39 | **IaC**             | Creating and managing infrastructure using code.                      |
| 40 | **Terraform**       | A tool used to create cloud infrastructure using code.                |
| 41 | **Provider**        | Connects Terraform to AWS, Azure, Kubernetes, etc.                    |
| 42 | **Resource**        | Something Terraform creates, such as an EC2 instance.                 |
| 43 | **Module**          | Reusable Terraform code.                                              |
| 44 | **State File**      | A file Terraform uses to remember the infrastructure it created.      |
| 45 | **Drift**           | When real infrastructure is different from Terraform's configuration. |
| 46 | **Terraform Plan**  | Shows what Terraform is going to change.                              |
| 47 | **Terraform Apply** | Actually makes those changes.                                         |

---

## 📊 Monitoring & Logging

| #  | Term           | Easy Meaning                                    |
| -- | -------------- | ----------------------------------------------- |
| 48 | **Prometheus** | Collects information/metrics about systems.     |
| 49 | **Grafana**    | Shows metrics using graphs and dashboards.      |
| 50 | **RCA**        | Finding the main reason why a problem happened. |

---

## 🔥 Extra Important Terms

| #  | Term                      | Easy Meaning                                                                            |
| -- | ------------------------- | --------------------------------------------------------------------------------------- |
| 51 | **Helm**                  | A tool used to install and manage applications in Kubernetes.                           |
| 52 | **Chart**                 | A package containing Kubernetes configuration.                                          |
| 53 | **GitOps**                | Using Git to control deployments and infrastructure changes.                            |
| 54 | **Rollback**              | Going back to a previous working version.                                               |
| 55 | **Blue-Green Deployment** | Keep old and new versions ready, then switch traffic to the new one.                    |
| 56 | **Canary Deployment**     | Give the new version to a small number of users first.                                  |
| 57 | **Rolling Update**        | Slowly replace the old version with the new version.                                    |
| 58 | **ELK**                   | Tools used to collect, store, and view logs.                                            |
| 59 | **Alert**                 | A notification that tells you something is wrong.                                       |
| 60 | **Observability**         | Understanding what is happening inside your system using **metrics, logs, and traces**. |

---

# 🧠 DevOps Flow — Remember This

```text
Developer writes code
        ↓
       Git
        ↓
   CI/CD Pipeline
        ↓
   Build & Test
        ↓
   Docker Image
        ↓
   Kubernetes
        ↓
Application Running
        ↓
Prometheus + Grafana
        ↓
Monitor & Fix Problems
```

## 🔥 Super Simple Memory Flow

```text
CODE
 ↓
GIT
 ↓
BUILD
 ↓
TEST
 ↓
DOCKER
 ↓
KUBERNETES
 ↓
APPLICATION
 ↓
MONITORING
 ↓
FIX
```

> **My simple understanding:** I write code → store it in Git → CI/CD builds and tests it → Docker packages it → Kubernetes runs it → Prometheus and Grafana monitor it → I troubleshoot and fix problems.

### 🎯 The most important terms to know first

If I'm preparing for a **DevOps / Cloud Engineer** role, I would make sure I can explain these without looking at notes:

**Git → GitHub → CI/CD → Pipeline → Docker → Image → Container → Kubernetes → Pod → Deployment → Service → AWS → EC2 → VPC → IAM → Security Group → Load Balancer → Terraform → IaC → Prometheus → Grafana → Logs → RCA**
