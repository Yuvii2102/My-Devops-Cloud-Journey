<div align="center">

# 🔥 FINAL PENDING NETWORKING TOPICS

### Easy Cloud Support Networking Notes

</div>

> These are the remaining specific networking topics from my teacher's sheet.
> I already completed the main 10-day syllabus, so these notes focus only on the remaining points that need proper explanation.

---

# 1️⃣ DHCP — TYPES OF IP ADDRESS ALLOCATION

My teacher asks:

> **What are the different types of IP address allocation in DHCP?**

There are **3 types**:

1. Dynamic Allocation
2. Automatic Allocation
3. Manual Allocation

---

## 1. Dynamic Allocation

In dynamic allocation, DHCP gives an IP address to a device for a **limited amount of time**.

This time is called the **lease period**.

For example:

```text
Laptop
   ↓
 DHCP
   ↓
192.168.1.10
   ↓
Lease expires
   ↓
IP can be reused
```

So, the device gets an IP temporarily.

This is the **most common type in normal networks**.

### Easy way to remember

**Dynamic = temporary IP**

---

## 2. Automatic Allocation

Here DHCP automatically assigns an IP address to the device.

The device generally keeps that address as long as the address remains available/appropriate in the DHCP system.

```text
Device
   ↓
 DHCP
   ↓
IP automatically assigned
```

### Easy way to remember

**Automatic = DHCP automatically chooses the IP**

---

## 3. Manual Allocation

Here the administrator decides which IP address should be given to a particular device.

Usually, this is done using the device's **MAC address/client identifier**.

Example:

```text
MAC Address
AA:BB:CC:11:22:33
        ↓
DHCP Reservation
        ↓
192.168.1.50
```

Whenever that particular device requests an IP, DHCP gives it the configured address.

### Easy way to remember

**Manual = Admin decides the IP**

---

## 🧠 DHCP Allocation — Quick Memory

```text
Dynamic  → IP for a lease period
Automatic → DHCP automatically assigns IP
Manual    → Admin associates specific IP with client
```

### 🎯 Interview Answer

> **DHCP supports dynamic, automatic and manual allocation. Dynamic allocation gives an IP for a lease period, automatic allocation assigns an IP automatically, and manual allocation allows the administrator to associate a specific IP with a particular client.**

---

# 2️⃣ DHCP DORA — BROADCAST & UNICAST

My teacher specifically asks:

> **Which messages are broadcast and unicast in DORA? Why?**

First, remember DORA:

```text
D → Discover
O → Offer
R → Request
A → Acknowledgement
```

---

## Step 1 — DHCP Discover

The client doesn't have an IP address yet.

It asks:

> "Is there any DHCP server?"

```text
Client
   ↓
Broadcast
   ↓
"Is there any DHCP server?"
```

### Why broadcast?

Because the client **doesn't know the DHCP server's IP address yet**.

So it sends the message to everyone in the local broadcast domain.

---

## Step 2 — DHCP Offer

The DHCP server responds with an offer.

```text
DHCP Server
     ↓
   Offer
     ↓
   Client
```

The response can be **broadcast or unicast**, depending on the DHCP stage and the client's state.

### ⚠️ Important

Don't blindly memorize:

> "DHCP Offer is always unicast."

That's too absolute.

The actual behavior can depend on the client state and DHCP exchange.

---

## Step 3 — DHCP Request

The client says:

> **"I want this offered IP."**

This is commonly sent as a **broadcast**.

```text
Client
  ↓
Broadcast
  ↓
DHCP Servers
```

### Why?

So that all DHCP servers know which offer the client selected.

For example, imagine two DHCP servers gave offers.

The client selects one.

The broadcast DHCP Request tells the DHCP servers which offer was selected.

---

## Step 4 — DHCP ACK

The DHCP server confirms the configuration.

```text
DHCP Server
     ↓
    ACK
     ↓
   Client
```

The ACK can also be **broadcast or unicast**, depending on the client's state and the DHCP exchange.

---

## 🔥 Important Interview Point

Don't say:

> "Discover and Request are always broadcast, Offer and ACK are always unicast."

That's too absolute.

Instead, say:

> **"DHCP Discover is broadcast because the client doesn't initially know the DHCP server. DHCP Request is commonly broadcast so all DHCP servers know which offer was selected. Offer and ACK can be broadcast or unicast depending on the client's state and DHCP exchange."**

---

# 3️⃣ TCP SEQUENCE & ACKNOWLEDGEMENT NUMBERS

This is an important TCP concept.

The main idea is:

* **SEQ** → tells the position of data
* **ACK** → tells the next data the receiver expects

---

## Simple Example

Suppose the sender sends:

```text
SEQ = 100
Data = 1 byte
```

The receiver receives it.

Then the receiver sends:

```text
ACK = 101
```

This means:

> **"I received byte 100. I expect 101 next."**

---

# What if the Data Contains 100 Bytes?

Suppose:

```text
SEQ = 1000
Data = 100 bytes
```

The data occupies:

```text
1000 → 1099
```

So the receiver expects the next byte:

```text
ACK = 1100
```

Why?

Because **1100 is the next sequence number expected**.

---

# ❌ What Happens If a Packet Is Lost?

Suppose:

```text
Packet 1
SEQ 1000
   ↓
RECEIVED

Packet 2
SEQ 1100
   ↓
LOST
```

The receiver received Packet 1 but did not receive Packet 2.

The acknowledgement doesn't advance as expected.

The sender detects the missing data through acknowledgements/timeouts and **retransmits** it.

```text
Packet lost
    ↓
ACK doesn't advance as expected
    ↓
Sender detects problem
    ↓
Retransmission
    ↓
Data received
```

---

## Why Are Sequence Numbers Important?

TCP uses sequence numbers to:

* Identify data
* Maintain data order
* Detect missing data
* Support retransmission
* Prevent confusion between segments

---

## 🧠 Easy Memory

```text
SEQ → Where is this data?
ACK → What data do I expect next?
```

### 🎯 Interview Answer

> **"TCP sequence numbers identify the position of data in the byte stream, while acknowledgement numbers indicate the next sequence number the receiver expects. They help TCP maintain ordering and detect missing data."**

---

# 4️⃣ HOW TO CHECK IP, GATEWAY & DNS

My teacher asks:

> **How do we check the IP address, gateway and DNS server address of a device?**

For Linux, I need to remember these commands.

---

## 🔹 Check IP Address

Use:

```bash
ip addr
```

or:

```bash
ip a
```

Example output may contain:

```text
inet 192.168.1.20/24
```

Here:

```text
192.168.1.20
       ↓
IP address
```

And:

```text
/24
 ↓
CIDR
```

---

## 🔹 Check Gateway / Routes

Use:

```bash
ip route
```

Example:

```text
default via 192.168.1.1 dev eth0
```

Here:

```text
192.168.1.1
     ↑
Default Gateway
```

So:

```text
ip route
   ↓
Check route/gateway
```

---

## 🔹 Check DNS Configuration

Use:

```bash
cat /etc/resolv.conf
```

You may see:

```text
nameserver 8.8.8.8
```

That is a configured DNS server.

---

## 🔹 Test DNS Resolution

Use:

```bash
nslookup google.com
```

or:

```bash
dig google.com
```

These help me check whether the domain can be resolved.

---

# 🧠 EASY MEMORY

```text
IP      → ip addr
Gateway → ip route
DNS     → /etc/resolv.conf
DNS test → nslookup / dig
```

---

# 5️⃣ OSI MODEL — COMPLETE REVISION

My teacher asks:

> **Explain the OSI model with complete detail and protocols on each layer.**

The OSI model has **7 layers**.

```text
┌─────────────────────────────┐
│ 7. Application              │
│ HTTP, HTTPS, DNS, SSH       │
├─────────────────────────────┤
│ 6. Presentation             │
│ Data representation         │
│ Encryption / formatting     │
├─────────────────────────────┤
│ 5. Session                  │
│ Session management          │
├─────────────────────────────┤
│ 4. Transport                │
│ TCP, UDP, Ports             │
├─────────────────────────────┤
│ 3. Network                  │
│ IP, Routing                 │
├─────────────────────────────┤
│ 2. Data Link                │
│ MAC, Ethernet, Frames       │
├─────────────────────────────┤
│ 1. Physical                 │
│ Cables, signals, radio      │
└─────────────────────────────┘
```

---

## Layer 7 — Application

This layer provides network services to applications.

Examples:

```text
HTTP
HTTPS
DNS
SSH
```

For example, when I use a browser, protocols such as HTTP/HTTPS are involved.

---

## Layer 6 — Presentation

This layer deals with **how data is represented**.

I can think of it as dealing with:

```text
Format
Encryption
Compression
```

---

## Layer 5 — Session

This layer manages communication sessions.

Think:

```text
Establish
   ↓
Maintain
   ↓
Terminate
```

So it deals with managing the communication session.

---

## Layer 4 — Transport

This layer is responsible for **end-to-end transport**.

Main protocols:

```text
TCP
UDP
```

Also remember:

```text
Ports
```

So for Cloud Support, when I think about Layer 4, I should remember:

> **TCP + UDP + Ports**

---

## Layer 3 — Network

This layer is responsible for:

* Logical addressing
* Routing

Main concepts:

```text
IP
Routing
```

So:

> **Layer 3 → IP + Routing**

---

## Layer 2 — Data Link

This layer is responsible for **local network communication**.

Important concepts:

```text
MAC
Ethernet
Frames
```

ARP is closely associated with local IP-to-MAC resolution, although its exact OSI-layer classification can vary depending on the teaching model.

---

## Layer 1 — Physical

This is the actual transmission of signals.

Examples:

```text
Cable
Electrical signal
Optical signal
Radio / Wi-Fi
```

So:

> **Physical = actual signals/bits moving**

---

# 🧠 OSI EASY MEMORY

```text
7 → Application
6 → Presentation
5 → Session
4 → Transport
3 → Network
2 → Data Link
1 → Physical
```

The most important ones for my Cloud Support preparation:

```text
Layer 7 → HTTP / HTTPS / DNS / SSH
Layer 4 → TCP / UDP / Ports
Layer 3 → IP / Routing
Layer 2 → MAC / Ethernet / Frames
Layer 1 → Cables / Signals
```

---

# 6️⃣ REAL-WORLD OSI EXAMPLE

Suppose I open:

```text
https://amazon.com
```

What happens conceptually?

---

## Layer 7 — Application

The browser uses:

```text
HTTPS
DNS
```

---

## Layer 6 — Presentation

The data needs appropriate representation and secure encoding/encryption mechanisms.

---

## Layer 5 — Session

The communication session is managed.

---

## Layer 4 — Transport

TCP provides reliable transport.

The TCP connection is established using:

```text
Client → SYN
Server → SYN-ACK
Client → ACK
```

---

## Layer 3 — Network

IP handles addressing and routing.

```text
Source IP
    ↓
Destination IP
```

---

## Layer 2 — Data Link

Local delivery uses:

```text
MAC addresses
Frames
```

ARP may be used to discover the local next-hop MAC when required.

---

## Layer 1 — Physical

The actual bits/signals travel through:

```text
Wi-Fi
   OR
Ethernet / Cable
```

So conceptually:

```text
Application
     ↓
Presentation
     ↓
Session
     ↓
Transport
     ↓
Network
     ↓
Data Link
     ↓
Physical
```

At the receiving side, the process is conceptually handled back **up the stack**.

---

# 7️⃣ COMPLETE `amazon.com` FLOW

This is an important flow that I should know properly.

Suppose I type:

```text
https://amazon.com
```

and press **Enter**.

---

## Step 1 — DNS

My system needs the server's IP address.

```text
amazon.com
     ↓
    DNS
     ↓
IP address
```

So:

> **DNS finds the IP address.**

---

## Step 2 — Routing

My machine determines how to reach that destination.

If the destination is outside my local subnet:

```text
My machine
     ↓
Default Gateway / Next Hop
```

---

## Step 3 — TCP

For traditional HTTPS over TCP:

```text
Client → SYN
Server → SYN-ACK
Client → ACK
```

Now:

```text
TCP connection established
```

---

## Step 4 — TLS

The TLS handshake establishes the secure connection and authenticates the server using its certificate.

---

## Step 5 — HTTPS

Now the browser sends the HTTP request over the secure TLS connection.

```text
Browser
   ↓
HTTPS Request
   ↓
Web Server
```

---

## Step 6 — Response

The server sends the response back.

```text
Server
   ↓
HTTPS Response
   ↓
Browser
   ↓
Web Page Displayed
```

---

## 🔥 One-Line Answer

> **DNS finds the IP, routing finds the path, TCP establishes the connection, TLS secures it, and HTTPS carries the web communication.**

This is a very useful interview answer.

---

# 8️⃣ TCP + SSL/TLS HANDSHAKE TOGETHER

Another important question is:

> **How do TCP and TLS work together for HTTPS?**

The order is:

```text
          DNS
           ↓
      Get IP Address
           ↓
    TCP 3-Way Handshake
           ↓
          SYN
           ↓
        SYN-ACK
           ↓
          ACK
           ↓
      TLS Handshake
           ↓
  Certificate Verification
           ↓
    Secure Connection
           ↓
 HTTPS Application Data
```

### 🔥 Most Important

When HTTPS is using TCP:

> **TCP comes before TLS.**

So I remember:

```text
DNS
 ↓
TCP
 ↓
TLS
 ↓
HTTPS
```

---

# 9️⃣ IP ADDRESSING — SENDER, GATEWAY & DESTINATION

Let's take this example:

```text
Sender:
10.0.1.10

Gateway:
10.0.1.1

Destination:
10.0.2.20
```

The sender first asks:

> **"Is 10.0.2.20 in my local subnet?"**

Suppose the sender has:

```text
10.0.1.10/24
```

Its local network is:

```text
10.0.1.0/24
```

But the destination is:

```text
10.0.2.20
```

The destination is in a **different network**.

Therefore:

```text
Sender
10.0.1.10
    ↓
Gateway
10.0.1.1
    ↓
Router / Network Path
    ↓
10.0.2.20
```

---

## 🔥 Important Distinction

At the IP layer:

```text
Source IP      = 10.0.1.10
Destination IP = 10.0.2.20
```

The IP destination remains the **ultimate destination** for the routed packet in this basic example.

But at Layer 2, the frame's destination MAC is the **next hop's MAC** on the local link.

So I should not confuse:

```text
IP destination
        vs
Layer 2 next-hop MAC
```

---

# 🔟 PACKET TRACING

My teacher asks:

> **What is packet tracing?**

Packet tracing means:

> **Following the traffic path from source to destination to find where communication is failing.**

Example:

```text
Client
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
Firewall / SG / NACL
  ↓
Port
  ↓
Server
  ↓
Application
```

The main idea is:

> **Don't randomly check everything. Follow the path step by step.**

---

## Example 1 — DNS Failure

If:

```text
DNS ❌
```

Then:

> → DNS issue

---

## Example 2 — IP Connectivity Failure

If:

```text
DNS ✅
IP Connectivity ❌
```

Then:

> → Routing / reachability / security issue

---

## Example 3 — Port 443 Failure

If:

```text
IP ✅
Port 443 ❌
```

Then:

> → Port / security / listener issue

---

## Example 4 — Application Failure

If:

```text
Port 443 ✅
Application ❌
```

Then:

> → Application / service / logs issue

---

# 1️⃣1️⃣ FIREWALL — WHY DO WE NEED IT?

A firewall controls network traffic based on defined rules.

For example:

```text
Allow:
TCP 443

Block:
Unwanted traffic
```

The purpose of a firewall is to:

* Protect systems
* Control access
* Prevent unauthorized connections
* Restrict unnecessary traffic

---

## AWS Security

In AWS:

```text
Security Group → Resource / Instance level

NACL → Subnet level
```

So I remember:

> **SG protects the resource/instance.**

> **NACL controls traffic at the subnet level.**

---

# 🏆 FINAL TROUBLESHOOTING MASTER FLOW

This combines almost the entire networking sheet.

```text
              CUSTOMER PROBLEM
                     ↓
              Understand Issue
                     ↓
                   DNS?
                     ↓
               Correct IP?
                     ↓
                 Reachable?
                     ↓
                Same Subnet?
                     ↓
                   Route?
                     ↓
                  Gateway?
                     ↓
             SG / NACL / Firewall?
                     ↓
                   Port?
                     ↓
              Service Running?
                     ↓
               Application?
                     ↓
                   Logs
                     ↓
                Root Cause
                     ↓
                    Fix
                     ↓
                  Verify
```

This is the **master troubleshooting structure** I should remember.

---

# 🧠 FINAL MEMORY SHEET

## 🔹 DHCP DORA

```text
D → Discover
O → Offer
R → Request
A → ACK
```

---

## 🔹 DHCP Allocation Types

```text
Dynamic
Automatic
Manual
```

---

## 🔹 Linux Commands

```bash
ip addr
```

→ Check IP

```bash
ip route
```

→ Check routes/gateway

```bash
cat /etc/resolv.conf
```

→ Check DNS configuration

```bash
nslookup example.com
```

→ Test DNS

```bash
dig example.com
```

→ Test DNS

---

## 🔹 TCP 3-Way Handshake

```text
SYN
 ↓
SYN-ACK
 ↓
ACK
```

---

## 🔹 TCP Numbers

```text
SEQ → Identifies position of data

ACK → Next sequence number expected
```

---

## 🔹 DNS

```text
Domain → IP
```

---

## 🔹 Common Ports

```text
22  → SSH
53  → DNS
80  → HTTP
443 → HTTPS
```

---

## 🔹 HTTPS Flow

```text
DNS
 ↓
TCP
 ↓
TLS
 ↓
HTTPS
```

---

## 🔹 Router vs Switch

```text
Switch → MAC → Local Network

Router → IP → Different Networks
```

---

## 🔹 ARP

```text
IPv4 Address
      ↓
MAC Address
```

ARP is used for local IP-to-MAC resolution.

---

## 🔹 Security

```text
SG       → Instance / Resource
NACL     → Subnet
Firewall → Controls Traffic
```

---

## 🔹 OSI

```text
7 → Application
6 → Presentation
5 → Session
4 → Transport
3 → Network
2 → Data Link
1 → Physical
```

---

# 🏆 MY FINAL TAKEAWAY

The biggest thing I need to understand from these topics is **how to think when something is not working**.

If a customer says:

> **"It's not working."**

I should not randomly start checking things.

I should go step by step:

```text
CUSTOMER SAYS
"It's not working"
       ↓
What exactly failed?
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
SG / NACL / Firewall
       ↓
Port
       ↓
Service
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

### 🔥 The main idea I want to remember:

> **Find the exact layer where the failure happens, then troubleshoot that layer.**

That's the mindset I need for **Cloud Support troubleshooting**.

</div>
