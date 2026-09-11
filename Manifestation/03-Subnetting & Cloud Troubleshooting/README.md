# 🚀 PART 2

In Part 2, I am going to take everything I learned about IP addressing and actually use it.

The main focus here is:

```text
Basic Subnetting
      ↓
Cloud Support Scenarios
      ↓
Day 2 Revision
      ↓
Interview Preparation
```

---

# 1️⃣2️⃣ Basic Subnetting

At first, subnetting sounded difficult to me.

But the basic idea is actually simple:

> **Subnetting means taking one large network and dividing it into smaller networks.**

That's the main idea.

---

# 🏢 Real-World Example

Imagine I have one big office:

```text
BIG OFFICE
```

Inside that office, I have:

```text
HR
IT
Finance
Sales
```

Instead of keeping everyone in one large area, I divide the office into sections.

That's basically what subnetting does:

```text
BIG NETWORK
     ↓
 ┌───┼───┬───┐
 ↓   ↓   ↓   ↓
HR  IT  Finance Sales
```

Each section is a **subnet**.

---

# ☁️ AWS Example

Suppose I have a VPC:

```text
10.0.0.0/16
```

This is a relatively large private network.

I can divide it into smaller `/24` subnets:

```text
             VPC
          10.0.0.0/16
               │
        ┌──────┼──────┐
        ↓      ↓      ↓
      Subnet Subnet Subnet
       /24    /24    /24

    10.0.1.0 10.0.2.0 10.0.3.0
```

I could organize them like:

```text
10.0.1.0/24 → Web
10.0.2.0/24 → Application
10.0.3.0/24 → Database
```

So one large VPC network can be divided into smaller logical networks.

---

# 🤔 Why Do I Subnet?

There are a few important reasons.

## 1️⃣ Organization

Instead of having everything together:

```text
100 servers
```

I can organize them into:

```text
Web servers
App servers
Database servers
```

This makes the network easier to understand.

---

# 2️⃣ Security

I can apply different network/security rules to different subnets.

For example:

```text
Internet
   ↓
Web Subnet
   ↓
App Subnet
   ↓
Database Subnet
```

I generally don't want the database sitting directly on the public-facing edge.

The idea is to separate different parts of the environment into different network sections.

---

# 3️⃣ Network Management

Smaller networks are easier to manage and troubleshoot.

Suppose a customer says:

> **"The database server can't communicate with the application server."**

I can start asking:

```text
Which subnet is the database in?
Which subnet is the application in?
What routes connect them?
What security rules apply?
```

So subnetting isn't just about calculations.

It also helps me organize and troubleshoot networks.

---

# 🔥 Let's Actually Divide a Network

Start with:

```text
192.168.1.0/24
```

I already know:

```text
Network:
192.168.1.0

Usable:
192.168.1.1 – 192.168.1.254

Broadcast:
192.168.1.255
```

This is one network.

Now suppose I want **two smaller networks**.

I can split it into:

```text
192.168.1.0/25
192.168.1.128/25
```

Visually:

```text
              192.168.1.0/24
                     │
             ┌───────┴───────┐
             ↓               ↓
       192.168.1.0/25   192.168.1.128/25
```

---

# 1️⃣ First Subnet

```text
192.168.1.0/25
```

For this subnet:

```text
Network:
192.168.1.0

Usable:
192.168.1.1 – 192.168.1.126

Broadcast:
192.168.1.127
```

---

# 2️⃣ Second Subnet

```text
192.168.1.128/25
```

For this subnet:

```text
Network:
192.168.1.128

Usable:
192.168.1.129 – 192.168.1.254

Broadcast:
192.168.1.255
```

So:

```text
One /24
   ↓
Two /25 networks
```

---

# 🧠 Notice What Happened

Before:

```text
192.168.1.0/24
```

After:

```text
192.168.1.0/25
192.168.1.128/25
```

We made the network smaller by increasing:

```text
/24 → /25
```

This connects to the CIDR rule I learned earlier:

> **Bigger CIDR number = smaller network.**

---

# 🎯 I Don't Need Advanced Subnetting Yet

For now, I want to understand this picture:

```text
ONE BIG NETWORK
       ↓
   SUBNETTING
       ↓
SMALLER NETWORKS
```

Example:

```text
192.168.1.0/24
       ↓
 ┌─────┴─────┐
 ↓           ↓
/25         /25
 ↓           ↓
Network 1   Network 2
```

That's the basic concept.

---

# ☁️ Why This Matters for Cloud Support

Imagine a customer has:

```text
VPC → 10.0.0.0/16
```

and tells me:

> **"My EC2 is in `10.0.2.25`, but it can't communicate with `10.0.3.25`."**

I should immediately start thinking:

```text
10.0.2.25
    ↓
Which subnet?
    ↓
10.0.2.0/24

10.0.3.25
    ↓
Which subnet?
    ↓
10.0.3.0/24

Different subnets
    ↓
Check routing
    ↓
Security Group
    ↓
NACL
    ↓
Firewall
    ↓
Port
```

This is why **subnetting isn't just a calculation exercise**.

It directly affects cloud networking and troubleshooting.

---

# 1️⃣3️⃣ Cloud Support Scenarios

Now I want to use everything I learned today in real Cloud Support situations.

This is where the concepts start connecting.

---

# 🚨 Scenario 1 — EC2 is Running, but I Cannot Connect

Imagine:

```text
EC2

Private IP:
10.0.1.25

Subnet:
10.0.1.0/24
```

Customer says:

> **"My EC2 instance is running, but I cannot connect to it."**

My first reaction should **not** be:

> "Restart the EC2." ❌

I need to troubleshoot systematically.

---

## Step 1 — Is the IP Correct?

I know:

```text
10.0.1.25
```

I first check whether I am trying to reach the **correct address**.

---

## Step 2 — Is it a Private or Public IP?

```text
10.0.1.25
```

This is a **private IP**.

So I need to ask:

> **"Are you trying to connect from inside the private network or from the public internet?"**

If the customer is sitting at home and trying to connect directly to:

```text
10.0.1.25
```

that is a problem because it is a private address.

This is an important Cloud Support clue.

---

# 🚨 Scenario 2 — Two EC2 Instances Cannot Communicate

Suppose I have:

```text
EC2-A
10.0.1.25

EC2-B
10.0.2.25
```

Customer says:

> **"These two servers can't communicate."**

The first thing I notice is:

```text
10.0.1.25
    ↓
Subnet 10.0.1.0/24

10.0.2.25
    ↓
Subnet 10.0.2.0/24
```

They are in **different subnets**.

So I start thinking:

```text
Different subnet
      ↓
Routing
      ↓
Security rules
      ↓
NACL
      ↓
Firewall
      ↓
Required port
```

Now all the concepts from today start connecting.

---

# 🚨 Scenario 3 — EC2 Has a Private IP but Needs Internet Access

Suppose:

```text
EC2
10.0.1.25
```

Customer says:

> **"My EC2 can communicate internally, but it can't access the internet."**

I think:

```text
EC2
10.0.1.25
   ↓
Private network
   ↓
Route?
   ↓
Gateway / NAT setup?
   ↓
Security rules?
   ↓
Internet
```

The important thing I learned here is:

> **Having a private IP does NOT automatically mean the server has internet access.**

The network needs the appropriate **routing and NAT/internet connectivity setup**.

---

# 🚨 Scenario 4 — Is `10.0.1.25` Inside `10.0.1.0/24`?

Yes.

Why?

I know:

```text
Network:
10.0.1.0/24
```

The usable range is:

```text
10.0.1.1 → 10.0.1.254
```

And:

```text
10.0.1.25
```

falls inside that range.

Therefore:

```text
10.0.1.25 ✅
```

is a valid host address for that normal `/24` network.

---

# 🚨 Scenario 5 — Customer Gives Me `10.0.1.255`

Customer asks:

> **"Can I assign `10.0.1.255` to my EC2?"**

For:

```text
10.0.1.0/24
```

I know:

```text
10.0.1.0   → Network
10.0.1.1   → Usable
...
10.0.1.254 → Usable
10.0.1.255 → Broadcast
```

So:

```text
10.0.1.255 ❌
```

is the broadcast address, not a normal host address.

---

# 🧠 Now I Put EVERYTHING Together

Take:

```text
10.0.1.25/24
```

Now I can explain the whole thing:

```text
IP Address
    ↓
10.0.1.25
    ↓
CIDR
    ↓
/24
    ↓
Subnet Mask
    ↓
255.255.255.0
    ↓
Network Address
    ↓
10.0.1.0
    ↓
Broadcast
    ↓
10.0.1.255
    ↓
Usable Range
    ↓
10.0.1.1 – 10.0.1.254
```

This is the complete picture for this example.

---

# 🎯 Day 2 Interview Question

Suppose an interviewer asks:

> **"What is `10.0.1.25/24`?"**

My simple answer would be:

> "`10.0.1.25` is the IP address. `/24` means 24 bits are used for the network and 8 bits for hosts. The subnet mask is `255.255.255.0`. The network address is `10.0.1.0`, the broadcast address is `10.0.1.255`, and the normal usable host range is `10.0.1.1` to `10.0.1.254`."

That's a solid Cloud Support answer.

---

# 🏆 DAY 2 COMPLETE

Now I have covered the complete Day 2 roadmap:

```text
✅ IPv4 Address
✅ Network Part & Host Part
✅ Public IP vs Private IP
✅ Private IP Ranges
✅ Subnet Mask
✅ CIDR
✅ Subnet
✅ Network Address
✅ Broadcast Address
✅ Usable IP Addresses
✅ Default Gateway
✅ Basic Subnetting
✅ Cloud Support Troubleshooting
```

---

# 🔥 Most Important Concepts From Day 2

If I remember only these, I am doing well:

```text
IP Address
    ↓
Identifies an address used for communication
```

```text
CIDR
    ↓
Tells me the network/host boundary
```

```text
Subnet
    ↓
Smaller network inside a larger network
```

```text
Network Address
    ↓
Identifies the whole subnet
```

```text
Broadcast Address
    ↓
Represents all hosts in the subnet
```

```text
Default Gateway
    ↓
Way toward other networks
```

---

# 🧠 Day 2 — My Complete Mental Picture

This is the picture I want to keep in my head:

```text
                    IP ADDRESS
                         │
                         ↓
                Network + Host
                         │
                         ↓
                  Subnet Mask
                         │
                         ↓
                      CIDR
                         │
                         ↓
                     SUBNET
                         │
          ┌──────────────┼──────────────┐
          ↓              ↓              ↓
       Network        Usable         Broadcast
       Address           IP           Address
          │
          ↓
     Is destination
     in my network?
          │
       ┌──┴──┐
       ↓     ↓
      YES    NO
       │      │
       ↓      ↓
    Local   Route
   Network    ↓
           Gateway
              ↓
         Other Network
```

And in Cloud Support, if communication fails:

```text
Customer Problem
       ↓
Correct IP?
       ↓
Public or Private?
       ↓
Which subnet?
       ↓
Network/Host boundary?
       ↓
Route?
       ↓
Gateway?
       ↓
Security Group?
       ↓
NACL?
       ↓
Firewall?
       ↓
Port?
       ↓
Application?
```

---

# 💪 Final Day 2 Takeaway

The biggest thing I learned today is that **IP addressing and subnetting are not just calculations**.

They help me understand:

* Where a device belongs
* Which network it is part of
* Whether another IP is inside the same network
* Which addresses can be used by hosts
* Which address represents the network
* Which address is the broadcast address
* When traffic needs to leave the local network
* Where routing and gateway concepts come into the picture

The main idea I want to remember is:

> **IP tells me the address, CIDR tells me the network/host boundary, subnet divides networks into smaller networks, and the gateway provides the way toward other networks.**

And as a Cloud Support Associate, when something fails, I should not guess.

I should think:

```text
What exactly is failing?
        ↓
Is the IP correct?
        ↓
Is it public or private?
        ↓
Which subnet?
        ↓
Is the destination local or remote?
        ↓
Is the route correct?
        ↓
Is the gateway/path correct?
        ↓
Are security rules allowing traffic?
        ↓
Is the required port reachable?
        ↓
Find the evidence
        ↓
Find the root cause
        ↓
Fix it
        ↓
Test again
```

**That's my Day 2 networking foundation. 🔥**
