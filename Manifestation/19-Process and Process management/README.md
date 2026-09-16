# 🚀 DAY 3 — PROCESSES & PROCESS MANAGEMENT

Day 2 is complete. ✅

Today I'm learning one of the **most important OS topics for Cloud Support**, especially because interviews commonly ask about:

* What is a process?
* Process management
* Process states / lifecycle
* What is a PID?
* What is `fork()`?
* What are system calls?
* Foreground vs background processes
* How to identify running processes

I'll learn everything **slowly and simply**. 🧒

---

# 🧒 1. What is a Program?

Imagine I have a **recipe for making pizza**. 🍕

The recipe is just a set of instructions.

Similarly:

```text
Program = Instructions stored on disk
```

Examples:

```text
python
nginx
java
```

A program simply existing on disk does **not** mean it is currently doing something.

It is just the instructions/code.

---

# 🟢 2. What is a Process?

Now imagine I actually start following the pizza recipe.

🍕 The recipe is now running.

That's similar to a **process**.

> **A process is a program that is currently executing.**

Simple flow:

```text
Program
   ↓
You run it
   ↓
Process
```

Example:

Before I run:

```bash
app.py
```

It is a:

```text
Program
```

When I run:

```bash
python app.py
```

it becomes a:

```text
Process
```

---

# 🧠 Program vs Process

| Program           | Process                         |
| ----------------- | ------------------------------- |
| Instructions/code | Running instance of the program |
| Stored on disk    | Exists while executing          |
| Passive           | Active                          |
| Example: `app.py` | Running `python app.py`         |

### Easy memory trick

> **Program = recipe 📖**

> **Process = cooking 🍳**

---

# 🟢 3. Every Process Gets a PID

When Linux starts a process, it gives it an identification number.

This is called:

# PID = Process ID

Think about students in a classroom:

```text
Student  → Roll number
Process  → PID
```

Example:

```text
Process
   ↓
PID = 1234
```

Linux can use the PID to identify that particular process.

---

# 🟢 4. How Do I See Processes?

The simplest command is:

```bash
ps
```

Run:

```bash
ps
```

You might see:

```text
PID   TTY      TIME     CMD
1234  pts/0    00:00    bash
5678  pts/0    00:00    ps
```

I can see information such as:

```text
PID
Command
```

---

# 🟢 5. `ps aux`

If I want a much larger list of processes:

```bash
ps aux
```

This shows many running processes.

I'll see columns such as:

```text
USER
PID
%CPU
%MEM
COMMAND
```

Example:

```text
root    100   0.1   1.2   nginx
root    200   2.5   3.0   python
```

This becomes extremely useful during troubleshooting.

---

# 🔥 6. Why Does a Cloud Support Engineer Care About Processes?

Imagine a customer says:

> **"My EC2 server is extremely slow."**

One possible reason could be:

```text
Some process
     ↓
Using huge CPU
     ↓
Server becomes slow
```

I can investigate using:

```bash
top
```

or:

```bash
ps aux
```

Then I identify which process is using the resources.

That's why understanding processes isn't just theory.

It's a real Cloud Support troubleshooting skill.

---

# 🟢 7. Foreground Process

Imagine I'm talking directly to someone.

I start:

```bash
ping google.com
```

The command runs in my terminal.

My terminal is occupied with that command.

That's a:

> **Foreground process**

Think:

```text
Terminal
   ↓
Process
   ↓
I interact with it
```

The terminal waits while the command is running.

---

# 🟢 8. Background Process

Now imagine I tell someone:

> "Go do this task while I continue working."

That's similar to a **background process**.

I can run a command using:

```bash
command &
```

For example:

```bash
sleep 100 &
```

The `&` tells the shell to start the command in the background.

Now I can continue using my terminal.

---

# 🧠 Foreground vs Background

### Foreground

```bash
sleep 100
```

My terminal waits for it to finish.

### Background

```bash
sleep 100 &
```

The command runs in the background.

I can continue typing other commands.

---

# 🟢 9. Jobs

When I run something in the background from my shell, I can see shell jobs using:

```bash
jobs
```

Example:

```text
[1]+  Running  sleep 100 &
```

I can bring a job back to the foreground with:

```bash
fg
```

These are **shell job-control concepts**.

Later I'll distinguish them from the broader Linux concept of process management.

---

# 🟢 10. Parent & Child Processes

This is important.

Imagine:

```text
👨 Parent
    ↓
👶 Child
```

Processes can also have relationships.

A process can create another process.

```text
Parent Process
      ↓
Child Process
```

Linux tracks this relationship.

---

# 🟢 11. PPID

If:

```text
PID = Process ID
```

then:

# PPID = Parent Process ID

Example:

```text
Parent
PID = 1000
   ↓
Child
PID = 2000
PPID = 1000
```

So:

```text
PID  → Who am I?
PPID → Who created/is my parent?
```

---

# 🔥 12. `fork()` — VERY IMPORTANT

An interview may ask:

> **"Explain `fork()`."**

Let's make it simple.

Imagine I have one child.

The child makes a copy of itself.

Now there are two processes.

That's the basic idea behind:

# `fork()`

In Unix/Linux:

> **`fork()` creates a new process by duplicating the calling process.**

Conceptually:

```text
Parent Process
      |
    fork()
      ↓
 ┌───────────┐
 ↓           ↓
Parent      Child
```

Now there are two processes.

---

# 🧒 Simple Story

Imagine I have:

```text
👦 One worker
```

I tell him:

> "Make another worker like yourself."

Now:

```text
👦 Worker 1
👦 Worker 2
```

Linux has created another process.

---

# 🧠 What Happens After `fork()`?

After `fork()`:

* The parent continues executing.
* The child continues executing.

The important return values are:

```text
Parent → positive value = child's PID
Child  → 0
Failure → -1
```

For my first understanding, remember:

```text
fork()
   ↓
Creates child process
```

We'll do a small C example during the practical side.

---

# 🟢 13. What is a System Call?

Another direct interview question:

> **"What are system calls?"**

Imagine I'm a child in a school.

I cannot directly enter the principal's office and change school records.

Instead, I make a request:

> "Sir, please do this for me."

Similarly, a user program cannot directly perform every privileged operation involving hardware or kernel-managed resources.

It asks the kernel through a:

# System Call

Simple flow:

```text
Application
     ↓
System Call
     ↓
Kernel
     ↓
Hardware / OS Resource
```

---

# 🧠 Examples of System Calls

A program may need to:

* Create a process
* Open a file
* Read a file
* Write to a file
* Communicate with the OS

Some familiar Linux system calls include:

```text
fork()
open()
read()
write()
close()
execve()
```

I don't need to memorize every system call.

For interviews, I need to understand the concept.

---

# 🔥 `fork()` IS A SYSTEM CALL

This is an important connection.

```text
Application
     ↓
fork()
     ↓
Kernel
     ↓
New process
```

So if the interviewer asks:

> **"Is `fork()` a system call?"**

Answer:

> **Yes. `fork()` is a Linux/Unix system call used to create a new process.**

---

# 🟢 14. Process Lifecycle

A process doesn't simply appear and disappear.

It goes through different states.

Think about a child at school:

```text
Waiting to play
      ↓
Playing
      ↓
Waiting
      ↓
Finished
```

Processes have states too.

A simplified lifecycle is:

```text
NEW
 ↓
READY
 ↓
RUNNING
 ↓
WAITING/BLOCKED
 ↓
READY
 ↓
RUNNING
 ↓
TERMINATED
```

---

# 🟢 15. NEW

The process is being created.

```text
Program
   ↓
Process being created
```

This is the **NEW** state.

---

# 🟢 16. READY

The process is ready to run but is waiting for CPU time.

Think:

> 🧒 "I'm ready! Give me my turn!"

```text
READY
  ↓
Waiting for CPU
```

---

# 🟢 17. RUNNING

The CPU is currently executing that process.

```text
CPU
 ↓
Process
```

The process is actively executing.

---

# 🟢 18. WAITING / BLOCKED

The process can't continue right now because it is waiting for something.

For example:

```text
Process
   ↓
Waiting for disk I/O
```

It doesn't necessarily need CPU at that moment.

When the event completes:

```text
WAITING
   ↓
READY
```

---

# 🟢 19. TERMINATED

The process finishes.

```text
RUNNING
   ↓
TERMINATED
```

Its execution is over.

---

# 🔥 Process Lifecycle Diagram

This is worth remembering:

```text
              ┌──────────┐
              │   NEW    │
              └────┬─────┘
                   ↓
              ┌──────────┐
              │  READY   │
              └────┬─────┘
                   ↓
              ┌──────────┐
              │ RUNNING  │
              └──┬────┬──┘
                 │    │
        waits    │    │ finishes
                 ↓    ↓
           ┌────────┐ ┌────────────┐
           │WAITING │ │ TERMINATED │
           └───┬────┘ └────────────┘
               │
               ↓
             READY
```

---

# 🧠 Linux Process States

When I run:

```bash
ps
```

I may see a process state column.

Common Linux process state codes include:

```text
R → Running / runnable
S → Interruptible sleep
D → Uninterruptible sleep
T → Stopped
Z → Zombie
```

I don't need to panic if these look strange.

I'll understand the important ones through troubleshooting.

---

# 🚨 20. What is a Zombie Process?

Imagine a child has finished school but the parent hasn't collected its final information yet. 👻

A zombie process is a process that has:

* Finished executing
* But still has an entry in the process table
* Because its parent has not yet collected its termination status

Simple flow:

```text
Child process
     ↓
Finished
     ↓
Parent hasn't collected status
     ↓
Zombie
```

A zombie isn't a normally running application consuming CPU like a regular process.

This is useful to know during troubleshooting.

---

# 🟢 21. How Do I Find Processes?

## Basic

```bash
ps
```

## Detailed process list

```bash
ps aux
```

## Live view

```bash
top
```

## Find a particular process

For example:

```bash
ps aux | grep nginx
```

This searches the process output for:

```text
nginx
```

---

# 🟢 22. How Do I Stop a Process?

Suppose:

```text
PID = 1234
```

I can send a signal:

```bash
kill 1234
```

The default `kill` request is a termination signal:

```text
SIGTERM
```

If a process refuses to terminate and I've determined that a stronger action is necessary, I may use:

```bash
kill -9 1234
```

`-9` sends:

```text
SIGKILL
```

`SIGKILL` cannot be caught or handled by the process.

⚠️ **Don't make `kill -9` the first choice.**

Usually:

```text
Try graceful termination
        ↓
Investigate
        ↓
Force only when appropriate
```

---

# 🔥 CLOUD SUPPORT SCENARIO

Customer:

> **"My application is not responding."**

I shouldn't immediately restart the server.

First, I can check:

```bash
ps aux
```

or:

```bash
top
```

Then ask:

```text
Is the process running?
       ↓
      Yes
       ↓
Is it consuming huge CPU?
       ↓
Is it consuming huge memory?
       ↓
Is it stuck/waiting?
       ↓
Is the required port listening?
       ↓
Check application logs
```

This is **structured troubleshooting**.

---

# 🎯 INTERVIEW QUESTIONS — DAY 3

## Q1. What is a process?

> A process is a program that is currently executing.

---

## Q2. What is a PID?

> PID is the unique process ID assigned to a process.

---

## Q3. What is PPID?

> PPID is the process ID of the parent process.

---

## Q4. Program vs Process?

> A program is stored instructions/code, while a process is an executing instance of a program.

---

## Q5. What is `fork()`?

> `fork()` is a Unix/Linux system call that creates a new child process.

---

## Q6. What is a system call?

> A system call is an interface through which a user-space program requests services or operations from the kernel.

---

## Q7. Explain process lifecycle.

```text
New
 ↓
Ready
 ↓
Running
 ↓
Waiting/Blocked ↔ Ready
 ↓
Terminated
```

---

## Q8. How do you see running processes?

```bash
ps
```

or:

```bash
ps aux
```

or:

```bash
top
```

---

## Q9. How do you terminate a process?

```bash
kill <PID>
```

---

# 🧪 DAY 3 PRACTICAL

Since I'm using my Ubuntu container, I can actually create and manage a process.

## Step 1 — Create a Background Process

Run:

```bash
sleep 300 &
```

I'll get something like:

```text
[1] 123
```

Here:

```text
1   → Shell job number
123 → PID
```

⚠️ The PID will be different on my machine.

---

## Step 2 — Find the Process

Run:

```bash
ps
```

Or:

```bash
ps aux | grep sleep
```

I should be able to find the `sleep` process.

---

## Step 3 — Check It Using `top`

Run:

```bash
top
```

I should be able to find the `sleep` process.

Exit `top` using:

```text
q
```

---

## Step 4 — Stop the Process

Suppose the actual PID is:

```text
123
```

Run:

```bash
kill 123
```

Replace `123` with the **actual PID** I received.

Then check again:

```bash
ps aux | grep sleep
```

---

# 🏆 DAY 3 MASTER MEMORY

## Program → Process

```text
PROGRAM
   ↓
RUN
   ↓
PROCESS
   ↓
PID
```

---

## Process Relationships

```text
Parent
  ↓
fork()
  ↓
Child
```

---

## Process Lifecycle

```text
NEW
 ↓
READY
 ↓
RUNNING
 ↓
WAITING
 ↓
READY
 ↓
RUNNING
 ↓
TERMINATED
```

---

## System Interaction

```text
Program
   ↓
System Call
   ↓
Kernel
   ↓
OS / Hardware Resources
```

---

## Process Commands

```text
ps       → See processes
ps aux   → Detailed process list
top      → Live process/resource view
kill     → Send signal to process
```

---

# 🧠 SUPER SIMPLE MEMORY TRICK

```text
Program
  ↓
Running
  ↓
Process
  ↓
PID
  ↓
Parent/Child
  ↓
fork()
  ↓
Process States
  ↓
Running / Waiting / Terminated
  ↓
ps / top
  ↓
kill
```

---

# 🔥 CLOUD SUPPORT MINDSET

If a customer says:

> **"My application is not responding."**

I should NOT immediately think:

> "Restart the server."

Instead, I should think:

```text
Is the process running?
        ↓
Is CPU high?
        ↓
Is memory high?
        ↓
Is the process waiting/stuck?
        ↓
Is the port listening?
        ↓
What do the logs say?
        ↓
Find the root cause
        ↓
Fix
        ↓
Verify
```

This is the mindset I need as a **Cloud Support Engineer**.

---

# ✅ DAY 3 STATUS

```text
Program vs Process          ✅
PID                         ✅
PPID                        ✅
Foreground/Background       ✅
Process relationships       ✅
fork()                      ✅
System Calls                ✅
Process Lifecycle           ✅
Process States              ✅
Zombie concept              ✅
ps / ps aux                 ✅
top                         ✅
kill                        ✅
Cloud troubleshooting       ✅
Interview questions         ✅
Practical                   ✅
```

# 🏁 DAY 3 → COMPLETE ✅

### 🔥 What I should remember most

> **Program = code/instructions.**

> **Process = running program.**

> **PID = process identity.**

> **PPID = parent process identity.**

> **`fork()` = creates a child process.**

> **System call = program requests a service from the kernel.**

> **`ps` / `ps aux` = see processes.**

> **`top` = live view of processes and resources.**

> **`kill` = send a signal to a process.**

> **Process lifecycle = New → Ready → Running → Waiting → Ready → Running → Terminated.**
