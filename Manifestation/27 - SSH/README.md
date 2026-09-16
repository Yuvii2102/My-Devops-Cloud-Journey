# 🔐 OS DAY 11 — SSH & REMOTE MANAGEMENT

## 🎯 What I’m Learning Today

Day 10 is complete ✅

Today I’m learning another important **Cloud Support interview topic**:

> ❓ **“A customer cannot SSH into their Linux server. How would I troubleshoot it?”**

I’m connecting SSH with the networking concepts I already learned.

---

# 🧠 1. What is Remote Management?

**Remote management** means:

> **Managing a computer/server from another computer over a network.**

For example, I don't have to physically sit in front of an AWS EC2 server.

I can manage it remotely:

```text
Your Laptop
     │
     │ Internet
     ↓
AWS EC2
Linux Server
```

I can connect to the EC2 server and run commands remotely.

---

# 🔐 2. What is SSH?

SSH stands for:

> **Secure Shell**

SSH is a protocol used to **securely connect to and manage a remote system over a network**.

I can think about it like this:

```text
Laptop
   │
   │ SSH
   ↓
Linux EC2
```

Once I connect, I can run Linux commands on the remote server.

---

# 🔢 3. Which Port Does SSH Use?

By default:

```text
SSH → TCP → Port 22
```

### 🧠 Easy Memory

```text
SSH
 ↓
TCP
 ↓
22
```

So when I troubleshoot SSH, **TCP port 22** is one of the first things I should think about.

---

# 💻 4. Basic SSH Command

From my local Linux terminal, I can use:

```bash
ssh username@server-ip
```

For example:

```bash
ssh ubuntu@3.110.20.50
```

I can understand the command like this:

```text
ssh       → SSH program
ubuntu    → Remote username
@         → At
IP        → Remote server
```

---

# ☁️ 5. AWS EC2 SSH Example

Suppose my EC2 public IP is:

```text
13.200.10.50
```

and my username is:

```text
ubuntu
```

I would typically connect using:

```bash
ssh ubuntu@13.200.10.50
```

If key-based authentication is required:

```bash
ssh -i my-key.pem ubuntu@13.200.10.50
```

The private key must also have appropriate local permissions.

---

# 🧠 6. What Happens When I Run SSH?

Suppose I run:

```bash
ssh ubuntu@13.200.10.50
```

Conceptually, the connection goes through:

```text
Your Computer
      ↓
Destination IP
      ↓
Routing
      ↓
Network Path
      ↓
EC2 Public IP
      ↓
TCP Port 22
      ↓
SSH Server
      ↓
Authentication
      ↓
Shell
```

This shows why my **Networking + OS knowledge** is important.

SSH is not just one command.

There are multiple layers involved in making the connection work.

---

# 🚨 7. BIG INTERVIEW QUESTION

## ❓ “SSH Is Not Working. How Will You Troubleshoot It?”

I should **not randomly change things**.

Instead, I should use a **layer-by-layer troubleshooting approach**.

---

# 🥇 Step 1 — Is the Server Reachable?

First, I can check basic connectivity.

For example:

```bash
ping <server-ip>
```

However, I must remember:

> **Ping failing does NOT automatically mean SSH is broken.**

Why?

Because **ICMP can be blocked** by firewall or security rules.

So I should not stop my troubleshooting just because ping fails.

---

# 🥈 Step 2 — Check the Destination IP

I should make sure that I'm connecting to the **correct IP address**.

For example:

```bash
ssh ubuntu@13.200.10.50
```

I should ask:

> **“Is this actually the server's current public IP?”**

This is especially important with EC2 because the public IP can change under certain instance lifecycle/configuration conditions.

---

# 🥉 Step 3 — Check Port 22

SSH normally uses:

```text
TCP 22
```

I need to determine whether TCP port 22 is reachable.

I can use:

```bash
nc -zv <server-ip> 22
```

For example:

```bash
nc -zv 13.200.10.50 22
```

If it cannot connect, I should investigate the network/security path.

---

# 🔥 Step 4 — Check the AWS Security Group

For Cloud Support, this is extremely important.

I should check the EC2 **Security Group**.

I need an inbound rule that allows:

```text
Protocol → TCP
Port     → 22
Source   → Appropriate client/network
```

For example:

```text
SSH
TCP
22
My IP / appropriate network
```

### ⚠️ Security Reminder

I should **not blindly open SSH to the entire internet**.

I should use an appropriate source range for the situation.

---

# 🛣️ Step 5 — Check Networking

If the Security Group looks correct, I should investigate the network path.

Depending on the setup, I can check:

```text
EC2
 ↓
Subnet
 ↓
Route Table
 ↓
Internet Gateway / Appropriate Network Path
 ↓
Internet
```

For a public EC2 instance, I should verify that it has the necessary **public addressing and routing configuration**.

---

# 🖥️ Step 6 — Is the SSH Service Running?

If I have console access or another way to access the server, I can check:

```bash
systemctl status ssh
```

On some Linux distributions or configurations, the service name may be different.

I can also investigate the service logs:

```bash
journalctl -u ssh
```

So I can think:

```text
SSH not working
      ↓
Is SSH service running?
      ↓
systemctl status ssh
      ↓
Check logs if needed
```

---

# 🔌 Step 7 — Is Anything Listening on Port 22?

I can use:

```bash
ss -lntp
```

I may see something like:

```text
LISTEN
0.0.0.0:22
```

This means something is listening on **TCP port 22** on the relevant IPv4 addresses.

I can also use:

```bash
ss -lnt
```

if I only want to see listening TCP sockets without process details.

---

# 🔐 Step 8 — Check Authentication

Suppose:

```text
Network → Working
Port 22 → Reachable
SSH Service → Running
```

but I get:

```text
Permission denied
```

Now I should investigate the **authentication/access layer**.

I should check:

* Correct username
* Correct private key
* Key permissions
* Server-side `authorized_keys`
* Authentication configuration
* Account status

I should not confuse:

```text
Connection timed out
```

with:

```text
Permission denied
```

They point to different troubleshooting areas.

---

# 🎯 9. Important SSH Error Differences

## ❌ Connection Timed Out

Example:

```text
Connection timed out
```

I should think:

```text
Network / Security Path
```

I should investigate:

```text
IP
Route
Security Group
NACL
Firewall
Port 22
```

---

## ❌ Connection Refused

Example:

```text
Connection refused
```

This can indicate that the host is reachable but **nothing is accepting the connection on that port**, or a firewall/device is actively rejecting it.

I should investigate:

```text
SSH Service
Listening Port
Host Firewall
```

---

## ❌ Permission Denied

Example:

```text
Permission denied
```

I should think:

```text
Authentication
```

I should investigate:

```text
Username
SSH Key / Password
authorized_keys
Account Configuration
```

### 🧠 Easy Memory

```text
Timeout
   ↓
Network / Security

Refused
   ↓
Service / Listening / Firewall

Permission denied
   ↓
Authentication
```

🔥 This distinction is very useful in Cloud Support interviews.

---

# 🧠 10. Complete SSH Troubleshooting Tree

I should remember this flow:

```text
             SSH NOT WORKING
                    ↓
             Correct IP/Host?
                    ↓
             Network Reachable?
                    ↓
             TCP Port 22 Reachable?
                    ↓
          AWS Security Group Okay?
                    ↓
       Route / NACL / Firewall Okay?
                    ↓
          SSH Service Running?
                    ↓
          Port 22 Listening?
                    ↓
         Authentication Correct?
                    ↓
              Check Logs
```

### ⭐ My Rule

> **I should troubleshoot from the outside toward the server, one layer at a time, instead of randomly changing settings.**

---

# 🔥 11. How Do I Check Listening Ports?

This was specifically important for my interview preparation.

I can use:

```bash
ss -lntp
```

Let's understand the command:

```text
ss  → Socket information
-l  → Listening
-n  → Numeric addresses/ports
-t  → TCP
-p  → Process information
```

Therefore:

> **`ss -lntp` shows listening TCP sockets and the associated processes where permitted.**

For example:

```text
LISTEN 0 128 0.0.0.0:22
```

This means a service is listening on **TCP port 22** on all IPv4 interfaces.

---

# 🎤 12. Interview Question — Listening Ports

### ❓ How do you check which ports are listening?

### Good Answer:

> **“I can use `ss -lntp` to check listening TCP ports and the associated processes.”**

---

# 🎤 13. Interview Question — What is SSH?

### Good Answer:

> **“SSH, or Secure Shell, is a protocol used to securely connect to and manage remote systems over a network.”**

---

# 🎤 14. Interview Question — Which Port Does SSH Use?

### Good Answer:

> **“SSH normally uses TCP port 22.”**

---

# 🎤 15. Interview Question — SSH Is Not Working

### ❓ How will you troubleshoot SSH?

### 🔥 Strong Interview Answer

> **“First, I would verify the destination IP and basic network connectivity. Then I would check whether TCP port 22 is reachable and verify the AWS Security Group and other network controls. If I have access to the server, I would check whether the SSH service is running using `systemctl status ssh` and whether port 22 is listening using `ss -lntp`. If the network connection works but authentication fails, I would check the username, SSH key and authentication configuration. Finally, I would check the relevant logs to identify the exact cause.”**

This gives me a **structured troubleshooting answer** instead of simply saying:

> “I will restart SSH.”

---

# 🧪 16. PRACTICAL

I can practice the following commands in my Ubuntu environment.

### Step 1 — Check My Current User

```bash
whoami
```

---

### Step 2 — Check SSH Service

```bash
systemctl status ssh
```

If I'm inside my **Docker Ubuntu container** and `systemctl` gives a systemd-related error, that can be expected for many basic containers.

The container may not be running `systemd` as PID 1.

---

### Step 3 — Check Listening TCP Ports

```bash
ss -lntp
```

If `ss` is not installed, I should note the exact error and investigate from there.

---

# ☁️ 17. AWS CLOUD SUPPORT CONNECTION

I can visualize an SSH connection to an EC2 instance like this:

```text
Customer Laptop
      │
      │ SSH / TCP 22
      ↓
   Internet
      │
      ↓
Internet Gateway
      │
      ↓
    AWS VPC
      │
      ↓
    Subnet
      │
      ↓
 Security Group
      │
      ↓
     EC2
      │
      ↓
 SSH Service
      │
      ↓
Authentication
```

If SSH fails, I need to find:

> **“Which layer failed?”**

That's the troubleshooting mindset I'm building through my **Networking + OS + AWS Cloud Support preparation**.

---

# 🧠 MASTER MEMORY

```text
SSH
 ↓
Secure Shell
 ↓
Remote Management
 ↓
TCP Port 22
 ↓
Correct IP
 ↓
Network Path
 ↓
Security Group
 ↓
Route / NACL / Firewall
 ↓
SSH Service
 ↓
Port Listening
 ↓
Authentication
 ↓
Logs
```

### 🔑 Three Errors I Must Remember

```text
TIMEOUT
→ Think Network / Security

REFUSED
→ Think Service / Listening / Firewall

PERMISSION DENIED
→ Think Authentication
```

---

# ✅ DAY 11 CHECKLIST

I should now understand:

* [x] Remote management
* [x] SSH
* [x] Secure Shell
* [x] SSH uses TCP
* [x] SSH default port 22
* [x] Basic SSH command
* [x] SSH with `.pem` key
* [x] What happens during an SSH connection
* [x] Checking the destination IP
* [x] Why ping failure doesn't always mean SSH failure
* [x] Checking TCP port 22
* [x] AWS Security Groups
* [x] Network path
* [x] Subnet
* [x] Route Table
* [x] Internet Gateway / appropriate network path
* [x] Checking the SSH service
* [x] `systemctl status ssh`
* [x] `journalctl -u ssh`
* [x] Checking listening ports
* [x] `ss -lntp`
* [x] `ss -lnt`
* [x] Authentication troubleshooting
* [x] Timeout vs refused vs permission denied
* [x] Layer-by-layer troubleshooting
* [x] Cloud Support SSH troubleshooting
* [x] Interview-ready SSH answers

# 🚀 DAY 11 = COMPLETE

My main takeaway:

> **“When SSH fails, I should not randomly change things. I should identify the failing layer — IP, network, port 22, AWS security controls, SSH service, listening port, authentication, or logs — and troubleshoot from there.”**
