<div align="center">

# 🚀 DAY 11 — FINAL CLOUD SUPPORT TROUBLESHOOTING + INTERVIEW REVISION

</div>

## 📚 DAY 11 — WHAT I'LL COVER

1. Complete troubleshooting methodology
2. DNS troubleshooting
3. IP / reachability troubleshooting
4. Routing & gateway troubleshooting
5. Port troubleshooting
6. Security Group / NACL / Firewall
7. Server / service troubleshooting
8. Application + logs
9. End-to-end customer scenarios
10. Final networking interview revision

---

# 🟢 1. The Golden Troubleshooting Flow

When a customer tells me:

> **"My application is not working."**

I should **not immediately restart the server**.

Instead, I should break the problem down step by step.

```text
Customer Problem
      ↓
DNS
      ↓
IP
      ↓
Subnet
      ↓
Route
      ↓
Gateway
      ↓
Security
      ↓
Port
      ↓
Server
      ↓
Application
      ↓
Logs
      ↓
Root Cause
      ↓
Fix
      ↓
Verify
```

🔥 This is the **main troubleshooting flow** I need to remember.

The idea is simple:

> **Find where the failure is happening instead of randomly checking everything.**

---

# 🟢 2. Step 1 — Understand the Exact Problem

The first thing I should ask is:

> **"What exactly is failing?"**

If someone simply tells me:

> "The website is down."

I should clarify the problem.

For example:

```text
Can you resolve the domain?
Can you reach the IP?
Can you connect to the port?
Is it failing for everyone or one user?
When did it start?
```

The goal is to identify the **exact failure point**.

So before troubleshooting, I first need to understand **what exactly is not working**.

---

# 🟢 3. DNS Troubleshooting

Suppose:

```text
Domain → ❌
IP     → ✅
```

My first suspicion should be:

# DNS

I need to check whether the domain resolves correctly.

I can use:

```bash
nslookup example.com
```

or:

```bash
dig example.com
```

I can think about it like this:

```text
Domain
  ↓
DNS
  ↓
Correct IP?
```

### 🎯 Interview Answer

> **"If the IP works but the domain doesn't, I would first investigate DNS resolution and verify that the domain resolves to the correct IP."**

---

# 🟢 4. IP / Reachability Troubleshooting

Suppose:

```text
DNS → ✅
IP connectivity → ❌
```

Now I move toward networking.

I would check:

```text
IP
 ↓
Subnet
 ↓
Route
 ↓
Gateway
 ↓
Security
```

At this stage, I shouldn't waste time investigating the application yet.

I first need to find out **why the network connectivity is failing**.

---

# 🟢 5. Routing Troubleshooting

I should ask:

> **"Does a route exist to the destination?"**

Then I check the route table.

For example:

```text
Destination       Target
10.0.2.0/24       appropriate target
```

For general IPv4 traffic, I may see:

```text
0.0.0.0/0
```

which represents the **default route**.

### 🧠 I Remember It Like This

> **Route table = tells traffic where to go.**

---

# 🟢 6. Gateway Troubleshooting

If the destination is outside the local network, traffic needs an appropriate path through a **gateway / next hop**.

For example:

```text
Client
10.0.1.10
    ↓
Gateway
10.0.1.1
    ↓
Other Network
```

So I should check:

```text
Correct gateway?
Correct route?
Correct next hop?
```

The important thing for me is:

> **The gateway is the next step toward reaching another network.**

---

# 🔥 7. Port Troubleshooting

Suppose:

```text
IP → reachable ✅
Application → ❌
```

Now I should ask:

> **"Is the required port reachable?"**

Some common ports I already learned are:

```text
SSH   → 22
DNS   → 53
HTTP  → 80
HTTPS → 443
```

If an application is running on port `8080`:

```text
Server
   ↓
TCP 8080
```

I should also check whether the service is actually listening on that port.

For Linux, I can use:

```bash
ss -lntp
```

---

# 🟢 8. Security Group

If I'm troubleshooting an AWS EC2 connection, I should check the **Security Group**.

For example, if the customer wants SSH:

```text
TCP 22
```

I need to check whether the Security Group allows the required inbound traffic.

For HTTPS:

```text
TCP 443
```

For HTTP:

```text
TCP 80
```

So if a service isn't reachable, I should check whether the required traffic is allowed.

---

# 🟢 9. NACL

Next, I should check the subnet-level **NACL**.

The distinction I need to remember is:

```text
Security Group → Instance / Resource level

NACL            → Subnet level
```

I should check whether the relevant **inbound/outbound traffic** is permitted.

---

# 🟢 10. Host Firewall

Even if the AWS networking configuration looks correct, the **server itself can still block traffic**.

Examples:

```text
ufw
iptables
firewalld
```

So my troubleshooting becomes:

```text
AWS Security Group → Check
NACL                → Check
Host Firewall       → Check
```

I shouldn't assume that because the AWS configuration is correct, the server itself must be allowing the traffic.

---

# 🟢 11. Is the Service Running?

Suppose everything I've checked so far looks correct.

Now I move toward the actual **service/application**.

For example:

```text
Web Server
SSH Service
Application Server
```

I need to check whether:

* the process is running
* the service is listening on the expected port

For example:

```bash
ss -lntp | grep 8080
```

If there is no listener:

```text
Port not listening
       ↓
Check service
       ↓
Check configuration
       ↓
Check logs
```

So if nothing is listening on the expected port, I move toward the service configuration and logs.

---

# 🟢 12. Application Logs

If the network path and port are working but the application is still failing:

> **I should check the application logs.**

Logs can show things such as:

```text
Application error
Configuration error
Connection failure
Permission problem
Startup failure
```

The exact location of the logs depends on the **application/service**.

---

# 🔥 13. Scenario 1 — SSH Not Working

Customer says:

> **"My EC2 is running but I can't SSH into it."**

I would troubleshoot it step by step:

```text
EC2 running?
     ↓
Correct IP?
     ↓
Route?
     ↓
TCP 22?
     ↓
Security Group
     ↓
NACL
     ↓
Host Firewall
     ↓
SSH Service
     ↓
Logs
```

### 🎯 Interview Answer

> **"I would verify the instance and IP first, then check network routing and TCP port 22. After that I'd check the Security Group, NACL and host firewall, then verify that the SSH service is running and check logs."**

---

# 🔥 14. Scenario 2 — IP Works, Domain Doesn't

Suppose:

```text
IP     → ✅
Domain → ❌
```

I would check:

```text
DNS Resolution
     ↓
Correct DNS Response?
     ↓
Correct IP?
```

### Likely Root Cause

> **DNS / configuration issue**

So my first focus would be DNS.

---

# 🔥 15. Scenario 3 — DNS Works, Website Doesn't

Suppose:

```text
DNS → ✅
IP  → ✅
Website → ❌
```

Now I move further down the troubleshooting flow:

```text
IP Reachability
     ↓
Route
     ↓
Port 80 / 443
     ↓
Security Group
     ↓
NACL
     ↓
Firewall
     ↓
Application
     ↓
Logs
```

Here, DNS is already working, so I shouldn't keep focusing on DNS.

---

# 🔥 16. Scenario 4 — Ping Works, Port Doesn't

Customer says:

> **"I can ping the server, but port 8080 doesn't work."**

I need to remember:

```text
Ping → ICMP
8080 → TCP
```

So I should **not assume**:

> "Ping works, therefore everything works."

Instead:

```text
Ping ✅
   ↓
Basic connectivity works
   ↓
TCP 8080 ❌
   ↓
Check:
Security Group
NACL
Firewall
Listener
Application
Logs
```

This tells me that basic connectivity is working, but the required TCP port is not.

---

# 🔥 17. Scenario 5 — Private EC2 Can't Access Internet

The basic path is:

```text
EC2
 ↓
Route Table
 ↓
0.0.0.0/0
 ↓
NAT Gateway
 ↓
Internet Gateway
 ↓
Internet
```

I should check:

```text
Route Table
Default Route
NAT Gateway
Internet Gateway path
Security Group
NACL
```

For a private subnet, a common AWS design uses a **NAT Gateway** for outbound internet access.

---

# 🔥 18. Scenario 6 — Two EC2 Instances Can't Communicate

Suppose:

```text
EC2-A
10.0.1.10

EC2-B
10.0.2.20
```

They are in different subnets.

I should check:

```text
IP
 ↓
Subnet
 ↓
Route
 ↓
Security Group
 ↓
NACL
 ↓
Firewall
 ↓
Port
 ↓
Application
 ↓
Logs
```

Again, I follow the path instead of randomly checking things.

---

# 🔥 19. Scenario 7 — HTTPS Doesn't Work

Customer says:

> **"The website doesn't work over HTTPS."**

I know:

```text
HTTPS → TCP 443
```

So I check:

```text
DNS
 ↓
Correct IP
 ↓
TCP 443
 ↓
Security Group
 ↓
NACL
 ↓
Firewall
 ↓
Service listening on 443
 ↓
TLS Configuration
 ↓
Certificate
 ↓
Logs
```

This lets me identify whether the problem is:

* DNS
* network connectivity
* security
* port
* service
* TLS
* certificate
* logs

---

# 🟢 20. Complete Customer Troubleshooting Flow

🔥 This is the **most important diagram of Day 11**.

```text
                 CUSTOMER PROBLEM
                        ↓
                What exactly fails?
                        ↓
                      DNS?
                        ↓
                       IP?
                        ↓
                     SUBNET?
                        ↓
                      ROUTE?
                        ↓
                     GATEWAY?
                        ↓
               SECURITY GROUP / NACL?
                        ↓
                    FIREWALL?
                        ↓
                      PORT?
                        ↓
                   SERVER/SERVICE?
                        ↓
                   APPLICATION?
                        ↓
                      LOGS
                        ↓
                   ROOT CAUSE
                        ↓
                       FIX
                        ↓
                     VERIFY
```

### 🧠 My Main Troubleshooting Rule

> **Don't randomly troubleshoot. Find the layer where the failure occurs.** 🔥

---

# 🎯 FINAL INTERVIEW REVISION

# 🌐 Networking Basics

## ❓ What is an IP address?

> **An IP address identifies a device/interface for network communication.**

---

## ❓ What is a MAC address?

> **A MAC address is used for Layer-2/local network communication.**

---

## ❓ What is a port?

> **A port identifies a particular service/application on a device.**

---

## ❓ What is a protocol?

> **A protocol is a set of rules used for communication.**

---

# 🎯 OSI Model

```text
7 → Application
6 → Presentation
5 → Session
4 → Transport
3 → Network
2 → Data Link
1 → Physical
```

### Important for me:

```text
Transport → TCP / UDP / Ports
Network   → IP / Routing
Data Link → MAC
```

---

# 🎯 IP & Subnetting

I remember:

```text
CIDR → /24 /26 /27 /28
```

For traditional IPv4 subnetting:

```text
Host bits = 32 - CIDR

Total IPs = 2^host bits

Usable = Total - 2
```

And:

```text
Network   → identifies subnet
Broadcast → represents all hosts in subnet
Usable    → host addresses
```

### ☁️ AWS-Specific Note

> **AWS reserves 5 IPv4 addresses in each subnet, so AWS assignable IP counts differ from the traditional `total - 2` calculation.**

---

# 🎯 TCP / UDP

## TCP

```text
Connection-oriented
Reliable
Ordered
```

## UDP

```text
Connectionless
Less overhead
No TCP-style reliability
```

---

# 🎯 TCP Handshake

```text
SYN
 ↓
SYN-ACK
 ↓
ACK
 ↓
Connection established
```

---

# 🎯 Sequence & ACK

```text
SEQ
 ↓
Tracks data/order

ACK
 ↓
Indicates what sequence number is expected next
```

---

# 🎯 Flow Control

I remember:

> **Flow control prevents a fast sender from overwhelming a slower receiver.**

---

# 🎯 Common Ports

```text
22  → SSH
53  → DNS
80  → HTTP
443 → HTTPS
```

---

# 🎯 DNS

```text
Domain
 ↓
DNS
 ↓
IP Address
```

If:

```text
IP works
Domain doesn't
```

→ **Check DNS.**

---

# 🎯 DHCP

DORA:

```text
D → Discover
O → Offer
R → Request
A → Acknowledge
```

DHCP provides network configuration such as:

```text
IP
Subnet Mask
Gateway
DNS
```

---

# 🎯 NAT

```text
Private Network
      ↓
     NAT
      ↓
External / Public Communication
```

Common AWS private-subnet outbound path:

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

# 🎯 HTTP / HTTPS

```text
HTTP  → TCP 80
HTTPS → TCP 443
```

HTTPS:

```text
HTTP + TLS
```

Simplified secure web flow:

```text
DNS
 ↓
IP
 ↓
TCP 443
 ↓
TLS
 ↓
HTTPS
```

---

# 🎯 Router vs Switch

```text
Switch → Local Network → MAC

Router → Different Networks → IP / Routing
```

---

# 🎯 ARP

> **ARP resolves an IPv4 address to a MAC address on the local network.**

Simple memory:

```text
IP
 ↓
ARP
 ↓
MAC
```

For a remote destination, the sender needs the MAC of its **local next hop/default gateway**, not the remote server's MAC.

---

# 🎯 Security Group vs NACL

```text
Security Group → Instance / Resource Level

NACL            → Subnet Level
```

---

# 🏆 FINAL CLOUD SUPPORT CHEAT SHEET

If I remember only **one thing** from this entire networking course, I should remember this troubleshooting flow:

```text
                CUSTOMER SAYS:
              "IT IS NOT WORKING"
                       ↓
                  WHAT FAILED?
                       ↓
                     DNS
                       ↓
                      IP
                       ↓
                    SUBNET
                       ↓
                     ROUTE
                       ↓
                    GATEWAY
                       ↓
              SG / NACL / FIREWALL
                       ↓
                     PORT
                       ↓
                    SERVICE
                       ↓
                  APPLICATION
                       ↓
                     LOGS
                       ↓
                  ROOT CAUSE
                       ↓
                      FIX
                       ↓
                    VERIFY
```

### 🔥 My Main Rule

> **Don't randomly troubleshoot. Find the layer where the failure occurs.**

---

# 🎉 NETWORKING COURSE COMPLETE

```text
Day 1  → Networking Fundamentals             ✅
Day 2  → IP Addressing                       ✅
Day 3  → Subnetting                          ✅
Day 4  → TCP, UDP & Ports                    ✅
Day 5  → DNS                                 ✅
Day 6  → DHCP + NAT                          ✅
Day 7  → HTTP/HTTPS + TLS                    ✅
Day 8  → Router, Switch, ARP, Packet Flow    ✅
Day 9  → Routing, Firewall, SG/NACL          ✅
Day 11 → Troubleshooting + Revision          ✅
```

# 🏆 DAY 11 COMPLETE, BRO! 🔥🔥🔥

## 🎯 My Final Takeaway

> **I now understand that Cloud Support troubleshooting should be done step by step. First I identify exactly what is failing, then I move through DNS, IP, subnet, route, gateway, security, port, server/service, application, and logs. My goal is not to randomly try fixes, but to find the exact layer where the failure is happening, identify the root cause, fix it, and finally verify that the issue is resolved.**
