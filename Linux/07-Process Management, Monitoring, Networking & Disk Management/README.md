# 🐧 Linux — Process Management, Monitoring, Networking & Disk Management

# 1. Process Management

## What is a Process?

A **process is a running instance of a program**.

For example:

* Running Python application → Process
* Running Java application → Process
* Running shell command/script → Process
* Running web server → Process
* Running application server → Process

The simple definition I remember is:

```text
Program
→ Code / Application

Process
→ Running instance of that program
```

---

## Why is Process Management Needed?

The operating system manages hardware resources such as:

* CPU
* Memory
* File system
* Network

A process consumes these resources.

For example:

```text
Linux Server
     |
     +---- Python Process → CPU intensive
     |
     +---- Java Process → Memory intensive
     |
     +---- Web Server
     |
     +---- Shell Script
```

If one process consumes too many resources, other processes may not get enough resources.

For example:

```text
CPU = 100%

Python Process → 90%
Web Server     → 10%
Other Process  → 0%
```

This can make applications slow or even cause them to fail.

---

# 2. Main Process Management Activities

As a Linux/Cloud/DevOps Engineer, I mainly need to know how to:

1. **View/check processes**
2. **Kill processes**
3. **Stop processes temporarily**
4. **Resume processes**
5. **Prioritize/deprioritize processes**

---

# 3. Viewing Processes

## `ps`

```bash
ps
```

This shows processes, but only a limited set of processes.

---

## `ps aux`

```bash
ps aux
```

This shows running processes with more information.

Important information includes:

* User
* PID
* CPU utilization
* Memory utilization
* Start time
* Command

---

## Count Processes

```bash
ps aux | wc -l
```

This counts the lines in the output.

It can be used to determine the approximate number of running processes.

---

## Number the Output

```bash
ps aux | nl
```

`nl` numbers the lines of output.

---

# 4. `ps aux` vs `ps -ef`

This is an important interview question.

## `ps aux`

```bash
ps aux
```

Provides information such as:

* Process ID
* CPU utilization
* Memory utilization
* User
* Command
* Other process information

## `ps -ef`

```bash
ps -ef
```

Provides process information including:

* Process ID
* User
* Parent process information
* Start time
* Command

### Key difference

> **`ps aux` shows CPU and memory utilization, while `ps -ef` does not show CPU and memory utilization.**

---

# 5. Important Process Columns

## USER

This is the user who initiated or triggered the process.

For example:

```text
root
ubuntu
```

---

## PID

PID means **Process ID**.

Every process has a unique PID.

For example:

```text
PID = 4055
```

I can use the PID to manage the process.

For example:

```bash
kill 4055
```

---

## CPU Utilization

This shows how much CPU the process is consuming.

---

## Memory Utilization

This shows how much memory the process is consuming.

---

## START

This shows when the process started.

---

## COMMAND

This shows the command that started the process.

---

# 6. Finding a Specific Process

I can use `grep` to filter process output.

For example:

```bash
ps aux | grep java
```

This searches for Java-related processes.

One common issue is that the `grep` command itself can appear in the output because `grep` is also a process.

To remove that line:

```bash
ps aux | grep java | grep -v grep
```

If an actual Java process exists, I can take its:

```text
PID
```

from the output and use it with `kill`.

---

# 7. Killing a Process

## `kill`

Syntax:

```bash
kill PID
```

Example:

```bash
kill 4055
```

This sends a termination signal to the process.

The typical workflow is:

```text
Find process
     ↓
Get PID
     ↓
kill PID
```

---

## `kill -9`

If the normal `kill` does not terminate the process:

```bash
kill -9 PID
```

Example:

```bash
kill -9 4040
```

### Difference between `kill` and `kill -9`

```text
kill PID
→ Normal termination request

kill -9 PID
→ Forcefully kills the process
```

I should use `kill -9` carefully.

---

# 8. `kill -3`

For Java applications:

```bash
kill -3 PID
```

This is used to obtain a **thread dump**.

I remember it like this:

```text
kill
→ Terminate process

kill -9
→ Forcefully terminate process

kill -3
→ Thread dump, especially for Java
```

---

# 9. Stop and Resume a Process

Sometimes I don't want to kill a process.

I may want to temporarily stop it and resume it later.

## Stop

```bash
kill -STOP PID
```

Example:

```bash
kill -STOP 4048
```

The process remains present but is temporarily stopped.

## Resume

```bash
kill -CONT PID
```

Example:

```bash
kill -CONT 4048
```

This resumes the stopped process.

So:

```text
STOP
→ Temporarily stop process

CONT
→ Continue/resume process
```

---

# 10. Prioritize / Deprioritize Processes

Linux provides the `renice` command.

```bash
renice -n 10 -p PID
```

The important concept here is the **nice value**.

The range discussed is approximately:

```text
-19 ---------------- 0 ---------------- +20
High priority                         Low priority
```

So:

* Lower nice value → **higher CPU priority**
* Higher nice value → **lower CPU priority**

For example:

```bash
renice -n 10 -p PID
```

This decreases the process priority.

Another example:

```bash
renice -n -5 -p PID
```

This gives the process higher priority.

### Why use `renice`?

I can use it when I want to tell the CPU that a particular process should receive:

* More priority
* Less priority

I need to use this carefully because changing process priority can affect other applications.

---

# 11. Services

A **service is a special type of background-running process**.

The important difference is:

## Normal Process

A normal application/process may not automatically start when the server restarts.

Examples:

```text
Python application
Java application
Shell script
```

## Service

Services generally start automatically during server boot when configured/enabled as services.

Examples:

```text
Nginx
Apache
Cron
```

### Interview Definition

> **Services are background processes that can be configured to start automatically when the Linux server boots.**

---

# 12. `systemctl`

`systemctl` is used to manage services.

## List Services

```bash
systemctl list-units --type=service
```

This lists services.

## Stop a Service

```bash
systemctl stop cron
```

## Start a Service

```bash
systemctl start cron
```

### Main commands

```bash
systemctl list-units --type=service

systemctl stop <service>

systemctl start <service>
```

---

# 13. Process vs Service

| Process                                  | Service                                 |
| ---------------------------------------- | --------------------------------------- |
| Running instance of a program            | Background process managed as a service |
| May not automatically start after reboot | Can automatically start during boot     |
| Example: Python application              | Example: Nginx                          |
| Managed using process commands           | Managed using `systemctl`               |

A process can also be configured to run as a service.

---

# 14. Monitoring

Process management tells me **what processes are running**.

Monitoring helps me understand:

* CPU usage
* Memory usage
* Disk usage
* Resource-consuming processes

The main commands I need to know are:

```text
top
htop
vmstat
free
nproc
df
du
```

---

# 15. `top`

```bash
top
```

`top` provides **real-time monitoring**.

It shows:

* Process ID
* CPU utilization
* Memory utilization
* Running processes
* System information

The output continuously updates.

### Important difference

```text
ps aux
→ Process information, not real-time updating

top
→ Real-time process/resource monitoring
```

It also helps me identify processes consuming high CPU or memory.

---

# 16. `htop`

```bash
htop
```

`htop` provides similar information to `top`, but with a more user-friendly and visual interface.

It shows:

* CPU usage
* Memory usage
* Processes
* System uptime
* Process information

The simple difference is:

```text
top
→ Standard real-time monitoring

htop
→ Visually improved version of top
```

---

# 17. `vmstat`

```bash
vmstat
```

`vmstat` reports system performance information.

If someone says:

> "The Linux server is very slow."

I can use `vmstat` to investigate system performance and memory-related information.

---

# 18. Memory — `free`

## `free -m`

```bash
free -m
```

Shows memory information in MB.

## `free -h`

```bash
free -h
```

Shows memory in human-readable format.

This is the recommended form from the practical.

It helps me understand:

* Total memory
* Used memory
* Available/free memory
* Cached memory

### Important

For scripting and automation, `free` is more useful than visually oriented `top` because its output can be processed using commands such as:

```text
grep
awk
sed
```

---

# 19. CPU — `nproc`

```bash
nproc
```

This shows the number of available CPUs/processing units.

For example:

```text
1
```

means one CPU is available to the environment.

---

# 20. Disk Space — `df -h`

```bash
df -h
```

This shows disk/filesystem utilization in human-readable format.

It shows information for different filesystems/partitions.

Important columns include:

```text
Filesystem
Size
Used
Avail
Use%
Mounted on
```

The `/` filesystem is particularly important because it represents the root filesystem.

---

# 21. Folder Disk Usage — `du -sh`

```bash
du -sh
```

This shows the disk usage of the current directory.

To check individual folders:

```bash
du -sh *
```

This helps me identify which folders are consuming the most disk space.

For example:

```text
logs      → large
scripts   → small
python    → small
```

This is useful for troubleshooting disk-space problems, especially when logs consume a lot of storage.

---

# 22. Quick Monitoring Cheat Sheet

| Requirement           | Command                               |
| --------------------- | ------------------------------------- |
| View processes        | `ps`                                  |
| View all processes    | `ps aux`                              |
| Count processes       | `ps aux \| wc -l`                     |
| Number output lines   | `ps aux \| nl`                        |
| Filter process        | `ps aux \| grep java`                 |
| Remove grep line      | `grep -v grep`                        |
| Kill process          | `kill PID`                            |
| Force kill            | `kill -9 PID`                         |
| Java thread dump      | `kill -3 PID`                         |
| Stop process          | `kill -STOP PID`                      |
| Resume process        | `kill -CONT PID`                      |
| Change priority       | `renice -n VALUE -p PID`              |
| Real-time monitoring  | `top`                                 |
| Better `top` UI       | `htop`                                |
| System performance    | `vmstat`                              |
| Memory                | `free -h`                             |
| CPU count             | `nproc`                               |
| Disk/filesystem usage | `df -h`                               |
| Folder disk usage     | `du -sh *`                            |
| List services         | `systemctl list-units --type=service` |
| Stop service          | `systemctl stop SERVICE`              |
| Start service         | `systemctl start SERVICE`             |

---

# 23. Networking

In this section, my teacher did **not explain the networking concepts**.

Instead, I was directed to the **Networking Fundamentals** playlist.

The topics mentioned were:

* IP address
* Subnet
* Private subnet
* Public subnet
* CIDR
* OSI model
* Practical examples of the OSI model

The important takeaway is:

> **Networking is extremely important for Linux administrators, DevOps engineers, developers and SREs because it is required for debugging, troubleshooting and understanding latency.**

The recommended approach is to learn **Networking Fundamentals first**, and then later learn AWS/Azure networking.

---

# 24. Disk Management

Disk management is another common task for:

* Linux Administrators
* DevOps Engineers
* Cloud Engineers

Typical activities include:

* Adding storage
* Adding volumes
* Removing storage
* Mounting storage
* Formatting storage

---

# 25. Why Do We Need More Storage?

A Linux server may initially have something like:

```text
8 GB storage
```

Over time, applications can generate:

* Application logs
* Debug logs
* Audit logs
* Other files
* Installed packages/software

Eventually, the disk may become full.

I can either:

1. Remove/archive/move logs
2. Take backups
3. Increase storage

---

# 26. Block Storage

When I create a volume in AWS EBS, it is **block storage**.

For example:

```text
AWS EBS Volume
      ↓
    10 GB
      ↓
Linux Server
```

Simply attaching the volume does **not** mean applications can immediately use it.

I need to:

1. Identify the disk
2. Format it
3. Mount it

---

# 27. `lsblk`

```bash
lsblk
```

This lists block devices attached to the Linux instance.

For example:

```text
xvda   → 8 GB
xvdf   → 10 GB
```

`lsblk` is useful when I attach a new volume and want to verify that Linux can see it.

My teacher also mentioned `loop` devices, but for this practical the focus is on the actual attached disk.

---

# 28. Partitions

A disk or volume can be divided into **partitions**.

For example:

```text
8 GB Volume
     |
     +---- Partition
     +---- Partition
     +---- Partition
```

Partitions can then be formatted and mounted.

---

# 29. `fdisk -l`

```bash
sudo fdisk -l
```

This displays detailed information about disks and partitions.

Compared with `lsblk`, `fdisk -l` provides more partition-level details.

I remember it like this:

```text
lsblk
→ List block devices

fdisk -l
→ Detailed disk/partition information
```

---

# 30. Create a Mount Directory

My teacher created a mount directory:

```bash
mkdir -p /mnt/temp-volume
```

A mount point is simply the location in the Linux filesystem where the new storage will be made accessible.

---

# 31. Format a Volume

`mkfs` means **make filesystem**.

The command used was:

```bash
mkfs -t ext4 /dev/xvdf
```

This formats the volume using the **ext4** filesystem.

The two filesystem types mentioned were:

```text
ext4
XFS
```

---

# 32. Mount the Volume

After formatting:

```bash
mount /dev/xvdf /mnt/temp-volume
```

Now the storage is accessible through:

```text
/mnt/temp-volume
```

I can then create files there.

For example:

```bash
cd /mnt/temp-volume
touch Abhishek
ls
```

---

# 33. Verify Disk Usage

After mounting:

```bash
df -h
```

I can see the newly mounted filesystem and its available space.

---

# 34. Unmount

`umount` is the opposite operation of `mount`.

Example:

```bash
umount /mnt/temp-volume
```

This removes the filesystem from that mount point.

---

# 35. Complete Disk Management Flow

This is the most important practical flow:

```text
Create Volume
     ↓
Attach Volume to EC2
     ↓
lsblk
     ↓
Identify Disk
     ↓
mkfs -t ext4 /dev/xvdf
     ↓
Create Mount Directory
     ↓
mkdir -p /mnt/temp-volume
     ↓
mount /dev/xvdf /mnt/temp-volume
     ↓
Use Storage
     ↓
df -h
```

---

# 36. Important Disk Commands

| Requirement            | Command                            |
| ---------------------- | ---------------------------------- |
| List block devices     | `lsblk`                            |
| Disk/partition details | `sudo fdisk -l`                    |
| Create directory       | `mkdir -p /mnt/temp-volume`        |
| Format as ext4         | `mkfs -t ext4 /dev/xvdf`           |
| Mount volume           | `mount /dev/xvdf /mnt/temp-volume` |
| Check disk/filesystem  | `df -h`                            |
| Check folder usage     | `du -sh *`                         |
| Unmount                | `umount /mnt/temp-volume`          |

---

# 🎯 37. DevOps/Cloud Engineer Quick Revision

## Process Management

```text
Process
→ Running instance of a program
```

Commands:

```bash
ps aux
ps -ef
grep
kill
kill -9
kill -3
kill -STOP
kill -CONT
renice
systemctl
```

---

## Monitoring

```text
CPU
→ nproc / top / htop

Memory
→ free -h / top / htop

Disk
→ df -h / du -sh *

Performance
→ vmstat
```

---

## Networking

```text
IP
Subnet
Private/Public subnet
CIDR
OSI Model
```

These are learned from the Networking Fundamentals section my teacher referenced.

---

## Disk Management

The basic flow is:

```text
Volume
   ↓
Attach
   ↓
lsblk
   ↓
Format
   ↓
Mount
   ↓
Use
```

Main commands:

```bash
lsblk
fdisk -l
mkfs
mount
umount
df -h
du -sh *
```

---

# 🎯 38. Most Important Interview Points

### 1. What is a process?

A **running instance of a program**.

### 2. `ps aux` vs `ps -ef`?

`ps aux` provides CPU and memory utilization, while `ps -ef` does not.

### 3. What is PID?

PID is the **unique process ID** used to identify and manage a process.

### 4. `kill` vs `kill -9`?

```text
kill
→ Normal termination request

kill -9
→ Forcefully terminates the process
```

### 5. What does `kill -3` do?

It generates a **thread dump**, especially for Java applications.

### 6. How do I stop and resume a process?

```bash
kill -STOP PID
kill -CONT PID
```

### 7. How do I change process priority?

```bash
renice
```

### 8. Process vs Service?

A service is a background process managed as a service and can be configured to start at boot.

### 9. How do I monitor CPU/memory in real time?

```bash
top
htop
```

### 10. How do I check memory?

```bash
free -h
```

### 11. How do I check disk space?

```bash
df -h
```

### 12. How do I find folders consuming disk space?

```bash
du -sh *
```

### 13. How do I see attached disks?

```bash
lsblk
```

### 14. How do I format a volume?

```bash
mkfs -t ext4 /dev/xvdf
```

### 15. How do I mount a volume?

```bash
mount /dev/xvdf /mnt/temp-volume
```

### 16. How do I manage services?

```bash
systemctl
```

---

# 🧠 Final Mental Model

I can remember this entire topic as four major areas:

```text
              Linux
                │
    ┌───────────┼───────────┐
    │           │           │
 Process     Monitoring   Disk
Management                Management
    │           │           │
    │           │           │
   ps          top        lsblk
  kill        htop       fdisk
 renice       vmstat      mkfs
systemctl     free       mount
               df        umount
               du
                │
                │
            Networking
                │
       IP / Subnet / CIDR
           OSI Model
```

The main thing I need to understand is:

```text
Processes
→ What is running?

Monitoring
→ How much CPU, memory and disk are being used?

Networking
→ How does the Linux server communicate?

Disk Management
→ How do I add, format, mount and manage storage?
```
