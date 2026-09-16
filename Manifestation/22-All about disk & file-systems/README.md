# 🚀 OS DAY 6 — DISK, FILESYSTEMS & INODES

Bro, **Day 5 is complete ✅**

Today I’m learning about:

* Disk space
* Filesystems
* `df`
* `du`
* Inodes
* `df -i`
* Disk troubleshooting
* Why a file may not be created even when disk space is available

The main interview question I should be able to answer is:

> ❓ **“Disk space is available, but a file is not getting created. Why?”**

---

# 🧠 1. What is Disk Space?

I can think of a disk like a **big cupboard**.

```text
💾 Disk
┌──────────────────────────┐
│ Files                    │
│ Applications             │
│ Logs                     │
│ Operating System         │
│                          │
│      FREE SPACE          │
└──────────────────────────┘
```

Disk space tells me **how much storage capacity is available**.

For example:

```text
Total Disk → 100 GB
Used       → 60 GB
Free       → 40 GB
```

So I have 40 GB of storage available.

---

# 🔥 2. How do I check Disk Space?

The most important command is:

```bash
df -h
```

I remember:

```text
df = disk filesystem information
-h  = human-readable
```

Example:

```text
Filesystem      Size  Used Avail Use%
/dev/sda1        20G   12G    8G  60%
```

I can understand this as:

```text
Total → 20 GB
Used  → 12 GB
Free  → 8 GB
```

So:

> `df -h` tells me how much space is available on the filesystem.

---

# 🧠 3. What is a Filesystem?

A filesystem is basically the **system Linux uses to organize and manage files on storage**.

I can think about it like this:

```text
Disk       = Cupboard
Filesystem = Organization system
Files      = Things stored inside
```

Some common Linux filesystems are:

```text
ext4
xfs
```

For my Cloud Support preparation, I don't need to memorize a huge list of filesystems right now.

The important thing is that the filesystem manages how files and directories are organized on storage.

---

# 🔎 4. `df` vs `du`

This is **very important** for interviews.

## `df`

```bash
df -h
```

It tells me:

> **How much space is available on the filesystem?**

---

## `du`

```bash
du -sh /var/log
```

It tells me:

> **How much space a particular directory is using.**

The easiest way I remember it:

```text
df → Disk filesystem
du → Directory usage
```

### Simple example

If my server is running out of space:

```bash
df -h
```

tells me:

> "The filesystem is almost full."

Then:

```bash
du -sh /var/log
```

can help me understand:

> "How much space is `/var/log` using?"

---

# 🧪 5. What if my Server is Running Out of Space?

Suppose I run:

```bash
df -h
```

and see:

```text
Use%
98%
```

🚨 That's very high.

Now I need to find what is consuming the space.

I can use:

```bash
du -sh /*
```

This can help me identify large directories.

I may see permission errors or virtual filesystems while doing this, so I shouldn't panic if every directory doesn't behave normally.

I can then investigate directories such as:

```text
/var
/home
/tmp
```

For example:

```bash
du -sh /var
du -sh /home
du -sh /tmp
```

---

# 🔥 6. The Important Interview Question

## ❓ "Disk space is available, but a file cannot be created. Why?"

At first, I might think:

> "If disk space is available, the file should definitely be created."

But that's **not always true**.

One important reason is:

# 🧩 INODES

---

# 🧠 7. What is an Inode?

I can think of an **inode as a file's information card**.

Linux needs more than just storage space for every file.

It also needs information such as:

* File type
* Permissions
* Owner
* Group
* Timestamps
* Information about where the file's data is stored

This information is associated with an **inode**.

So I can think:

```text
File
 ↓
Data + Metadata
       ↓
     Inode
```

The inode is filesystem metadata that helps Linux manage the file.

---

# 📦 8. Simple Inode Example

Imagine my disk has:

```text
💾 100 GB storage
```

And:

```text
95 GB free
```

That looks great.

But suppose the filesystem has:

```text
Available inodes = 0
```

Then creating a new file may fail even though I still have plenty of storage space.

So:

```text
Disk space → AVAILABLE ✅
Inodes     → EXHAUSTED ❌
```

Result:

> I may be unable to create new files.

🔥 This is an important Cloud Support troubleshooting concept.

---

# 🤯 9. Why Can Inodes Become Exhausted?

Imagine someone creates millions of tiny files:

```text
file1
file2
file3
file4
...
file1,000,000
```

Each file needs filesystem metadata/inode resources.

Eventually I can reach a situation like:

```text
Disk space → AVAILABLE ✅
Inodes     → EXHAUSTED ❌
```

So I may still have lots of GB available, but I can't create additional files.

This is why I should not look at only disk capacity.

I should also think about **inode usage**.

---

# 🔍 10. How do I Check Inode Usage?

I use:

```bash
df -i
```

Example:

```text
Filesystem      Inodes   IUsed   IFree IUse%
/dev/sda1       1.0M     1.0M       0  100%
```

Here:

```text
IUse% = 100%
```

🚨 This means the filesystem has exhausted its available inodes.

So even if:

```bash
df -h
```

shows plenty of free disk space, I can still have a file-creation problem.

---

# 🎯 11. My Troubleshooting Flow

Suppose a customer tells me:

> "I have free disk space, but I can't create a file."

I should **not immediately assume the disk is the problem**.

I should investigate step by step.

```text
Cannot create file
        ↓
Check disk space
        ↓
     df -h
        ↓
Space available?
        ↓
      YES
        ↓
Check inode usage
        ↓
     df -i
        ↓
Inodes exhausted?
        ↓
      YES
        ↓
Investigate/remove
unnecessary files
```

This gives me a structured troubleshooting approach.

---

# 🧠 12. Another Possible Reason — Permissions

Suppose:

```bash
df -h
```

shows plenty of space.

And:

```bash
df -i
```

also looks fine.

But I still cannot create a file.

Then I should ask:

> **Do I have permission to write to this directory?**

I can check the directory permissions using:

```bash
ls -ld /some/directory
```

For example:

```bash
ls -ld /tmp
```

Permissions can prevent a user from creating files even when the filesystem has enough space and inodes.

---

# 🎯 13. What Should I Check When File Creation Fails?

I should remember this:

```text
1️⃣ Disk space?
       ↓
   df -h

2️⃣ Inodes?
       ↓
   df -i

3️⃣ Permissions?
       ↓
   ls -ld directory

4️⃣ Other filesystem/system issue?
       ↓
   Investigate the specific error
```

I should **not assume one cause without checking the evidence**.

The exact error message can also give me an important clue.

---

# ☁️ 14. Cloud Support Example

Imagine I'm supporting a Linux server.

A customer says:

> "The application is running, but it cannot create new log files."

First, I check filesystem space:

```bash
df -h
```

Suppose I see:

```text
Use%
70%
```

So there is still free disk space.

Then I check:

```bash
df -i
```

Suppose I see:

```text
IUse%
100%
```

Now I have an important clue:

> The filesystem has exhausted its inodes.

The problem is **not simply lack of GBs**.

I would then investigate why there are so many files and follow the appropriate cleanup/remediation process.

---

# 🎤 15. Interview Questions

## ❓ What is `df -h`?

My answer:

> "`df -h` displays filesystem disk-space usage in a human-readable format."

---

## ❓ What is `du`?

My answer:

> "`du` shows how much disk space files or directories are using."

---

## ❓ What is an inode?

My answer:

> "An inode is a filesystem data structure that stores metadata about a file, such as its permissions, ownership, timestamps, and information needed to locate its data."

---

## ❓ How do you check inode usage?

I use:

```bash
df -i
```

---

## ❓ Disk has free space but a file cannot be created. What could be the reason?

My strong Cloud Support answer:

> "I would first check disk space using `df -h`. If space is available, I would check inode usage using `df -i`, because the filesystem may have exhausted its inodes. I would also check directory permissions using `ls -ld` and look at the exact error message."

🔥 This shows that I troubleshoot using **evidence instead of guessing**.

---

# 🧪 16. Practical — My Ubuntu Container

I can practice these commands in my Ubuntu container.

### Step 1 — Check disk space

```bash
df -h
```

---

### Step 2 — Check inode usage

```bash
df -i
```

---

### Step 3 — Check `/tmp` usage

```bash
du -sh /tmp
```

---

### Step 4 — Check `/tmp` permissions

```bash
ls -ld /tmp
```

---

### Step 5 — Investigate directories if disk usage is high

```bash
du -sh /*
```

Then I can investigate:

```bash
du -sh /var
du -sh /home
du -sh /tmp
```

---

# 🧠 17. Master Memory

I should remember the difference like this:

```text
                 💾 STORAGE
                     │
             ┌───────┴───────┐
             │               │
        Disk Space         Inodes
             │               │
          df -h            df -i
             │               │
       How much space?   How many inode
                         resources?
```

And:

```text
df → Filesystem space
du → Directory/file usage
df -i → Inode usage
```

---

# 🔥 18. The Main Interview Scenario

I should be able to think like this:

```text
Customer:
"File cannot be created."

             ↓

        df -h
             ↓
   Is disk space available?
             ↓
            YES
             ↓
        df -i
             ↓
   Are inodes exhausted?
        ↙           ↘
      YES            NO
       ↓              ↓
 Investigate       Check
 inode usage       permissions
                      ↓
                 ls -ld
                      ↓
              Check exact error
```

This is the mindset I need as a **Cloud Support Engineer**.

---

# 🧠 19. What I Should Remember for the Interview

### Disk

> Disk provides storage capacity for the operating system, applications, files and logs.

### Filesystem

> A filesystem organizes and manages files on storage.

### `df -h`

> Shows filesystem disk-space usage in human-readable form.

### `du`

> Shows how much disk space files/directories are using.

### Inode

> Stores filesystem metadata about a file.

### `df -i`

> Shows inode usage.

### Important scenario

> Free disk space does **not always mean** that new files can be created.

I should also check:

```text
Inodes
Permissions
Exact error message
Other filesystem/system issues
```

---

# 🚀 QUICK COMMAND MEMORY

| Command           | What I use it for                  |
| ----------------- | ---------------------------------- |
| `df -h`           | Check filesystem disk space        |
| `df -i`           | Check inode usage                  |
| `du -sh /var/log` | Check directory usage              |
| `du -sh /*`       | Find potentially large directories |
| `ls -ld /tmp`     | Check directory permissions        |

---

# 🎯 DAY 6 CHECKLIST

Before moving to Day 7, I should be comfortable with:

* [ ] What disk space means
* [ ] What a filesystem is
* [ ] `df`
* [ ] `df -h`
* [ ] `du`
* [ ] Difference between `df` and `du`
* [ ] What an inode is
* [ ] Why inodes can become exhausted
* [ ] `df -i`
* [ ] Why files may fail to create even with free disk space
* [ ] Checking directory permissions
* [ ] `ls -ld`
* [ ] Using the exact error message as evidence
* [ ] Disk troubleshooting flow
* [ ] Cloud Support scenario
* [ ] Interview-ready answers
* [ ] Practical commands in my Ubuntu container

---

# 🏆 DAY 6 = COMPLETE ✅

Today I learned an important Cloud Support lesson:

> **I should never look only at disk space.**

If a file cannot be created, I should think:

```text
💾 Disk Space
      ↓
🧩 Inodes
      ↓
🔐 Permissions
      ↓
🔎 Exact Error
      ↓
🛠️ Investigate the actual cause
```

My goal is not to randomly run commands.

My goal is:

> **Understand the symptom → collect evidence → identify the bottleneck → troubleshoot the actual cause.** 🔥
