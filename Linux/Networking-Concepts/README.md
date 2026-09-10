# 🌐 Networking Fundamentals — IP Address, Subnet, CIDR & Ports

This is what I learned about networking fundamentals.

The whole lesson can be understood like this:

```text
IP Address → Subnet → CIDR → Private/Public Subnet → Ports
```

---

# 1. What is an IP Address?

An **IP address** is a unique address given to a device connected to a network.

### Simple Example

Imagine my home has Wi-Fi:

```text
                 HOME NETWORK
                      |
          -----------------------
          |          |          |
       Mobile      Laptop       TV
       IP: ?       IP: ?       IP: ?
```

If four devices are connected, each device needs an address so the network can identify them.

For example:

```text
Mobile  → 192.168.1.10
Laptop  → 192.168.1.11
TV      → 192.168.1.12
Tablet  → 192.168.1.13
```

This allows the network to distinguish between different devices.

### Why do we need IP addresses?

Some examples are:

* Tracking which device accessed a website
* Blocking a particular device
* Monitoring a particular device
* Controlling access to websites

Without some form of unique addressing, the network couldn't easily distinguish between devices.

---

# 2. IPv4

The IP address format I focused on in this lesson is **IPv4**.

An IPv4 address looks like:

```text
172.16.3.4
```

or:

```text
10.1.2.4
```

or:

```text
192.168.12.40
```

IPv4 contains:

```text
32 bits = 4 bytes
```

Each byte contains:

```text
8 bits
```

Therefore:

```text
8 bits + 8 bits + 8 bits + 8 bits
              ↓
           32 bits
```

The four bytes are separated using dots.

For example:

```text
172 . 16 . 3 . 4
 ↑     ↑    ↑   ↑
Byte1 Byte2 Byte3 Byte4
```

---

# 3. Why can each number only be 0–255?

This is very important.

One byte contains **8 bits**.

Each bit can have only:

```text
0 or 1
```

The bit positions are:

```text
2⁷  2⁶  2⁵  2⁴  2³  2²  2¹  2⁰
128  64   32   16   8    4    2    1
```

If all 8 bits are `1`:

```text
1 1 1 1 1 1 1 1
```

Then:

```text
128 + 64 + 32 + 16 + 8 + 4 + 2 + 1
= 255
```

Therefore:

> **One byte can represent numbers from 0 to 255.**

Since IPv4 has four bytes:

```text
0–255 . 0–255 . 0–255 . 0–255
```

### Remember

> **IPv4 = 4 bytes = 32 bits = each byte 0–255**

---

# 4. Example — Is `192.168.1.10` a valid IPv4 address?

Yes.

I check every section:

```text
192 → valid
168 → valid
1   → valid
10  → valid
```

All are between `0` and `255`.

But:

```text
192.600.1.10
```

is **not valid IPv4 notation**, because:

```text
600 > 255
```

---

# 5. Converting Decimal to Bits

I also learned how to convert a decimal number into binary.

For example, let's convert:

```text
192
```

into binary.

First, write the bit values:

```text
128  64  32  16  8  4  2  1
```

We need `192`.

```text
128 + 64 = 192
```

Therefore:

```text
128 64 32 16 8 4 2 1
 1   1  0  0 0 0 0 0
```

So:

```text
192 = 11000000
```

---

# 6. Assignment — Convert `172.32.16.1` into Bits

I need to convert **each byte separately**.

## Byte 1 → 172

Bit values:

```text
128 64 32 16 8 4 2 1
```

We need `172`:

```text
128 + 32 + 8 + 4 = 172
```

Therefore:

```text
172 = 10101100
```

---

## Byte 2 → 32

```text
128 64 32 16 8 4 2 1
 0   0  1  0 0 0 0 0
```

So:

```text
32 = 00100000
```

---

## Byte 3 → 16

```text
128 64 32 16 8 4 2 1
 0   0  0  1 0 0 0 0
```

So:

```text
16 = 00010000
```

---

## Byte 4 → 1

```text
128 64 32 16 8 4 2 1
 0   0  0  0 0 0 0 1
```

So:

```text
1 = 00000001
```

### Final Answer

Therefore:

```text
172.32.16.1
```

becomes:

```text
10101100.00100000.00010000.00000001
```

That's the binary representation of the IPv4 address.

---

# 7. What is a Subnet?

Now I move to the next concept.

**Subnet = Subnetwork**

Imagine I have one large network:

```text
               OFFICE NETWORK
              65,000 addresses
                     |
           ---------------------
           |                   |
       Finance              General
        subnet               subnet
```

Instead of putting everybody into one network, I can divide the large network into smaller networks.

These smaller networks are called **subnets**.

---

# 8. Why do we create subnets?

There are three major benefits:

## 1. Security

Sensitive systems can be separated.

```text
Finance subnet
      ↓
Sensitive data
```

## 2. Privacy

Only appropriate people/devices can access a particular network.

## 3. Isolation

If one subnet has a problem, I can isolate it from other parts of the network.

### Example

```text
              OFFICE NETWORK
                    |
           ---------------------
           |                   |
      Finance subnet       Free subnet
           |                   |
     Sensitive data      Regular users
```

If a device in the free subnet is compromised, the goal is to prevent that compromise from automatically giving access to the finance subnet.

**Important:** Subnetting itself isn't a complete security solution. The main point here is **segmentation/isolation**.

---

# 9. Private Subnet vs Public Subnet

The simple definition I learned is:

### Private Subnet

A subnet that **does not have direct access to the internet**.

### Public Subnet

A subnet that **has access to the internet**.

So I remember it like this:

```text
Private subnet → No internet access
Public subnet  → Internet access
```

In AWS, this is achieved through networking/routing configuration.

The concepts mentioned here are **route tables** and an **Internet Gateway**.

For now, the main difference I need to remember is:

```text
Private → No internet access
Public  → Internet access
```

---

# 10. What is a VPC?

The AWS example was used to explain this.

A **VPC** is essentially a private network that I create in AWS.

I can think of it like:

```text
                 VPC
                  |
         ---------------------
         |                   |
    Finance subnet       Free subnet
```

First, I create the larger network/VPC.

Then I divide it into subnets.

---

# 11. What is CIDR?

This is probably the most important part of this lesson.

**CIDR tells me how large a network/subnet is.**

For example:

```text
172.16.3.0/24
```

The `/24` is the **CIDR prefix length**.

The main calculation is:

> **32 − CIDR number = number of host bits**

Then:

> **Number of IP addresses = 2^(host bits)**

For example:

```text
/24

32 - 24 = 8

2⁸ = 256
```

Therefore:

```text
172.16.3.0/24
```

contains:

**256 IP addresses**

---

# 12. Why does `/24` give 256?

IPv4 has 32 bits.

If:

```text
/24
```

then:

```text
32 - 24 = 8
```

So 8 bits remain available for addresses.

Each bit has two possibilities:

```text
0 or 1
```

Therefore:

```text
2⁸ = 256
```

That's it.

---

# 13. Visualizing `/24`

Imagine:

```text
172.16.3.0
```

in binary:

```text
10101100.00010000.00000011.00000000
<----------- 24 -----------><--8-->
          network             host
```

The first 24 bits are the network portion.

The last 8 bits can change.

Therefore:

```text
00000000
to
11111111
```

which represents:

```text
0 to 255
```

So:

```text
172.16.3.0
172.16.3.1
172.16.3.2
...
172.16.3.255
```

There are:

```text
256 addresses
```

---

# 14. CIDR Calculation — Formula I Need to Memorize

I should remember these formulas:

```text
IPv4 = 32 bits

Host bits = 32 - CIDR

Number of IP addresses = 2^(32 - CIDR)
```

### Examples

#### `/24`

```text
32 - 24 = 8

2⁸ = 256
```

#### `/27`

```text
32 - 27 = 5

2⁵ = 32
```

#### `/28`

```text
32 - 28 = 4

2⁴ = 16
```

#### `/29`

```text
32 - 29 = 3

2³ = 8
```

#### `/30`

```text
32 - 30 = 2

2² = 4
```

#### `/31`

```text
32 - 31 = 1

2¹ = 2
```

---

# 15. Important CIDR Table

| CIDR  | Calculation | Total IP addresses |
| ----- | ----------: | -----------------: |
| `/8`  |       `2²⁴` |         16,777,216 |
| `/16` |       `2¹⁶` |             65,536 |
| `/24` |        `2⁸` |                256 |
| `/25` |        `2⁷` |                128 |
| `/26` |        `2⁶` |                 64 |
| `/27` |        `2⁵` |                 32 |
| `/28` |        `2⁴` |                 16 |
| `/29` |        `2³` |                  8 |
| `/30` |        `2²` |                  4 |
| `/31` |        `2¹` |                  2 |

The key ones I need to remember are:

```text
/8  → huge
/16 → 65,536
/24 → 256
/27 → 32
/28 → 16
/29 → 8
/30 → 4
/31 → 2
```

---

# 16. Example — Need 32 IP Addresses

Suppose the development team says:

> "I need 32 IP addresses."

I calculate:

```text
2⁵ = 32
```

Therefore, I need 5 host bits.

```text
32 - 5 = 27
```

So:

```text
/27
```

Example:

```text
192.168.3.0/27
```

gives:

```text
32 IP addresses
```

---

# 17. Example — Need 64 IP Addresses

Need:

```text
64
```

I know:

```text
2⁶ = 64
```

Therefore:

```text
32 - 6 = 26
```

So:

```text
/26
```

Example:

```text
192.168.5.0/26
```

gives:

**64 IP addresses.**

---

# 18. Example — Need 256 IP Addresses

Need:

```text
256
```

I know:

```text
2⁸ = 256
```

Therefore:

```text
32 - 8 = 24
```

So:

```text
/24
```

Example:

```text
172.16.3.0/24
```

gives:

**256 IP addresses.**

---

# 19. Example — Need 2 IP Addresses

Need:

```text
2
```

I know:

```text
2¹ = 2
```

Therefore:

```text
32 - 1 = 31
```

So:

```text
/31
```

Example:

```text
172.16.3.0/31
```

gives:

**2 addresses.**

---

# 20. Very Important Pattern

I should remember this pattern:

```text
/24 → 256
/25 → 128
/26 → 64
/27 → 32
/28 → 16
/29 → 8
/30 → 4
/31 → 2
```

Every time the CIDR increases by 1:

**the number of addresses becomes half.**

For example:

```text
/24 → 256

/25 → 128

/26 → 64

/27 → 32
```

This makes mental calculations much faster.

---

# 21. `/8`, `/16`, `/24` Explanation

I also learned the older/common class terminology:

```text
/8  → Class A
/16 → Class B
/24 → Class C
```

For this lesson, I remember them as common reference points.

### `/8`

```text
32 - 8 = 24

2²⁴ = 16,777,216
```

### `/16`

```text
32 - 16 = 16

2¹⁶ = 65,536
```

### `/24`

```text
32 - 24 = 8

2⁸ = 256
```

---

# 22. Assignment #1

Question:

> What is the number of IP addresses for `172.168.3.0/30`?

Calculation:

```text
CIDR = /30

32 - 30 = 2
```

Therefore:

```text
2² = 4
```

### Answer

```text
172.168.3.0/30 → 4 total IP addresses
```

---

# 23. Assignment #2

Question:

> What is the number of IP addresses for `10.0.0.0/8`?

Calculate:

```text
32 - 8 = 24
```

Therefore:

```text
2²⁴
```

And:

```text
2²⁴ = 16,777,216
```

### Answer

```text
10.0.0.0/8 → 16,777,216 total IP addresses
```

This can also be expressed as:

```text
256 × 256 × 256
```

which equals:

```text
16,777,216
```

---

# 24. Private IP Address Ranges

The private IPv4 ranges I need to remember are:

```text
10.0.0.0/8

172.16.0.0/12

192.168.0.0/16
```

So I should not think **every** IP beginning with `172` is private.

For example:

```text
172.16.x.x → private range
172.31.x.x → private range
```

The private `172` range is specifically:

```text
172.16.0.0 – 172.31.255.255
```

---

# 25. Why can't I randomly use public IP addresses?

Suppose a public IP address belongs to some organization.

I shouldn't simply take that public address and use it inside my private network.

For example:

```text
8.8.8.8
```

was mentioned as being associated with Google's public DNS service.

Private networks therefore use designated private address ranges to avoid conflicts with globally routable addresses.

---

# 26. Putting VPC + Subnet + CIDR Together

Now I can connect everything.

Suppose I create an AWS VPC:

```text
192.168.0.0/16
```

Calculate:

```text
32 - 16 = 16

2¹⁶ = 65,536
```

So my VPC has:

**65,536 total IP addresses** in the CIDR range.

Now I create a subnet:

```text
192.168.3.0/27
```

Calculate:

```text
32 - 27 = 5

2⁵ = 32
```

So this subnet has:

**32 total IP addresses.**

I can think about it like this:

```text
                 VPC
             192.168.0.0/16
                65,536
                   |
           -------------------
           |                 |
        Subnet 1          Subnet 2
        /27                  ...
           |
        32 IPs
```

The core relationship is:

> **VPC = larger network**

> **Subnet = smaller network inside it**

> **CIDR = tells me the size/range of that network**

---

# 27. Understanding Ports

The final concept covered was **ports**.

Imagine one virtual machine:

```text
              Virtual Machine
                    |
        ---------------------------
        |            |            |
      App 1         App 2        App 3
     Port 8080     Port 9090    Port 9191
```

A single machine can run many applications.

So an IP address alone identifies the machine, but the **port identifies the application/service endpoint on that machine**.

---

# 28. IP + Port

Suppose the server's IP is:

```text
172.16.3.4
```

and my application runs on:

```text
9191
```

I can access it using:

```text
172.16.3.4:9191
```

I remember it like this:

```text
IP address → Which machine?

Port       → Which application/service?
```

This is a very useful mental model.

---

# 29. Common Port Examples

Some port examples mentioned were:

```text
:80
:443
:3600
:8080
:9191
```

For example:

```text
3.4.5.8:9191
```

means:

```text
3.4.5.8 → IP address
9191    → port
```

So I'm telling the network:

> Connect to this machine/service using port 9191.

---

# 30. Why Do Applications Need Different Ports?

Imagine one server is running three applications:

```text
Server IP: 3.4.5.8

Application A → 8080
Application B → 9090
Application C → 9191
```

Then:

```text
3.4.5.8:8080 → Application A

3.4.5.8:9090 → Application B

3.4.5.8:9191 → Application C
```

The IP gets me to the machine.

The port directs the traffic toward the appropriate service.

---

# 31. Important Point About Ports

Ports such as `3306` were mentioned as ports generally associated with known services.

For example:

```text
3306 → commonly MySQL
80   → commonly HTTP
443  → commonly HTTPS
```

I should understand these as **standard/common port assignments**, not as ports that can never be used for anything else.

---

# 32. Entire Lesson in One Picture

```text
                         NETWORKING
                              |
       ------------------------------------------------
       |                  |             |             |
   IP Address           Subnet        CIDR          Ports
       |                  |             |             |
   Identifies          Smaller       Defines       Identifies
   device/interface    network       network size   service
       |                  |             |
     IPv4             VPC divided    /24, /27,
       |              into parts     /28 etc.
    32 bits
       |
    4 bytes
       |
   0–255 each
```

---

# 33. Most Important Formulas

### IPv4

```text
IPv4 = 32 bits
     = 4 bytes
```

### Each Byte

```text
8 bits
```

### Maximum Value of a Byte

```text
2⁸ - 1 = 255
```

### CIDR

```text
Host bits = 32 - CIDR
```

### Number of IP Addresses

```text
2^(32 - CIDR)
```

### Example

```text
/27

32 - 27 = 5

2⁵ = 32
```

So `/27` gives:

```text
32 IP addresses
```

---

# 34. Assignments — Final Answers

## Assignment 1

Convert:

```text
172.32.16.1
```

to bits.

### Answer

```text
172.32.16.1

= 10101100.00100000.00010000.00000001
```

---

## Assignment 2

How many IP addresses?

```text
172.168.3.0/30
```

Calculation:

```text
32 - 30 = 2

2² = 4
```

### Answer

**4 IP addresses**

---

## Assignment 3

How many IP addresses?

```text
10.0.0.0/8
```

Calculation:

```text
32 - 8 = 24

2²⁴ = 16,777,216
```

### Answer

**16,777,216 IP addresses**

---

# 35. Now Test Myself 🧠

I should try these without looking at the answers immediately.

### Q1

Is this a valid IPv4 address?

```text
192.168.1.50
```

### Q2

Is this valid?

```text
192.168.500.10
```

### Q3

How many bits are there in IPv4?

### Q4

How many bytes are there in IPv4?

### Q5

How many bits are in one byte?

### Q6

Convert:

```text
192
```

to binary.

### Q7

Convert:

```text
32
```

to binary.

### Q8

How many IP addresses are in:

```text
10.0.0.0/24
```

### Q9

How many IP addresses are in:

```text
10.0.0.0/26
```

### Q10

How many IP addresses are in:

```text
10.0.0.0/28
```

### Q11

I need 32 IP addresses. What CIDR should I use?

### Q12

I need 64 IP addresses. What CIDR should I use?

### Q13

I need 256 IP addresses. What CIDR should I use?

### Q14

What is the difference between a subnet and a VPC?

### Q15

What is the difference between a private subnet and public subnet according to the lesson?

### Q16

If:

```text
IP = 3.4.5.8
Port = 9191
```

how do I write the destination?

### Q17

What does the IP address tell me and what does the port tell me?

---

# 36. Answers

### Q1

```text
192.168.1.50
```

✅ **Valid**

All four values are between `0` and `255`.

---

### Q2

```text
192.168.500.10
```

❌ **Invalid**

Because:

```text
500 > 255
```

---

### Q3

```text
32 bits
```

---

### Q4

```text
4 bytes
```

---

### Q5

```text
8 bits
```

---

### Q6

```text
192 = 11000000
```

---

### Q7

```text
32 = 00100000
```

---

### Q8

```text
/24

32 - 24 = 8

2⁸ = 256
```

**Answer: 256**

---

### Q9

```text
/26

32 - 26 = 6

2⁶ = 64
```

**Answer: 64**

---

### Q10

```text
/28

32 - 28 = 4

2⁴ = 16
```

**Answer: 16**

---

### Q11

```text
32 IPs → /27
```

---

### Q12

```text
64 IPs → /26
```

---

### Q13

```text
256 IPs → /24
```

---

### Q14

**VPC = larger private network.**

**Subnet = smaller network created inside that network.**

---

### Q15

According to the lesson:

```text
Private subnet → no internet access
Public subnet  → internet access
```

---

### Q16

```text
3.4.5.8:9191
```

---

### Q17

```text
IP address → identifies/reaches the machine or network interface

Port → identifies the application/service endpoint
```

---

# 🔥 Final Mental Model

If I remember only this, I have understood the main concepts from the lesson:

```text
IP ADDRESS
    ↓
Identifies a device/interface
    ↓
IPv4 = 32 bits = 4 bytes
    ↓
Each byte = 8 bits
    ↓
Each byte = 0–255
```

```text
VPC / NETWORK
    ↓
Large network
    ↓
Can be divided
    ↓
SUBNETS
    ↓
Smaller networks
    ↓
CIDR tells the size
    ↓
/24 → 2⁸ → 256
/27 → 2⁵ → 32
/28 → 2⁴ → 16
/30 → 2² → 4
```

```text
SERVER
    ↓
IP address → which machine?
    ↓
PORT → which application?
    ↓
3.4.5.8:9191
```

## 🧠 The CIDR Trick I Need to Drill

Whenever I see:

```text
/X
```

I immediately do:

```text
32 - X
```

Then:

```text
2^(answer)
```

For example:

```text
/29
 ↓
32 - 29
 ↓
3
 ↓
2³
 ↓
8 IP addresses
```

This calculation is the foundation I need when going deeper into **subnets and CIDR ranges**.
