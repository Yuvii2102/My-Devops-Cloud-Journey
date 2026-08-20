<div align="center">

# ☸️ KUBERNETES PODS WITH MINIKUBE

### 🚀 Deploying and Running an Nginx Pod on Kubernetes

<img src="https://img.shields.io/badge/Kubernetes-v1.35.1-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white">
<img src="https://img.shields.io/badge/Minikube-v1.38.1-2C3E50?style=for-the-badge&logo=minikube&logoColor=white">
<img src="https://img.shields.io/badge/Docker-29.1.3-2496ED?style=for-the-badge&logo=docker&logoColor=white">
<img src="https://img.shields.io/badge/Ubuntu-26.04-E95420?style=for-the-badge&logo=ubuntu&logoColor=white">

</div>

---

## 📌 Project Overview

In this hands-on Kubernetes project, I created a local Kubernetes cluster using **Minikube with Docker**, configured `kubectl`, created a Kubernetes **Pod manifest**, deployed an **Nginx container**, verified the Pod status, inspected the Pod configuration, accessed the application from inside the Minikube node, and verified the Nginx response using `curl`.

The project was executed on an **Ubuntu 26.04 EC2 instance**.

---

## 🎯 Objectives

* Install and configure Docker
* Install `kubectl`
* Install Minikube
* Create a Kubernetes cluster using the Docker driver
* Verify the Kubernetes cluster
* Create a Pod using YAML
* Deploy Nginx
* Verify Pod status and networking
* Inspect the Pod using `kubectl describe`
* View application logs
* Access the Pod using its Kubernetes IP
* Understand basic Kubernetes Pod operations

---

## 🏗️ Architecture

```text
                    AWS EC2
                Ubuntu 26.04
                     │
                     ▼
                ┌─────────┐
                │ Docker  │
                └────┬────┘
                     │
                     ▼
                ┌──────────┐
                │ Minikube │
                │  Cluster │
                └────┬─────┘
                     │
                     ▼
             ┌───────────────┐
             │ Kubernetes    │
             │     Pod       │
             │    nginx      │
             └──────┬────────┘
                    │
                    ▼
              Nginx:1.14.2
                 Port 80
                    │
                    ▼
              curl 10.244.0.5
                    │
                    ▼
             Welcome to nginx!
```

---

# 🧰 Prerequisites

The EC2 instance used for this project had:

```text
OS       : Ubuntu 26.04 LTS
CPU      : 2 vCPUs
Memory   : ~3.8 GB
Disk     : ~6.7 GB
```

Check system resources:

```bash
free -h
df -h
nproc
```

---

# 1️⃣ Update Ubuntu Package Information

An initial typo was entered:

```bash
sudo apt updte
```

which produced:

```text
Error: Invalid operation updte
```

The correct command was:

```bash
sudo apt update
```

This successfully updated the package information.

---

# 2️⃣ Install Docker

Install Docker:

```bash
sudo apt install docker.io -y
```

Start Docker:

```bash
sudo systemctl start docker
```

Enable Docker at boot:

```bash
sudo systemctl enable docker
```

Check Docker status:

```bash
sudo systemctl status docker
```

Docker was successfully running.

Verify Docker version:

```bash
docker --version
```

Output:

```text
Docker version 29.1.3
```

---

# 3️⃣ Configure Docker for the Ubuntu User

Add the current user to the Docker group:

```bash
sudo usermod -aG docker $USER
```

Apply the group change:

```bash
newgrp docker
```

Verify Docker access:

```bash
docker ps
```

Expected output:

```text
CONTAINER ID   IMAGE   COMMAND   CREATED   STATUS   PORTS   NAMES
```

This confirmed that Docker could be used without `sudo`.

---

# 4️⃣ Install kubectl

Download `kubectl`:

```bash
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
```

Make the binary executable:

```bash
chmod +x ./kubectl
```

Move it into the system PATH:

```bash
sudo mv ./kubectl /usr/local/bin/kubectl
```

Verify the installation:

```bash
kubectl version --client
```

Output:

```text
Client Version: v1.31.0
Kustomize Version: v5.4.2
```

---

# 5️⃣ Install Minikube

Download Minikube:

```bash
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
```

Install it:

```bash
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

Remove the downloaded binary:

```bash
rm minikube-linux-amd64
```

Verify Minikube:

```bash
minikube version
```

Output:

```text
minikube version: v1.38.1
```

---

# 6️⃣ Check Disk Space

Before starting Minikube:

```bash
df -h
```

At this stage:

```text
/dev/root
Size : 6.7G
Used : 2.7G
Available : 4.0G
Usage : 41%
```

---

# 7️⃣ Start Minikube

Start Minikube using the Docker driver:

```bash
minikube start --driver=docker
```

Minikube successfully created a Kubernetes cluster using:

```text
Kubernetes : v1.35.1
Docker     : 29.2.1
CPUs       : 2
Memory     : 3072 MB
```

During startup, Minikube displayed a warning because the EC2 instance had approximately **3811 MiB total memory**, while Minikube requested **3072 MiB**.

Minikube also warned that Docker disk usage was high:

```text
Docker is nearly out of disk space
```

Despite the warnings, the cluster successfully started.

---

# 8️⃣ Verify Kubernetes Nodes

Check the nodes:

```bash
kubectl get nodes
```

Successful output:

```text
NAME       STATUS   ROLES           AGE     VERSION
minikube   Ready    control-plane   3m15s   v1.35.1
```

This confirmed that the Kubernetes control-plane node was healthy.

---

# 9️⃣ Check Current Kubernetes Context

Run:

```bash
kubectl config current-context
```

Output:

```text
minikube
```

This confirms that `kubectl` is currently communicating with the Minikube cluster.

---

# 🔟 Check Minikube Status

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

Everything was successfully running.

---

# 1️⃣1️⃣ Create the Kubernetes Pod YAML

Create the YAML file using Vim:

```bash
vi pod.yml
```

The Pod manifest used:

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

### Pod Configuration

| Field          | Value          |
| -------------- | -------------- |
| API Version    | `v1`           |
| Kind           | `Pod`          |
| Pod Name       | `nginx`        |
| Container Name | `nginx`        |
| Image          | `nginx:1.14.2` |
| Container Port | `80`           |

---

# 1️⃣2️⃣ Create the Pod

Deploy the Pod using:

```bash
kubectl create -f pod.yml
```

Output:

```text
pod/nginx created
```

This confirms that Kubernetes successfully created the Pod.

---

# 1️⃣3️⃣ Check the Pod

Run:

```bash
kubectl get pods
```

Output:

```text
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          14s
```

The Pod was successfully running.

---

# 1️⃣4️⃣ Get Pod Networking Information

Run:

```bash
kubectl get pods -o wide
```

Output:

```text
NAME    READY   STATUS    RESTARTS   AGE   IP           NODE
nginx   1/1     Running   0          41s   10.244.0.5   minikube
```

Important information:

```text
Pod Name : nginx
Pod IP   : 10.244.0.5
Node     : minikube
Status   : Running
```

---

# 1️⃣5️⃣ Access the Minikube Node

Run:

```bash
minikube ssh
```

This opened a shell inside the Minikube environment.

The shell prompt changed to:

```text
docker@minikube:~$
```

---

# 1️⃣6️⃣ Test the Nginx Pod from Inside Minikube

The Pod IP discovered earlier was:

```text
10.244.0.5
```

Run:

```bash
curl 10.244.0.5
```

The request successfully returned the Nginx HTML page.

Important response:

```html
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and working.</p>
```

This confirmed that the Nginx web server inside the Kubernetes Pod was successfully running and reachable through its Pod IP.

---

# 1️⃣7️⃣ Exit the Minikube Shell

Run:

```bash
exit
```

This returns to the Ubuntu EC2 terminal.

---

# 1️⃣8️⃣ Inspect the Pod

An incorrect command was first attempted:

```bash
kubectl describe nginx
```

Kubernetes returned:

```text
error: the server doesn't have a resource type "nginx"
```

The correct command is:

```bash
kubectl describe pod nginx
```

This displayed detailed information about the Pod.

Important information included:

```text
Name:             nginx
Namespace:        default
Node:             minikube/192.168.49.2
Status:           Running
IP:               10.244.0.5
Image:            nginx:1.14.2
Port:             80/TCP
State:            Running
Ready:            True
Restart Count:    0
```

---

# 1️⃣9️⃣ Understand Pod Events

The `describe` output also showed the Pod lifecycle events:

```text
Successfully assigned default/nginx to minikube
Pulling image "nginx:1.14.2"
Successfully pulled image
Container created
Container started
```

This demonstrates the Kubernetes flow:

```text
Pod Created
    ↓
Scheduled to Node
    ↓
Image Pulled
    ↓
Container Created
    ↓
Container Started
    ↓
Pod Ready
```

---

# 2️⃣0️⃣ View Pod Logs

An incomplete command was first attempted:

```bash
kubectl logs
```

This returned an error because a Pod name is required.

Correct command:

```bash
kubectl logs nginx
```

Output:

```text
10.244.0.1 - - [20/Aug/2026:10:06:20 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.88.1" "-"
```

This log confirms that:

```text
HTTP Method : GET
Path        : /
Status Code : 200
Client      : curl
```

So the Nginx application successfully handled the HTTP request.

---

# 🔄 Complete Project Flow

```text
Ubuntu EC2
    │
    ▼
Install Docker
    │
    ▼
Configure Docker User
    │
    ▼
Install kubectl
    │
    ▼
Install Minikube
    │
    ▼
minikube start --driver=docker
    │
    ▼
Kubernetes Cluster
    │
    ▼
Create pod.yml
    │
    ▼
kubectl create -f pod.yml
    │
    ▼
Nginx Pod
    │
    ├── Image: nginx:1.14.2
    ├── Port: 80
    └── IP: 10.244.0.5
    │
    ▼
kubectl get pods
    │
    ▼
Pod Running ✅
    │
    ▼
minikube ssh
    │
    ▼
curl 10.244.0.5
    │
    ▼
Welcome to nginx! 🎉
```

---

# 🧠 Kubernetes Concepts Learned

### Pod

A **Pod** is the smallest deployable unit in Kubernetes. It can contain one or more containers that share networking and storage resources.

### YAML Manifest

The `pod.yml` file describes the desired Pod configuration.

### kubectl

`kubectl` is the command-line interface used to communicate with the Kubernetes API server.

### Minikube

Minikube provides a local Kubernetes cluster suitable for learning and development.

### Container

The Nginx container runs inside the Kubernetes Pod.

### Pod IP

Kubernetes assigned the Nginx Pod the IP:

```text
10.244.0.5
```

### Logs

`kubectl logs nginx` allows us to inspect the application output generated by the Nginx container.

---

# ⚠️ Troubleshooting Encountered

## Docker Disk Space Warning

Minikube reported:

```text
Docker is nearly out of disk space
```

This occurred because the EC2 instance had limited disk capacity.

Useful command:

```bash
df -h
```

Docker cleanup can be performed with:

```bash
docker system prune
```

or:

```bash
docker system prune -a
```

---

## Minikube Memory Warning

The instance had approximately:

```text
3811 MiB RAM
```

while Minikube attempted to allocate:

```text
3072 MiB
```

A lower memory allocation can be used on a small EC2 instance:

```bash
minikube start --driver=docker --cpus=2 --memory=2048mb
```

---

## kubectl Version Warning

Minikube used:

```text
Kubernetes v1.35.1
```

while the installed `kubectl` was:

```text
v1.31.0
```

Minikube warned that the client version may have incompatibilities with the newer cluster version.

Minikube can also run the matching version:

```bash
minikube kubectl -- get pods -A
```

---

## Incorrect `kubectl describe` Command

Incorrect:

```bash
kubectl describe nginx
```

Correct:

```bash
kubectl describe pod nginx
```

---

## Incorrect `kubectl logs` Command

Incorrect:

```bash
kubectl logs
```

Correct:

```bash
kubectl logs nginx
```

---

# 📋 Complete Command Reference

```bash
# Update system
sudo apt update

# Install Docker
sudo apt install docker.io -y

# Start and enable Docker
sudo systemctl start docker
sudo systemctl enable docker

# Check Docker
sudo systemctl status docker
docker --version

# Configure Docker user
sudo usermod -aG docker $USER
newgrp docker

# Test Docker
docker ps

# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Verify kubectl
kubectl version --client

# Install Minikube
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

# Verify Minikube
minikube version

# Check disk
df -h

# Start Minikube
minikube start --driver=docker

# Kubernetes verification
kubectl get nodes
kubectl config current-context
minikube status

# Create Pod manifest
vi pod.yml

# Create Pod
kubectl create -f pod.yml

# Check Pods
kubectl get pods
kubectl get pods -o wide

# Access Minikube
minikube ssh

# Test Nginx
curl 10.244.0.5

# Exit Minikube
exit

# Describe Pod
kubectl describe pod nginx

# View logs
kubectl logs nginx
```

---

# 📸 Project Screenshots

### ✅ Kubernetes Node Running

```text
kubectl get nodes

minikube   Ready   control-plane
```

### ✅ Nginx Pod Running

```text
kubectl get pods

nginx   1/1   Running
```

### ✅ Nginx Application Response

```text
curl 10.244.0.5

Welcome to nginx!
```

### ✅ Pod Details

```text
kubectl describe pod nginx

Status: Running
IP:     10.244.0.5
Image:  nginx:1.14.2
Port:   80/TCP
Ready:  True
```

---

# 🎯 Final Result

The Kubernetes environment was successfully created on an AWS EC2 Ubuntu instance using Docker and Minikube.

The Nginx Pod was successfully:

```text
✅ Created
✅ Scheduled
✅ Started
✅ Verified
✅ Accessed through Pod IP
✅ Inspected
✅ Logged
```

The final application response was:

```text
Welcome to nginx!
```

This confirms that my **first Kubernetes Pod deployment was successfully completed.** 🚀☸️

---

<div align="center">

# 🏆 KUBERNETES PODS COMPLETE

### ☸️ Docker → Minikube → Kubernetes → Pod → Nginx

**DevOps Cloud Journey 🚀**

</div>
