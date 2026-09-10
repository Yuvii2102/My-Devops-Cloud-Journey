# 📚 Day 1 — Networking Fundamentals

Today I started learning **Networking Fundamentals** as part of my **Cloud Support Associate preparation**.

The main thing I understood today is that networking is not just about memorizing terms. I need to understand **how everything connects together and how I can troubleshoot when something goes wrong.**

---

# 🌐 What I Learned Today

## 1. IP Address

The first thing I learned was about an **IP address**.

I understood it as:

> **IP address = address of a device on a network.**

For example:

```text
Server
   ↓
192.168.1.10
```

I can think of an IP address like a **house address**.

If I want to send something to a particular house, I need to know its address.

In networking, the IP address helps identify where the device can be reached.

---

## 2. MAC Address

Next, I learned about the **MAC address**.

I understood it as:

> **MAC address = identifies a network interface on the local network.**

Example:

```text
00:1A:2B:3C:4D:5E
```

One thing I connected from this was:

```text
IP
 ↓
ARP
 ↓
MAC
 ↓
Switch
```

So, when communication happens on the local network, the IP address can be associated with a MAC address using ARP.

The simple way I remember it is:

```text
IP  → Where?
MAC → Which local network interface?
```

---

## 3. Port

Then I learned about **ports**.

I understood:

> **Port = identifies a particular service on a server.**

The easiest way for me to remember this is:

```text
IP   = Building
Port = Door
```

A server can have different services running on different ports.

The important ports I learned today are:

```text
SSH   → 22
HTTP  → 80
HTTPS → 443
```

For example:

```text
10.0.1.25:443
```

means I am trying to connect to the HTTPS service on that server.

---

## 4. Protocol

A **protocol** is basically a set of rules that computers use to communicate.

I can think of it like a language or communication rules.

The protocols I learned today are:

```text
HTTP
HTTPS
TCP
UDP
DNS
DHCP
SSH
```

Each protocol has its own purpose.

---

# 🌐 Web and Communication Protocols

## 5. HTTP

I learned that:

> **HTTP = communication used by websites.**

HTTP normally uses:

```text
HTTP → Port 80
```

The basic communication looks like:

```text
Browser
   ↓
HTTP Request
   ↓
Web Server
   ↓
HTTP Response
   ↓
Browser
```

So I remember:

> **HTTP = website communication**

One important thing I learned is that HTTP itself doesn't provide encryption.

---

## 6. HTTPS

Then I learned about **HTTPS**.

I understood it as:

> **HTTPS = HTTP + TLS protection.**

HTTPS normally uses:

```text
HTTPS → Port 443
```

The basic idea is:

```text
HTTP
  +
TLS
  ↓
HTTPS
```

So HTTPS gives me web communication with TLS protection.

I remember:

```text
HTTP
→ Website communication

HTTPS
→ Website communication + TLS protection
```

---

## 7. TLS

I also learned about **TLS**.

I understood it as:

> **TLS protects communication between the client and server.**

I can think about it like this:

```text
Client
  │
  │ 🔒 Protected communication
  │
  ↓
Server
```

The important idea for me is that TLS protects the data while it is travelling between the client and server.

---

## 8. Certificate

Then I learned about **certificates**.

I understood:

> **Certificate = digital ID for a website.**

Certificates are used with **HTTPS/TLS**.

When using HTTPS, the server presents a certificate and the browser checks it.

Things that can cause problems include:

```text
Wrong certificate
       ↓
HTTPS problem

Expired certificate
       ↓
HTTPS problem
       ↓
Browser warning
```

So the simple way I remember it is:

> **Certificate = website's digital ID**

---

# 🌍 DNS and Network Configuration

## 9. DNS

Next, I learned about **DNS**.

I understood:

> **DNS = converts a domain name into an IP address.**

I can think of DNS like a **phonebook**.

For example:

```text
example.com
     ↓
    DNS
     ↓
IP address
```

Instead of remembering an IP address, I can use a domain name.

### Important troubleshooting scenario

If:

```text
IP works ✓
Domain doesn't work ✗
```

then one of the first things I should think about is:

```text
DNS
```

I can check DNS using commands such as:

```bash
nslookup example.com
```

or:

```bash
dig example.com
```

The main question I am asking is:

> **"Does this domain name resolve to the correct IP address?"**

---

## 10. DHCP

I also learned about **DHCP**.

I understood:

> **DHCP automatically gives a device network information.**

For example, DHCP can provide:

```text
IP address
Gateway
DNS
```

So when I connect my laptop to Wi-Fi, I normally don't have to manually enter all this network information.

### DHCP DORA

I learned the basic DHCP process called **DORA**:

```text
D → Discover
O → Offer
R → Request
A → Acknowledge
```

So:

```text
Discover
    ↓
Offer
    ↓
Request
    ↓
Acknowledge
```

---

# 🔐 Remote Access

## 11. TCP

Then I learned about **TCP**.

I understood:

> **TCP provides a reliable connection between devices.**

TCP provides:

* Reliable delivery
* Ordered delivery
* Connection-oriented communication
* Ports

One important thing I learned was the **TCP 3-way handshake**.

```text
Client → SYN
Server → SYN-ACK
Client → ACK
```

Visually:

```text
Client                    Server
  │                         │
  │ ─────── SYN ─────────→  │
  │                         │
  │ ←──── SYN-ACK ───────── │
  │                         │
  │ ─────── ACK ─────────→  │
  │                         │
  │      Connection         │
  │       established       │
```

After this, data transfer can begin.

---

## 12. UDP

I also learned about **UDP**.

I understood:

> **UDP is a simpler, connectionless way to send data.**

Unlike TCP, UDP does not provide TCP's built-in reliability and ordering.

One common example we discussed was **DNS**.

So I remember:

```text
TCP
→ Reliable and connection-oriented

UDP
→ Connectionless and simpler
```

---

# 📦 Network Data

## 13. Packet

Then I learned about a **packet**.

I understood:

> **Packet = a small piece of data sent through a network.**

Instead of thinking about a huge amount of data travelling as one big piece, I can think about it as smaller pieces being sent through the network.

For troubleshooting, I learned to ask:

```text
Is the packet leaving?
        ↓
Is it taking the correct route?
        ↓
Is something blocking it?
        ↓
Is it reaching the server?
```

This helps me think about the actual path the traffic is taking.

---

# ☁️ AWS Networking Concepts

After learning the basic networking concepts, I started connecting them to **AWS**.

---

# 14. Subnet

I learned that:

> **Subnet = smaller network inside a bigger network.**

I can visualize it like:

```text
VPC
 │
 ├── Subnet A
 │
 └── Subnet B
```

A larger network can be divided into smaller networks called subnets.

For example:

```text
10.0.0.0/16
      ↓
 ┌────┼────┐
 ↓    ↓    ↓
.1   .2   .3
```

The important idea I want to remember is:

> **Subnet = smaller section of a bigger network.**

---

# 15. Route

I learned that:

> **Route = tells network traffic where to go.**

I think of a route as a **direction**.

For example:

```text
Source
  ↓
Route
  ↓
Destination
```

The route helps determine which direction the traffic should take.

So:

> **Route = direction/path**

---

# 16. Route Table

Then I learned about the **route table**.

I understood:

> **Route table = contains the rules that tell traffic where to go.**

The easiest way for me to remember this is:

> **Route table = Google Maps for network traffic**

For example:

```text
Destination        Target
10.0.0.0/16        local
0.0.0.0/0          Internet Gateway
```

The route table helps decide where packets should be sent.

---

# 17. Gateway

I learned that:

> **Gateway = path from one network to another.**

I think of a gateway as an **exit door**.

For example:

```text
EC2
 ↓
Gateway
 ↓
Internet
```

The idea is:

> If the destination is outside my local network, I need a path to get there.

So:

```text
Gateway = Exit door
```

---

# 18. Router

Then I learned about a **router**.

I understood:

> **Router = connects different networks and helps traffic find its way.**

I think of a router as a **road junction**.

```text
Network A
    │
    ↓
  Router
    ↓
Network B
```

The router helps traffic move between different networks.

So I remember:

> **Router = road junction between networks**

---

# 19. Security Group

This is one of the AWS concepts I need to remember properly.

I learned:

> **Security Group = AWS virtual firewall for resources such as EC2.**

Security Groups contain rules that control traffic.

For example:

```text
Allow TCP 22
```

This means SSH traffic on **port 22** is allowed from the specified source.

I can think of it as:

```text
Internet
   ↓
Security Group
   ↓
EC2
```

If the required traffic is not allowed, the connection may fail.

For example, if SSH isn't working, I need to think about:

```text
SSH
 ↓
TCP
 ↓
Port 22
 ↓
Security Group
```

---

# 20. Network ACL

Then I learned about **Network ACL**, or **NACL**.

I understood:

> **Network ACL = rules that allow or block traffic for a subnet.**

The easiest analogy for me is:

> **NACL = security gate around a whole area/subnet**

I visualize it like:

```text
          NACL
    ┌───────────────┐
    │    Subnet     │
    │               │
    │  EC2   EC2    │
    │               │
    └───────────────┘
```

The important difference I learned is:

```text
Security Group
→ Resource level

NACL
→ Subnet level
```

---

# 21. Firewall

I learned that:

> **Firewall = allows or blocks network traffic based on rules.**

The basic idea is:

```text
ALLOW ✓
BLOCK ✗
```

For example:

```text
Internet
   ↓
Firewall
   ↓
Server
```

The firewall checks the traffic against its rules and either allows or blocks it.

---

# 🖥️ Server and Troubleshooting Concepts

## 22. Service

I learned that:

> **Service = a program running in the background that provides a function.**

Examples:

```text
SSH service
Web server service
Database service
```

For example, if SSH isn't working, I need to think:

```text
Is the SSH service running?
        ↓
Is it listening on port 22?
```

So:

> **Service = background program providing a function**

---

## 23. Logs

I learned that:

> **Logs = records of what happened on the server/application.**

I think of logs as:

> **The server's history**

For example:

```text
Database connection failed
Permission denied
Service stopped
```

If something was working before and suddenly stopped, logs can give me evidence about what happened.

Instead of guessing:

```text
❌ "Maybe the application is broken."
```

I should check the logs:

```text
✓ Database connection failed
```

Now I have evidence.

So my mindset is:

> **Don't guess. Check the evidence.**

---

# 🧠 24. OSI Model

The OSI model was one of the biggest topics I learned today.

I learned that **OSI = Open Systems Interconnection**.

It gives us **7 layers** that help us understand and troubleshoot network communication.

The 7 layers are:

```text
7️⃣ Application
6️⃣ Presentation
5️⃣ Session
4️⃣ Transport
3️⃣ Network
2️⃣ Data Link
1️⃣ Physical
```

I don't want to memorize these just for the sake of memorizing them.

The main purpose is:

> **OSI gives me a way to break networking into different layers so I can understand and troubleshoot problems.**

---

# 🔢 The 7 OSI Layers

## 7️⃣ Application

This is the layer closest to the application/user.

Examples:

```text
HTTP
HTTPS
DNS
SSH
```

I remember:

> **L7 → Application → HTTP, HTTPS, DNS, SSH**

---

## 6️⃣ Presentation

This layer is related to how data is represented.

I remember it mainly as:

```text
L6 → Data format / representation
```

It can involve things such as:

* Data formatting
* Encoding
* Encryption-related processing

I don't need to over-focus on this layer right now.

---

## 5️⃣ Session

This layer deals with communication sessions.

I think of it as:

```text
Start session
    ↓
Manage session
    ↓
End session
```

I remember:

> **L5 → Session / conversation**

Again, I don't need to over-focus on this one right now.

---

## 4️⃣ Transport ⭐

This is very important for Cloud Support.

The main protocols I learned here are:

```text
TCP
UDP
```

Ports are also associated with this layer.

Examples:

```text
HTTPS → TCP → 443
SSH   → TCP → 22
```

I remember:

> **L4 → TCP / UDP / Ports**

---

## 3️⃣ Network ⭐

This is also very important.

The main things I associate with Layer 3 are:

```text
IP
Routing
```

For example:

```text
EC2
 ↓
IP
 ↓
Route
 ↓
Destination
```

I remember:

> **L3 → IP + Routing**

---

## 2️⃣ Data Link ⭐

This is about communication on the local network.

The important things I associate with Layer 2 are:

```text
MAC
Ethernet
Switch
```

For example:

```text
PC A
 ↓
Switch
 ↓
PC B
```

I remember:

> **L2 → MAC + Switch + Local Network**

---

## 1️⃣ Physical

This is the actual physical connection.

Examples:

```text
Cable
Fiber
Wi-Fi / Radio
```

For example:

```text
Laptop
  ↓
Wi-Fi
  ↓
Router
```

or:

```text
Computer
   ↓
Ethernet Cable
   ↓
Switch
```

I remember:

> **L1 → Cable / Wi-Fi / Physical connection**

---

# 🧠 My Easy OSI Reminder

This is how I want to remember the layers:

```text
7️⃣ Application  → HTTP, HTTPS, DNS, SSH
6️⃣ Presentation → Data format
5️⃣ Session      → Session
4️⃣ Transport    → TCP, UDP, Ports
3️⃣ Network      → IP, Routing
2️⃣ Data Link    → MAC, Switch
1️⃣ Physical     → Cable, Wi-Fi
```

For Cloud Support, the layers I especially want to focus on are:

```text
L7 → Application
L4 → Transport
L3 → Network
L2 → Data Link
```

---

# 🔥 25. Most Important Thing I Learned Today

Honestly, the most important thing I learned today isn't a networking command or a definition.

It is the **Cloud Support mindset**.

If a customer tells me:

> **"My website isn't working."**

I should not randomly restart the server.

I should troubleshoot step by step.

```text
What exactly is failing?
        ↓
DNS?
        ↓
IP?
        ↓
Can I reach it?
        ↓
Route?
        ↓
Gateway?
        ↓
Port?
        ↓
Security Group?
        ↓
Firewall?
        ↓
Application?
        ↓
Logs?
        ↓
Find the problem
        ↓
Fix it
        ↓
Test again
```

---

# 🧠 My Golden Rules

## 1. Don't guess

I should use evidence instead of assumptions.

```text
❌ "I think the firewall is blocking it."

✓ "I tested the connection and found that traffic is being blocked before reaching the application."
```

---

## 2. Check one thing at a time

I shouldn't randomly change multiple things.

Instead:

```text
DNS
 ↓
IP
 ↓
Route
 ↓
Port
 ↓
Firewall
 ↓
Application
 ↓
Logs
```

This makes it easier to understand what actually caused the problem.

---

## 3. If something is working, move to the next thing

For example:

```text
DNS ✓
```

Then I don't keep troubleshooting DNS.

I move forward:

```text
IP
 ↓
Connectivity
 ↓
Route
 ↓
Port
```

---

## 4. Use evidence to find the problem

My goal should be:

```text
Problem
   ↓
Evidence
   ↓
Root Cause
   ↓
Fix
   ↓
Verify
```

Not:

```text
Problem
   ↓
Guess
   ↓
Random change
```

---

# 🎯 Day 1 — Everything in One Picture

This is the overall picture I have in my head after today's learning:

```text
                         CLOUD SUPPORT
                               │
                         NETWORKING
                               │
          ┌────────────────────┼────────────────────┐
          ↓                    ↓                    ↓
        Basics                AWS                  OSI
          │                    │                    │
     IP Address             Subnet                  L7
     MAC Address             Route                  L6
     Port                    Route Table             L5
     Protocol                Gateway                 L4
     Packet                  Security Group          L3
     HTTP                    NACL                    L2
     HTTPS                   Firewall                L1
     TCP
     UDP
     DNS
     DHCP
     SSH
     Logs
     Service
     Certificate
     TLS
```

---

# 🧩 My Complete Networking Picture

If I put everything together, I can think of network communication like this:

```text
                    Client
                       │
                       ↓
                     DNS
                       │
                       ↓
                  IP Address
                       │
                       ↓
                    Route
                       │
                       ↓
                   Gateway
                       │
                       ↓
                Firewall / NACL
                       │
                       ↓
                Security Group
                       │
                       ↓
                     Port
                       │
                       ↓
                    Service
                       │
                       ↓
                  Application
                       │
                       ↓
                HTTP / HTTPS
                       │
                       ↓
                  TCP / UDP
                       │
                       ↓
                  Destination
```

And when something breaks, I start asking questions instead of guessing:

```text
                 CUSTOMER PROBLEM
                         │
                         ↓
              What exactly failed?
                         │
                         ↓
                       DNS?
                         │
                         ↓
                        IP?
                         │
                         ↓
                 Can I reach it?
                         │
                         ↓
                       Route?
                         │
                         ↓
                     Gateway?
                         │
                         ↓
                       Port?
                         │
                         ↓
             Security Group / Firewall?
                         │
                         ↓
                    Application?
                         │
                         ↓
                       Logs?
                         │
                         ↓
                    ROOT CAUSE
                         │
                         ↓
                        FIX
                         │
                         ↓
                      VERIFY
```

---

# 💪 Final Takeaway From Day 1

Today I learned that networking is basically about:

> **How data moves from one device to another and what can stop that communication.**

I learned the basic building blocks:

```text
IP
MAC
Port
Protocol
Packet
DNS
DHCP
SSH
HTTP
HTTPS
TCP
UDP
```

Then I connected them with AWS concepts:

```text
Subnet
Route
Route Table
Gateway
Security Group
NACL
Firewall
```

And I learned how the **OSI model** helps me break networking into layers:

```text
L7 → Application
L6 → Presentation
L5 → Session
L4 → Transport
L3 → Network
L2 → Data Link
L1 → Physical
```

Most importantly, I learned the **Cloud Support mindset**:

> **Don't guess. Troubleshoot step by step, use evidence, find the root cause, fix it, and verify the result.**

That is what I want to carry forward from **Day 1 of my Cloud Support Associate preparation.** 💪
