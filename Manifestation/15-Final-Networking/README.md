<div align="center">

# 🚀 NETWORKING — NEXT IMPORTANT TOPICS

### My Detailed Cloud Support & Interview Notes

</div>

> **My goal:** I don't want to memorize one-line definitions. I want to understand **what happens, why it happens, and what I should check when something goes wrong.**

---

# 1️⃣ DHCP — WHAT IS IT?

DHCP stands for:

> **Dynamic Host Configuration Protocol**

I understood DHCP as a service that **automatically gives my device the network configuration it needs to communicate on the network.**

Instead of manually configuring everything, DHCP can provide:

```text
IP Address
Subnet Mask
Default Gateway
DNS Server
```

For example, when I connect my laptop to a network, I need an IP address before I can communicate properly.

Instead of me manually entering:

```text
IP       → 192.168.1.10
Subnet   → 255.255.255.0
Gateway  → 192.168.1.1
DNS      → DNS Server
```

DHCP can provide this automatically.

---

# 2️⃣ WHY DO WE NEED DHCP?

Imagine a company has hundreds of computers.

If every computer has to be configured manually:

```text
PC 1 → Manual IP
PC 2 → Manual IP
PC 3 → Manual IP
PC 4 → Manual IP
...
PC 500 → Manual IP
```

That becomes difficult to manage.

DHCP automates this.

```text
Device
   ↓
DHCP
   ↓
IP + Subnet Mask + Gateway + DNS
```

So my main understanding is:

> **DHCP removes the need to manually configure basic network settings on every device.**

---

# 3️⃣ DHCP DORA PROCESS

The main DHCP process is called **DORA**.

```text
D → Discover
O → Offer
R → Request
A → Acknowledge
```

The complete flow is:

```text
Client                         DHCP Server

   |                                |
   |---- DHCP Discover ------------>|
   |                                |
   |<---- DHCP Offer ---------------|
   |                                |
   |---- DHCP Request ------------->|
   |                                |
   |<---- DHCP ACK -----------------|
   |                                |
```

Now let's understand each step properly.

---

# 4️⃣ STEP 1 — DHCP DISCOVER

When my computer joins the network, initially it doesn't have a usable IP configuration.

It doesn't know:

```text
Who is the DHCP server?
What IP should I use?
What network configuration should I get?
```

So it sends a **DHCP Discover** message.

Basically, the computer is saying:

> **"Is there any DHCP server available that can give me network configuration?"**

Conceptually:

```text
Client
   |
   | DHCP Discover
   ↓
Network
```

### Why is it Broadcast?

At this point, the client doesn't know the DHCP server's IP address.

So it cannot simply send the request directly to a known DHCP server.

It uses a broadcast so DHCP servers on the local network can receive it.

Think:

> **"I don't know where the DHCP server is, so I'm asking everyone."**

---

# 5️⃣ STEP 2 — DHCP OFFER

The DHCP server receives the Discover message.

The server can respond with an **Offer**.

The offer can contain network configuration such as:

```text
IP Address
Subnet Mask
Default Gateway
DNS Server
Lease information
```

For example:

```text
DHCP Server
     |
     | DHCP Offer
     ↓
   Client
```

The server is basically saying:

> **"I can give you this IP address and this network configuration."**

---

# 6️⃣ STEP 3 — DHCP REQUEST

The client may receive an offer from one or more DHCP servers.

The client chooses an offer and sends a **DHCP Request**.

Basically:

> **"I want to use the configuration offered by this DHCP server."**

Conceptually:

```text
Client
   |
   | DHCP Request
   ↓
DHCP Server
```

The request also lets the other DHCP servers know that their offers were not selected.

---

# 7️⃣ STEP 4 — DHCP ACKNOWLEDGE

The DHCP server confirms the request.

It sends:

> **DHCP ACK**

Basically:

> **"Okay, you can use this network configuration."**

```text
DHCP Server
     |
     | DHCP ACK
     ↓
   Client
```

Now the client has its network configuration and can communicate using the assigned IP.

---

# 🔥 DORA — MY EASY UNDERSTANDING

```text
DISCOVER
"Is there a DHCP server?"

       ↓

OFFER
"Here is an IP/configuration I can give you."

       ↓

REQUEST
"I want this configuration."

       ↓

ACK
"Okay, you can use it."
```

### 🧠 Interview answer

> **"DHCP automatically provides network configuration to clients. The basic DHCP process is DORA: Discover, Offer, Request and Acknowledge. The client first discovers a DHCP server, the server offers an IP configuration, the client requests the selected offer, and the server acknowledges it."**

---

# 8️⃣ WHICH DORA MESSAGES ARE BROADCAST AND UNICAST?

This is where the interview can go deeper.

The important point is that **the exact destination behavior can depend on the DHCP stage and client/server state**, so I should understand the reason rather than blindly memorize "this is always broadcast."

For the basic process I am learning:

```text
DHCP Discover → Broadcast
DHCP Offer    → Usually Broadcast in the initial exchange
DHCP Request  → Broadcast in the initial exchange
DHCP ACK      → Broadcast or Unicast depending on the situation/client state
```

### Why Discover is Broadcast?

Because the client doesn't know the DHCP server yet.

```text
Client
  |
  | "Who is the DHCP server?"
  ↓
Broadcast
```

### Why can Offer be Broadcast?

The server may still need to communicate with a client that doesn't yet have normal IP communication established.

### Why can Request be Broadcast?

The client is effectively announcing which DHCP offer it accepted.

This also informs other DHCP servers that their offers were not selected.

### Why can ACK be Unicast?

Once the client and server know each other and the client can communicate using the offered configuration, the server can send the final response directly.

### 🧠 What I should remember

> **The main reason for broadcast at the beginning is that the client doesn't yet know the DHCP server and doesn't have normal IP configuration.**

---

# 9️⃣ TYPES OF IP ADDRESS ALLOCATION IN DHCP

DHCP can allocate addresses in different ways.

The important types I should know are:

```text
Dynamic Allocation
Automatic Allocation
Manual / Static Reservation
```

---

## 🔹 1. Dynamic Allocation

The DHCP server gives an IP address to the client for a **lease period**.

For example:

```text
Client → 192.168.1.10
Lease → Temporary
```

When the lease expires, the address can be renewed or eventually returned to the available pool.

This is commonly used for normal client devices.

---

## 🔹 2. Automatic Allocation

The DHCP server automatically assigns an IP address to a client.

Depending on the DHCP implementation, the address may effectively remain associated with that client for future use.

The important idea is:

> **The DHCP server automatically chooses the address instead of me manually configuring it.**

---

## 🔹 3. Manual Allocation / Reservation

Here I can configure the DHCP server to give a particular client a specific IP address based on an identifier such as its MAC address.

For example:

```text
Device MAC
     ↓
DHCP Reservation
     ↓
192.168.1.50
```

This is useful when I want a device to consistently receive the same address while still managing it through DHCP.

---

# 🔟 WILL MY COMPUTER GET THE SAME IP EVERY TIME?

**Not necessarily.**

If I'm using normal dynamic DHCP allocation, the IP address is leased to my device.

For example:

```text
Today:
192.168.1.10

Later:
192.168.1.15
```

It can change depending on the DHCP server's available address pool and lease state.

However, I might repeatedly receive the same address if the DHCP server can still associate that address with my client and it is available.

If I need a predictable IP, I can use a **DHCP reservation** or another appropriate static addressing mechanism.

### 🧠 My interview answer

> **"With normal DHCP dynamic allocation, I cannot assume that my computer will always receive the same IP address. The address is leased. It may be renewed or changed. If I need a consistent address, I can use a DHCP reservation or static configuration."**

---

# 1️⃣1️⃣ APIPA

APIPA stands for:

> **Automatic Private IP Addressing**

APIPA is used when a device configured to use DHCP **cannot obtain an IP address from a DHCP server**.

The device can automatically assign itself an address from:

```text
169.254.0.0/16
```

So the address looks like:

```text
169.254.x.x
```

---

# 🔹 Why does APIPA happen?

Normally:

```text
Computer
   ↓
DHCP Discover
   ↓
DHCP Server
   ↓
IP Address
```

But imagine the DHCP server cannot be reached:

```text
Computer
   ↓
DHCP Discover
   ↓
❌ No DHCP response
```

The computer may assign itself an APIPA address.

```text
Computer
   ↓
169.254.x.x
```

---

# 🔥 What does an APIPA address tell me?

If I see:

```text
169.254.x.x
```

I should immediately think:

> **"The device probably could not obtain its normal IP configuration through DHCP."**

Possible areas to investigate include:

```text
DHCP server
Network connectivity
Cable/Wi-Fi
Switch/network connection
DHCP configuration
```

### 🧠 Important

APIPA is **not the normal address I expect for communication with my wider network or Internet**.

It mainly allows limited local communication scenarios.

---

# 1️⃣2️⃣ HOW DO I CHECK MY DEVICE'S IP, GATEWAY AND DNS?

This is very important for Cloud Support troubleshooting.

## 🪟 Windows

I can use:

```cmd
ipconfig
```

For more detailed information:

```cmd
ipconfig /all
```

I can see information such as:

```text
IPv4 Address
Subnet Mask
Default Gateway
DNS Servers
```

Example:

```text
IPv4 Address . . . . : 192.168.1.10
Subnet Mask . . . . : 255.255.255.0
Default Gateway . . : 192.168.1.1
DNS Servers . . . . : 192.168.1.1
```

---

## 🐧 Linux

I can check the IP address using:

```bash
ip addr
```

or:

```bash
ip a
```

To check the routing/default gateway:

```bash
ip route
```

I can see something similar to:

```text
default via 192.168.1.1
```

That tells me the default gateway.

For DNS configuration, I can inspect the system's configured DNS information, depending on how the Linux system manages DNS.

A common file to inspect is:

```bash
cat /etc/resolv.conf
```

---

# 1️⃣3️⃣ ROUTER AND BROADCAST DOMAIN SEPARATION

A router plays an important role in separating broadcast domains.

Suppose I have:

```text
Network A
   |
 Switch
   |
 Router
   |
 Switch
   |
Network B
```

The router connects the two different networks.

A Layer-2 broadcast from Network A is **not simply forwarded into Network B**.

So:

```text
Broadcast Domain A
        |
      Router
        |
Broadcast Domain B
```

The router acts as the boundary between the two broadcast domains.

### 🧠 My understanding

> **A switch generally keeps devices within the same broadcast domain, while a router separates different broadcast domains.**

This is important because broadcasts should not automatically spread across every network.

---

# 1️⃣4️⃣ DNS QUERY PROCESS

DNS stands for:

> **Domain Name System**

Its main job is:

```text
Domain Name
     ↓
DNS
     ↓
IP Address
```

For example:

```text
www.amazon.com
      ↓
DNS
      ↓
IP Address
```

Now let's understand what happens in more detail.

---

# 1️⃣5️⃣ WHAT HAPPENS WHEN I TYPE `www.amazon.com`?

This is an important interview question because the interviewer can keep asking deeper questions.

I should understand the complete flow.

Suppose I type:

```text
www.amazon.com
```

and press Enter.

---

## STEP 1 — Browser checks its information

The browser may already know the IP address from its cache.

So it first checks available cached DNS information.

If the answer is already available:

```text
www.amazon.com
       ↓
Browser Cache
       ↓
IP Address
```

The browser may not need to perform a complete DNS lookup again.

---

## STEP 2 — Operating system DNS information

If the browser doesn't have the answer, the request can continue through the operating system's DNS resolver mechanisms.

Conceptually:

```text
Browser
   ↓
OS / Resolver
   ↓
DNS Server
```

---

# 1️⃣6️⃣ DNS RESOLVER

The DNS resolver is responsible for finding the IP address.

For example:

```text
www.amazon.com
       ↓
DNS Resolver
```

The resolver may already have the answer cached.

If not, it can query the DNS hierarchy.

---

# 1️⃣7️⃣ DNS HIERARCHY

Conceptually, DNS can be understood as:

```text
Root
  ↓
.com
  ↓
Authoritative DNS
  ↓
amazon.com
  ↓
www
  ↓
IP Address
```

The important idea is that DNS is hierarchical.

The resolver follows the DNS system to find the authoritative answer.

---

# 1️⃣8️⃣ ROOT DNS SERVER

The root is at the top of the DNS hierarchy.

It doesn't normally provide the final IP address for `www.amazon.com`.

Instead, it can direct the resolver toward the appropriate **TLD**, such as:

```text
.com
```

---

# 1️⃣9️⃣ TLD — `.COM`

The `.com` servers are responsible for information about domains under `.com`.

The resolver can be directed toward the authoritative DNS servers for:

```text
amazon.com
```

---

# 2️⃣0️⃣ AUTHORITATIVE DNS SERVER

The authoritative DNS server contains the authoritative DNS information for the domain.

The resolver can finally obtain the record needed for:

```text
www.amazon.com
```

which provides the relevant IP address information.

Then:

```text
www.amazon.com
       ↓
IP Address
```

The resolver returns the result to the client.

---

# 🔥 COMPLETE DNS FLOW

```text
Browser
   ↓
Browser DNS Cache
   ↓
OS / Resolver
   ↓
DNS Resolver
   ↓
Root
   ↓
.com
   ↓
Authoritative DNS
   ↓
www.amazon.com
   ↓
IP Address
   ↓
Browser
```

### 🧠 Important interview point

The DNS resolver may use **cache** and therefore may not need to contact every level every time.

So I should say:

> **"Conceptually the DNS hierarchy involves the root, TLD and authoritative servers, but caching can allow the resolver to return an answer without querying all of them every time."**

---

# 2️⃣1️⃣ DNS USES WHICH PORT?

DNS commonly uses:

```text
UDP 53
```

It can also use:

```text
TCP 53
```

So:

```text
DNS
├── UDP 53 → commonly
└── TCP 53 → when required
```

---

# 2️⃣2️⃣ WHAT ARE PORTS AND PORT NUMBERS?

An IP address helps identify a **host/interface**.

But one computer can run many applications at the same time.

For example:

```text
Browser
SSH
DNS
Web Server
Database
```

If traffic arrives at the computer, how does the operating system know which application should receive it?

This is where **port numbers** help.

A port number identifies the service/application endpoint associated with network traffic.

---

# 🔹 Example

Suppose I have:

```text
Server IP = 10.0.1.10
```

The same server can have:

```text
10.0.1.10:22   → SSH
10.0.1.10:80   → HTTP
10.0.1.10:443  → HTTPS
```

So I can think of it like:

```text
IP Address → Which machine/interface?
Port       → Which service/application endpoint?
```

---

# 2️⃣3️⃣ COMMON PORT NUMBERS

The important ones I should remember for Cloud Support are:

| Port | Protocol/Service |
| ---: | ---------------- |
|   22 | SSH              |
|   53 | DNS              |
|   80 | HTTP             |
|  443 | HTTPS            |

I may also see application-specific ports such as:

```text
8080
```

depending on the application.

---

# 2️⃣4️⃣ DO DIFFERENT BROWSER TABS USE DIFFERENT PORT NUMBERS?

This is a very important question.

The answer is:

> **The destination service port does not change just because I open another browser tab.**

For example, HTTPS traffic to a web server normally goes to:

```text
Destination Port = 443
```

Whether I have:

```text
Tab 1 → Website
Tab 2 → Website
Tab 3 → Website
```

the destination service can still be:

```text
TCP 443
```

### Then how are different connections identified?

TCP connections are identified using connection information including:

```text
Source IP
Source Port
Destination IP
Destination Port
Protocol
```

A browser can therefore have multiple simultaneous connections to the same destination service while using different **source/ephemeral ports**.

For example:

```text
Connection 1:
Source Port      → 50001
Destination Port → 443

Connection 2:
Source Port      → 50002
Destination Port → 443

Connection 3:
Source Port      → 50003
Destination Port → 443
```

So:

```text
Destination port → 443
Source ports     → Can be different
```

### 🧠 My easy memory

> **Server's service port stays the same. Client-side source ports can be different for separate connections.**

Also, one browser tab does not necessarily equal exactly one TCP connection. A browser can create multiple connections depending on the situation.

---

# 2️⃣5️⃣ TCP THREE-WAY HANDSHAKE — IN DETAIL

TCP is:

> **Connection-oriented and reliable.**

Before normal TCP data transfer begins, TCP establishes a connection using the **three-way handshake**.

```text
Client                         Server

   |                              |
   |-------- SYN ---------------->|
   |                              |
   |<------- SYN-ACK -------------|
   |                              |
   |-------- ACK ---------------->|
   |                              |
```

Let's understand each one.

---

# 2️⃣6️⃣ STEP 1 — SYN

The client wants to establish a TCP connection.

It sends:

```text
SYN
```

The client is essentially saying:

> **"I want to establish a TCP connection."**

The SYN also contains information such as the client's initial sequence number.

---

# 2️⃣7️⃣ STEP 2 — SYN-ACK

The server receives the SYN.

It responds:

```text
SYN + ACK
```

This means:

> **"I received your request, and I also want to establish the connection."**

The server sends its own initial sequence number and acknowledges the client's SYN.

---

# 2️⃣8️⃣ STEP 3 — ACK

The client receives the server's SYN-ACK.

It sends:

```text
ACK
```

This acknowledges the server's SYN.

Now:

```text
TCP Connection Established
```

and normal data transfer can begin.

---

# 2️⃣9️⃣ WHY THREE STEPS?

The handshake allows both sides to establish that:

```text
Client ↔ Server
```

can communicate and allows both sides to synchronize their initial sequence-number state.

The important idea is:

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

# 3️⃣0️⃣ SEQUENCE NUMBERS

TCP needs to keep track of data.

That's why TCP uses **sequence numbers**.

Imagine I send:

```text
Data A
Data B
Data C
```

TCP needs a way to track the position/order of the bytes.

Conceptually:

```text
Data A → Sequence
Data B → Sequence
Data C → Sequence
```

This helps TCP understand:

```text
What data was sent?
What order should it be in?
What data is missing?
```

---

# 3️⃣1️⃣ ACKNOWLEDGEMENT NUMBERS

TCP also uses acknowledgement numbers.

The ACK tells the sender what data has been received and what is expected next.

For example, conceptually:

```text
Sender
  |
  | Data
  ↓
Receiver
  |
  | ACK
  ↓
Sender
```

The acknowledgement number indicates the next sequence number the receiver expects.

---

# 3️⃣2️⃣ SIMPLE SEQUENCE + ACK EXAMPLE

Suppose the sender sends:

```text
SEQ = 1000
```

and the segment contains:

```text
100 bytes
```

Then the receiver has received bytes through:

```text
1099
```

and would conceptually acknowledge:

```text
ACK = 1100
```

Meaning:

> **"I have received up to the previous byte and I expect byte 1100 next."**

This is the important relationship I should understand.

---

# 3️⃣3️⃣ WHAT IF A PACKET/SEGMENT IS LOST?

Suppose:

```text
Segment 1 → received
Segment 2 → LOST
Segment 3 → received
```

The receiver can indicate that it is still waiting for the missing data.

TCP can then retransmit the missing data.

Conceptually:

```text
Sender
  ↓
Segment 1 → Receiver
  ↓
Segment 2 → ❌ Lost
  ↓
Segment 3 → Receiver
  ↓
ACK indicates missing/expected data
  ↓
Retransmission
```

This is one reason TCP is considered reliable.

---

# 3️⃣4️⃣ WHAT IS SSL?

SSL stands for:

> **Secure Sockets Layer**

SSL was the older security protocol used for secure communication.

Modern secure communication uses:

> **TLS — Transport Layer Security**

So when people say:

> **"SSL certificate"**

they are often referring to certificates used with modern TLS-based secure communication.

---

# 3️⃣5️⃣ WHY DO WE NEED TLS?

Without encryption, sensitive information could potentially be exposed while travelling across the network.

For example:

```text
Username
Password
Payment information
Session information
```

TLS helps provide:

```text
Encryption
Authentication
Integrity
```

So:

> **TLS helps me communicate securely with the intended server.**

---

# 3️⃣6️⃣ DIGITAL CERTIFICATE

A digital certificate helps establish the identity of the server and associates that identity with a cryptographic public key.

When I visit:

```text
https://example.com
```

the server presents a certificate during the TLS process.

The browser checks things such as whether the certificate is valid and trusted.

The important idea for me is:

```text
Certificate
     ↓
Server identity
     +
Public key information
```

---

# 3️⃣7️⃣ TLS HANDSHAKE — HIGH LEVEL

The exact handshake depends on the TLS version, so I should not memorize one old handshake as if it applies to every modern TLS connection.

At a high level:

```text
Client
  |
  | TLS negotiation
  ↓
Server
  |
  | Certificate / security information
  ↓
Client
  |
  | Verify / establish security parameters
  ↓
Secure session
```

After the handshake:

```text
TCP Connection
      ↓
TLS Handshake
      ↓
Secure Session
      ↓
HTTPS Data
```

---

# 3️⃣8️⃣ TCP + TLS + HTTPS

This sequence is extremely important.

For the traditional HTTPS-over-TCP flow I am learning:

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

> **TCP establishes the transport connection first. TLS then establishes the secure communication. HTTPS application data is exchanged after that.**

---

# 3️⃣9️⃣ PROBLEM ON IP ADDRESSING

Now I need to understand IP addressing between:

```text
Sender
Gateway
Destination
```

Suppose:

```text
Sender:
10.0.1.10/24

Gateway:
10.0.1.1/24

Destination:
10.0.2.20/24
```

First I check the sender's subnet.

```text
Sender subnet:
10.0.1.0/24
```

Destination:

```text
10.0.2.20
```

is not in:

```text
10.0.1.0/24
```

Therefore, the destination is on another network.

The sender needs to use the default gateway.

```text
Sender
10.0.1.10
    |
    ↓
Gateway
10.0.1.1
    |
    ↓
Destination
10.0.2.20
```

---

# 4️⃣0️⃣ WHAT DOES THE SENDER CHECK?

The sender checks:

```text
My IP
My subnet mask
Destination IP
```

It determines whether the destination is:

```text
Same subnet
      OR
Different subnet
```

### Same subnet

The sender can communicate directly on the local network.

### Different subnet

The sender sends the traffic toward its:

> **Default Gateway**

---

# 4️⃣1️⃣ WHAT DOES THE GATEWAY DO?

The gateway/router receives the packet.

It looks at the:

```text
Destination IP
```

Then checks its routing table.

For example:

```text
Destination Network       Next Hop/Target

10.0.2.0/24               ...
0.0.0.0/0                 ...
```

It chooses the appropriate route and forwards the packet toward the destination.

---

# 4️⃣2️⃣ PACKET TRACING

Packet tracing means:

> **Following the path of traffic from the source to the destination and identifying where the communication fails.**

This is extremely important for Cloud Support.

Instead of saying:

> "The server is not reachable."

I should ask:

> **"At which point is the traffic failing?"**

---

# 4️⃣3️⃣ BASIC PACKET FLOW

Suppose:

```text
Sender
10.0.1.10
     |
     ↓
Gateway
10.0.1.1
     |
     ↓
Router
     |
     ↓
Destination
10.0.2.20
```

I can trace the communication step by step.

```text
Sender
 ↓
Local network
 ↓
Gateway
 ↓
Route
 ↓
Destination network
 ↓
Destination
```

At each stage I ask:

```text
Can the traffic reach this point?
```

---

# 4️⃣4️⃣ WHAT SHOULD I CHECK DURING PACKET TRACING?

I can follow this order:

```text
Source IP
   ↓
Destination IP
   ↓
Subnet
   ↓
Default Gateway
   ↓
Route
   ↓
Security rules
   ↓
Port
   ↓
Destination server
   ↓
Application
```

If communication fails, I try to identify the exact stage.

---

# 4️⃣5️⃣ PACKET TRACING EXAMPLE

Suppose:

```text
EC2-A
10.0.1.10
   ↓
EC2-B
10.0.2.20
```

EC2-A cannot communicate with EC2-B.

I don't immediately say:

> "EC2-B is down."

Instead I troubleshoot:

### Step 1 — Check IP

```text
Is EC2-A using the correct IP?
Is EC2-B using the correct IP?
```

### Step 2 — Check subnet

```text
Which subnet is each instance in?
```

### Step 3 — Check routing

```text
Is there a route from
10.0.1.0/24
to
10.0.2.0/24?
```

### Step 4 — Check gateway/next hop

```text
Is the traffic being sent toward
the correct next hop?
```

### Step 5 — Check security

```text
Security Group?
NACL?
Host firewall?
```

### Step 6 — Check port

For example:

```text
SSH → 22
HTTP → 80
HTTPS → 443
```

### Step 7 — Check service

Is the service actually listening?

For example:

```bash
ss -lntp
```

### Step 8 — Check application/logs

If the network path and port are working, then I move toward the application and logs.

---

# 4️⃣6️⃣ USEFUL COMMANDS FOR PACKET TRACING

## Windows

I can use:

```cmd
ipconfig
```

to check IP configuration.

```cmd
tracert <destination>
```

to trace the path toward a destination.

I can also use:

```cmd
ping <destination>
```

to test basic reachability.

---

## Linux

Check IP:

```bash
ip addr
```

Check routing:

```bash
ip route
```

Test reachability:

```bash
ping <destination>
```

Trace route:

```bash
traceroute <destination>
```

or, depending on the system:

```bash
tracepath <destination>
```

Check listening ports:

```bash
ss -lntp
```

---

# 4️⃣7️⃣ HOW I SHOULD THINK AS A CLOUD SUPPORT ENGINEER

Suppose a customer says:

> **"My application is not reachable."**

I should not randomly check things.

I should follow the path:

```text
Customer Problem
       ↓
Source IP
       ↓
Destination IP
       ↓
Subnet
       ↓
Route
       ↓
Gateway / Next Hop
       ↓
Security Group / NACL / Firewall
       ↓
Port
       ↓
Server
       ↓
Service
       ↓
Application
       ↓
Logs
```

This gives me a structured troubleshooting method.

---

# 🏆 FINAL REVISION

## DHCP

```text
Dynamic Host Configuration Protocol
→ Automatically provides network configuration
```

## DORA

```text
Discover
Offer
Request
Acknowledge
```

## APIPA

```text
Automatic Private IP Addressing
→ 169.254.x.x
→ Commonly indicates DHCP configuration could not be obtained
```

## DHCP Allocation

```text
Dynamic
Automatic
Manual/Reservation
```

## Same IP every time?

```text
Not guaranteed with normal dynamic DHCP.
Reservation/static configuration can provide predictable addressing.
```

## Broadcast Domain

```text
Area where Layer-2 broadcasts can reach
```

## Router

```text
Separates broadcast domains
Connects different networks
Uses IP/routing
```

## DNS

```text
Domain
 ↓
DNS
 ↓
IP
```

## DNS hierarchy

```text
Root
 ↓
TLD (.com)
 ↓
Authoritative DNS
 ↓
Domain/record
 ↓
IP
```

## Ports

```text
IP → Host/interface
Port → Service/application endpoint
```

Important:

```text
22  → SSH
53  → DNS
80  → HTTP
443 → HTTPS
```

## Browser connections

```text
Destination HTTPS port → 443
Client source ports → Can be different
```

## TCP

```text
SYN
 ↓
SYN-ACK
 ↓
ACK
 ↓
Connection established
```

## TCP reliability

```text
Sequence Numbers
      +
ACK Numbers
      +
Retransmission
```

## TLS

```text
TLS → Transport Layer Security
```

Provides:

```text
Encryption
Authentication
Integrity
```

## Digital Certificate

```text
Helps establish server identity
+
Associates identity with public-key information
```

## Packet tracing

```text
Source
 ↓
Subnet
 ↓
Gateway
 ↓
Route
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
```

---

# 🔥 MOST IMPORTANT INTERVIEW FLOWS

## DHCP

```text
Client
  ↓
DHCP Discover
  ↓
DHCP Offer
  ↓
DHCP Request
  ↓
DHCP ACK
  ↓
IP Configuration
```

## DNS

```text
www.amazon.com
       ↓
Browser Cache
       ↓
OS / Resolver
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

## HTTPS

```text
Domain
 ↓
DNS
 ↓
IP
 ↓
TCP 3-Way Handshake
 ↓
TLS Handshake
 ↓
HTTPS Request
 ↓
Server
 ↓
HTTPS Response
```

## Packet tracing

```text
Source
 ↓
Destination
 ↓
Same subnet?
 ↓
Gateway
 ↓
Route
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
```

---

# 🧠 MY FINAL UNDERSTANDING

I don't want to remember these as completely separate topics.

They are connected.

For example, when my computer joins a network:

```text
DHCP
 ↓
I get IP + Subnet + Gateway + DNS
```

When I type:

```text
www.amazon.com
```

then:

```text
DNS
 ↓
I get the destination IP
```

Then:

```text
IP + Subnet
 ↓
I determine whether the destination is local
```

If it is remote:

```text
Default Gateway
 ↓
Routing
 ↓
Destination
```

Then for HTTPS:

```text
TCP 443
 ↓
TCP Handshake
 ↓
TLS Handshake
 ↓
HTTPS
```

If something doesn't work, I reverse the flow and troubleshoot:

```text
DNS
 ↓
IP
 ↓
Subnet
 ↓
Gateway
 ↓
Route
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
```

> **This is how I want to think about networking: not as memorized definitions, but as a complete flow where I can understand what happens at every step and identify exactly where the problem is.**
