# 🚀 DAY 3 — SUBNETTING

## 🎯 Today's Roadmap

```text
1️⃣ Quick Day 2 revision
2️⃣ Why do we subnet?
3️⃣ Host bits
4️⃣ Total IPs calculation
5️⃣ Usable IP calculation
6️⃣ /25
7️⃣ /26
8️⃣ /27
9️⃣ /28
🔟 Find Network + Broadcast + Usable range
1️⃣1️⃣ Cloud/AWS subnetting scenarios
1️⃣2️⃣ Practice questions
```

---

# 🎯 Goal for Today

By the end, if I am given:

```text
192.168.1.0/26
```

I should be able to tell:

```text
Network Address
Broadcast Address
Usable IP range
Number of usable IPs
```

**without guessing.**

---

# 1️⃣ Quick Day 2 Revision

Yesterday, we worked with:

```text
10.0.1.25/24
```

We learned:

```text
CIDR        → /24
Subnet Mask → 255.255.255.0

Network     → 10.0.1.0
Broadcast   → 10.0.1.255

Usable      → 10.0.1.1 – 10.0.1.254
```

And:

```text
/24
 ↓
24 network bits
8 host bits
```

Therefore:

```text
2⁸ = 256 total addresses

256 - 2 = 254 usable addresses
```

---

# 2️⃣ Why Do We Subnet?

Imagine my company has:

```text
10.0.0.0/24
```

This gives:

```text
256 total addresses
```

But suppose I have different teams:

```text
Web      → 50 devices
App      → 50 devices
Database → 30 devices
```

Instead of keeping everything inside one network, I can divide the network into smaller networks.

This is called **subnetting**.

```text
              10.0.0.0/24
                    │
          ┌─────────┼─────────┐
          ↓         ↓         ↓
        Web        App       DB
       subnet     subnet    subnet
```

Subnetting gives me better:

* Organization
* Network control
* Security

---

# 3️⃣ The BIG Idea Today

The main thing I need to remember is:

> **When I increase the CIDR number, I take some host space and use it to create smaller networks.**

For example:

```text
/24 → /25
```

The network becomes smaller.

Then:

```text
/25 → /26
```

It becomes smaller again.

I can think about it like this:

```text
/24
 │
 ├── /25
 │
 │    ├── /26
 │    └── /26
 │
 └── ...
```

I don't need to calculate everything at once.

I'll do it step by step.

---

# 4️⃣ Starting With `/25`

I already know:

```text
192.168.1.0/24
```

has:

```text
256 total IPs
254 usable IPs
```

Now I split it into **two `/25` networks**:

```text
192.168.1.0/24
       ↓
 ┌─────┴─────┐
 ↓           ↓
/25         /25
```

The two networks are:

```text
192.168.1.0/25
192.168.1.128/25
```

---

## 🟢 First `/25` Subnet

```text
192.168.1.0/25
```

Range:

```text
Network   → 192.168.1.0
Usable    → 192.168.1.1 – 192.168.1.126
Broadcast → 192.168.1.127
```

---

## 🔵 Second `/25` Subnet

```text
192.168.1.128/25
```

Range:

```text
Network   → 192.168.1.128
Usable    → 192.168.1.129 – 192.168.1.254
Broadcast → 192.168.1.255
```

So the complete split looks like:

```text
        192.168.1.0/24
                │
       ┌────────┴────────┐
       ↓                 ↓
192.168.1.0/25     192.168.1.128/25
       │                 │
   .0 → .127         .128 → .255
```

---

# 🧮 How Many IPs in `/25`?

For `/25`:

```text
32 - 25 = 7 host bits
```

Therefore:

```text
2⁷ = 128 total addresses
```

And:

```text
128 - 2 = 126 usable addresses
```

So each `/25` has:

```text
128 total addresses
126 usable addresses
```

---

# 🧠 The Pattern

For `/24`:

```text
256 total
254 usable
```

For `/25`:

```text
128 total
126 usable
```

So my main understanding is:

> **Every time I increase the CIDR, the number of available addresses gets smaller.**

---

# 5️⃣ `/26` Practice

Now I move from `/25` to `/26`.

A `/24` can be divided into **four `/26` subnets**.

The pattern is:

```text
0
64
128
192
```

So:

```text
192.168.1.0/26
192.168.1.64/26
192.168.1.128/26
192.168.1.192/26
```

Each `/26` contains:

```text
64 total addresses
62 usable addresses
```

The important pattern is:

```text
/24
 ↓
/26

1 network
 ↓
4 smaller networks
```

---

# 6️⃣ Finding Network + Broadcast + Usable Range

For a `/26`, the blocks are:

```text
0 – 63
64 – 127
128 – 191
192 – 255
```

If the IP is:

```text
192.168.10.130/26
```

I first find which block contains `.130`.

```text
0 – 63
64 – 127
128 – 191  ← 130 is here
192 – 255
```

Therefore, the subnet is:

```text
192.168.10.128/26
```

### Network Address

The first address in the block:

```text
192.168.10.128
```

### Broadcast Address

The last address in the block:

```text
192.168.10.191
```

### Usable IP Range

Everything between network and broadcast:

```text
192.168.10.129 – 192.168.10.190
```

So:

| Address       | Value                             |
| ------------- | --------------------------------- |
| **Subnet**    | `192.168.10.128/26`               |
| **Network**   | `192.168.10.128`                  |
| **Your IP**   | `192.168.10.130`                  |
| **Usable**    | `192.168.10.129 – 192.168.10.190` |
| **Broadcast** | `192.168.10.191`                  |

### 💡 Shortcut

I can remember:

```text
Find the block containing the IP
        ↓
First number = Network
        ↓
Last number = Broadcast
        ↓
Everything between = Usable
```

---

# 7️⃣ Final Interview Questions

## ❓ Question 1

What is the difference between:

```text
Network Address
Broadcast Address
Usable IP Address
```

### ✅ Answer

**Network Address**

Identifies the entire subnet.

Example:

```text
192.168.1.0/24
```

Here:

```text
192.168.1.0
```

is the **Network Address**.

---

**Broadcast Address**

Used to represent all hosts in that subnet.

For:

```text
192.168.1.0/24
```

the broadcast address is:

```text
192.168.1.255
```

---

**Usable IP Addresses**

These are the addresses that can be assigned to hosts in the traditional subnetting model.

For `/24`:

```text
192.168.1.1 – 192.168.1.254
```

So:

```text
Network   → .0
Usable    → .1 – .254
Broadcast → .255
```

---

# ❓ Question 2

Given:

```text
10.0.1.50/24
10.0.2.50/24
```

Are they in the same subnet?

### ✅ Answer

For `/24`, the first three octets represent the network portion.

First IP:

```text
10.0.1.50
Network = 10.0.1.0
```

Second IP:

```text
10.0.2.50
Network = 10.0.2.0
```

Therefore:

> **They are in different subnets.** ✅

```text
10.0.1.0/24
       ↕
    different
       ↕
10.0.2.0/24
```

---

# ❓ Question 3

A `/24` network needs to be divided into **4 equal subnets**.

What CIDR should I use?

### ✅ Answer

I need:

```text
4 subnets
```

And:

```text
2² = 4
```

So I borrow **2 bits**.

```text
/24 + 2 = /26
```

Therefore:

> **Answer = `/26`** ✅

The four subnets are:

```text
192.168.1.0/26
192.168.1.64/26
192.168.1.128/26
192.168.1.192/26
```

---

# 🏆 DAY 3 COMPLETE

At the end of Day 3, my understanding is:

```text
IPv4
 ↓
Network / Host
 ↓
Private / Public IP
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
Usable IP Range
 ↓
Subnetting
 ↓
AWS Subnet Scenarios
 ↓
Cloud Support Troubleshooting
```

## 🔥 My Day 3 Takeaway

The biggest thing I learned today is that **subnetting means dividing one larger network into smaller networks**.

I also learned how to use the CIDR value to calculate:

```text
Total IPs
Usable IPs
Network Address
Broadcast Address
Usable IP Range
```

And for subnetting practice, I learned the `/26` block pattern:

```text
0, 64, 128, 192
```

So when I see something like:

```text
192.168.10.130/26
```

I should not guess.

I should find the block first:

```text
128 – 191
```

Then:

```text
Network   → 192.168.10.128
Broadcast → 192.168.10.191
Usable    → 192.168.10.129 – 192.168.10.190
```

**Day 3 → Completed ✅🔥**
