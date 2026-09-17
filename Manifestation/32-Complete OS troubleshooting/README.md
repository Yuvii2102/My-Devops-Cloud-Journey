🖥️ OS DAY 16 — COMPLETE OS TROUBLESHOOTING

🎯 What I’m Learning Today

Today I’m bringing everything I learned in OS together.

I need to start thinking like a Cloud Support Engineer.

The most important rule is:

«❌ Don't randomly restart the server.
✅ Find the problem layer → collect evidence → fix it → verify.»

---

1️⃣ Scenario: Linux Machine Is Very Slow 🐌

Imagine a customer tells me:

«“My Linux server has become very slow.”»

I should not immediately reboot the server.

I should troubleshoot step by step.

---

Step 1 — Check CPU

I can run:

top

I should look for:

- High "%CPU"
- Which process is consuming CPU
- Load average

I can also use:

ps aux --sort=-%cpu | head

This shows processes using the most CPU.

My thought process:

Linux Server Slow
       ↓
Check CPU
       ↓
top
       ↓
Find High-CPU Process
       ↓
Investigate

---

Step 2 — Check Memory

I can run:

free -h

I should look at:

- RAM available
- Used memory
- Swap

If memory is heavily used, I can find which processes are consuming the most memory:

ps aux --sort=-%mem | head

My thought process:

Memory Problem?
      ↓
free -h
      ↓
Check available memory
      ↓
Check swap
      ↓
ps aux --sort=-%mem | head
      ↓
Find high-memory process

---

Step 3 — Check Load

I can run:

uptime

I may see:

load average: 2.00, 1.50, 1.20

These represent approximately:

2.00 → 1 minute
1.50 → 5 minutes
1.20 → 15 minutes

Load tells me about the amount of work waiting for CPU/resources.

⚠️ Important

I must interpret load together with:

- Number of CPU cores
- Workload

I should not use a single fixed load value to automatically decide that a server is unhealthy.

---

Step 4 — Check Disk Space

I can run:

df -h

If a filesystem is almost full, applications may start experiencing problems.

I should investigate further instead of assuming that CPU or memory is the problem.

---

Step 5 — Find Which Directories Are Consuming Space

I can use:

du -sh /*

or:

du -sh /var/*

This helps me identify directories consuming significant disk space.

---

Step 6 — Check Historical CPU Information

If "sar" is available:

sar -u

This can help me determine whether the problem is:

Happening now
      OR
Happening over time

Historical information can give me additional evidence.

---

🧠 Slow Linux Machine — Interview Answer

If an interviewer asks:

«“How would you troubleshoot a slow Linux machine?”»

I can answer:

«“I would first check CPU utilization and processes using "top" or "ps", then memory and swap using "free", load using "uptime", disk usage using "df" and "du", and historical resource usage using "sar". I would identify the resource causing the bottleneck before taking corrective action.”»

---

2️⃣ Scenario: Server / Device Is Heating Up 🔥

Customer:

«“The server is getting very hot.”»

I should not immediately assume CPU is the only reason.

I need to investigate the system.

---

Check CPU

top

I should find processes consuming excessive CPU.

I can also use:

ps aux --sort=-%cpu | head

---

Check Memory

free -h

I should check memory and swap activity.

---

Check Load

uptime

---

Check Historical CPU Usage

sar -u

if available.

Then I should investigate the process or application causing the load.

---

Physical Machine Considerations

For a physical machine, I should also consider:

- Fans
- Airflow
- Dust
- Environment temperature
- Hardware condition

For an EC2 server, I should focus more on:

CPU
 ↓
Processes
 ↓
Memory
 ↓
Load
 ↓
Application
 ↓
Logs / Monitoring

---

🧠 Heating Server — Interview Answer

«“If a server is heating up, I would check CPU utilization and the processes consuming CPU, then check memory, load and historical resource usage. If it is a physical system, I would also check cooling, airflow and hardware conditions.”»

---

3️⃣ Scenario: Disk Has Free Space, But File Cannot Be Created ❌

This is a very important interview scenario.

Customer says:

«“There is 20 GB free, but I cannot create a file.”»

I should think:

«💡 Maybe the filesystem has space, but the inodes are exhausted.»

---

Step 1 — Check Disk Space

I run:

df -h

Suppose I see:

Filesystem   Size   Used   Avail
/dev/sda1     50G   30G    20G

There is clearly free storage space.

But the file still cannot be created.

---

Step 2 — Check Inodes

I run:

df -i

I might see:

Filesystem     Inodes   IUsed   IFree
/dev/sda1      100000   100000      0

🚨 There are no free inodes.

That means:

«The filesystem has storage space available, but it has run out of file entries/inodes.»

This can happen when there are huge numbers of small files.

---

Step 3 — Check Permissions

I should also check whether the user actually has permission to create files:

ls -ld /path/to/directory

So I should not assume inode exhaustion without checking the evidence.

---

🧠 File Creation — Interview Answer

«“If disk space is available but a file cannot be created, I would check inode availability using "df -i", because the filesystem may have exhausted its inodes. I would also check directory permissions and the exact error message.”»

---

4️⃣ Scenario: Linux Server Doesn't Boot ❌

Imagine:

Server
   ↓
Power ON
   ↓
❌ Doesn't Boot

I should not randomly repair things.

First, I need to determine:

«“Where did the boot process stop?”»

---

🖥️ Linux Boot Flow

Power ON
   ↓
BIOS / UEFI
   ↓
POST
   ↓
Boot Device
   ↓
GRUB / Bootloader
   ↓
Linux Kernel
   ↓
systemd
   ↓
Services
   ↓
Login

I should identify the stage where the boot process failed.

---

If BIOS/UEFI Doesn't Detect the Disk

I should investigate:

Disk Connection
Storage Hardware
BIOS/UEFI Storage Detection

---

If the Disk Is Detected But I See:

Bootable Device Not Found

I should check:

- Is the correct disk detected?
- Is the boot order correct?
- Is there a valid bootloader?
- Is the boot configuration correct?
- Is the OS/filesystem accessible?

---

If the Kernel Starts But the System Doesn't Finish Booting

I should investigate:

Kernel Messages
systemd
Failed Services
Boot Logs

Useful commands when I can access a recovery or working environment:

journalctl -b

For the previous boot:

journalctl -b -1

---

5️⃣ Scenario: “Bootable Device Not Found” 💻

This is directly relevant to my interview preparation.

Imagine I see:

Bootable Device Not Found

I should not immediately say:

«❌ “GRUB is broken.”»

That's too early.

I should troubleshoot in order:

Is Disk Detected?
       ↓
Check Boot Order
       ↓
Correct Boot Device?
       ↓
Bootloader Available?
       ↓
Boot Configuration?
       ↓
Filesystem / OS?
       ↓
Recovery / Repair

---

🧠 Bootable Device Not Found — Interview Answer

«“First, I would check whether the storage device is detected by BIOS/UEFI. If it is detected, I would verify the boot order and correct boot device. Then I would investigate the bootloader, boot configuration and filesystem/OS, using a recovery environment if necessary.”»

---

6️⃣ Scenario: SSH Is Not Working 🔐

Customer says:

«“I cannot SSH into my EC2 instance.”»

I already learned Networking and SSH, so now I combine OS + Networking.

I should think:

Your Computer
     ↓
Internet / Network
     ↓
AWS Route
     ↓
Security Group
     ↓
Port 22
     ↓
EC2
     ↓
SSH Service
     ↓
Authentication

---

Step 1 — Check IP

I should ask:

«“Am I connecting to the correct IP?”»

For example:

ssh username@IP

---

Step 2 — Check Network and Security

For AWS, I should check:

- Security Group
- Route
- NACL / firewall where relevant
- Correct public/private connectivity

---

Step 3 — Is SSH Listening?

On the server:

ss -lntp

I should look for:

22

---

Step 4 — Check SSH Service

On Ubuntu:

systemctl status ssh

---

Step 5 — Check Logs

journalctl -u ssh

---

Step 6 — Authentication

If I get:

Permission denied

I should think about:

- Username
- SSH key
- Password/authentication
- File permissions where relevant

---

🧠 SSH — Interview Answer

«“For an SSH issue, I would check the destination IP and network connectivity first, then verify port 22 is allowed through the security path. On the server I would check whether SSH is listening using "ss -lntp", check the SSH service with "systemctl status ssh", review logs, and finally investigate authentication if the connection reaches the server.”»

---

7️⃣ Scenario: Service Is Not Running ❌

Customer says:

«“Our web application is down.”»

The first thing I should check is the service.

systemctl status <service>

For example:

systemctl status nginx

---

If the Service Is Stopped

I can start it:

systemctl start nginx

If it needs restarting:

systemctl restart nginx

Then check again:

systemctl status nginx

---

If the Service Keeps Failing

I should investigate the logs:

journalctl -u nginx

⚠️ Important

I should not keep doing:

systemctl restart nginx
systemctl restart nginx
systemctl restart nginx

without finding the reason.

Instead:

Check Status
     ↓
Check Logs
     ↓
Find Cause
     ↓
Fix
     ↓
Restart If Required
     ↓
Verify

This is much better troubleshooting.

---

8️⃣ The BIG Troubleshooting Method 🧠

This is probably the most important concept for my Cloud Support preparation.

Whenever a customer says:

«“Something isn't working.”»

I should use a structured troubleshooting mindset.

---

🔍 Step 1 — Understand the Problem

I should ask:

- What exactly is failing?
- When did it start?
- Is it affecting one user or everyone?
- What changed recently?
- What is the exact error?

I should understand the problem before changing anything.

---

🔍 Step 2 — Check the Basics

I should check:

Is the server running?
Is the network reachable?
Is the service running?
Is the port listening?
Is there enough CPU?
Is there enough memory?
Is there disk space?
Are permissions correct?

---

🔍 Step 3 — Collect Evidence

The commands I've learned include:

top
uptime
free -h
df -h
df -i
du
ps aux
sar -u
ss -lntp
systemctl status
journalctl

These commands help me collect evidence instead of guessing.

---

🔍 Step 4 — Find the Layer

I can think about the problem in layers:

Hardware
   ↓
Boot
   ↓
OS
   ↓
CPU / Memory / Disk
   ↓
Network
   ↓
Port
   ↓
Service
   ↓
Application
   ↓
Logs

The exact path depends on the problem.

---

🔍 Step 5 — Fix

I should take corrective action only after identifying the cause.

Evidence
   ↓
Root Cause
   ↓
Corrective Action

---

🔍 Step 6 — Verify

After fixing the problem, I should ask:

«“Does the customer's problem actually work now?”»

I should not stop at:

«“The command succeeded.”»

For example:

Service started successfully

doesn't automatically prove that the customer's application works.

I need to verify the actual result.

---

🧪 CLOUD SUPPORT MASTER SCENARIO

Imagine my EC2 web server is not responding.

I could think:

EC2 Running?
      ↓
Network Reachable?
      ↓
Security Group Allows 80/443?
      ↓
Port Listening?
      ↓
Web Service Running?
      ↓
CPU Okay?
      ↓
Memory Okay?
      ↓
Disk Okay?
      ↓
Permissions Okay?
      ↓
Logs?
      ↓
Application?

This is the troubleshooting mindset I need.

---

🎯 DAY 16 INTERVIEW QUESTIONS

Q1. How Would You Troubleshoot a Slow Linux Machine?

Answer:

«“I would check CPU and processes using "top" or "ps", memory using "free", load using "uptime", disk usage using "df" and "du", and historical resource usage using "sar". Then I would identify the bottleneck and investigate the responsible process or application.”»

---

Q2. Disk Space Is Available, But a File Cannot Be Created. Why?

Answer:

«“The filesystem may have exhausted its inodes. I would check "df -i". I would also verify directory permissions and the exact error.”»

---

Q3. How Would You Troubleshoot a Heating Server?

Answer:

«“I would check CPU utilization, high-CPU processes, memory, load and historical resource usage. For a physical machine I would also check cooling, airflow and hardware conditions.”»

---

Q4. How Would You Troubleshoot SSH?

Answer:

«“I would verify the destination IP and network path, check that port 22 is allowed, verify the SSH service and listening port, check logs, and then investigate authentication.”»

---

Q5. What Would You Do for “Bootable Device Not Found”?

Answer:

«“I would first check whether the storage device is detected by BIOS/UEFI, then verify boot order and the correct boot device. After that I would investigate the bootloader, boot configuration and filesystem/OS.”»

---

🧠 MASTER OS TROUBLESHOOTING FRAMEWORK

I can now connect my previous OS days:

                 SERVER PROBLEM
                       ↓
              Understand Problem
                       ↓
                Collect Evidence
                       ↓
        ┌──────────────┼──────────────┐
        ↓              ↓              ↓
       CPU           Memory          Disk
        ↓              ↓              ↓
       top          free -h         df -h
        │              │              │
        └──────────────┼──────────────┘
                       ↓
                   Processes
                       ↓
                     ps aux
                       ↓
                    Network
                       ↓
                   ss -lntp
                       ↓
                    Service
                       ↓
                systemctl status
                       ↓
                     Logs
                       ↓
                  journalctl
                       ↓
                  Find Cause
                       ↓
                      Fix
                       ↓
                    Verify

---

🔥 THE GOLDEN RULE

«“Don't randomly restart the server. Find the problem layer, collect evidence, identify the root cause, fix it, and verify that the actual customer problem is resolved.”»

This is the mindset I want to carry into my Cloud Support interviews.

---

🧠 QUICK COMMAND MEMORY

Problem| Command
CPU / processes| "top"
Top CPU processes| "ps aux --sort=-%cpu | head"
Memory| "free -h"
Top memory processes| "ps aux --sort=-%mem | head"
Load| "uptime"
Disk space| "df -h"
Inodes| "df -i"
Directory usage| "du -sh"
Historical CPU| "sar -u"
Listening TCP ports| "ss -lntp"
Service status| "systemctl status"
Service logs| "journalctl"
Current boot logs| "journalctl -b"
Previous boot logs| "journalctl -b -1"

---

🧠 MY FINAL MEMORY

Whenever something goes wrong, I should think:

PROBLEM
   ↓
UNDERSTAND
   ↓
CHECK BASICS
   ↓
COLLECT EVIDENCE
   ↓
FIND THE LAYER
   ↓
IDENTIFY ROOT CAUSE
   ↓
FIX
   ↓
VERIFY

Not:

Problem
  ↓
Restart
  ↓
Hope 😭

---

🚀 DAY 16 = COMPLETE

My biggest takeaway from all these OS days is:

«“When something isn't working, I should not guess or randomly restart the server. I should understand the problem, collect evidence, identify the failing layer, find the root cause, take the appropriate corrective action, and finally verify that the customer's actual problem is resolved.”»
