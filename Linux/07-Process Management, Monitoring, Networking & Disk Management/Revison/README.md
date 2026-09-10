# 🐧 Linux Commands — Simple Understanding

These are the Linux commands I learned for **process management, services, system monitoring, networking topics, and disk management**.

---

# 🔹 Process Management

A **process** is basically a running program.

These are the commands I learned to view, manage, stop, and change the priority of processes.

| Command                               | Simple Understanding                                          |
| ------------------------------------- | ------------------------------------------------------------- |
| `ps`                                  | Shows currently running processes                             |
| `ps aux`                              | Shows all running processes with CPU and memory usage         |
| `ps -ef`                              | Shows detailed information about running processes            |
| `ps aux \| wc -l`                     | Counts the lines/processes in `ps aux` output                 |
| `ps aux \| nl`                        | Numbers the `ps aux` output lines                             |
| `ps aux \| grep java`                 | Finds Java-related processes                                  |
| `ps aux \| grep java \| grep -v grep` | Finds Java processes while removing the `grep` command itself |
| `kill PID`                            | Terminates a process using its PID                            |
| `kill -9 PID`                         | Forcefully kills a process                                    |
| `kill -3 PID`                         | Generates a thread dump, mainly used for Java                 |
| `kill -STOP PID`                      | Temporarily stops a process                                   |
| `kill -CONT PID`                      | Resumes a stopped process                                     |
| `renice -n 10 -p PID`                 | Decreases the process priority                                |
| `renice -n -5 -p PID`                 | Increases the process priority                                |

### Example — Find a Java Process

```bash
ps aux | grep java
```

This helps me find the Java process.

### Example — Kill a Process

```bash
kill 1234
```

This kills the process with PID `1234`.

### Forcefully Kill a Process

```bash
kill -9 1234
```

This forcefully kills process `1234`.

---

# 🔹 Services

A **service** is something that runs in the background and is managed as a service.

I can use `systemctl` to manage services.

| Command                               | Simple Understanding          |
| ------------------------------------- | ----------------------------- |
| `systemctl list-units --type=service` | Lists running/loaded services |
| `systemctl stop SERVICE`              | Stops a service               |
| `systemctl start SERVICE`             | Starts a service              |

### Example — Stop a Service

```bash
systemctl stop cron
```

This stops the `cron` service.

### Example — Start a Service

```bash
systemctl start cron
```

This starts the `cron` service.

---

# 🔹 Monitoring

Monitoring is used to understand what is happening on the Linux system, especially CPU, memory, processes, and disk usage.

| Command    | Simple Understanding                              |
| ---------- | ------------------------------------------------- |
| `top`      | Real-time monitoring of CPU, memory and processes |
| `htop`     | More user-friendly/visual version of `top`        |
| `vmstat`   | Shows system performance information              |
| `free -m`  | Shows memory usage in MB                          |
| `free -h`  | Shows memory usage in human-readable format       |
| `nproc`    | Shows the number of available CPUs                |
| `df -h`    | Shows filesystem/disk space usage                 |
| `du -sh`   | Shows disk usage of the current directory         |
| `du -sh *` | Shows disk usage of each file/folder              |

### Quick Memory

Check memory:

```bash
free -h
```

Check the number of CPUs:

```bash
nproc
```

Check disk/filesystem space:

```bash
df -h
```

Find which folders are consuming disk space:

```bash
du -sh *
```

---

# 🔹 Networking

For networking, my teacher referred us to the **Networking Fundamentals** section instead of teaching networking commands in this episode.

The concepts mentioned were:

```text
IP Address
Subnet
Private Subnet
Public Subnet
CIDR
OSI Model
```

So, for this particular class, I am not adding extra networking commands to my notes.

---

# 🔹 Disk Management

Disk management is used when we need to work with disks/block storage attached to a Linux server.

| Command                            | Simple Understanding                                     |
| ---------------------------------- | -------------------------------------------------------- |
| `lsblk`                            | Lists disks/block storage attached to the server         |
| `sudo fdisk -l`                    | Shows detailed disk and partition information            |
| `mkdir -p /mnt/temp-volume`        | Creates the directory that will be used as a mount point |
| `mkfs -t ext4 /dev/xvdf`           | Formats the disk using the ext4 filesystem               |
| `mount /dev/xvdf /mnt/temp-volume` | Mounts the disk so Linux/applications can use it         |
| `umount /mnt/temp-volume`          | Unmounts the disk                                        |
| `df -h`                            | Checks filesystem/disk space                             |

### Disk Management Flow

The basic flow I need to remember is:

```text
lsblk
  ↓
fdisk -l
  ↓
Create mount point
  ↓
mkfs
  ↓
mount
  ↓
df -h
  ↓
umount
```

For example:

```bash
lsblk
```

First, I can see the disks attached to the server.

```bash
sudo fdisk -l
```

Then I can see detailed disk and partition information.

Create the mount-point directory:

```bash
mkdir -p /mnt/temp-volume
```

Format the disk:

```bash
mkfs -t ext4 /dev/xvdf
```

Mount the disk:

```bash
mount /dev/xvdf /mnt/temp-volume
```

Check the filesystem/disk space:

```bash
df -h
```

Unmount it when required:

```bash
umount /mnt/temp-volume
```

---

# ⭐ Most Important Commands to Remember

For my **DevOps/Cloud Engineer interviews and practicals**, these are the commands I should remember first.

### Processes

```bash
ps aux
ps -ef
ps aux | grep java
kill PID
kill -9 PID
kill -3 PID
kill -STOP PID
kill -CONT PID
renice -n 10 -p PID
```

### Services

```bash
systemctl list-units --type=service
systemctl start SERVICE
systemctl stop SERVICE
```

### Monitoring

```bash
top
htop
vmstat
free -h
nproc
df -h
du -sh *
```

### Disk Management

```bash
lsblk
sudo fdisk -l
mkfs -t ext4 /dev/xvdf
mount /dev/xvdf /mnt/temp-volume
umount /mnt/temp-volume
```

---

# 🧠 One-Line Memory Trick

```text
ps        → See processes
kill      → Kill process
STOP      → Stop process
CONT      → Resume process
renice    → Change priority
systemctl → Manage services

top       → Monitor everything
free      → Memory
nproc     → CPU count
df        → Disk/filesystem
du        → Folder disk usage

lsblk     → See disks
fdisk     → See partitions
mkfs      → Format disk
mount     → Attach filesystem to a directory
umount    → Remove the mount
```

---

# 🔄 Overall Understanding

```text
              LINUX COMMANDS
                    │
       ┌────────────┼────────────┐
       │            │            │
   Processes     Services    Monitoring
       │            │            │
      ps        systemctl       top
      kill                       htop
     renice                     vmstat
                                free
                                nproc
                                df
                                du
       │
       │
       └──────────────┐
                      │
                Disk Management
                      │
          ┌───────────┼───────────┐
          │           │           │
        lsblk       fdisk        mkfs
                                  │
                                mount
                                  │
                                df
                                  │
                               umount
```

These are the main Linux commands I learned in this section, with networking kept limited to the concepts my teacher mentioned.
