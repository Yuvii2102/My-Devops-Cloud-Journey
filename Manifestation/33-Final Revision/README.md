🚀 DAY 17 — FINAL OS INTERVIEW REVISIONN

Today is the final day of my OS roadmap.

I have already learned the concepts. Today I am converting everything into interview-ready answers.

My interview rule

«Explain the concept clearly → give the troubleshooting steps → mention the command when useful.»

I don't need to give a huge textbook answer in an interview. I need to show that I understand the concept and know how to troubleshoot it.

---

🧠 PART 1 — BOOT PROCESS

Q1. Explain the Linux boot process in detail.

Simple understanding

When I switch on a computer:

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

Interview answer

«“When the system is powered on, BIOS or UEFI initializes the hardware and performs POST. It identifies the boot device according to the boot configuration. The bootloader, commonly GRUB in Linux, loads the Linux kernel. The kernel initializes the system and starts the user-space initialization system, commonly systemd. systemd starts and manages services, and finally the system reaches the login stage.”»

---

🧠 PART 2 — BOOT TROUBLESHOOTING

Q2. How would I troubleshoot a boot issue?

I should not randomly repair things.

First I ask:

«At which stage does the boot process stop?»

Troubleshooting flow

Power
  ↓
BIOS / UEFI
  ↓
Disk detected?
  ↓
Boot order
  ↓
Bootloader / GRUB
  ↓
Kernel
  ↓
systemd
  ↓
Services
  ↓
Login

Useful commands

After gaining access through a recovery/working environment:

journalctl -b

Previous boot:

journalctl -b -1

Interview answer

«“I would first identify the stage where the boot process is failing. I would check hardware and BIOS/UEFI detection, boot order, bootloader, kernel and systemd/services. If the system is accessible through a recovery environment, I would review boot logs using journalctl.”»

---

💻 PART 3 — BOOTABLE DEVICE NOT FOUND

Q3. What would I do if the system shows "Bootable Device Not Found"?

I think about the problem step-by-step:

Is disk detected?
       ↓
Is boot order correct?
       ↓
Correct boot device?
       ↓
Bootloader?
       ↓
Boot configuration?
       ↓
Filesystem / OS?

Interview answer

«“First I would check whether the storage device is detected by BIOS/UEFI. If it is detected, I would verify the boot order and correct boot device. Then I would investigate the bootloader, boot configuration and filesystem or OS. If necessary, I would use a recovery environment.”»

---

🐌 PART 4 — SLOW LINUX MACHINE

Q4. A Linux machine is very slow. How would I troubleshoot it?

This is a very important Cloud Support question.

I should not immediately say I will restart the server.

I should investigate the resources first.

Troubleshooting flow

CPU
 ↓
Memory
 ↓
Load
 ↓
Disk
 ↓
Processes
 ↓
Historical data
 ↓
Logs / Application

CPU / Processes

top

ps aux --sort=-%cpu | head

Memory

free -h

Load

uptime

Disk

df -h

Directory usage

du -sh /var/*

Historical CPU

sar -u

Interview answer

«“I would first check CPU utilization and high-CPU processes using top or ps. Then I would check memory and swap using free, load using uptime, disk usage using df and du, and historical resource usage using sar. Then I would identify the bottleneck and investigate the responsible process or application.”»

---

🔥 PART 5 — SERVER HEATING

Q5. A server is heating up. How would I troubleshoot it?

First I check CPU:

top

I look for processes consuming excessive CPU.

ps aux --sort=-%cpu | head

Then I check:

free -h

uptime

sar -u

For a physical machine, I would also investigate:

- Fans
- Airflow
- Dust
- Environment temperature
- Hardware

Interview answer

«“I would check CPU utilization and processes consuming excessive CPU, then check memory, load and historical resource usage. If it is a physical machine, I would also check cooling, airflow and hardware conditions.”»

---

💾 PART 6 — DISK FREE SPACE

Q6. How do I check disk free space?

I use:

df -h

Meaning

df → filesystem disk usage
-h → human-readable format

Example:

Filesystem      Size  Used Avail Use%
/dev/sda1        50G   30G   20G  60%

Interview answer

«“I use df -h to check filesystem disk space in a human-readable format.”»

---

📁 PART 7 — DISK SPACE AVAILABLE BUT FILE CANNOT BE CREATED

Q7. Disk space is available, but a file cannot be created. Why?

This is an important interview question.

First:

df -h

If there is still space available, I check:

df -i

Why?

Disk space and inodes are two different resources.

For example:

20 GB free
BUT
0 free inodes

In this situation, creating another file may fail.

I should also check permissions:

ls -ld /path/to/directory

And I should look at the exact error message.

Interview answer

«“If disk space is available but a file cannot be created, I would check inode availability using df -i. The filesystem may have exhausted its inodes, especially if there are many small files. I would also check directory permissions and the exact error message.”»

---

🧬 PART 8 — INODES

Q8. What is an inode?

I can think of an inode as a file's information card.

It stores metadata such as:

- File type
- Permissions
- Owner
- Group
- Timestamps
- Information used to locate the file's data

Check inode usage

df -i

Interview answer

«“An inode is a filesystem data structure that stores metadata about a file, such as its type, permissions, ownership and timestamps. df -i can be used to check inode availability.”»

---

🧠 PART 9 — PAGING

Q9. What is paging?

I imagine RAM has many small boxes.

The OS divides virtual memory into pages.

Physical memory is divided into frames.

Virtual Memory
      ↓
    Pages
      ↓
   Mapped to
      ↓
 Physical RAM
      ↓
   Frames

Paging helps the OS manage memory efficiently.

Related concepts

Virtual memory

It gives processes their own virtual address spaces.

Swap

It is disk space used when memory pages need to be moved out of RAM.

Page fault

It occurs when a process accesses a page that isn't currently available in the required physical memory location, so the OS must handle it.

Interview answer

«“Paging is a memory-management technique where virtual memory is divided into fixed-size pages and physical memory into frames. The OS maps pages to physical frames. It allows efficient memory management and supports virtual memory.”»

---

⚙️ PART 10 — SYSTEM CALLS

Q10. What is a system call?

A normal program cannot directly perform every privileged operation.

It asks the Linux kernel to perform the operation.

That request is called a system call.

Application
     ↓
System Call
     ↓
Kernel
     ↓
Hardware / OS resource

Examples

fork()
open()
read()
write()
close()
execve()

Interview answer

«“A system call is an interface through which a user-space program requests a service from the operating system kernel, such as creating a process or reading a file.”»

---

👶 PART 11 — fork()

Q11. Explain fork().

I can think of it like:

👨 One process
      ↓
    fork()
      ↓
 ┌────┴────┐
Parent    Child

"fork()" creates a new child process from the calling process.

The child gets its own PID.

Return values

Parent → receives child's PID
Child  → receives 0
Failure → -1

Interview answer

«“fork() is a Linux/Unix system call used to create a new child process from the calling process. The parent receives the child's PID, the child receives zero, and -1 indicates failure.”»

---

🔄 PART 12 — PROCESS LIFE CYCLE

Q12. Explain process states/lifecycle.

Simple flow

NEW
 ↓
READY
 ↓
RUNNING
 ↓
WAITING / BLOCKED
 ↓
READY
 ↓
RUNNING
 ↓
TERMINATED

Linux process states I should know

State| Meaning
"R"| Running / Runnable
"S"| Interruptible sleep
"D"| Uninterruptible sleep
"T"| Stopped
"Z"| Zombie

Zombie process

A zombie process has finished execution, but its parent hasn't collected its termination status yet.

Interview answer

«“A process can move through states such as new, ready, running, waiting or blocked, and terminated. In Linux, common process states include R, S, D, T and Z. A zombie is a terminated child process whose parent has not yet collected its exit status.”»

---

🔐 PART 13 — SSH TROUBLESHOOTING

Q13. SSH is not working. How do I troubleshoot it?

I think layer-by-layer:

Correct IP
   ↓
Network
   ↓
Security Group / Firewall
   ↓
Port 22
   ↓
SSH service
   ↓
Listening socket
   ↓
Authentication

Check listening ports

ss -lntp

Check SSH service

systemctl status ssh

Check SSH logs

journalctl -u ssh

Error clues

Timeout
   ↓
Network / security path

Connection refused
   ↓
Host reachable, but no service/listener
or active rejection

Permission denied
   ↓
Authentication / access problem

Interview answer

«“I would verify the destination IP and network path, then check whether port 22 is allowed. On the server I would check whether SSH is listening using ss -lntp, check the SSH service using systemctl status ssh, review logs, and investigate authentication if necessary.”»

---

🔎 PART 14 — CHECK LISTENING PORTS

Q14. How do I check which ports are listening?

I use:

ss -lntp

Meaning

-l → listening
-n → numeric addresses/ports
-t → TCP
-p → process information

I may see:

LISTEN  0  128  0.0.0.0:22

This means something is listening on TCP port 22.

Interview answer

«“I use ss -lntp to check listening TCP ports and, where permitted, the associated processes.”»

---

⏱️ PART 15 — TOP AND SAR

Q15. What is top?

"top" gives me a live view of:

- Processes
- CPU
- Memory
- Load
- System activity

Command:

top

Interview answer

«“top is a real-time system monitoring command used to view processes and resource utilization such as CPU and memory.”»

---

Q16. What is sar?

"sar" means:

«System Activity Reporter»

It can provide resource usage information over time when data collection is configured.

CPU

sar -u

Memory

sar -r

Interview answer

«“sar is used to collect and report historical system activity. For example, sar -u provides CPU-related statistics and sar -r provides memory-related statistics.”»

---

📂 PART 16 — LINUX FILE PERMISSIONS

Q17. Explain Linux file permissions.

Linux permissions have three categories:

User
Group
Others

And three basic permissions:

r = read
w = write
x = execute

Example:

-rwxr-xr--

Break it down:

User    → rwx
Group   → r-x
Others  → r--

Numeric permissions

r = 4
w = 2
x = 1

For example:

755

means:

Owner  → rwx
Group  → r-x
Others → r-x

Useful commands

ls -l
chmod
chown
chgrp

---

👤 PART 17 — USERS AND GROUPS

Q18. How do I check the current user?

whoami

For more information:

id

To check groups:

groups

Create a user

useradd -m developer

Set password

passwd developer

Create a group

groupadd developers

Add user to group

usermod -aG developers developer

---

📦 PART 18 — SOFTWARE MANAGEMENT

Q19. What is apt update vs apt upgrade?

"apt update"

Refreshes package information.

apt update

"apt upgrade"

Upgrades installed packages.

apt upgrade

Install

apt install <package>

Remove

apt remove <package>

Easy memory trick

update
   ↓
Refresh information

upgrade
   ↓
Upgrade packages

---

⚙️ PART 19 — SERVICES

Q20. What is a service?

A service is a background functionality managed by the operating system/service manager.

For example:

systemctl status nginx

Start

systemctl start nginx

Stop

systemctl stop nginx

Restart

systemctl restart nginx

Enable at boot

systemctl enable nginx

Disable automatic startup

systemctl disable nginx

Logs

journalctl -u nginx

Important difference

start
  ↓
Starts it now

enable
  ↓
Configures it to start automatically at boot

---

🕐 PART 20 — DATE, TIME AND NTP

Q21. How do I check system time?

I use:

date

For system time configuration:

timedatectl

NTP

NTP means:

«Network Time Protocol»

It synchronizes a system's clock with a reliable time source.

Why is correct time important?

Correct time is important for:

- Logs
- Monitoring
- Authentication
- Scheduled tasks
- Troubleshooting

---

⏰ PART 21 — CRON

Q22. What is cron?

Cron is a Linux scheduler.

It allows me to automatically run commands at scheduled times.

List jobs

crontab -l

Edit jobs

crontab -e

Example

0 22 * * * /home/developer/backup.sh

This means:

«Run "backup.sh" every day at 10 PM.»

Cron structure

Minute
Hour
Day of Month
Month
Day of Week

---

🌐 PART 22 — PING AND TRACERT

Q23. How does ping work?

"ping" checks whether a destination is reachable using:

«ICMP Echo Request and Echo Reply»

Simple flow:

Your computer
     ↓
ICMP Echo Request
     ↓
Server
     ↓
ICMP Echo Reply
     ↓
Your computer

Example:

ping example.com

---

Q24. How does tracert/traceroute work?

It helps show the path/hops packets take toward a destination.

Windows

tracert example.com

Linux

traceroute example.com

It is useful when troubleshooting where along a path connectivity may be failing.

---

🌐 PART 23 — WHAT HAPPENS WHEN I TYPE AMAZON.COM?

This was already covered in networking, so today I only revise it.

Type amazon.com
       ↓
DNS
       ↓
Get IP address
       ↓
Routing
       ↓
TCP 3-way handshake
       ↓
TLS handshake
       ↓
HTTPS request
       ↓
Server
       ↓
HTTPS response
       ↓
Browser displays page

Interview answer

«“When I enter amazon.com, the browser first needs the server's IP address, so DNS resolution occurs. The system then determines the route to that IP. For a TCP-based HTTPS connection, TCP establishes the connection using the three-way handshake. TLS then establishes secure communication and authenticates the server using its certificate. After that, the browser sends the HTTPS request and receives the response.”»

---

📡 PART 24 — DHCP DORA

This is another networking topic that I should know for my interview question bank.

DORA

D → Discover
O → Offer
R → Request
A → Acknowledgement

Flow

Client
  ↓
DHCP Discover
  ↓
DHCP Server
  ↓
DHCP Offer
  ↓
Client
  ↓
DHCP Request
  ↓
DHCP Server
  ↓
DHCP ACK

Why is Discover broadcast?

The client initially doesn't know where the DHCP server is.

Important broadcast/unicast detail

- Discover is broadcast.
- Request is commonly broadcast so DHCP servers can see which offer was selected.
- Offer and ACK can be broadcast or unicast depending on the DHCP exchange/client state.

Interview answer

«“DORA stands for Discover, Offer, Request and Acknowledgement. The client sends a DHCP Discover to find a DHCP server. The server responds with an Offer. The client sends a Request for the selected configuration, and the server sends an Acknowledgement confirming the lease.”»

---

🏆 FINAL CLOUD SUPPORT TROUBLESHOOTING CHEAT SHEET

This is the troubleshooting flow I should remember.

                CUSTOMER ISSUE
                      ↓
              Understand problem
                      ↓
               Check exact error
                      ↓
              Check basic health
                      ↓
          ┌───────────┼───────────┐
          ↓           ↓           ↓
         CPU        Memory       Disk
          ↓           ↓           ↓
       Processes     Swap       Inodes
          ↓           ↓           ↓
          └───────────┼───────────┘
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
                      ↓
                 Find Cause
                      ↓
                     Fix
                      ↓
                   Verify

---

🔥 MY GOLDEN RULE

«Don't troubleshoot by guessing. Troubleshoot by collecting evidence.»

When a customer reports an issue, I should:

Understand
    ↓
Check basics
    ↓
Collect evidence
    ↓
Find the failing layer
    ↓
Identify root cause
    ↓
Fix
    ↓
Verify

The goal is not just to make a command succeed.

The goal is to verify that the actual customer problem is solved.

---

🎯 FINAL OS INTERVIEW CHECKLIST

Interview Topic| Status
Boot process| ✅
Boot troubleshooting| ✅
Bootable Device Not Found| ✅
Slow Linux machine| ✅
CPU utilization| ✅
"top"| ✅
"sar"| ✅
Paging| ✅
System calls| ✅
"fork()"| ✅
Process lifecycle| ✅
Disk free space| ✅
Inodes| ✅
File creation failure| ✅
Heating server| ✅
SSH troubleshooting| ✅
Listening ports| ✅
File permissions| ✅
Users & groups| ✅
Software management| ✅
Services| ✅
Date/time| ✅
NTP| ✅
Cron| ✅
Ping| ✅
Tracert/Traceroute| ✅
Amazon.com flow| ✅
DHCP DORA| ✅

---

🏆 DAY 17 = COMPLETE

🎉 OS ROADMAP = 100% COMPLETE

I have now covered the OS syllabus + OS interview questions I collected.

My main focus going into a Cloud Support interview should be:

«Concept → Command → Troubleshooting → Evidence → Root Cause → Fix → Verify»

I should not just memorize commands.

I should understand why I am running each command and what information I am looking for.

🚀 OS ROADMAP COMPLETE

DAY 1  → Boot Process
DAY 2  → Linux Basics & System Information
DAY 3  → Processes & Process Management
DAY 4  → CPU, top & sar
DAY 5  → Memory Management
DAY 6  → Disk, Filesystems & Inodes
DAY 7  → File Permissions
DAY 8  → Users & Groups
DAY 9  → Software Management
DAY 10 → Services & systemd
DAY 11 → SSH & Remote Management
DAY 12 → Network Services
DAY 13 → Date, Time & NTP
DAY 14 → System Automation
DAY 15 → Server Heating & Resource Troubleshooting
DAY 16 → Complete OS Troubleshooting
DAY 17 → Final OS Interview Revision

🏁 FINAL MINDSET

«I don't troubleshoot by guessing. I troubleshoot by collecting evidence.»

«I don't just fix the server. I identify the root cause and verify the actual problem is resolved.»

«I think layer-by-layer.»

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
   ↓
Root Cause
   ↓
Fix
   ↓
Verify

🔥 DAY 17 COMPLETE.
🏆 OS ROADMAP 100% COMPLETE.
