
<div align="center">
  
# ☁️ AWS CLI + EC2 — COMPLETE HANDS-ON

## From Installing AWS CLI → Discovering AWS Resources → Launching EC2 Using AWS CLI

### ☁️ DEVOPS CLOUD JOURNEY

</div>

---

How to connect to EC2 Instance from UI & Terminal

Use AWS CLI Command Reference if you need any help

# 📚 TODAY'S LEARNING

Today you learned how to:

1. Open an EC2 instance through **AWS Console → EC2 Instance Connect**
2. Check the Linux OS
3. Check CPU architecture
4. Install **AWS CLI v2** manually on Ubuntu
5. Verify AWS CLI installation
6. Understand **AWS Access Key ID vs Secret Access Key**
7. Understand why Secret Access Keys cannot be viewed again
8. Use AWS CLI to discover:

   * AMIs
   * Key pairs
   * Security groups
   * Subnets
   * VPC
   * Instance types
9. Find the configuration of an existing EC2 instance
10. Launch a **new EC2 instance using only AWS CLI**
11. Handle a Free Tier instance-type error
12. Verify the newly launched EC2 instance
13. Get its:

* Instance ID
* State
* Public IP
* Private IP

---

# 🟢 01 — OPEN EC2 INSTANCE CONNECT

We started from the **AWS Console**.

```text
AWS Console
     │
     ▼
EC2
     │
     ▼
Instances
     │
     ▼
Select Instance
     │
     ▼
Connect
     │
     ▼
EC2 Instance Connect
     │
     ▼
Connect
     │
     ▼
EC2 Linux Terminal
```

The terminal looked like:

```bash
ubuntu@ip-172-31-17-66:~$
```

This gave us a Linux shell directly inside the EC2 instance through the AWS Console.

---

# 🟢 02 — CHECK OPERATING SYSTEM

We first checked what Linux distribution the EC2 instance was running.

### Command

```bash
cat /etc/os-release
```

### Result

```text
NAME="Ubuntu"
VERSION="26.04 LTS (Resolute Raccoon)"
ID=ubuntu
VERSION_ID="26.04"
```

Therefore, our EC2 instance was running:

```text
Ubuntu 26.04 LTS
```

This was important because the AWS CLI installation method depends on the operating system.

---

# 🟢 03 — CHECK CPU ARCHITECTURE

We checked the processor architecture.

### Command

```bash
uname -m
```

### Result

```text
x86_64
```

Therefore, we used the **Linux x86_64 AWS CLI installer**.

```text
x86_64
   │
   ▼
AWS CLI Linux x86_64 Package
```

---

# 🟢 04 — DOWNLOAD AWS CLI V2

We downloaded the official AWS CLI v2 Linux ZIP package.

### Command

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```

This downloaded:

```text
awscliv2.zip
```

### Flow

```text
AWS CLI Official Download
          │
          ▼
    awscliv2.zip
          │
          ▼
      EC2 Ubuntu
```

The AWS Linux installation process uses the ZIP package, followed by extraction and installation.

---

# 🟢 05 — INSTALL `unzip`

When we first tried to extract the package:

```bash
unzip awscliv2.zip
```

we got:

```text
Command 'unzip' not found
```

This meant that the `unzip` utility was not installed on our Ubuntu instance.

So we installed it.

### Command

```bash
sudo apt install unzip
```

After `unzip` was installed, we ran:

```bash
unzip awscliv2.zip
```

This extracted the AWS CLI installer into:

```text
aws/
```

The directory contained files such as:

```text
aws/
├── install
├── dist/
├── examples/
└── other AWS CLI files
```

During extraction, we saw many messages like:

```text
inflating: aws/...
inflating: aws/dist/...
inflating: aws/dist/awscli/...
```

### What does `inflating` mean?

`inflating` simply means the file is being extracted from the ZIP archive.

It is **not an error**.

---

# 🟢 06 — INSTALL AWS CLI

After extracting the AWS CLI installer, we installed it.

### Command

```bash
sudo ./aws/install
```

This performed the actual AWS CLI installation.

The AWS CLI installation flow was:

```text
awscliv2.zip
     │
     ▼
unzip awscliv2.zip
     │
     ▼
aws/
     │
     ▼
sudo ./aws/install
     │
     ▼
AWS CLI Installed
```

---

# 🟢 07 — VERIFY AWS CLI INSTALLATION

We checked whether AWS CLI was installed successfully.

### Command

```bash
aws --version
```

### Result

```text
aws-cli/2.36.24 Python/3.14.6 Linux/7.0.0-1006-aws exe/x86_64.ubuntu.26
```

This confirmed:

```text
AWS CLI
   │
   ▼
Version 2
   │
   ▼
Successfully Installed ✅
```

---

# 🔐 08 — AWS ACCESS KEY ID & SECRET ACCESS KEY

We opened:

```text
AWS Console
     │
     ▼
IAM
     │
     ▼
Security Credentials
```

We saw existing Access Key IDs.

## 🔑 Access Key ID

An Access Key ID identifies the AWS access credential.

It looks similar to:

```text
AKIA...
```

## 🔐 Secret Access Key

The Secret Access Key is the secret part of the credential.

### Important Concept

The **Secret Access Key is not displayed again after it has been created**.

It is shown when the access key is initially created.

If the Secret Access Key was not saved at that time, it cannot simply be viewed again later.

A new access key would need to be created if the old secret is unavailable.

---

# ⚠️ 09 — AWS CREDENTIAL SECURITY

We also noticed that the credentials page we opened was for the **root user**.

This is an important security lesson.

### Never put AWS credentials inside:

```text
GitHub repositories
README.md
Shell scripts
Dockerfiles
Public repositories
Screenshots
```

Never commit:

```text
AWS Access Key ID
AWS Secret Access Key
```

to GitHub.

### For EC2

For EC2, an **IAM Role** is generally preferable to storing long-term access keys on the server.

The preferred concept is:

```text
EC2
 │
 ▼
IAM Role
 │
 ▼
Temporary AWS Credentials
 │
 ▼
AWS CLI
 │
 ▼
AWS Services
```

---

# ☁️ 10 — FIND AN AMI

We used AWS CLI to search for an Ubuntu AMI.

### Command

```bash
aws ec2 describe-images \
  --owners 099720109477 \
  --filters "Name=name,Values=ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*" \
  --query 'Images | sort_by(@, &CreationDate)[-1].[ImageId,Name]' \
  --output table
```

### Result

```text
AMI ID:
ami-052355af2a014bd2c
```

The AMI name returned was:

```text
ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20260714
```

---

# 🧠 WHAT IS AN AMI?

**AMI = Amazon Machine Image**

An AMI provides the information required to launch an EC2 instance.

Conceptually:

```text
AMI
 │
 ├── Operating System
 ├── Software configuration
 └── Launch configuration
```

In our case, we searched for an Ubuntu AMI.

---

# 🔑 11 — FIND EC2 KEY PAIRS

We checked the available EC2 Key Pairs.

### Command

```bash
aws ec2 describe-key-pairs \
  --query 'KeyPairs[*].KeyName' \
  --output table
```

### Key Pairs Found

```text
devops-key
yuv
demo
yuva
kubernetes
demo1
```

We selected:

```text
devops-key
```

---

# 🧠 WHAT IS AN EC2 KEY PAIR?

An EC2 Key Pair is used for authentication when connecting to an EC2 instance.

Conceptually:

```text
EC2 Key Pair
     │
     ├── Public Key → AWS / EC2
     │
     └── Private Key → User
```

---

# 🔒 12 — FIND SECURITY GROUPS

We checked the available Security Groups.

### Command

```bash
aws ec2 describe-security-groups \
  --query 'SecurityGroups[*].[GroupId,GroupName]' \
  --output table
```

We had multiple Security Groups available.

The Security Group selected for our new instance was:

```text
sg-0d9f7d57cc5ab8ef7
```

---

# 🧠 WHAT IS A SECURITY GROUP?

A Security Group acts as a virtual firewall for an EC2 instance.

Conceptually:

```text
Internet
   │
   ▼
Security Group
   │
   ├── SSH : 22
   ├── HTTP : 80
   └── HTTPS : 443
   │
   ▼
EC2 Instance
```

Security Groups control network traffic allowed to and from EC2 instances.

---

# 🌐 13 — FIND SUBNETS

We checked the available Subnets.

### Command

```bash
aws ec2 describe-subnets \
  --query 'Subnets[*].[SubnetId,AvailabilityZone,VpcId]' \
  --output table
```

The selected subnet was:

```text
subnet-0e00a4ed026a21325
```

It belonged to:

```text
VPC:
vpc-0c6cd2d587a5406dd
```

The subnet was in:

```text
Availability Zone:
us-east-1c
```

---

# 🧠 WHAT IS A SUBNET?

A subnet is a network segment inside a VPC.

Conceptually:

```text
VPC
 │
 ├── Subnet A
 ├── Subnet B
 ├── Subnet C
 └── Subnet D
```

EC2 instances are launched into subnets.

---

# 🌐 14 — VPC

The VPC associated with our selected subnet was:

```text
vpc-0c6cd2d587a5406dd
```

### Concept

```text
VPC
 │
 ├── Subnet
 │    └── EC2
 │
 ├── Route Tables
 │
 ├── Internet Gateway
 │
 └── Security Groups
```

The VPC provides the networking environment for our EC2 resources.

---

# 🔍 15 — FIND EXISTING EC2 CONFIGURATION

We wanted to know the configuration of our existing EC2 instance.

The existing EC2 private IP was:

```text
172.31.17.66
```

We used its private IP to find its configuration.

### Command

```bash
aws ec2 describe-instances \
  --filters "Name=private-ip-address,Values=172.31.17.66" \
  --query 'Reservations[*].Instances[*].[InstanceId,SubnetId,VpcId,SecurityGroups[*].GroupId,KeyName]' \
  --output table
```

### Result

```text
Instance ID:
i-09c1cca80293a5637

Subnet:
subnet-0e00a4ed026a21325

VPC:
vpc-0c6cd2d587a5406dd

Security Group:
sg-0d9f7d57cc5ab8ef7

Key Pair:
devops-key
```

This was useful because we didn't have to guess which subnet, VPC, Security Group, or Key Pair belonged to our existing EC2.

---

# 💻 16 — CHECK FREE TIER ELIGIBLE INSTANCE TYPES

Initially, we tried to launch an instance using:

```text
t2.micro
```

But AWS returned:

```text
InvalidParameterCombination:
The specified instance type is not eligible for Free Tier.
```

Instead of guessing another instance type, we asked AWS which instance types were eligible.

### Command

```bash
aws ec2 describe-instance-types \
  --filters "Name=free-tier-eligible,Values=true" \
  --query 'InstanceTypes[*].InstanceType' \
  --output table
```

### Result

```text
c7i-flex.large
t3.micro
t4g.small
t4g.micro
t3.small
m7i-flex.large
```

We selected:

```text
t3.micro
```

---

# ❌ 17 — ERROR WE FACED

Our first EC2 launch attempt used:

```bash
--instance-type t2.micro
```

AWS rejected the request because `t2.micro` was not eligible for Free Tier under the current account's rules.

### Original

```text
t2.micro ❌
```

### After checking AWS

```text
t3.micro ✅
```

We then changed the instance type to:

```bash
--instance-type t3.micro
```

This allowed the EC2 launch to proceed.

---

# 🚀 18 — LAUNCH EC2 USING AWS CLI

After discovering the required resources, we launched the new EC2 instance using AWS CLI.

### Configuration Used

```text
AMI:
ami-052355af2a014bd2c

Instance Type:
t3.micro

Key Pair:
devops-key

Security Group:
sg-0d9f7d57cc5ab8ef7

Subnet:
subnet-0e00a4ed026a21325

VPC:
vpc-0c6cd2d587a5406dd
```

### Command

```bash
aws ec2 run-instances \
  --image-id ami-052355af2a014bd2c \
  --count 1 \
  --instance-type t3.micro \
  --key-name devops-key \
  --security-group-ids sg-0d9f7d57cc5ab8ef7 \
  --subnet-id subnet-0e00a4ed026a21325
```

---

# 🏗️ 19 — EC2 LAUNCH ARCHITECTURE

```text
                         AWS CLI
                            │
                            ▼
                  aws ec2 run-instances
                            │
          ┌─────────────────┼─────────────────┐
          │                 │                 │
          ▼                 ▼                 ▼
         AMI            Key Pair       Security Group
          │                 │                 │
          └─────────────────┼─────────────────┘
                            │
                            ▼
                          Subnet
                            │
                            ▼
                           VPC
                            │
                            ▼
                  ┌───────────────────┐
                  │   EC2 INSTANCE    │
                  │                   │
                  │     t3.micro      │
                  │                   │
                  └───────────────────┘
```

---

# 🎉 20 — NEW EC2 SUCCESSFULLY CREATED

The new EC2 instance was successfully launched.

### New EC2 Details

```text
Instance ID:
i-0b3d482baeb01c4f6
```

```text
State:
running
```

```text
Instance Type:
t3.micro
```

```text
Architecture:
x86_64
```

```text
Public IP:
54.242.200.251
```

```text
Private IP:
172.31.23.87
```

```text
Subnet:
subnet-0e00a4ed026a21325
```

```text
VPC:
vpc-0c6cd2d587a5406dd
```

```text
Security Group:
sg-0d9f7d57cc5ab8ef7
```

```text
Key Pair:
devops-key
```

---

# 🔎 21 — VERIFY NEW EC2 INSTANCE

After launching the new instance, we verified its state and IP addresses.

The new private IP was:

```text
172.31.23.87
```

### Command

```bash
aws ec2 describe-instances \
  --filters "Name=private-ip-address,Values=172.31.23.87" \
  --query 'Reservations[*].Instances[*].[InstanceId,State.Name,PublicIpAddress,PrivateIpAddress]' \
  --output table
```

### Result

```text
---------------------------------------------------------
| InstanceId         | State   | PublicIp       | Private |
---------------------------------------------------------
| i-0b3d482baeb01c4f6| running | 54.242.200.251 | 172...  |
---------------------------------------------------------
```

This confirmed:

```text
Instance ID → i-0b3d482baeb01c4f6
State       → running
Public IP   → 54.242.200.251
Private IP  → 172.31.23.87
```

So we successfully created and verified an EC2 instance **without manually launching it through the EC2 Launch Wizard**.

---

# 🧠 22 — AWS CLI COMMANDS WE LEARNED

## Check AWS CLI

```bash
aws --version
```

## Check Operating System

```bash
cat /etc/os-release
```

## Check Architecture

```bash
uname -m
```

## Download AWS CLI

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```

## Install unzip

```bash
sudo apt install unzip
```

## Extract AWS CLI

```bash
unzip awscliv2.zip
```

## Install AWS CLI

```bash
sudo ./aws/install
```

---

# ☁️ 23 — AWS EC2 DISCOVERY COMMANDS

## Find AMIs

```bash
aws ec2 describe-images \
  --owners 099720109477 \
  --filters "Name=name,Values=ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*" \
  --query 'Images | sort_by(@, &CreationDate)[-1].[ImageId,Name]' \
  --output table
```

## Find Key Pairs

```bash
aws ec2 describe-key-pairs \
  --query 'KeyPairs[*].KeyName' \
  --output table
```

## Find Security Groups

```bash
aws ec2 describe-security-groups \
  --query 'SecurityGroups[*].[GroupId,GroupName]' \
  --output table
```

## Find Subnets

```bash
aws ec2 describe-subnets \
  --query 'Subnets[*].[SubnetId,AvailabilityZone,VpcId]' \
  --output table
```

## Find Existing EC2 Configuration

```bash
aws ec2 describe-instances \
  --filters "Name=private-ip-address,Values=172.31.17.66" \
  --query 'Reservations[*].Instances[*].[InstanceId,SubnetId,VpcId,SecurityGroups[*].GroupId,KeyName]' \
  --output table
```

## Find Free Tier Eligible Instance Types

```bash
aws ec2 describe-instance-types \
  --filters "Name=free-tier-eligible,Values=true" \
  --query 'InstanceTypes[*].InstanceType' \
  --output table
```

---

# 🚀 24 — EC2 LAUNCH COMMAND

```bash
aws ec2 run-instances \
  --image-id ami-052355af2a014bd2c \
  --count 1 \
  --instance-type t3.micro \
  --key-name devops-key \
  --security-group-ids sg-0d9f7d57cc5ab8ef7 \
  --subnet-id subnet-0e00a4ed026a21325
```

---

# 🔎 25 — VERIFY EC2 COMMAND

```bash
aws ec2 describe-instances \
  --filters "Name=private-ip-address,Values=172.31.23.87" \
  --query 'Reservations[*].Instances[*].[InstanceId,State.Name,PublicIpAddress,PrivateIpAddress]' \
  --output table
```

---

# 🧩 26 — IMPORTANT AWS CLI OPTIONS

| Option                 | Meaning                            |
| ---------------------- | ---------------------------------- |
| `--image-id`           | AMI ID used to launch the instance |
| `--count`              | Number of instances to launch      |
| `--instance-type`      | EC2 instance size                  |
| `--key-name`           | EC2 Key Pair name                  |
| `--security-group-ids` | Security Group ID                  |
| `--subnet-id`          | Subnet ID                          |
| `--filters`            | Filters AWS resources              |
| `--query`              | Filters/reshapes AWS CLI output    |
| `--output table`       | Displays output in table format    |

---

# 🧠 27 — IMPORTANT AWS CLI COMMANDS

## `aws`

The main AWS Command Line Interface command.

```bash
aws
```

## `aws ec2`

Used to interact with Amazon EC2.

```bash
aws ec2
```

## `describe-images`

Used to find and inspect AMIs.

```bash
aws ec2 describe-images
```

## `describe-key-pairs`

Used to list EC2 Key Pairs.

```bash
aws ec2 describe-key-pairs
```

## `describe-security-groups`

Used to list Security Groups.

```bash
aws ec2 describe-security-groups
```

## `describe-subnets`

Used to list Subnets.

```bash
aws ec2 describe-subnets
```

## `describe-instances`

Used to get EC2 instance information.

```bash
aws ec2 describe-instances
```

## `describe-instance-types`

Used to inspect EC2 instance types.

```bash
aws ec2 describe-instance-types
```

## `run-instances`

Used to launch new EC2 instances.

```bash
aws ec2 run-instances
```

---

# 🔥 28 — COMPLETE AWS CLI + EC2 WORKFLOW

```text
STEP 01
Open EC2 Instance Connect
        │
        ▼
STEP 02
Check Operating System
cat /etc/os-release
        │
        ▼
STEP 03
Check Architecture
uname -m
        │
        ▼
STEP 04
Download AWS CLI
curl ...
        │
        ▼
STEP 05
Install unzip
sudo apt install unzip
        │
        ▼
STEP 06
Extract AWS CLI
unzip awscliv2.zip
        │
        ▼
STEP 07
Install AWS CLI
sudo ./aws/install
        │
        ▼
STEP 08
Verify AWS CLI
aws --version
        │
        ▼
STEP 09
Understand AWS Credentials
Access Key + Secret Access Key
        │
        ▼
STEP 10
Find AMI
describe-images
        │
        ▼
STEP 11
Find Key Pair
describe-key-pairs
        │
        ▼
STEP 12
Find Security Group
describe-security-groups
        │
        ▼
STEP 13
Find Subnet / VPC
describe-subnets
        │
        ▼
STEP 14
Find Existing EC2 Configuration
describe-instances
        │
        ▼
STEP 15
Check Free Tier Instance Types
describe-instance-types
        │
        ▼
STEP 16
Select t3.micro
        │
        ▼
STEP 17
Launch EC2
run-instances
        │
        ▼
STEP 18
Verify EC2
describe-instances
        │
        ▼
🚀 NEW EC2 INSTANCE RUNNING
```

---

# 🏆 29 — WHAT I ACCOMPLISHED TODAY

```text
✅ Opened EC2 through AWS Console

✅ Used EC2 Instance Connect

✅ Checked Ubuntu version

✅ Checked x86_64 architecture

✅ Downloaded AWS CLI v2

✅ Installed unzip

✅ Extracted AWS CLI

✅ Installed AWS CLI

✅ Verified AWS CLI installation

✅ Learned about Access Key ID

✅ Learned about Secret Access Key

✅ Learned that Secret Access Keys cannot be viewed again

✅ Learned about root-user credential security

✅ Learned why IAM Roles are preferable for EC2

✅ Found an Ubuntu AMI

✅ Found EC2 Key Pairs

✅ Found Security Groups

✅ Found Subnets

✅ Found VPC information

✅ Inspected an existing EC2 configuration

✅ Checked Free Tier eligible instance types

✅ Faced and understood the t2.micro Free Tier error

✅ Selected t3.micro

✅ Launched an EC2 instance using AWS CLI

✅ Retrieved the new Instance ID

✅ Retrieved the new Public IP

✅ Retrieved the new Private IP

✅ Verified that the new EC2 instance was running

✅ Successfully created EC2 without using the EC2 Launch Wizard
```

---

# 💡 30 — KEY TAKEAWAYS

### ☁️ AWS CLI

AWS CLI allows us to interact with and manage AWS resources directly from the terminal.

### 💿 AMI

An AMI provides the image/configuration used to launch an EC2 instance.

### 🔑 Key Pair

A Key Pair is used for EC2 authentication.

### 🔒 Security Group

A Security Group acts as a virtual firewall for EC2.

### 🌐 Subnet

A Subnet is a network segment inside a VPC where the EC2 instance is launched.

### ☁️ VPC

A VPC provides the virtual networking environment for AWS resources.

### 💻 Instance Type

The instance type determines the compute resources allocated to an EC2 instance.

### 🚀 `run-instances`

The `run-instances` command launches EC2 instances from the command line.

### 🔎 Discovery Commands

Instead of guessing AWS resource IDs, we can discover them using AWS CLI:

```text
AMI
 │
 ▼
Key Pair
 │
 ▼
Security Group
 │
 ▼
Subnet
 │
 ▼
VPC
 │
 ▼
Instance Type
 │
 ▼
EC2
```

---

# ⚠️ 31 — IMPORTANT FOR FUTURE USE

The following values were specific to today's AWS environment:

```text
AMI:
ami-052355af2a014bd2c

Security Group:
sg-0d9f7d57cc5ab8ef7

Subnet:
subnet-0e00a4ed026a21325

VPC:
vpc-0c6cd2d587a5406dd

Existing Instance:
i-09c1cca80293a5637

New Instance:
i-0b3d482baeb01c4f6

New Public IP:
54.242.200.251

New Private IP:
172.31.23.87

Key Pair:
devops-key
```

### ⚠️ Important

These IDs are specific to the AWS account, region, VPC, and resources used during today's practice.

They can change in future projects.

Therefore, **do not blindly reuse today's resource IDs**.

Instead, run the discovery commands again:

```bash
aws ec2 describe-images ...
```

```bash
aws ec2 describe-key-pairs ...
```

```bash
aws ec2 describe-security-groups ...
```

```bash
aws ec2 describe-subnets ...
```

```bash
aws ec2 describe-instance-types ...
```

Then use the IDs returned for the environment you are working in.

---

# 🔐 32 — SECURITY REMINDER

Never commit sensitive credentials to GitHub.

Do **NOT** commit:

```text
AWS Access Key ID
AWS Secret Access Key
.pem private keys
credentials files
.env files containing secrets
passwords
tokens
API keys
```

### ❌ Never do this

```bash
git add .
git commit -m "AWS credentials"
git push
```

if your project contains credentials.

### ✅ Prefer

```text
IAM Roles
Environment Variables
AWS Secrets Manager
AWS Systems Manager Parameter Store
```

depending on the use case.

---

# 📖 33 — QUICK REVISION

### How did we install AWS CLI?

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip
unzip awscliv2.zip
sudo ./aws/install
aws --version
```

### How did we find an AMI?

```bash
aws ec2 describe-images ...
```

### How did we find Key Pairs?

```bash
aws ec2 describe-key-pairs ...
```

### How did we find Security Groups?

```bash
aws ec2 describe-security-groups ...
```

### How did we find Subnets?

```bash
aws ec2 describe-subnets ...
```

### How did we find Free Tier eligible instance types?

```bash
aws ec2 describe-instance-types \
  --filters "Name=free-tier-eligible,Values=true"
```

### How did we launch EC2?

```bash
aws ec2 run-instances ...
```

### How did we verify the instance?

```bash
aws ec2 describe-instances ...
```

---

# ☁️ 34 — TODAY'S FINAL RESULT

```text
                         ☁️ AWS
                          │
                          ▼
                     AWS CLI v2
                          │
                          ▼
                 EC2 Linux Terminal
                          │
                          ▼
                Resource Discovery
                          │
        ┌─────────────────┼─────────────────┐
        ▼                 ▼                 ▼
       AMI            Key Pair        Security Group
        │                 │                 │
        └─────────────────┼─────────────────┘
                          │
                          ▼
                        Subnet
                          │
                          ▼
                         VPC
                          │
                          ▼
                 Instance Type Check
                          │
                          ▼
                      t3.micro
                          │
                          ▼
                aws ec2 run-instances
                          │
                          ▼
                🚀 NEW EC2 INSTANCE
                          │
                          ├── Instance ID
                          │   i-0b3d482baeb01c4f6
                          │
                          ├── State
                          │   running
                          │
                          ├── Public IP
                          │   54.242.200.251
                          │
                          └── Private IP
                              172.31.23.87
                          │
                          ▼
                     ✅ VERIFIED
```

---

<div align="center">

# 🚀 AWS CLI + EC2 COMPLETE

### From Zero → AWS CLI Installation → AWS Resource Discovery → EC2 Automation

**Learn → Practice → Troubleshoot → Automate → Repeat**

---

## ☁️ DEVOPS CLOUD JOURNEY ☁️

### AWS CLI + EC2 HANDS-ON COMPLETE ✅

</div>
