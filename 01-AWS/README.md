# 🚀 AWS Zero to Hero — Day 1

# ☁️ Introduction to AWS & Public Cloud

## 📚 Topics Covered

1. What is Cloud?
2. Traditional / On-Premises Infrastructure
3. Data Center
4. Problems with Traditional Servers
5. Virtualization
6. Private Cloud
7. Public Cloud
8. Private Cloud vs Public Cloud
9. Why Public Cloud is Popular
10. AWS and its Services
11. Why AWS is Popular
12. Cloud Repatriation
13. Creating an AWS Account

---

# 1️⃣ ☁️ What is Cloud?

The simplest way I understand cloud is:

> **Cloud means using computing resources over the internet without having to physically own and manage those resources myself.**

For example, imagine I am a developer and I need a server to deploy my application.

## 🏢 Traditional Way

I would have to:

```text
Buy a physical server
        ↓
Bring it to my company
        ↓
Create a data center
        ↓
Connect network
        ↓
Provide electricity
        ↓
Control temperature
        ↓
Maintain the server
        ↓
Deploy application
```

That's a lot of work.

## ☁️ Cloud Way

Instead, I can simply say:

> "I need a server."

A cloud provider such as AWS provides that server to me.

```text
You
 ↓
AWS
 ↓
Server
 ↓
Your Application
```

I don't need to physically own the server.

---

# 2️⃣ 🏢 Traditional / On-Premises Infrastructure

Traditionally, organizations used to **buy physical servers**.

For example, suppose a company needs 15 servers.

They could purchase physical servers from companies such as:

* IBM
* HP
* Other server providers

The company would then bring those servers into its own organization and build a **data center**.

This is generally referred to as **on-premises infrastructure**.

---

# 3️⃣ 🏭 What is a Data Center?

A data center can be understood as:

> **A place where servers are stored and all the configurations required for those servers are done.**

I can think of a data center as a **special building or room containing many servers**.

Inside a data center, I need things like:

```text
Servers
   +
Networking
   +
Electricity
   +
Cooling
   +
Temperature control
   +
Security
   +
Maintenance
```

Servers generate a lot of heat, so proper cooling is required.

I also need to make sure:

* Electricity doesn't fail
* Servers are protected
* Network is working
* Servers are maintained
* Security is maintained

So running a data center is a big responsibility.

---

# 4️⃣ 💰 Problems with Physical Servers

Now consider this example.

Suppose my company buys a server with:

```text
100 GB RAM
100 CPU
```

But my application needs only:

```text
1 GB RAM
1 CPU
```

The application uses:

```text
1 GB RAM
1 CPU
```

But I have:

```text
99 GB RAM unused
99 CPU unused
```

So a lot of resources are wasted.

The physical server itself is also expensive.

And if tomorrow I have another application, traditionally I might need to buy another server.

That becomes expensive very quickly.

---

# 5️⃣ 🖥️ Virtualization

This problem led to the concept of **virtualization**.

Suppose I have:

```text
Physical Server
100 GB RAM
100 CPU
```

Instead of putting only one application directly on that physical server, I can create multiple **virtual machines** on it.

For example:

```text
              Physical Server
           100 GB RAM / 100 CPU
                    |
          -------------------------
          |           |           |
         VM1         VM2         VM3
          |           |           |
        App 1       App 2       App 3
```

These are **virtual servers**.

So instead of buying:

```text
15 physical servers
```

I might use:

```text
1 physical server
        ↓
15 virtual machines
        ↓
15 applications
```

## 🧠 Simple Definition

> **Virtualization = Creating multiple virtual machines/servers on top of a physical server so that physical resources can be utilized better.**

---

# 6️⃣ ☁️ How Does This Become Cloud?

Now suppose my organization has physical servers and uses virtualization.

I can create virtual machines.

For example, a developer says:

> "I need 5 servers."

A system administrator can create:

```text
VM1
VM2
VM3
VM4
VM5
```

and give the developer their IP addresses.

The developer doesn't necessarily need to know:

> "Where is the physical server?"

They simply use the virtual machines.

The physical infrastructure is somewhere behind the scenes.

That's where the idea of **cloud** comes from.

---

# 7️⃣ 🔒 Private Cloud

Now imagine all of this infrastructure belongs to **my organization**.

My organization owns and manages the infrastructure.

```text
Your Company
     |
     ↓
Your Data Center
     |
     ↓
Physical Servers
     |
     ↓
Virtual Machines
     |
     ↓
Applications
```

Other companies cannot simply come and request my servers.

This is called:

# Private Cloud

## 🧠 Simple Definition

> **Private Cloud = Cloud infrastructure that is dedicated to and managed for a particular organization.**

The important point is:

> **It is private to my organization.**

---

# 8️⃣ 🌎 Public Cloud

Now AWS comes into the picture.

Instead of every company building its own data center, AWS essentially provides the underlying infrastructure for customers to use.

AWS builds data centers in different parts of the world.

Inside those data centers, AWS has huge amounts of infrastructure.

Customers can then request resources from AWS.

For example:

```text
Developer
   |
   ↓
AWS
   |
   ↓
"I need a server"
   |
   ↓
EC2 Instance
```

That EC2 instance is basically a **virtual server**.

---

# 9️⃣ 🌎 Why is it Called Public Cloud?

It is called public cloud because **customers can use the cloud provider's infrastructure**, subject to the provider's account and service rules.

For example:

```text
Company A ─────┐
Company B ─────┤
Company C ─────┼──→ AWS
Company D ─────┤
Developer ─────┘
```

All of them can use AWS infrastructure.

Similarly:

* Microsoft provides Azure
* Google provides Google Cloud

These are called **public cloud providers**.

---

# 🔥 10️⃣ Private Cloud vs Public Cloud

This is important for interviews.

| Private Cloud                                | Public Cloud                                         |
| -------------------------------------------- | ---------------------------------------------------- |
| Infrastructure is private to an organization | Infrastructure is provided to many customers         |
| Organization manages the infrastructure      | Cloud provider manages the underlying infrastructure |
| Organization maintains its data centers      | AWS/Azure/GCP maintain their infrastructure          |
| Organization handles much of the maintenance | Cloud provider handles underlying infrastructure     |
| Higher management responsibility             | Less infrastructure management for the customer      |

## 🧠 Easy Way to Remember

### Private Cloud

> **"I build and manage it."**

### Public Cloud

> **"AWS builds and manages the infrastructure; I use the resources."**

---

# 1️⃣1️⃣ 🤔 Why is Public Cloud Popular?

Imagine a startup with:

```text
50 employees
```

Suppose they want to build their own data center.

They need:

```text
Servers
Networking
Electricity
Cooling
Security
Data-center space
System administrators
Maintenance
Patching
Monitoring
```

That's a huge responsibility.

They may need dedicated people just to manage this infrastructure.

This becomes an **overhead**.

---

# 1️⃣2️⃣ 💰 Cost + Maintenance

The problem isn't only buying servers.

There are two major problems.

## 1. Money 💰

I have to spend money on:

* Servers
* Networking
* Data center
* Electricity
* Cooling
* Equipment

## 2. Maintenance 🛠️

I need people to:

* Maintain servers
* Patch servers
* Manage security
* Monitor infrastructure
* Handle failures
* Maintain the data center

For a startup or mid-sized company, this can be difficult.

---

# 1️⃣3️⃣ ☁️ Public Cloud Solves This

Instead of doing all of this:

```text
Company
   ↓
Build Data Center
   ↓
Buy Servers
   ↓
Hire Infrastructure Team
   ↓
Maintain Everything
```

A company can instead:

```text
Company
   ↓
Create AWS Account
   ↓
Request Resources
   ↓
Use AWS
```

AWS takes care of the underlying infrastructure.

That's a major reason public cloud became popular.

---

# 1️⃣4️⃣ 🛠️ What is an AWS Service?

AWS provides different **services** to customers.

A service is basically a **capability that AWS provides**.

For example:

## EC2

Used for computing / virtual servers.

```text
EC2 → Virtual Server
```

## Storage

AWS provides storage services.

## Database

AWS provides database-related services.

## Kubernetes

AWS provides managed Kubernetes through its Kubernetes service.

The basic idea is:

> **If something is complicated to set up yourself, AWS can provide it as a managed service.**

For example, instead of manually building a Kubernetes environment, I can use AWS's managed Kubernetes offering.

---

# 1️⃣5️⃣ 🌍 AWS, Azure and GCP

The major cloud providers discussed were:

```text
AWS
Azure
GCP
```

There are also other cloud providers, such as:

```text
Oracle Cloud
DigitalOcean
```

and others.

But AWS is one of the biggest and most widely used cloud platforms.

---

# 1️⃣6️⃣ 🏆 Why is AWS Popular?

## First-Mover Advantage

AWS was an early pioneer in commercial cloud computing.

Because AWS entered the market early, many organizations started their cloud journey with AWS.

For example:

```text
Company
   ↓
Started Cloud
   ↓
AWS
   ↓
Built applications/infrastructure
   ↓
Continued using AWS
```

Once an organization builds its systems on a particular cloud platform, moving everything to another cloud can require significant effort.

So AWS built a large customer base.

---

# 1️⃣7️⃣ 📈 Large Market Share → More Jobs

AWS popularity is also connected to DevOps and cloud-related jobs.

The logic is:

```text
AWS widely used
      ↓
Many companies use AWS
      ↓
Companies need AWS-skilled engineers
      ↓
More AWS-related job opportunities
```

That's why learning AWS is useful when starting a cloud journey.

---

# 1️⃣8️⃣ 🔄 Are AWS, Azure and GCP Completely Different?

No.

The **concepts are largely similar**.

For example:

```text
Cloud
Virtual Machines
Networking
Storage
Databases
Security
Containers
Kubernetes
```

These concepts exist across different cloud platforms.

But the following can be different:

* Service names
* Interfaces
* Terminology
* Implementation
* Ways of configuring things

I can think about it like this:

```text
AWS          Azure          GCP
 |             |             |
EC2            VM       Compute Engine
```

The names and implementation differ, but the underlying cloud concepts are similar.

So:

> **If I learn one cloud platform properly, moving to another becomes easier.**

---

# 1️⃣9️⃣ 🔙 Cloud Repatriation

Normally, organizations may move from:

```text
Private / On-Premises
        ↓
Public Cloud
```

But some organizations do the reverse:

```text
Public Cloud
      ↓
On-Premises / Private Infrastructure
```

This is called:

# Cloud Repatriation

## 🧠 Simple Definition

> **Cloud repatriation = Moving workloads from public cloud back to on-premises/private infrastructure.**

---

# 2️⃣0️⃣ 🤔 Why Would Companies Move Back?

Some reasons mentioned were:

## 🔐 Security

Some organizations may have specific security requirements.

## 💰 Cost

Some companies may find that their cloud usage isn't giving them the cost benefits they expected.

## 📊 Lack of Expected Advantage

They may determine that moving a particular workload to public cloud didn't provide enough benefit.

The important point is:

> **Cloud repatriation exists, but it represents a relatively small portion of users compared with the broader adoption of public cloud.**

So I shouldn't think:

> "Everyone is leaving AWS."

That's not the point.

The main point is that **public cloud adoption continues to be important**, particularly because startups and mid-sized organizations may not want the burden of building and maintaining their own infrastructure.

---

# 2️⃣1️⃣ 🧠 The Entire Day 1 in One Flow

This is probably the most important flow to remember.

```text
Traditional Infrastructure
          ↓
Companies bought physical servers
          ↓
Created their own data centers
          ↓
Huge cost + maintenance
          ↓
Resources were often wasted
          ↓
Virtualization introduced
          ↓
One physical server
          ↓
Multiple virtual machines
          ↓
Private Cloud
          ↓
AWS / Azure / GCP saw the opportunity
          ↓
They built huge infrastructure
          ↓
Customers can request resources
          ↓
Public Cloud
```

---

# 2️⃣2️⃣ 🔥 Private Cloud vs Public Cloud — Interview Answer

If an interviewer asks:

### "What is the difference between private and public cloud?"

I can answer:

> **Private cloud is cloud infrastructure dedicated to and managed for a particular organization, whereas public cloud is infrastructure provided by cloud providers such as AWS, Azure, and GCP, where customers can provision resources without managing the underlying physical data-center infrastructure themselves.**

That's a solid beginner-level answer.

---

# 2️⃣3️⃣ 🧑‍💻 AWS Account

At the end of Day 1, the teacher started creating an AWS account because the next lessons will involve actually working with AWS.

The general flow demonstrated was:

```text
Create AWS Account
       ↓
Provide Email
       ↓
Verify Email
       ↓
Create Password
       ↓
Select Personal / Business
       ↓
Provide Contact Information
       ↓
Provide Payment Method
       ↓
Complete Verification
       ↓
AWS Account Created
```

## 👤 Root User

When I initially create an AWS account, the account's primary identity is the **root user**.

Later, I will learn about **IAM users**.

---

# ⚠️ Important AWS Billing Point

One thing I need to be careful about when doing the practical:

I should **not** assume that AWS can never charge my payment method.

If I use a paid AWS resource and incur charges, AWS can bill the payment method associated with the account according to its billing terms.

So while following the course, I should always be careful about:

```text
Free Tier / Free resources
        ↓
Avoid unnecessary paid resources
        ↓
Check billing
        ↓
Delete resources when finished
```

---

# 📝 Day 1 — Super Short Revision

## ☁️ Cloud

> Using computing resources over the internet instead of physically owning and managing the infrastructure myself.

## 🏭 Data Center

> A facility where servers and the required infrastructure are stored and managed.

## 🖥️ Virtualization

> Creating multiple virtual machines on top of a physical server to utilize resources better.

## 🔒 Private Cloud

> Cloud infrastructure dedicated to and managed for a particular organization.

## 🌎 Public Cloud

> Cloud infrastructure provided by cloud providers such as AWS, Azure and GCP to customers.

## ☁️ AWS

> Amazon's cloud platform that provides many cloud services such as compute, storage, databases and managed services.

---

# 🔥 Why Public Cloud?

```text
No need to build data center
          +
Less infrastructure management
          +
Easy resource provisioning
          +
Scalable infrastructure
```

---

# 🏆 Why AWS?

```text
Early pioneer
     ↓
Large adoption
     ↓
Large market presence
     ↓
Many organizations use AWS
     ↓
Many AWS-related opportunities
```

---

# 🔄 Cloud Repatriation

```text
Public Cloud
     ↓
On-Premises / Private Infrastructure
```

---

# 🎯 What I Actually Need to Remember From Day 1

I don't need to memorize the entire transcript.

I need to understand this story:

> **Companies originally bought physical servers and built their own data centers. This was expensive and difficult to maintain. Virtualization allowed multiple virtual machines to run on one physical server, improving resource utilization. Organizations could use this concept internally to build private clouds. Cloud providers such as AWS took this idea further by building and managing huge infrastructure and allowing customers around the world to provision resources from them. That's public cloud. Public cloud became popular because companies don't have to build and maintain all the underlying infrastructure themselves. AWS became one of the leading cloud providers because it entered the market early and gained widespread adoption.**

## 🧠 My Day 1 Mental Model

```text
Physical Servers
      ↓
Data Center
      ↓
Problem:
Cost + Maintenance + Resource Waste
      ↓
Virtualization
      ↓
Multiple Virtual Machines
      ↓
Private Cloud
      ↓
Cloud Providers
      ↓
AWS / Azure / GCP
      ↓
Public Cloud
      ↓
Customers Provision Resources
```

### 🚀 Day 1 = Completed ✅

**Core idea:**

> **Physical infrastructure → Virtualization → Private Cloud → Public Cloud → AWS**
