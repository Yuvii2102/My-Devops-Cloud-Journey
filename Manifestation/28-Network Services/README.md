# 🌐 OS DAY 12 — NETWORK SERVICES

## 🎯 What I’m Learning Today

Day 11 is complete ✅

Today I’m staying exactly within my OS syllabus:

> **Network protocols — FTP, HTTP (web servers), SMTP (mail servers)**

My goal is **not** to become a web server or mail server administrator.

I just need to understand:

* What each protocol does
* What kind of server uses it
* Which ports are commonly associated with it
* How to troubleshoot it at a **Cloud Support level**

---

# 🧠 1. What is a Network Protocol?

A **network protocol** is a set of rules that tells computers how to communicate with each other.

I can compare it to two people communicating:

```text
Person A → speaks English → Person B
```

Both people understand the rules of the language.

Computers work similarly:

```text
Computer A → Protocol → Computer B
```

Some examples I already know are:

```text
HTTP
FTP
SMTP
SSH
DNS
```

I have already learned SSH and DNS in previous days.

---

# 📁 2. FTP

FTP stands for:

> **File Transfer Protocol**

Its main purpose is:

> **Transferring files between systems.**

I can visualize it like this:

```text
Computer A
    │
    │ FTP
    ↓
Computer B

📄 file.txt
📷 image.jpg
📦 backup.zip
```

FTP is commonly associated with:

```text
TCP 21 → Control connection
```

FTP also uses a separate data connection, whose port depends on the FTP mode/configuration.

For my current syllabus, the main association I need to remember is:

```text
FTP
 ↓
File transfer
 ↓
TCP Port 21 → Control
```

---

# 🧠 3. Example of FTP

Imagine a company has an FTP server:

```text
FTP Server
    │
    ├── reports/
    ├── backups/
    └── files/
```

A client can connect to the FTP server and transfer files.

### Upload

```text
Client
  ↓
FTP Server
```

### Download

```text
FTP Server
  ↓
Client
```

So the main purpose I need to remember is:

> **FTP → File Transfer 📁**

---

# 🌐 4. HTTP

HTTP stands for:

> **HyperText Transfer Protocol**

I already encountered HTTP while learning networking.

HTTP is used for:

> **Communication between web clients and web servers.**

I can visualize it like this:

```text
Browser
   │
   │ HTTP Request
   ↓
Web Server
   │
   │ HTTP Response
   ↓
Browser
```

The default HTTP port is:

```text
TCP 80
```

So:

```text
HTTP
 ↓
TCP
 ↓
80
```

---

# 🌍 5. What is a Web Server?

A **web server** is software that handles web requests and responses.

Examples include:

```text
Nginx
Apache HTTP Server
```

I can think of it like:

```text
Browser
   │
   │ GET /
   ↓
Nginx
   │
   ↓
Web Page
```

The browser sends a request.

The web server processes that request and sends a response.

---

# 🔥 6. HTTP Request and Response

Suppose I open:

```text
http://example.com
```

Conceptually:

```text
Browser
   │
   │ HTTP Request
   ↓
Web Server
   │
   │ HTTP Response
   ↓
Browser
```

The response could contain:

```text
HTML
CSS
JavaScript
Images
```

So I can remember:

```text
HTTP
 ↓
Request + Response
 ↓
Web communication
```

---

# 🔐 7. HTTPS

I already learned HTTPS in Networking.

HTTPS is:

> **HTTP secured using TLS.**

Normally:

```text
HTTPS → TCP 443
```

So:

```text
HTTP
 ↓
TCP 80
```

and:

```text
HTTPS
 ↓
TLS
 ↓
TCP 443
```

For this OS topic, I don't need to relearn the complete TLS handshake because I already covered that in Networking.

---

# 📧 8. SMTP

SMTP stands for:

> **Simple Mail Transfer Protocol**

Its purpose is:

> **Sending email.**

I can visualize it like this:

```text
Mail Client / Mail Server
        │
        │ SMTP
        ↓
   Mail Server
```

Common SMTP ports include:

```text
25
587
465
```

For my current interview preparation, the most important thing is understanding the purpose:

> **SMTP → Sending / Relaying Email 📧**

Port 25 is traditionally associated with server-to-server SMTP, while port 587 is commonly used for message submission.

---

# 🧠 9. SMTP vs Receiving Mail

I should not confuse SMTP with receiving mail.

SMTP is primarily used for:

```text
Sending / Transferring Mail
```

Other protocols are commonly used for retrieving mail, such as:

```text
IMAP
POP3
```

However, my current syllabus specifically mentions **SMTP**, so I don't need to go deeply into IMAP and POP3 right now.

---

# 🔥 10. FTP vs HTTP vs SMTP

| Protocol | Purpose                  | Common Port           |
| -------- | ------------------------ | --------------------- |
| FTP      | File transfer            | TCP 21 control        |
| HTTP     | Web communication        | TCP 80                |
| HTTPS    | Secure web communication | TCP 443               |
| SMTP     | Sending/relaying email   | TCP 25 / 587 commonly |

### 🧠 Easiest Memory

```text
FTP
 ↓
Files 📁

HTTP
 ↓
Websites 🌐

SMTP
 ↓
Email 📧
```

And:

```text
FTP   → 21 (control)
HTTP  → 80
HTTPS → 443
SMTP  → 25 / 587 commonly
```

---

# ☁️ 11. Cloud Support Scenario — Web Server

Imagine a customer tells me:

> **“My website is not opening.”**

I should combine my **Networking + OS** knowledge.

First, I should ask:

> **“Is the web server service running?”**

If the web server is Nginx:

```bash
systemctl status nginx
```

Then I should ask:

> **“Is it listening on port 80 or 443?”**

I can check using:

```bash
ss -lntp
```

Then I investigate:

```text
Service
   ↓
Listening Port
   ↓
Firewall / Security Group
   ↓
Network
   ↓
Application
   ↓
Logs
```

This gives me a structured troubleshooting process.

---

# 🧪 12. Web Server Example

Suppose I run:

```bash
systemctl status nginx
```

and it shows:

```text
Active: failed
```

I should not randomly restart it.

Instead, I can investigate the logs:

```bash
journalctl -u nginx
```

The logs may show the actual reason for the failure.

So my troubleshooting flow becomes:

```text
Website Unavailable
       ↓
Nginx Failed
       ↓
Check Logs
       ↓
Find Actual Error
```

This is exactly how my **OS + Cloud Support** knowledge connects.

---

# 📁 13. Cloud Support Scenario — FTP

Suppose a customer says:

> **“File transfer to the server isn't working.”**

I could investigate:

```text
FTP Service Running?
       ↓
Correct Server / IP?
       ↓
Correct FTP Port?
       ↓
Security Group / Firewall?
       ↓
FTP Server Configuration?
       ↓
Authentication?
       ↓
Logs?
```

Again, I should remember:

> **Don't randomly change firewall rules. Find which layer is failing.**

---

# 📧 14. Cloud Support Scenario — SMTP

Suppose a customer says:

> **“Our application cannot send emails.”**

I could investigate:

```text
Application
    ↓
SMTP Configuration
    ↓
SMTP Server Reachable?
    ↓
Correct Port?
    ↓
Authentication / Configuration?
    ↓
Firewall / Network Rules?
    ↓
Mail-Server Logs
```

The important thing is that I understand the role of SMTP:

> **SMTP is used for sending and relaying email.**

---

# 🎤 15. Interview Questions

## ❓ What is FTP?

### Good Answer:

> **“FTP stands for File Transfer Protocol. It is used to transfer files between systems.”**

---

## ❓ What is HTTP?

### Good Answer:

> **“HTTP stands for HyperText Transfer Protocol. It is used for communication between web clients and web servers.”**

---

## ❓ What is a Web Server?

### Good Answer:

> **“A web server is software that receives HTTP/HTTPS requests and provides responses such as web pages and other web resources.”**

---

## ❓ What is SMTP?

### Good Answer:

> **“SMTP stands for Simple Mail Transfer Protocol. It is used for sending and relaying email.”**

---

## ❓ Which port does HTTP use?

### Good Answer:

> **“HTTP commonly uses TCP port 80.”**

---

## ❓ Which port does HTTPS use?

### Good Answer:

> **“HTTPS commonly uses TCP port 443.”**

---

## ❓ Which port is associated with FTP control?

### Good Answer:

> **“TCP port 21 is commonly associated with the FTP control connection.”**

---

## ❓ Which port is commonly associated with SMTP?

### Good Answer:

> **“TCP port 25 is traditionally used for SMTP server-to-server communication, while port 587 is commonly used for message submission.”**

---

# 🧠 16. BIG MEMORY TRICK

I can remember the three main network services like this:

```text
        NETWORK SERVICES

FTP
 ↓
FILES 📁

HTTP
 ↓
WEBSITES 🌐

SMTP
 ↓
EMAIL 📧
```

And their common port associations:

```text
FTP   → 21 (control)
HTTP  → 80
HTTPS → 443
SMTP  → 25 / 587 commonly
```

---

# 🧪 17. PRACTICAL

I can check whether my system has a web server installed.

### Check Nginx

```bash
which nginx
```

### Check Apache

```bash
which apache2
```

---

### Check Listening Ports

```bash
ss -lntp
```

This helps me see whether services are listening on their expected ports.

---

### If Nginx is Installed

I can check its service status:

```bash
systemctl status nginx
```

If I see a systemd-related error inside my **Docker Ubuntu container**, I should remember that this can be expected because a basic Docker container may not run `systemd`.

My EC2 Ubuntu server is a more representative environment for practicing normal Linux service management.

---

# ☁️ 18. Cloud Support Connection

I can visualize these network services like this:

```text
                    NETWORK SERVICES
                           │
          ┌────────────────┼────────────────┐
          ↓                ↓                ↓
         FTP              HTTP             SMTP
          │                │                │
          ↓                ↓                ↓
       Files 📁        Websites 🌐       Email 📧
          │                │                │
       Port 21          Port 80          Port 25/587
```

For HTTPS:

```text
HTTPS
  ↓
TLS
  ↓
TCP 443
```

---

# 🧠 MASTER MEMORY

```text
FTP
 ↓
File Transfer
 ↓
TCP 21 → Control

HTTP
 ↓
Web Communication
 ↓
TCP 80

HTTPS
 ↓
HTTP + TLS
 ↓
TCP 443

SMTP
 ↓
Send / Relay Email
 ↓
TCP 25 / 587 commonly
```

---

# 🎯 My Cloud Support Troubleshooting Mindset

Whenever a network service isn't working, I should avoid randomly changing things.

I should identify the failing layer:

```text
Service
   ↓
Port
   ↓
Firewall / Security Group
   ↓
Network
   ↓
Configuration
   ↓
Authentication
   ↓
Application
   ↓
Logs
```

The exact checks depend on the service and the error I'm seeing.

---

# 🚀 DAY 12 = COMPLETE

My main takeaway:

> **“FTP is mainly for file transfer, HTTP is for web communication, and SMTP is for sending and relaying email. When a network service fails, I should identify the failing layer instead of randomly changin**
