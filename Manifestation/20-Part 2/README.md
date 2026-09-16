# 🚀 OS DAY 4 — PART 2

## `top` + `sar` + Slow Linux Machine — Interview Level

Day 3 is complete. ✅

In Part 1, I learned the basic commands.

Now I'm going one level deeper to understand **what an interviewer actually expects me to know**.

---

# 🔥 1. `top` — Understand It Properly

Run:

```bash
top
```

I can think of `top` as a:

> 📹 **Live CCTV camera for my Linux server**

It shows:

* CPU usage
* Memory usage
* Load average
* Running processes
* Process IDs
* Which processes are consuming resources

Example:

```text
PID    USER     %CPU    %MEM    COMMAND
1234   root     90.0     5.2    python
2345   root     20.0     2.1    nginx
```

Immediately, I can see:

```text
python → using 90% CPU
```

So I have a clue and can investigate that process.

---

# 🧠 2. What Does `%CPU` Mean?

Suppose:

```text
python → 80% CPU
```

This means that process is consuming a significant amount of CPU processing capacity.

If I see:

```text
%CPU
95%
```

I should ask:

> **"Why is this process consuming so much CPU?"**

⚠️ I should **not immediately kill the process**.

First, I need to understand:

> **What is the process doing?**

---

# 🧠 3. What Does `%MEM` Mean?

Example:

```text
PID    %CPU    %MEM    COMMAND
1234   20.0    70.0    java
```

Here:

```text
CPU    → 20%
Memory → 70%
```

The Java process is consuming a large amount of memory.

Then I can investigate whether the system is experiencing memory pressure.

---

# 🔥 4. `ps` vs `top`

I already learned:

```bash
ps aux
```

and:

```bash
top
```

So what's the difference?

## `ps`

```bash
ps aux
```

Gives me a:

> 📸 **Snapshot of processes**

---

## `top`

```bash
top
```

Gives me a:

> 📹 **Continuously updating view**

---

# 🧠 Easy Memory Trick

```text
ps  → Photo 📸
top → Live Camera 📹
```

That's an easy way to remember the difference.

---

# 🔥 5. `sar` — Interviewers May Ask This Directly

`SAR` means:

> **System Activity Reporter**

It can provide system performance information **over time**, when its data collection is configured.

For CPU:

```bash
sar -u
```

For memory:

```bash
sar -r
```

On some systems, I may need to install/enable the:

```text
sysstat
```

package for historical collection.

---

# 🧠 6. `top` vs `sar`

The main difference:

| Command | Main Purpose                      |
| ------- | --------------------------------- |
| `top`   | See what's happening now          |
| `sar`   | Examine system activity over time |

### Example

If the problem is happening **right now**:

```bash
top
```

If the problem happened **earlier**:

```bash
sar
```

This distinction is useful in Cloud Support interviews.

---

# 🐌 7. Real Interview Scenario

Interviewer:

> **"A customer's Linux server is very slow. What will you do?"**

I should use a structured troubleshooting approach.

---

## Step 1 — Check CPU

Run:

```bash
top
```

Ask:

```text
Is CPU extremely busy?
Which process is using CPU?
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

```text
Is available memory very low?
Is swap being used heavily?
```

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

Then interpret the load relative to:

* Number of CPU cores
* System workload

---

## Step 4 — Check Disk

Run:

```bash
df -h
```

Ask:

```text
Is any filesystem full?
```

If necessary:

```bash
du -sh *
```

This helps investigate space usage.

---

## Step 5 — Check Processes

Run:

```bash
ps aux
```

Look for:

* Abnormal CPU usage
* Abnormal memory usage
* Unusual processes
* Processes in unusual states

---

## Step 6 — Check Historical Activity

Run:

```bash
sar
```

if historical data is available.

Ask:

> **"Was this a sudden problem, or has it been happening repeatedly?"**

---

# 🧠 8. Important Troubleshooting Principle

Suppose the customer says:

> **"My server is slow."**

Remember:

> **"Slow" is a symptom, not the root cause.**

There can be many possible causes:

```text
Slow Server
    │
    ├── CPU problem
    │
    ├── Memory problem
    │
    ├── Disk problem
    │
    ├── Process problem
    │
    └── Other system/resource issue
```

My job as a Cloud Support Engineer is to:

> **Find the bottleneck using evidence.**

I shouldn't guess the cause.

---

# 🎤 9. Interview Question — CPU Utilization

### ❓ How do you check CPU utilization in Linux?

### Good Answer

> **"I can use `top` to view current CPU utilization and identify processes consuming CPU. I can also use `sar -u` to examine CPU activity over time when SAR data is available."**

---

# 🎤 10. Interview Question — `top`

### ❓ What is the `top` command?

### Answer

> **"`top` is a real-time system monitoring command in Linux. It displays processes and resource usage such as CPU and memory, and helps identify processes consuming high resources."**

---

# 🎤 11. Interview Question — `sar`

### ❓ What is `sar`?

### Answer

> **"`sar` stands for System Activity Reporter. It is used to collect and report system performance information such as CPU and memory activity over time."**

---

# 🎯 12. Don't Memorize Commands Blindly

Imagine:

```text
Customer: Server is slow.
```

I shouldn't immediately type 20 commands.

Instead, I should think:

```text
WHAT RESOURCE IS THE PROBLEM?
        ↓
CPU?
        ↓
Memory?
        ↓
Load?
        ↓
Disk?
        ↓
Process?
        ↓
Historical Pattern?
```

That's the:

> 🧠 **Support Engineer Mindset**

---

# 🏆 DAY 4 FINAL CHECK

I should now be able to answer:

* ✅ What is CPU?
* ✅ What is CPU utilization?
* ✅ What is `top`?
* ✅ What does `%CPU` mean?
* ✅ What does `%MEM` mean?
* ✅ `ps` vs `top`
* ✅ What is load average?
* ✅ What is `sar`?
* ✅ `top` vs `sar`
* ✅ How to check CPU utilization
* ✅ How to troubleshoot a slow Linux machine
* ✅ How to approach a Cloud Support performance issue

---

# 🧠 DAY 4 MASTER MEMORY

```text
                 SERVER IS SLOW
                        │
                        ▼
              WHAT RESOURCE IS BUSY?
                        │
          ┌─────────────┼─────────────┐
          ↓             ↓             ↓
         CPU          Memory         Load
          │             │             │
         top          free -h       uptime
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
   Corrective Action
          │
          ▼
        Verify
```

---

# ⭐ QUICK COMMAND MEMORY

```text
CPU         → top
Memory      → free -h
Load        → uptime
Disk        → df -h
Processes   → ps aux
History     → sar
```

---

# 🔥 MOST IMPORTANT IDEA

When a customer says:

> **"My Linux server is slow."**

I should never assume the cause.

I should think:

```text
Slow = Symptom
       ↓
Collect Evidence
       ↓
Check Resources
       ↓
Find Bottleneck
       ↓
Investigate Root Cause
       ↓
Take Corrective Action
       ↓
Verify
```

> **Don't just fix the symptom. Find the actual bottleneck.**

---

# 🟢 DAY 4 = COMPLETE ✅
