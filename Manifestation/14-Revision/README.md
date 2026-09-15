<div align="center">

# 🚀 NETWORKING REVISION

### Core Cloud Support Topics — My Easy-to-Understand Notes

</div>

> **How I want to use these notes:** I don't want to just memorize definitions. I want to understand what each networking concept means, why it is needed, and how it connects to the complete request flow.

---

# 1️⃣ ROUTER vs SWITCH

This is one of the first things I should understand clearly.

## 🔹 Switch

A **switch connects devices within the same local network**.

It mainly works with **MAC addresses**.

```text
PC 1 ───┐
PC 2 ───┼── Switch
PC 3 ───┘
```

If PC 1 wants to communicate with PC 2 on the same network, the switch forwards the Ethernet frame to the correct device.

### What I should remember

```text
Switch
→ Same/local network
→ MAC address
→ Mainly Layer 2
→ Uses a MAC table
```

## 🔹 Router

A **router connects different networks**.

It mainly works with **IP addresses** and routing.

```text
Network A
    |
  Router
    |
Network B
```

For example:

```text
10.0.1.0/24
      |
    Router
      |
10.0.2.0/24
```

The router looks at the destination IP and uses its routing table to decide where the packet should go.

### What I should remember

```text
Router
→ Different networks
→ IP address
→ Mainly Layer 3
→ Routing
→ Uses a routing table
```

### 🧠 My easy memory

> **Switch = same network**
> **Router = different networks**

---

# 2️⃣ WHAT IS A BROADCAST DOMAIN?

A **broadcast domain** is a group of devices that can receive a **Layer-2 broadcast**.

For example:

```text
PC1
PC2
PC3
PC4
  \ | /
   Switch
```

If one device sends a broadcast, the other devices in that broadcast domain can receive it.

## 🔹 Example: ARP

ARP uses broadcast for an IPv4 address-to-MAC lookup.

Suppose:

```text
PC1 wants to find the MAC
for 192.168.1.20
```

PC1 can send:

```text
"Who has 192.168.1.20?"
```

That is a broadcast.

## 🔹 Router separates broadcast domains

A router does not simply forward a Layer-2 broadcast from one network to another.

```text
Broadcast Domain A
        |
      Router
        |
Broadcast Domain B
```

So the router separates the two broadcast domains.

### 🧠 My memory

> **A broadcast domain is the area where a Layer-2 broadcast can reach.**

---

# 3️⃣ DHCP — DORA PROCESS

DHCP stands for:

> **Dynamic Host Configuration Protocol**

DHCP automatically provides network configuration to a device.

It can provide:

* IP address
* Subnet mask
* Default gateway
* DNS server

Without DHCP, I would have to configure these manually.

## 🔥 DORA

The DHCP process is:

```text
D → Discover
O → Offer
R → Request
A → Acknowledge
```

## 1. Discover

The client does not know where the DHCP server is.

So it sends a **DHCP Discover**.

Basically:

> "Is there any DHCP server available?"

```text
Client
  |
  | DHCP Discover
  ↓
Network
```

## 2. Offer

A DHCP server responds with an offer.

It can offer:

```text
IP Address
Subnet Mask
Gateway
DNS
```

```text
DHCP Server
     |
     | DHCP Offer
     ↓
   Client
```

## 3. Request

The client chooses an offer and requests that configuration.

```text
Client
  |
  | DHCP Request
  ↓
DHCP Server
```

## 4. Acknowledge

The DHCP server confirms the configuration.

```text
DHCP Server
     |
     | DHCP ACK
     ↓
   Client
```

Now the client can use the assigned network configuration.

### 🧠 DORA in my own words

```text
Discover → "Any DHCP server?"
Offer    → "Here is an IP/config."
Request  → "I want this configuration."
ACK      → "Okay, you can use it."
```

---

# 4️⃣ DNS — DETAILED EXPLANATION

DNS stands for:

> **Domain Name System**

The main purpose of DNS is to translate a domain name into an IP address.

For example:

```text
amazon.com
    ↓
   DNS
    ↓
IP Address
```

Humans prefer names.

Networks communicate using IP addresses.

So I can think of DNS as a **lookup system**.

## 🔹 What happens when I type a domain?

Suppose I type:

```text
amazon.com
```

The browser needs the IP address.

It first checks available DNS information/cache.

If the answer is not available locally, a DNS query is sent to a DNS resolver.

The resolver may query other DNS servers to find the answer.

Conceptually:

```text
Browser
   ↓
DNS Resolver
   ↓
Root
   ↓
.com
   ↓
Authoritative DNS
   ↓
IP Address
```

The IP address is returned to the client.

Then the browser can connect to the server.

## 🔹 Which protocol does DNS use?

DNS commonly uses:

```text
UDP 53
```

TCP can also be used:

```text
TCP 53
```

### Why UDP?

DNS queries are usually small and need a quick response.

UDP has:

* Less overhead
* No connection establishment
* Simple request-response communication

So normal DNS queries commonly use UDP.

### Why TCP?

TCP can be used when DNS needs reliable transport or when the response is too large for the normal UDP exchange.

A classic example is:

```text
DNS Zone Transfer
```

which uses TCP.

### 🧠 My memory

```text
DNS → UDP 53 commonly
DNS → TCP 53 when required
```

---

# 5️⃣ SUBNETTING

Subnetting means **dividing a larger network into smaller networks**.

For example:

```text
10.0.0.0/24
```

can be divided into smaller subnets.

## Why do I need subnetting?

I may want to separate networks.

For example:

```text
VPC
 |
 ├── Subnet A
 ├── Subnet B
 ├── Subnet C
 └── Subnet D
```

In AWS, subnets are used to organize resources within a VPC.

## 🔹 CIDR

CIDR tells me how many bits are used for the network portion.

Example:

```text
192.168.1.0/24
```

Here:

```text
/24 → 24 network bits
```

IPv4 has 32 bits.

Therefore:

```text
Host bits = 32 - 24
          = 8
```

Total addresses:

```text
2^8 = 256
```

Traditional usable host addresses:

```text
256 - 2 = 254
```

The two traditionally excluded addresses are:

```text
Network address
Broadcast address
```

## 🔹 Example — /26

```text
192.168.1.0/26
```

Host bits:

```text
32 - 26 = 6
```

Total:

```text
2^6 = 64
```

Traditional usable:

```text
64 - 2 = 62
```

## 🔹 Important AWS point

AWS reserves **5 IPv4 addresses in every subnet**, so AWS assignable IP counts are different from the traditional `total - 2` calculation.

So I should not blindly apply the normal host calculation when working with AWS subnet capacity.

---

# 6️⃣ MTU

MTU means:

> **Maximum Transmission Unit**

It represents the maximum packet size that can be transmitted over a particular network interface/link without needing fragmentation at that point.

I can simply remember:

```text
MTU = Maximum packet size
```

Example:

```text
MTU = 1500 bytes
```

If a packet is larger than the supported MTU, fragmentation or another mechanism may be needed depending on the protocol/path.

---

# 7️⃣ MSS

MSS means:

> **Maximum Segment Size**

MSS is related to TCP.

It represents the maximum amount of **TCP payload** that can be carried in a segment.

A common relationship is:

```text
MSS ≈ MTU - IP Header - TCP Header
```

For a common Ethernet MTU of 1500 bytes with normal IPv4/TCP headers:

```text
1500 - 20 - 20
= 1460 bytes
```

So:

```text
MTU → Maximum packet size
MSS → Maximum TCP payload
```

### 🧠 Easy memory

> **MTU is about the packet. MSS is about TCP data inside the packet.**

---

# 8️⃣ COMPLETE FLOW — WHEN I TYPE AMAZON.COM

This is one of the most important flows I should know for interviews.

Suppose I type:

```text
https://amazon.com
```

and press Enter.

## Step 1 — My device needs network configuration

My device needs:

```text
IP
Subnet Mask
Default Gateway
DNS Server
```

DHCP can provide these.

```text
Device
  ↓
DHCP
  ↓
DORA
  ↓
IP + Subnet + Gateway + DNS
```

## Step 2 — Browser checks DNS information

The browser checks whether it already knows the IP address.

If not, the OS/network resolver can continue the lookup.

```text
Browser
   ↓
DNS Cache
   ↓
OS / Resolver
```

## Step 3 — DNS resolves the domain

The DNS resolver finds the IP address for:

```text
amazon.com
```

Conceptually:

```text
DNS Resolver
     ↓
Root
     ↓
.com
     ↓
Authoritative DNS
     ↓
Amazon IP
```

Now the browser knows where to connect.

## Step 4 — Routing

My computer checks whether the destination IP is on the local network.

If it is outside the local subnet:

```text
Computer
   ↓
Default Gateway
   ↓
Router
```

The router checks its routing table and forwards the packet toward the destination.

## Step 5 — TCP connection

Because HTTPS normally uses TCP in this flow, the browser establishes a TCP connection to:

```text
TCP 443
```

using:

```text
SYN
 ↓
SYN-ACK
 ↓
ACK
```

Now TCP is established.

## Step 6 — TLS handshake

Because I am accessing:

```text
HTTPS
```

TLS is established over the TCP connection.

TLS provides:

* Encryption
* Authentication
* Integrity

The exact handshake depends on the TLS version.

## Step 7 — HTTPS request

Once TLS is established, the browser sends the HTTP request through the encrypted connection.

For example:

```text
GET /
```

The server receives the request.

## Step 8 — Web server / application

The request reaches the web server/application.

The server processes it and generates a response.

## Step 9 — HTTPS response

The server sends the response back through the encrypted connection.

```text
Server
  ↓
HTTPS Response
  ↓
Browser
```

## Step 10 — Browser displays the website

The browser processes the returned content.

It may request additional:

```text
HTML
CSS
JavaScript
Images
```

Finally:

```text
Amazon Website
      ↓
Displayed in Browser
```

## 🔥 Complete flow I should remember

```text
User
 ↓
Browser
 ↓
DNS Cache
 ↓
DNS Resolver
 ↓
Root
 ↓
.com
 ↓
Authoritative DNS
 ↓
Amazon IP
 ↓
Routing
 ↓
Default Gateway
 ↓
Internet
 ↓
TCP 3-Way Handshake
 ↓
TCP 443
 ↓
TLS Handshake
 ↓
HTTPS Request
 ↓
Web Server
 ↓
Application
 ↓
HTTPS Response
 ↓
Browser
 ↓
Website
```

### 🧠 My interview answer

> "When I enter amazon.com, DNS first resolves the domain name to an IP address. My system then routes traffic toward that IP through the default gateway. For HTTPS, TCP establishes a connection on port 443, followed by the TLS handshake. After that, the browser sends the HTTPS request, the server processes it and sends the response back, which the browser displays."

---

# 9️⃣ OSI MODEL — COMPLETE

The OSI model has **7 layers**.

```text
7 → Application
6 → Presentation
5 → Session
4 → Transport
3 → Network
2 → Data Link
1 → Physical
```

I want to understand what each layer is doing rather than just memorizing the names.

---

## 🔹 Layer 7 — Application

This is the layer closest to the applications/users.

It provides network services to applications.

Examples/protocols:

```text
HTTP
HTTPS
DNS
FTP
SMTP
SNMP
```

Examples of services:

```text
Web browsing
Email
File transfer
DNS lookup
Network management
```

### My understanding

> **Application = network services used by applications.**

---

## 🔹 Layer 6 — Presentation

This layer deals with **how data is represented**.

It can be associated with:

```text
Data formatting
Encoding
Encryption
Compression
```

Examples mentioned conceptually include:

```text
ASCII
JPEG
```

### My understanding

> **Presentation = how the data is represented.**

---

## 🔹 Layer 5 — Session

This layer manages communication sessions.

It can:

```text
Establish
Maintain
Terminate
```

a session between applications.

### My understanding

> **Session = manages the conversation/session.**

---

## 🔹 Layer 4 — Transport

This layer provides **end-to-end transport**.

Main protocols:

```text
TCP
UDP
```

It also uses:

```text
Port Numbers
```

Examples:

```text
TCP 22
TCP 80
TCP 443
UDP 53
```

### PDU

For TCP:

```text
Segment
```

For UDP:

```text
Datagram
```

### My understanding

> **Transport = TCP/UDP + ports + end-to-end transport.**

---

## 🔹 Layer 3 — Network

This layer deals with:

```text
IP Addressing
Routing
```

Main protocol:

```text
IP
```

Other example:

```text
ICMP
```

Routers mainly operate here.

### PDU

```text
Packet
```

### My understanding

> **Network = IP + routing.**

---

## 🔹 Layer 2 — Data Link

This layer deals with **local network communication**.

It uses:

```text
MAC Addresses
Frames
```

Examples:

```text
Ethernet
ARP
```

Switches mainly operate here.

### PDU

```text
Frame
```

### My understanding

> **Data Link = MAC + frames + local network communication.**

---

## 🔹 Layer 1 — Physical

This is the actual transmission of bits/signals.

Examples:

```text
Copper
Fiber
Wireless
Electrical signals
Radio signals
Light signals
```

### PDU

```text
Bits
```

### My understanding

> **Physical = actual bits/signals moving through the medium.**

---

# 🔥 OSI MODEL — MY QUICK TABLE

| Layer | Name         | Main idea                       | Examples / PDU                    |
| ----- | ------------ | ------------------------------- | --------------------------------- |
| 7     | Application  | Network services                | HTTP, HTTPS, DNS, FTP, SMTP, SNMP |
| 6     | Presentation | Format, encryption, compression | Data representation               |
| 5     | Session      | Sessions                        | Session management                |
| 4     | Transport    | End-to-end transport, ports     | TCP, UDP / Segment, Datagram      |
| 3     | Network      | IP, routing                     | IP, ICMP / Packet                 |
| 2     | Data Link    | MAC, frames                     | Ethernet, ARP / Frame             |
| 1     | Physical     | Signals/bits                    | Cable, Fiber, Wireless / Bits     |

### 🧠 Easy way I remember the lower layers

```text
Layer 4 → TCP / UDP / Ports
Layer 3 → IP / Routing
Layer 2 → MAC / Frames
Layer 1 → Bits / Signals
```

---

# 🔟 TCP vs UDP

This is a very common interview question.

## 🔹 TCP

TCP is:

> **Connection-oriented and reliable.**

It establishes a connection before transferring data.

It provides mechanisms for:

* Reliability
* Ordering
* Acknowledgements
* Flow control

Example:

```text
Client                  Server

  SYN  ------------------>

       <------------------ SYN-ACK

  ACK  ------------------>
```

Now the connection is established.

Common examples:

```text
HTTP/HTTPS
SSH
FTP
SMTP
```

### My understanding

> **TCP is used when reliable, ordered delivery is important.**

---

# 🔹 UDP

UDP is:

> **Connectionless and has less overhead than TCP.**

There is no TCP-style three-way handshake.

UDP does not provide TCP-style reliability and ordering.

It is useful when low overhead is important.

Examples include:

```text
DNS
DHCP
```

### 🔥 TCP vs UDP

| TCP                   | UDP                        |
| --------------------- | -------------------------- |
| Connection-oriented   | Connectionless             |
| Reliable              | No TCP-style reliability   |
| Ordered               | No TCP-style ordering      |
| Uses acknowledgements | No TCP-style ACK mechanism |
| More overhead         | Less overhead              |
| Uses handshake        | No TCP 3-way handshake     |
| Example: HTTPS        | Example: DNS               |

### 🧠 My easy memory

> **TCP = reliability**
> **UDP = low overhead**

---

# 1️⃣1️⃣ TCP THREE-WAY HANDSHAKE

The TCP three-way handshake is:

```text
Client                  Server

  SYN  ------------------>

       <------------------ SYN-ACK

  ACK  ------------------>
```

## 1. SYN

The client wants to establish a connection.

## 2. SYN-ACK

The server acknowledges the SYN and sends its own SYN.

## 3. ACK

The client acknowledges the server.

Now:

```text
TCP Connection Established
```

### 🧠 In simple words

```text
Client → "Can we connect?"
Server → "Yes, I received you. Can we connect?"
Client → "Yes."
```

---

# 1️⃣2️⃣ TLS / SSL HANDSHAKE

People often say **SSL handshake**, but modern secure web communication uses **TLS**.

TLS stands for:

> **Transport Layer Security**

It provides:

```text
Encryption
Authentication
Integrity
```

The exact handshake depends on the TLS version.

At a high level:

```text
TCP Connection
      ↓
TLS Handshake
      ↓
Secure Session
      ↓
HTTPS Data
```

## 🔥 TCP + TLS + HTTPS

This is extremely important:

```text
DNS
 ↓
IP Address
 ↓
TCP 3-Way Handshake
 ↓
TLS Handshake
 ↓
HTTPS Request
 ↓
HTTPS Response
```

So I remember:

> **TCP comes first, then TLS, then HTTPS application data.**

---

# 1️⃣3️⃣ FLOW CONTROL

Flow control prevents a **fast sender from overwhelming a slower receiver**.

Imagine:

```text
Sender
  ↓↓↓↓↓↓↓↓↓
  Fast
    ↓
Receiver
  ↓
 Slow
```

If the sender sends too much too quickly, the receiver may not be able to process it.

TCP uses mechanisms such as the **receive window** to control how much data can be sent before acknowledgements are needed.

### 🧠 Easy memory

> **Flow control = match sender speed with receiver capacity.**

---

# 1️⃣4️⃣ ERROR CONTROL

Error control is about making sure data is transferred correctly.

TCP provides reliability using mechanisms such as:

```text
Sequence Numbers
Acknowledgements
Retransmission
```

## 🔹 Sequence numbers

Sequence numbers help TCP keep track of data and its order.

```text
Data 1 → SEQ
Data 2 → SEQ
Data 3 → SEQ
```

## 🔹 ACK

The acknowledgement tells the sender what data has been received and what is expected next.

If data is missing, TCP can retransmit it.

```text
Sender
  ↓ Data
Receiver
  ↓ ACK
Sender
```

If something is lost:

```text
Data ❌
  ↓
Retransmission
  ↓
Receiver
```

### 🧠 My understanding

> **Sequence numbers help track/order the data, ACKs confirm what was received/expected, and retransmission handles missing data.**

---

# 1️⃣5️⃣ FIREWALL

A firewall is a **security mechanism that controls network traffic according to rules**.

It can:

```text
ALLOW
or
BLOCK
```

traffic.

The rules can consider things such as:

```text
Source IP
Destination IP
Protocol
Port
Direction
```

## 🔹 Why do I need a firewall?

Without traffic filtering, unwanted traffic could reach systems/services.

For example, suppose my server only needs HTTPS.

I can allow:

```text
TCP 443
```

and block unwanted traffic.

```text
Internet
   ↓
Firewall
   ↓
TCP 443 → ALLOW
TCP 23  → BLOCK
```

So the firewall acts as a controlled checkpoint.

---

# 🔹 Firewall in Cloud — AWS Security Group

In AWS, a **Security Group** acts as a virtual firewall associated with resources such as EC2.

For example:

```text
Inbound Rules

SSH    → TCP 22
HTTP   → TCP 80
HTTPS  → TCP 443
```

If port 443 is not allowed, an HTTPS connection may fail even when the server is running.

### 🧠 My troubleshooting thought

If the application is running but I cannot connect, I should not immediately blame the application.

I should think:

```text
Is the required port allowed?
        ↓
Security Group?
        ↓
Other network/security rules?
        ↓
Is the service actually listening?
```

---

# 🔹 Stateful vs Stateless

## Stateful

A stateful firewall keeps track of connection state.

```text
Connection
   ↓
State tracked
   ↓
Return traffic understood
```

## Stateless

A stateless firewall evaluates packets independently against its rules.

It does not maintain the connection state like a stateful firewall.

---

# 🧠 FIREWALL — MY INTERVIEW ANSWER

> "A firewall controls network traffic based on defined rules. It can allow or block traffic based on things like source, destination, protocol and port. We need it to prevent unauthorized or unwanted network access while allowing legitimate traffic required by the application."

---

# 🏆 FINAL REVISION — EVERYTHING I SHOULD REMEMBER

## Switch

```text
→ Same/local network
→ MAC
→ Layer 2
```

## Router

```text
→ Different networks
→ IP + Routing
→ Layer 3
```

## Broadcast Domain

```text
→ Area where Layer-2 broadcasts can reach
```

## DHCP

```text
→ Provides IP configuration
→ DORA
→ Discover → Offer → Request → ACK
```

## DNS

```text
→ Domain → IP
→ UDP 53 commonly
→ TCP 53 when required
```

## Subnetting

```text
→ Divides a network into smaller networks
→ CIDR
```

## MTU

```text
→ Maximum packet size
```

## MSS

```text
→ Maximum TCP payload
```

## TCP

```text
→ Reliable
→ Connection-oriented
→ Ordered
→ Acknowledgements
→ Flow control
→ Handshake
```

## UDP

```text
→ Connectionless
→ Less overhead
```

## Flow Control

```text
→ Prevents a fast sender from overwhelming the receiver
```

## Error Control

```text
→ Sequence numbers
→ ACK
→ Retransmission
```

## Firewall

```text
→ Allow/block traffic
→ Uses rules
→ Can consider IP, protocol, port and direction
```

## OSI

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

# 🔥 MOST IMPORTANT FLOW — AMAZON.COM

If an interviewer asks:

> **"What happens when you type amazon.com?"**

I should be able to explain it like this:

```text
DHCP
 ↓
Browser / OS DNS Cache
 ↓
DNS Resolution
 ↓
IP Address
 ↓
Routing
 ↓
Default Gateway
 ↓
TCP 3-Way Handshake
 ↓
TCP 443
 ↓
TLS Handshake
 ↓
HTTPS Request
 ↓
Web Server
 ↓
Application
 ↓
HTTPS Response
 ↓
Browser
```

### And if they ask:

> **"Where can it fail?"**

I can troubleshoot layer by layer:

```text
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
Firewall / Security Group
 ↓
Port
 ↓
Server
 ↓
Application
 ↓
Logs
```

---

# 🧠 MY MAIN TAKEAWAY

I don't want to memorize networking as separate topics.

I want to understand how all these concepts connect together in **one packet/request flow**.

When something fails, I should think step by step:

```text
What is the destination?
        ↓
Did DNS resolve it?
        ↓
Can I reach the IP?
        ↓
Is the destination in the local subnet?
        ↓
If not, what is the gateway/route?
        ↓
Is traffic allowed?
        ↓
Is the required port open?
        ↓
Is the server/service running?
        ↓
Is the application working?
        ↓
What do the logs say?
```

> **My goal is not just to remember networking terms. My goal is to understand the path the traffic takes and identify exactly where it can fail.**
