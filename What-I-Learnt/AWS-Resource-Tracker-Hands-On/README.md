<div align="center">

# ☁️ DEVOPS CLOUD JOURNEY

## 🛠️ AWS RESOURCE TRACKER — SHELL SCRIPTING PROJECT

### 🚀 AWS CLI → Bash Scripting → AWS Resource Monitoring → Automation

<br>

<img src="https://img.shields.io/badge/AWS-CLI-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white"/>
<img src="https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white"/>
<img src="https://img.shields.io/badge/Bash-Scripting-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white"/>
<img src="https://img.shields.io/badge/EC2-Cloud%20Server-FF9900?style=for-the-badge&logo=amazonec2&logoColor=white"/>
<img src="https://img.shields.io/badge/AWS%20IAM-Security-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white"/>

<br><br>

### 📅 DATE
**16 AUGUST 2026**

### 🎯 PROJECT
**AWS Resource Tracker using Shell Scripting**

</div>

---

# 📚 01 — WHAT I LEARNED

Today I built a simple **AWS Resource Tracker** using **Bash Shell Scripting + AWS CLI**.

The goal of this project was to execute multiple AWS CLI commands automatically from a Bash script and display information about AWS resources available in the AWS account.

### 🎯 Today I learned how to:

1. Connect to an AWS EC2 instance using **EC2 Instance Connect**
2. Work with the Ubuntu Linux terminal
3. Use the **AWS CLI** from an EC2 instance
4. Configure AWS CLI using `aws configure`
5. Understand AWS Access Key ID and Secret Access Key
6. Understand AWS CLI authentication
7. Create a Bash shell script
8. Create and edit a script using `vim`
9. Add comments and documentation to a Bash script
10. Use `set -x` for Bash debugging
11. Execute AWS CLI commands from a shell script
12. List AWS S3 buckets
13. List AWS EC2 instances
14. List AWS Lambda functions
15. List AWS IAM users
16. Give execute permission to a shell script using `chmod`
17. Execute a `.sh` file
18. Understand how Bash executes commands
19. Build a basic AWS resource visibility/monitoring script
20. Understand how Shell Scripting can automate AWS CLI operations

---

# ☁️ 02 — PROJECT OVERVIEW

The project is based on a simple idea:

> **Instead of manually running AWS CLI commands one by one, create a Bash script that executes multiple AWS commands automatically.**

### Without Automation

The manual approach would require running:

    aws s3 ls

    aws ec2 describe-instances

    aws lambda list-functions

    aws iam list-users

one command at a time.

### With Automation

The Bash script acts as an **automation layer** between the Linux environment and AWS services.

    ┌─────────────────────────────┐
    │        AWS EC2 Instance     │
    │          Ubuntu Linux       │
    └──────────────┬──────────────┘
                   │
                   ▼
    ┌─────────────────────────────┐
    │      Bash Shell Script      │
    │   aws_resource_tracker.sh   │
    └──────────────┬──────────────┘
                   │
        ┌──────────┼──────────┬──────────┐
        │          │          │          │
        ▼          ▼          ▼          ▼
       S3         EC2       Lambda      IAM
        │          │          │          │
        └──────────┴──────────┴──────────┘
                   │
                   ▼
          AWS Resource Information

The Bash script becomes an **automation layer** between the Linux environment and AWS services.

---

# 🖥️ 03 — ENVIRONMENT

The project was performed inside an **AWS EC2 instance**.

### Operating System

    Ubuntu 26.04 LTS

### Architecture

    x86_64

### Cloud Environment

    AWS EC2

### Region

    us-east-1

### Tools Used

| Tool | Purpose |
|---|---|
| AWS EC2 | Cloud server/environment |
| Ubuntu Linux | Operating system |
| AWS CLI | Communicate with AWS services |
| Bash | Shell scripting |
| Vim | Script editing |
| chmod | File permissions |
| IAM | AWS identity and access |
| S3 | Object storage |
| Lambda | Serverless functions |

---

# 🔐 04 — AWS CLI CONFIGURATION

Before using AWS CLI commands, the CLI needs AWS credentials or another authentication method.

We used:

    aws configure

The command asks for:

    AWS Access Key ID
    AWS Secret Access Key
    Default region name
    Default output format

Example:

    aws configure

    AWS Access Key ID [None]:
    AWS Secret Access Key [None]:
    Default region name [None]: us-east-1
    Default output format [None]: json

### ⚠️ SECURITY NOTE

Never store real AWS credentials inside GitHub repositories.

Do NOT put:

    AWS Access Key ID
    AWS Secret Access Key

inside:

    README.md
    Shell scripts
    Dockerfiles
    Public GitHub repositories
    Screenshots
    `.env` files committed to Git

For production workloads on EC2, prefer using an **IAM Role attached to the EC2 instance** instead of storing long-term access keys on the server.

---

# 🧪 05 — VERIFY AWS CLI

We verified that AWS CLI was available:

    aws --version

Example output:

    aws-cli/2.36.24 Python/3.14.6 Linux/7.0.0-1006-aws exe/x86_64.ubuntu.26

This confirmed that:

    AWS CLI
        ↓
    Successfully Installed
        ↓
    Ready to communicate with AWS

---

# 📂 06 — CREATE THE RESOURCE TRACKER SCRIPT

We created the Bash script:

    aws_resource_tracker.sh

Command:

    vim aws_resource_tracker.sh

The script contains Bash instructions and AWS CLI commands.

---

# 📝 07 — BASIC BASH SCRIPT STRUCTURE

The script begins with the Bash shebang:

    #!/bin/bash

This tells Linux to execute the script using Bash.

We also added documentation:

    #!/bin/bash

    # Author: Yuvraj
    # Date: 16-08-2026

    # This script will report AWS resource usage

---

# 🐞 08 — BASH DEBUGGING WITH set -x

We used:

    set -x

`set -x` tells Bash to display commands before executing them.

For example:

    + echo "Print list of s3 buckets"
    Print list of s3 buckets
    + aws s3 ls

This helps us understand exactly what commands the script is executing.

### Without `set -x`

The script mainly shows the command output.

### With `set -x`

Bash displays:

    + command

before executing it.

This is extremely useful when troubleshooting shell scripts.

---

# 🪣 09 — LIST AWS S3 BUCKETS

The script contains:

    echo "Print list of s3 buckets"
    aws s3 ls

### What it does

`aws s3 ls` lists the S3 buckets accessible to the configured AWS identity.

Example:

    Print list of s3 buckets

    2026-08-16 06:48:10 kops-yuvi-storage-1

This allowed us to see the S3 resources available in the AWS account.

---

# 💻 10 — LIST AWS EC2 INSTANCES

The script contains:

    echo "Print list of EC2 Instances"
    aws ec2 describe-instances

### What it does

`aws ec2 describe-instances` retrieves information about EC2 instances.

The response can contain information such as:

    Instance ID
    Instance state
    Instance type
    Private IP
    Public IP
    Security groups
    Network interfaces
    Block devices
    VPC
    Subnet

Example command:

    aws ec2 describe-instances

This demonstrates how AWS CLI can retrieve EC2 infrastructure information directly from a Linux server.

---

# ⚡ 11 — LIST AWS LAMBDA FUNCTIONS

The script contains:

    echo "Print list of lambda functions"
    aws lambda list-functions

### What it does

`aws lambda list-functions` retrieves the Lambda functions available to the AWS account in the configured region.

This allowed us to monitor another AWS service from the same Bash script.

---

# 👤 12 — LIST AWS IAM USERS

The script contains:

    echo "Print list of IAM users"
    aws iam list-users

### What it does

`aws iam list-users` retrieves IAM users accessible to the AWS identity running the command.

This demonstrates that one Bash script can interact with multiple AWS services through AWS CLI.

---

# 🧩 13 — COMPLETE RESOURCE TRACKER SCRIPT

The project script we created was:

    #!/bin/bash

    # Author: Yuvraj
    # Date: 16-08-2026

    # This script will report AWS resource usage

    set -x

    # AWS S3
    # AWS EC2
    # AWS Lambda
    # AWS IAM

    # If you don't know the AWS CLI commands, you can use the
    # AWS CLI Command Reference to find the required command.

    # List S3 buckets
    echo "Print list of s3 buckets"
    aws s3 ls

    # List EC2 Instances
    echo "Print list of EC2 Instances"
    aws ec2 describe-instances

    # List Lambda functions
    echo "Print list of lambda functions"
    aws lambda list-functions

    # List IAM users
    echo "Print list of IAM users"
    aws iam list-users

---

# 🔑 14 — MAKE THE SCRIPT EXECUTABLE

Initially, a newly created shell script may not have execute permission.

We used:

    chmod 777 aws_resource_tracker.sh

This changes the file permissions.

### Permission concept

    chmod
       │
       └── Change file permissions

The command made the script executable so that we could run it directly.

### Recommended practice

For normal scripts, a more restrictive permission is usually preferable:

    chmod +x aws_resource_tracker.sh

or:

    chmod 755 aws_resource_tracker.sh

---

# ▶️ 15 — EXECUTE THE SCRIPT

After giving execute permission, we executed:

    ./aws_resource_tracker.sh

The `./` means:

> Execute the file from the current directory.

The execution flow was:

    ./aws_resource_tracker.sh
              │
              ▼
         Bash starts
              │
              ▼
          set -x
              │
              ▼
        AWS S3 command
              │
              ▼
        AWS EC2 command
              │
              ▼
       AWS Lambda command
              │
              ▼
         AWS IAM command
              │
              ▼
       Resource information

---

# 🔍 16 — UNDERSTANDING THE SCRIPT EXECUTION

When we execute:

    ./aws_resource_tracker.sh

Bash reads the script from top to bottom.

### Step 1

Bash identifies the interpreter:

    #!/bin/bash

### Step 2

The script enables debugging:

    set -x

### Step 3

The script prints:

    Print list of s3 buckets

### Step 4

It executes:

    aws s3 ls

### Step 5

It prints:

    Print list of EC2 Instances

### Step 6

It executes:

    aws ec2 describe-instances

### Step 7

It prints:

    Print list of lambda functions

### Step 8

It executes:

    aws lambda list-functions

### Step 9

It prints:

    Print list of IAM users

### Step 10

It executes:

    aws iam list-users

This is the basic automation workflow.

---

# 🏗️ 17 — PROJECT ARCHITECTURE

    ┌───────────────────────────────────────┐
    │             AWS EC2 INSTANCE          │
    │                                       │
    │            Ubuntu Linux               │
    │                                       │
    │    ┌─────────────────────────────┐    │
    │    │     aws_resource_tracker.sh │    │
    │    └──────────────┬──────────────┘    │
    │                   │                   │
    │                   ▼                   │
    │              AWS CLI                 │
    │                   │                   │
    └───────────────────┼───────────────────┘
                        │
            ┌───────────┼───────────┬───────────┐
            │           │           │           │
            ▼           ▼           ▼           ▼
        ┌───────┐   ┌───────┐   ┌────────┐   ┌───────┐
        │  S3   │   │  EC2  │   │ Lambda │   │  IAM  │
        └───────┘   └───────┘   └────────┘   └───────┘
            │           │           │           │
            └───────────┴───────────┴───────────┘
                        │
                        ▼
              AWS Resource Information

---

# 🔄 18 — AUTOMATION FLOW

    User
      │
      ▼
    EC2 Instance
      │
      ▼
    Ubuntu Terminal
      │
      ▼
    Bash Script
      │
      ▼
    AWS CLI
      │
      ├──────────► S3
      │
      ├──────────► EC2
      │
      ├──────────► Lambda
      │
      └──────────► IAM
                   │
                   ▼
          Resource Information

The important concept learned:

> **Bash scripting can be used as an automation layer to execute AWS CLI operations repeatedly and consistently.**

---

# 📊 19 — AWS SERVICES USED

| AWS Service | CLI Command | Purpose |
|---|---|---|
| Amazon S3 | `aws s3 ls` | List S3 buckets |
| Amazon EC2 | `aws ec2 describe-instances` | List EC2 instance information |
| AWS Lambda | `aws lambda list-functions` | List Lambda functions |
| AWS IAM | `aws iam list-users` | List IAM users |

---

# 🧠 20 — IMPORTANT COMMANDS LEARNED

### AWS CLI

    aws --version

    aws configure

    aws s3 ls

    aws ec2 describe-instances

    aws lambda list-functions

    aws iam list-users

### Linux

    vim aws_resource_tracker.sh

    chmod +x aws_resource_tracker.sh

    chmod 755 aws_resource_tracker.sh

    ./aws_resource_tracker.sh

### Bash

    #!/bin/bash

    set -x

    echo "message"

---

# 🐞 21 — DEBUGGING EXPERIENCE

During the project we used:

    set -x

This helped us see the commands being executed.

Example:

    + echo 'Print list of s3 buckets'
    Print list of s3 buckets

    + aws s3 ls
    2026-08-16 06:48:10 kops-yuvi-storage-1

    + echo 'Print list of EC2 Instances'
    Print list of EC2 Instances

    + aws ec2 describe-instances

This made it easier to understand the execution flow of the Bash script.

---

# 🛡️ 22 — IAM AND PERMISSIONS

AWS CLI operations are controlled by AWS permissions.

The identity used by AWS CLI must have permission to perform the requested operations.

For example:

    aws s3 ls

requires appropriate S3 permissions.

Similarly:

    aws ec2 describe-instances

requires permission to describe EC2 instances.

And:

    aws lambda list-functions

requires permission to list Lambda functions.

And:

    aws iam list-users

requires appropriate IAM permission.

### Important principle

    AWS CLI
       │
       ▼
    AWS Authentication
       │
       ▼
    IAM Permissions
       │
       ▼
    AWS Service
       │
       ▼
    Resource Information

---

# 🔐 23 — SECURITY LESSONS

During this project I also learned that AWS credentials must be handled carefully.

### Never commit:

    AWS Access Key ID
    AWS Secret Access Key
    Private keys
    `.pem` files
    Passwords
    Tokens
    API keys

### Never upload credentials to:

    GitHub
    Public repositories
    README files
    Screenshots
    Shell scripts

### Better EC2 approach

For EC2 workloads, prefer:

    EC2
      │
      ▼
    IAM Role
      │
      ▼
    Temporary AWS credentials
      │
      ▼
    AWS CLI
      │
      ▼
    AWS Services

This avoids putting long-term AWS access keys directly inside the EC2 environment.

---

# 🧪 24 — MANUAL VS AUTOMATED APPROACH

### ❌ Manual

    aws s3 ls

    aws ec2 describe-instances

    aws lambda list-functions

    aws iam list-users

Every command has to be entered manually.

### ✅ Automated

    ./aws_resource_tracker.sh

The script executes all required AWS CLI commands automatically.

This is the fundamental idea behind automation in DevOps.

---

# 🚀 25 — HOW THIS CAN BE IMPROVED

This project is a basic version of an AWS resource monitoring tool.

It can later be improved with:

    ├── Resource count
    ├── EC2 running/stopped status
    ├── CPU utilization
    ├── S3 bucket size
    ├── Lambda function count
    ├── IAM user information
    ├── Error handling
    ├── Logging
    ├── AWS region selection
    ├── Email notifications
    ├── Scheduled execution
    ├── Cron jobs
    └── CloudWatch integration

The current project establishes the foundation for these future improvements.

---

# 🧑‍💻 26 — PROJECT DIRECTORY

A simple project structure:

    AWS-Resource-Tracker/
    │
    ├── aws_resource_tracker.sh
    │
    └── README.md

### Script

    aws_resource_tracker.sh

### Documentation

    README.md

---

# 🎯 27 — WHAT THIS PROJECT DEMONSTRATES

This project demonstrates practical knowledge of:

    Linux
      ↓
    Bash
      ↓
    AWS CLI
      ↓
    IAM
      ↓
    AWS Services
      ↓
    Automation

It combines several DevOps fundamentals into one hands-on project.

### Skills demonstrated

| Skill | Demonstrated |
|---|---|
| Linux | ✅ |
| Ubuntu | ✅ |
| Bash | ✅ |
| Shell scripting | ✅ |
| AWS CLI | ✅ |
| AWS EC2 | ✅ |
| AWS S3 | ✅ |
| AWS Lambda | ✅ |
| AWS IAM | ✅ |
| File permissions | ✅ |
| Vim | ✅ |
| Bash debugging | ✅ |
| Cloud automation | ✅ |

---

# 💡 28 — KEY CONCEPTS I UNDERSTOOD

### AWS CLI

AWS CLI allows us to interact with AWS services from the command line.

### Bash

Bash allows us to combine multiple Linux and AWS CLI commands into an automated workflow.

### IAM

IAM controls who can access AWS resources and what actions they are allowed to perform.

### EC2

EC2 provides the Linux environment where we executed the AWS CLI and Bash script.

### Automation

Instead of repeatedly typing commands manually, we created a script that executes them automatically.

---

# 🏆 29 — FINAL LEARNING

The biggest concept I learned from this project is:

> **DevOps is not only about knowing individual commands. It is about combining tools to automate repetitive work.**

In this project:

    Linux
       +
    Bash
       +
    AWS CLI
       +
    IAM
       +
    AWS Services
       ↓
    Automation

The Bash script connects the Linux environment with AWS services and allows multiple AWS operations to be executed through a single script.

---

# 📌 30 — QUICK REVISION

### Create script

    vim aws_resource_tracker.sh

### Bash interpreter

    #!/bin/bash

### Enable debugging

    set -x

### List S3

    aws s3 ls

### List EC2

    aws ec2 describe-instances

### List Lambda

    aws lambda list-functions

### List IAM users

    aws iam list-users

### Give execute permission

    chmod +x aws_resource_tracker.sh

### Execute script

    ./aws_resource_tracker.sh

---

# 🔥 31 — COMPLETE WORKFLOW

    ┌──────────────────────┐
    │      AWS Console     │
    └──────────┬───────────┘
               │
               ▼
    ┌──────────────────────┐
    │     EC2 Instance     │
    │     Ubuntu Linux     │
    └──────────┬───────────┘
               │
               ▼
    ┌──────────────────────┐
    │      AWS CLI         │
    └──────────┬───────────┘
               │
               ▼
    ┌──────────────────────┐
    │   Bash Script        │
    │ aws_resource_tracker │
    └──────────┬───────────┘
               │
       ┌───────┼────────┬─────────┐
       │       │        │         │
       ▼       ▼        ▼         ▼
      S3      EC2     Lambda     IAM
       │       │        │         │
       └───────┴────────┴─────────┘
                       │
                       ▼
              Resource Information
                       │
                       ▼
                  Automation 🚀

---

# 📝 32 — PROJECT SUMMARY

### Project Name

**AWS Resource Tracker using Shell Scripting**

### Technologies

    AWS
    EC2
    Ubuntu
    AWS CLI
    Bash
    IAM
    S3
    Lambda

### Main Objective

Create a Bash script that uses AWS CLI to retrieve information about AWS resources.

### Main AWS Commands

    aws s3 ls
    aws ec2 describe-instances
    aws lambda list-functions
    aws iam list-users

### Main Linux Commands

    vim
    chmod
    ./script.sh

### Main Bash Concept

    set -x

### Main DevOps Concept

> **Automation through Shell Scripting and AWS CLI**

---

# 🚀 33 — WHAT I CAN BUILD NEXT

This project is the foundation for more advanced DevOps automation.

Possible next steps:

    AWS Resource Tracker
            │
            ▼
    Better Bash Script
            │
            ▼
    Error Handling
            │
            ▼
    Logging
            │
            ▼
    Cron Automation
            │
            ▼
    CloudWatch
            │
            ▼
    Notifications
            │
            ▼
    CI/CD Automation

This progression demonstrates how a simple shell script can evolve into a more complete cloud automation solution.

---

<div align="center">

# ☁️ AWS RESOURCE TRACKER COMPLETE

### 🚀 AWS CLI + Bash + Linux + IAM + Cloud Automation

**Built on AWS EC2**

**DEVOPS CLOUD JOURNEY**

</div>
