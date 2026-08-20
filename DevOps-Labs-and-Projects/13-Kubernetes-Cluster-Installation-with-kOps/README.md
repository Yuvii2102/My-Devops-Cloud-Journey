<div align="center">

# ☸️ KUBERNETES CLUSTER SETUP WITH KOPS

### 🚀 AWS EC2 + AWS CLI + kubectl + kOps

![Kubernetes](https://img.shields.io/badge/Kubernetes-Setup-326CE5?style=for-the-badge\&logo=kubernetes\&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-EC2-FF9900?style=for-the-badge\&logo=amazon-aws\&logoColor=white)
![kOps](https://img.shields.io/badge/kOps-Cluster%20Management-326CE5?style=for-the-badge)
![Ubuntu](https://img.shields.io/badge/Ubuntu-EC2-E95420?style=for-the-badge\&logo=ubuntu\&logoColor=white)

</div>

---

# 📌 Project Overview

Today I started my **Kubernetes journey** by setting up the tools required to create a Kubernetes cluster on AWS using **kOps**.

The hands-on was performed on an **AWS EC2 Ubuntu instance**.

The setup included:

* Ubuntu package update
* Kubernetes APT repository setup
* `kubectl` installation
* AWS CLI installation
* kOps installation
* AWS CLI configuration
* S3 bucket creation for kOps state
* kOps Kubernetes cluster configuration

> 🛑 **Important:** I intentionally stopped after `kops create cluster` to avoid provisioning the actual AWS Kubernetes infrastructure and potentially generating AWS charges.

---

# 🏗️ Architecture

```text
                         AWS
                          │
                          ▼
                  ┌───────────────┐
                  │   EC2 Ubuntu  │
                  │               │
                  │ AWS CLI       │
                  │ kubectl       │
                  │ kOps          │
                  └───────┬───────┘
                          │
                          │ kops create cluster
                          ▼
                  ┌───────────────┐
                  │   S3 Bucket   │
                  │               │
                  │ kOps State    │
                  └───────┬───────┘
                          │
                          ▼
                Kubernetes Cluster
                Configuration Only
                          │
                          X
                   STOPPED HERE 🛑
```

---

# 🧰 Tools Used

| Tool      | Purpose                                 |
| --------- | --------------------------------------- |
| AWS EC2   | Ubuntu environment for Kubernetes setup |
| Ubuntu    | Operating system                        |
| AWS CLI   | Interact with AWS services              |
| kubectl   | Kubernetes command-line tool            |
| kOps      | Kubernetes cluster lifecycle management |
| Amazon S3 | kOps cluster state storage              |

---

# 1️⃣ Update Ubuntu

First, the Ubuntu package repositories were updated:

```bash
sudo apt update
```

This refreshed the available package information.

---

# 2️⃣ Install Kubernetes Prerequisites

The required packages were installed/upgraded:

```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl apt-transport-https
```

These packages prepare the system for downloading packages securely and accessing the Kubernetes package repository.

---

# 3️⃣ Add Kubernetes Repository

The Kubernetes repository signing key was added:

```bash
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
```

Then the Kubernetes APT repository was configured:

```bash
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

---

# 4️⃣ Install kubectl

The Kubernetes command-line tool was installed:

```bash
sudo apt-get update
sudo apt-get install -y kubectl
```

Installed version during this setup:

```text
kubectl 1.28.15-1.1
```

`kubectl` is used to communicate with and manage Kubernetes clusters.

---

# 5️⃣ Install AWS CLI

AWS CLI was installed using Snap:

```bash
sudo snap install aws-cli --classic
```

AWS CLI was successfully installed.

---

# 6️⃣ Configure PATH

The local binary directory was added to the PATH:

```bash
export PATH="$PATH:/home/ubuntu/.local/bin/"
```

---

# 7️⃣ Install kOps

kOps was downloaded as the Linux AMD64 binary.

The kOps binary was downloaded and prepared for installation:

```bash
kops-linux-amd64
```

The downloaded file was approximately:

```text
164.6 MB
```

kOps is used to create and manage Kubernetes clusters on AWS.

---

# 8️⃣ Configure AWS CLI

AWS CLI configuration was started with:

```bash
aws configure
```

The configuration used:

```text
AWS Access Key ID: Configured
AWS Secret Access Key: Configured
Default Region: us-east-1
Default Output Format: json
```

> 🔐 **Security Note:** AWS credentials should never be committed to GitHub or stored inside project files. Use IAM roles or secure credential management whenever possible.

---

# 9️⃣ Create S3 Bucket for kOps State

The next step was creating an S3 bucket to store the kOps state:

```bash
aws s3api create-bucket --bucket kops-yuvi-storage --region us-east-1
```

The S3 bucket is used as the **kOps state store**.

```text
kops-yuvi-storage
        │
        └── Kubernetes cluster state/configuration
```

> ⚠️ S3 bucket names are globally unique. If `kops-yuvi-storage` is already taken, another unique bucket name must be used.

---

# 🔟 Create Kubernetes Cluster Configuration

The kOps cluster configuration was created using:

```bash
kops create cluster \
--name=yuvik8scluster.k8s.local \
--state=s3://kops-yuvi-storage \
--zones=us-east-1a \
--node-count=1 \
--node-size=t2.micro \
--master-size=t2.micro \
--master-volume-size=8 \
--node-volume-size=8
```

### Cluster Configuration

| Setting              | Value                      |
| -------------------- | -------------------------- |
| Cluster Name         | `yuvik8scluster.k8s.local` |
| kOps State Store     | `s3://kops-yuvi-storage`   |
| AWS Region           | `us-east-1`                |
| Availability Zone    | `us-east-1a`               |
| Worker Nodes         | `1`                        |
| Worker Instance Type | `t2.micro`                 |
| Master Instance Type | `t2.micro`                 |
| Master Volume        | `8 GB`                     |
| Worker Volume        | `8 GB`                     |

---

# 🛑 Important Stopping Point

After running:

```bash
kops create cluster \
--name=yuvik8scluster.k8s.local \
--state=s3://kops-yuvi-storage \
--zones=us-east-1a \
--node-count=1 \
--node-size=t2.micro \
--master-size=t2.micro \
--master-volume-size=8 \
--node-volume-size=8
```

I **stopped the project here**.

The next commands in the original tutorial would continue with cluster editing and provisioning.

However, I did **not** continue to the actual infrastructure creation because kOps can provision AWS resources that may incur charges.

---

# ❌ Commands NOT Executed

These were intentionally **not executed**:

```bash
kops update cluster yuvik8scluster.k8s.local \
--yes \
--state=s3://kops-yuvi-storage
```

and:

```bash
kops validate cluster yuvik8scluster.k8s.local
```

The cluster was therefore **not fully provisioned and validated** as an AWS Kubernetes environment during this session.

---

# 🔄 Planned kOps Workflow

The complete workflow would normally be:

```text
AWS CLI
   │
   ▼
Create S3 State Store
   │
   ▼
kops create cluster
   │
   ▼
kops edit cluster
   │
   ▼
kops update cluster
   │
   ▼
AWS Infrastructure
   │
   ▼
Kubernetes Cluster
   │
   ▼
kops validate cluster
   │
   ▼
kubectl get nodes
```

### Today's stopping point:

```text
AWS CLI
   │
   ▼
S3 Bucket
   │
   ▼
kops create cluster
   │
   ▼
🛑 STOP
```

---

# 💰 Cost Awareness

Before continuing with kOps on AWS, AWS resource costs must be considered.

A Kubernetes cluster can involve multiple AWS resources, including:

* EC2 instances
* EBS volumes
* Networking resources
* Load balancers
* Other supporting infrastructure

Therefore, I intentionally stopped before applying the cluster configuration to AWS.

---

# 🧠 Key Concepts Learned

> 🔹 `kubectl` is the Kubernetes command-line client.

> 🔹 `aws` is used to interact with AWS from the terminal.

> 🔹 `kOps` is used to manage Kubernetes clusters on AWS.

> 🔹 Amazon S3 can be used as the kOps state store.

> 🔹 `kops create cluster` creates the cluster configuration.

> 🔹 The cluster configuration specifies details such as cluster name, Availability Zone, node count, instance sizes, and storage sizes.

> 🔹 Creating the configuration is different from actually provisioning the AWS infrastructure.

> 🔹 `kops update cluster --yes` is the step that applies the configuration and begins provisioning the cluster infrastructure.

> 🔹 AWS cost awareness is important when experimenting with Kubernetes infrastructure.

---

# 📋 Commands Learned

```bash
# Update Ubuntu
sudo apt update

# Install prerequisites
sudo apt-get update
sudo apt-get install -y ca-certificates curl apt-transport-https

# Add Kubernetes repository key
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Add Kubernetes repository
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Install kubectl
sudo apt-get update
sudo apt-get install -y kubectl

# Install AWS CLI
sudo snap install aws-cli --classic

# Configure PATH
export PATH="$PATH:/home/ubuntu/.local/bin/"

# Configure AWS CLI
aws configure

# Create S3 bucket
aws s3api create-bucket --bucket kops-yuvi-storage --region us-east-1

# Create Kubernetes cluster configuration
kops create cluster \
--name=yuvik8scluster.k8s.local \
--state=s3://kops-yuvi-storage \
--zones=us-east-1a \
--node-count=1 \
--node-size=t2.micro \
--master-size=t2.micro \
--master-volume-size=8 \
--node-volume-size=8
```

---

# 🎯 Project Status

```text
┌─────────────────────────────────────────────┐
│          KUBERNETES KOPS PROJECT            │
├─────────────────────────────────────────────┤
│                                             │
│  AWS CLI                 ✅ Installed       │
│  kubectl                 ✅ Installed       │
│  kOps                    ✅ Installed       │
│  AWS Configuration       ✅ Completed       │
│  S3 State Store          ✅ Created         │
│  Cluster Configuration   ✅ Created         │
│  AWS Infrastructure     🛑 Not Provisioned  │
│  Kubernetes Cluster     🛑 Not Built        │
│                                             │
└─────────────────────────────────────────────┘
```

---

<div align="center">

# ☸️ KUBERNETES SETUP COMPLETE — FOR TODAY

### 🚀 AWS CLI → kubectl → kOps → S3 State → Cluster Configuration

### 🛑 Stopped Before AWS Infrastructure Provisioning

**Learn • Build • Understand • Stay Cost-Aware**

</div>
