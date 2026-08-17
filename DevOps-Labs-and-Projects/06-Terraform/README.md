<div align="center">

# 🚀 Terraform AWS EC2 — Hands-On Project

### Infrastructure as Code with Terraform and AWS EC2

![Terraform](https://img.shields.io/badge/Terraform-1.15.8-844FBA?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-EC2-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-Linux-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![AWS CLI](https://img.shields.io/badge/AWS%20CLI-Command%20Line-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white)
![Git](https://img.shields.io/badge/Git-Version%20Control-F05032?style=for-the-badge&logo=git&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-Documentation-181717?style=for-the-badge&logo=github&logoColor=white)

</div>

---

# 📌 Project Overview

This project demonstrates my hands-on learning of **Terraform and Infrastructure as Code (IaC)** by creating an AWS EC2 instance using Terraform.

I performed the complete process on an Ubuntu EC2 instance, starting from connecting to the server, installing Terraform, configuring the HashiCorp repository, creating a Terraform project, writing the Terraform configuration, initializing Terraform, configuring AWS CLI, planning the infrastructure, applying the configuration, and finally verifying that the EC2 instance was successfully created in AWS.

The complete project was performed from the Ubuntu terminal.

---

# 🎯 Project Objective

The main objective of this project was to understand how **Terraform can be used to provision AWS infrastructure through code instead of manually creating resources from the AWS Management Console.**

Instead of manually creating an EC2 instance:

```text
AWS Console
     ↓
Manually Configure EC2
     ↓
Launch Instance
```

I used Infrastructure as Code:

```text
Terraform Configuration
        ↓
   terraform init
        ↓
   terraform plan
        ↓
  terraform apply
        ↓
     AWS EC2
```

---

# 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| AWS | Cloud platform |
| Amazon EC2 | Virtual server |
| Ubuntu | Operating system |
| Terraform | Infrastructure as Code |
| AWS CLI | Command-line interaction with AWS |
| HashiCorp AWS Provider | Connects Terraform with AWS |
| Vim | Editing Terraform configuration |
| Git | Version control |
| GitHub | Project documentation and storage |

---

# 🏗️ Project Architecture

```text
                         AWS CLOUD
                            │
                            │
                     ┌──────▼──────┐
                     │     AWS     │
                     │     EC2     │
                     └──────▲──────┘
                            │
                     AWS Provider
                            │
                     ┌──────┴──────┐
                     │  Terraform  │
                     │   on Ubuntu │
                     └──────▲──────┘
                            │
                       main.tf
                            │
                 ┌──────────┴──────────┐
                 │                     │
        terraform plan        terraform apply
                 │                     │
                 └──────────┬──────────┘
                            │
                            ▼
                       AWS EC2 Created
```

---

# 1️⃣ Connect to Ubuntu EC2

I first connected to my Ubuntu EC2 instance using **AWS EC2 Instance Connect**.

After connecting, I worked directly from the Ubuntu terminal.

```bash
ubuntu@ip-172-31-22-7:~$
```

This Ubuntu EC2 instance was used as my Terraform working environment.

---

# 2️⃣ Update Ubuntu Packages

I first updated the Ubuntu package information:

```bash
sudo apt update
```

This ensured that the system had the latest available package information.

---

# 3️⃣ Install Required Packages

I installed the packages required for adding and working with the HashiCorp repository:

```bash
sudo apt install -y gnupg software-properties-common curl
```

These packages provided the tools required to download and verify the HashiCorp repository information.

---

# 4️⃣ Add HashiCorp GPG Key

I downloaded the HashiCorp GPG key and stored it in the system keyring:

```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
```

The GPG key allows Ubuntu to verify packages obtained from the HashiCorp repository.

---

# 5️⃣ Add HashiCorp Repository

I added the official HashiCorp APT repository:

```bash
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```

This allowed Ubuntu to find Terraform from the HashiCorp package repository.

---

# 6️⃣ Update Package Information Again

After adding the HashiCorp repository, I updated the package information:

```bash
sudo apt update
```

Now the system could retrieve Terraform from the newly added repository.

---

# 7️⃣ Install Terraform

I installed Terraform:

```bash
sudo apt install -y terraform
```

Terraform was successfully installed on my Ubuntu EC2 instance.

---

# 8️⃣ Verify Terraform Installation

I checked the installed Terraform version:

```bash
terraform version
```

The output showed:

```text
Terraform v1.15.8
on linux_amd64
```

This confirmed that Terraform was successfully installed.

---

# 9️⃣ Create Terraform Project Directory

I created a directory for my Terraform project:

```bash
mkdir terraform-demo
```

Then I entered the directory:

```bash
cd terraform-demo/
```

I verified my current location:

```bash
pwd
```

The working directory was:

```text
/home/ubuntu/terraform-demo
```

---

# 🔟 Create Terraform Configuration File

I created the Terraform configuration file:

```bash
touch main.tf
```

Then I opened the file using Vim:

```bash
vim main.tf
```

---

# 1️⃣1️⃣ Write Terraform Configuration

Inside `main.tf`, I wrote the following Terraform configuration:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t3.micro"

  tags = {
    Name = "Terraform-EC2"
  }
}
```

---

# 🧠 Understanding the Terraform Configuration

The configuration contains the Terraform settings, AWS provider configuration, and EC2 resource definition.

### Terraform Provider Requirement

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
```

This tells Terraform that the project requires the AWS provider from HashiCorp.

The provider source is:

```text
hashicorp/aws
```

The required version is:

```text
~> 6.0
```

### AWS Provider

```hcl
provider "aws" {
  region = "us-east-1"
}
```

This tells Terraform to work with AWS in the `us-east-1` region.

### EC2 Resource

```hcl
resource "aws_instance" "my_ec2" {
```

Here:

```text
aws_instance
```

is the Terraform resource type.

```text
my_ec2
```

is the Terraform resource name.

### AMI

```hcl
ami = "ami-0c2b8ca1dad447f8a"
```

The AMI specifies the machine image that will be used for the EC2 instance.

### Instance Type

```hcl
instance_type = "t3.micro"
```

I used the `t3.micro` instance type.

### EC2 Name Tag

```hcl
tags = {
  Name = "Terraform-EC2"
}
```

This gives the EC2 instance the name:

```text
Terraform-EC2
```

---

# 1️⃣2️⃣ Check the Project Directory

I checked the files inside the Terraform project:

```bash
ls
```

The `main.tf` file was present.

```text
main.tf
```

---

# 1️⃣3️⃣ Initialize Terraform

I initialized the Terraform project:

```bash
terraform init
```

Terraform initialized the backend and provider plugins.

It downloaded the AWS provider required by the project.

The terminal displayed:

```text
Terraform has been successfully initialized!
```

This confirmed that the Terraform project was successfully initialized.

---

# 1️⃣4️⃣ Check Terraform Files

I checked all files, including hidden files:

```bash
ls -la
```

After initialization, Terraform created files and directories such as:

```text
.terraform/
.terraform.lock.hcl
main.tf
```

The `.terraform` directory contains Terraform's local working information and downloaded provider components.

The `.terraform.lock.hcl` file records the provider selection and checksums.

---

# 1️⃣5️⃣ Install AWS CLI

I checked whether AWS CLI was available:

```bash
aws --version
```

I then installed AWS CLI:

```bash
sudo apt install awscli
```

AWS CLI allows me to interact with AWS services from the terminal.

---

# 1️⃣6️⃣ Configure AWS CLI

I configured AWS CLI using:

```bash
aws configure
```

The command requested:

```text
AWS Access Key ID
AWS Secret Access Key
Default region name
Default output format
```

I configured the AWS region as:

```text
us-east-1
```

The actual AWS credentials are intentionally not documented or committed to GitHub.

> ⚠️ Never expose AWS Access Keys, Secret Access Keys, passwords, tokens, or private keys in a public GitHub repository.

---

# 1️⃣7️⃣ Run Terraform Plan

After configuring AWS CLI, I ran:

```bash
terraform plan
```

Terraform analyzed my configuration and generated an execution plan.

The plan showed:

```text
Plan: 1 to add, 0 to change, 0 to destroy.
```

This meant Terraform planned to:

```text
1 resource → Add
0 resources → Change
0 resources → Destroy
```

The resource Terraform planned to create was:

```text
aws_instance.my_ec2
```

---

# 🧠 What `terraform plan` Does

`terraform plan` does not create the infrastructure.

It only shows what Terraform intends to do.

The process is:

```text
main.tf
   ↓
terraform plan
   ↓
Terraform analyzes configuration
   ↓
Terraform creates an execution plan
   ↓
I review the planned changes
```

---

# 1️⃣8️⃣ Run Terraform Apply

After reviewing the plan, I executed:

```bash
terraform apply
```

Terraform displayed the proposed changes and asked for confirmation:

```text
Do you want to perform these actions?

Terraform will perform the actions described above.

Only 'yes' will be accepted to approve.
```

I entered:

```text
yes
```

Terraform then started creating the EC2 instance.

---

# 1️⃣9️⃣ Terraform Created the EC2 Instance

Terraform displayed:

```text
aws_instance.my_ec2: Creating...
```

After the creation process completed:

```text
aws_instance.my_ec2: Creation complete
```

Terraform then displayed:

```text
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

This confirmed that Terraform successfully created the EC2 instance.

---

# 2️⃣0️⃣ Created AWS EC2 Instance

The EC2 instance created by Terraform had the following configuration:

| Property | Value |
|---|---|
| Resource | `aws_instance.my_ec2` |
| Name | `Terraform-EC2` |
| Instance Type | `t3.micro` |
| Region | `us-east-1` |
| AMI | `ami-0c2b8ca1dad447f8a` |
| Creation Method | Terraform |

The created EC2 instance ID was:

```text
i-0911b2639c988cb7c
```

---

# 2️⃣1️⃣ Verify EC2 in AWS Console

After `terraform apply` completed successfully, I opened the AWS EC2 Console.

The newly created instance appeared in the EC2 instance list.

It was named:

```text
Terraform-EC2
```

The instance was running successfully.

This confirmed that Terraform successfully communicated with AWS and provisioned the EC2 infrastructure.

---

# 2️⃣2️⃣ Practice Making Terraform Changes

After successfully creating the EC2 instance, I practiced modifying the Terraform configuration.

I opened the configuration again:

```bash
vim main.tf
```

After modifying the configuration, I ran:

```bash
terraform plan
```

I then applied the changes:

```bash
terraform apply
```

This helped me understand how Terraform compares the desired configuration with the existing infrastructure and determines what needs to change.

The workflow was:

```text
Modify main.tf
      ↓
terraform plan
      ↓
Review Changes
      ↓
terraform apply
      ↓
AWS Infrastructure Updated
```

---

# 2️⃣3️⃣ Terraform Commands Practiced

During this project, I practiced the following Terraform commands:

```bash
terraform version
terraform init
terraform plan
terraform apply
```

### `terraform version`

Checks the installed Terraform version.

### `terraform init`

Initializes the Terraform working directory and downloads required providers.

### `terraform plan`

Shows what Terraform plans to add, change, or destroy.

### `terraform apply`

Applies the Terraform configuration to the infrastructure.

---

# 2️⃣4️⃣ Complete Commands Used During the Project

The complete command history from my hands-on work was:

```bash
sudo apt update

sudo apt install -y gnupg software-properties-common curl

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt install -y terraform

terraform version

mkdir terraform-demo

cd terraform-demo/

pwd

touch main.tf

vim main.tf

ls

terraform init

ls -la

vim main.tf

terraform init

ls -la

aws --version

sudo apt install awscli

aws configure

terraform plan

terraform apply

vim main.tf

terraform plan

terraform apply

vim main.tf

terraform plan

terraform apply

history
```

---

# 2️⃣5️⃣ Project Directory Structure

The Terraform project was structured as:

```text
terraform-demo/
│
├── main.tf
│
├── .terraform/
│
└── .terraform.lock.hcl
```

### `main.tf`

Contains the Terraform infrastructure configuration.

### `.terraform/`

Terraform's local working directory containing provider-related files.

### `.terraform.lock.hcl`

Locks provider selections and checksums.

---

# 🔐 Security

During the project, AWS CLI credentials were configured using:

```bash
aws configure
```

However, credentials must never be stored inside the GitHub repository.

The following information should never be pushed:

```text
❌ AWS Access Key
❌ AWS Secret Access Key
❌ SSH Private Key
❌ .pem files
❌ Passwords
❌ API Tokens
❌ terraform.tfstate
❌ Secret .tfvars files
```

A `.gitignore` file can be used to protect Terraform and credential-related files.

Example:

```gitignore
.terraform/
*.tfstate
*.tfstate.*
*.tfvars
*.tfvars.json
crash.log
crash.*.log
override.tf
override.tf.json
*_override.tf
*_override.tf.json
.terraformrc
terraform.rc
```

---

# 🧠 What I Learned From This Project

Through this hands-on project, I learned:

```text
✅ Infrastructure as Code
✅ Terraform fundamentals
✅ Terraform installation on Ubuntu
✅ HashiCorp repository configuration
✅ Terraform provider configuration
✅ AWS provider
✅ AWS CLI installation
✅ AWS CLI configuration
✅ Creating Terraform configuration files
✅ Writing HCL syntax
✅ Creating AWS EC2 resources
✅ Selecting an AMI
✅ Selecting an EC2 instance type
✅ Adding AWS tags
✅ terraform init
✅ terraform plan
✅ terraform apply
✅ Terraform provider installation
✅ Terraform execution plans
✅ Provisioning AWS infrastructure using code
✅ Detecting infrastructure configuration changes
✅ Verifying Terraform-created resources in AWS
```

---

# 📚 Important Terraform Concepts

| Concept | What I Learned |
|---|---|
| Infrastructure as Code | Infrastructure can be defined and managed using code |
| Terraform | Tool used to provision and manage infrastructure |
| Provider | Connects Terraform to a platform such as AWS |
| Resource | Infrastructure component managed by Terraform |
| `main.tf` | Terraform configuration file |
| `terraform init` | Initializes the Terraform project |
| `terraform plan` | Shows planned infrastructure changes |
| `terraform apply` | Applies the infrastructure configuration |
| AMI | Machine image used to launch an EC2 instance |
| Instance Type | Defines the compute capacity of an EC2 instance |
| Tags | Used to identify and organize AWS resources |
| State | Terraform's record of infrastructure it manages |
| `.terraform.lock.hcl` | Records provider selections and checksums |

---

# 🔄 Complete Project Workflow

```text
┌──────────────────────────┐
│ Connect to Ubuntu EC2    │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│ Update Ubuntu Packages   │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│ Install Required Tools   │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│ Add HashiCorp Repository │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│ Install Terraform        │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│ Verify Terraform         │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│ Create terraform-demo    │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│ Create main.tf           │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│ Write AWS EC2 Config     │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│ terraform init           │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│ Install / Configure AWS  │
│ CLI                      │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│ terraform plan           │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│ Review Infrastructure    │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│ terraform apply          │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│ AWS Creates EC2          │
│ Terraform-EC2            │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│ Verify in AWS Console    │
└──────────────────────────┘
```

---

# 🏆 Final Result

I successfully provisioned an AWS EC2 instance using Terraform.

Terraform confirmed:

```text
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

The final infrastructure was:

```text
AWS
└── EC2
    ├── Name: Terraform-EC2
    ├── Instance Type: t3.micro
    ├── Region: us-east-1
    └── Created using Terraform
```

This project gave me practical experience with **Infrastructure as Code, Terraform, AWS EC2, AWS CLI, Linux, and cloud automation.**

---

# 🚀 From Manual Infrastructure to Infrastructure as Code

Before learning Terraform:

```text
AWS Console
     ↓
Select EC2
     ↓
Choose AMI
     ↓
Choose Instance Type
     ↓
Configure Instance
     ↓
Launch
```

After learning Terraform:

```text
Write Infrastructure Code
          ↓
      main.tf
          ↓
  terraform init
          ↓
  terraform plan
          ↓
  terraform apply
          ↓
       AWS EC2
```

This is the fundamental idea behind **Infrastructure as Code**.

---

# 📈 Skills Practiced

```text
☁️ AWS
🖥️ EC2
🐧 Ubuntu/Linux
🏗️ Terraform
🔧 Infrastructure as Code
⌨️ AWS CLI
📝 HCL
🧰 Vim
🔀 Git
🐙 GitHub
```

---

<div align="center">

# 🎉 TERRAFORM AWS EC2 PROJECT COMPLETE

### Infrastructure as Code • AWS • Terraform • Linux • Cloud

**Successfully created AWS infrastructure using Terraform 🚀**

</div>
