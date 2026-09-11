# 🚀 DAY 2 — IP Addressing & Subnetting

Today I continued my **Networking Fundamentals** preparation for Cloud Support Associate.

The main focus of Day 2 is **IP addressing and subnetting**.

I am going to understand everything step by step instead of directly jumping into difficult subnetting calculations.

---

# 📚 Today's Flow

```text
1️⃣ IPv4 Address
       ↓
2️⃣ Network Part & Host Part
       ↓
3️⃣ Public IP vs Private IP
       ↓
4️⃣ Private IP Ranges
       ↓
5️⃣ Subnet Mask
       ↓
6️⃣ CIDR
       ↓
7️⃣ Subnet
       ↓
8️⃣ Network Address
       ↓
9️⃣ Broadcast Address
       ↓
🔟 Usable IP Addresses
       ↓
1️⃣1️⃣ Default Gateway
       ↓
1️⃣2️⃣ Basic Subnetting
       ↓
1️⃣3️⃣ Cloud Support Scenarios
```

I want to go **one topic at a time**.

---

# 1️⃣ What is an IPv4 Address?

The simple way I understand an IP address is:

> **An IP address is an address given to a device so that it can communicate over a network.**

I can compare it with my house address.

Just like my house has an address, a device on a network has an IP address.

For example:

```text
192.168.1.10
```

This is an **IPv4 address**.

---

# 🔢 IPv4 Address Structure

IPv4 has **4 parts**, separated by dots.

Example:

```text
192 . 168 . 1 . 10
 ↓     ↓    ↓    ↓
 1     2    3    4
```

Each part is called an **octet**.

Each octet can have a value from:

```text
0 → 255
```

So these are valid examples:

```text
192.168.1.10   ✅
10.0.0.25      ✅
172.16.5.20    ✅
```

But:

```text
192.168.1.300  ❌
```

is not valid because `300` is greater than `255`.

---

# 🏠 Real-World Example

Suppose my office has 5 computers.

They could have addresses like:

```text
Computer 1 → 192.168.1.10
Computer 2 → 192.168.1.11
Computer 3 → 192.168.1.12
Computer 4 → 192.168.1.13
Computer 5 → 192.168.1.14
```

Now the network can identify which device is which.

The way I remember it:

```text
House address → identifies a house
IP address    → identifies a device/interface on a network
```

---

# ☁️ Cloud / AWS Example

Suppose I launch an EC2 instance.

It might have a private IP like:

```text
10.0.1.25
```

Another EC2 instance might have:

```text
10.0.1.26
```

They can use these addresses to communicate within the network, provided the network configuration and security rules allow it.

This is why **IP addressing is extremely important in Cloud Support**.

---

# 🧠 One Important Thing

I should not think:

> **"IP address always identifies the physical computer."**

Instead, for now I remember:

> **IP address = address used for network communication.**

A device can have different IP addresses depending on the network it is connected to.

---

# 🎯 Small Cloud Support Scenario

Suppose a customer says:

> **"I cannot connect to my EC2 server."**

One of the first things I need to know is:

```text
What is the destination IP?
        ↓
Is it the correct IP?
        ↓
Can we reach that IP?
        ↓
Is the required port reachable?
```

So even a basic Cloud Support issue can start with **IP addressing**.

---

# 🔥 IPv4 Checkpoint

The important things I remember are:

```text
IPv4
 ↓
32 bits
 ↓
4 octets
 ↓
Example: 192.168.1.10
 ↓
Each octet: 0–255
```

---

# 2️⃣ Network Part & Host Part

Now I need to understand an important idea:

> **An IP address contains a network part and a host part.**

The network part tells me **which network** the address belongs to.

The host part identifies the **specific device/host inside that network**.

For example:

```text
192.168.1.10/24
```

With `/24`, the first 24 bits represent the network and the remaining 8 bits represent hosts.

I will understand this more clearly when I learn **subnet masks and CIDR**.

The important idea for now is:

```text
IP Address
    ↓
┌───────────────┬─────────────┐
│ Network Part  │ Host Part   │
└───────────────┴─────────────┘
```

This network/host boundary is one of the most important things in subnetting.

---

# 3️⃣ Public IP vs Private IP

Another important thing I learned is that IP addresses can be **public or private**.

## 🌐 Public IP

A public IP is used for communication involving the public internet.

I can think of it as an address that can be used on the internet, subject to the relevant networking configuration.

---

## 🏠 Private IP

A private IP is used inside private networks.

For example:

```text
10.0.1.25
```

An EC2 instance inside a VPC can have a private IP.

I should remember:

```text
Private IP
→ Used inside private networking

Public IP
→ Used for public internet-facing communication
```

---

# 4️⃣ Private IP Ranges

The private IPv4 ranges I learned are:

```text
10.0.0.0/8
```

```text
172.16.0.0/12
```

```text
192.168.0.0/16
```

So examples like these fall inside private address ranges:

```text
10.0.1.25
172.16.5.20
192.168.1.10
```

These ranges are important because I will see them frequently when working with private networks and AWS VPCs.

---

# 5️⃣ Subnet Mask

Now I came to the **subnet mask**.

The subnet mask helps tell me:

> **Which part of the IP belongs to the network and which part belongs to the hosts.**

For example:

```text
192.168.1.10/24
```

The `/24` corresponds to this subnet mask:

```text
255.255.255.0
```

So:

```text
CIDR → /24
Subnet Mask → 255.255.255.0
```

The important idea is:

```text
Subnet Mask
     ↓
Network / Host boundary
```

---

# 6️⃣ CIDR

CIDR is the notation I will use a lot in cloud networking.

For example:

```text
192.168.1.0/24
```

The `/24` is the **CIDR prefix length**.

It tells me how many bits belong to the network portion.

For `/24`:

```text
IPv4 = 32 bits

Network = 24 bits
Host    = 8 bits
```

So:

```text
/24
 ↓
24 network bits
8 host bits
```

---

# 🧠 Important CIDR Idea

One thing I need to remember:

> **Bigger CIDR number = smaller network.**

For example:

```text
/24
```

is a larger network than:

```text
/25
```

because `/25` uses one more bit for the network portion and therefore leaves fewer host bits.

I will use this idea when I start basic subnetting.

---

# 7️⃣ Subnet

Now I can understand what a subnet is.

> **Subnet = a smaller network inside a bigger network.**

For example:

```text
Large Network
      ↓
   Subnet
```

In AWS, I can have:

```text
VPC
 ↓
Subnet A
Subnet B
Subnet C
```

Each subnet represents a smaller network inside the larger VPC network.

---

# 8️⃣ Network Address

A subnet has a **network address**.

For example:

```text
192.168.1.0/24
```

Here:

```text
Network Address
      ↓
192.168.1.0
```

The network address represents the **network itself**, not a normal host.

---

# 9️⃣ Broadcast Address

A subnet also has a **broadcast address**.

For:

```text
192.168.1.0/24
```

the broadcast address is:

```text
192.168.1.255
```

So:

```text
Network   → 192.168.1.0
Broadcast → 192.168.1.255
```

The broadcast address represents communication to all hosts in that subnet.

---

# 🔟 Usable IP Addresses

For the normal `/24` example:

```text
192.168.1.0/24
```

the addresses are:

```text
Network:
192.168.1.0

Usable:
192.168.1.1 → 192.168.1.254

Broadcast:
192.168.1.255
```

So the normal usable host range is:

```text
192.168.1.1 – 192.168.1.254
```

That gives:

```text
254 usable host addresses
```

The important thing I remember is:

```text
Network address
     ↓
Not a normal host address

Usable addresses
     ↓
Used by hosts

Broadcast address
     ↓
Represents all hosts in the subnet
```

---

# 🧠 Complete `/24` Picture

For:

```text
192.168.1.0/24
```

I can visualize it as:

```text
192.168.1.0
     ↓
NETWORK
     ↓
192.168.1.1
     ↓
     ...
     ↓
192.168.1.254
     ↓
USABLE HOSTS
     ↓
192.168.1.255
     ↓
BROADCAST
```

---

# 1️⃣1️⃣ Default Gateway

This one becomes easier when I connect it with the **router** concept I learned on Day 1.

The simple definition is:

> **Default Gateway is the device, usually a router, that my computer sends traffic to when the destination is outside its local network.**

I think of it as:

> **The exit door of my network.** 🚪

---

# 🏠 Real-World Example

Imagine my home network:

```text
                 INTERNET 🌍
                      ↑
                      |
                  ROUTER
                192.168.1.1
                      |
          ┌───────────┼───────────┐
          ↓           ↓           ↓
       Laptop       Phone        TV
    192.168.1.10   .11          .12
```

My router's private IP might be:

```text
192.168.1.1
```

My laptop could have:

```text
IP Address:
192.168.1.10

Default Gateway:
192.168.1.1
```

---

# 🤔 Why Do I Need a Default Gateway?

Suppose my laptop wants to talk to my phone:

```text
Laptop
192.168.1.10
     ↓
Phone
192.168.1.11
```

They are in the same network, so the laptop can communicate within that network.

But now suppose my laptop wants to reach:

```text
Google 🌍
```

Google isn't inside:

```text
192.168.1.0/24
```

So my laptop thinks:

> **"This destination is outside my network. I'll send the traffic to my default gateway."**

So:

```text
Laptop
192.168.1.10
      ↓
Default Gateway
192.168.1.1
      ↓
Internet 🌍
      ↓
Google
```

---

# 🏢 Simple Analogy

I can imagine an apartment complex:

```text
Apartment
    ↓
Security Gate 🚪
    ↓
Outside World
```

If I want to go from one room to another inside the building:

```text
Room → Room
```

I don't need to leave the building.

But if I want to go outside:

```text
Room → Security Gate → Outside
```

The security gate is like the **default gateway**.

---

# ☁️ AWS Example

Suppose my EC2 has:

```text
IP:
10.0.1.25
```

and it is inside:

```text
Subnet:
10.0.1.0/24
```

If it needs to communicate with something outside its local subnet, it needs a route toward the appropriate gateway/path.

Conceptually:

```text
EC2
10.0.1.25
   ↓
Default route / gateway
   ↓
Other network / Internet
```

In AWS, the exact path depends on the **route table and network setup**.

---

# 🔥 Connecting Everything I Have Learned

Now I can connect the concepts:

```text
VPC
 ↓
Subnet
 ↓
EC2
 ↓
Private IP
 ↓
Subnet mask tells me:
"Is the destination inside my network?"
```

If YES:

```text
Communicate within the network
```

If NO:

```text
Send traffic toward
Default Gateway / appropriate route
```

This is why **subnetting matters**.

---

# 🎯 Cloud Support Scenario

Customer says:

> **"My EC2 can communicate with another server in the same subnet, but it can't reach another network."**

Now I should start thinking:

```text
Same subnet works?
       ↓
      YES
       ↓
Local networking probably works
       ↓
Destination is another network
       ↓
Check route
       ↓
Check gateway/path
       ↓
Check Security Group / NACL
       ↓
Check firewall
```

So the default gateway is part of understanding **how traffic leaves one network and reaches another**.

---

# 🧠 One Sentence to Remember

> **Default Gateway = the way out of my local network.**

```text
Same network?
     ↓
Direct/local communication

Different network?
     ↓
Gateway / route
     ↓
Other network
```

Example:

```text
Laptop:
192.168.1.10

Gateway:
192.168.1.1
```

If my laptop wants to reach something outside:

```text
192.168.1.0/24
```

it can send the traffic toward its gateway.

---

# 🔥 Part 1 — My Main Takeaways

By this point, I understand:

```text
IPv4
 ↓
4 octets
 ↓
0–255 per octet
 ↓
Network + Host parts
 ↓
Public / Private IP
 ↓
Private IP ranges
 ↓
Subnet Mask
 ↓
CIDR
 ↓
Subnet
 ↓
Network Address
 ↓
Broadcast Address
 ↓
Usable IPs
 ↓
Default Gateway
```

The most important relationship for me is:

```text
IP Address
     ↓
CIDR / Subnet Mask
     ↓
Network + Host boundary
     ↓
Subnet
     ↓
Network Address
     ↓
Broadcast Address
     ↓
Usable Host Addresses
```

And when traffic needs to leave the local network:

```text
Device
  ↓
Route
  ↓
Default Gateway
  ↓
Other Network
```

---

# 🎯 Next — Part 2

In Part 2, I continue with:

```text
1️⃣2️⃣ Basic Subnetting
        ↓
1️⃣3️⃣ Cloud Support Scenarios
        ↓
Day 2 Revision
        ↓
Interview Questions
        ↓
Complete Day 2 Cheat Sheet
```
