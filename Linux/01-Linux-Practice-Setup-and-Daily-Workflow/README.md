# Linux Practice — Windows + Docker + Ubuntu

## Goal

I want to set up a Linux practice environment on Windows using Docker Desktop and an Ubuntu container.

My goal is to practice Linux commands practically and understand what each command does.

---

## Setup Architecture

Windows
   ↓
Docker Desktop
   ↓
Docker Engine
   ↓
Ubuntu Container
   ↓
Linux Commands

---

# Part 1 — Initial Setup

## 1. Check Windows Version

Before setting everything up, I checked my Windows version.

My system:

- Windows 10
- Version: 22H2
- OS Build: 19045.6466

---

## 2. Initial WSL Setup

Docker Desktop uses WSL 2 on Windows, so I first tried to set up WSL.

### Check WSL Status

I ran:

    wsl --status

### Check Available Linux Distributions

I ran:

    wsl --list --online

This showed distributions such as:

    Ubuntu
    Debian
    kali-linux
    OracleLinux
    openSUSE

---

## 3. Try Installing Ubuntu Through WSL

I tried:

    wsl --install -d Ubuntu

The installation started, but eventually I got:

    Catastrophic failure

Because of this problem, I decided to use Docker Desktop with an Ubuntu container for my Linux practice.

---

## 4. Update WSL

I opened PowerShell as Administrator and ran:

    wsl --update

Eventually, I got:

    Checking for updates.
    The most recent version of Windows Subsystem for Linux is already installed.

This confirmed that WSL was updated.

---

# Part 2 — Docker Desktop Setup

## 5. Install Docker Desktop

I installed Docker Desktop for Windows.

My computer uses x64 architecture, so I selected:

    AMD64 / x64

I did not select ARM64 because my Windows PC uses x64 architecture.

---

## 6. Docker Desktop WSL Problem

After installing Docker Desktop, Docker initially showed:

    WSL needs updating

I updated WSL using:

    wsl --update

After updating WSL, Docker Desktop showed:

    Docker Desktop - WSL is unresponsive

I restarted Windows.

After restarting Windows and opening Docker Desktop again, Docker successfully started.

Docker Desktop showed:

    Engine running

This confirmed that the Docker Engine was running correctly.

---

# Part 3 — Verify Docker

## 7. Open Windows CMD

I opened Command Prompt (CMD).

The prompt looked like:

    C:\Users\Yuvraj>

---

## 8. Check Docker Version

I ran:

    docker --version

My output was:

    Docker version 29.7.2, build a7dcaab

This confirmed that Docker was installed and working correctly.

---

# Part 4 — Create Ubuntu Container

## 9. Start Ubuntu Container

From Windows CMD, I ran:

    docker run -it ubuntu

### Meaning of the Command

    docker

Uses Docker.

    run

Creates and starts a container.

    -it

Starts an interactive terminal so I can work inside the container.

    ubuntu

Uses the Ubuntu Docker image.

---

## 10. Ubuntu Image Download

The first time I ran:

    docker run -it ubuntu

Docker displayed:

    Unable to find image 'ubuntu:latest' locally

This was not an error.

It simply meant that Docker did not have the Ubuntu image locally.

Docker then downloaded the Ubuntu image.

After the download finished, Docker started the Ubuntu container.

---

# Part 5 — Enter Ubuntu

## 11. Enter the Ubuntu Container

After the container started, my Windows prompt changed from:

    C:\Users\Yuvraj>

to something similar to:

    root@5310cfb59118:/#

This means I am now inside the Ubuntu container.

I am no longer working directly in Windows CMD.

I am now working inside an Ubuntu Linux environment running through Docker.

---

## 12. Understand the Ubuntu Prompt

My prompt looked like:

    root@5310cfb59118:/#

It can be understood as:

    root
    ↓
    Current Linux user

    @
    ↓
    Separates the username and hostname

    5310cfb59118
    ↓
    Container hostname / container ID

    :
    ↓
    Separates hostname and current directory

    /
    ↓
    Current directory

    #
    ↓
    Root user's shell prompt

The important part is:

    root@5310cfb59118:/#

This tells me that I am inside Ubuntu and currently located at:

    /

---

# Part 6 — Linux Commands I Practiced

## 13. First Linux Command — pwd

I ran:

    pwd

Output:

    /

### Meaning

    pwd = Print Working Directory

The command tells me my current location in the Linux filesystem.

The output:

    /

means that I am currently in the Linux root directory.

---

## 14. Linux Root Directory

In Linux, / is the top-level directory of the filesystem.

The root directory contains important directories such as:

    /
    ├── bin
    ├── boot
    ├── dev
    ├── etc
    ├── home
    ├── lib
    ├── media
    ├── mnt
    ├── opt
    ├── proc
    ├── root
    ├── run
    ├── sbin
    ├── srv
    ├── sys
    ├── tmp
    ├── usr
    └── var

I will learn the purpose of these directories later.

---

## 15. Second Linux Command — ls

I ran:

    ls

The output included:

    bin
    boot
    dev
    etc
    home
    lib
    media
    mnt
    opt
    proc
    root
    run
    sbin
    srv
    sys
    tmp
    usr
    var

### Meaning

    ls = List

The ls command displays files and directories inside the current directory.

Because I was currently inside:

    /

the ls command displayed the contents of the Linux root directory.

---

## 16. Third Linux Command — cd

The next command I started learning is:

    cd /home

### Meaning

    cd = Change Directory

This command changes my current directory.

I move from:

    /

to:

    /home

---

## 17. Verify the New Directory

After running:

    cd /home

I can verify my current location using:

    pwd

Expected output:

    /home

This confirms that I successfully moved into the /home directory.

---

# Part 7 — Linux Commands Learned So Far

| Command | Meaning | Purpose |
|---|---|---|
| pwd | Print Working Directory | Shows my current directory |
| ls | List | Shows files and directories |
| cd | Change Directory | Moves me to another directory |

---

# Part 8 — Daily Linux Practice Process

After setting up Docker and Ubuntu, this is the process I will follow every day when I want to practice Linux.

## Step 1 — Start Docker Desktop

After restarting my Windows PC:

1. I will open Docker Desktop.
2. I will wait until Docker Desktop shows:

    Engine running

This means Docker Engine is running and I can use Docker.

---

## Step 2 — Open CMD

I will open:

    Command Prompt

I will see something like:

    C:\Users\Yuvraj>

This means I am currently in Windows CMD.

---

## Step 3 — Check My Ubuntu Container

I will run:

    docker ps -a

This command shows all my Docker containers, including containers that are currently stopped.

I should see something similar to:

    CONTAINER ID   IMAGE     STATUS
    5310cfb59118   ubuntu    Exited

If the status says:

    Exited

I don't need to worry.

It only means that my Ubuntu container is currently stopped because I restarted or closed it.

---

## Step 4 — Start My Existing Ubuntu Container

I will use the container ID shown by:

    docker ps -a

For example:

    docker start -ai 5310cfb59118

The container ID may be different on my system, so I should use the ID shown on my computer.

After starting it, I should see something like:

    root@5310cfb59118:/#

Now I am back inside my Ubuntu Linux container.

---

# Part 9 — Start Practicing Linux

Once I see:

    root@5310cfb59118:/#

I can start executing Linux commands.

For example:

### Check where I am

    pwd

### List files and directories

    ls

### Change directory

    cd /home

### Check my new location

    pwd

Expected output:

    /home

From this point, I will continue learning Linux commands one by one.

---

# Part 10 — My Daily Flow

Every time I want to practice Linux, I will follow this process:

    Restart Windows
          ↓
    Open Docker Desktop
          ↓
    Wait for "Engine running"
          ↓
    Open CMD
          ↓
    docker ps -a
          ↓
    docker start -ai <container-id>
          ↓
    root@...:/#
          ↓
    Practice Linux commands
          ↓
    exit

---

# Important — Do Not Create a New Container Every Day

I should NOT run this every day:

    docker run -it ubuntu

This command creates a new Ubuntu container.

I have already created my Ubuntu container.

So from now on, I will use:

    docker ps -a

to find my existing container.

Then I will use:

    docker start -ai <container-id>

to start my existing container.

---

# Part 11 — When I Finish Practicing

When I am finished with Linux practice, I can type:

    exit

This will take me out of the Ubuntu container and back to Windows CMD.

I will see:

    C:\Users\Yuvraj>

So:

    exit

means I leave the Ubuntu container and return to Windows CMD.

---

# Part 12 — Complete Setup Flow

The complete process I followed was:

    Windows
       ↓
    Check Windows Version
       ↓
    Try WSL Installation
       ↓
    WSL Catastrophic Failure
       ↓
    Update WSL
       ↓
    Install Docker Desktop
       ↓
    Fix Docker + WSL Issue
       ↓
    Restart Windows
       ↓
    Docker Engine Running
       ↓
    Open Windows CMD
       ↓
    docker --version
       ↓
    docker run -it ubuntu
       ↓
    Ubuntu Image Downloaded
       ↓
    Ubuntu Container Created
       ↓
    Enter Ubuntu
       ↓
    pwd
       ↓
    ls
       ↓
    cd /home
       ↓
    Practice Linux Commands

---

# Part 13 — Current Status

Docker:

    Installed ✅

Docker Engine:

    Running ✅

WSL:

    Updated ✅

Ubuntu image:

    Downloaded ✅

Ubuntu container:

    Created ✅

Ubuntu terminal:

    Working ✅

Linux commands practiced:

    pwd ✅
    ls  ✅
    cd  → Learning

---

# Part 14 — What I Understand Now

I understand that Docker is not the same thing as Linux.

Docker is used to run containers.

In my setup:

    Windows
       ↓
    Docker Desktop
       ↓
    Docker Engine
       ↓
    Ubuntu Container
       ↓
    Linux Environment
       ↓
    Linux Commands

The Ubuntu container gives me a Linux environment where I can practice Linux commands.

---

# Part 15 — Next Linux Topics

I will continue learning Linux step by step.

    pwd
     ↓
    ls
     ↓
    cd
     ↓
    mkdir
     ↓
    touch
     ↓
    cat
     ↓
    cp
     ↓
    mv
     ↓
    rm
     ↓
    File Permissions
     ↓
    Users and Groups
     ↓
    Processes
     ↓
    Networking
     ↓
    Package Management
     ↓
    Shell Scripting

My goal is to understand each command practically instead of simply memorizing commands.
