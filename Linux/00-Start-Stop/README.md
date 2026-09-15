<div align="center">

# 🐳 LINUX PRACTICE USING DOCKER + UBUNTU

</div>

> **Goal:** Use Docker to run an Ubuntu container and practice Linux commands inside it.

---

# 🆕 1. First-Time Setup

## Step 1 — Open Docker Desktop

Open **Docker Desktop**.

Wait until you see:

```text
🟢 Engine running
```

This means Docker is ready to use.

---

## Step 2 — Open CMD

Press:

**Windows key → type `cmd` → Enter**

You should see something like:

```text
C:\Users\Yuvraj>
```

---

## Step 3 — Check Existing Containers

Run:

```bash
docker ps -a
```

If this is my first time using Docker, I may see:

```text
CONTAINER ID   IMAGE   COMMAND   CREATED   STATUS   PORTS   NAMES
```

with nothing underneath.

That's completely fine.

It simply means:

> **No containers have been created yet.**

---

# 🐧 2. Create the Ubuntu Container

If I don't have an Ubuntu container yet, I run:

```bash
docker run -it --name my-ubuntu ubuntu
```

### What this command does

It:

1. Downloads the Ubuntu image if it isn't already available.
2. Creates a new container named `my-ubuntu`.
3. Starts the container.
4. Opens an interactive Ubuntu terminal.

After it starts, I should see something like:

```text
root@abc123:/#
```

🎉 **Now I am inside Ubuntu Linux.**

---

# 🧪 3. Test Linux

Once I see:

```text
root@abc123:/#
```

I can start executing Linux commands.

---

## 👤 Check the Current User

Run:

```bash
whoami
```

Expected output:

```text
root
```

This means:

> **I am currently logged in as the `root` user.**

---

## 📍 Check the Current Directory

Run:

```bash
pwd
```

Expected output:

```text
/
```

This means:

> **I am currently at the root `/` directory of the Linux filesystem.**

---

## 📂 List Files and Directories

Run:

```bash
ls
```

I may see directories such as:

```text
bin
dev
etc
home
lib
root
tmp
usr
var
```

This shows the contents of my current directory.

---

# 🔄 4. What Happens When I Exit?

When I'm finished practicing Linux, I can run:

```bash
exit
```

This takes me out of the Ubuntu container and returns me to Windows CMD:

```text
C:\Users\Yuvraj>
```

### Important

The container still exists.

I **do not need to create a new container every time**.

---

# 🐳 5. Daily Linux Practice Process

After the first-time setup, I can use the same container every day.

---

## Step 1 — Open Docker Desktop

Open **Docker Desktop**.

Wait until it says:

```text
🟢 Engine running
```

---

## Step 2 — Open CMD

Open **Command Prompt**.

I should see:

```text
C:\Users\Yuvraj>
```

---

## Step 3 — Check My Ubuntu Container

Run:

```bash
docker ps -a
```

I should look for my Ubuntu container.

For example:

```text
CONTAINER ID   IMAGE     STATUS    NAMES
5310cfb59118   ubuntu    Exited    my-ubuntu
```

The container ID can be different on my computer.

The important part is:

```text
my-ubuntu
```

---

## Step 4 — Start My Existing Ubuntu Container

Since I already created the container, I use:

```bash
docker start -ai my-ubuntu
```

Or I can use the container ID:

```bash
docker start -ai <container-id>
```

For example:

```bash
docker start -ai 5310cfb59118
```

After starting it, I should see something like:

```text
root@5310cfb59118:/#
```

🎉 **Now I'm inside Ubuntu again.**

I can start practicing Linux commands.

---

# 🐧 6. Execute Linux Commands

Once I see:

```text
root@...:/#
```

I can execute Linux commands.

For example:

```bash
pwd
ls
cd /home
mkdir test
```

I'll learn and practice these commands step by step.

---

# 🛑 7. Finish My Practice

When I'm finished, run:

```bash
exit
```

I'll return to:

```text
C:\Users\Yuvraj>
```

The container is still available for my next practice session.

---

# ⚠️ 8. Important Docker Commands

There are three commands I need to clearly understand.

---

## 🆕 `docker run`

```bash
docker run -it --name my-ubuntu ubuntu
```

Means:

> **Create a NEW container and start it.**

I normally use this when creating the container for the first time.

### Think:

```text
docker run
     ↓
NEW container
     ↓
START
```

---

## ▶️ `docker start`

```bash
docker start -ai my-ubuntu
```

Means:

> **Start an EXISTING container.**

I use this when I want to practice Linux again using the container I already created.

### Think:

```text
docker start
      ↓
Existing container
      ↓
START
```

---

## 🚪 `exit`

```bash
exit
```

Means:

> **Leave the Ubuntu container and return to Windows CMD.**

### Think:

```text
Ubuntu Container
      ↓
    exit
      ↓
Windows CMD
```

---

# ⭐ 9. My Daily Flow

This is the complete process I should remember:

```text
Docker Desktop
      ↓
Wait for "Engine running"
      ↓
Open CMD
      ↓
docker ps -a
      ↓
docker start -ai my-ubuntu
      ↓
root@...:/#
      ↓
🐧 Execute Linux commands
      ↓
exit
      ↓
C:\Users\Yuvraj>
```

---

# 🧠 10. Easy Reminder

```text
docker run   → Create a NEW container
docker start → Start an EXISTING container
exit         → Leave the container
```

### First time

```bash
docker run -it --name my-ubuntu ubuntu
```

### Every next time

```bash
docker start -ai my-ubuntu
```

### Finished

```bash
exit
```

---

# 🔥 My Final Understanding

I can think about the whole process like this:

```text
                 DOCKER DESKTOP
                       ↓
                    DOCKER
                       ↓
                Ubuntu Container
                       ↓
                 Linux Terminal
                       ↓
              Practice Linux Commands
```

The important thing is:

> **I create the Ubuntu container once with `docker run`. After that, I reuse the same container with `docker start`. When I'm done, I use `exit`.**

So my daily workflow is simply:

```text
FIRST TIME:
docker run
    ↓
Create + Start Container

NEXT TIME:
docker start
    ↓
Start Existing Container

FINISHED:
exit
    ↓
Return to Windows CMD
```
