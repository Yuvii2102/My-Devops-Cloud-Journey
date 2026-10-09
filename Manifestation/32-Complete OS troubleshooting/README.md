🖥️ OS DAY 16 — COMPLETE OS TROUBLESHOOTING

🎯 What I'm Learning Today

Today I'm bringing everything I learned in OS together.

I need to start thinking like a Cloud Support Engineer.

My most important rule:

- ❌ Don't randomly restart the server.
- ✅ Find the problem layer → Collect evidence → Identify the root cause → Fix → Verify.

---

1. Scenario: Linux Machine Is Very Slow 🐌

Imagine a customer reports that their Linux server has become very slow.

I should not immediately reboot the server. I should troubleshoot step by step.

Step 1 — Check CPU

top

I should look for:

- High CPU utilization
- Processes consuming excessive CPU
- Load average

To find processes using the most CPU:

ps aux --sort=-%cpu | head

Troubleshooting Flow

flowchart TD
    A["Linux Server Is Slow"] --> B["Check CPU Using top"]
    B --> C["Find High-CPU Processes"]
    C --> D["Investigate the Responsible Process"]
    D --> E["Identify the Cause"]

Step 2 — Check Memory

free -h

I should check:

- Available RAM
- Used memory
- Swap usage

To find processes consuming the most memory:

ps aux --sort=-%mem | head

Troubleshooting Flow

flowchart TD
    A["Check Memory Using free -h"] --> B["Check Available RAM"]
    B --> C["Check Swap Usage"]
    C --> D["Find High-Memory Processes"]
    D --> E["Investigate the Cause"]

Step 3 — Check Load

uptime

Example:

load average: 2.00, 1.50, 1.20

These represent load averages over approximately:

- "2.00" → 1 minute
- "1.50" → 5 minutes
- "1.20" → 15 minutes

Load tells me about the amount of work waiting for CPU resources and other resources.

Important: I must interpret load together with:

- Number of CPU cores
- Workload

I should not use one fixed load value to automatically decide that a server is unhealthy.

Step 4 — Check Disk Space

df -h

If a filesystem is almost full, applications may experience problems.

I should investigate disk usage instead of assuming CPU or memory is the cause.

Step 5 — Find Directories Consuming Space

du -sh /*

Or:

du -sh /var/*

These commands help me identify directories consuming significant disk space.

Step 6 — Check Historical CPU Information

If "sar" is available and historical data collection is configured:

sar -u

This helps me investigate whether high CPU usage is happening now or has occurred over time.

🧠 Interview Question: How Would You Troubleshoot a Slow Linux Machine?

Answer:

I would first check CPU utilization and processes using "top" or "ps", then memory and swap using "free", load using "uptime", disk usage using "df" and "du", and historical resource usage using "sar". I would identify the resource causing the bottleneck before taking corrective action.

---

2. Scenario: Server or Device Is Heating Up 🔥

Imagine a customer reports that the server is getting very hot.

I should not immediately assume CPU is the only reason. I need to investigate the system.

Check CPU

top

To identify processes consuming excessive CPU:

ps aux --sort=-%cpu | head

Check Memory

free -h

I should check memory and swap activity.

Check Load

uptime

Check Historical CPU Usage

sar -u

This is useful when historical data is available.

I should investigate the process or application causing excessive resource usage.

Physical Machine Considerations

For a physical machine, I should also investigate:

- Fans
- Airflow
- Dust
- Environment temperature
- Hardware condition

For an EC2 server, I should focus on CPU utilization, processes, memory, load, applications, logs and monitoring.

Troubleshooting Flow

flowchart TD
    A["Server Is Heating Up"] --> B["Check CPU Using top"]
    B --> C["Identify High-CPU Processes"]
    C --> D["Check Memory Using free -h"]
    D --> E["Check Load Using uptime"]
    E --> F["Review Historical CPU Using sar -u"]
    F --> G{"Physical Machine?"}
    G -->|Yes| H["Check Fans, Airflow, Dust and Hardware"]
    G -->|No - EC2| I["Investigate Application, Logs and Monitoring"]
    H --> J["Identify Cause and Take Appropriate Action"]
    I --> J
    J --> K["Verify System Condition"]

🧠 Interview Question: How Would You Troubleshoot a Heating Server?

Answer:

If a server is heating up, I would check CPU utilization and the processes consuming CPU, then check memory, load and historical resource usage. If it is a physical system, I would also check cooling, airflow and hardware conditions.

---

3. Scenario: Disk Has Free Space, but a File Cannot Be Created ❌

Imagine a customer reports that there is 20 GB of free space, but they cannot create a file.

I should consider whether the filesystem has space available but has exhausted its inodes.

Step 1 — Check Disk Space

df -h

Example:

Filesystem   Size   Used   Avail
/dev/sda1     50G   30G    20G

There is free storage space, but the file still cannot be created.

Step 2 — Check Inodes

df -i

Example:

Filesystem     Inodes   IUsed   IFree
/dev/sda1      100000   100000      0

There are no free inodes.

This means the filesystem has storage space available but has run out of available inodes.

This can happen when there are huge numbers of small files.

Step 3 — Check Permissions

ls -ld /path/to/directory

I should also check the exact error message.

I should not assume inode exhaustion without collecting evidence.

Troubleshooting Flow

flowchart TD
    A["Cannot Create a File"] --> B["Check Disk Space Using df -h"]
    B --> C{"Is Disk Space Available?"}
    C -->|No| D["Investigate Disk Usage"]
    C -->|Yes| E["Check Inodes Using df -i"]
    E --> F{"Are Free Inodes Available?"}
    F -->|No| G["Investigate Inode Exhaustion"]
    F -->|Yes| H["Check Directory Permissions"]
    H --> I["Check Exact Error and Other Possible Causes"]
    D --> J["Identify Root Cause"]
    G --> J
    I --> J
    J --> K["Fix and Verify"]

🧠 Interview Question: Disk Space Is Available, but a File Cannot Be Created. Why?

Answer:

If disk space is available but a file cannot be created, I would check inode availability using "df -i", because the filesystem may have exhausted its inodes. I would also check directory permissions and the exact error message.

---

4. Scenario: Linux Server Doesn't Boot ❌

Imagine the server powers on but does not boot.

I should not randomly repair things.

First, I need to determine where the boot process stopped.

Linux Boot Flow

flowchart TD
    A["Power ON"] --> B["BIOS / UEFI"]
    B --> C["POST"]
    C --> D["Boot Device"]
    D --> E["GRUB / Bootloader"]
    E --> F["Linux Kernel"]
    F --> G["systemd"]
    G --> H["Services"]
    H --> I["Login"]

I should identify the stage where the boot process failed.

If BIOS/UEFI Doesn't Detect the Disk

I should investigate:

- Disk connection
- Storage hardware
- BIOS/UEFI storage detection

If the Disk Is Detected but I See Bootable Device Not Found

I should check:

- Is the correct disk detected?
- Is the boot order correct?
- Is there a valid bootloader?
- Is the boot configuration correct?
- Is the OS/filesystem accessible?

If the Kernel Starts but the System Doesn't Finish Booting

I should investigate:

- Kernel messages
- "systemd"
- Failed services
- Boot logs

When I can access a recovery or working environment, I can use:

journalctl -b

For the previous boot:

journalctl -b -1

These commands help me inspect boot logs when the relevant logs are available.

Troubleshooting Flow

flowchart TD
    A["Linux Server Does Not Boot"] --> B{"Is the Disk Detected?"}
    B -->|No| C["Check Storage Hardware and BIOS/UEFI Detection"]
    B -->|Yes| D["Check Boot Order and Boot Device"]
    D --> E["Investigate Bootloader and Configuration"]
    E --> F["Check Kernel, systemd and Services"]
    F --> G["Review Boot Logs if Accessible"]
    C --> H["Use Recovery Environment if Necessary"]
    G --> H
    H --> I["Identify Cause, Repair and Verify Boot"]

---

5. Scenario: Bootable Device Not Found 💻

This is directly relevant to my interview preparation.

If I see the error "Bootable Device Not Found", I should not immediately assume that GRUB is broken.

I should troubleshoot in order.

Troubleshooting Flow

flowchart TD
    A["Bootable Device Not Found"] --> B{"Is Disk Detected by BIOS/UEFI?"}
    B -->|No| C["Investigate Storage Hardware and Connections"]
    B -->|Yes| D["Check Boot Order"]
    D --> E{"Is the Correct Boot Device Selected?"}
    E -->|No| F["Correct the Boot Device"]
    E -->|Yes| G["Investigate Bootloader"]
    F --> G
    G --> H["Check Boot Configuration and Filesystem / OS"]
    C --> I["Use Recovery Environment if Necessary"]
    H --> I
    I --> J["Identify Root Cause and Repair"]
    J --> K["Verify Successful Boot"]

🧠 Interview Question: What Would You Do for Bootable Device Not Found?

Answer:

First, I would check whether the storage device is detected by BIOS/UEFI. If it is detected, I would verify the boot order and correct boot device. Then I would investigate the bootloader, boot configuration and filesystem/OS, using a recovery environment if necessary.

---

6. Scenario: SSH Is Not Working 🔐

Imagine a customer reports that they cannot SSH into their EC2 instance.

I need to combine my OS and networking knowledge.

SSH Troubleshooting Flow

flowchart TD
    A["SSH Connection Fails"] --> B["Verify Destination IP"]
    B --> C["Check Network Connectivity and Routing"]
    C --> D["Check Security Group, NACL and Firewall"]
    D --> E["Check TCP Port 22"]
    E --> F["Check SSH Service and Listening Socket"]
    F --> G["Review SSH Logs"]
    G --> H["Investigate Authentication"]
    H --> I["Fix Identified Cause"]
    I --> J["Verify SSH Connection"]

Step 1 — Check the IP

I should verify that I am connecting to the correct IP.

ssh username@IP

Step 2 — Check Network and Security

For AWS, I should check:

- Security Group
- Route
- Network ACL or firewall where relevant
- Correct public/private connectivity

Step 3 — Check Whether SSH Is Listening

On the server:

ss -lntp

I should look for port "22".

Step 4 — Check the SSH Service

On Ubuntu:

systemctl status ssh

Step 5 — Check Logs

journalctl -u ssh

Step 6 — Investigate Authentication

If I receive "Permission denied", I should investigate:

- Username
- SSH key
- Password or authentication configuration
- File permissions where relevant

Common SSH Errors

Error| Possible area to investigate
Connection timed out| Network, routing, security rules or firewall
Connection refused| SSH listener/service or active rejection
Permission denied| Authentication or access configuration

🧠 Interview Question: How Would You Troubleshoot SSH?

Answer:

For an SSH issue, I would check the destination IP and network connectivity first, then verify that port 22 is allowed through the security path. On the server, I would check whether SSH is listening using "ss -lntp", check the SSH service with "systemctl status ssh", review logs, and investigate authentication if necessary.

---

7. Scenario: Service Is Not Running ❌

Imagine a customer reports that their web application is down.

The first thing I should check is the service status.

systemctl status <service>

For example:

systemctl status nginx

If the Service Is Stopped

I can start it:

systemctl start nginx

If a restart is required:

systemctl restart nginx

Then I should check the status again:

systemctl status nginx

If the Service Keeps Failing

I should investigate the logs:

journalctl -u nginx

Important: I should not repeatedly restart a service without finding the reason.

Troubleshooting Flow

flowchart TD
    A["Application Is Down"] --> B["Check Service Status"]
    B --> C{"Is the Service Running?"}
    C -->|Yes| D["Check Port, Application and Logs"]
    C -->|No| E["Review Service Logs"]
    E --> F["Identify and Fix the Cause"]
    F --> G["Start or Restart If Required"]
    G --> H["Verify Service Status"]
    H --> I["Verify the Actual Application"]
    D --> I

This is better troubleshooting because I investigate the cause before taking corrective action.

---

8. The Big Troubleshooting Method 🧠

This is one of the most important concepts for my Cloud Support preparation.

Whenever a customer reports that something isn't working, I should follow a structured troubleshooting approach.

Step 1 — Understand the Problem

I should ask:

- What exactly is failing?
- When did it start?
- Is it affecting one user or everyone?
- What changed recently?
- What is the exact error?

I should understand the problem before changing anything.

Step 2 — Check the Basics

I should check:

- Is the server running?
- Is the network reachable?
- Is the service running?
- Is the port listening?
- Is there enough CPU?
- Is there enough memory?
- Is there disk space?
- Are permissions correct?

Step 3 — Collect Evidence

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

Step 4 — Find the Problem Layer

I can think about the problem in layers:

flowchart TD
    A["Hardware"] --> B["Boot"]
    B --> C["Operating System"]
    C --> D["CPU / Memory / Disk"]
    D --> E["Network"]
    E --> F["Port"]
    F --> G["Service"]
    G --> H["Application"]
    H --> I["Logs and Evidence"]
    I --> J["Identify Root Cause"]
    J --> K["Fix"]
    K --> L["Verify"]

The exact troubleshooting path depends on the problem.

Step 5 — Fix the Problem

I should take corrective action only after identifying the cause.

flowchart LR
    A["Collect Evidence"] --> B["Identify Root Cause"]
    B --> C["Take Corrective Action"]
    C --> D["Verify the Fix"]

Step 6 — Verify the Solution

After fixing the problem, I should ask whether the customer's problem actually works now.

I should not stop just because a command succeeded.

For example, a service starting successfully does not automatically prove that the customer's application works.

I need to verify the actual result.

---

🧪 Cloud Support Master Scenario

Imagine my EC2 web server is not responding.

I should investigate step by step.

flowchart TD
    A["EC2 Web Server Not Responding"] --> B{"Is EC2 Running?"}
    B -->|No| C["Investigate Instance State"]
    B -->|Yes| D["Check Network Reachability"]
    D --> E["Check Security Group Rules for 80/443"]
    E --> F["Check Listening Port"]
    F --> G["Check Web Service Status"]
    G --> H["Check CPU and Memory"]
    H --> I["Check Disk Space and Permissions"]
    I --> J["Review Logs"]
    J --> K["Investigate Application"]
    C --> L["Identify Root Cause"]
    K --> L
    L --> M["Fix the Cause"]
    M --> N["Verify Customer Access"]

This is the troubleshooting mindset I need to develop as a Cloud Support Engineer.

---

🎯 DAY 16 INTERVIEW QUESTIONS

Q1. How Would You Troubleshoot a Slow Linux Machine?

Answer:

I would check CPU and processes using "top" or "ps", memory using "free", load using "uptime", disk usage using "df" and "du", and historical resource usage using "sar". Then I would identify the bottleneck and investigate the responsible process or application.

Q2. Disk Space Is Available, but a File Cannot Be Created. Why?

Answer:

The filesystem may have exhausted its inodes. I would check "df -i". I would also verify directory permissions and the exact error.

Q3. How Would You Troubleshoot a Heating Server?

Answer:

I would check CPU utilization, high-CPU processes, memory, load and historical resource usage. For a physical machine, I would also check cooling, airflow and hardware conditions.

Q4. How Would You Troubleshoot SSH?

Answer:

I would verify the destination IP and network path, check that port 22 is allowed, verify the SSH service and listening port, check logs, and then investigate authentication.

Q5. What Would You Do for Bootable Device Not Found?

Answer:

I would first check whether the storage device is detected by BIOS/UEFI, then verify the boot order and correct boot device. After that, I would investigate the bootloader, boot configuration and filesystem/OS.

---

🧠 MASTER OS TROUBLESHOOTING FRAMEWORK

I can now connect the concepts from my previous OS learning days.

flowchart TD
    A["Server Problem"] --> B["Understand Problem"]
    B --> C["Collect Evidence"]
    C --> D["Check CPU"]
    C --> E["Check Memory"]
    C --> F["Check Disk"]
    D --> G["Investigate Processes"]
    E --> G
    F --> G
    G --> H["Check Network"]
    H --> I["Check Listening Ports"]
    I --> J["Check Service"]
    J --> K["Review Logs"]
    K --> L["Identify Root Cause"]
    L --> M["Fix"]
    M --> N["Verify"]

---

🔥 THE GOLDEN RULE

Don't randomly restart the server. Find the problem layer, collect evidence, identify the root cause, fix it, and verify that the actual customer problem is resolved.

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

flowchart TD
    A["PROBLEM"] --> B["UNDERSTAND"]
    B --> C["CHECK BASICS"]
    C --> D["COLLECT EVIDENCE"]
    D --> E["FIND THE LAYER"]
    E --> F["IDENTIFY ROOT CAUSE"]
    F --> G["FIX"]
    G --> H["VERIFY"]

Not:

flowchart TD
    A["Problem"] --> B["Restart"]
    B --> C["Hope 😭"]

---

🚀 DAY 16 = COMPLETE

🏆 My Biggest Takeaway

When something isn't working, I should not guess or randomly restart the server. I should understand the problem, collect evidence, identify the failing layer, find the root cause, take the appropriate corrective action, and finally verify that the customer's actual problem is resolved.

My Final Mindset

Understand the problem → Collect evidence → Find the root cause → Fix it → Verify the solution.

I don't troubleshoot by guessing. I troubleshoot by collecting evidence. 🔥
