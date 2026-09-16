# 🖥️ DAY 2 — LINUX BASICS & SYSTEM INFORMATION

## 🎯 Today's Goal

Day 1 was about the **Linux Boot Process**.

Now in Day 2, the goal is simple:

> **Learn how to look at a Linux machine and understand what it's telling you.**

As a Cloud Support Engineer, one of the first questions I should ask is:

> **"What's happening on this server?"**

Linux provides commands that help me answer that question.

---

# 🧒 1. What is a Linux Command?

I can think of Linux as a person who understands instructions.

For example, I type:

```bash
ls
```

Linux gives me the result.

So the basic idea is:

```text
You
 ↓
Command
 ↓
Linux
 ↓
Result
```

Another example:

```bash
pwd
```

Linux might return:

```text
/root
```

That means:

> "You are currently inside `/root`."

---

# 🟢 2. `pwd` — Where Am I?

`pwd` means:

> **Print Working Directory**

Imagine I am inside a huge shopping mall.

I ask:

> 🧒 "Where am I?"

Linux tells me my current directory.

Run:

```bash
pwd
```

Example:

```text
/root
```

That means I am currently inside `/root`.

### 🎯 Interview Understanding

```text
pwd → tells me my current directory
```

---

# 🟢 3. `ls` — What's Here?

Imagine I am inside a room.

I ask:

> 🧒 "What things are inside this room?"

I use:

```bash
ls
```

Example:

```text
file1.txt
notes.txt
projects
```

So:

```text
ls → lists files and directories
```

---

## 🔍 `ls -l`

If I want more detailed information:

```bash
ls -l
```

Example:

```text
-rw-r--r--  user user  120  Sep 16  file.txt
```

I don't need to understand every column yet.

Permissions will be studied properly later.

For now:

> `ls -l` gives me a **detailed listing**.

---

# 🟢 4. `cd` — Move Around

`cd` means:

> **Change Directory**

I can think of directories as different rooms.

`cd` allows me to move between them.

For example:

```bash
cd /tmp
```

Now I am inside `/tmp`.

I can check where I am:

```bash
pwd
```

Output:

```text
/tmp
```

To go back:

```bash
cd ..
```

Here:

```text
.. → Parent directory
```

So `cd ..` means:

> Go to the directory one level above the current directory.

---

# 🟢 5. `whoami` — Who Am I?

Imagine I am wearing a mask and forgot who I am. 😂

I can ask Linux:

```bash
whoami
```

Example:

```text
root
```

Linux tells me:

> "You are root."

This is important because **the user I am logged in as affects what I am allowed to do.**

---

# 🟢 6. `id` — Tell Me About This User

Run:

```bash
id
```

Example:

```text
uid=0(root) gid=0(root) groups=0(root)
```

This gives information about:

* User ID
* Group ID
* Groups the user belongs to

We'll study users and groups in detail later.

For now, remember:

```text
whoami → Who am I?

id → What are my user/group IDs and memberships?
```

---

# 🟢 7. `uname` — Tell Me About the System

Now imagine I am a doctor checking a machine. 🩺

I ask:

> "What kind of system are you?"

Run:

```bash
uname
```

You might get:

```text
Linux
```

If I want more information:

```bash
uname -a
```

Example:

```text
Linux hostname 6.x.x ... x86_64 GNU/Linux
```

This can provide information about:

* Kernel name
* Hostname
* Kernel release/version
* Architecture

So:

```text
uname     → basic system information
uname -a  → detailed system/kernel information
```

---

# 🟢 8. `uptime` — How Long Has the Machine Been Awake?

Imagine my computer woke up at:

```text
8:00 AM
```

and now it is:

```text
12:00 PM
```

I ask:

> "How long have you been awake?"

Run:

```bash
uptime
```

Example:

```text
10:35:21 up 5 days, 3:12, 2 users, load average: 0.20, 0.15, 0.10
```

This tells me things such as:

```text
Current time
How long the system has been running
Number of logged-in users
Load averages
```

---

# 🔥 Why `uptime` Is Important for Cloud Support

Imagine a customer says:

> **"The server suddenly became slow."**

One command I could start with is:

```bash
uptime
```

Why?

Because:

* **Uptime** tells me how long the machine has been running.
* **Load average** gives me an initial clue about system activity.

We'll learn load average properly when we study CPU and performance.

---

# 🟢 9. `date` — What Time Is It?

Run:

```bash
date
```

Example:

```text
Wed Sep 16 10:45:00 IST 2026
```

It displays the system's current date and time.

This becomes important when troubleshooting logs.

For example:

```text
Application log:
10:00 → error

Server time:
11:00
```

Now I have a time synchronization problem to investigate.

We'll study:

> **Date/time + NTP**

later.

---

# 🟢 10. `hostname` — What's This Machine Called?

Run:

```bash
hostname
```

Example:

```text
ip-10-0-1-25
```

This tells me the system's hostname.

This is very useful when I am working with multiple servers.

Imagine:

```text
Server A
Server B
Server C
```

I don't want to accidentally troubleshoot the wrong machine. 😄

So checking the hostname helps me confirm:

> **"Which server am I actually working on?"**

---

# 🟢 11. `top` — What's Happening RIGHT NOW?

🔥 This is one of the most important commands from the interview list.

I can think of Linux as a hospital.

`top` is like a **live monitor showing which processes are using the most resources**.

Run:

```bash
top
```

I'll see running processes and resource information.

Something like:

```text
PID   USER   %CPU   %MEM   COMMAND
123   root   85.0    2.1   python
456   user   20.0    5.0   java
789   user    2.0    1.0   sshd
```

---

# 🧠 What Should I Look At in `top`?

## `%CPU`

This tells me how much CPU a process is using.

Example:

```text
python → 90%
```

That process is consuming a lot of CPU.

---

## `%MEM`

This tells me how much memory a process is using.

Example:

```text
java → 20%
```

That process is using a significant amount of memory.

---

## `PID`

PID means:

> **Process ID**

Example:

```text
12345
```

Every running process has a PID.

We'll study PIDs properly during the **Process Management** days.

---

# 🔥 `top` and Cloud Support

Imagine a customer says:

> **"My Linux server is very slow."**

I can run:

```bash
top
```

Then investigate:

```text
CPU
Memory
Processes
Load
```

For example:

```text
CPU → 99%
```

I would investigate which process is consuming CPU.

Or:

```text
Memory → almost full
```

I would investigate which processes are consuming memory.

So I shouldn't simply memorize:

> `top = process command`

Instead, I should understand:

> **`top` gives me a live view of system activity and resource usage.**

---

# 🟢 12. `free` — How Much Memory Do I Have?

Run:

```bash
free
```

A better version is:

```bash
free -h
```

Here:

```text
-h → human-readable
```

Example:

```text
               total   used   free
Mem:           8Gi     4Gi    2Gi
Swap:          2Gi     0Gi    2Gi
```

It helps me understand:

* Memory usage
* Available/free memory
* Swap usage

For now:

```text
free -h → memory information
```

We'll study memory properly later.

---

# 🟢 13. `df` — How Much Disk Space?

`df` means:

> **Disk Filesystem**

Run:

```bash
df
```

A better version is:

```bash
df -h
```

Example:

```text
Filesystem   Size   Used   Avail   Use%
/dev/sda1     30G    20G    10G    67%
```

This tells me filesystem disk usage.

---

# 🟢 14. `du` — Which Files/Folders Are Using Space?

This is important because:

> `df` and `du` are different.

Think of them like this:

### `df`

> "How full is the whole filesystem?"

### `du`

> "Which files/folders are using the space?"

Example:

```bash
du -sh /var/log
```

It could show:

```text
2.5G    /var/log
```

So remember:

```text
df → filesystem usage

du → directory/file usage
```

🔥 I should remember this distinction.

---

# 🧠 `df` vs `du`

A simple analogy:

Imagine I have a water tank.

```text
df
 ↓
How much water is in the tank?
```

And:

```text
du
 ↓
Which bucket is using the water?
```

This isn't a perfect technical analogy, but it makes the purpose easier to remember.

---

# 🟢 15. Putting Our Commands Together

Imagine I am given a Linux server.

The customer says:

> **"Something seems wrong with this server."**

I shouldn't randomly run commands.

I can start by gathering basic information:

```bash
whoami
hostname
uname -a
uptime
date
```

Then check resources:

```bash
top
free -h
df -h
```

If disk usage looks suspicious, I can investigate directories:

```bash
du -sh <directory>
```

This is the beginning of a:

> **Structured troubleshooting approach**

---

# 🔥 IMPORTANT CLOUD SUPPORT THINKING

Don't just memorize commands.

Think in terms of:

> **Question → Command → Information**

| Question                | Command    |
| ----------------------- | ---------- |
| Who am I?               | `whoami`   |
| What are my IDs/groups? | `id`       |
| Where am I?             | `pwd`      |
| What's here?            | `ls`       |
| Move somewhere?         | `cd`       |
| What OS/kernel?         | `uname -a` |
| How long running?       | `uptime`   |
| What time?              | `date`     |
| Machine name?           | `hostname` |
| What's happening now?   | `top`      |
| How much memory?        | `free -h`  |
| How much disk?          | `df -h`    |
| What uses disk?         | `du`       |

🔥 **This table is worth memorizing.**

---

# 🎯 INTERVIEW QUESTIONS FROM DAY 2

## Q1. What does `ls` do?

> It lists files and directories.

---

## Q2. What does `pwd` do?

> It displays the current working directory.

---

## Q3. What does `whoami` do?

> It shows the currently logged-in username.

---

## Q4. What does `uname -a` do?

> It displays detailed system/kernel information.

---

## Q5. What does `uptime` show?

> It shows how long the system has been running, logged-in users, and load averages.

---

## Q6. How do you check memory?

```bash
free -h
```

---

## Q7. How do you check disk space?

```bash
df -h
```

---

## Q8. How do you find which directories are consuming disk space?

```bash
du -sh <directory>
```

---

## Q9. How do you check what is consuming CPU?

```bash
top
```

---

## Q10. Why is `top` useful?

> It provides a live view of processes and system resource usage such as CPU and memory.

---

# 🧪 DAY 2 — PRACTICAL

Since I'm practicing Linux using my Ubuntu environment, I should run these **one at a time**.

### Step 1 — Where am I?

```bash
pwd
```

### Step 2 — What's here?

```bash
ls
```

### Step 3 — Who am I?

```bash
whoami
```

### Step 4 — What are my IDs and groups?

```bash
id
```

### Step 5 — What system am I using?

```bash
uname -a
```

### Step 6 — How long has the system been running?

```bash
uptime
```

### Step 7 — What time is it?

```bash
date
```

### Step 8 — What's the machine called?

```bash
hostname
```

### Step 9 — Check memory

```bash
free -h
```

### Step 10 — Check disk

```bash
df -h
```

### Step 11 — Check live system activity

```bash
top
```

To exit `top`, press:

```text
q
```

---

# 🏆 DAY 2 — WHAT I SHOULD UNDERSTAND

By the end of Day 2, I should be able to look at a Linux machine and answer:

```text
Who am I?
    ↓
whoami

Where am I?
    ↓
pwd

What's here?
    ↓
ls

What system is this?
    ↓
uname -a

How long has it been running?
    ↓
uptime

What's happening?
    ↓
top

How much memory?
    ↓
free -h

How much disk?
    ↓
df -h

What's using disk?
    ↓
du
```

---

# 🧠 DAY 2 — FINAL MEMORY MAP

```text
                 LINUX SERVER
                      │
        ┌─────────────┴─────────────┐
        │                           │
     Identity                    System
        │                           │
   whoami / id              uname / hostname
        │                           │
        └─────────────┬─────────────┘
                      │
                 Location
                      │
                 pwd / ls / cd
                      │
                      ▼
                 System Health
                      │
          ┌───────────┼───────────┐
          │           │           │
        uptime       top       free -h
          │           │           │
        runtime    CPU/process   memory
                      │
                      ▼
                  Disk Health
                      │
                  ┌───┴───┐
                  │       │
                df -h     du
                  │       │
             filesystem  files/
               usage    directories
```

---

# 🔥 ONE-MINUTE REVISION

```text
pwd       → Where am I?
ls        → What's here?
cd        → Move directory
whoami    → Who am I?
id        → User/group information
uname -a  → System/kernel information
uptime    → How long has system been running?
date      → Current system date/time
hostname  → Machine name
top       → Live system/process activity
free -h   → Memory information
df -h     → Filesystem disk usage
du        → File/directory disk usage
```

## 🎯 My Main Takeaway

I don't want to memorize Linux commands blindly.

I want to think:

> **"What question do I have about this server?"**

Then:

> **"Which Linux command can give me the answer?"**

That is the beginning of a **Cloud Support troubleshooting mindset**.

---

# 🏁 DAY 2 COMPLETE

### ✅ Concepts Covered

* Linux commands
* `pwd`
* `ls`
* `ls -l`
* `cd`
* `whoami`
* `id`
* `uname`
* `uname -a`
* `uptime`
* Load average introduction
* `date`
* Time synchronization troubleshooting idea
* `hostname`
* `top`
* CPU usage
* Memory usage
* PID introduction
* `free`
* `free -h`
* `df`
* `df -h`
* `du`
* `du -sh`
* `df` vs `du`
* Structured troubleshooting
* Cloud Support thinking
* Interview questions
* Day-2 practical commands

> 🔥 **Day 1 = How Linux starts**
>
> 🔥 **Day 2 = How I inspect a running Linux system**
>
> 🚀 **Next = Day 3**
