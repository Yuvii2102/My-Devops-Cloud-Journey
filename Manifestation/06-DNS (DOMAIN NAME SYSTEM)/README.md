<div align="center">

# 🚀 DAY 5 — DNS (DOMAIN NAME SYSTEM)

</div>

---

## 📚 Topics Covered

1. What is DNS?
2. Domain Name vs IP Address
3. What happens when you type `amazon.com`?
4. Basic DNS Flow
5. DNS Port 53
6. DNS + UDP
7. What happens after DNS gives the IP?
8. Complete DNS Flow
9. DNS Troubleshooting
10. DNS Troubleshooting Flow
11. DNS Resolves but Website Doesn't Open
12. DNS vs IP
13. DNS and Cloud Support Mindset
14. Important Ports
15. DNS Interview Questions
16. Day 5 Quick Revision

---

# 1️⃣ 🌐 What is DNS?

**DNS = Domain Name System**

DNS converts a **domain name into an IP address**.

For example:

```text
amazon.com
     ↓
    DNS
     ↓
IP address
```

### 🤔 Why Do We Need DNS?

Computers communicate using **IP addresses**, but humans prefer names.

Instead of remembering:

```text
some IP address
```

we use:

```text
amazon.com
```

DNS helps find the IP address associated with that domain.

### 📱 Simple Example

I can think of DNS like my phone's contacts:

```text
Name                 Phone Number
----------------------------------
John          →      9876543210
```

Similarly:

```text
Domain Name          IP Address
--------------------------------
amazon.com     →     Server IP
```

So:

> **DNS is like the internet's name-to-IP lookup system.**

---

# 2️⃣ 🌍 Domain Name vs IP Address

## Domain Name

A human-friendly name:

```text
amazon.com
```

## IP Address

The network address of the destination:

```text
Example:
X.X.X.X
```

So the basic flow is:

```text
Domain
  ↓
DNS
  ↓
IP Address
```

Then communication can happen using the IP.

---

# 3️⃣ 🔥 What Happens When I Type `amazon.com`?

This is one of the most important Day 5 questions.

Suppose I open my browser and type:

```text
amazon.com
```

What happens?

---

## Step 1 — I Enter the Domain

I type:

```text
amazon.com
```

into my browser.

The computer needs to know:

> **"What IP address belongs to amazon.com?"**

So it needs DNS.

---

## Step 2 — DNS Lookup

The device sends a DNS query asking for the IP address of:

```text
amazon.com
```

Conceptually:

```text
Client
   ↓
DNS Query
   ↓
DNS Server
```

The DNS server finds the appropriate IP information and sends a response.

```text
DNS Server
   ↓
IP Address
   ↓
Client
```

Now the client knows where to send the request.

---

# 4️⃣ 🔄 Basic DNS Flow

I can remember this diagram:

```text
          DNS QUERY
Client ───────────────→ DNS Server
                         │
                         │ Finds IP
                         ↓
Client ←─────────────── DNS Response
          IP Address
```

In simple words:

```text
Client:
"What is the IP of amazon.com?"

DNS:
"The IP is X.X.X.X."

Client:
"Okay, now I know where to connect."
```

---

# 5️⃣ 🔌 DNS Uses Port 53

DNS commonly uses:

```text
Port 53
```

So I need to remember:

```text
DNS → Port 53
```

DNS can use **UDP or TCP**, depending on the situation.

For the level I need here:

```text
Normal DNS Query
        ↓
Commonly UDP 53
```

DNS can also use **TCP 53 when needed**.

---

# 6️⃣ 📦 DNS + UDP

A basic DNS request commonly looks like:

```text
Client
   ↓
UDP
   ↓
Port 53
   ↓
DNS Server
```

The DNS server sends the response back.

This is one reason **UDP is commonly associated with DNS**.

---

# 7️⃣ 🌐 What Happens After DNS Gives the IP?

This is important:

> **DNS itself doesn't load the website.**

DNS's job is to help the client find the IP.

The simplified flow is:

```text
You type:
amazon.com
      ↓
DNS lookup
      ↓
Get IP address
      ↓
Connect to server
      ↓
Web communication
```

So:

> **DNS finds the destination IP. The actual application communication happens afterward.**

---

# 8️⃣ 🔄 Complete Simple Flow

Let's put everything together:

```text
                STEP 1
         You type amazon.com
                  ↓
                STEP 2
             DNS lookup
                  ↓
                STEP 3
          DNS returns IP address
                  ↓
                STEP 4
       Client connects to that IP
                  ↓
                STEP 5
        Web communication begins
```

For HTTPS, the communication will involve:

```text
TCP 443
   ↓
TLS / HTTPS
   ↓
Web Server
```

The HTTP/HTTPS + TLS details will be covered later according to the learning flow.

---

# 9️⃣ 🛠️ DNS Troubleshooting

This is **very important for Cloud Support**.

## Scenario 1

A customer says:

> **"The website works when I use the IP address, but not when I use the domain name."**

For example:

```text
IP Address → ✅
amazon.com → ❌
```

### First Suspect

**DNS**

Because:

```text
IP works
   ↓
Network path is likely working
   ↓
Domain doesn't work
   ↓
Check DNS
```

---

# 🔟 🔍 DNS Troubleshooting Flow

If a domain isn't working:

```text
Domain not working
       ↓
Check DNS resolution
       ↓
Does domain resolve?
       ↓
Is returned IP correct?
       ↓
Check connectivity to IP
       ↓
Check required port
       ↓
Check security / firewall
       ↓
Check application
       ↓
Check logs
```

### Useful Basic Commands

```bash
nslookup example.com
```

or:

```bash
dig example.com
```

These help check DNS resolution.

---

# 1️⃣1️⃣ ⚠️ DNS Resolves but Website Doesn't Open

Suppose:

```text
DNS Resolution → ✅
IP Address     → Correct
Website        → ❌
```

I shouldn't keep blaming DNS.

I should move to the next part:

```text
DNS ✅
 ↓
IP / Reachability
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

For HTTPS:

```text
Port 443
   ↓
TLS
   ↓
Certificate / Configuration
   ↓
Application
```

---

# 1️⃣2️⃣ 🧠 DNS vs IP — Important Difference

I shouldn't confuse these:

```text
Domain Name
     ↓
Needs DNS Resolution
     ↓
IP Address
     ↓
Network Communication
```

For example:

```text
example.com → 10.0.1.25
```

DNS helps resolve:

```text
example.com
      ↓
10.0.1.25
```

After that, network communication uses the IP.

---

# 1️⃣3️⃣ ☁️ DNS and the Cloud Support Mindset

Suppose a customer says:

> **"My application is down."**

I shouldn't immediately assume that the application itself is broken.

I should break the problem down:

```text
Can domain resolve?
       ↓
      DNS

Can IP be reached?
       ↓
   Connectivity

Can required port be reached?
       ↓
Port / SG / NACL / Firewall

Is application running?
       ↓
    Service

Any errors?
       ↓
     Logs
```

This is the troubleshooting mindset I've been building since Day 1.

---

# 1️⃣4️⃣ 🔌 Important Ports to Remember

From the sheet:

```text
22   → SSH
53   → DNS
80   → HTTP
443  → HTTPS
```

For DNS specifically:

```text
DNS → Port 53
```

---

# 1️⃣5️⃣ 🎯 DNS Interview Questions

## ❓ Q1. What is DNS?

### ✅ Answer

> **DNS stands for Domain Name System. It translates domain names into IP addresses so clients can communicate with the correct destination.**

---

## ❓ Q2. Why do we need DNS?

### ✅ Answer

> **Humans can easily remember domain names, while computers communicate using IP addresses. DNS maps the domain name to the required IP address.**

---

## ❓ Q3. What happens when you type `amazon.com`?

### ✅ Answer

> **The client performs a DNS lookup for amazon.com. DNS returns the corresponding IP address. The client then uses that IP to establish communication with the destination server and access the website.**

---

## ❓ Q4. Which port does DNS use?

### ✅ Answer

> **DNS commonly uses port 53. Normal DNS queries commonly use UDP 53, while TCP 53 can also be used when required.**

---

## ❓ Q5. The IP works but the domain doesn't. What do you check?

### ✅ Answer

> **I would first check DNS resolution and verify that the domain resolves to the correct IP address.**

---

## ❓ Q6. DNS resolves correctly but the website doesn't open. What next?

### ✅ Answer

> **I would move beyond DNS and check IP connectivity, routing, the required port, Security Group, NACL/firewall, the application/service, and logs.**

---

# 🧠 DAY 5 — QUICK REVISION

The main flow I need to remember is:

```text
             USER
               ↓
        Types amazon.com
               ↓
             DNS
               ↓
       Find IP Address
               ↓
        IP Address Found
               ↓
       Connect to Server
               ↓
       Port 80 / 443
               ↓
      Web Communication
               ↓
          Application
```

## ⭐ Most Important Points

```text
DNS
 ↓
Domain → IP
```

```text
DNS
 ↓
Port 53
```

```text
Normal DNS Query
 ↓
Commonly UDP
```

```text
IP works but domain doesn't
 ↓
Check DNS
```

```text
DNS works but website doesn't
 ↓
Move to connectivity
 ↓
Port
 ↓
Security
 ↓
Application
```

---

# 🏆 DAY 5 COMPLETE

```text
Day 1 → Networking Fundamentals       ✅
Day 2 → IP Addressing                 ✅
Day 3 → Subnetting                    ✅
Day 4 → TCP, UDP & Ports              ✅
Day 5 → DNS                           ✅
```

## 🔥 Final Day 5 Takeaway

> **DNS is the name-to-IP lookup system. When I enter a domain such as `amazon.com`, the client performs a DNS lookup, receives the corresponding IP address, and then communicates with the destination using the required network protocol and port. For Cloud Support troubleshooting, if the IP works but the domain doesn't, I should check DNS first. If DNS resolves correctly but the website still doesn't work, I should move on to connectivity, routing, ports, security, the application, and logs.**

# 🚀 DAY 5 — COMPLETED ✅
