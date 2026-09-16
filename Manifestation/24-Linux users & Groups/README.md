# 👤 OS DAY 8 — LINUX USERS & GROUPS

Bro, **Day 7 is complete ✅**

Today I’m learning about **Linux Users & Groups**, which is important for my OS and Cloud Support preparation.

The big idea I need to remember is:

> **Linux uses users + groups + permissions to control access to the system.**

This connects directly with what I learned on **Day 7 — File Permissions**.

---

# 🧠 1. What is a User?

A **user** is an account that can log in and interact with Linux.

Some examples are:

```text
root
developer
ubuntu
```

Each user can have:

* Username
* User ID (UID)
* Group membership
* Home directory
* Login shell

I can think about a company:

```text
👨‍💻 Yuva
👨‍💻 Developer
👨‍💻 Admin
```

Each person has their own account and permissions.

So:

> **User = an account used to access and operate the Linux system.**

---

# 👑 2. What is `root`?

`root` is the Linux **superuser**.

It has very high privileges and can perform administrative operations.

For example, root can generally:

```text
create users
delete users
install software
change permissions
manage services
```

That's why I often see:

```text
root@server:~#
```

when practicing inside my Ubuntu container.

I should remember:

> **root = Linux's superuser / administrative account.**

---

# 👥 3. What is a Group?

A **group** is a collection of users.

I can imagine:

```text
Group: developers

        developers
       /    |     \
    Yuva  Ravi   Arun
```

Instead of giving permissions individually to every user, I can give permissions to a group.

This becomes very useful on servers.

For example:

```text
developers
   ↓
Yuva
Ravi
Arun
```

All three users can get access through the group.

---

# 🔥 4. User vs Group

The easiest way I remember it:

```text
User  → one account
Group → collection of users
```

Example:

```text
Users:
Yuva
Ravi
Arun

Group:
developers
```

All three users can belong to:

```text
developers
```

This connects directly to Day 7:

```text
USER
GROUP
OTHERS
```

---

# 🔎 5. How Do I See the Current User?

I use:

```bash
whoami
```

Example:

```text
root
```

This tells me:

> **Which user am I currently operating as?**

This is one of the first commands I should run when I need to understand my current identity.

---

# 🆔 6. What is `id`?

I can run:

```bash
id
```

Example:

```text
uid=0(root) gid=0(root) groups=0(root)
```

It shows information such as:

```text
UID    → User ID
GID    → Primary Group ID
groups → Groups the user belongs to
```

I can also check a specific user:

```bash
id developer
```

This helps me understand the user's identity and group memberships.

---

# 🔥 7. What is `groups`?

I use:

```bash
groups
```

This tells me which groups the **current user** belongs to.

I can also check another user:

```bash
groups developer
```

So:

```text
groups
   ↓
Shows group membership
```

---

# 👤 8. Creating a User

The command I use is:

```bash
useradd
```

For example:

```bash
useradd developer
```

This creates the user.

However, for a normal user, it is often useful to create the home directory at the same time:

```bash
useradd -m developer
```

Here:

```text
-m
 ↓
Create the user's home directory
```

For example:

```text
/home/developer
```

So I remember:

```bash
useradd -m developer
```

> Create a user and create their home directory.

---

# 🔐 9. Setting a Password

After creating the user, I can set a password:

```bash
passwd developer
```

Linux will ask me to enter the password.

So my basic flow is:

```bash
useradd -m developer
passwd developer
```

I can think:

```text
useradd → Create user
passwd  → Set password
```

---

# 👀 10. How Do I Check the User?

After creating the user, I can check:

```bash
id developer
```

and:

```bash
groups developer
```

I can also check the home directory:

```bash
ls -ld /home/developer
```

This helps me verify that the account and its home directory exist.

---

# 🏠 11. What is a Home Directory?

Every normal user generally has a home directory.

For example:

```text
/home/developer
```

This is the user's personal area.

I can visualize it like:

```text
/home
   │
   ├── developer
   ├── ubuntu
   └── yuvi
```

So:

> **Home directory = the user's personal working area in the filesystem.**

---

# 👥 12. Creating a Group

I use:

```bash
groupadd
```

Example:

```bash
groupadd developers
```

Now I have a group called:

```text
developers
```

I can later add users to this group.

---

# ➕ 13. Adding a User to a Group

A common command is:

```bash
usermod -aG developers developer
```

I can break it down:

```text
usermod → modify user
-a      → append
-G      → supplementary group
```

So:

> Add `developer` to the `developers` group without removing existing supplementary group memberships.

Then I can check:

```bash
groups developer
```

I should see the group listed.

---

# 🔥 14. Why Are Groups Useful?

Imagine I have:

```text
developers
```

with:

```text
Yuva
Ravi
Arun
```

And I have a project directory:

```text
/project
```

I can configure ownership and permissions around the group instead of managing every developer separately.

This connects directly to Day 7:

```text
USER
GROUP
OTHERS
```

I should remember:

```text
User permissions   → owner
Group permissions   → group members
Others permissions → everyone else
```

So Day 7 and Day 8 work together:

```text
Users + Groups
      ↓
File Ownership
      ↓
File Permissions
      ↓
Access Control
```

---

# 🗑️ 15. Deleting a User

I use:

```bash
userdel developer
```

If I also want to remove the user's home directory:

```bash
userdel -r developer
```

I need to be careful with:

```text
-r
```

because it removes the user's home directory and its contents.

So:

```text
userdel       → Delete user
userdel -r    → Delete user + home directory
```

---

# 🔄 16. Switching Users

I learned this while practicing Linux.

I can use:

```bash
su - developer
```

This means:

> Switch to the `developer` user with their login environment.

I may be asked for the user's password.

To return to the previous shell:

```bash
exit
```

So:

```text
su - developer
      ↓
Switch to developer

exit
      ↓
Return to previous shell
```

---

# 🧠 17. My Previous Container Problem

I remember when I tried:

```bash
su - qe
```

and got:

```text
Authentication failure
```

That can happen for several reasons, including:

* Incorrect password
* Missing password
* Account configuration problems

I also previously encountered a situation where a user didn't have a proper home directory.

That's why this command is useful:

```bash
useradd -m developer
```

The `-m` option creates the user's home directory.

So when I create practice users, I should normally use:

```bash
useradd -m username
```

when I want a home directory created.

---

# 🎯 18. Important Linux Files

I don't need to memorize everything inside these files.

I just need to know what they represent.

---

## 📄 `/etc/passwd`

This contains information about local user accounts.

I can view it using:

```bash
cat /etc/passwd
```

I may see an entry similar to:

```text
developer:x:1000:1000:Developer:/home/developer:/bin/bash
```

Important fields include:

```text
username
UID
GID
home directory
login shell
```

So I remember:

```text
/etc/passwd
      ↓
Local user account information
```

---

# 👥 19. `/etc/group`

This contains information about groups.

I can view it using:

```bash
cat /etc/group
```

So:

```text
/etc/group
     ↓
Group information
```

---

# ⚠️ 20. What About Passwords?

I may notice something like:

```text
developer:x:1000...
```

inside `/etc/passwd`.

The `x` does **not** mean the password is literally stored there.

On modern Linux systems, password hashes are normally stored in:

```text
/etc/shadow
```

This file is protected and should not be casually modified.

So I remember:

```text
/etc/passwd → User account information
/etc/group  → Group information
/etc/shadow → Password hashes
```

---

# ☁️ 21. Cloud Support Scenario

Imagine a customer says:

> **"My application cannot access this directory."**

I should **not immediately run:**

```bash
chmod 777
```

Instead, I investigate step by step.

### Step 1 — Who is running the application?

I can check:

```bash
ps aux
```

Suppose I find the application is running as:

```text
appuser
```

---

### Step 2 — Check the directory

```bash
ls -ld /project
```

Now I can see:

* Owner
* Group
* Permissions

---

### Step 3 — Check the user's groups

```bash
id appuser
```

This tells me the user's:

```text
UID
GID
Groups
```

---

### Step 4 — Connect everything

Now I ask:

```text
Who owns the directory?
        ↓
Which group owns it?
        ↓
What permissions are configured?
        ↓
Which user is running the application?
        ↓
Is that user a member of the required group?
        ↓
Does the permission configuration allow access?
```

🔥 This connects **Day 7 + Day 8** together.

---

# 🎤 22. Interview Questions

## ❓ What is a user in Linux?

My answer:

> "A user is an account used to access and operate a Linux system. Each user has identifiers such as a UID and group memberships."

---

## ❓ What is a group?

My answer:

> "A group is a collection of users used to manage permissions and access more efficiently."

---

## ❓ What is root?

My answer:

> "Root is the Linux superuser with extensive administrative privileges."

---

## ❓ How do you create a user?

```bash
useradd -m username
```

My answer:

> "`useradd -m username` creates a user and creates the user's home directory."

---

## ❓ How do you set a user's password?

```bash
passwd username
```

---

## ❓ How do you create a group?

```bash
groupadd groupname
```

---

## ❓ How do you add a user to a group?

```bash
usermod -aG groupname username
```

---

## ❓ How do you check user information?

```bash
id username
```

---

## ❓ How do you check group membership?

```bash
groups username
```

---

## ❓ How do you switch users?

```bash
su - username
```

---

## ❓ Where is local user account information stored?

> `/etc/passwd`

---

## ❓ Where is group information stored?

> `/etc/group`

---

## ❓ Where are password hashes normally stored?

> `/etc/shadow`

---

# 🧪 23. PRACTICAL — My Ubuntu Container

Since I'm practicing as root, I can safely create a practice user.

---

### Step 1 — Create the user

```bash
useradd -m developer
```

If I get:

```text
user 'developer' already exists
```

that's okay.

It means I already created the user earlier.

---

### Step 2 — Set the password

```bash
passwd developer
```

---

### Step 3 — Check the user

```bash
id developer
```

---

### Step 4 — Create the group

```bash
groupadd developers
```

If it already exists, that's also okay.

---

### Step 5 — Add the user to the group

```bash
usermod -aG developers developer
```

---

### Step 6 — Verify

```bash
groups developer
```

I should see:

```text
developers
```

in the output.

---

### Step 7 — Switch to the user

```bash
su - developer
```

Then check:

```bash
whoami
```

I should get:

```text
developer
```

Then:

```bash
pwd
```

I should normally land in:

```text
/home/developer
```

Finally:

```bash
exit
```

I should return to my previous shell.

---

# 🧠 24. DAY 8 MASTER MEMORY

I should remember these commands:

```text
whoami
    ↓
Who am I?

id
    ↓
UID + GID + groups

groups
    ↓
Group membership

useradd
    ↓
Create user

passwd
    ↓
Set password

groupadd
    ↓
Create group

usermod -aG
    ↓
Add user to group

su -
    ↓
Switch user

userdel
    ↓
Delete user
```

And these important files:

```text
/etc/passwd
      ↓
Users

/etc/group
      ↓
Groups

/etc/shadow
      ↓
Password hashes
```

---

# 🔥 25. MY COMPLETE USERS + GROUPS FLOW

I can remember the whole concept like this:

```text
              LINUX
                │
        ┌───────┴───────┐
        ↓               ↓
      USERS           GROUPS
        │               │
        └───────┬───────┘
                ↓
           OWNERSHIP
                ↓
          PERMISSIONS
                ↓
        ACCESS CONTROL
```

For example:

```text
developer
    ↓
member of developers
    ↓
/project belongs to developers
    ↓
Group permissions allow access
    ↓
developer can access /project
```

---

# ☁️ 26. CLOUD SUPPORT MEMORY

If a customer says:

> **"My application cannot access this directory."**

I should think:

```text
Application cannot access directory
                ↓
       Who runs the application?
                ↓
             ps aux
                ↓
            appuser
                ↓
       Check directory
                ↓
         ls -ld /project
                ↓
     Check user information
                ↓
            id appuser
                ↓
       Check group membership
                ↓
       Check owner + group +
           permissions
                ↓
        Identify the actual
             cause
```

I should not blindly change permissions.

I should first understand:

> **Who is the user? Which groups does the user belong to? Who owns the resource? What permissions are configured?**

---

# 🎯 DAY 8 CHECKLIST

Before moving to Day 9, I should be comfortable with:

* [ ] What a Linux user is
* [ ] UID
* [ ] GID
* [ ] Group membership
* [ ] Root user
* [ ] What a group is
* [ ] User vs Group
* [ ] `whoami`
* [ ] `id`
* [ ] `groups`
* [ ] `useradd`
* [ ] `useradd -m`
* [ ] `passwd`
* [ ] Home directory
* [ ] `groupadd`
* [ ] `usermod -aG`
* [ ] `userdel`
* [ ] `userdel -r`
* [ ] `su -`
* [ ] `exit`
* [ ] `/etc/passwd`
* [ ] `/etc/group`
* [ ] `/etc/shadow`
* [ ] User/group troubleshooting
* [ ] Application-user troubleshooting
* [ ] Connecting users + groups + permissions
* [ ] Cloud Support scenario
* [ ] Interview-ready answers
* [ ] Practical commands

---

# 🏆 DAY 8 = COMPLETE ✅

Today I learned that:

```text
USER
  ↓
Who am I?

GROUP
  ↓
Who am I working with?

OWNERSHIP
  ↓
Who owns the resource?

PERMISSIONS
  ↓
What can they do?

ACCESS
  ↓
Can the application/user actually use it?
```

My most important memory is:

```text
whoami       → Current user
id           → User + groups information
groups       → Group membership
useradd      → Create user
passwd       → Set password
groupadd     → Create group
usermod -aG  → Add user to group
su -         → Switch user
userdel      → Delete user
```

And:

```text
/etc/passwd → Users
/etc/group  → Groups
/etc/shadow → Password hashes
```

As a Cloud Support Engineer, I should always connect:

> **Users → Groups → Ownership → Permissions → Access** 🔥
