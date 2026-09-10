# 🐧 Linux — User Management, File Management & Vim

## 1. User Management

### Why do we need User Management?

On a production Linux server, many people may need access, like:

* Developers
* QA engineers
* DevOps engineers
* Administrators

We should not give everyone the **root user**, because root has almost unrestricted permissions.

So Linux provides **user management**.

It helps with:

* **Security** → users get only the permissions they need.
* **Accountability** → actions can be associated with individual users.
* **Access control** → different users can access different files/directories.
* **Easy management** → users can be added, removed, locked, etc.

### Root vs Normal User

| User        | Meaning                                        |
| ----------- | ---------------------------------------------- |
| `root`      | Superuser with almost unrestricted permissions |
| Normal user | Limited permissions                            |

So basically:

```text
root
→ Almost unrestricted permissions

Normal User
→ Limited permissions
```

---

# 2. Important User Commands

## Create a user

The command is:

```bash
useradd username
```

Example:

```bash
useradd yuva
```

---

## Create user with interactive details + home directory

Another command is:

```bash
adduser username
```

Example:

```bash
adduser yuva
```

### Difference between `useradd` and `adduser`

```text
useradd
→ Simple / non-interactive
→ Useful in scripts and automation

adduser
→ Interactive
→ Creates home directory
→ Asks for user details
```

So I can remember it like:

```text
useradd → automation/scripts

adduser → manual/interactive user creation
```

---

## Set or change password

```bash
passwd username
```

Example:

```bash
passwd yuva
```

---

## Check users

Users are listed in:

```bash
cat /etc/passwd
```

`/etc/passwd` contains information about Linux users.

---

## Password information

Password hash information is stored in:

```bash
cat /etc/shadow
```

Passwords are stored as **hashes**, not plaintext.

So normally I cannot recover the original password from the hash.

If a user forgets the password, an administrator normally **resets** the password.

---

## Delete a user

```bash
userdel username
```

Example:

```bash
userdel yuva
```

---

## Switch user

```bash
su - username
```

Example:

```bash
su - yuva
```

---

## Check current user

```bash
whoami
```

This tells me which user I am currently logged in as.

---

## Run command with elevated privileges

```bash
sudo command
```

Example:

```bash
sudo apt install vim
```

Here `sudo` allows me to run the command with elevated privileges.

---

# 3. User Groups

Groups are useful when I want to manage permissions for **multiple users together**.

For example, instead of changing permissions for 100 developers individually, I can put them into a group and manage permissions at the group level.

```text
        DevOps Group
             │
       ┌─────┼─────┐
       │     │     │
       A     B     C
```

So the group contains multiple users.

---

## Create a group

```bash
groupadd devops
```

---

## View groups

```bash
cat /etc/group
```

---

## Add user to a group

```bash
usermod -aG devops yuva
```

The syntax is:

```bash
usermod -aG GROUP USER
```

I should remember the `-aG` part because it is important.

---

# 4. Account Lock / Unlock

Sometimes I may need to temporarily disable a user's account.

## Lock a user

```bash
passwd -l username
```

## Unlock a user

```bash
passwd -u username
```

---

# 5. Password Expiration

Linux can also enforce password-expiration policies.

For example, to force password expiration every 90 days:

```bash
chage -M 90 username
```

I don't need to memorize every `chage` option right now.

I just need to understand that **Linux can enforce password-expiration policies**.

---

# 6. Important User-Management Interview Questions

### Why should I not give everyone root access?

Because root has unrestricted privileges.

Giving everyone root access creates:

* Security risks
* Accountability problems

---

### `useradd` vs `adduser`?

```text
useradd
→ Simple
→ Useful for automation/scripts

adduser
→ Interactive
→ Easier for manual user creation
```

---

### Where are users stored?

```text
/etc/passwd
```

---

### Where is password hash information stored?

```text
/etc/shadow
```

---

### Can I decrypt a Linux user's password?

**No.**

Passwords are stored as hashes.

If a user forgets the password, normally I reset the password instead of recovering the old one.

---

# 7. File Management

These are commands I should be comfortable with **every day** as a Cloud/DevOps engineer.

I will constantly work with:

* Files
* Directories
* Configuration files
* Logs
* Deployment files

---

## List files

```bash
ls
```

For a detailed listing:

```bash
ls -l
```

---

## Check current directory

```bash
pwd
```

This shows where I currently am.

---

## Change directory

```bash
cd /tmp
```

---

## Go one directory back

```bash
cd ..
```

---

## Go to the root of the filesystem

```bash
cd /
```

---

## Create a directory

```bash
mkdir mydir
```

---

## Create an empty file

```bash
touch file.txt
```

---

## Delete a file

```bash
rm file.txt
```

---

## Delete a directory

```bash
rmdir mydir
```

If the directory contains files:

```bash
rm -rf mydir
```

⚠️ I need to be **extremely careful with `rm -rf`**, especially when I am working as root.

---

## Copy a file

```bash
cp source.txt destination.txt
```

---

## Move / Rename

```bash
mv old.txt new.txt
```

The same `mv` command is used for both:

```text
Moving
   +
Renaming
```

---

# 8. Reading Files

Reading files is very important in DevOps because I will constantly need to read:

* Application logs
* Configuration files
* Deployment files
* System files
* Error messages

---

## Print the entire file

```bash
cat file.txt
```

---

## Interactive file viewing

```bash
less file.txt
```

To quit:

```text
q
→ quit
```

---

## View first lines

```bash
head file.txt
```

For the first 10 lines:

```bash
head -10 file.txt
```

---

## View last lines

```bash
tail file.txt
```

For the last 20 lines:

```bash
tail -20 file.txt
```

---

## `tail -f` — Very important in DevOps

```bash
tail -f application.log
```

This continuously watches the log file as new lines are added.

This is very useful when I want to watch application logs in real time.

---

# 9. Writing to Files

## Print something

```bash
echo "Hello"
```

---

## Overwrite a file

```bash
echo "Hello" > file.txt
```

Here:

```text
> → overwrite
```

---

## Append to a file

```bash
echo "World" >> file.txt
```

Here:

```text
>> → append
```

So I remember:

```text
>   → overwrite

>>  → append
```

These are very important for shell scripting.

---

# 10. Vim Editor

As a Cloud/DevOps engineer, I should at least be comfortable editing configuration files on a remote Linux server.

To open or create a file:

```bash
vim file.txt
```

## Vim has three modes

```text
                Vim
                 │
        ┌────────┼─────────┐
        │        │         │
      Normal   Insert    Command
        │        │         │
    Navigate   Write    Save/Quit
```

---

## Normal Mode

This is the default mode.

It is mainly used for navigation and commands.

---

## Insert Mode

Press:

```text
i
```

Then I can type/write content.

---

## Command Mode

Press:

```text
Esc
:
```

Then I can use commands such as:

```text
:wq
```

Save and quit.

```text
:q!
```

Quit without saving.

---

# 11. Vim Shortcuts I Actually Need

I don't need to memorize 50 Vim shortcuts right now.

I will start with these:

| Shortcut | Purpose             |
| -------- | ------------------- |
| `i`      | Insert/write        |
| `Esc`    | Leave insert mode   |
| `:wq`    | Save + quit         |
| `:q!`    | Quit without saving |
| `:w`     | Save                |
| `gg`     | Go to beginning     |
| `G`      | Go to last line     |
| `:500`   | Go to line 500      |
| `/word`  | Search for word     |

For now, these are enough.

---

# 12. SSH — Important Connection

Now the whole point of learning users becomes clearer.

I normally connect to a remote Linux server using SSH:

```bash
ssh username@SERVER_IP
```

Example:

```bash
ssh yuva@172.31.87.187
```

Conceptually:

```text
Your Laptop
     │
     │ SSH
     ▼
Linux Server
     │
     └── User: yuva
```

The Linux server runs an SSH server process, commonly:

```text
sshd
```

My laptop uses an SSH client:

```text
ssh
```

So:

```text
Laptop
  │
  │ ssh
  ▼
Linux Server
  │
  │ sshd
  ▼
User: yuva
```

---

# 🎯 What I Should Actually Memorize

If I am preparing specifically for a **Cloud/DevOps job**, I should prioritize these.

## User Management

```bash
useradd
adduser
passwd
userdel
su -
whoami
sudo
```

## Groups

```bash
groupadd
usermod -aG
cat /etc/group
```

## Important Linux Files

```text
/etc/passwd
/etc/shadow
/etc/group
```

## File Management

```bash
ls
pwd
cd
mkdir
touch
rm
rm -rf
cp
mv
```

## File Reading

```bash
cat
less
head
tail
tail -f
```

## Writing

```bash
echo
>
>>
```

## Vim

```bash
vim
i
Esc
:wq
:q!
gg
G
:line_number
/word
```

## Remote Access

```bash
ssh username@IP
```

---

# 🧠 The Big Picture

I don't want to learn these as random commands.

I want to understand the overall workflow:

```text
Linux Server
     │
     ├── Users
     │     ├── Developer
     │     ├── QA
     │     └── DevOps
     │
     ├── Groups
     │     ├── developers
     │     ├── qa
     │     └── devops
     │
     ├── Files & Directories
     │     ├── create
     │     ├── copy
     │     ├── move
     │     ├── delete
     │     └── read/edit
     │
     └── SSH
           │
           └── Remote access
```

### My understanding should be:

```text
Users
  ↓
Groups
  ↓
Permissions / Access
  ↓
Files & Directories
  ↓
Read / Edit / Manage
  ↓
SSH
  ↓
Access the remote Linux server
```

So these commands are not separate random commands. They are all part of working with a Linux server as a Cloud/DevOps engineer.
