<div align="center">

# 🚀 DAY 5 — TCP, UDP & PORTS

</div>

## 📚 Topics Covered

1. TCP 3-Way Handshake
2. TCP Handshake in Detail
3. Ports & Port Numbers
4. Why Different Applications Use Different Port Numbers
5. TCP vs UDP
6. Sequence & Acknowledgement Numbers
7. Problems with Sequence & ACK Numbers
8. Flow Control
9. Common Ports & Protocols
10. Practice + Cloud Support Interview Questions

---

# 1️⃣ 🟢 What is TCP?

**TCP = Transmission Control Protocol**

TCP is a protocol used to establish **reliable communication between two devices**.

I can think about two computers communicating like this:

```text
Client                         Server
  │                              │
  │────── TCP connection ───────→│
  │                              │
  │←────── reliable data ────────│
  │                              │
```

TCP makes sure communication is **reliable and properly managed**.

---

# 2️⃣ 📦 Why Do We Need TCP?

Imagine I'm sending an important document to someone.

I don't simply send the document and assume they received it.

I want to know:

> "Did you receive it?"

They reply:

> "Yes."

If something is missing, I want to know so it can be sent again.

TCP works with this kind of **acknowledgement and reliability**.

---

# 3️⃣ 🤝 TCP 3-Way Handshake

Suppose a client wants to communicate with a server.

Before sending application data, TCP establishes a connection.

This is where the famous:

# **TCP 3-Way Handshake**

comes in.

The three steps are:

```text
Client                         Server

   SYN  ─────────────────────→
        ←──────────────── SYN-ACK
   ACK  ─────────────────────→

        Connection established
```

The three steps are:

```text
SYN
 ↓
SYN-ACK
 ↓
ACK
 ↓
TCP connection established
```

---

# 4️⃣ 🧠 Understanding SYN, SYN-ACK & ACK

## SYN

SYN means:

> **"I want to establish a TCP connection."**

---

## SYN-ACK

SYN-ACK means:

> **"I received your request, and I also want to establish the connection."**

---

## ACK

ACK means:

> **"I acknowledge/confirm what you sent."**

So I can remember it like this:

```text
SYN
 ↓
I want to connect.

SYN-ACK
 ↓
I received your request + I'm ready.

ACK
 ↓
I received your response.
```

Then:

```text
✅ TCP connection established
```

---

# 5️⃣ ☁️ Cloud Support Example — SSH to EC2

Suppose I'm connecting to an EC2 server using SSH.

The basic path is:

```text
Your Computer
      ↓
EC2 Public / Private IP
      ↓
TCP Port 22
```

Before SSH data can be exchanged, TCP needs to establish the connection.

So:

```text
Client                         EC2

SYN  ────────────────────────→
     ←────────────────── SYN-ACK
ACK  ────────────────────────→

       TCP connection established
```

**Then** the SSH communication can proceed.

### 🎯 Important Point

> **TCP uses a 3-way handshake to establish a TCP connection before reliable communication begins.**

---

# 6️⃣ 🔢 Sequence Numbers

TCP also uses **sequence numbers**.

The purpose is to keep track of data and its order.

I can remember:

```text
SEQ
 ↓
Tracks data / order
```

This helps TCP properly manage the data being communicated.

---

# 7️⃣ ✅ Acknowledgement Numbers

TCP also uses **acknowledgement numbers**.

I can remember:

```text
ACK
 ↓
Indicates what is expected next
```

So:

```text
SEQ → Tracks data / order

ACK → Indicates what is expected next
```

These numbers help TCP keep track of communication between the two sides.

---

# 8️⃣ ⚠️ Problems with Sequence & ACK Numbers

TCP has to keep track of sequence and acknowledgement information while communicating.

The important idea from this section is that TCP uses:

```text
Sequence Numbers
        +
Acknowledgement Numbers
        ↓
Track communication
```

This allows TCP to properly manage the order and confirmation of data.

---

# 9️⃣ 🌊 Flow Control

One important TCP concept is **Flow Control**.

Imagine:

```text
Fast Sender
    ↓
Too much data
    ↓
Slow Receiver
```

The sender can potentially send data faster than the receiver can handle it.

TCP flow control prevents this situation.

### 🎯 Simple Definition

> **Flow control prevents a fast sender from overwhelming a slower receiver.**

So:

```text
Fast Sender
     ↓
  TCP Flow Control
     ↓
Slow Receiver
```

---

# 🔟 🔌 What is a Port?

When a device communicates over a network, we don't only need to know the destination IP address.

We also need to identify the application/service we want to communicate with.

That's where **ports** come in.

Think:

```text
IP Address
    ↓
Which device?
    ↓
Port Number
    ↓
Which application/service?
```

Different applications use different port numbers.

---

# 1️⃣1️⃣ Why Do Different Applications Use Different Ports?

Imagine one server is running multiple services.

For example:

```text
Server
  │
  ├── SSH
  ├── HTTP
  ├── HTTPS
  └── DNS
```

The port number helps identify which service the communication is intended for.

So I can think about it as:

```text
IP Address → Identifies the destination
Port       → Identifies the service/application
```

---

# 1️⃣2️⃣ 🔥 Common Ports & Protocols

These are the important ports from today's learning:

|    Port | Protocol / Service |
| ------: | ------------------ |
|  **22** | SSH                |
|  **53** | DNS                |
|  **80** | HTTP               |
| **443** | HTTPS              |

### 🧠 Easy Memory

```text
22  → SSH
53  → DNS
80  → HTTP
443 → HTTPS
```

---

# 1️⃣3️⃣ 🔄 TCP vs UDP

The two important transport protocols we discussed are:

```text
TCP
UDP
```

## TCP

TCP is:

> **Reliable and connection-oriented.**

TCP establishes a connection and uses mechanisms such as acknowledgements to manage reliable communication.

```text
TCP
 ↓
Connection
 ↓
Reliable communication
```

---

## UDP

UDP is:

> **Connectionless and has less overhead.**

UDP does not establish the same type of connection as TCP before sending data.

```text
UDP
 ↓
Connectionless
 ↓
Less overhead
```

### 🧠 Quick Comparison

| TCP                   | UDP                         |
| --------------------- | --------------------------- |
| Reliable              | Connectionless              |
| Connection-oriented   | No connection establishment |
| Uses acknowledgements | Less overhead               |
| Uses TCP handshake    | No TCP 3-way handshake      |

---

# 1️⃣4️⃣ 🧠 TCP 3-Way Handshake — Final Understanding

The complete process is:

```text
Client                         Server

   SYN  ─────────────────────→
        ←──────────────── SYN-ACK
   ACK  ─────────────────────→

        Connection established
```

### Step-by-step

**Step 1 — SYN**

```text
Client → Server
SYN
```

Client says:

> "I want to establish a connection."

**Step 2 — SYN-ACK**

```text
Server → Client
SYN-ACK
```

Server says:

> "I received your request and I'm ready."

**Step 3 — ACK**

```text
Client → Server
ACK
```

Client confirms the response.

Then:

```text
✅ Connection established
```

---

# 1️⃣5️⃣ ☁️ Cloud Support Troubleshooting

Now let's apply the concepts to a real Cloud Support scenario.

Suppose a customer says:

> **"I can ping my EC2 server, but I cannot connect to SSH."**

We know:

```text
Ping → ✅
SSH  → ❌
```

The first thing I should think about is:

```text
SSH → Which port?
```

SSH commonly uses:

```text
TCP Port 22
```

So I can follow this troubleshooting flow:

```text
EC2 reachable
      ↓
TCP Port 22
      ↓
Security Group
      ↓
NACL / Firewall
      ↓
SSH Service
```

### 🎯 Interview Answer

> **"Since the EC2 instance is reachable but SSH is failing, I'll check TCP port 22, then the Security Group, NACL/firewall, and finally whether the SSH service is running."**

---

# 1️⃣6️⃣ 🧪 Practice Questions

## Question 1 — Flow Control

A sender is much faster than the receiver.

Which TCP mechanism prevents the sender from overwhelming the receiver?

### ✅ Answer

> **Flow Control**

```text
Fast Sender
    ↓
Too much data
    ↓
Flow Control
    ↓
Slow Receiver
```

### Interview Answer

> **"Flow control prevents a fast sender from overwhelming a slower receiver."**

---

# Question 2 — SSH

A customer says:

```text
Ping → ✅
SSH  → ❌
```

Which port does SSH commonly use?

### ✅ Answer

> **TCP Port 22**

Troubleshooting path:

```text
TCP 22
  ↓
Security Group
  ↓
NACL / Firewall
  ↓
SSH Service
```

---

# Question 3 — TCP Handshake

Complete the sequence:

```text
Client → Server : ______
Server → Client : ______
Client → Server : ______
```

### ✅ Answer

```text
Client → Server : SYN
Server → Client : SYN-ACK
Client → Server : ACK
```

### Purpose

The purpose of the 3-step process is to:

> **Establish a TCP connection between the client and server before data communication begins.**

I can think about it like:

```text
Client: "Can we connect?"       → SYN

Server: "Yes, I received you."  → SYN-ACK

Client: "Confirmed."             → ACK

             ↓
      Connection established ✅
```

---

# 🏆 DAY 4 — COMPLETE

Today I covered:

* ✅ TCP
* ✅ TCP 3-Way Handshake
* ✅ SYN / SYN-ACK / ACK
* ✅ Sequence Numbers
* ✅ Acknowledgement Numbers
* ✅ TCP vs UDP
* ✅ Ports & Port Numbers
* ✅ Why applications use different ports
* ✅ Flow Control
* ✅ Common Ports & Protocols
* ✅ Cloud Support troubleshooting
* ✅ Interview questions

---

# 🔥 Important Memory Points

```text
TCP
↓
Reliable + Connection-oriented
```

```text
UDP
↓
Connectionless + Less overhead
```

### Common Ports

```text
22  → SSH
53  → DNS
80  → HTTP
443 → HTTPS
```

### TCP Handshake

```text
SYN
 ↓
SYN-ACK
 ↓
ACK
```

### Sequence & ACK

```text
SEQ
 ↓
Tracks data / order

ACK
 ↓
Indicates what is expected next
```

### Flow Control

```text
Fast Sender
     ↓
Flow Control
     ↓
Slow Receiver
```

> **Flow control prevents a fast sender from overwhelming a slower receiver.**

---

# 🧠 DAY 4 — FINAL MENTAL MODEL

```text
TCP
 ↓
Connection Establishment
 ↓
SYN → SYN-ACK → ACK
 ↓
Connection Established
 ↓
Data Communication
 ↓
SEQ + ACK
 ↓
Reliable Communication
 ↓
Flow Control
 ↓
Prevents Fast Sender from
Overwhelming Slow Receiver
```

And when troubleshooting an application connection:

```text
IP Address
    ↓
Port
    ↓
Protocol
    ↓
Security Group
    ↓
NACL / Firewall
    ↓
Service
```

### 🎯 My Day 4 Takeaway

> **TCP gives me reliable, connection-oriented communication. The TCP connection starts with the 3-way handshake: SYN → SYN-ACK → ACK. Ports help identify the service I want to communicate with. TCP also uses sequence and acknowledgement numbers to track communication, while flow control prevents a fast sender from overwhelming a slower receiver.**

# 🚀 DAY 4 — COMPLETED ✅
