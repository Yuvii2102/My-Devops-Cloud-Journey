<div align="center">

# DAY 4 — AMAZON VPC

</div>

## 🔐 Amazon VPC — Virtual Private Cloud

Bro, VPC is a **very important AWS networking topic**.

At first, VPC can look complicated because it has many networking components:

* VPC
* Subnets
* Internet Gateway
* Route Tables
* Security Groups
* NACLs
* NAT Gateway
* Load Balancer
* VPC Flow Logs

I understood this lesson mainly through a **real-life secure community example** and then mapped that example to AWS.

> **Main idea:** VPC gives my AWS project a logically isolated network where I can control IP addressing, subnets, routing, and security.

---

# 1. 🌐 What is VPC?

VPC stands for:

> **Virtual Private Cloud**

A VPC is a **logically isolated network** that I create in AWS where I can place and control AWS resources such as EC2 instances.

I can think of it like:

```text
AWS Region
     ↓
   Your VPC
     ↓
Your private network
     ↓
   Subnets
     ↓
EC2 / Applications
```

So instead of just launching an EC2 instance without understanding its networking, I create a network environment where I can decide how my resources communicate.

---

# 2. 🤔 Why Do I Need a VPC?

The easiest way I understood VPC was through the teacher's **gated-community example**.

---

# 3. 🏘️ Real-Life Example — Village

Imagine a huge village.

Many people live there.

Some people don't want to:

* Build their own house
* Maintain their house
* Manage construction
* Take care of infrastructure

So a person called **ABC** sees an opportunity.

He purchases a huge piece of land.

```text
                 HUGE LAND
                     |
        ---------------------------
        |            |            |
      House A      House B      House C
```

ABC builds and maintains the houses.

The people pay ABC for using them.

---

# 4. 🚨 The Security Problem

Now imagine all the houses are very close together.

If someone compromises one house:

```text
House A
   ↓
Hacker
   ↓
Can potentially reach
   ↓
House B / House C
```

That creates a security and privacy problem.

The residents want:

> "We want our houses, but we also want isolation and security."

---

# 5. 🏘️ Secure / Gated Community

ABC creates a secure community.

```text
              HUGE LAND
                  |
        ┌─────────────────┐
        │ Secure Community│
        │                 │
        │ House A         │
        │ House B         │
        │ House C         │
        └─────────────────┘
                  ↑
               GATEWAY
                  ↑
                Outside
```

Now not everyone can enter.

There is a **gate**.

There can be:

* Security guards
* Entry rules
* Internal paths
* Restrictions

---

# 6. 🚪 Gateway

Suppose someone wants to visit House A.

They can't simply jump directly into the community.

They must go through:

```text
Outside
   ↓
Gateway
   ↓
Secure Community
   ↓
House A
```

The gateway controls entry into the secure community.

---

# 7. 🛣️ Internal Routing

Now imagine I've entered the community.

I want to go to House A.

Someone needs to tell me:

> "Go through this path."

That's **routing**.

```text
Gateway
   ↓
 Path
   ↓
House A
```

There can also be another security check before reaching the house.

So the overall system becomes:

```text
Authentication / Entry
        ↓
     Gateway
        ↓
     Routing
        ↓
     Security
        ↓
 Specific House
```

---

# 8. ☁️ Converting This to AWS

Now I map the same story to AWS.

Imagine an AWS Region.

```text
Mumbai Region
```

AWS owns the underlying infrastructure.

Different companies want to run their applications.

For example:

```text
TCS
Example.com
Example1.com
Example2.com
```

Each company needs its own secure networking environment.

That's where **VPC** comes in.

---

# 9. 🏢 VPC = My Secure Network

I can think of my VPC like this:

```text
AWS Region
┌─────────────────────────────────┐
│                                 │
│            Your VPC             │
│                                 │
│     Your private network        │
│                                 │
└─────────────────────────────────┘
```

The VPC provides the **networking boundary** for my AWS resources.

---

# 10. 🧮 VPC IP Address Range

A VPC has an:

> **IP Address Range**

For example:

```text
172.16.0.0/16
```

This is called a **CIDR block**.

For this lesson, I remember:

> **The CIDR block defines the address space of my VPC.**

---

# 11. 🧠 Why Does My VPC Need IP Addresses?

Every network resource needs an IP address to communicate.

For example:

```text
VPC
 |
 ├── EC2 → IP
 ├── EC2 → IP
 ├── EC2 → IP
 └── Other resources → IP
```

So when creating a VPC, I decide the IP address range from which my resources can receive private IP addresses.

---

# 12. ✂️ Subnet

Now I take my VPC IP range and divide it into smaller networks.

Suppose:

```text
VPC
172.16.0.0/16
```

I have different projects:

```text
Project A
Project B
Project C
```

I can divide the VPC address space:

```text
Project A → 172.16.1.0/24
Project B → 172.16.2.0/24
Project C → 172.16.3.0/24
```

These smaller networks are called:

> **Subnets**

---

# 13. 📦 What is a Subnet?

Subnet literally means:

> **Sub-network**

So:

```text
VPC
172.16.0.0/16
        |
        ├── Subnet A
        ├── Subnet B
        └── Subnet C
```

I understand a subnet as:

> **A subdivision of the VPC's IP address range.**

---

# 14. 🧩 Real-Life → AWS Mapping

This is the mapping I need to remember:

| Real Life               | AWS                      |
| ----------------------- | ------------------------ |
| Huge land               | VPC                      |
| Secure community        | VPC                      |
| Houses                  | Applications / Resources |
| Dividing the property   | Subnets                  |
| Gate                    | Internet Gateway         |
| Internal paths          | Route Tables             |
| Security guard          | Security controls        |
| Houses inside community | EC2 / Resources          |

This analogy is the **main idea of the lesson**.

---

# 15. 🏗️ Applications Inside Subnets

A VPC can contain multiple subnets.

```text
VPC
 |
 ├── Subnet A
 │     └── EC2
 │
 ├── Subnet B
 │     ├── EC2
 │     └── EC2
 │
 └── Subnet C
       ├── EC2
       ├── EC2
       └── EC2
```

Different projects can have different numbers of resources.

The subnet provides the network boundary/address space in which those resources are placed.

---

# 16. 🌎 Public vs Private Subnet

This is **very important**.

## 🌐 Public Subnet

A public subnet has a route allowing traffic to/from the internet through an **Internet Gateway**.

## 🔒 Private Subnet

A private subnet does not have a direct route to the Internet Gateway for internet access.

Conceptually:

```text
                  VPC
                   |
        ----------------------
        |                    |
   Public Subnet       Private Subnet
        |                    |
   Load Balancer             EC2
```

---

# 17. 🌐 Internet Gateway — IGW

The next component is:

> **Internet Gateway**

I can think of the Internet Gateway as the **gate of the secure community**.

It provides a path between the VPC and the internet when routing and other configuration allow that connectivity.

```text
Internet
    |
    ↓
Internet Gateway
    |
    ↓
VPC
```

So my simple understanding is:

> **Internet Gateway = Gateway that enables internet connectivity for a VPC when the required configuration allows it.**

---

# 18. 🌍 Public Subnet + Internet Gateway

For a public subnet:

```text
Internet
   ↓
Internet Gateway
   ↓
Public Subnet
```

A common resource placed in a public subnet is a **public-facing Load Balancer**.

For example:

```text
Internet
   ↓
Internet Gateway
   ↓
Public Subnet
   ↓
Load Balancer
```

---

# 19. ⚖️ Load Balancer

The AWS service is:

> **Elastic Load Balancer (ELB)**

The basic purpose of a load balancer is:

> **Receive incoming requests and distribute them to appropriate backend targets.**

For example:

```text
             Users
           /    |    \
          ↓     ↓     ↓
       Internet
          ↓
     Load Balancer
        /       \
       ↓         ↓
    EC2-A      EC2-B
```

So users don't necessarily connect directly to individual backend servers.

---

# 20. 🎯 Target Group

A **Target Group** contains the backend targets to which the load balancer can send traffic.

```text
Load Balancer
      ↓
Target Group
      |
   ---------
   |       |
 EC2-A   EC2-B
```

For now, I just need to remember:

> **Load Balancer receives requests and sends them to appropriate backend targets.**

I'll learn target groups in more detail later.

---

# 21. 🛣️ Route Table

Another critical VPC component is the:

> **Route Table**

I can think of a route table as a **path map**.

A route table determines where network traffic should go.

```text
Traffic
   ↓
Route Table
   ↓
Where should this traffic go?
```

Example:

```text
Destination             Target
0.0.0.0/0               Internet Gateway
```

This means traffic destined for anywhere on the internet should use the Internet Gateway, assuming the subnet/resource is configured appropriately.

---

# 22. 🧠 Route Table in Simple Words

I can compare a route table to Google Maps.

I say:

> "I want to go from A to B."

The map gives me a path:

```text
A
 ↓
Road 1
 ↓
Road 2
 ↓
Road 3
 ↓
B
```

Similarly, a route table tells AWS:

> **"For this destination, send the traffic through this target."**

---

# 23. 🔐 Security Group

Now comes:

> **Security Group**

A Security Group acts as a **virtual firewall** for resources such as EC2 instances.

It controls what traffic is allowed to reach or leave the associated resource based on rules.

Conceptually:

```text
Internet
   ↓
Load Balancer
   ↓
Security Group
   ↓
EC2
```

Security Group rules can allow things such as:

```text
Allow HTTP
Allow HTTPS
Allow SSH from specific IP
```

Traffic not allowed by the applicable rules is blocked.

---

# 24. 🚨 Security Group Example

Suppose my EC2 is running an application on a particular port.

Someone from the internet tries to connect:

```text
Internet
   ↓
EC2
```

The Security Group checks its applicable rules.

If traffic is allowed:

```text
Request → ✅
```

If it isn't allowed:

```text
Request → ❌
```

So I can think of a Security Group like the **security guard at the house**.

---

# 25. 🔥 Complete Internet → Application Flow

Now I combine everything.

Suppose a customer wants to access an application running on an EC2 instance in a private subnet.

The conceptual flow is:

```text
                     INTERNET
                         |
                         ↓
                  INTERNET GATEWAY
                         |
                         ↓
                    PUBLIC SUBNET
                         |
                         ↓
                   LOAD BALANCER
                         |
                         ↓
                    ROUTE TABLE
                         |
                         ↓
                   PRIVATE SUBNET
                         |
                         ↓
                   SECURITY GROUP
                         |
                         ↓
                    EC2 INSTANCE
                         |
                         ↓
                    APPLICATION
```

This is the **core VPC traffic flow** I need to understand.

---

# 26. 🏠 Why Put EC2 in a Private Subnet?

I generally don't want backend application servers directly exposed to the public internet unnecessarily.

Instead:

```text
Internet
   ↓
Load Balancer
   ↓
Private EC2
```

The user interacts with the load balancer.

The backend EC2 instances can remain in a private subnet.

This creates a more secure architecture.

---

# 27. 🛡️ NACL

NACL stands for:

> **Network Access Control List**

NACLs provide another layer of network traffic control at the **subnet level**.

The most important distinction:

```text
Security Group → Resource level
NACL            → Subnet level
```

Another important difference:

> **Security Groups are stateful. NACLs are stateless.**

The teacher said NACLs would be explained in more detail in the next class, so I don't need to go too deep here.

---

# 28. 🆚 Security Group vs NACL

| Security Group                     | NACL                                |
| ---------------------------------- | ----------------------------------- |
| Resource level                     | Subnet level                        |
| Stateful                           | Stateless                           |
| Controls traffic at resource level | Controls traffic at subnet boundary |
| Uses allow rules                   | Supports allow and deny rules       |

### Easy way to remember

```text
Security Group → Resource
NACL            → Subnet
```

---

# 29. 🌐 NAT Gateway

Now comes an important question:

> **What if a private EC2 needs to access the internet?**

For example, my EC2 might need to:

* Download a package
* Download updates
* Access an external API
* Access a website

But I don't want the private EC2 to be directly reachable from the internet.

That's where:

> **NAT Gateway**

comes in.

---

# 30. 🔄 What Does NAT Mean?

NAT stands for:

> **Network Address Translation**

The basic idea is that private resources can initiate outbound internet connections through the NAT Gateway without requiring those private resources to have public IP addresses.

Conceptually:

```text
Private EC2
     ↓
NAT Gateway
     ↓
Internet Gateway
     ↓
Internet
```

---

# 31. 🔒 Why Do I Need NAT Gateway?

Imagine my private EC2:

```text
Private EC2
10.x.x.x
```

It wants to access:

```text
example.com
```

I don't want to give the private EC2 a public IP just for outbound internet access.

Instead:

```text
Private EC2
    ↓
NAT Gateway
    ↓
Internet
```

The external destination sees the public-side address used by the NAT Gateway rather than directly seeing the private IP of my EC2.

That's the basic NAT concept.

---

# 32. 📍 Where is NAT Gateway Created?

The teacher explained:

> **NAT Gateway is created in a public subnet.**

Common architecture:

```text
                  Internet
                     |
                     ↓
              Internet Gateway
                     |
                Public Subnet
                     |
                 NAT Gateway
                     |
                Private Subnet
                     |
                    EC2
```

The private subnet's route table sends internet-bound traffic to the NAT Gateway.

---

# 33. 🔄 NAT Traffic Flow

Suppose my EC2 wants to download something:

```text
EC2
 ↓
Private Subnet
 ↓
Route Table
 ↓
NAT Gateway
 ↓
Internet Gateway
 ↓
Internet
```

The response comes back through the corresponding path.

The important point is:

> **A private instance can initiate outbound internet access without being directly exposed as an internet-reachable server.**

---

# 34. ⚠️ Important NAT Clarification

I need to keep one thing clear:

> **NAT Gateway performs network address translation for outbound traffic from private subnets.**

A **Load Balancer** and a **NAT Gateway** are different AWS networking components with different purposes.

I should **not** memorize them as interchangeable.

---

# 35. 📊 VPC Flow Logs

Finally, the teacher introduces:

> **VPC Flow Logs**

Suppose my VPC has lots of traffic.

I want to understand:

```text
Who sent traffic?
Where was it going?
Was traffic accepted?
Was traffic rejected?
Which network interface was involved?
```

That's where VPC Flow Logs help.

---

# 36. 🔍 What Are VPC Flow Logs?

VPC Flow Logs capture information about network traffic flowing to and from network interfaces in my VPC.

Conceptually:

```text
Traffic
  ↓
VPC
  ↓
Flow Logs
  ↓
Traffic information
```

They can help with:

* Troubleshooting
* Network analysis
* Security investigation
* Understanding rejected traffic

So my simple understanding is:

> **VPC Flow Logs = visibility into network traffic.**

---

# 37. 🧠 VPC Flow Logs Example

Suppose my application isn't reachable.

I have:

```text
Internet
   ↓
IGW
   ↓
Load Balancer
   ↓
EC2
```

But something is blocking the traffic.

Flow Logs can help me investigate traffic records and determine whether traffic was accepted or rejected at the relevant network interface.

So:

> **VPC Flow Logs help me see what's happening with network traffic.**

---

# 38. 🧩 All VPC Components Together

Now I put everything together:

```text
                          INTERNET
                              |
                              ↓
                       INTERNET GATEWAY
                              |
                              ↓
                    ┌─────────────────┐
                    │      VPC        │
                    │                 │
                    │  PUBLIC SUBNET  │
                    │       |         │
                    │  Load Balancer  │
                    │       |         │
                    │       |         │
                    │  NAT Gateway    │
                    │       |         │
                    │       ↓         │
                    │  Route Table    │
                    │       |         │
                    │       ↓         │
                    │ PRIVATE SUBNET  │
                    │       |         │
                    │ Security Group  │
                    │       |         │
                    │      EC2        │
                    │       |         │
                    │  Application    │
                    │                 │
                    └─────────────────┘

                  VPC Flow Logs
                       ↓
                Traffic visibility
```

---

# 39. 🔥 Full Traffic Flow — Internet → EC2

This is one of the most important things from Day 4.

A user outside AWS wants to access my application.

### Step 1 — User sends request

```text
User
 ↓
Internet
```

### Step 2 — Traffic reaches the VPC

```text
Internet
 ↓
Internet Gateway
```

### Step 3 — Traffic reaches the public subnet

```text
Internet Gateway
 ↓
Public Subnet
```

### Step 4 — Request reaches the Load Balancer

```text
Load Balancer
```

### Step 5 — Load Balancer selects backend target

```text
Load Balancer
 ↓
Target Group
 ↓
EC2
```

### Step 6 — Routing and security allow traffic

```text
Route Table
 ↓
Private Subnet
 ↓
Security Group
 ↓
EC2
```

### Step 7 — Application processes the request

```text
EC2
 ↓
Application
```

---

# 40. 🔄 Full Traffic Flow — Private EC2 → Internet

Now suppose my private EC2 wants to download something.

The flow is:

```text
EC2
 ↓
Private Subnet
 ↓
Route Table
 ↓
NAT Gateway
 ↓
Internet Gateway
 ↓
Internet
 ↓
External Website
```

This is a different traffic direction from the public-user-to-application flow.

---

# 41. 🧠 The Two Flows I Must Know

## 🌍 External User → Application

```text
Internet
 ↓
Internet Gateway
 ↓
Public Subnet
 ↓
Load Balancer
 ↓
Private Subnet
 ↓
Security Group
 ↓
EC2
 ↓
Application
```

## 🖥️ Private EC2 → Internet

```text
EC2
 ↓
Private Subnet
 ↓
Route Table
 ↓
NAT Gateway
 ↓
Internet Gateway
 ↓
Internet
```

> **I should memorize these two flows and understand why each component exists.**

---

# 42. 🗺️ VPC Mental Model

The complete real-life analogy is:

```text
REAL LIFE                    AWS

Huge Land                →   VPC
Secure Community         →   VPC
Smaller areas            →   Subnets
Gate                     →   Internet Gateway
Road Map                 →   Route Table
Security Guard           →   Security Group
Subnet Security          →   NACL
Outbound Gateway         →   NAT Gateway
Houses                   →   EC2 / Application
Traffic Register         →   VPC Flow Logs
```

This makes the whole VPC easier for me to remember.

---

# 43. 🎯 What Does a DevOps Engineer Do With VPC?

As a DevOps / Cloud Engineer, I'll commonly work with:

```text
VPC
 ↓
Subnets
 ↓
Route Tables
 ↓
Internet Gateway
 ↓
NAT Gateway
 ↓
Security Groups
 ↓
NACLs
 ↓
Load Balancers
 ↓
EC2
```

I'll use these components to design how applications communicate securely.

---

# 44. 🏗️ Typical DevOps Architecture

A common architecture looks like:

```text
                    USERS
                      |
                   INTERNET
                      |
                      ↓
               INTERNET GATEWAY
                      |
                      ↓
                PUBLIC SUBNETS
                      |
                LOAD BALANCER
                      |
             -----------------------
             |                     |
             ↓                     ↓
        PRIVATE SUBNET       PRIVATE SUBNET
             |                     |
            EC2                   EC2
             |                     |
             -------- APPLICATION ---
                      |
                   DATABASE
```

The database would commonly be kept private rather than directly exposed to the internet.

---

# 45. 🧪 Day 4 Practical / Assignment

The teacher specifically explained that Day 4 is primarily a **foundation/theory class**.

The complete practical deployment comes in the following class.

So for Day 4, my main task is to **understand and inspect the concepts**, not invent a complete deployment that wasn't part of this lesson.

### I need to understand:

```text
VPC
Subnet
Internet Gateway
Public Subnet
Private Subnet
Route Table
Security Group
NACL
NAT Gateway
Load Balancer
Target Group
VPC Flow Logs
```

I should also:

1. Understand what a VPC is.
2. Understand why a VPC is required.
3. Go through AWS documentation.
4. Use the teacher's diagrams/GitHub repository to validate my understanding.

The goal is:

> **I should be able to explain the entire traffic flow without blindly memorizing it.**

---

# 46. 🎤 Interview Questions — Day 4

### Q1. What is VPC?

> **VPC stands for Virtual Private Cloud. It is a logically isolated network environment in AWS where I can launch and control AWS resources.**

### Q2. Why do we need VPC?

> **VPC allows me to design and control networking for AWS resources, including IP addressing, subnets, routing, and network security.**

### Q3. What is a subnet?

> **A subnet is a subdivision of a VPC's IP address range where AWS resources can be placed.**

### Q4. What is an Internet Gateway?

> **An Internet Gateway provides a path between a VPC and the internet for resources that have appropriate routing and public addressing.**

### Q5. What is a public subnet?

> **A public subnet has a route to an Internet Gateway, allowing resources with appropriate public addressing to communicate with the internet.**

### Q6. What is a private subnet?

> **A private subnet does not have a direct route to an Internet Gateway for internet access. Private resources can use a NAT Gateway for outbound internet connectivity when configured appropriately.**

### Q7. What is a route table?

> **A route table contains routing rules that determine where network traffic should be sent.**

### Q8. What is a Security Group?

> **A Security Group is a stateful virtual firewall associated with resources such as EC2 network interfaces that controls allowed inbound and outbound traffic.**

### Q9. What is NACL?

> **A Network ACL is a stateless network access control mechanism associated with a subnet that controls inbound and outbound traffic using allow and deny rules.**

### Q10. What is NAT Gateway?

> **A NAT Gateway allows resources in private subnets to initiate outbound connections to the internet without requiring those resources to have public IP addresses.**

### Q11. What are VPC Flow Logs?

> **VPC Flow Logs capture information about network traffic to and from network interfaces and help with troubleshooting, monitoring, and security analysis.**

### Q12. Why use multiple Availability Zones?

> **To improve application availability and resilience by distributing resources across separate Availability Zones.**

---

# 47. 🧠 Public vs Private Subnet — Quick Revision

```text
                  VPC
                   |
           -------------------
           |                 |
           ↓                 ↓
      PUBLIC SUBNET      PRIVATE SUBNET
           |                 |
           ↓                 ↓
    Load Balancer          EC2
           |                 |
           |              NAT Gateway
           |                 |
           ↓                 ↓
        Internet          Internet
```

The key thing I remember:

> **The private subnet does not directly connect to the Internet Gateway for internet access.**

---

# 48. 🚨 Important Things I Should Not Get Wrong

### ❌ VPC is NOT a physical data center

A VPC is:

> **A logical network boundary in AWS.**

---

### ❌ Public subnet does NOT mean anyone can enter

A public subnet simply has a route to an Internet Gateway.

Security Groups, NACLs, application configuration, and public addressing still determine whether traffic can actually reach a resource.

---

### ❌ NAT Gateway does NOT make private EC2 publicly accessible

NAT Gateway is primarily used for:

> **Outbound connections initiated from private resources.**

---

### ❌ Security Group and NACL are NOT the same

```text
Security Group → Resource level + Stateful
NACL            → Subnet level + Stateless
```

---

# 🔥 DAY 4 — COMPLETE REVISION

## VPC

```text
VPC
 ↓
Virtual Private Cloud
 ↓
My logical AWS network
```

## IP Address Range

```text
VPC
 ↓
CIDR
 ↓
Example: 172.16.0.0/16
```

## Subnets

```text
VPC
 ↓
Subnet A
Subnet B
Subnet C
```

## Public Subnet

```text
Subnet
 ↓
Route to Internet Gateway
 ↓
Internet connectivity possible
```

## Private Subnet

```text
Subnet
 ↓
No direct Internet Gateway route
 ↓
Private resources
```

## Internet Gateway

```text
VPC ↔ Internet
```

## Route Table

```text
Traffic
 ↓
Route Table
 ↓
Where should it go?
```

## Load Balancer

```text
Internet
 ↓
Load Balancer
 ↓
Target Group
 ↓
Backend EC2
```

## Security Group

```text
Traffic
 ↓
Security Group
 ↓
Allow / Block
```

## NACL

```text
Subnet
 ↓
NACL
 ↓
Allow / Deny
```

## NAT Gateway

```text
Private EC2
 ↓
NAT Gateway
 ↓
Internet Gateway
 ↓
Internet
```

## VPC Flow Logs

```text
Network Traffic
 ↓
Flow Logs
 ↓
Traffic visibility / troubleshooting
```

---

# 🏆 FINAL — WHAT I NEED TO UNDERSTAND

I don't want to memorize VPC as 10 separate components.

I understand it as one story:

> **AWS provides infrastructure in different Regions. Inside a Region, I create a VPC, which gives my project a logically isolated network. I define an IP address range for the VPC and divide that range into smaller subnets. Some subnets can be public and some private. An Internet Gateway provides internet connectivity for appropriately configured public resources. Route Tables determine where traffic should go. A public-facing Load Balancer can receive traffic from users and forward it to backend applications running in private subnets. Security Groups control traffic at the resource level, while NACLs provide stateless traffic control at the subnet level. If a private EC2 instance needs outbound internet access, it can use a NAT Gateway located in a public subnet. Finally, VPC Flow Logs provide visibility into network traffic for troubleshooting and security analysis.**

## 🌍 Flow 1 — User → Application

```text
Internet
   ↓
Internet Gateway
   ↓
Public Subnet
   ↓
Load Balancer
   ↓
Private Subnet
   ↓
Security Group
   ↓
EC2
   ↓
Application
```

## 🖥️ Flow 2 — Private EC2 → Internet

```text
EC2
   ↓
Private Subnet
   ↓
Route Table
   ↓
NAT Gateway
   ↓
Internet Gateway
   ↓
Internet
```

### 🔥 My Day 4 takeaway

> **VPC = My AWS network**
>
> **Subnet = Smaller network inside VPC**
>
> **IGW = Internet path**
>
> **Route Table = Decides where traffic goes**
>
> **Security Group = Resource-level security**
>
> **NACL = Subnet-level security**
>
> **NAT Gateway = Private resources → outbound internet**
>
> **Load Balancer = Distributes incoming traffic**
>
> **VPC Flow Logs = Traffic visibility**

If I can **draw these two traffic flows and explain why each component exists**, then I've understood the core of Day 4 VPC.
