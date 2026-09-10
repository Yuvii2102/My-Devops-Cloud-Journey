# 🐧 Linux File Permissions

The main idea is very simple:

> **Linux uses file permissions to control who can read, modify, or execute files and directories.**

This is important because a Linux server can have **many users**, and we don't want every user to access or modify everything.

---

# 1. Three Types of Permissions

Linux has three basic permissions:

| Permission | Symbol | Meaning                 |
| ---------- | ------ | ----------------------- |
| Read       | `r`    | View/read the file      |
| Write      | `w`    | Modify the file         |
| Execute    | `x`    | Execute the file/script |

For example:

```text
rwx
```

means:

**Read + Write + Execute**

---

# 2. Permissions Apply to 3 Categories

Every file or directory has permissions for:

```text
User       Group       Others
  ↓          ↓            ↓
 rwx        rwx          rwx
```

### User (`u`)

The **owner** of the file.

### Group (`g`)

The group that owns the file.

### Others (`o`)

Everyone else.

For example:

```text
-rwxr-x---
```

I can break it down like this:

```text
- | rwx | r-x | ---
  |     |     |
  |     |     └── Others
  |     └──────── Group
  └────────────── User
```

So:

```text
User   → rwx
Group  → r-x
Others → ---
```

The user has read, write and execute permissions.

The group has read and execute permissions.

Others have no permissions.

---

# 3. How to Check Permissions

I can use:

```bash
ls -l
```

Example:

```text
-rwxr-xr--  developer  dev  script.sh
```

The important part is:

```text
-rwxr-xr--
```

The first character tells me the type:

```text
- → regular file
d → directory
```

The next 9 characters are the permissions:

```text
rwx r-x r--
│   │   │
│   │   └── Others
│   └────── Group
└────────── User
```

---

# 4. `chmod` — Change Permissions

`chmod` is one of the **most important commands** for file permissions.

Syntax:

```bash
chmod <permissions> <file>
```

Example:

```bash
chmod 777 script.sh
```

`chmod` is used when I want to change what the user, group, or others are allowed to do with a file or directory.

---

# 5. Numeric Permissions

I need to remember these values:

```text
r = 4
w = 2
x = 1
```

I add them together to get the permission number.

| Permission | Number |
| ---------- | -----: |
| `---`      |      0 |
| `--x`      |      1 |
| `-w-`      |      2 |
| `-wx`      |      3 |
| `r--`      |      4 |
| `r-x`      |      5 |
| `rw-`      |      6 |
| `rwx`      |      7 |

For example:

```text
rwx = 4 + 2 + 1 = 7

rw- = 4 + 2 = 6

r-x = 4 + 1 = 5

r-- = 4
```

So when I see something like:

```text
755
```

I know it represents permissions for:

```text
User | Group | Others
  7      5       5
```

---

# 6. Understanding `chmod 755`

This is extremely common in DevOps.

```bash
chmod 755 script.sh
```

It means:

```text
User    → 7 → rwx
Group   → 5 → r-x
Others  → 5 → r-x
```

So the final permission becomes:

```text
rwxr-xr-x
```

The owner can:

```text
Read + Write + Execute
```

The group can:

```text
Read + Execute
```

Others can:

```text
Read + Execute
```

But group and others **cannot modify** the file.

---

# 7. Common Permissions I Should Recognize

## `644`

```bash
chmod 644 file.txt
```

Means:

```text
User    → rw-
Group   → r--
Others  → r--
```

This is very common for normal files.

---

## `755`

```bash
chmod 755 script.sh
```

Means:

```text
User    → rwx
Group   → r-x
Others  → r-x
```

This is common for executable scripts/programs.

---

## `700`

```bash
chmod 700 private.sh
```

Means:

```text
User    → rwx
Group   → ---
Others  → ---
```

Only the owner has access.

---

## `400`

```bash
chmod 400 file
```

Means:

```text
User    → r--
Group   → ---
Others  → ---
```

The owner can only read.

---

## `777`

```bash
chmod 777 file
```

Means:

```text
User    → rwx
Group   → rwx
Others  → rwx
```

Everyone has full access.

⚠️ As a DevOps engineer, I need to be careful with `777`.

I should **not use `777` casually**, especially on production systems.

---

# 8. `chmod` Using Letters

I can also change permissions using letters.

```text
u = user
g = group
o = others
```

For example:

```bash
chmod u+x script.sh
```

This adds execute permission for the owner.

Another example:

```bash
chmod o-r file.txt
```

This removes read permission from others.

I don't need to memorize every combination immediately.

For now, I should first understand **numeric `chmod`** properly.

---

# 9. `chown` — Change Ownership

`chmod` and `chown` are different.

### `chmod`

Changes:

> **What can the owner/group/others do?**

### `chown`

Changes:

> **Who owns the file?**

Example:

```bash
chown qe:qe test.sh
```

This changes:

```text
Owner → qe
Group → qe
```

I will commonly come across `chown` when working with:

* Docker containers
* Kubernetes
* Application directories
* Web servers
* Deployment scripts
* Linux services

---

# 10. VERY IMPORTANT — Directory Permissions

This is an important concept.

Suppose I have:

```text
/tmp/
   └── demo.txt
```

Even if I run:

```bash
chmod 777 /tmp/demo.txt
```

the user **still cannot access `demo.txt`** if they don't have the required permission to access `/tmp`.

I can understand this using the **bank and locker example**.

```text
BANK
  ↓
LOCKER
```

I need permission to **enter the bank** before I can access the locker.

Similarly:

```text
Directory
    ↓
   File
```

I need the necessary directory access before I can reach the file.

### Interview-level rule

> **To access a file, the user must have the necessary permissions on every directory in the path, as well as the required permissions on the file itself.**

This is very important when troubleshooting permissions in real DevOps work.

---

# 11. Commands I Should Practice

I should practice these until they become comfortable.

### Check permissions

```bash
ls -l
```

### Change permissions

```bash
chmod 755 script.sh
```

```bash
chmod 644 file.txt
```

```bash
chmod 700 private.sh
```

```bash
chmod 777 file
```

### Change ownership

```bash
chown user:group file
```

### Check current user

```bash
whoami
```

`whoami` tells me which user I am currently logged in as.

---

# 12. The Whole Topic in One Picture

```text
                 Linux File Permissions
                         │
             ┌───────────┴───────────┐
             │                       │
        Permissions              Ownership
             │                       │
          chmod                    chown
             │
       ┌─────┼─────┐
       │     │     │
      User  Group Others
       │     │     │
      rwx   rwx   rwx
       │     │     │
       └─────┴─────┘
             │
       r = 4
       w = 2
       x = 1
```

---

# 🎯 What I Need to Remember for Cloud/DevOps

I should remember these **6 main things**:

### 1. Permissions

```text
r = read
w = write
x = execute
```

### 2. Permission categories

```text
User
Group
Others

→ ugo
```

### 3. Check permissions

```bash
ls -l
```

### 4. Change permissions

```bash
chmod
```

### 5. Change ownership

```bash
chown
```

### 6. Directory permissions matter

Having permission on the file alone **doesn't guarantee that I can access it**.

I need the necessary permissions on the directories in the path as well.

---

# 🧠 Simple Mental Model

```text
                 FILE
                  │
        ┌─────────┴─────────┐
        │                   │
   Ownership           Permissions
        │                   │
      chown               chmod
                            │
                    ┌───────┼───────┐
                    │       │       │
                   User   Group   Others
                    │       │       │
                   rwx     rwx     rwx
```

So the simple way I remember it is:

```text
chown → Who owns it?

chmod → What can they do?

ls -l → What are the current permissions?

Directory permissions → Can I actually reach the file?
```
