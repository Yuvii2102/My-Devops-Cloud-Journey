# 🔐 OS DAY 7 — LINUX FILE PERMISSIONS

Bro, **Day 6 is complete ✅**

Today I’m learning about **Linux File Permissions**, which is one of the direct interview topics from my sheet.

By the end of Day 7, I should understand:

* `r`, `w`, `x`
* User, Group, Others
* `ls -l`
* `chmod`
* `chown`
* `chgrp`
* Practical permission troubleshooting
* Interview questions

---

# 🧠 1. Why Do I Need Permissions?

Imagine I have a file:

```text
salary.txt
```

I don't want every person on the server to modify it.

Linux therefore needs to answer:

> **Who is allowed to read, modify, or execute this file?**

That's what **file permissions** control.

---

# 👥 2. Linux Has 3 Permission Categories

Every file or directory has permissions for:

```text
USER
GROUP
OTHERS
```

I can think about this like a classroom:

```text
👨‍🎓 User   → the owner
👨‍👩‍👧 Group  → people in the same group
👥 Others  → everyone else
```

So Linux separates users into these three permission categories.

---

# 🔥 3. Three Basic Permissions

Linux uses:

```text
r = read
w = write
x = execute
```

## 📖 Read — `r`

Read means I can **look at the contents** of a file.

For example:

```bash
cat file.txt
```

---

## ✏️ Write — `w`

Write means I can **modify the contents** of the file.

For example:

```bash
echo "hello" > file.txt
```

---

## ▶️ Execute — `x`

Execute means I can **execute/run** the file when it is an executable or script and the other required conditions allow it.

Example:

```bash
./script.sh
```

---

# 🧩 4. Understanding `ls -l`

I can create a file:

```bash
touch test.txt
```

Then check its permissions:

```bash
ls -l test.txt
```

I may see something like:

```text
-rw-r--r-- 1 root root 0 Sep 16 12:00 test.txt
```

The important part is:

```text
-rw-r--r--
```

I break it down like this:

```text
- rw- r-- r--
  │   │   │
  │   │   └── Others
  │   └────── Group
  └────────── User
```

Therefore:

```text
User   → rw-
Group  → r--
Others → r--
```

---

# 🎯 5. What Does the First `-` Mean?

The very first character tells me the **file type**.

```text
-    regular file
d    directory
l    symbolic link
```

For example:

```text
-rw-r--r--
```

starts with:

```text
-
```

So it is a **regular file**.

A directory might look like:

```text
drwxr-xr-x
```

The `d` tells me it is a directory.

---

# 🧠 6. How Do I Decode Permissions?

Suppose I see:

```text
-rwxr-xr--
```

I break it down:

```text
- rwx r-x r--
  │   │   │
  │   │   └── Others
  │   └────── Group
  └────────── User
```

Therefore:

## 👤 User

```text
rwx
```

Can:

```text
read    ✅
write   ✅
execute ✅
```

---

## 👥 Group

```text
r-x
```

Can:

```text
read    ✅
write   ❌
execute ✅
```

---

## 👥 Others

```text
r--
```

Can:

```text
read    ✅
write   ❌
execute ❌
```

---

# 🔢 7. Numeric Permissions

This is extremely important for `chmod`.

I remember:

```text
r = 4
w = 2
x = 1
```

Then I add them.

### `rwx`

```text
4 + 2 + 1 = 7
```

### `rw-`

```text
4 + 2 = 6
```

### `r-x`

```text
4 + 1 = 5
```

### `r--`

```text
4 = 4
```

So I remember:

```text
rwx = 7
rw- = 6
r-x = 5
r-- = 4
```

---

# 🔥 8. What Does `755` Mean?

Suppose I run:

```bash
chmod 755 script.sh
```

I break `755` into three parts:

```text
755
│││
││└── Others = 5 = r-x
│└─── Group  = 5 = r-x
└──── User   = 7 = rwx
```

Therefore:

```text
User   → rwx
Group  → r-x
Others → r-x
```

So `755` means:

> Owner can read, write and execute. Group and others can read and execute.

---

# 🔥 9. What Does `644` Mean?

If I run:

```bash
chmod 644 file.txt
```

It means:

```text
User   → 6 = rw-
Group  → 4 = r--
Others → 4 = r--
```

So the final permissions are:

```text
rw-r--r--
```

This is a very common permission pattern for ordinary files.

---

# 🛠️ 10. What is `chmod`?

`chmod` means:

> **Change mode**

I use it to change file or directory permissions.

Example:

```bash
chmod 755 script.sh
```

Now:

```text
Owner  → read + write + execute
Group  → read + execute
Others → read + execute
```

So:

```text
chmod → change permissions
```

---

# 🧪 11. PRACTICAL — Changing Permissions

First, I create a file:

```bash
touch test.txt
```

Then I check it:

```bash
ls -l test.txt
```

Now I set the permission to `600`:

```bash
chmod 600 test.txt
```

Check again:

```bash
ls -l test.txt
```

I should see something similar to:

```text
-rw-------
```

That means:

```text
User   → rw-
Group  → ---
Others → ---
```

So only the owner has read and write permissions.

---

# 🧠 12. What is `chown`?

`chown` means:

> **Change owner**

Suppose:

```text
test.txt
```

belongs to:

```text
root
```

and I want another user to own it.

The general form is:

```bash
chown username filename
```

For example:

```bash
chown developer test.txt
```

Then I can verify it using:

```bash
ls -l test.txt
```

---

# 👥 13. What is `chgrp`?

`chgrp` means:

> **Change group**

The general form is:

```bash
chgrp groupname filename
```

For example:

```bash
chgrp developers test.txt
```

Now the file's group ownership changes.

---

# 🎯 14. `chmod` vs `chown` vs `chgrp`

I remember them like this:

```text
chmod  → permissions
chown  → owner
chgrp  → group
```

### My memory trick:

> **Who owns it? → `chown`**

> **Which group? → `chgrp`**

> **What can they do? → `chmod`**

🔥 I should remember this for interviews.

---

# 🚨 15. Cloud Support Scenario

Suppose a customer tells me:

> **"My application cannot write to this file."**

I should **not immediately change the permissions**.

First, I inspect the file:

```bash
ls -l file.txt
```

Then I ask:

```text
Who owns the file?
Which group owns the file?
What permissions are configured?
Which user is running the application?
```

I can check running processes using:

```bash
ps aux
```

Suppose I find:

```text
-rw-r--r-- root root file.txt
```

But the application is running as:

```text
developer
```

The application may not have permission to write to that file.

Now I have a direction to investigate.

---

# ⚠️ 16. Why Shouldn't I Blindly Use `chmod 777`?

I may see beginners doing:

```bash
chmod 777 file.txt
```

This gives:

```text
User   → rwx
Group  → rwx
Others → rwx
```

In other words, everyone gets read, write and execute permissions.

🚨 I should **not use this as a random fix**.

In a real server environment, I should set permissions according to the application's actual requirements.

The goal is not:

> "Make everything work."

The goal is:

> **Give only the permissions that are actually required.**

---

# 🎤 17. Interview Questions

## ❓ What are Linux file permissions?

My answer:

> "Linux file permissions control what the owner, group, and other users can do with a file or directory."

---

## ❓ What are `r`, `w`, and `x`?

My answer:

> "`r` means read, `w` means write, and `x` means execute."

---

## ❓ What does `755` mean?

My answer:

> "The owner has read, write and execute permissions, while the group and others have read and execute permissions."

---

## ❓ What does `644` mean?

My answer:

> "The owner has read and write permissions, while the group and others have read-only permission."

---

## ❓ What is `chmod`?

My answer:

> "`chmod` is used to change file or directory permissions."

---

## ❓ What is `chown`?

My answer:

> "`chown` is used to change the owner of a file or directory."

---

## ❓ What is `chgrp`?

My answer:

> "`chgrp` is used to change the group ownership of a file or directory."

---

# 🧠 18. FINAL MEMORY TRICK

I can visualize permissions like this:

```text
        FILE
         │
   ┌─────┼─────┐
   ↓     ↓     ↓
 USER  GROUP  OTHERS
   │     │     │
  rwx   rwx   rwx
```

And the numeric values:

```text
r = 4
w = 2
x = 1
```

Therefore:

```text
rwx = 7
rw- = 6
r-x = 5
r-- = 4
```

My main commands are:

```text
ls -l  → see permissions
chmod  → change permissions
chown  → change owner
chgrp  → change group
```

---

# ☁️ 19. My Cloud Support Troubleshooting Mindset

If an application cannot write to a file, I should think:

```text
Application cannot write
          ↓
     Check the file
          ↓
      ls -l file
          ↓
   Who owns the file?
          ↓
    Which group?
          ↓
   What permissions?
          ↓
Which user runs the application?
          ↓
      ps aux
          ↓
   Does that user have
   the required access?
```

I should **not blindly run `chmod 777`**.

I should first understand the actual problem.

---

# 🚀 QUICK COMMAND MEMORY

| Command  | What I use it for                  |
| -------- | ---------------------------------- |
| `ls -l`  | Check permissions, owner and group |
| `chmod`  | Change permissions                 |
| `chown`  | Change owner                       |
| `chgrp`  | Change group                       |
| `ps aux` | Check running processes/users      |

---

# 🎯 DAY 7 CHECKLIST

Before moving to Day 8, I should be comfortable with:

* [ ] Why Linux needs permissions
* [ ] User
* [ ] Group
* [ ] Others
* [ ] `r`
* [ ] `w`
* [ ] `x`
* [ ] `ls -l`
* [ ] File type characters
* [ ] Regular file `-`
* [ ] Directory `d`
* [ ] Symbolic link `l`
* [ ] How to decode `rwxr-xr--`
* [ ] Numeric permissions
* [ ] `r = 4`
* [ ] `w = 2`
* [ ] `x = 1`
* [ ] Meaning of `755`
* [ ] Meaning of `644`
* [ ] `chmod`
* [ ] `chown`
* [ ] `chgrp`
* [ ] Permission troubleshooting
* [ ] Application-user troubleshooting
* [ ] Why I shouldn't blindly use `chmod 777`
* [ ] Cloud Support scenario
* [ ] Interview-ready answers
* [ ] Practical commands

---

# 🏆 DAY 7 = COMPLETE ✅

Today I learned that Linux permissions answer three important questions:

```text
WHO?
 ↓
User / Group / Others

WHAT CAN THEY DO?
 ↓
Read / Write / Execute

HOW DO I CHANGE IT?
 ↓
chmod / chown / chgrp
```

My most important memory is:

```text
ls -l  → See
chmod  → Permission
chown  → Owner
chgrp  → Group
```

And as a Cloud Support Engineer, I should always:

> **Check the owner → check the group → check the permissions → check which user is running the application → then troubleshoot.** 🔥
