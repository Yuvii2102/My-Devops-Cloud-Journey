
# Day 5 : AWS VPC - Security Groups and Network ACLs (NACLs)

## 1. Introduction

In Day 4, I learned about VPC (Virtual Private Cloud) and its different components. I understood how traffic flows inside a VPC and how different AWS components work together to deliver requests to an application.

The important components I learned were:

- VPC
- Public Subnet
- Private Subnet
- Internet Gateway
- Route Tables
- Load Balancer

In Day 5, my teacher Abhishek Veeramalla explained two important security components in AWS:

1. Security Groups
2. Network Access Control Lists (NACLs)

Both are used to control network traffic and protect our applications from unwanted access.

In this class, I learned their differences and performed practical exercises using an EC2 instance.

---

## 2. What is VPC?

VPC stands for **Virtual Private Cloud**.

In simple words, a VPC is our own virtual network inside AWS.

Whenever an organization wants to deploy applications on AWS, it can create a VPC and launch resources such as EC2 instances and databases inside it.

A VPC helps us manage:

- IP addresses
- Subnets
- Network traffic
- Internet connectivity
- Network security

### What is CIDR?

CIDR stands for Classless Inter-Domain Routing.

When creating a VPC, we need to provide an IP address range. This range is called a CIDR block.

Example:

```text
10.0.0.0/16
```

This provides 65,536 total IP addresses.

Another example:

```text
10.0.0.0/24
```

This provides 256 total IP addresses.

**What I understood:** CIDR defines the IP address range available inside our VPC or subnet.

Note: AWS reserves five IP addresses in every IPv4 subnet, so not all addresses are available for resources.

---

## 3. Understanding Public and Private Subnets

A subnet is a smaller network created inside a VPC.

We can divide a VPC into multiple subnets depending on our requirements.

### Public Subnet

A public subnet has a route to an Internet Gateway.

Resources inside a public subnet can communicate with the internet if their other network configurations allow it.

Examples:

- Load Balancers
- Bastion Hosts
- Public-facing resources

### Private Subnet

A private subnet does not have a direct route to the internet through an Internet Gateway.

It is generally used to keep internal resources away from direct internet access.

Examples:

- Application Servers
- Database Servers
- Internal Applications

### How Does Traffic Flow Inside a VPC?

Imagine I have deployed an application on AWS and a user wants to access it.

The request generally follows this path:

1. The user sends a request from the internet.
2. The request reaches the Internet Gateway.
3. It enters the public subnet.
4. It reaches the Load Balancer.
5. The Load Balancer forwards the request to the application in the private subnet.
6. The application processes the request and sends a response.

This architecture allows users to access applications without directly exposing internal application servers.

---

## 4. AWS Shared Responsibility Model

My teacher explained an important concept called the **Shared Responsibility Model**.

In AWS, security is the responsibility of both AWS and the customer.

This means AWS takes care of some security responsibilities, and we must take care of the remaining responsibilities.

### AWS Responsibility

AWS is responsible for the security OF the cloud.

Examples:

- Physical security of data centers.
- Hardware security.
- Networking infrastructure.
- Underlying cloud infrastructure.

### Customer Responsibility

We are responsible for security IN the cloud.

Examples:

- Configuring Security Groups.
- Configuring NACLs.
- Securing EC2 instances.
- Managing permissions.
- Protecting application data.

**What I understood:** AWS provides security features, but we must configure them properly to protect our applications and infrastructure.

This is why DevOps engineers play an important role in AWS security.

---

## 5. What is a Security Group?

A Security Group is like a firewall for an EC2 instance.

It controls which traffic is allowed to enter and leave an EC2 instance.

Let's understand with an example.

Imagine I have launched an EC2 instance and installed Jenkins on it.

Jenkins is running on port 8080.

Even though Jenkins is running successfully, I cannot access it from my browser unless I allow port 8080 in the Security Group.

This is exactly what a Security Group does.

It controls which connections are allowed to reach my EC2 instance.

### Inbound Traffic

Inbound traffic means traffic coming into our EC2 instance.

Examples:

- A user accessing our website.
- A developer connecting to EC2 using SSH.
- A user accessing Jenkins through a browser.

Commonly used ports:

| Port | Purpose |
|---|---|
| 22 | SSH |
| 80 | HTTP |
| 443 | HTTPS |
| 8080 | Jenkins |
| 8000 | Python HTTP Server |

### Outbound Traffic

Outbound traffic means traffic going out from our EC2 instance.

Examples:

- Our application accessing Google.
- Our application calling an external API.
- Our application communicating with another service.

### Default Security Group Rules

By default, when AWS creates a Security Group:

| Traffic | Default Rule |
|---|---|
| Inbound | Deny all traffic |
| Outbound | Allow all traffic |

This means nobody can access our EC2 instance through inbound traffic unless we explicitly allow it.

However, our EC2 instance can send outgoing traffic by default.

### What is Stateful?

Security Groups are called **stateful**.

Let's understand with a simple example.

Imagine a user sends a request to my application on port 8000.

1. The Security Group allows the incoming request.
2. The application processes it.
3. The application sends a response back to the user.
4. The Security Group automatically allows the response traffic.

We don't need to create a separate rule just to allow the response.

This is called stateful behaviour.

**Remember:** Security Groups are stateful and support allow rules only.

---

## 6. What is a Network ACL (NACL)?

NACL stands for **Network Access Control List**.

In simple words, a NACL is another type of firewall in AWS.

But there is one important difference.

A Security Group works at the EC2 instance level, whereas a NACL works at the subnet level.

Let's understand with an example.

Imagine an organization has a private subnet containing 50 EC2 instances.

Each EC2 instance has its own Security Group.

Now suppose one development team accidentally allows all incoming traffic in its Security Group.

This can create a security risk.

Instead of changing the Security Group of every EC2 instance, a DevOps engineer can configure a NACL at the subnet level.

The NACL can block unwanted traffic for the entire subnet.

### Important Features of NACL

- It works at the subnet level.
- It controls inbound and outbound traffic.
- It supports both ALLOW and DENY rules.
- We can block specific ports.
- We can block specific IP addresses.
- It provides an additional layer of security.

### Default NACL

When we create a VPC, AWS automatically creates a default NACL.

By default, it allows all inbound and outbound traffic.

However, if we create a custom NACL, it denies traffic by default until we add the required rules.

### What is Stateless?

NACLs are called **stateless**.

Let's understand with an example.

Imagine a user sends a request to our application.

The NACL allows the incoming request.

But that does not automatically mean the response traffic will be allowed.

We must separately configure the required outbound rules.

This is called stateless behaviour.

**Remember:** NACLs support both ALLOW and DENY rules and are stateless.

---

## 7. Difference Between Security Groups and NACLs

This is one of the most important concepts from today's class.

| Feature | Security Group | NACL |
|---|---|---|
| Works at | EC2 instance/network interface level | Subnet level |
| Rules | Allow only | Allow and Deny |
| Behaviour | Stateful | Stateless |
| Inbound | Deny all by default | Default NACL allows all |
| Outbound | Allow all by default | Default NACL allows all |
| Rule evaluation | All applicable rules are evaluated | Rules checked in ascending order |

### Easy Way to Remember

- Security Group = EC2 instance security.
- NACL = Subnet security.
- Security Group = Only ALLOW.
- NACL = ALLOW and DENY.
- Security Group = Stateful.
- NACL = Stateless.

---

## 8. How Does NACL Rule Priority Work?

This was one of the interesting concepts my teacher demonstrated.

NACL rules are checked based on their rule numbers.

The lowest rule number gets checked first.

### Example 1: ALLOW Comes First

Imagine I configure these rules:

| Rule Number | Traffic | Action |
|---|---|---|
| 100 | All Traffic | ALLOW |
| 200 | TCP Port 8000 | DENY |
| * | All Traffic | DENY |

Now suppose a user tries to access port 8000.

What happens?

1. AWS checks rule 100 first.
2. Rule 100 allows all traffic.
3. The request matches this rule.
4. AWS stops checking the remaining rules.

Therefore, port 8000 is allowed.

Even though I created a DENY rule for port 8000, it will not work because rule 100 already allowed the traffic.

### Example 2: DENY Comes First

Now imagine I change the rules:

| Rule Number | Traffic | Action |
|---|---|---|
| 100 | TCP Port 8000 | DENY |
| 110 | All Traffic | ALLOW |
| * | All Traffic | DENY |

Now what happens?

1. AWS checks rule 100 first.
2. It sees that the request is coming through port 8000.
3. It denies the request.
4. AWS stops checking the remaining rules.

Therefore, port 8000 is blocked.

**What I understood:** NACL checks rules in ascending order and follows the first matching rule.

---

## 9. Practical: Creating a Custom VPC

After understanding the theory, my teacher demonstrated everything practically using the AWS Management Console.

The main goal was to:

- Create a custom VPC.
- Launch an EC2 instance.
- Run a Python application.
- Allow and block traffic using Security Groups.
- Allow and block traffic using NACLs.

### Step 1: Open VPC

1. Log in to the AWS Management Console.
2. Search for VPC.
3. Open the VPC service.
4. Click on Create VPC.
5. Select **VPC and more**.

Why did we select VPC and more?

Because AWS automatically creates the required networking resources for us.

It can create:

- VPC
- Public Subnets
- Private Subnets
- Route Tables
- Internet Gateway
- S3 Gateway Endpoint (if selected)

### Step 2: Configure the VPC

My teacher configured a VPC with the following example settings:

| Configuration | Value |
|---|---|
| Name | demo-vpc |
| IPv4 CIDR | 10.0.0.0/16 |
| Availability Zones | 2 |
| Public Subnets | 2 |
| Private Subnets | 2 |
| VPC Endpoint | S3 Gateway |

After providing the configuration, he clicked Create VPC.

AWS automatically created the networking resources.

### Step 3: Check Resource Map

After creating the VPC, I can open the Resource Map.

It provides a visual representation of the VPC and its resources.

I can see:

- VPC
- Subnets
- Internet Gateway
- Route Tables
- Network ACLs

This helps me understand how the resources are connected.

---

## 10. Practical: Launching an EC2 Instance

After creating the custom VPC, my teacher launched an EC2 instance inside it.

### Step 1: Launch Instance

1. Open EC2.
2. Click Launch Instance.
3. Give the instance a name.

```text
demo-instance
```

4. Select Ubuntu.
5. Select an instance type such as `t2.micro`.
6. Select or create a key pair.

### Step 2: Configure Network Settings

Under Network Settings, click Edit.

Configure the following:

| Configuration | Value |
|---|---|
| VPC | demo-vpc |
| Subnet | Public Subnet |
| Availability Zone | us-east-1a |
| Auto-assign Public IP | Enable |
| Security Group | Create new |

My teacher selected a public subnet because he wanted to demonstrate Security Groups and NACLs without adding a Load Balancer.

In real-world applications, EC2 instances are commonly placed in private subnets behind a Load Balancer.

After completing the configuration, launch the instance.

---

## 11. Practical: Connect to EC2 and Run a Python Application

Once the EC2 instance was running, my teacher connected to it using SSH.

### Step 1: Connect to EC2

Open the terminal and execute:

```bash
ssh -i AWS-login.pem ubuntu@<EC2-PUBLIC-IP>
```

Here:

- `-i` specifies the private key.
- `AWS-login.pem` is the private key file.
- `ubuntu` is the default username for Ubuntu.
- `EC2-PUBLIC-IP` is the public IP of the instance.

### Step 2: Update Packages

After connecting to EC2, update the package information.

```bash
sudo apt update
```

### Step 3: Check Python Installation

```bash
python3 --version
```

Python was already installed on the Ubuntu instance.

### Step 4: Run a Python HTTP Server

My teacher used Python's built-in HTTP server.

```bash
python3 -m http.server 8000
```

Now the HTTP server is running on port 8000.

To access the application, open:

```text
http://<EC2-PUBLIC-IP>:8000
```

But initially, the application was not accessible.

Why?

Because the Security Group was not allowing incoming traffic on port 8000.

Only SSH traffic on port 22 was allowed.

This helped me understand why Security Groups are important.

---

## 12. Practical: Allow Port 8000 in Security Group

Now my teacher opened the Security Group attached to the EC2 instance.

He checked the inbound rules.

Initially, the rule looked like this:

| Type | Port | Purpose |
|---|---|---|
| SSH | 22 | Connect to EC2 |

There was no rule for port 8000.

### Step 1: Add a New Inbound Rule

He edited the inbound rules and added:

| Configuration | Value |
|---|---|
| Type | Custom TCP |
| Port Range | 8000 |
| Source | 0.0.0.0/0 |

After saving the rule, he refreshed the browser.

This time, the application was accessible.

The browser displayed the directory listing generated by the Python HTTP server.

**Result:** HTTP 200 – Successful Response.

### What Did I Learn?

Even though the Python application was running on EC2, I could not access it until I allowed port 8000 through the Security Group.

This is how Security Groups control incoming traffic.

**Security note:** `0.0.0.0/0` allows connections from anywhere. It was used for the demonstration. In real projects, I should allow only trusted IP addresses wherever possible.

---

## 13. Practical: Block Port 8000 Using NACL

Now my teacher demonstrated something interesting.

What happens if the Security Group allows port 8000 but the NACL blocks it?

To test this, he opened the VPC service.

### Step 1: Open Network ACLs

Navigate to:

```text
AWS Console
    → VPC
        → Network ACLs
```

Select the NACL associated with the demo VPC's public subnet.

### Step 2: Check Inbound Rules

Initially, the default NACL was allowing all inbound traffic.

That means the NACL was not blocking the request.

The Security Group was the component blocking port 8000 earlier.

After allowing port 8000 in the Security Group, the application became accessible.

### Step 3: Deny Port 8000

Now my teacher edited the inbound rules of the NACL.

He added this rule:

| Configuration | Value |
|---|---|
| Rule Number | 100 |
| Type | Custom TCP |
| Port Range | 8000 |
| Source | 0.0.0.0/0 |
| Action | DENY |

After saving the changes, he tried accessing the application again.

This time, the application was not accessible.

Why?

Because the NACL was blocking traffic on port 8000.

Even though the Security Group allowed port 8000, the NACL denied the request.

**What I learned:** A Security Group cannot override a DENY rule in a NACL.

---

## 14. Practical: Understanding NACL Rule Priority

Now my teacher demonstrated why rule numbers are important.

### Scenario 1: Allow All Traffic First

He configured:

| Rule Number | Traffic | Action |
|---|---|---|
| 100 | All Traffic | ALLOW |
| 200 | TCP Port 8000 | DENY |
| * | All Traffic | DENY |

After saving the configuration, he accessed the application.

Surprisingly, the application was accessible.

Why?

Because rule 100 was checked first.

It allowed all traffic.

AWS did not check rule 200 because the request had already matched rule 100.

### Scenario 2: Deny Port 8000 First

Now he changed the configuration:

| Rule Number | Traffic | Action |
|---|---|---|
| 100 | TCP Port 8000 | DENY |
| 110 | All Traffic | ALLOW |
| * | All Traffic | DENY |

After saving the configuration, he tried accessing the application again.

This time, it was blocked.

Why?

Because rule 100 was checked first and denied port 8000.

AWS stopped checking the remaining rules.

### What Did I Learn?

The lowest rule number gets checked first.

The first matching rule decides whether the traffic should be allowed or denied.

This is very important when configuring NACLs in real-world environments.

---

## 15. How Do DevOps Engineers Use NACLs?

My teacher explained a real-world scenario.

Imagine an organization has multiple development teams.

Each team manages its own EC2 instances and Security Groups.

One development team accidentally allows all incoming traffic to its EC2 instance.

This creates a security risk.

Now, as a DevOps engineer, I can use NACLs to control traffic at the subnet level.

For example, I can:

- Block unwanted ports.
- Block specific IP addresses.
- Block IP address ranges.
- Allow only required traffic.

The biggest advantage is that a single NACL can protect multiple EC2 instances inside the associated subnet.

Instead of manually configuring the same restriction on every instance, I can apply network-level rules to the entire subnet.

---

## 16. Important Concept: Port 25

My teacher also explained port 25.

Port 25 is commonly used for SMTP (Simple Mail Transfer Protocol).

SMTP is used for sending email.

AWS restricts outbound traffic on port 25 from EC2 instances by default to help prevent spam activities.

This is an AWS-level restriction and is separate from the default outbound rules of a Security Group.

---

## 17. Complete Traffic Flow

This is the simplified traffic flow I understood from today's practical.

```text
             USER / INTERNET
                    |
                    v
              INTERNET GATEWAY
                    |
                    v
                NETWORK ACL
              (Subnet Level)
                    |
                    v
                ROUTE TABLE
                    |
                    v
               SECURITY GROUP
               (Instance Level)
                    |
                    v
                EC2 INSTANCE
                    |
                    v
             PYTHON APPLICATION
                 PORT 8000
```

The important thing is that the relevant network controls must allow the traffic before it reaches the application.

---

## 18. Important Interview Questions

### 1. What is a Security Group?

A Security Group is a virtual firewall that controls incoming and outgoing traffic for an EC2 instance's network interface.

### 2. What is a NACL?

A Network Access Control List is a firewall associated with a subnet. It controls inbound and outbound traffic.

### 3. What is the main difference between Security Groups and NACLs?

Security Groups work at the instance level and support allow rules only. NACLs work at the subnet level and support both allow and deny rules.

### 4. What is a stateful firewall?

A stateful firewall remembers connections. If an incoming request is allowed, its response traffic is automatically allowed.

### 5. What is a stateless firewall?

A stateless firewall checks incoming and outgoing traffic separately. We must configure the required rules in both directions.

### 6. Can a NACL block traffic even if the Security Group allows it?

Yes. If the NACL denies the traffic, the request will be blocked even if the Security Group allows it.

### 7. How does NACL evaluate rules?

NACL checks rules in ascending order. The first matching rule decides whether traffic is allowed or denied.

### 8. Why do we need both Security Groups and NACLs?

Security Groups protect individual instances, while NACLs provide security at the subnet level. Together, they provide multiple layers of protection.

### 9. What is inbound traffic?

Inbound traffic is traffic coming into an EC2 instance or subnet.

### 10. What is outbound traffic?

Outbound traffic is traffic going out from an EC2 instance or subnet.

### 11. What happens if I allow port 8000 in a Security Group but deny it in a NACL?

The request will be blocked by the NACL.

### 12. What is the purpose of port 25?

Port 25 is commonly used for SMTP email communication. AWS restricts outbound port 25 traffic from EC2 by default.

---

## 19. Practical Assignment

After watching the class, I can repeat these activities in my own AWS account.

- [ ] Create a custom VPC.
- [ ] Create public and private subnets.
- [ ] Check the Internet Gateway.
- [ ] Check the Route Tables.
- [ ] Launch an EC2 instance inside the public subnet.
- [ ] Connect to EC2 using SSH.
- [ ] Run a Python HTTP server on port 8000.
- [ ] Try accessing the application without allowing port 8000.
- [ ] Allow port 8000 through the Security Group.
- [ ] Access the application successfully.
- [ ] Deny port 8000 through the NACL.
- [ ] Verify that the application is no longer accessible.
- [ ] Experiment with different NACL rule numbers.
- [ ] Understand ALLOW and DENY rules.
- [ ] Check inbound and outbound NACL rules.

**Note:** Since NACLs are stateless, I should also check the outbound rules and return traffic when repeating the practical.

---

## 20. What I Learned From This Class

After completing Day 5, I understood the following:

1. VPC provides an isolated network inside AWS.
2. CIDR defines the IP address range.
3. Public and private subnets help organize AWS resources.
4. AWS follows the Shared Responsibility Model.
5. Security Groups work at the EC2 instance/network-interface level.
6. NACLs work at the subnet level.
7. Security Groups support allow rules only.
8. NACLs support both allow and deny rules.
9. Security Groups are stateful.
10. NACLs are stateless.
11. NACL rules are evaluated in ascending order.
12. NACLs can block traffic even when Security Groups allow it.

---

## 21. Conclusion

In this class, I learned how AWS controls network traffic using Security Groups and NACLs.

Before this session, I knew that both were used for security, but I did not clearly understand how they were different.

After the practical demonstration, I understood how Security Groups control traffic at the EC2 instance level and how NACLs control traffic at the subnet level.

I also learned how a running application can become inaccessible because of network security rules.

The most important thing I learned from this class is that security should not depend on just one layer. We should use multiple layers of protection to keep our applications and infrastructure secure.

---

**Day 5 Completed: AWS VPC – Security Groups and Network ACLs**

**Instructor:** Abhishek Veeramalla  
**Learning:** AWS Zero to Hero Series
