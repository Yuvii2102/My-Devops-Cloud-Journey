# DAY 14 — KUBERNETES PODS | DEPLOY YOUR FIRST NGINX APP

<p align="center">

<img src="https://img.shields.io/badge/Kubernetes-Pods-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white"/>
<img src="https://img.shields.io/badge/Docker-Container_Runtime-2496ED?style=for-the-badge&logo=docker&logoColor=white"/>
<img src="https://img.shields.io/badge/Minikube-Lab-FF6B35?style=for-the-badge&logo=kubernetes&logoColor=white"/>
<img src="https://img.shields.io/badge/NGINX-Web_Server-009639?style=for-the-badge&logo=nginx&logoColor=white"/>

</p>

<p align="center">
<b>Deploying My First NGINX Application Using a Kubernetes Pod</b>
</p>

---

## 📌 Overview

In this lab, I created my first Kubernetes Pod and deployed an **NGINX web server** inside it.

The complete lab was performed on an **AWS EC2 Ubuntu instance** using:

* 🐧 Ubuntu
* 🐳 Docker
* ☸️ Kubernetes
* 🚀 Minikube
* 🛠️ kubectl
* 🌐 NGINX

### 🎯 Main Goals

* Understand what a Kubernetes Pod is
* Install and configure Docker
* Install and configure Minikube
* Install kubectl
* Start a Kubernetes cluster
* Create a Pod using YAML
* Deploy an NGINX container
* Check Pod status
* Find the Pod IP
* Access the Pod from inside Minikube
* Inspect the Pod
* Understand basic Kubernetes troubleshooting

---

# 🏗️ LAB ARCHITECTURE

```text
                         AWS EC2
                    Ubuntu Linux Server
                           │
                           │
                           ▼
                    ┌─────────────┐
                    │   Docker    │
                    └──────┬──────┘
                           │
                           │ Docker Driver
                           ▼
                    ┌─────────────┐
                    │  Minikube   │
                    │   Cluster   │
                    └──────┬──────┘
                           │
                           │ Kubernetes
                           ▼
                    ┌─────────────┐
                    │     Pod     │
                    │    nginx    │
                    └──────┬──────┘
                           │
                           ▼
                    ┌─────────────┐
                    │    NGINX    │
                    │   Port 80   │
                    └─────────────┘
```

---

# 🧠 WHAT IS A KUBERNETES POD?

A **Pod** is the smallest deployable unit in Kubernetes.

A Pod can contain one or more containers.

In this lab, the Pod contains one NGINX container.

```text
Pod
 └── NGINX Container
       └── nginx:1.14.2
```

### Pod Details

| Component      | Value          |
| -------------- | -------------- |
| Pod Name       | `nginx`        |
| Container Name | `nginx`        |
| Image          | `nginx:1.14.2` |
| Container Port | `80`           |
| Namespace      | `default`      |
| Node           | `minikube`     |
| Pod IP         | `10.244.0.3`   |

---

# 🖥️ STEP 1 — CHECK SYSTEM RESOURCES

Before installing Kubernetes tools, I checked the available memory.

```bash
free -h
```

Example output:

```text
               total        used        free
Mem:            7.6Gi       518Mi       7.0Gi
Swap:              0B          0B
```

This confirmed that the EC2 instance had enough memory for the Minikube lab.

---

# 🐧 STEP 2 — UPDATE UBUNTU

First, update the package information.

```bash
sudo apt update
```

This downloaded the latest package information from the Ubuntu repositories.

---

# 🐳 STEP 3 — INSTALL DOCKER

Install Docker:

```bash
sudo apt install docker.io
```

Docker installed the required components including:

```text
docker.io
containerd
runc
bridge-utils
```

---

# ▶️ STEP 4 — START DOCKER

Start Docker:

```bash
sudo systemctl start docker
```

Enable Docker to start automatically after reboot:

```bash
sudo systemctl enable docker
```

Check Docker status:

```bash
sudo systemctl status docker
```

Expected result:

```text
Active: active (running)
```

This confirms that Docker is running correctly.

---

# 👤 STEP 5 — ALLOW THE USER TO USE DOCKER

Add the current user to the Docker group:

```bash
sudo usermod -aG docker $USER
```

Apply the group change:

```bash
newgrp docker
```

Test Docker:

```bash
docker ps
```

At this stage there were no application containers running yet.

```text
CONTAINER ID   IMAGE   COMMAND   CREATED   STATUS   PORTS   NAMES
```

---

# 🚀 STEP 6 — INSTALL MINIKUBE

Download Minikube:

```bash
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
```

Install it:

```bash
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

Remove the downloaded file:

```bash
rm minikube-linux-amd64
```

Check the version:

```bash
minikube version
```

Output:

```text
minikube version: v1.38.1
commit: c93a4cb9311efc66b90d33ea03f75f2c4120e9b0
```

---

# ☸️ STEP 7 — START MINIKUBE USING DOCKER

Start Minikube with the Docker driver:

```bash
minikube start --driver=docker
```

Important details from the lab:

```text
Minikube version : v1.38.1
Kubernetes       : v1.35.1
Driver           : Docker
Cluster          : minikube
Node             : Control Plane
```

Minikube created a Docker container for the Kubernetes environment.

---

# ⚠️ DOCKER DISK SPACE WARNING

During Minikube startup, Docker reported:

```text
Docker is nearly out of disk space
```

The system showed that around **89% of the available capacity** was being used.

Suggested cleanup:

```bash
docker system prune
```

Another option when using the Docker runtime:

```bash
minikube ssh -- docker system prune
```

### ⚠️ Important

Be careful with:

```bash
docker system prune -a
```

because it can remove unused Docker images and containers.

---

# ⚠️ STEP 8 — MINIKUBE COMMAND MISTAKES

I accidentally typed:

```bash
minikube sttaus
```

which returned:

```text
Error: unknown command "sttaus" for "minikube"
```

Then:

```bash
minikube staus
```

which was also incorrect.

The correct command is:

```bash
minikube status
```

### 🧠 Lesson

Always check the exact command spelling when working with CLI tools.

---

# ✅ STEP 9 — CHECK MINIKUBE STATUS

Run:

```bash
minikube status
```

Output:

```text
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```

This confirms that the Minikube Kubernetes cluster is working correctly.

---

# 🛠️ STEP 10 — INSTALL KUBECTL

Initially, kubectl was not installed.

Running:

```bash
kubectl config current-context
```

returned:

```text
Command 'kubectl' not found
```

Install kubectl:

```bash
sudo snap install kubectl --classic
```

Check the client version:

```bash
kubectl version --client
```

Output:

```text
Client Version: v1.36.3
Kustomize Version: v5.8.1
```

---

# 🔍 STEP 11 — CHECK MINIKUBE VERSION

```bash
minikube version
```

Output:

```text
minikube version: v1.38.1
commit: c93a4cb9311efc66b90d33ea03f75f2c4120e9b0
```

---

# 🐳 STEP 12 — CHECK THE MINIKUBE DOCKER CONTAINER

Run:

```bash
docker ps
```

Minikube itself appears as a Docker container.

Example:

```text
CONTAINER ID   IMAGE                                STATUS
11dc7929af65   gcr.io/k8s-minikube/kicbase:v0.0.50 Up 2 minutes
```

Container name:

```text
minikube
```

This shows that Minikube is running using Docker because the Docker driver was selected.

---

# ☸️ STEP 13 — CHECK KUBERNETES NODES

Run:

```bash
kubectl get nodes
```

Output:

```text
NAME       STATUS   ROLES           AGE     VERSION
minikube   Ready    control-plane   2m39s   v1.35.1
```

The node is:

```text
minikube
```

Status:

```text
Ready
```

This means Kubernetes is ready to schedule workloads.

---

# 📦 STEP 14 — CHECK PODS BEFORE DEPLOYMENT

Run:

```bash
kubectl get pods
```

Output:

```text
No resources found in default namespace.
```

This is expected because no application Pod had been created in the `default` namespace yet.

To see Pods from all namespaces:

```bash
kubectl get pods -A
```

This displayed Kubernetes system Pods such as:

```text
coredns
etcd-minikube
kube-apiserver-minikube
kube-controller-manager-minikube
kube-proxy
kube-scheduler-minikube
storage-provisioner
```

These are Kubernetes system components.

---

# 📝 STEP 15 — CREATE THE POD YAML FILE

Create the YAML file:

```bash
vi pod.yml
```

The Pod configuration used in this lab:

```yaml
apiVersion: v1
kind: Pod

metadata:
  name: nginx

spec:
  containers:
    - name: nginx
      image: nginx:1.14.2
      ports:
        - containerPort: 80
```

---

# 🔎 UNDERSTANDING THE YAML

## `apiVersion`

```yaml
apiVersion: v1
```

Specifies the Kubernetes API version.

---

## `kind`

```yaml
kind: Pod
```

Tells Kubernetes that we want to create a Pod.

---

## `metadata`

```yaml
metadata:
  name: nginx
```

The Pod name is:

```text
nginx
```

---

## `containers`

```yaml
spec:
  containers:
```

Defines the container or containers inside the Pod.

---

## Container Name

```yaml
- name: nginx
```

The container is named:

```text
nginx
```

---

## Container Image

```yaml
image: nginx:1.14.2
```

The Pod uses:

```text
nginx:1.14.2
```

---

## Container Port

```yaml
ports:
  - containerPort: 80
```

NGINX listens on:

```text
Port 80
```

---

# 🚀 STEP 16 — CREATE THE KUBERNETES POD

Apply the YAML:

```bash
kubectl create -f pod.yml
```

Output:

```text
pod/nginx created
```

This means Kubernetes successfully created the Pod.

---

# 🔍 STEP 17 — CHECK THE POD

Run:

```bash
kubectl get pod -o wide
```

Output:

```text
NAME    READY   STATUS    RESTARTS   AGE   IP           NODE
nginx   1/1     Running   0          19s   10.244.0.3   minikube
```

### Pod Information

| Field    | Value        |
| -------- | ------------ |
| Name     | `nginx`      |
| Ready    | `1/1`        |
| Status   | `Running`    |
| Restarts | `0`          |
| IP       | `10.244.0.3` |
| Node     | `minikube`   |

---

# 🧠 WHAT DOES `1/1` MEAN?

```text
READY: 1/1
```

means:

```text
1 container is ready
out of 1 container
```

So the NGINX container is healthy and ready.

---

# 🌐 UNDERSTANDING THE POD IP

Our Pod received this IP:

```text
10.244.0.3
```

This is the internal IP assigned to the Pod.

It is **not the public IP of the EC2 instance**.

The Pod is running inside the Kubernetes network.

```text
EC2 Public IP
      │
      │
      ▼
Kubernetes / Minikube
      │
      ▼
Pod IP
10.244.0.3
```

---

# 🔐 STEP 18 — ENTER THE MINIKUBE ENVIRONMENT

Run:

```bash
minikube ssh
```

This opens a shell inside the Minikube node.

The prompt changes to:

```text
docker@minikube:~$
```

This means we are now inside the Minikube environment.

---

# ⚠️ HOST VS MINIKUBE ENVIRONMENT

At one point I tried:

```bash
cat pod.yml
```

inside Minikube.

It returned:

```text
cat: pod.yml: No such file or directory
```

### Why?

The YAML file was created on the EC2 Ubuntu host.

```text
EC2 Ubuntu Host
│
└── pod.yml
```

Minikube is a separate environment:

```text
Minikube Node
│
└── pod.yml
   does not automatically exist here
```

Running:

```bash
minikube ssh
```

does not mean that you are still working directly in the EC2 host environment.

---

# 🐳 STEP 19 — CHECK KUBERNETES CONTAINERS INSIDE MINIKUBE

Inside Minikube:

```bash
docker ps
```

This showed the NGINX container:

```text
f04149eef1d7   nginx   "nginx -g 'daemon of..."   Up 16 minutes
```

The container name was similar to:

```text
k8s_nginx_nginx_default_...
```

This shows that Kubernetes created and started the actual NGINX container.

---

# 🧩 KUBERNETES POD + CONTAINER RELATIONSHIP

```text
Kubernetes
    │
    ▼
  Pod: nginx
    │
    ├── NGINX container
    │      └── nginx:1.14.2
    │
    └── pause container
```

The `pause` container is part of Kubernetes Pod infrastructure.

---

# 🌐 STEP 20 — TEST NGINX USING THE POD IP

Inside Minikube:

```bash
curl 10.244.0.3
```

This successfully returned the NGINX HTML page.

The response included:

```html
<title>Welcome to nginx!</title>
```

and:

```html
<h1>Welcome to nginx!</h1>
```

It also showed:

```text
If you see this page, the nginx web server is successfully installed and working.
```

This proves that the NGINX application is running correctly inside the Kubernetes Pod.

---

# 🔄 APPLICATION FLOW

```text
curl request
     │
     ▼
10.244.0.3
     │
     ▼
NGINX Pod
     │
     ▼
NGINX Container
     │
     ▼
Port 80
     │
     ▼
NGINX HTML Response
```

---

# 🔍 STEP 21 — CHECK THE POD AGAIN

Exit Minikube:

```bash
exit
```

Then:

```bash
kubectl get pods
```

Output:

```text
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          15m
```

Check more information:

```bash
kubectl get pods -o wide
```

Output:

```text
NAME    READY   STATUS    RESTARTS   AGE   IP           NODE
nginx   1/1     Running   0          15m   10.244.0.3   minikube
```

---

# 🔎 STEP 22 — CHECK THE NODE AGAIN

```bash
kubectl get nodes
```

Output:

```text
NAME       STATUS   ROLES           AGE   VERSION
minikube   Ready    control-plane   21m   v1.35.1
```

The Kubernetes node is healthy.

---

# ⚠️ STEP 23 — TRY TO EXPOSE THE POD

I tried:

```bash
kubectl expose pod nginx --type=NodePort --port=80
```

But Kubernetes returned:

```text
error: couldn't retrieve selectors via --selector flag or introspection:
the pod has no labels and cannot be exposed
```

---

# 🧠 WHY DID THE EXPOSE COMMAND FAIL?

The Pod YAML does not contain any labels.

Current metadata:

```yaml
metadata:
  name: nginx
```

There is no:

```yaml
labels:
```

A Service normally uses labels to select the Pods that should receive traffic.

For example:

```yaml
metadata:
  name: nginx
  labels:
    app: nginx
```

Then a Service can use a selector such as:

```yaml
selector:
  app: nginx
```

---

# 🔗 POD VS SERVICE

A Pod and a Service are different Kubernetes resources.

```text
┌─────────────┐
│     Pod     │
│             │
│ Runs App    │
└──────┬──────┘
       │
       │ Labels
       ▼
┌─────────────┐
│   Service   │
│             │
│ Stable      │
│ Networking  │
└─────────────┘
```

In this lab, the main focus was creating and testing the Pod.

The Service and NodePort concepts will be explored further in Kubernetes networking.

---

# 🔎 STEP 24 — INSPECT THE POD

Run:

```bash
kubectl describe pod nginx
```

This gives detailed information about the Pod.

Important information:

```text
Name: nginx
Namespace: default
Node: minikube
Status: Running
IP: 10.244.0.3
```

Container information:

```text
Container: nginx
Image: nginx:1.14.2
Port: 80/TCP
State: Running
Ready: True
Restart Count: 0
```

---

# 📋 POD CONDITIONS

The Pod showed healthy conditions:

```text
PodReadyToStartContainers   True
Initialized                 True
Ready                       True
ContainersReady             True
PodScheduled                True
```

This means Kubernetes successfully:

```text
Scheduled the Pod
       ↓
Initialized the Pod
       ↓
Started the container
       ↓
Confirmed the container is ready
```

---

# 📜 POD EVENTS

The Pod events showed the startup process:

```text
Scheduled
Pulling
Pulled
Created
Started
```

The complete flow:

```text
Kubernetes Scheduler
        │
        ▼
Pod Scheduled
        │
        ▼
NGINX Image Pulled
        │
        ▼
Container Created
        │
        ▼
Container Started
        │
        ▼
Pod Running
```

This sequence is very useful for Kubernetes troubleshooting.

---

# 🧪 STEP 25 — VERIFY NGINX DIRECTLY

Inside Minikube:

```bash
curl 10.244.0.3
```

The response confirmed:

```html
<h1>Welcome to nginx!</h1>
```

Therefore, the application was successfully running inside the Kubernetes Pod.

---

# 📄 FINAL `pod.yml`

```yaml
apiVersion: v1
kind: Pod

metadata:
  name: nginx

spec:
  containers:
    - name: nginx
      image: nginx:1.14.2
      ports:
        - containerPort: 80
```

---

# 🗂️ COMPLETE COMMAND HISTORY

```bash
# Check memory
free -h

# Update packages
sudo apt update

# Install Docker
sudo apt install docker.io

# Start Docker
sudo systemctl start docker

# Enable Docker
sudo systemctl enable docker

# Check Docker
sudo systemctl status docker

# Add user to Docker group
sudo usermod -aG docker $USER

# Apply group change
newgrp docker

# Check Docker containers
docker ps

# Download Minikube
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64

# Install Minikube
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Remove downloaded file
rm minikube-linux-amd64

# Check Minikube version
minikube version

# Start Minikube using Docker
minikube start --driver=docker

# Check Minikube status
minikube status

# Install kubectl
sudo snap install kubectl --classic

# Check kubectl
kubectl version --client

# Check Docker
docker ps

# Check Kubernetes nodes
kubectl get nodes

# Check Pods
kubectl get pods

# Check all Pods
kubectl get pods -A

# Create Pod YAML
vi pod.yml

# Create Pod
kubectl create -f pod.yml

# Check Pod
kubectl get pod

# Check Pod with IP and Node
kubectl get pod -o wide

# Enter Minikube
minikube ssh

# Check containers inside Minikube
docker ps

# Test NGINX using Pod IP
curl 10.244.0.3

# Exit Minikube
exit

# Check Pod again
kubectl get pods

# Check Pod with details
kubectl get pods -o wide

# Check Node
kubectl get nodes

# Try exposing Pod
kubectl expose pod nginx --type=NodePort --port=80

# Inspect Pod
kubectl describe pod nginx
```

---

# 🧠 WHAT I LEARNED

## 1️⃣ Kubernetes Pod

A Pod is the smallest deployable unit in Kubernetes.

```text
Pod
 └── Container
```

---

## 2️⃣ Kubernetes Node

The Pod was scheduled on:

```text
minikube
```

The node status was:

```text
Ready
```

---

## 3️⃣ Container Image

The Pod used:

```text
nginx:1.14.2
```

---

## 4️⃣ Container Port

NGINX was configured to use:

```text
80
```

---

## 5️⃣ Pod IP

Kubernetes assigned:

```text
10.244.0.3
```

---

## 6️⃣ Pod Status

The final status was:

```text
READY:     1/1
STATUS:    Running
RESTARTS:  0
```

---

## 7️⃣ Pod Networking

The Pod IP could be accessed from inside the Minikube environment:

```bash
curl 10.244.0.3
```

and returned the NGINX web page.

---

## 8️⃣ Kubernetes and Docker

Kubernetes used Docker to run the NGINX container.

```text
Kubernetes Pod
      │
      ▼
Docker Container
      │
      ▼
NGINX
```

---

# ⚠️ TROUBLESHOOTING LEARNED

| Problem                                | Reason                                          | Lesson                                          |
| -------------------------------------- | ----------------------------------------------- | ----------------------------------------------- |
| `minikube sttaus`                      | Typo                                            | Use `minikube status`                           |
| `minikube staus`                       | Typo                                            | Command names must be exact                     |
| `kubectl` not found                    | kubectl was not installed                       | Install kubectl                                 |
| `kubectl get pods` showed no resources | No application Pod existed in default namespace | Check `kubectl get pods -A`                     |
| `cat pod.yml` inside Minikube failed   | YAML existed on EC2 host                        | Host and Minikube environments are different    |
| `kubectl expose pod nginx` failed      | Pod had no labels                               | Services use selectors and labels               |
| Docker nearly out of disk space        | Minikube downloaded large images                | Monitor disk usage and clean unused Docker data |

---

# 🔥 IMPORTANT COMMANDS TO REMEMBER

### Check Kubernetes Nodes

```bash
kubectl get nodes
```

### Check Pods

```bash
kubectl get pods
```

### Get Pod IP

```bash
kubectl get pods -o wide
```

### Detailed Pod Information

```bash
kubectl describe pod nginx
```

### Check Minikube

```bash
minikube status
```

### Enter Minikube

```bash
minikube ssh
```

### Check Containers

```bash
docker ps
```

### Test the Application

```bash
curl 10.244.0.3
```

---

# 🔄 COMPLETE LAB FLOW

```text
AWS EC2 Ubuntu
      │
      ▼
Install Docker
      │
      ▼
Start Docker
      │
      ▼
Install Minikube
      │
      ▼
Start Minikube with Docker Driver
      │
      ▼
Install kubectl
      │
      ▼
Check Kubernetes Node
      │
      ▼
Create pod.yml
      │
      ▼
kubectl create -f pod.yml
      │
      ▼
NGINX Pod Created
      │
      ▼
Pod Scheduled on Minikube
      │
      ▼
NGINX Container Started
      │
      ▼
Pod IP → 10.244.0.3
      │
      ▼
curl 10.244.0.3
      │
      ▼
Welcome to nginx!
```

---

# 📊 FINAL LAB RESULT

```text
Kubernetes Cluster
│
└── Node: minikube
      │
      └── Pod: nginx
            │
            └── Container: nginx
                  │
                  ├── Image: nginx:1.14.2
                  ├── Port: 80
                  └── IP: 10.244.0.3
```

### Final Pod Status

```text
NAME    READY   STATUS    RESTARTS
nginx   1/1     Running   0
```

### Final Application Test

```text
curl 10.244.0.3
```

Result:

```text
Welcome to nginx!
```

This confirms that my **first Kubernetes Pod was successfully created and the NGINX application was running inside the Pod.**

---

# 📸 LAB EVIDENCE

The screenshots from this hands-on lab can be stored inside:

```text
images/day-33/
```

Suggested names:

```text
01-ubuntu-ec2.png
02-docker-installation.png
03-docker-running.png
04-minikube-installation.png
05-minikube-status.png
06-kubectl-installation.png
07-kubernetes-node.png
08-pod-yaml.png
09-nginx-pod-running.png
10-nginx-curl-response.png
11-kubectl-describe-pod.png
```

Example Markdown:

```markdown
<p align="center">
  <img src="./images/day-33/09-nginx-pod-running.png" width="90%">
</p>
```

---

# 🎯 KEY TAKEAWAYS

```text
✅ A Pod is the smallest deployable unit in Kubernetes

✅ A Pod can contain one or more containers

✅ Kubernetes can run containers using a container runtime

✅ Minikube provides a single-node Kubernetes environment

✅ kubectl is used to communicate with the Kubernetes cluster

✅ YAML files are commonly used to define Kubernetes resources

✅ kubectl create -f pod.yml creates the resource from YAML

✅ kubectl get pods checks Pod status

✅ kubectl get pods -o wide shows Pod IP and Node

✅ kubectl describe pod gives detailed Pod information

✅ Pod IPs are internal Kubernetes network addresses

✅ Kubernetes Services use labels/selectors to route traffic

✅ Pod troubleshooting can be done using kubectl describe and Events

✅ docker ps helps understand containers running underneath Kubernetes
```

---

# 🚀 NEXT KUBERNETES TOPICS

After understanding Pods, the next important concepts are:

```text
Pod
 │
 ▼
Deployment
 │
 ▼
ReplicaSet
 │
 ▼
Multiple Pods
 │
 ▼
Service
 │
 ▼
Stable Networking
 │
 ▼
Load Balancing
```

The next step is to understand how **Deployments manage multiple Pods automatically** instead of manually creating individual Pods.

---

<p align="center">

# 🎉 DAY 33 COMPLETE

### ☸️ Kubernetes Pods — First NGINX Application Successfully Deployed

</p>

