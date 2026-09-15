<div align="center">

# 🚀 AWS ZERO TO HERO — DAY 3

## 🖥️ EC2 — ELASTIC COMPUTE CLOUD

</div>

> **My goal for Day 3:** I want to understand what EC2 is, why we use it, the different instance types, Regions and Availability Zones, how to launch an EC2 instance, connect to it using SSH, and deploy Jenkins on it.

---

# 1. 🖥️ What is EC2?

EC2 stands for:

> **Elastic Compute Cloud**

The simplest way I understand EC2 is:

> **EC2 allows me to create and use virtual servers in the AWS Cloud.**

Instead of buying a physical server myself:

```text
Physical Server
      ↓
    Buy
      ↓
  Install OS
      ↓
  Configure
      ↓
   Maintain
```

I can use AWS:

```text
You
 ↓
AWS EC2
 ↓
Virtual Server
 ↓
Your Application
```

So basically:

> **EC2 gives me a virtual server in AWS that I can use to run my applications.**

---

# 2. 🧩 EC2 = Elastic + Cloud + Compute

My teacher broke the name into three words:

```text
              EC2
               ↓
      ┌────────┼────────┐
      ↓        ↓        ↓
   Elastic   Cloud    Compute
```

I need to understand what each word means.

---

# 3. 💻 Compute

**Compute** means computing resources.

An EC2 instance provides resources such as:

```text
EC2 Instance
├── CPU
├── RAM
├── Storage
├── Operating System
└── Networking
```

So when I create an EC2 instance, I can think:

> **"AWS, give me a virtual server with the computing resources I need."**

Therefore:

> **Compute = Virtual server / computing resources.**

---

# 4. ☁️ Cloud

Why is it called **Cloud**?

Because the virtual servers are running on AWS's cloud infrastructure.

AWS has physical infrastructure in different parts of the world.

I don't need to buy the physical server myself.

The basic idea is:

```text
AWS Data Center
      ↓
Physical Servers
      ↓
Virtualization
      ↓
EC2 Instance
      ↓
I use it
```

So:

> **Cloud = AWS provides the computing infrastructure through its cloud platform.**

---

# 5. 🪢 Elastic

This is another important word.

AWS uses the word **Elastic** for services/resources that can be scaled or adjusted.

For example, I can change the resources of an EC2 instance according to my requirement.

I might start with:

```text
Small workload
      ↓
Small instance
```

Later:

```text
Large workload
      ↓
Larger instance
```

So I remember:

> **Elastic = ability to adjust/scale resources according to requirement.**

AWS has several services with "Elastic" in their names, such as:

* EC2 — Elastic Compute Cloud
* EKS — Elastic Kubernetes Service
* Elastic Beanstalk
* Elastic Load Balancing

---

# 6. 🎯 EC2 in One Sentence

The complete meaning I need to remember is:

> **EC2 (Elastic Compute Cloud) is an AWS service that provides virtual servers in the cloud, with configurable computing resources that can be adjusted according to requirements.**

---

# 7. 🤔 Why Do We Need EC2?

Now comes the **WHY**.

Imagine I am a DevOps engineer and I need:

```text
1000 virtual machines
```

I could build my own infrastructure.

I would need:

```text
Physical Servers
       ↓
    Hypervisor
       ↓
 Virtual Machines
       ↓
   Networking
       ↓
    Security
       ↓
    Updates
       ↓
  Maintenance
```

But creating the servers is not the end.

I would also need to maintain them.

---

# 8. 🛠️ The Maintenance Problem

Suppose I have:

```text
1000 servers
```

I would continuously need to check:

```text
Are servers running?
Are they updated?
Are there security issues?
Are packages outdated?
Did a server go down?
Are there vulnerabilities?
```

I could spend a huge amount of time maintaining the infrastructure.

That becomes a major operational burden.

---

# 9. ☁️ EC2 Reduces Infrastructure Management

Instead of buying and maintaining all the underlying physical infrastructure myself:

```text
You
 ↓
AWS
 ↓
EC2
```

AWS manages the **underlying cloud infrastructure**.

This reduces the infrastructure management effort for me.

### But important:

EC2 does **not** mean AWS manages everything for me.

For an EC2 instance, I still generally manage:

* Operating system
* OS updates
* Packages
* Applications
* Application configuration
* My workloads

So the important distinction is:

```text
AWS
 ↓
Underlying physical infrastructure
```

while I manage things inside my EC2 instance such as:

```text
EC2
 ↓
Operating System
 ↓
Packages
 ↓
Application
 ↓
My Workload
```

---

# 10. 💰 Cost Advantage

Another major reason to use cloud computing is:

> **Cost flexibility**

Imagine I buy a physical server.

Once I purchase it, I have already paid for it whether I am using it or not.

Cloud computing provides a **pay-as-you-go** model.

Conceptually:

```text
Use EC2
   ↓
Pay for usage
```

This allows me to provision resources when I need them instead of purchasing fixed physical capacity upfront.

---

# 11. 🛑 Example — Night Time

Suppose my application is only needed during working hours.

Conceptually:

```text
DAY
 ↓
EC2 Running
 ↓
Application available
```

At night:

```text
NIGHT
 ↓
EC2 stopped
 ↓
No compute usage while stopped
```

This can help optimize costs.

The same idea can apply during periods when nobody needs the servers, such as certain holidays or business shutdown periods.

### ⚠️ Important

Stopping an EC2 instance does **not necessarily mean every related AWS charge becomes zero**.

For example, attached storage can still incur charges.

So I should always understand what resources I am paying for.

---

# 12. 🧠 Two Major Reasons for EC2

The two main reasons I should remember are:

```text
EC2
 |
 ├── Reduced infrastructure management
 |
 └── Cost flexibility
```

That's the main **WHY**.

---

# 13. 🧩 EC2 Instance Types

Not every application needs the same resources.

For example:

### Application A

Needs a balanced amount of:

```text
CPU
RAM
```

### Application B

Needs a lot of CPU.

### Application C

Needs a lot of RAM.

### Application D

Needs high storage performance.

### Application E

Needs GPUs/accelerators.

So AWS provides different EC2 categories.

---

# 14. 🏷️ Main EC2 Instance Categories

The five categories from the lesson are:

```text
1. General Purpose
2. Compute Optimized
3. Memory Optimized
4. Storage Optimized
5. Accelerated Computing
```

---

# 15. 1️⃣ General Purpose

General Purpose provides a balanced combination of:

```text
CPU
RAM
Networking
```

It is suitable for general workloads.

For the practicals, we mostly use general-purpose instances.

I can think:

```text
Normal workload
      ↓
General Purpose
```

---

# 16. 2️⃣ Compute Optimized

Compute Optimized instances are designed for workloads requiring strong CPU performance.

Think:

```text
CPU-heavy application
       ↓
Compute Optimized
```

Examples include:

* CPU-intensive applications
* Batch processing
* High-performance computing workloads

---

# 17. 3️⃣ Memory Optimized

Memory Optimized instances are designed for applications requiring large amounts of RAM.

Think:

```text
RAM-heavy application
       ↓
Memory Optimized
```

They are useful for workloads that process large datasets in memory.

---

# 18. 4️⃣ Storage Optimized

Storage Optimized instances are designed for workloads requiring high-performance local storage or high disk I/O.

Think:

```text
Storage / Disk I/O heavy
          ↓
Storage Optimized
```

---

# 19. 5️⃣ Accelerated Computing

Accelerated Computing uses specialized hardware accelerators such as GPUs or other accelerators.

Useful for:

```text
Machine Learning
AI
Graphics
Specialized computation
```

Think:

```text
GPU / Accelerator workload
          ↓
Accelerated Computing
```

---

# 20. 🧠 How Do I Choose an Instance Type?

The main idea is:

> **I choose the instance type according to the application's resource requirements.**

```text
Normal application
      ↓
General Purpose

CPU-intensive
      ↓
Compute Optimized

RAM-intensive
      ↓
Memory Optimized

Storage-intensive
      ↓
Storage Optimized

GPU / accelerator workload
      ↓
Accelerated Computing
```

I don't need to memorize every EC2 family right now.

I need to understand **the categories and their purpose**.

---

# 21. 🌍 AWS Regions

AWS has infrastructure around the world.

Examples include locations such as:

```text
India
USA
Europe
Singapore
Australia
```

AWS divides its global infrastructure into geographical **Regions**.

A Region is:

> **A geographical area where AWS has infrastructure.**

Examples from the lesson include:

```text
Mumbai
Frankfurt
North Virginia
Ohio
Oregon
Sydney
Singapore
```

---

# 22. 🤔 Why Do I Choose a Region?

There are two major reasons emphasized in the lesson.

## 1. Data requirements / compliance

Suppose I work with a European bank.

The customer may require data to remain within a particular geographical area because of regulatory or organizational requirements.

So I may select an appropriate European AWS Region.

Conceptually:

```text
European Customer
       ↓
European AWS Region
```

---

# 23. ⚡ 2. Latency

Another important reason is:

> **Latency**

Latency is the time taken for communication between the user and the application/server.

For example:

```text
User
 ↓
Mumbai Server
```

If the user is in India, the communication distance may be relatively small.

But:

```text
User in USA
      ↓
Server in Mumbai
```

The communication has to travel much farther.

That can increase latency.

So:

> **Lower latency generally means faster communication between the client and the application.**

---

# 24. 🧠 Simple Latency Example

I can think about it like ordering something.

Nearby shop:

```text
You → Shop
      ↓
Short distance
      ↓
Faster
```

Far-away shop:

```text
You → Shop
      ↓
Long distance
      ↓
More travel time
```

Networking works in a similar way.

---

# 25. 🌍 Availability Zones

Inside an AWS Region, there are multiple:

> **Availability Zones (AZs)**

I can visualize it like:

```text
              AWS Region
                   |
        ┌──────────┼──────────┐
        ↓          ↓          ↓
       AZ-A       AZ-B       AZ-C
```

An Availability Zone consists of one or more discrete data centers with redundant power, networking, and connectivity.

The important thing to remember is:

> **A Region contains multiple Availability Zones.**

---

# 26. 🤔 Why Do We Need Availability Zones?

Suppose I deploy my entire application in only one Availability Zone:

```text
Region
  ↓
AZ-A
  ↓
Application
```

If that Availability Zone experiences a failure, my application may become unavailable.

To improve availability, I can distribute the application across multiple AZs:

```text
                 Region
                   |
            ┌──────┴──────┐
            ↓             ↓
           AZ-A          AZ-B
            ↓             ↓
          App-1         App-2
```

If one AZ has a problem, another AZ can potentially continue serving traffic, depending on how the application is designed.

---

# 27. 🔥 Region vs Availability Zone

This is an important interview question.

| Region                          | Availability Zone                 |
| ------------------------------- | --------------------------------- |
| Geographical area               | Isolated location within a Region |
| Contains multiple AZs           | Belongs to one Region             |
| Used for geographical placement | Used for availability/resilience  |
| Example: Mumbai Region          | Individual AZ within Mumbai       |

### Easy memory trick

> **Region = Geographical area**

> **AZ = Separate infrastructure location inside that Region**

---

# 28. 🏗️ Practical — Create an EC2 Instance

Now I follow the practical.

The basic flow is:

```text
AWS Console
     ↓
EC2
     ↓
Instances
     ↓
Launch Instance
```

---

# 29. 🏷️ Step 1 — Name the Instance

I give the instance a name.

Example:

```text
my-first-ec2
```

The name is mainly used to identify the instance in the AWS console.

---

# 30. 🐧 Step 2 — Choose an Operating System

An EC2 instance needs an operating system.

Examples:

```text
Ubuntu
Amazon Linux
Windows
```

For this practical, I use:

```text
Ubuntu
```

---

# 31. 🖥️ Step 3 — Choose Instance Type

Now I select an EC2 instance type.

For the practicals, we generally use:

> **General Purpose**

The instance type determines resources such as:

```text
vCPU
Memory
Network performance
```

It also affects pricing.

---

# 32. 🔑 Step 4 — Key Pair

This is extremely important.

AWS asks me to create or select a:

> **Key Pair**

A key pair contains:

```text
Public Key
Private Key
```

Think:

```text
Key Pair
   |
   ├── Public Key
   └── Private Key
```

---

# 33. 🔐 Public Key vs Private Key

The **public key** goes with the server.

The **private key** stays with me.

Conceptually:

```text
AWS EC2
   ↓
Public Key
```

My computer:

```text
My Computer
     ↓
Private Key
```

When I connect:

```text
My Computer
     |
     | Private Key
     ↓
    EC2
     |
     | Public Key
```

The keys work together to authenticate me.

---

# 34. ⚠️ Protect the Private Key

This is extremely important.

My `.pem` file is sensitive.

Example:

```text
AWS-login.pem
```

I should:

```text
❌ Never upload it publicly
❌ Never commit it to GitHub
❌ Never share it with strangers
❌ Never put it in my application repository
```

I need to keep the private key secure.

---

# 35. 🗝️ Creating the Key Pair

The practical demonstrates:

```text
Create New Key Pair
```

Then:

```text
RSA
```

I can name it something like:

```text
AWS-login
```

AWS downloads:

```text
AWS-login.pem
```

I must keep this file safe.

---

# 36. 🌐 Step 5 — Network Settings

For this particular lesson, the teacher says not to change the networking settings because networking will be covered in future lessons.

Later I will learn about:

* VPC
* Subnets
* Security Groups
* Routing
* Route Tables
* Firewalls
* Public/private networking

For today's practical, I follow the default configuration shown by the teacher.

---

# 37. 💾 Storage

EC2 provides storage for the instance.

The practical shows:

```text
8 GB
```

The important idea is that I can configure storage according to my requirement.

For example:

```text
8 GB
20 GB
50 GB
100 GB
...
```

The exact available options depend on the selected configuration.

---

# 38. 🚀 Step 6 — Launch the Instance

After configuring the required options:

```text
Launch Instance
```

AWS starts creating the EC2 instance.

Initially it may show:

```text
Pending
```

Then eventually:

```text
Running
```

---

# 39. 🟢 Instance Running

Once the instance is running, I can click the instance ID.

I can see information such as:

```text
Public IPv4 address
Private IPv4 address
```

Both are important.

---

# 40. 🌐 Public IP Address

The **public IP address** can be used for communication with the instance from outside, when the network and security configuration allows it.

Conceptually:

```text
Your Laptop
     |
  Internet
     |
  Public IP
     |
    EC2
```

This is what I use in the practical when connecting to the EC2 instance from my laptop.

---

# 41. 🔒 Private IP Address

The private IP is used within the AWS networking environment.

Conceptually:

```text
AWS Network
     |
 Private IP
     |
    EC2
```

For now, I remember:

> **Public IP → external connectivity**

> **Private IP → internal AWS networking**

More detailed networking will come later.

---

# 42. 💻 Connecting to EC2

Now that my EC2 instance is running, I need to log into it.

The method depends on my operating system.

### Mac/Linux

I can use:

```text
Terminal
```

### Windows

I can use tools such as:

```text
PuTTY
MobaXterm
```

The teacher also demonstrated MobaXterm as a convenient option.

---

# 43. 🔐 SSH Connection

For the Ubuntu EC2 instance, I use:

> **SSH — Secure Shell**

The basic command is:

```bash
ssh -i AWS-login.pem ubuntu@PUBLIC_IP
```

I need to understand every part.

### `ssh`

Means:

> Secure Shell

It is used to connect to a remote machine securely.

### `-i`

Specifies the identity/private key file.

### `AWS-login.pem`

My private key.

### `ubuntu`

The username.

### `PUBLIC_IP`

The EC2 instance's public IP address.

So the general structure is:

```bash
ssh -i key.pem username@server-ip
```

---

# 44. 👤 Why `ubuntu`?

Because I created an **Ubuntu EC2 instance**.

Ubuntu images generally provide a default login user named:

```text
ubuntu
```

So:

```text
ubuntu@PUBLIC_IP
```

means:

> Connect as the `ubuntu` user to that server.

Different operating-system images can have different default usernames.

---

# 45. 🚨 `.pem` Permission Error

When I try to use the private key, SSH may complain that its permissions are too open.

For example:

```text
Permissions for 'AWS-login.pem' are too open
```

Why?

Because the private key is sensitive.

Linux permissions need to be restrictive enough so other users cannot access the private key.

---

# 46. 🔢 `chmod 600`

The teacher uses:

```bash
chmod 600 AWS-login.pem
```

This changes the permissions of the private key.

I can understand `600` like this:

```text
600
 |
 ├── Owner  → read + write
 ├── Group  → no permissions
 └── Others → no permissions
```

Or:

```text
Owner  → rw-
Group  → ---
Others → ---
```

This protects the private key.

---

# 47. 🔐 Connect Again

After fixing the permissions:

```bash
ssh -i AWS-login.pem ubuntu@PUBLIC_IP
```

The SSH connection succeeds.

🎉 Now I am **inside the EC2 instance**.

---

# 48. 🖥️ I Am Now Inside the Server

My terminal is now interacting with the remote EC2 server.

I can verify the current user:

```bash
whoami
```

It returns:

```text
ubuntu
```

This tells me that I am currently logged in as the Ubuntu user.

---

# 49. 👑 Switching to Root

The teacher also demonstrates switching to root.

Conceptually:

```text
ubuntu user
     ↓
   sudo
     ↓
   root
```

One command shown is:

```bash
sudo su -
```

This switches to a root shell.

Root has very high privileges, so I need to use it carefully.

---

# 50. 🔑 What is `sudo`?

`sudo` allows an authorized user to execute a command with elevated privileges.

For example:

```bash
sudo apt update
```

means:

> Run `apt update` with elevated privileges.

If I am already root, I generally don't need `sudo`.

---

# 51. 📦 Update Packages

After logging into a new Ubuntu instance, the teacher updates the package repository information.

Command:

```bash
sudo apt update
```

If I am root:

```bash
apt update
```

This refreshes the package information available from the configured repositories.

---

# 52. ☕ Install Java

The application I am going to deploy is:

> **Jenkins**

Jenkins requires Java.

So I first install Java.

The command demonstrated is:

```bash
sudo apt install openjdk-11-jdk
```

Then verify:

```bash
java --version
```

If Java is installed correctly, I should see its version.

---

# 53. 🔧 Install Jenkins

Now I install Jenkins according to the Jenkins installation instructions for Ubuntu.

The overall flow from the lesson is:

```text
Jenkins
   ↓
Installation
   ↓
Linux
   ↓
Ubuntu
```

The important thing for me is not memorizing every installation command.

The important DevOps idea is:

```text
EC2
 ↓
Login
 ↓
Update OS
 ↓
Install dependencies
 ↓
Install application
```

This is a common type of task I can perform on an EC2 server.

---

# 54. 🚀 Jenkins on EC2

After installation, the setup looks like:

```text
AWS EC2
   |
   ↓
Ubuntu
   |
   ↓
Java
   |
   ↓
Jenkins
```

So Jenkins is running **inside the EC2 instance**.

---

# 55. 🔍 Check Jenkins Status

I need to verify whether Jenkins is running.

Command:

```bash
systemctl status jenkins
```

This tells me whether the Jenkins service is:

```text
active
inactive
failed
```

For example:

```text
Active: active (running)
```

means Jenkins is running.

---

# 56. 🌍 Access Jenkins From My Laptop

Now I have:

```text
Your Laptop
      |
   Internet
      |
     AWS
      |
     EC2
      |
   Jenkins
```

Jenkins is running inside the EC2 instance.

But I want to open Jenkins from my laptop browser.

For this to work, the network/security configuration needs to allow traffic to Jenkins's listening port.

This is where **Security Groups and networking** become important.

The key idea is:

```text
Browser
   ↓
Internet
   ↓
EC2 Public IP
   ↓
Allowed port
   ↓
Jenkins
```

If the required traffic is not allowed, Jenkins can be running correctly while I still cannot access it from outside.

---

# 57. 🔥 Complete Day 3 Practical Flow

This is the complete practical:

```text
AWS Console
     ↓
EC2
     ↓
Launch Instance
     ↓
Choose Ubuntu
     ↓
Choose Instance Type
     ↓
Create / Select Key Pair
     ↓
Configure Networking
     ↓
Configure Storage
     ↓
Launch
     ↓
Instance Running
     ↓
Get Public IP
     ↓
SSH
     ↓
EC2 Server
     ↓
ubuntu user
     ↓
Update packages
     ↓
Install Java
     ↓
Install Jenkins
     ↓
Check Jenkins
     ↓
Configure access
     ↓
Open Jenkins from browser
```

---

# 58. 🧠 EC2 — Complete Mental Model

I understand EC2 like this:

```text
                         AWS
                          |
                         EC2
                          |
              Elastic Compute Cloud
                          |
              ┌───────────┼───────────┐
              ↓           ↓           ↓
           Elastic      Cloud       Compute
              |           |           |
        Adjustable      AWS       Virtual Server
        Resources     Platform
                          |
                   ┌──────┼──────┐
                   ↓      ↓      ↓
                  CPU    RAM   Storage
```

---

# 59. 🌍 AWS Global Structure

I remember the geographical structure like:

```text
                         AWS
                          |
        ┌─────────────────┼─────────────────┐
        ↓                 ↓                 ↓
     Region             Region            Region
        |
    ┌───┴───┐
    ↓       ↓
   AZ-A    AZ-B
    ↓       ↓
 Servers  Servers
```

The important relationship:

```text
AWS
 ↓
Region
 ↓
Availability Zones
 ↓
Infrastructure
```

---

# 60. 🎯 EC2 Instance Types — Quick Revision

```text
General Purpose
       ↓
Balanced CPU + RAM

Compute Optimized
       ↓
CPU intensive

Memory Optimized
       ↓
RAM intensive

Storage Optimized
       ↓
Storage / I/O intensive

Accelerated Computing
       ↓
GPU / specialized acceleration
```

---

# 61. 🎯 Region vs AZ — Quick Revision

### REGION

```text
Region
 ↓
Geographical area
 ↓
Contains multiple Availability Zones
```

### AVAILABILITY ZONE

```text
Availability Zone
 ↓
Isolated infrastructure location
 ↓
Located inside a Region
 ↓
Used to improve availability/resilience
```

---

# 62. 🎯 EC2 Creation — Quick Revision

```text
Choose Region
     ↓
Launch Instance
     ↓
Choose OS
     ↓
Choose Instance Type
     ↓
Key Pair
     ↓
Networking
     ↓
Storage
     ↓
Launch
```

---

# 63. 🔐 EC2 Connection — Quick Revision

```text
EC2 Running
     ↓
Public IP
     ↓
Private Key
     ↓
SSH
     ↓
Ubuntu User
     ↓
EC2 Server
```

Command:

```bash
ssh -i AWS-login.pem ubuntu@PUBLIC_IP
```

If the key permissions are too open:

```bash
chmod 600 AWS-login.pem
```

---

# 64. 🚀 Application Deployment — Quick Revision

```text
EC2
 ↓
Ubuntu
 ↓
apt update
 ↓
Java
 ↓
Jenkins
 ↓
systemctl status jenkins
 ↓
Browser Access
```

---

# 65. 🎤 Day 3 Interview Questions

## 1. What is EC2?

> **EC2 stands for Elastic Compute Cloud. It is an AWS service that provides virtual servers in the cloud.**

---

## 2. Why do we use EC2?

> **EC2 allows us to provision virtual servers without purchasing and managing the underlying physical server infrastructure ourselves. It provides flexibility and a pay-as-you-go model.**

---

## 3. What are the main EC2 instance categories?

> **General Purpose, Compute Optimized, Memory Optimized, Storage Optimized, and Accelerated Computing.**

---

## 4. What is a Region?

> **An AWS Region is a geographical area containing multiple AWS Availability Zones.**

---

## 5. What is an Availability Zone?

> **An Availability Zone is an isolated location within an AWS Region, designed to provide independent infrastructure and improve application availability and resilience.**

---

## 6. Why deploy across multiple Availability Zones?

> **To improve availability and resilience so that an application can continue operating if one Availability Zone experiences a failure.**

---

## 7. What is latency?

> **Latency is the time taken for data or a request to travel between the client and the application/server and for the response to return.**

---

## 8. Why does Region selection matter?

> **Region selection can affect latency, data residency/compliance requirements, availability architecture, and cost.**

---

## 9. What is a key pair?

> **An EC2 key pair consists of a public key and a private key and is commonly used to securely authenticate to an EC2 instance.**

---

## 10. Why should we protect the `.pem` file?

> **Because it contains the private key used for authentication. It should never be publicly exposed or committed to a repository.**

---

## 11. What does `chmod 600` do?

> **It gives the file owner read and write permissions while removing permissions for the group and other users.**

---

## 12. What is a public IP?

> **A public IP can be used for communication between the EC2 instance and external networks, provided the relevant networking and security configuration allows the traffic.**

---

## 13. What is a private IP?

> **A private IP is used for communication within the private AWS networking environment.**

---

# 📝 DAY 3 — 5-MINUTE REVISION

If I have only a few minutes before an interview, I remember this:

### EC2

```text
EC2
 ↓
Elastic Compute Cloud
 ↓
Virtual Server in AWS
```

### Why EC2?

```text
Reduced infrastructure burden
          +
Flexible provisioning
          +
Pay-as-you-go
          +
Scalability
```

### Instance Types

```text
General Purpose
Compute Optimized
Memory Optimized
Storage Optimized
Accelerated Computing
```

### Geography

```text
AWS
 ↓
Region
 ↓
Availability Zones
 ↓
Infrastructure
```

### Connection

```text
EC2 Running
 ↓
Public IP
 ↓
Private Key
 ↓
SSH
 ↓
Ubuntu
 ↓
Server
```

### Practical

```text
EC2
 ↓
Ubuntu
 ↓
apt update
 ↓
Java
 ↓
Jenkins
 ↓
systemctl status jenkins
 ↓
Browser Access
```

---

# 🔥 THE STORY I SHOULD REMEMBER

I don't want to memorize EC2 as random definitions.

I want to understand the complete story:

> **EC2 is AWS's virtual-server service. Instead of buying a physical server and managing the underlying infrastructure myself, I can request a virtual server from AWS. I choose the required Region, operating system, instance type, storage, networking configuration and authentication key. Once the instance is running, I can connect to it using SSH and my private key. After connecting, I manage the operating system, install required dependencies and deploy applications. In this practical, I used Ubuntu, installed Java, installed Jenkins, checked the Jenkins service and then looked at how Jenkins can be accessed from outside through the EC2 networking and security configuration.**

---

# 🏆 DAY 3 FINAL MEMORY MAP

```text
                         EC2
                          |
             Elastic Compute Cloud
                          |
                    Virtual Server
                          |
          ┌───────────────┼───────────────┐
          ↓               ↓               ↓
        CPU              RAM           Storage
                          |
                     AWS Region
                          |
                Availability Zones
                          |
                      EC2 Instance
                          |
                ┌─────────┴─────────┐
                ↓                   ↓
           Public IP            Private IP
                |
               SSH
                |
          Private Key
                |
             Ubuntu
                |
           sudo / root
                |
           apt update
                |
              Java
                |
             Jenkins
                |
       systemctl status jenkins
                |
        External Browser Access
```

## 💡 My main takeaway

> **EC2 = a virtual server in AWS.**

I need to understand:

```text
What is EC2?
      ↓
Why EC2?
      ↓
Instance types
      ↓
Region
      ↓
Availability Zone
      ↓
Launch EC2
      ↓
Key Pair
      ↓
Public / Private IP
      ↓
SSH
      ↓
Ubuntu
      ↓
sudo
      ↓
apt update
      ↓
Java
      ↓
Jenkins
      ↓
Service status
      ↓
External access
```

**That is my Day 3 EC2 foundation.**
