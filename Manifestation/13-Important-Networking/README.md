<div align="center">

# 🔥 Important NETWORKING TOPICS

### My Easy Cloud Support + Networking Notes

</div>

These are the remaining networking topics from my teacher's sheet.

I already learned the main networking concepts, so here I am focusing on the **extra topics that I need to understand properly for Cloud Support and interviews**.

---

# 1️⃣ HOW DO I REACH AMAZON / A WEBSITE?

This is one of the most important flows to understand.

Suppose I type:

```text
https://maps.google.com
```

in my browser and press **Enter**.

A lot of things happen behind the scenes.

---

## Step 1 — My PC Gets Network Information

When my computer starts, it needs:

* Its own IP address
* DNS server address
* Default gateway
* Subnet information

This information is obtained using **DHCP** through the **DORA process**.

```text
PC Boots
   ↓
DHCP
   ↓
DORA
   ↓
IP + DNS + Gateway + Subnet
```

So before my computer can communicate properly, it needs basic network configuration.

---

# Step 2 — Browser Checks DNS Cache

I type:

```text
maps.google.com
```

But my computer needs the **IP address** of that website.

So the browser first checks whether it already knows the IP from its DNS cache.

There are several places where the DNS information may already be cached.

---

## 1. Browser Cache

First, the browser checks its own DNS cache.

The browser keeps DNS records for websites I have previously visited for a certain period of time.

```text
Browser
   ↓
DNS Cache
   ↓
Found?
```

If the IP is already there, the browser can use it.

---

## 2. OS Cache

If the browser doesn't have the DNS record, the browser asks the operating system.

The OS can also maintain its own DNS cache.

```text
Browser Cache
     ↓
Not Found
     ↓
OS DNS Cache
```

---

## 3. Router Cache

If the OS also doesn't have the record, the request can reach the router.

The router may have its own DNS cache.

```text
Browser
   ↓
OS
   ↓
Router
   ↓
DNS Cache
```

---

## 4. ISP Cache

If the DNS record isn't found locally, the request goes to the ISP's DNS server.

The ISP may already have the DNS record cached.

```text
Browser
   ↓
OS
   ↓
Router
   ↓
ISP DNS Cache
```

Caching is useful because it helps reduce network traffic and can make DNS lookups faster.

---

# Step 3 — DNS Query

If the IP address still isn't found in the caches, the ISP's DNS server starts a DNS query.

The purpose is simple:

> **Find the IP address of the server hosting the requested website.**

```text
maps.google.com
       ↓
      DNS
       ↓
   IP Address
```

---

# Step 4 — Recursive DNS Search

If the DNS server doesn't already know the answer, it searches other DNS servers.

This is called a **recursive search**.

The search continues through DNS servers until:

```text
Correct IP Found
      OR
Error returned
```

---

# Step 5 — DNS Recursor and Name Servers

The ISP's DNS server acts as a **DNS recursor**.

Its job is to find the correct IP address by asking other DNS servers.

The other DNS servers are called **name servers**.

A domain can have different levels.

For example:

```text
maps.google.com
```

can be thought of as:

```text
maps        → Third-level domain
google      → Second-level domain
.com        → Top-level domain
```

Each level has name servers involved in the DNS lookup.

---

# Step 6 — DNS Lookup Path

For:

```text
maps.google.com
```

the DNS lookup can conceptually happen like this:

```text
DNS Recursor
     ↓
Root Name Server
     ↓
.com Name Server
     ↓
google.com Name Server
     ↓
maps.google.com
     ↓
IP Address
```

The result is then returned:

```text
Name Server
     ↓
DNS Recursor
     ↓
Browser
```

Now my browser knows the IP address.

---

# Step 7 — DNS Packets Travel Through the Network

The DNS requests themselves travel as small packets.

These packets contain information such as:

* Request information
* Destination IP address

The packets can pass through multiple networking devices.

Those devices use **routing tables** to decide where the packet should go next.

```text
Client
  ↓
Router
  ↓
Router
  ↓
DNS Server
```

If packets are lost, the DNS request can fail.

If everything works:

```text
DNS Request
    ↓
DNS Server
    ↓
Correct IP
    ↓
Browser
```

---

# Step 8 — Browser Starts TCP Connection

Now my browser has the correct IP address.

The browser can start a connection with the server.

For HTTP-based communication, TCP is commonly used.

```text
Browser
   ↓
Server IP
   ↓
TCP Connection
```

---

# Step 9 — TCP 3-Way Handshake

Before transferring data, TCP establishes a connection.

The process is:

```text
Client              Server

  SYN  ------------>

       <------------ SYN-ACK

  ACK  ------------>
```

### Step 1 — SYN

The client sends a **SYN** packet.

Basically:

> "Can we establish a connection?"

### Step 2 — SYN-ACK

The server responds with:

> "Yes, I received your request and I'm ready."

### Step 3 — ACK

The client sends an ACK.

Now:

```text
TCP Connection Established
```

Data can be transferred.

---

# Step 10 — Browser Sends HTTP Request

Once TCP is established, the browser sends an HTTP request.

For example, it may send a:

```text
GET
```

request to ask for a web page.

If I submit a form or send credentials, a:

```text
POST
```

request may be used.

The request can also contain information such as:

* Browser information
* What type of response the browser accepts
* Connection information
* Cookies

---

# Step 11 — Web Server Handles the Request

The server has a web server such as:

```text
Apache
IIS
```

The web server receives the request.

It passes the request to a request handler/program.

That program processes things such as:

* Request
* Headers
* Cookies
* What the user requested

It can then generate a response.

The response can be in formats such as:

```text
HTML
JSON
XML
```

---

# Step 12 — Server Sends HTTP Response

The server sends the response back to my browser.

The response can contain:

* Requested web page
* Status code
* Compression information
* Cache information
* Cookies
* Other response information

---

# Step 13 — HTTP Status Codes

The first part of an HTTP response contains a status code.

I should remember the five groups:

| Code    | Meaning           |
| ------- | ----------------- |
| **1xx** | Informational     |
| **2xx** | Success           |
| **3xx** | Redirect          |
| **4xx** | Client-side error |
| **5xx** | Server-side error |

### Easy memory

```text
1xx → Information
2xx → Success
3xx → Redirect
4xx → Client problem
5xx → Server problem
```

---

# Step 14 — Browser Displays the Page

The browser receives the HTML and starts displaying the page.

First, it renders the basic HTML structure.

Then it finds additional resources such as:

```text
Images
CSS
JavaScript
```

The browser sends additional GET requests for these resources.

Some of these files are cached so that they don't need to be downloaded again the next time.

Finally:

```text
Web Page
   ↓
Displayed in Browser
```

---

# 🔥 COMPLETE WEBSITE FLOW

This is the flow I should remember:

```text
PC Boots
   ↓
DHCP
   ↓
IP + DNS + Gateway + Subnet
   ↓
Browser DNS Cache
   ↓
OS DNS Cache
   ↓
Router Cache
   ↓
ISP DNS Cache
   ↓
DNS Recursor
   ↓
Root Name Server
   ↓
.com Name Server
   ↓
Authoritative Name Server
   ↓
IP Address
   ↓
Routing
   ↓
TCP 3-Way Handshake
   ↓
HTTP Request
   ↓
Web Server
   ↓
HTTP Response
   ↓
Browser
   ↓
Web Page
```

### 🧠 My one-line understanding

> **First I get network configuration using DHCP, then DNS finds the server IP, routing gets the packets there, TCP establishes the connection, HTTP carries the request, and the server sends the response back.**

---

# 2️⃣ PACKET FLOW AT EACH OSI LAYER

Now I want to understand what happens to the data as it moves through the OSI layers.

There are two directions:

```text
DOWNSTREAM
Source → Destination

UPSTREAM
Destination → Source
```

---

# 🔽 DOWNSTREAM — SOURCE SIDE

## Layer 7 — Application

The application creates the HTTP request.

The request is passed down to the transport layer for further processing.

```text
Application
    ↓
HTTP Data
```

---

## Layer 6 — Presentation

This layer deals with how the data is represented.

Examples:

```text
ASCII → Text
JPEG  → Image
```

---

## Layer 5 — Session

The session layer manages communication sessions.

It can:

```text
Establish
Maintain
End
```

the session between local and remote applications.

---

## Layer 4 — Transport

The transport layer receives the application data.

It adds a:

```text
TCP / UDP Header
```

This forms a **segment**.

It also adds:

```text
Source Port
Destination Port
```

Example:

```text
Application Data
      ↓
TCP Header
      ↓
Segment
```

---

## Layer 3 — Network

The network layer receives the segment.

It adds an IP header.

Now we have an:

```text
IP Packet
```

The IP packet contains:

```text
Source IP
Destination IP
```

DNS is used to translate the domain name into an IP address.

Then routing determines the outgoing interface/NIC.

```text
Segment
   ↓
IP Header
   ↓
IP Packet
```

---

## Layer 2 — Data Link

The Data Link layer receives the IP packet.

It adds an Ethernet header and trailer.

Now we have a:

```text
Frame
```

The frame contains:

```text
Source MAC
Destination MAC
```

ARP can be used to determine the required local MAC address.

The frame is then forwarded to the next hop.

```text
IP Packet
   ↓
Ethernet Header + Trailer
   ↓
Frame
```

---

## Layer 1 — Physical

The Physical layer receives the frame.

It converts the frame into:

```text
Bits
```

Then the bits are encoded into signals depending on the medium:

```text
Copper
Wireless
Fiber
```

The signals are transmitted through the network.

---

# 🔼 UPSTREAM — DESTINATION SIDE

Now the data reaches the destination.

The process happens in the opposite direction.

---

## Layer 1 — Physical

The physical layer receives the signals.

It converts the signals into bits/frame information and passes them to Layer 2.

---

## Layer 2 — Data Link

The Data Link layer receives the frame.

It performs a **Frame Check Sequence (FCS)** check for errors.

If no error is found:

```text
Frame
  ↓
Remove MAC information
  ↓
IP Packet
```

The IP packet is passed to Layer 3.

---

## Layer 3 — Network

The network layer reads:

```text
Source IP
Destination IP
```

It checks the routing table.

It compares the destination IP with known routes/subnets.

Then it sends the IP packet through the correct interface.

---

## Layer 4 — Transport

The transport layer receives the segment.

It checks the:

```text
TCP / UDP
Source Port
Destination Port
```

The destination port tells the system which application/service should receive the data.

For example:

```text
Port 80
   ↓
HTTP Service
```

---

## Layer 7 — Application

Finally, the application receives the request.

The application processes the request and performs whatever action is required.

```text
Physical
   ↑
Data Link
   ↑
Network
   ↑
Transport
   ↑
Application
```

---

# 🧠 EASY ENCAPSULATION MEMORY

As data goes down:

```text
Application Data
      ↓
Segment
      ↓
IP Packet
      ↓
Frame
      ↓
Bits / Signals
```

So I remember:

> **Data → Segment → Packet → Frame → Bits**

---

# 3️⃣ LINUX COMMAND TO CHECK OPEN PORTS

One command mentioned by my teacher is:

```bash
netstat
```

To check which process is using port 80:

```bash
netstat -an | grep ':80'
```

This helps identify information related to port 80.

Important options:

```text
-i → Interfaces
-a → All
```

---

# 4️⃣ HOW I WOULD TROUBLESHOOT A SLOW WEBSITE

If a user tells me:

> **"The website is very slow."**

I shouldn't immediately assume that the server is slow.

First, I would ask:

> **"Is everything on the computer slow, or only this particular application?"**

---

## Case 1 — Only One Application Is Slow

If only one application is slow, I would focus on that application.

---

## Case 2 — Everything Is Slow

Then I would check common causes such as:

* Scheduled antivirus scans
* Free disk space
* RAM usage
* System resource usage
* Updates being deployed

---

# Three Main Areas That Could Be Slow

At a high level, I can think of three areas:

```text
1. My Computer
2. Internet Connection
3. Server
```

---

## 1. My Computer

The computer itself could be slow because of:

* Antivirus scan
* A process using high CPU/network
* Full HDD
* Virus infection
* Other system problems

---

## 2. Internet Connection

The network connection could be slow because of:

* Slow proxy
* Slow ISP
* Routing to a different geographic location
* Other network-related problems

---

## 3. Server

The server could be slow because of:

* DoS attack
* Some instances being unavailable
* Large increase in users
* Festival season / sale / new offering
* Server running out of space
* Data center networking issue
* Slow or unavailable partner servers

---

# 🔹 Check Network Latency

A simple:

```bash
ping
```

test can help check how long network traffic takes to reach the server.

---

# 🔹 Use `tracert`

On Windows:

```cmd
tracert 8.8.8.8
```

This shows the path taken from my computer to the destination.

If many hops are failing, it may indicate network problems along the route.

---

# 5️⃣ NETWORK DROP TROUBLESHOOTING

If my network suddenly drops, I would check things step by step.

### Step 1

Check:

```text
LAN cable
Router
Wi-Fi
```

Make sure the physical connection is okay.

---

### Step 2

Run the network troubleshooter.

---

### Step 3

Check whether I have a valid IP address:

```cmd
ipconfig
```

---

### Step 4

Try:

```cmd
ping 8.8.8.8
```

and:

```cmd
tracert 8.8.8.8
```

---

## What Does `ping 8.8.8.8` Do?

It sends ICMP packets toward Google's address.

If it fails, the output can help indicate where the problem may be.

---

## What Does `tracert` Do?

It shows the path step by step.

```text
Computer
   ↓
Hop 1
   ↓
Hop 2
   ↓
Hop 3
   ↓
Destination
```

If the failure happens very early in the path, the issue may be closer to my local network.

---

# 6️⃣ PACKET LOSS

Packet loss means packets are being lost somewhere along the communication path.

---

## Step 1 — Test With Ping

Use:

```cmd
ping -n 20 8.8.8.8
```

If needed, I can increase the number of packets for a longer test.

Important:

> This tests ICMP behavior. It does not necessarily prove that every other type of traffic has the same packet-loss behavior.

---

## Step 2 — Find Where Loss Starts

Use:

```cmd
tracert -d 8.8.8.8
```

The `-d` option prevents hostname resolution and shows the hops as IP addresses.

This helps identify where packet loss may begin.

---

## Step 3 — Use MTR

For a more continuous test, I can use:

```text
MTR
```

MTR combines ideas from:

```text
Ping + Traceroute
```

It can show the percentage of loss at different hops.

---

# 🔥 If Packet Loss Starts at the First Hop

Traceroute mainly shows Layer 3 devices such as routers.

But the first hop might require traffic to pass through:

```text
Wireless AP
   ↓
Switch
   ↓
Router
```

So I may need additional tests.

---

## Test 1 — Ping the Access Point

This checks wireless quality.

If packet loss starts here:

> I should investigate wireless performance.

---

## Test 2 — Ping a Client on the Same VLAN

If possible, ping a client connected to the same VLAN.

If multiple switches exist, repeat the test as needed.

If loss starts here, possible causes include:

* Speed/duplex mismatch
* Bad cable

---

## Test 3 — Connect Directly to Router/Firewall

Connect a client directly to the router/firewall on the same VLAN and test from the wireless client.

If loss begins here, possible causes include:

* Speed/duplex mismatch
* Bad cable

---

# 7️⃣ DUPLEX MISMATCH

A duplex mismatch happens when the two ends of a link are using different speed/duplex settings.

Example:

```text
Device A → 100 Mbps / Half Duplex

Device B → 1000 Mbps / Full Duplex
```

This mismatch can cause some or all traffic to be lost.

### How to fix it?

Both sides should use matching settings.

Ideally:

```text
Both sides
    ↓
Auto Speed
    +
Auto Duplex
```

If one side is manually configured, the other side should use the same settings.

---

# 8️⃣ LINK CONGESTION

Link congestion means too much traffic is trying to use a link.

Example:

```text
Traffic = 60 Mbps

Link Capacity = 20 Mbps
```

The link cannot handle all the traffic.

So it becomes a bottleneck and some traffic can be dropped.

```text
Too much traffic
       ↓
Bottleneck
       ↓
Packet drops
```

---

# 9️⃣ FIREWALL BLOCKING TRAFFIC

Sometimes packet loss doesn't happen for all types of traffic.

A firewall may block specific traffic.

For example:

```text
Website A → Works
Website B → Fails
```

or:

```text
Service A → Works
Service B → Fails
```

If there is a firewall between the two locations, I should check whether it is blocking the traffic.

---

# 🔟 BAD CABLE / LOOSE CONNECTION

A damaged or badly terminated cable can cause an incomplete or incorrect electrical signal.

Possible solution:

```text
Old Cable
   ↓
Replace / Test Cable
```

This helps eliminate the cable as the cause.

---

# 1️⃣1️⃣ STATIC ROUTING VS DYNAMIC ROUTING

This is an important routing comparison.

| Static Routing                            | Dynamic Routing                                    |
| ----------------------------------------- | -------------------------------------------------- |
| Routes configured manually                | Routes are learned/updated automatically           |
| Routes are user-defined                   | Routes can change with topology                    |
| Doesn't use complex routing algorithms    | Uses routing algorithms                            |
| Good for smaller networks                 | Suitable for larger networks                       |
| Link failure requires manual intervention | Can reroute after topology changes                 |
| No routing advertisements                 | Uses routing advertisements                        |
| No routing protocol required              | Uses protocols such as RIP, EIGRP, BGP             |
| Requires fewer additional resources       | Uses additional resources such as memory/bandwidth |

---

## Easy Example

### Static

I manually tell the router:

```text
Network X
   ↓
Use Router Y
```

### Dynamic

The routing protocol learns routes and updates them when the network changes.

```text
Network Change
     ↓
Routing Protocol
     ↓
Route Updated
```

---

# 1️⃣2️⃣ TRACEROUTE

Traceroute helps me find the path between my computer and a destination.

Suppose:

```text
My Computer
     ↓
Router 1
     ↓
Router 2
     ↓
Router 3
     ↓
Server
```

Traceroute can show the devices/hops in between.

This helps me find where communication may be failing.

---

# How Does Traceroute Work?

Traceroute uses the **TTL — Time To Live** field in the IP packet.

TTL helps prevent packets from being forwarded forever in a routing loop.

Each router decreases TTL by 1.

```text
TTL = 3

Router 1 → 2
Router 2 → 1
Router 3 → 0
```

When TTL becomes zero, the packet is discarded.

Traceroute uses this behavior to discover the path.

---

## Windows vs Linux

The teacher material mentions:

```text
Windows → ICMP
Linux   → UDP
```

for traceroute behavior.

---

## Windows

```cmd
tracert -d 8.8.8.8
```

`-d` means:

> Don't resolve hostnames to IP addresses.

---

## Linux Traceroute Options

### `-i`

Specifies the interface through which traceroute should run.

```text
-i
```

By default, the routing table determines the outgoing interface.

---

### `-I`

Uses ICMP Echo instead of UDP datagrams.

---

### `-s`

Chooses an alternative source address.

---

### `-t`

Specifies the Type of Service value.

The value can be from:

```text
0–255
```

It can be used to check whether different service values result in different paths.

---

# 1️⃣3️⃣ ICMP

ICMP stands for:

> **Internet Control Message Protocol**

It is generally considered a **Layer 3 protocol**.

ICMP is commonly used for network troubleshooting.

Examples:

```text
ping
traceroute
```

---

## ICMP Packet

ICMP messages are carried inside IP packets.

An ICMP header contains:

```text
Type
Code
Checksum
```

---

## Important ICMP Types

```text
Type 8 → Echo Request
Type 0 → Echo Reply
Type 3 → Destination Unreachable
```

---

## Destination Unreachable Codes

Some important codes from the notes:

```text
0 → Network Unreachable
1 → Host Unreachable
6 → Destination Network Unknown
7 → Destination Host Unknown
```

### Network Unreachable

The router doesn't have a forwarding path to the destination network.

### Host Unreachable

A route to the directly connected destination network exists, but the destination host cannot be reached.

---

## Checksum

The checksum is used to check whether the ICMP header is corrupted.

---

# 1️⃣4️⃣ PING

If ping works, it tells me that the basic physical, Data Link and Network layers along the tested path are functioning for that ICMP communication.

But:

> **Ping working does NOT mean the application will work.**

For example:

```text
Ping → Works
TCP Port 80 → Blocked
```

The website can still fail.

Possible reasons:

* Firewall
* Access-list
* Port blocked
* Web server not listening on port 80

---

# 1️⃣5️⃣ MTR — MY TRACEROUTE

MTR combines the functionality of:

```text
Ping
+
Traceroute
```

It is useful for troubleshooting network connectivity.

MTR can provide information about:

1. Connectivity to destination
2. Packet loss
3. Round-trip time

---

## How MTR Works

MTR sends a series of packets and discovers the path hop by hop.

```text
Source
  ↓
Hop 1
  ↓
Hop 2
  ↓
Hop 3
  ↓
Destination
```

It also collects information about intermediate hosts.

---

## Install MTR

The teacher material gives:

```bash
sudo apt-get install mtr
```

Generate a report:

```bash
sudo mtr --report google.com
```

---

## Important Point About MTR

The route from:

```text
A → B
```

may not be the same as:

```text
B → A
```

So for network problems, MTR reports in **both directions** can be useful.

---

# 1️⃣6️⃣ DHCP PORTS

DHCP uses:

```text
UDP 67
UDP 68
```

The DHCP server uses:

```text
UDP 67
```

The DHCP client uses:

```text
UDP 68
```

The teacher notes the destination IP as:

```text
255.255.255.255
```

for the DHCP broadcast communication described.

---

# 1️⃣7️⃣ BANDWIDTH, DELAY & LATENCY

These three words are easy to confuse.

---

## 🔹 Latency

Latency is basically the **time taken to complete an operation**.

Simple example:

Imagine I am waiting at a traffic signal.

The time I spend waiting is like latency.

In networking, it is the time associated with data traveling or an operation completing.

---

## 🔹 Bandwidth

Bandwidth is:

> **How much data can be moved in a given amount of time.**

Think:

```text
Bandwidth = Capacity
```

Example:

```text
20 Mbps link
```

means the link has a certain capacity for carrying data.

---

## 🔹 Delay

Delay is the time between an action and the response.

It can also refer to the time required for a packet to travel from source to destination.

---

# 🧠 EASY MEMORY

```text
Bandwidth → How much data?

Latency   → How long does it take?

Delay     → Time between sending and receiving/responding
```

---

# 1️⃣8️⃣ MTU, WINDOW SIZE & MSS

These are networking terms I should understand at a basic level.

---

## 🔹 MTU

MTU means:

> **Maximum Transmission Unit**

It represents the maximum packet size an interface/link can support.

The teacher notes describe MTU as associated with Layer 1/link capacity, while protocols/software can also define values such as IP MTU or MPLS MTU.

---

## 🔹 IP MTU

IP MTU helps determine whether an IP packet needs fragmentation.

```text
Packet Size
     ↓
Compare with MTU
     ↓
Fragmentation decision
```

---

## 🔹 MSS

MSS means:

> **Maximum Segment Size**

MSS is calculated from MTU to avoid further fragmentation.

The teacher notes give the relationship as:

```text
MSS = MTU - Layer 3 Header + Layer 2 Header
```

The notes also mention a minimum MSS value of **576** when no MTU value is found.

---

## 🔹 UDP and MSS

UDP does not have MSS.

UDP uses **datagrams**.

The maximum UDP datagram size is limited by factors such as the IP packet carrying it and the UDP length field.

---

## 🔹 Fragment Offset

The teacher notes mention the offset bit in relation to fragmented data:

```text
0 → More data to be sent
1 → No more fragmented packet follows
```

---

# 1️⃣9️⃣ STATEFUL VS STATELESS FIREWALL

A firewall can be:

```text
Stateful
OR
Stateless
```

---

## 🔹 Stateless Firewall

A stateless firewall checks packets individually based on static information such as:

* Source address
* Destination address
* Other packet values

It does **not keep track of the state of the connection**.

Think:

> **Stateless = Check each packet using rules.**

A stateless firewall can be implemented as an ACL.

---

## Purpose

It can inspect incoming/outgoing packets and allow or block them based on rules.

It can be used to protect systems from malicious or untrusted packets.

---

# 🔹 Stateful Firewall

A stateful firewall keeps track of communication.

It understands the state of connections.

For example, it can understand TCP states such as:

```text
Open
SYN
SYN-ACK
Established
```

It can also track things such as:

* Communication paths
* Fragmentation
* MTU changes

Think:

> **Stateful = Understands the connection state.**

---

## Stateful vs Stateless

| Stateless                      | Stateful                                                |
| ------------------------------ | ------------------------------------------------------- |
| Checks packets individually    | Tracks connection state                                 |
| Uses static rules              | Understands communication state                         |
| Generally faster               | Better at identifying unauthorized/forged communication |
| Doesn't track connection state | Tracks connection state                                 |

Neither is automatically better for every situation.

---

# 2️⃣0️⃣ DNS ZONES

DNS information can be divided into smaller parts called **DNS zones**.

This makes DNS information easier to manage.

There are two main lookup zone types:

```text
Forward Lookup Zone
Reverse Lookup Zone
```

---

## 🔹 Forward Lookup

Used for:

```text
Name → IP
```

Example:

```text
google.com
    ↓
IP Address
```

---

## 🔹 Reverse Lookup

Used for:

```text
IP → Name
```

This can be useful for troubleshooting.

---

# DNS Zone Types

The teacher material mentions:

1. Primary
2. Secondary
3. Stub
4. Active Directory Integrated

---

## 1. Primary Zone

Primary zone contains a **read/write copy** of the DNS database.

I can:

```text
Add
Edit
Remove
```

DNS entries.

There is one primary server for the primary zone.

---

## 2. Secondary Zone

A secondary zone is a:

> **Read-only copy of the DNS database.**

It is mainly useful for redundancy.

The data can come from:

* Primary zone
* Another secondary zone
* Active Directory integrated zone

---

## 3. Stub Zone

A stub zone is also read-only.

It acts like a pointer toward the DNS servers of another zone.

It mainly contains name-server information rather than the complete zone data.

Because it contains only partial information, it can help make the query process faster.

---

## 4. Active Directory Integrated Zone

This type of DNS zone is integrated with Active Directory.

It is stored in Active Directory and is associated with environments such as Domain Controllers.

It is a read/write copy.

It can provide:

* Fault tolerance
* High availability
* Redundancy

---

# 2️⃣1️⃣ DNS RECORDS

DNS records are basically mappings that tell DNS:

> **Which IP address is associated with a domain and how requests should be handled.**

Important DNS record types:

```text
A
AAAA
CNAME
MX
PTR
NS
SOA
SRV
TXT
NAPTR
```

---

## 🔹 A Record

Maps a hostname/domain to an IPv4 address.

```text
Domain
  ↓
IPv4
```

---

## 🔹 AAAA Record

Maps a hostname to an IPv6 address.

IPv6 uses a 128-bit address.

---

## 🔹 CNAME

CNAME means:

> **Canonical Name**

It makes one domain an alias of another domain.

---

## 🔹 MX

MX means:

> **Mail Exchange**

It specifies the mail servers used for the domain.

---

## 🔹 PTR

PTR means:

> **Pointer Record**

It is used for reverse mapping.

```text
IP
 ↓
Name
```

---

## 🔹 NS

NS means:

> **Name Server**

It identifies the authoritative name server for a domain.

---

## 🔹 SOA

SOA means:

> **Start/State of Authority** as described in the teacher material.

It contains important information about the DNS zone, such as when the domain/zone information was updated.

---

## 🔹 SRV

SRV means:

> **Service**

It is used to define a service and the TCP service associated with a domain.

---

## 🔹 TXT

TXT allows administrators to add text information to DNS.

It is often used to store facts/information about a domain.

---

# 2️⃣2️⃣ IPTABLES

`iptables` is a rule-based Linux firewall.

It decides what happens to:

```text
Incoming packets
Outgoing packets
```

The teacher notes describe it as a front-end tool that communicates with the Linux kernel to filter packets.

---

## Different Tools

```text
iptables  → IPv4
ip6tables → IPv6
arptables → ARP
ebtables  → Ethernet frames
```

---

# IPTables Main Files

The teacher material mentions:

```text
/etc/init.d/iptables
/etc/sysconfig/iptables
/sbin/iptables
```

These can be used for managing the firewall and rules.

The exact paths can differ between Linux distributions, especially Ubuntu.

---

# IPTables Tables

The notes mention three tables:

```text
Filter
NAT
Mangle
```

---

# IPTables Chains

The material mentions:

```text
INPUT
OUTPUT
FORWARD
RH-Firewall-1-INPUT
```

### INPUT

Traffic coming into the system.

### OUTPUT

Traffic generated by the system.

### FORWARD

Traffic being forwarded through another interface.

### RH-Firewall-1-INPUT

A user-defined/custom chain mentioned in the notes.

---

# IPTables Commands

### Start

```bash
/etc/init.d/iptables start
```

### Stop

```bash
/etc/init.d/iptables stop
```

### Restart

```bash
/etc/init.d/iptables restart
```

---

## Start IPTables During Boot

```bash
chkconfig --level 345 iptables on
```

---

## Save Rules

```bash
service iptables save
```

The notes explain that saving the rules stores them in:

```text
/etc/sysconfig/iptables
```

so they can be restored when the service restarts.

---

# Check IPTables Rules

```bash
iptables -L -n -v
```

Meaning:

```text
-L → List rules
-n → Numeric format
-v → Verbose
```

---

## Display Rule Numbers

```bash
iptables -n -L -v --line-numbers
```

This is useful when I want to delete or insert a particular rule.

---

# Flush IPTables Rules

```bash
iptables -F
```

⚠️ This removes the rules from the tables.

So I should be careful and take a backup before flushing rules.

---

# Delete a Rule

For example:

```bash
iptables -D INPUT 5
```

This deletes rule number 5 from the INPUT chain.

---

# Insert a Rule

Example from the teacher material:

```bash
iptables -I INPUT 5 -s ipaddress -j DROP
```

This inserts a DROP rule into the INPUT chain.

---

# 2️⃣3️⃣ HTTP

HTTP means:

> **Hypertext Transfer Protocol**

It is the network protocol used by the Web.

A browser is an:

> **HTTP client**

and a web server is an:

> **HTTP server**

The browser sends requests and the server sends responses.

---

## HTTP Port

The standard HTTP port is:

```text
TCP 80
```

The server can technically use another port, but 80 is the standard/default port.

---

## What Is a Resource?

HTTP doesn't only transfer files.

A resource is information identified by a URL.

Examples can include:

```text
HTML
Images
Query results
Script output
Documents
```

So I can think:

> **HTTP transfers web resources between client and server.**

---

# 2️⃣4️⃣ VLAN

The teacher sheet has a point about VTP:

> A VTP client can overwrite a VTP server if the revision number is higher, because a VTP server is also a VTP client.

This is the specific VLAN/VTP point I need to remember from the sheet.

---

# 2️⃣5️⃣ LOAD BALANCERS

A load balancer distributes workloads across multiple servers or compute resources.

The main goal is:

```text
Distribute Traffic
       ↓
Better Efficiency
       ↓
Better Reliability
       ↓
Better Capacity
```

---

## Simple Example

Suppose I have:

```text
          Users
            ↓
      Load Balancer
       ↙    ↓    ↘
    Server1 Server2 Server3
```

Instead of sending all users to one server, the load balancer distributes requests.

---

# Load Balancer and Failover

Suppose:

```text
Server 1 → DOWN ❌
```

The load balancer can redirect traffic to another available server.

```text
User
 ↓
Load Balancer
 ↓
Server 2
```

So the user can continue using the application.

---

# Layer 4 Load Balancing

Layer 4 load balancing makes decisions using transport-level information such as:

```text
IP Address
TCP Port
```

---

# Layer 7 Load Balancing

Layer 7 load balancing makes decisions based on application-level information.

Examples:

```text
HTTP Headers
URLs
Cookies
```

---

# How Load Balancing Works

The load balancer sits between users and backend servers.

```text
Internet
    ↓
Load Balancer
    ↓
Server Pool
```

It checks which server is available and sends the request there.

During high traffic, additional servers can be added.

When traffic decreases, servers can be removed.

---

# Load Balancing Methods

The teacher material mentions:

### 1. Round Robin

Requests are distributed across servers in order.

```text
Request 1 → Server 1
Request 2 → Server 2
Request 3 → Server 3
Request 4 → Server 1
```

---

### 2. Least Connections

Send the request to the server having fewer current connections.

---

### 3. Least Time

Considers:

```text
Active Connections
+
Server Response Time
```

Servers with fewer connections and faster response times receive more traffic.

---

### 4. Predictive

Servers with better performance rankings and improving performance receive a greater proportion of connections.

---

### 5. Fastest

The new connection is sent to the server with the fastest response time.

This can be useful when servers are distributed across different logical networks.

---

# 2️⃣6️⃣ COMMON PORT NUMBERS

I should remember these:

| Service |   Port |
| ------- | -----: |
| FTP     | 20, 21 |
| SSH     |     22 |
| Telnet  |     23 |
| SMTP    |     25 |
| IPSec   | 50, 51 |
| DNS     |     53 |
| DHCP    | 67, 68 |
| HTTP    |     80 |
| HTTPS   |    443 |
| BGP     |    179 |

### 🧠 Most Important for Cloud Support

```text
22  → SSH
53  → DNS
67/68 → DHCP
80  → HTTP
443 → HTTPS
```

---

# 2️⃣7️⃣ HOST A AND HOST B CANNOT COMMUNICATE

Suppose:

```text
Host A ❌ Host B
```

How would I troubleshoot it?

---

## Step 1 — Test From Another Computer

First, I would check whether another computer on the same network as Host A can communicate with Host B.

### If another computer CAN communicate:

The problem may be:

```text
Host A
```

### If another computer CANNOT communicate:

The problem may be:

```text
Host B
OR
Network
```

---

## Step 2 — Check Host A With `ethtool`

Use:

```bash
ethtool eth0
```

This helps check the network interface.

It can also show:

```text
Speed
Duplex
```

The speed and duplex settings should match properly.

---

## Step 3 — Check the Interface

I should check whether the interface is correctly configured and running.

The teacher notes mention checking `eth0`.

---

## Step 4 — Check Default Gateway

Use the routing information.

The routing table can show the default gateway.

```bash
route
```

---

## Step 5 — Ping the IP

Try:

```bash
ping <IP>
```

If I receive a reply:

```text
Connectivity works
```

If there is no reply, one possibility is that a firewall is blocking ICMP.

---

# 2️⃣8️⃣ ACL

ACL means:

> **Access Control List**

It is a set of rules that can:

```text
ALLOW
or
DENY
```

specific traffic.

It can be used as Layer 3 security and packet filtering.

---

## Main Uses

The teacher material mentions:

```text
1. Filtering
2. Classification
```

---

## ACL and VPN

If a VPN encrypts traffic between two routers, an access list can be used to select which traffic should be encrypted.

Selecting the traffic is called:

> **Classification**

---

# Wildcard Mask

A wildcard mask tells the router which bits should:

```text
Match
or
Ignore
```

The notes give:

```text
Subnet Mask:
255.255.255.255

Customized Subnet Mask:
255.255.255.0

Wildcard:
0.0.0.255

Host Wildcard:
0.0.0.0
```

---

# 2️⃣9️⃣ FTP

FTP means:

> **File Transfer Protocol**

It is an application-layer protocol used to transfer files to/from a remote file system.

It follows the:

```text
Client
  ↕
Server
```

model.

---

## FTP Ports

FTP uses:

```text
TCP 21 → Control connection
TCP 20 → Data connection
```

The FTP client connects to port 21 and sends commands.

Example commands:

```text
USER
PASS
LIST
RETR
STOR
```

For example, when the client requests a list of files:

```text
Client
  ↓
LIST
  ↓
Port 21
```

The teacher notes describe the server sending the data through port 20.

---

# 3️⃣0️⃣ SNMP

SNMP means:

> **Simple Network Management Protocol**

It is an application-layer protocol used to **manage and monitor network devices**.

SNMP can be used with:

```text
Routers
Switches
Access Points
Printers
Scanners
```

It can also be used to monitor services such as DHCP.

---

# SNMP Manager and Agent

SNMP communication can involve:

```text
NMS / SNMP Manager
        ↕
      Agent
        ↕
Network Device
```

SNMP supports PUSH/PULL-style communication.

It can also provide information such as:

```text
Bandwidth
CPU
Memory
```

---

# SNMP Operations

## GET

Manager asks the agent for the value of a variable.

```text
Manager
   ↓ GET
Agent
   ↓
Value
```

---

## RESPONSE

Agent responds to a GET request with the requested values.

---

## GETNEXT

Used to retrieve the next OID in the MIB hierarchy.

---

## GETBULK

Used to retrieve larger tables of data by performing multiple GETNEXT operations.

---

## SET

Manager sends configuration/command information to the agent.

Example:

```text
Change Configuration
```

---

## TRAP

An agent sends an asynchronous alert to the manager when an important event occurs.

Example:

```text
Device Failure
     ↓
   TRAP
     ↓
   Manager
```

---

# 3️⃣1️⃣ SMTP

SMTP means:

> **Simple Mail Transfer Protocol**

SMTP is used to **send email**.

It is a **push protocol**.

For receiving email, protocols such as:

```text
POP
IMAP
```

are used.

---

# SMTP Working

SMTP works at the application layer.

The client opens a TCP connection to the SMTP server.

The SMTP server listens for connections.

The standard port mentioned in the teacher material is:

```text
TCP 25
```

Once the connection is established, the client sends the mail.

The teacher notes describe three phases:

```text
1. Handshaking
2. Transfer
3. Closure
```

SMTP can also use persistent connections.

---

# 3️⃣2️⃣ GRE

GRE means:

> **Generic Routing Encapsulation**

GRE is a protocol used to encapsulate packets so other protocols can be carried across IP networks.

It can be used as a tunneling mechanism.

```text
Network A
    ↓
 GRE Tunnel
    ↓
Network B
```

It can create a private point-to-point style connection over an IP network.

---

## GRE Can Carry

The teacher notes mention that GRE can carry:

* Multiple Layer 3 protocols
* Multicast traffic
* IPv6 traffic

---

## Advantages of GRE

GRE tunnels can:

* Carry multiple protocols over one backbone
* Work around networks with limited hops
* Connect discontinuous subnets
* Support VPN-style connections across WANs

---

## Important

GRE itself does **not provide encryption** like IPsec.

So:

> **GRE = tunneling, not encryption.**

---

# 3️⃣3️⃣ COOKIES

A cookie is an ID/information sent by a web server and stored in the user's browser.

It can be used for:

* Tracking
* Maintaining session information
* Security-related purposes

Example:

Suppose I add something to an online shopping cart.

```text
Shopping Cart
      ↓
Cookie
      ↓
Browser
```

When I return later, the stored information can help maintain the previous session information.

---

# 3️⃣4️⃣ CDN

CDN means:

> **Content Delivery Network**

A CDN is a distributed network of servers that delivers web content based on things such as:

* User's geographic location
* Origin website
* CDN server location

---

# How CDN Works

Suppose the website's original server is far away from me.

A CDN can have a server closer to me.

```text
User
 ↓
Nearest CDN Server
 ↓
Cached Content
```

The CDN stores copies of website content on geographically distributed servers.

---

## Example

```text
User in India
      ↓
Nearest CDN Server
      ↓
Cached Website Content
```

This can reduce the time required to get the content.

---

## If Content Isn't Cached

The CDN can communicate with the origin server to obtain content that hasn't already been cached.

The CDN process is mostly transparent to the user.

---

# 3️⃣5️⃣ REVERSE PROXY

A reverse proxy receives a request from a client.

It forwards the request to the appropriate backend server.

Then it sends the server's response back to the client.

```text
Client
   ↓
Reverse Proxy
   ↓
Backend Server
   ↓
Reverse Proxy
   ↓
Client
```

---

# Why Use a Reverse Proxy?

A reverse proxy can provide:

### 🔹 Security

The backend server's information is hidden from external users.

```text
Internet
   ↓
Reverse Proxy
   ↓
Private Backend
```

This makes it harder for clients to directly access backend servers.

The reverse proxy can also help with things such as:

* Blocking specific client IPs
* Limiting connections
* Protecting against certain DDoS traffic

---

### 🔹 Scalability

Clients only see the reverse proxy's address.

So the backend infrastructure can be changed without exposing those changes directly to clients.

This is especially useful with load balancing.

---

### 🔹 Compression

The reverse proxy can compress responses before sending them to clients.

Example:

```text
Large Response
      ↓
Compression
      ↓
Smaller Response
      ↓
Client
```

This reduces bandwidth usage.

---

### 🔹 SSL Termination

The reverse proxy can handle encryption/decryption.

```text
Client
  ↓
Encrypted Traffic
  ↓
Reverse Proxy
  ↓
Decrypt
  ↓
Backend
```

This can reduce the encryption/decryption work required on backend servers.

---

### 🔹 Caching

The reverse proxy can store responses locally.

```text
Client Request
      ↓
Reverse Proxy
      ↓
Cache Hit?
  ↙       ↘
YES       NO
 ↓         ↓
Response  Backend
```

If the content is already cached, the reverse proxy can respond directly.

This:

* Reduces response time
* Reduces backend server load

---

# 3️⃣6️⃣ PROXY SERVER

A proxy server acts as an intermediary between the client and another server.

```text
Client
  ↓
Proxy
  ↓
Server
```

The client requests something through the proxy.

For example:

```text
File
Web Page
Connection
Other Resource
```

The proxy evaluates and controls the request.

---

## Benefits

A proxy can:

* Reduce load on the main server
* Serve cached requests
* Make internal network details less visible externally

---

## Proxy Cache

Suppose many users request the same website.

The proxy may already have that website cached.

```text
User 1 ─┐
User 2 ─┼→ Proxy Cache
User 3 ─┘
```

This can improve response time.

---

# 3️⃣7️⃣ CLOUD HOSTING VS TRADITIONAL HOSTING

This is an important Cloud Support concept.

---

# Traditional Hosting

Traditional hosting mainly includes:

```text
Dedicated Hosting
Shared Hosting
```

---

## Dedicated Hosting

A company pays for the complete resources of one or more servers.

Resources can include:

```text
CPU
RAM
Storage
Bandwidth
```

The customer has control over those server resources.

---

# Shared Hosting

In shared hosting, multiple websites share the same server.

```text
Server
├── Website A
├── Website B
├── Website C
└── Website D
```

It is generally:

* Cost-effective
* Low maintenance

The hosting company manages the server.

---

# Problems With Shared Hosting

Because multiple websites share resources:

```text
Website A
Website B
Website C
      ↓
Same Server
```

If one website suddenly uses a lot of resources, other websites can experience reduced performance.

There can also be:

* Security problems
* Performance problems
* Single point of failure

If the server fails:

```text
All hosted websites
       ↓
Affected
```

---

# Resource Limitation

With traditional/shared hosting, I may pay for a fixed amount of:

```text
Storage
Processing Power
```

If traffic suddenly increases:

```text
Traffic ↑
   ↓
Resources may not be enough
```

I may need to purchase additional resources.

If traffic later decreases, I may still be paying for unused resources.

---

# Cloud Hosting

Cloud hosting provides more scalability.

Instead of paying upfront for fixed resources on one server, I can use resources on demand and pay for what I use.

```text
Cloud
 ├── Server
 ├── Server
 ├── Server
 └── Server
```

The workload can be distributed across multiple servers.

---

# Cloud Hosting Benefits

Cloud hosting can provide:

* Scalability
* Flexibility
* Redundancy
* Resilience
* Pay-as-you-use model

If one server goes down, other servers can continue handling the workload.

```text
Server 1 ❌
Server 2 ✅
Server 3 ✅
```

This reduces the impact of a single server failure.

Cloud hosting providers provide infrastructure as a service and maintain the underlying hardware.

---

# Traditional vs Cloud

| Traditional                                    | Cloud                                      |
| ---------------------------------------------- | ------------------------------------------ |
| Fixed resources                                | On-demand resources                        |
| Scaling can require manual changes             | Can scale more easily                      |
| Single server can be a single point of failure | Multiple servers can provide redundancy    |
| Pay for fixed resources                        | Pay for resources used                     |
| Less flexible                                  | More flexible                              |
| Hardware managed through hosting setup         | Cloud provider manages underlying hardware |

---

# 3️⃣8️⃣ TWO DIFFERENT WEBSITES IN THE SAME BROWSER

Suppose I open:

```text
Website A
Website B
```

at the same time.

How does the network know where each packet should go?

The IP packet contains the:

```text
Destination IP
```

Routers look at the destination IP and use their routing tables to decide where to send the packet.

```text
Packet A
Destination IP → Website A

Packet B
Destination IP → Website B
```

So the router knows which path to use based on the destination IP.

---

# 3️⃣9️⃣ DO ALL WEBSITES USE THE SAME PORT?

For standard web traffic:

```text
HTTP  → 80
HTTPS → 443
```

So many websites can use the same remote destination port.

But the **local/source ports** on my computer can be different.

Example:

```text
My Computer

Local Port 50001 → Remote Port 443
Local Port 50002 → Remote Port 443
```

Both can communicate with HTTPS servers even though their local ports are different.

---

# 4️⃣0️⃣ POP VS IMAP

Both POP and IMAP are email protocols.

They allow users to access email from a remote server.

But they work differently.

---

# POP3

POP3 generally downloads emails to a device.

The teacher notes describe that mail may be removed from the server after downloading unless the appropriate setting is enabled.

The problem with using multiple devices is that emails and their organization may not stay synchronized.

Example:

```text
Email Server
    ↓
Laptop
```

Then I read the same email on my phone and may not see the same organization/state.

---

# IMAP

IMAP keeps emails on the server.

This allows email to be synchronized across multiple devices.

```text
              Email Server
             ↙     ↓     ↘
         Laptop   Phone   Tablet
```

---

## IMAP

* Emails stored on server
* Sent messages stored on server
* Can synchronize across multiple devices

---

## POP3

* Emails stored on a device
* Sent messages stored on a device
* Mainly designed around downloading email to a device
* "Keep email on server" can be enabled if available

---

# 🧠 Easy Memory

```text
POP3 → Download to device

IMAP → Keep on server + Sync
```

---

# 4️⃣1️⃣ BGP

BGP means:

> **Border Gateway Protocol**

It is used for routing **between Autonomous Systems (AS)**.

It is an exterior gateway routing protocol.

The teacher material describes BGP as operating at the OSI Application layer and using:

```text
TCP 179
```

for reliable communication.

---

# What Does BGP Do?

BGP:

* Advertises routes
* Learns routes
* Chooses paths

It is extremely important on the global Internet.

For example:

```text
ISP A
  ↕
BGP
  ↕
ISP B
```

ISPs use BGP to exchange routing information.

Enterprises can also use BGP with ISPs.

---

# Multiple Internet Connections

Suppose an enterprise has:

```text
ISP 1
ISP 2
```

BGP can be used to influence which path traffic should take.

---

# BGP Tables

The teacher material mentions three important tables/databases.

---

## 1. Neighbor Table

Contains configured BGP neighbors.

Command:

```text
show ip bgp summary
```

---

## 2. BGP RIB / Forwarding Information

Contains networks, paths and BGP attributes.

Command:

```text
show ip bgp
```

---

## 3. Routing Table

Contains the best path to destination networks and the next hop.

Command:

```text
show ip route
```

---

# Multihoming

A network with one ISP connection is:

```text
Single-homed
```

A network connected to multiple ISPs is:

```text
Multihomed
```

Example:

```text
       Enterprise
       ↙        ↘
    ISP 1      ISP 2
```

Why use multiple ISPs?

* Redundancy
* Backup
* Better performance

If ISP 1 fails:

```text
ISP 1 ❌

ISP 2 ✅
```

Traffic can continue through ISP 2.

---

# BGP Peers

BGP routers need to establish a neighbor relationship.

These neighbors are called:

> **Peers**

---

## iBGP

BGP neighbors inside the same AS.

The teacher notes mention that iBGP neighbors do not have to be directly connected.

---

## eBGP

BGP neighbors between different ASes.

The teacher notes state that eBGP neighbors need to be directly connected.

---

# BGP Message Types

## 1. OPEN

Used to establish BGP peering.

It contains information such as:

```text
AS Number
Router ID
Hold Time
```

---

## 2. UPDATE

Used to exchange routing information.

It can contain:

```text
New Routes
Withdrawn Routes
Path Attributes
```

---

## 3. KEEPALIVE

Used to keep the BGP session active.

The teacher notes mention BGP peers exchange keepalive messages every:

```text
60 seconds
```

---

## 4. NOTIFICATION

Used when a problem causes the BGP session to end.

It reports the error and the connection is closed.

---

# BGP Peering States

BGP uses an FSM:

> **Finite State Machine**

The states are:

```text
Idle
 ↓
Connect
 ↓
Active
 ↓
OpenSent
 ↓
OpenConfirm
 ↓
Established
```

---

## Idle

BGP is waiting or administratively down.

It checks whether a route exists to reach the neighbor.

---

## Connect

BGP waits for the TCP connection to complete.

If successful:

```text
Connect
   ↓
OpenSent
```

If unsuccessful:

```text
Connect
   ↓
Active
```

---

## Active

BGP tries again to establish the TCP connection.

---

## OpenSent

TCP connection exists and an OPEN message has been sent.

BGP waits for the matching OPEN message from the other router.

---

## OpenConfirm

Both sides have exchanged OPEN messages.

The router waits for:

```text
KEEPALIVE
```

or:

```text
NOTIFICATION
```

---

## Established

The BGP peering session is established.

This is the desired state.

At this point, routing information can be exchanged.

Useful commands:

```text
show ip bgp neighbors
show ip bgp summary
```

---

# BGP Attributes

## AS Path

Contains the list of Autonomous Systems through which the route has passed.

Generally:

> **Shorter AS Path is preferred.**

---

## Next Hop

The next hop is the IP address used to reach the next AS for the destination network.

---

## Origin

Shows how BGP learned the network.

The notes mention:

```text
i → IGP / network command
e → EGP
? → Incomplete
```

---

## Weight

A Cisco proprietary attribute.

Higher weight is preferred.

The notes mention:

```text
Default weight:
0 → Learned routes
32768 → Locally injected routes
```

---

## Local Preference

Used inside the AS to influence which path should be used to leave the AS.

Higher local preference is preferred.

The teacher notes mention the default:

```text
100
```

---

## MED

MED means:

> **Multi-Exit Discriminator**

It can influence how traffic should enter an AS when multiple paths are available.

---

# 4️⃣2️⃣ OSPF

OSPF means:

> **Open Shortest Path First**

It is a **link-state routing protocol**.

It uses the **Dijkstra algorithm** to calculate the shortest/best path.

It is classless and supports:

```text
VLSM
```

---

# OSPF Important Points

The teacher material mentions:

* Link-state protocol
* Dijkstra algorithm
* Supports VLSM
* Supports equal-cost load balancing
* Updates use multicast

OSPF uses:

```text
224.0.0.5
224.0.0.6
```

---

# Routing Protocol Comparison

The teacher sheet compares:

```text
BGP
OSPF
IS-IS
EIGRP
IGRP
RIPv2
```

Important concepts mentioned include:

```text
Metric
Classless / Classful
Routing Algorithm
Updates
Load Balancing
Maximum Hop Count
Administrative Distance
Timers
Convergence
```

For my Cloud Support preparation, the most important distinction to remember is:

```text
OSPF → Link State + Dijkstra
BGP  → Inter-AS Routing
RIP  → Distance Vector + Hop Count
EIGRP → Hybrid
```

---

# 4️⃣3️⃣ IPSEC

IPsec means:

> **IP Security**

It is a suite of protocols used to provide security over IP networks.

It provides things such as:

```text
Authentication
Integrity
Confidentiality
```

It can be used for VPN communication.

```text
Host A
   ↓
Encrypted IPsec Tunnel
   ↓
Host B
```

---

# What Does IPsec Provide?

IPsec can:

* Encrypt application data
* Authenticate data
* Protect routing information over public networks
* Create encrypted VPN tunnels
* Protect IP packets

---

# IPsec Components

The teacher material mentions three important components:

```text
ESP
AH
IKE
```

---

## 1. ESP — Encapsulating Security Payload

ESP can provide:

* Encryption
* Data integrity
* Authentication
* Anti-replay protection

---

## 2. AH — Authentication Header

AH provides:

* Authentication
* Data integrity
* Anti-replay

But:

> **AH does not provide encryption.**

---

## 3. IKE — Internet Key Exchange

IKE is used to establish security parameters and exchange cryptographic keying information between devices.

It helps establish the:

```text
Security Association (SA)
```

---

# IPsec Working

### Step 1

The host checks whether the traffic should be protected by IPsec.

---

### Step 2 — IKE Phase 1

The two hosts authenticate each other and establish a secure channel.

The teacher material mentions:

```text
Main Mode
Aggressive Mode
```

---

### Step 3

The secure channel is used to negotiate how the IPsec communication will protect the data.

---

### Step 4 — IKE Phase 2

The hosts negotiate:

```text
Cryptographic Algorithms
Secret Keying Material
```

---

### Step 5 — Data Transfer

Data is exchanged through the IPsec tunnel.

The hosts encrypt/decrypt the traffic using IPsec security associations.

---

### Step 6 — Tunnel Termination

When communication finishes or the session times out:

```text
IPsec Tunnel
     ↓
Terminated
     ↓
Keys Discarded
```

---

# 4️⃣4️⃣ CHECK DISK SPACE IN LINUX

For Linux server troubleshooting, disk space is very important.

---

## `df`

`df` shows the amount of disk space:

```text
Used
Available
```

on file systems.

Basic command:

```bash
df
```

Human-readable:

```bash
df -h
```

---

## `du`

`du` shows disk usage for files and directories.

Think:

```text
df → File system space

du → Directory/file usage
```

---

## Other `df` Options

```bash
df -m
```

→ Show sizes in megabytes

```bash
df -k
```

→ Show sizes in kilobyte blocks

```bash
df -i
```

→ Show inode usage

```bash
df -T
```

→ Show file system type

```bash
df -T -h
```

→ File system type + human-readable output

```bash
df -T -h /data/
```

→ Check a specific path

---

# What Is an Inode?

An inode is a data structure in the Linux file system that stores information about a file.

To check inode usage:

```bash
df -i
```

or:

```bash
df -i -h
```

---

# `df -l`

The `-l` option limits the listing to local file systems.

```bash
df -l
```

---

# 4️⃣5️⃣ LINUX SERVER TROUBLESHOOTING

When a Linux server has a problem, I should troubleshoot step by step instead of randomly changing things.

The main areas from my teacher's notes are:

```text
Hardware
   ↓
Server/Application
   ↓
Processes
   ↓
Disk
   ↓
Logs
```

---

# Step 1 — Check Hardware

To check whether the Ethernet link is detectable:

```bash
sudo ethtool eth0
```

If the link is detected, I know the network port is communicating with the network.

---

## Check Memory

Bad RAM can cause many types of problems.

For server hardware information:

```bash
sudo dmidecode --type memory
```

If memory still looks suspicious, the teacher material mentions:

```text
Memtest86
```

It can perform memory testing, but it can take time.

---

# Step 2 — Check Whether the Server/Application Is Running

I should first determine whether:

```text
Server itself
OR
Application
```

is the problem.

For example, to check Apache:

```bash
sudo ps -ef | grep apache2
```

or:

```bash
sudo netstat -plunt | grep apache2
```

If Apache isn't running, it can be started with:

```bash
sudo service apache2 start
```

---

# Step 3 — Check Running Processes

Use:

```bash
top
```

`top` shows running processes and helps me see:

* Load average
* Swap
* CPU/resource usage
* Running processes

---

## Sort Processes

Inside `top`:

```text
M → Sort by memory
P → Sort by CPU
T → Sort by running time
b → Highlight/sort column information
```

---

## `htop`

The teacher notes also mention:

```bash
htop
```

It provides an easier way to view processes and can allow mouse/scroll interaction.

---

# Step 4 — Check Disk Space

Use:

```bash
df
```

or:

```bash
df -h
```

I can use this to check whether the server is running out of disk space.

---

# Step 5 — Check Server Logs

Logs can tell me what happened.

For Apache on Ubuntu, the teacher notes mention:

```text
/var/log/apache2
```

---

## `dmesg`

Another useful command is:

```bash
dmesg
```

It displays kernel messages.

There can be a lot of output, so I can use:

```bash
dmesg | tail
```

to see the latest messages.

---

# 🏆 MY FINAL TROUBLESHOOTING MINDSET

When something isn't working, I should not immediately start changing configurations.

I should first identify:

```text
What exactly is failing?
```

Then move step by step.

For a network problem:

```text
Physical
   ↓
Interface
   ↓
IP
   ↓
Gateway
   ↓
Routing
   ↓
DNS
   ↓
Packet Loss / Latency
   ↓
Firewall
   ↓
Port
   ↓
Service
   ↓
Application
   ↓
Logs
```

For a Linux server:

```text
Hardware
   ↓
Network
   ↓
Server
   ↓
Process
   ↓
Disk
   ↓
Logs
```

---

# 🧠 FINAL QUICK REVISION

## Website Flow

```text
DHCP
 ↓
DNS Cache
 ↓
DNS Recursor
 ↓
Root
 ↓
.com
 ↓
Authoritative DNS
 ↓
IP
 ↓
TCP
 ↓
HTTP
 ↓
Web Server
 ↓
Response
 ↓
Browser
```

---

## Packet Encapsulation

```text
Data
 ↓
Segment
 ↓
Packet
 ↓
Frame
 ↓
Bits
```

---

## Troubleshooting Commands

```bash
ipconfig
ping
tracert
netstat
ethtool
route
df
du
top
htop
dmesg
```

---

## Important Ports

```text
FTP      → 20,21
SSH      → 22
Telnet   → 23
SMTP     → 25
IPSec    → 50,51
DNS      → 53
DHCP     → 67,68
HTTP     → 80
HTTPS    → 443
BGP      → 179
```

---

## DNS Records

```text
A     → IPv4
AAAA  → IPv6
CNAME → Alias
MX    → Mail Server
PTR   → Reverse Lookup
NS    → Name Server
SOA   → Zone Authority Information
SRV   → Service
TXT   → Text Information
```

---

## Routing

```text
Static  → Manually configured
Dynamic → Automatically learned/updated
```

---

## Network Troubleshooting

```text
Ping
  ↓
Traceroute
  ↓
Packet Loss
  ↓
MTR
```

---

## Firewall

```text
Stateless → Checks packets individually
Stateful  → Tracks connection state
```

---

## Load Balancing

```text
Users
  ↓
Load Balancer
  ↓
Server 1
Server 2
Server 3
```

Main methods:

```text
Round Robin
Least Connections
Least Time
Predictive
Fastest
```

---

## Email

```text
SMTP → Send Email
POP3 → Download Email
IMAP → Email on Server + Sync
```

---

## Routing Protocols

```text
BGP  → Inter-AS routing
OSPF → Link-state + Dijkstra
RIP  → Distance Vector + Hop Count
EIGRP → Hybrid
```

---

## Security

```text
ACL   → Allow/Deny Traffic
GRE   → Tunneling
IPsec → Secure IP Communication
```

---

# 🔥 MY MAIN TAKEAWAY

The biggest thing I understood from these pending topics is that **networking is not just about knowing commands**.

I need to understand the **flow**.

For example, when a website is slow or unreachable:

```text
User
 ↓
Computer
 ↓
Network
 ↓
DNS
 ↓
Routing
 ↓
TCP
 ↓
Port
 ↓
Firewall
 ↓
Server
 ↓
Application
 ↓
Logs
```

Then I can use the right tool depending on where I think the problem is:

```text
IP problem       → ipconfig / network configuration
Connectivity     → ping
Path problem     → tracert / traceroute
Packet loss      → ping + traceroute + MTR
Port problem     → netstat
Interface problem → ethtool
Disk problem     → df / du
Process problem  → top / htop
Kernel problem   → dmesg
```

### 🧠 The mindset I want to remember:

> **Don't randomly troubleshoot. Find where the problem starts, test that layer, and then move deeper.**

That is the way I should approach **Cloud Support troubleshooting**.
