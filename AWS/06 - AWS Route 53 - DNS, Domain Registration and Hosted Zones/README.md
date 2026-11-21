
# Day 6 : AWS Route 53 - DNS, Domain Registration and Hosted Zones

## 1. Introduction

In the previous classes, I learned about VPC, Subnets, Internet Gateway, Route Tables, Security Groups and NACLs.

I also understood how users send requests to applications hosted on AWS and how traffic reaches those applications.

In Day 6, my teacher Abhishek Veeramalla introduced an important AWS service called **Amazon Route 53**.

Route 53 provides DNS (Domain Name System) services in AWS.

In this class, I learned:

1. What is DNS?
2. Why do we need DNS?
3. What is Amazon Route 53?
4. How domain names are mapped to IP addresses.
5. What is Domain Registration?
6. What are Hosted Zones?
7. What are DNS Records?
8. What are Health Checks?

Let's understand each concept step by step.

---

## 2. What is DNS?

DNS stands for **Domain Name System**.

In simple words, DNS converts a domain name into an IP address.

Let's understand with an example.

Every day, we use websites like:

- amazon.com
- flipkart.com
- google.com
- instagram.com

When we access these websites, we normally type their domain names instead of their IP addresses.

But computers communicate with each other using IP addresses.

For example, imagine a website has an IP address:

```text
3.6.10.171
```

Instead of remembering this IP address, we can simply use:

```text
example.com
```

But how does the browser know which IP address belongs to example.com?

This is where DNS comes into the picture.

DNS finds the IP address associated with a domain name.

### Simple Example

Imagine I want to access:

```text
www.amazon.com
```

The process is:

1. I enter www.amazon.com in my browser.
2. The browser needs the IP address associated with this domain.
3. A DNS resolver looks for the DNS information.
4. DNS returns the required IP address.
5. The browser connects to the destination using that IP address.
6. The website is displayed.

**What I understood:** DNS works like a phonebook. We remember names, and DNS helps us find the corresponding IP addresses.

---

## 3. Why Do We Need DNS?

My teacher explained two important reasons why we use domain names instead of directly using IP addresses.

### Reason 1: Domain Names Are Easy to Remember

Imagine a company wants users to access its application.

It can share an IP address like:

```text
3.6.10.171
```

But remembering IP addresses for every application is difficult.

Instead, it is much easier to share a domain name like:

```text
amazon.com
```

This makes accessing websites simple for users.

### Reason 2: IP Addresses Can Change

IP addresses are not always permanent.

Depending on the infrastructure and configuration, an application or server can receive a different IP address.

For example:

- An EC2 instance can receive a new public IP after being stopped and started.
- A server's network configuration can change.
- An application can move to another server.

If users always depend on IP addresses, we may need to share the new IP address whenever it changes.

But with DNS, we can update the DNS record to point the domain name to the new destination.

Users can continue using the same domain name.

**What I understood:** Domain names are easier to remember and help users access applications even when the underlying IP address changes, provided the DNS records are updated correctly.

---

## 4. What is Amazon Route 53?

Amazon Route 53 is an AWS service that provides DNS (Domain Name System) services.

In simple words, Route 53 helps us manage domain names and DNS records.

My teacher explained it using other AWS services:

- EC2 provides compute services.
- EKS provides managed Kubernetes services.
- Route 53 provides DNS services.

Imagine I have deployed an application on AWS.

I have created a VPC, launched EC2 instances and configured a Load Balancer.

AWS provides the Load Balancer with a DNS name.

Now I want users to access my application using my own domain name.

For example:

```text
www.myapplication.com
```

Instead of sharing the Load Balancer's DNS name, I can use Route 53 to connect my domain name to the Load Balancer.

When a user accesses my domain, DNS resolves the name to the appropriate destination.

### Why Do We Use Route 53?

- To manage domain names.
- To create and manage DNS records.
- To connect domain names to AWS resources.
- To perform health checks.
- To manage DNS routing.

---

## 5. How Does Route 53 Work?

Let's understand this using the VPC architecture that I learned in previous classes.

Imagine I have created:

- A VPC.
- A public subnet.
- A private subnet.
- A Load Balancer.
- An application inside the private subnet.

The Load Balancer receives requests from users and forwards them to the application.

Now I want users to access my application using:

```text
www.myapplication.com
```

Instead of sharing the Load Balancer's IP address or DNS name, I can configure Route 53.

### Request Flow

1. A user enters www.myapplication.com in the browser.
2. The browser needs to find the destination IP address.
3. A DNS resolver requests the DNS information.
4. Route 53 checks the DNS records in the hosted zone.
5. Route 53 returns the appropriate DNS response.
6. The browser connects to the destination.
7. The Load Balancer receives the request.
8. The Load Balancer forwards the request to the application.

### Simple Architecture

```text
          USER / BROWSER
                 |
                 |
                 v
       www.myapplication.com
                 |
                 v
          DNS RESOLUTION
                 |
                 v
           AMAZON ROUTE 53
                 |
                 v
            HOSTED ZONE
                 |
                 v
          DNS RECORDS
                 |
                 v
          LOAD BALANCER
                 |
                 v
          PRIVATE SUBNET
                 |
                 v
            APPLICATION
```

**What I understood:** Route 53 helps convert our domain name into the appropriate destination so users can access our applications using easy-to-remember names.

Note: DNS resolution happens before the browser connects to the application. Route 53 does not act as a proxy for the actual application traffic.

---

## 6. Important Components of Route 53

My teacher explained three important features of Route 53.

1. Domain Registration
2. Hosted Zones
3. Health Checks

Let's understand them one by one.

---

## 7. What is Domain Registration?

Domain Registration means purchasing a domain name.

For example, imagine I have developed a website and want users to access it using:

```text
myapplication.com
```

First, I need to register or purchase that domain name.

We can purchase domain names from domain providers such as:

- GoDaddy
- Namecheap
- AWS Route 53

My teacher explained that AWS also allows us to purchase domain names through Route 53.

### Two Ways to Register a Domain

**Option 1: Purchase a Domain Through AWS**

I can directly purchase a domain using Route 53.

AWS manages the domain registration through its domain registration service.

**Option 2: Purchase a Domain From Another Provider**

Suppose I already purchased a domain from GoDaddy.

I can still use AWS Route 53 to manage its DNS records.

I just need to connect the domain to Route 53 by updating the domain's nameserver configuration at the domain registrar.

**What I understood:** Domain Registration is simply the process of purchasing a domain name that users can use to access my application.

---

## 8. What is a Hosted Zone?

A Hosted Zone is a container in Route 53 where we manage the DNS records for a domain.

Let's understand with an example.

Imagine I purchased a domain:

```text
myapplication.com
```

Now I want to connect it to my AWS Load Balancer.

For this, I create a Hosted Zone in Route 53.

Inside the Hosted Zone, I create DNS records that tell DNS where my domain should point.

For example:

| Domain Name | Destination |
|---|---|
| myapplication.com | Application destination |
| www.myapplication.com | Application destination |
| api.myapplication.com | API destination |

These records help Route 53 provide the correct DNS response when users access the domain.

### Types of Hosted Zones

There are two important types of Hosted Zones.

### 1. Public Hosted Zone

A Public Hosted Zone is used to manage DNS records that should be accessible through the public internet.

Example:

```text
www.myapplication.com
```

If I want users from anywhere on the internet to access my website using my domain name, I can use a Public Hosted Zone.

### 2. Private Hosted Zone

A Private Hosted Zone is used to manage DNS records for resources inside one or more associated VPCs.

It is mainly used for internal applications and services.

Example:

```text
database.internal
```

An internal application inside the VPC can use this name to communicate with another internal resource.

The DNS records in a Private Hosted Zone are available only through the associated VPCs and supported private DNS resolution.

### Difference Between Public and Private Hosted Zones

| Feature | Public Hosted Zone | Private Hosted Zone |
|---|---|---|
| Purpose | Public websites and applications | Internal applications |
| Accessibility | Public DNS | Associated VPCs |
| Example | www.example.com | database.internal |
| Usage | Internet-facing applications | Internal AWS resources |

**What I understood:** Hosted Zones are where we manage DNS records. Public Hosted Zones are used for internet-facing domains, whereas Private Hosted Zones are used for internal resources.

---

## 9. What are DNS Records?

DNS Records contain information about a domain name and its destination.

In simple words, DNS records tell DNS what to return when someone searches for a domain name.

For example:

```text
www.myapplication.com
```

I can create a DNS record that points this domain to my application.

My teacher explained the concept of DNS records at a high level. We will explore their different types during practical implementation.

A few commonly used DNS record types are:

| Record Type | Purpose |
|---|---|
| A | Maps a domain name to an IPv4 address |
| AAAA | Maps a domain name to an IPv6 address |
| CNAME | Maps a domain name to another domain name |
| MX | Specifies mail servers for a domain |
| TXT | Stores text information, often used for verification |
| NS | Specifies the authoritative name servers for a domain |

### Example of an A Record

Imagine my application is hosted on an EC2 instance with a public IP address.

```text
Domain: www.myapplication.com
Type: A
Value: 3.6.10.171
```

When a user accesses www.myapplication.com, DNS can return the configured IPv4 address.

### Example of a CNAME Record

Imagine I want:

```text
www.myapplication.com
```

to point to another domain name.

I can use a CNAME record to point one domain name to another domain name.

**What I understood:** DNS records contain the information required to resolve domain names to their destinations.

---

## 10. What are Health Checks in Route 53?

Another important feature of Route 53 is Health Checks.

Health Checks help us monitor whether our applications or servers are working properly.

Let's understand with an example.

Imagine I have deployed my application on two different servers in two Availability Zones.

```text
Server 1 - Availability Zone A
Server 2 - Availability Zone B
```

Now I want to make sure that both servers are working properly.

Route 53 Health Checks can periodically send requests to the configured endpoint and check whether it is responding successfully.

For example:

- Check whether Server 1 is healthy.
- Check whether Server 2 is healthy.
- Identify when a server becomes unhealthy.

If one endpoint becomes unhealthy, Route 53 can use this health information with suitable routing policies to stop directing new DNS responses to that unhealthy endpoint.

### Simple Example

Imagine I have two application servers.

| Server | Health Status |
|---|---|
| Server 1 | Healthy |
| Server 2 | Unhealthy |

If I configure Route 53 with health checks and an appropriate failover routing policy, it can direct users to the healthy server instead of the unhealthy one.

### Why Are Health Checks Important?

- They help monitor application availability.
- They help identify unhealthy endpoints.
- They support DNS failover configurations.
- They improve application availability when configured properly.

**What I understood:** Health Checks help Route 53 monitor the health of our applications and support routing decisions based on their health status.

---

## 11. Important Difference: Domain Registration vs Hosted Zone

This is an important concept to understand.

| Domain Registration | Hosted Zone |
|---|---|
| Used to purchase a domain name | Used to manage DNS records |
| Gives us ownership or registration rights to a domain | Stores DNS configuration for the domain |
| Example: Purchasing myapplication.com | Creating records for myapplication.com |
| Usually involves a registration fee | Has separate hosted-zone charges |

Even if I purchase a domain from another provider, I can still use Route 53 to manage its DNS records.

**Remember:**

- Domain Registration = Purchasing a domain.
- Hosted Zone = Managing DNS records.

---

## 12. Real-World Example: Connecting a Domain to an AWS Application

Let's understand how all these concepts work together.

Imagine I am a DevOps engineer and my company wants to make its application available using:

```text
www.mycompany.com
```

The application is already deployed on AWS.

### Step 1: Deploy the Application

I create the required AWS infrastructure:

- VPC
- Public and private subnets
- Load Balancer
- Application servers

### Step 2: Register a Domain

I purchase:

```text
mycompany.com
```

I can purchase it through AWS Route 53 or another domain registrar.

### Step 3: Create a Hosted Zone

I create a Public Hosted Zone for:

```text
mycompany.com
```

### Step 4: Configure DNS Records

I create the required DNS record to connect my domain to the AWS application.

For an AWS Load Balancer, I can use an Alias record.

### Step 5: User Accesses the Application

Now a user enters:

```text
www.mycompany.com
```

Route 53 resolves the domain using the configured DNS records.

The browser connects to the destination, and the request reaches the Load Balancer.

The Load Balancer forwards the request to the application.

Now users can access the application using my company's domain name instead of remembering an IP address or the Load Balancer's DNS name.

---

## 13. Important Interview Questions

### 1. What is DNS?

DNS stands for Domain Name System. It translates domain names into IP addresses so users can access websites using easy-to-remember names.

### 2. What is Amazon Route 53?

Amazon Route 53 is an AWS DNS service used for domain registration, DNS record management, routing and health checks.

### 3. Why do we need DNS?

DNS helps users access applications using domain names instead of remembering IP addresses.

### 4. What is a domain name?

A domain name is a human-readable name used to access a website.

Example: google.com.

### 5. What is Domain Registration?

Domain Registration is the process of purchasing or registering a domain name.

### 6. What is a Hosted Zone?

A Hosted Zone is a container in Route 53 that stores and manages DNS records for a domain.

### 7. What are the two types of Hosted Zones?

The two types are:

- Public Hosted Zone
- Private Hosted Zone

### 8. What is a Public Hosted Zone?

A Public Hosted Zone manages DNS records that can be resolved through the public internet.

### 9. What is a Private Hosted Zone?

A Private Hosted Zone manages DNS records for resources inside associated VPCs.

### 10. What are DNS Records?

DNS records contain information that helps DNS resolve domain names to their destinations.

### 11. What are Health Checks in Route 53?

Health Checks monitor the availability of configured endpoints and can be used with routing policies to direct traffic away from unhealthy endpoints.

### 12. Can I use Route 53 if I purchased my domain from GoDaddy?

Yes. I can purchase a domain from another provider and use Route 53 to manage its DNS records by configuring the required nameservers.

### 13. What is the difference between Domain Registration and Hosted Zones?

Domain Registration is used to purchase a domain name, whereas Hosted Zones are used to manage the DNS records of that domain.

### 14. What is an A Record?

An A Record maps a domain name to an IPv4 address.

### 15. What is a CNAME Record?

A CNAME record maps one domain name to another domain name.

---

## 14. What I Learned From This Class

After completing Day 6, I understood the following concepts:

1. DNS stands for Domain Name System.
2. DNS converts domain names into IP addresses.
3. Domain names are easier to remember than IP addresses.
4. IP addresses can change depending on the infrastructure.
5. Amazon Route 53 provides DNS services in AWS.
6. Route 53 helps manage domain names and DNS records.
7. Domain Registration is used to purchase domain names.
8. Hosted Zones are used to manage DNS records.
9. Public Hosted Zones are used for public applications.
10. Private Hosted Zones are used for internal applications.
11. DNS records map domain names to their destinations.
12. Route 53 Health Checks help monitor application availability.

---

## 15. Conclusion

In this class, I learned about Amazon Route 53 and how DNS works.

Before this session, I knew that we use domain names to access websites, but I did not clearly understand how those names were connected to IP addresses.

My teacher explained how DNS resolves domain names and how Amazon Route 53 provides DNS as a service.

I also learned about Domain Registration, Hosted Zones, DNS Records and Health Checks.

The most important thing I learned is that DNS makes it easier for users to access applications without remembering their IP addresses.

As a DevOps engineer, understanding Route 53 is important because we need to connect our applications to domain names and manage DNS configurations when deploying applications on AWS.

---

**Day 6 Completed: AWS Route 53 - DNS and Domain Management**

**Instructor:** Abhishek Veeramalla

**Learning:** AWS Zero to Hero Series
