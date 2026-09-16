# 🚀 OS DAY 4 — CPU, `top`, `sar` & Slow Linux Machine

Day 3 is complete. ✅

Today I'm focusing on one of the **most important Cloud Support interview areas**:

> **"The Linux server is slow. How will I troubleshoot it?"**

I'll keep it simple and practical.

---

# 🧠 1. What is CPU?

Think of the **CPU as the worker** of the computer.

If I give the worker 5 tasks → easy.

If I give the worker **500 tasks at the same time** → the worker becomes very busy.

That's similar to what happens when CPU usage becomes high.

Example:

```text
CPU Usage = 20%
```

The CPU has plenty of capacity.

But:

```text
CPU Usage = 95%
```

The CPU is very busy.

---

# 🔥 2. What is CPU Utilization?

> **CPU utilization = how much of the CPU's processing capacity is currently being used.**

For example:

```text
CPU: 100%

Application A → 70%
Application B → 20%
Other         → 10%
--------------------
Total         → 100%
```

The CPU is completely busy.

### 🎯 Interview Answer

> **CPU utilization tells us how much of the CPU is currently being used by processes and system activity.**

---

# 🛠️ 3. How Do I Check CPU Utilization?

The most important command for my interview is:

```bash
top
```

Run:

```bash
top
```

I'll see something similar to:

```text
%Cpu(s): 80.0 us, 10.0 sy, 0.0 ni, 10.0 id
```

Don't panic. 😄

I only need to understand the important values first.

---

# 🎯 4. Important `top` CPU Values

## `us` — User

CPU being used by **user applications/processes**.

Example:

```text
us = 80%
```

This means applications are using a lot of CPU.

---

## `sy` — System

CPU being used by the **Linux kernel/system operations**.

Example:

```text
sy = 10%
```

---

## `id` — Idle

CPU that is **doing nothing**.

Example:

```text
id = 10%
```

That means the CPU is mostly busy.

---

# 🧠 Easy Way to Remember

```text
us → User programs
sy → System/kernel
id → Idle
```

---

# 🔥 5. `top` Also Shows Processes

Inside `top`, I'll see something like:

```text
PID     USER     %CPU    %MEM    COMMAND
1234    root     85.0    2.1     python
2345    root     10.0    1.5     nginx
3456    root      5.0    1.0     sshd
```

The important column here is:

```text
%CPU
```

For example:

```text
python → 85%
```

This gives me a clue that the Python process is consuming significant CPU.

---

# 🚪 6. How Do I Exit `top`?

Simply press:

```text
q
```

---

# ⚡ 7. What is Load Average?

This is **very important for Linux interviews**.

When I run:

```bash
uptime
```

I may see:

```text
load average: 0.50, 0.70, 0.80
```

These represent approximately:

```text
1 minute
5 minutes
15 minutes
```

---

## 🍽️ Easy Restaurant Analogy

Think of:

```text
CPU       = Chef
Processes = Customers
Load      = Queue
```

If the queue is small:

```text
Load → low
```

If many tasks are waiting for CPU/resources:

```text
Load → high
```

### ⚠️ Important

I should **not judge load average using one fixed number alone**.

The number needs to be interpreted relative to:

* Number of CPU cores
* What the processes are waiting for

So a load value that looks high on one machine may not mean the same thing on another machine.

---

# 🔥 8. What is `sar`?

Another command mentioned in my interview list is:

```bash
sar
```

`SAR` stands for:

> **System Activity Reporter**

It is used to look at **system performance/activity over time**.

The main difference:

```text
top
 ↓
What's happening right now?
```

while:

```text
sar
 ↓
What was the system doing over time?
```

`sar` can help me examine **historical/periodic performance data**, when the required accounting data is available.

---

# 🖥️ `sar` Examples

### CPU

```bash
sar -u
```

### Memory

```bash
sar -r
```

Depending on the Linux distribution, `sar` may not be installed by default.

On Ubuntu/Debian systems, it is commonly provided by:

```text
sysstat
```

---

# 🐌 9. MOST IMPORTANT INTERVIEW QUESTION

## ❓ "The Linux machine is very slow. How will you troubleshoot it?"

I should **not** simply answer:

> "I will restart the server."

❌ That's not a good troubleshooting approach.

Instead, I should use a **structured approach**.

---

# 🧑‍💻 Step-by-Step Troubleshooting

## Step 1 — Check CPU

Run:

```bash
top
```

Ask:

> **Is CPU utilization very high?**

If yes, investigate:

```text
Which process is consuming CPU?
```

Look at:

```text
%CPU
```

---

## Step 2 — Check Memory

Run:

```bash
free -h
```

Ask:

> **Is available memory very low?**

Also check:

> **Is swap usage high?**

---

## Step 3 — Check Load

Run:

```bash
uptime
```

Look at:

```text
load average
```

Compare it with the system's CPU capacity and investigate what is causing the load.

---

## Step 4 — Check Disk Space

Run:

```bash
df -h
```

Ask:

> **Is any filesystem almost full or completely full?**

If needed, find large directories:

```bash
du -sh *
```

---

## Step 5 — Check Processes

Run:

```bash
ps aux
```

or:

```bash
top
```

Look for:

* High CPU
* High memory
* Unusual processes
* Processes stuck/waiting

---

## Step 6 — Check Historical Performance

Use:

```bash
sar
```

if historical data is available.

This helps answer:

> **"Was the machine slow only now, or has this been happening repeatedly?"**

---

# 🧠 Complete Troubleshooting Flow

I should remember this:

```text
SERVER IS SLOW
      ↓
Check CPU
      ↓
Check Memory
      ↓
Check Load
      ↓
Check Disk
      ↓
Check Processes
      ↓
Check Historical Data / Logs
      ↓
Find the Actual Bottleneck
      ↓
Take Corrective Action
```

🔥 This is the **Cloud Support mindset**.

> **Don't randomly restart things.**

First find the actual bottleneck.

---

# ☁️ AWS / Cloud Support Example

Imagine an EC2 instance suddenly becomes slow.

I SSH into the instance and run:

```bash
top
```

I discover:

```text
%CPU = 98%
```

Then I look at the process list:

```text
PID     %CPU     COMMAND
4210    94.0     python
```

Now I have a direction:

```text
EC2 slow
   ↓
CPU high
   ↓
Python process consuming CPU
   ↓
Investigate that process/application
```

That's much better than:

> "The EC2 is slow, so I'll reboot it."

---

# 🎤 Interview-Ready Answer

If the interviewer asks:

> **"How would you troubleshoot a slow Linux machine?"**

I can answer:

> **"First, I would identify which resource is causing the bottleneck. I would use `top` to check CPU utilization and identify high-CPU processes. Then I would check memory and swap using `free -h`, load average using `uptime`, and disk usage using `df -h`. I would also inspect processes with `ps` and use `sar` to check historical system activity when available. Based on the findings, I would investigate the process or resource causing the issue and then take the appropriate corrective action."**

🔥 This gives me a structured Cloud Support answer instead of just saying "restart the server."

---

# 🧪 DAY 4 PRACTICAL

Since I'm practicing Linux using my Ubuntu container, I'll run these **one by one**.

## 1. Check live CPU/process information

```bash
top
```

Exit:

```text
q
```

---

## 2. Check uptime and load average

```bash
uptime
```

---

## 3. Check memory

```bash
free -h
```

---

## 4. Check disk space

```bash
df -h
```

---

## 5. Check processes

```bash
ps aux
```

---

## 6. Check CPU history/activity

```bash
sar -u
```

If I get:

```text
sar: command not found
```

Don't worry.

It simply means `sar` isn't installed in my container.

---

# 📝 DAY 4 CHEAT SHEET

| Command   | Purpose                                |
| --------- | -------------------------------------- |
| `top`     | Live CPU/process/resource monitoring   |
| `uptime`  | Uptime + load average                  |
| `free -h` | Memory + swap                          |
| `df -h`   | Filesystem disk usage                  |
| `du -sh`  | Directory/file space usage             |
| `ps aux`  | Process list                           |
| `sar -u`  | CPU activity/history when available    |
| `sar -r`  | Memory activity/history when available |

---

# ⭐ The 4 Commands I MUST Remember

```text
CPU    → top
Memory → free -h
Load   → uptime
Disk   → df -h
```

---

# 🧠 DAY 4 MASTER MEMORY

```text
                 LINUX SERVER
                      │
                      ▼
                SERVER IS SLOW
                      │
          ┌───────────┼───────────┐
          ↓           ↓           ↓
         CPU        Memory       Load
          │           │           │
        top        free -h      uptime
          │
          ▼
      Processes
          │
       ps aux
          │
          ▼
        Disk
          │
        df -h
          │
          ▼
   Historical Activity
          │
        sar
          │
          ▼
    Find Bottleneck
          │
          ▼
       Fix + Verify
```

---

# 🏆 DAY 4 FINAL TAKEAWAY

When someone says:

> **"The Linux server is slow."**

My first thought should NOT be:

> ❌ "Restart it."

My thought should be:

```text
What resource is causing the problem?
          ↓
CPU?
Memory?
Load?
Disk?
Process?
Historical pattern?
Logs?
          ↓
Find the bottleneck
          ↓
Take the appropriate action
          ↓
Verify the result
```

That's the **Cloud Support troubleshooting mindset**.

---

# ✅ DAY 4 STATUS

```text
CPU                              ✅
CPU Utilization                  ✅
top                              ✅
us / sy / id                     ✅
CPU-consuming processes          ✅
Load Average                     ✅
1 / 5 / 15 minute load           ✅
sar                              ✅
Historical performance           ✅
Slow Linux troubleshooting      ✅
Cloud / EC2 scenario             ✅
Interview answer                 ✅
Practical commands               🟡
```

# 🚀 DAY 4 → THEORY COMPLETE

**Practical is the remaining part.**
