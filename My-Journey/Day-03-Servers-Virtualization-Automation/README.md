<div align="center">

# DAY 03 — DevOps with Yuva

## 🖥️ Servers • Virtualization • AWS EC2 • Automation • IaC

### `Understand Infrastructure • Understand Virtualization • Automate Everything`

<br>

<img src="https://img.shields.io/badge/DEVOPS-JOURNEY-0A66C2?style=for-the-badge&logo=devops&logoColor=white"/>
<img src="https://img.shields.io/badge/DAY-03-2962FF?style=for-the-badge"/>
<img src="https://img.shields.io/badge/STATUS-COMPLETED-2EA44F?style=for-the-badge"/>

</div>

---

## 🎯 Today's Goal

Day 3 was about understanding **what runs underneath cloud infrastructure**.

After learning about DevOps and the SDLC on the previous days, I wanted to understand:

- 🖥️ What is a server?
- 🏢 What is a physical server?
- ⚙️ What is virtualization?
- 💻 What is a Virtual Machine?
- 🔧 What is a hypervisor?
- 🔒 What is logical isolation?
- ☁️ How does AWS EC2 provide virtual servers?
- 🔌 How do APIs communicate with cloud services?
- 🤖 How can infrastructure be automated?
- 🏗️ What is Infrastructure as Code?

The main question I wanted to understand was:

> **How does physical infrastructure become cloud infrastructure, and how can DevOps engineers automate it?**

---

## 🖥️ Server

A **server** is a computer system that provides applications, services, or data to users or other systems over a network.

A server can provide things such as:

- Applications
- Services
- Databases
- Files
- Network resources
- Data

In simple words:

> **A server is a computer that provides something to other computers or users over a network.**

---

## 🏢 Physical Server

A **physical server** is a real hardware machine located in a data center.

It has its own physical resources such as:

- CPU
- RAM
- Storage
- Network components

A physical server is an actual machine, unlike a Virtual Machine which is software-based.

```mermaid
flowchart TD
    A["🖥️ PHYSICAL SERVER"] --> B["CPU"]
    A --> C["RAM"]
    A --> D["STORAGE"]
    A --> E["NETWORK"]
```

---

## ⚙️ Virtualization

One of the important concepts I learned today was **virtualization**.

Virtualization is a technology that allows multiple virtual machines to run on a single physical server while sharing its hardware resources.

Instead of:

```mermaid
flowchart TD
    A["🖥️ PHYSICAL SERVER"] --> B["📦 ONE APPLICATION"]
```

We can have:

```mermaid
flowchart TD
    A["🖥️ PHYSICAL SERVER"] --> B["⚙️ VIRTUALIZATION"]

    B --> C["💻 VM 1"]
    B --> D["💻 VM 2"]
    B --> E["💻 VM 3"]

    C --> C1["Application"]
    C1 --> C2["Operating System"]

    D --> D1["Application"]
    D1 --> D2["Operating System"]

    E --> E1["Application"]
    E1 --> E2["Operating System"]
```

This allows organizations to use physical resources more efficiently.

---

## 💻 Virtual Machine — VM

A **Virtual Machine (VM)** is a software-based computer that runs on top of a physical server using virtualization.

A VM behaves like an independent computer with its own:

- Operating System
- CPU allocation
- Memory allocation
- Storage
- Network configuration

In simple words:

> **A VM is a software-based computer running on a physical machine.**

---

## 🧩 Virtual Machine Structure

The basic structure I understood is:

```mermaid
flowchart TD
    A["🖥️ PHYSICAL SERVER"] --> B["⚙️ HYPERVISOR"]

    B --> C["💻 VM 1"]
    B --> D["💻 VM 2"]
    B --> E["💻 VM 3"]

    C --> C1["Operating System"]
    C1 --> C2["Application"]

    D --> D1["Operating System"]
    D1 --> D2["Application"]

    E --> E1["Operating System"]
    E1 --> E2["Application"]
```

Each VM can operate as an independent computing environment.

---

## 🔧 Hypervisor

A **hypervisor** is software or firmware that creates and manages virtual machines.

It acts as a layer between:

> **Physical Hardware ↔ Virtual Machines**

The hypervisor manages resources such as:

- CPU
- Memory
- Storage
- Network

A simplified architecture:

```mermaid
flowchart TD
    A["💻 VM 1<br/>Application + Operating System"]
    B["💻 VM 2<br/>Application + Operating System"]
    C["💻 VM 3<br/>Application + Operating System"]

    A --> H["⚙️ HYPERVISOR"]
    B --> H
    C --> H

    H --> P["🖥️ PHYSICAL SERVER<br/>CPU • RAM • STORAGE • NETWORK"]
```

The hypervisor acts as the layer between the physical hardware and virtual machines.

---

## 🔒 Logical Isolation

One important concept I learned today was **logical isolation**.

Even though multiple VMs may run on the same physical server, each VM behaves like an independent machine.

```mermaid
flowchart TD
    A["🖥️ PHYSICAL SERVER"] --> B["⚙️ HYPERVISOR"]

    B --> C["💻 VM 1<br/>Company A"]
    B --> D["💻 VM 2<br/>Company B"]
    B --> E["💻 VM 3<br/>YUVI"]

    C --> C1["Independent Environment"]
    D --> D1["Independent Environment"]
    E --> E1["Independent Environment"]
```

Each VM gets its own allocated resources and environment.

> **One physical machine can host multiple isolated virtual environments.**

This is one of the important ideas behind cloud computing.

---

## ☁️ AWS EC2 Example

This helped me understand how AWS provides virtual servers.

**Amazon EC2** provides resizable compute capacity in the cloud.

Instead of buying and maintaining a physical server myself, I can launch a virtual server through AWS.

A simplified example:

```mermaid
flowchart TD
    A["☁️ AWS DATA CENTER"] --> B["🖥️ PHYSICAL SERVER"]
    B --> C["⚙️ HYPERVISOR"]

    C --> D["☁️ EC2 INSTANCE 1"]
    C --> E["☁️ EC2 INSTANCE 2"]
    C --> F["☁️ EC2 INSTANCE 3"]

    D --> D1["Application"]
    E --> E1["Application"]
    F --> F1["Application"]
```

The idea is:

> **AWS has physical infrastructure, virtualization allows it to create virtual environments, and EC2 provides those virtual compute resources to users.**

---

## 🔒 AWS EC2 & Logical Isolation

A simplified example of multiple customers using virtual machines:

```mermaid
flowchart TD
    A["☁️ AWS DATA CENTER"] --> B["🖥️ PHYSICAL SERVER"]
    B --> C["⚙️ HYPERVISOR"]

    C --> D["💻 VM 1<br/>Company A"]
    C --> E["💻 VM 2<br/>Company B"]
    C --> F["💻 VM 3<br/>YUVI"]

    D --> D1["Independent Environment"]
    E --> E1["Independent Environment"]
    F --> F1["Independent Environment"]
```

The physical resources are shared, while the virtual environments remain logically isolated.

---

## 🔌 AWS API Communication

I also learned how commands communicate with AWS services.

For example, a command such as:

```bash
aws ec2 describe-instances
```

asks AWS for information about EC2 instances.

The basic idea is:

```mermaid
flowchart TD
    A["💻 TERMINAL"] --> B["🛠️ AWS CLI"]
    B --> C["🔌 AWS API"]
    C --> D["☁️ AWS SERVICE"]
    D --> E["📊 INFORMATION / RESPONSE"]
```

The API acts as a communication layer between the client and the AWS service.

This is useful for DevOps engineers because infrastructure can be managed from scripts and automated workflows.

---

## 🏗️ Infrastructure Automation

I learned that cloud infrastructure can be automated using different approaches and tools.

Some examples are:

- 🛠️ AWS CLI
- 🔌 AWS APIs
- ☁️ AWS CloudFormation
- 🏗️ Terraform
- 📜 Shell Scripts
- 🐍 Python
- 💻 PowerShell

The goal is to reduce repetitive manual work.

```mermaid
flowchart TD
    A["🛠️ AWS CLI"] --> F["🤖 AUTOMATION"]
    B["🔌 AWS APIs"] --> F
    C["☁️ AWS CLOUDFORMATION"] --> F
    D["🏗️ TERRAFORM"] --> F
    E["📜 SCRIPTS"] --> F

    F --> G["☁️ CLOUD INFRASTRUCTURE"]
```

---

## ☁️ AWS CloudFormation

**AWS CloudFormation** is an Infrastructure as Code service provided by AWS.

It allows infrastructure to be defined using templates.

Instead of manually creating resources one by one:

```text
Create EC2
Create Network
Create Security Group
Create Database
Create IAM Resources
```

Infrastructure can be described in a template and deployed automatically.

A simplified idea:

```mermaid
flowchart TD
    A["📄 TEMPLATE"] --> B["☁️ AWS CLOUDFORMATION"]

    B --> C["💻 EC2"]
    B --> D["🌐 NETWORK"]
    B --> E["🔐 IAM"]
```

This introduces the concept of:

> **Infrastructure as Code (IaC)**

---

## 🏗️ Terraform

I also learned about **Terraform**.

Terraform is an Infrastructure as Code tool used to define and provision infrastructure using configuration files.

A simplified workflow:

```mermaid
flowchart TD
    A["📄 TERRAFORM CONFIGURATION"] --> B["🏗️ TERRAFORM"]
    B --> C["☁️ CLOUD PROVIDER"]
    C --> D["🏗️ INFRASTRUCTURE"]
```

One important idea I understood is:

> **Instead of manually creating infrastructure, I can describe the desired infrastructure as code.**

---

## 📜 Scripting

Automation can also be performed using scripts.

Some scripting technologies I came across include:

- Bash
- Python
- PowerShell

For example:

```mermaid
flowchart TD
    A["📜 SCRIPT"] --> B["🛠️ AWS CLI"]
    B --> C["🔌 AWS API"]
    C --> D["☁️ AWS SERVICE"]
    D --> E["🏗️ INFRASTRUCTURE"]
```

A script can perform repetitive tasks automatically.

This is one of the reasons scripting is important for DevOps engineers.

---

## 🔄 Manual vs Automated DevOps

The difference became clearer to me today.

### ❌ Manual

```mermaid
flowchart TD
    A["👨‍💻 ENGINEER"] --> B["🖥️ CONSOLE"]
    B --> C["🖱️ CLICK"]
    C --> D["🏗️ CREATE RESOURCE"]
    D --> E["🔁 REPEAT"]
    E --> F["🔁 REPEAT"]
    F --> G["🔁 REPEAT"]
```

### ✅ Automated

```mermaid
flowchart TD
    A["👨‍💻 ENGINEER"] --> B["💻 CODE / SCRIPT"]
    B --> C["🤖 AUTOMATION TOOL"]
    C --> D["🔌 API"]
    D --> E["☁️ CLOUD PROVIDER"]
    E --> F["🏗️ INFRASTRUCTURE"]
```

The automated approach is more scalable and repeatable.

---

## 🌐 Hybrid Cloud

I also came across the concept of **Hybrid Cloud**.

Hybrid cloud means using a combination of:

> **ON-PREMISES INFRASTRUCTURE + CLOUD**

For example:

```mermaid
flowchart TD
    A["🏢 COMPANY"] --> B["🏠 ON-PREMISES"]
    A --> C["☁️ CLOUD"]

    B --> D["🖥️ SERVERS"]
    C --> E["☁️ AWS"]

    D --> F["🔗 CONNECTED SYSTEM"]
    E --> F
```

A company may keep some workloads on its own infrastructure while running other workloads in the cloud.

---

## 🧩 How Everything Connects

Today's concepts started making more sense when I connected them together:

```mermaid
flowchart TD
    A["🖥️ PHYSICAL SERVER"]
    --> B["⚙️ VIRTUALIZATION"]
    --> C["🔧 HYPERVISOR"]
    --> D["💻 VIRTUAL MACHINE"]
    --> E["☁️ CLOUD / EC2"]
    --> F["🔌 API"]
    --> G["🛠️ AWS CLI / TOOLS"]
    --> H["🤖 AUTOMATION"]
    --> I["🏗️ INFRASTRUCTURE AS CODE"]
    --> J["☁️ CLOUDFORMATION / TERRAFORM"]
    --> K["🔄 REPEATABLE INFRASTRUCTURE"]
```

This gave me a better understanding of what happens underneath cloud infrastructure.

---

## 💡 What I Learned Today

My biggest takeaway from Day 3:

> **DevOps is not only about deploying applications. It is also about understanding and automating the infrastructure on which those applications run.**

Today I understood:

```mermaid
flowchart TD
    A["🖥️ SERVER<br/>Provides applications, services, or data"]
    --> B["🏢 PHYSICAL SERVER<br/>Real hardware machine"]

    B --> C["⚙️ VIRTUALIZATION<br/>Allows multiple VMs to share hardware"]

    C --> D["🔧 HYPERVISOR<br/>Creates and manages VMs"]

    D --> E["💻 VM<br/>Software-based independent computing environment"]

    E --> F["☁️ EC2<br/>Cloud-based virtual compute provided by AWS"]

    F --> G["🔌 API<br/>Allows software systems to communicate"]

    G --> H["🤖 AUTOMATION<br/>Performs repetitive tasks automatically"]

    H --> I["🏗️ IaC<br/>Infrastructure is defined using code"]

    I --> J["☁️ Terraform / CloudFormation<br/>Automate infrastructure provisioning"]
```

---

## 🧠 My Simple Mental Model

The easiest way I remember today's concepts:

```mermaid
flowchart TD
    A["🖥️ PHYSICAL HARDWARE"]
    --> B["⚙️ VIRTUALIZATION"]
    --> C["🔧 HYPERVISOR"]
    --> D["💻 VIRTUAL MACHINES"]
    --> E["☁️ CLOUD COMPUTING"]
    --> F["☁️ EC2"]
    --> G["🔌 APIs"]
    --> H["🤖 AUTOMATION"]
    --> I["🏗️ INFRASTRUCTURE AS CODE"]

    I --> J["☁️ CLOUDFORMATION"]
    I --> K["🏗️ TERRAFORM"]

    J --> L["🔄 REPEATABLE INFRASTRUCTURE"]
    K --> L
```

---

## 📸 My Day 03 Notes

These are the handwritten notes I made while learning about servers, virtualization, AWS EC2, hypervisors, automation, APIs, and Infrastructure as Code.

### 🖥️ Servers & Virtualization

<p align="center">
  <img src="./images/day-03-servers-virtualization.jpg" width="750"/>
</p>

---

## 🔑 Key Takeaways

| Concept | What I Understood |
|---|---|
| 🖥️ Server | Provides applications, services, or data |
| 🏢 Physical Server | Real hardware machine |
| 💻 Virtual Machine | Software-based computer |
| ⚙️ Virtualization | Multiple VMs sharing physical resources |
| 🔧 Hypervisor | Creates and manages VMs |
| 🔒 Logical Isolation | VMs operate as independent environments |
| ☁️ EC2 | Cloud-based virtual compute |
| 🔌 API | Allows software systems to communicate |
| 🤖 Automation | Performs repetitive tasks automatically |
| 🛠️ AWS CLI | Manage AWS through commands |
| ☁️ CloudFormation | AWS Infrastructure as Code |
| 🏗️ Terraform | Infrastructure as Code tool |
| 📜 Scripting | Automate tasks using code |
| 🌐 Hybrid Cloud | Combination of on-premises and cloud |

---

## 🎯 What I Want to Remember

```mermaid
flowchart LR
    A["🖥️ SERVER"] --> B["⚙️ VIRTUALIZATION"]
    B --> C["💻 VM"]
    C --> D["☁️ EC2"]
    D --> E["🔌 API"]
    E --> F["🤖 AUTOMATION"]
    F --> G["🏗️ IaC"]
    G --> H["🔄 REPEATABLE INFRASTRUCTURE"]
```

The biggest lesson from today:

> **Understand the infrastructure first. Then learn how to automate it.**

---

<div align="center">

# 🚀 DAY 03 COMPLETE

### Build • Break • Fix • Automate

**Learning → Understanding → Practicing → Documenting**

<br>

`Servers → Virtualization → Cloud → Automation → IaC`

<br>

📌 **More coming tomorrow...**

</div>
