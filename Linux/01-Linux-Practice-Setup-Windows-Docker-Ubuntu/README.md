# Linux Practice — Windows + Docker + Ubuntu

## Goal

Set up a Linux practice environment on Windows using Docker Desktop and an Ubuntu container, then start learning basic Linux commands.

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

## 1. Check Windows Version

Before setting up Docker and WSL, we checked the Windows version.

Our system:

- Windows 10
- Version: 22H2
- OS Build: 19045.6466

---

## 2. Initial WSL Setup

Docker Desktop uses WSL 2 on Windows, so we first tried to set up WSL.

### Check WSL Status

    wsl --status

### Check Available Linux Distributions

    wsl --list --online

This displayed Linux distributions such as:

    Ubuntu
    Debian
    kali-linux
    OracleLinux
    openSUSE

---

## 3. Try Installing Ubuntu Through WSL

We tried:

    wsl --install -d Ubuntu

The installation started, but eventually showed:

    Catastrophic failure

Because of this problem, we decided to use Docker Desktop with an Ubuntu container for our Linux practice.

---

## 4. Update WSL

We opened PowerShell as Administrator and ran:

    wsl --update

Eventually, WSL reported:

    Checking for updates.
    The most recent version of Windows Subsystem for Linux is already installed.

This confirmed that WSL was updated.

---

## 5. Install Docker Desktop

We installed Docker Desktop for Windows.

Our computer uses the normal x64 architecture, so we selected:

    AMD64 / x64

We did not select ARM64 because our Windows PC uses x64 architecture.

---

## 6. Docker Desktop WSL Problem

After installing Docker Desktop, Docker initially showed:

    WSL needs updating

We updated WSL again using:

    wsl --update

After updating WSL, Docker Desktop initially showed:

    Docker Desktop - WSL is unresponsive

We restarted Windows.

After restarting Windows and opening Docker Desktop again, Docker successfully started.

Docker Desktop showed:

    Engine running

This confirmed that the Docker Engine was running correctly.

---

## 7. Verify Docker From Windows CMD

We opened Windows Command Prompt.

The prompt looked like:

    C:\Users\Yuvraj>

We ran:

    docker --version

Output:

    Docker version 29.7.2, build a7dcaab

This confirmed that Docker was installed and working correctly.

---

## 8. Start an Ubuntu Container

From Windows CMD, we ran:

    docker run -it ubuntu

### Meaning of the Command

    docker

Uses Docker.

    run

Creates and starts a container.

    -it

Starts an interactive terminal so we can work inside the container.

    ubuntu

Uses the Ubuntu Docker image.

---

## 9. Ubuntu Image Download

The first time we ran:

    docker run -it ubuntu

Docker displayed:

    Unable to find image 'ubuntu:latest' locally

This was not an error.

It simply meant that Docker did not have the Ubuntu image locally.

Docker then downloaded the Ubuntu image.

After the download finished, Docker started the Ubuntu container.

---

## 10. Enter the Ubuntu Container

After the container started, the Windows prompt changed from:

    C:\Users\Yuvraj>

to something similar to:

    root@5310cfb59118:/#

This means that we are now inside the Ubuntu container.

We are no longer working directly in Windows CMD.

We are now working inside an Ubuntu Linux environment running through Docker.

---

## 11. Understand the Ubuntu Prompt

Our prompt was:

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

This tells us that we are inside Ubuntu and currently located at:

    /

---

## 12. First Linux Command — pwd

We ran:

    pwd

Output:

    /

### Meaning

    pwd = Print Working Directory

The command tells us our current location in the Linux filesystem.

The output:

    /

means that we are currently in the Linux root directory.

---

## 13. Linux Root Directory

In Linux, `/` is the top-level directory of the filesystem.

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

We will learn the purpose of these directories later.

---

## 14. Second Linux Command — ls

We ran:

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

The `ls` command displays files and directories inside the current directory.

Because we were currently inside:

    /

the `ls` command displayed the contents of the Linux root directory.

---

## 15. Third Linux Command — cd

The next command we started learning is:

    cd /home

### Meaning

    cd = Change Directory

The command changes our current directory.

We move from:

    /

to:

    /home

---

## 16. Verify the New Directory

After running:

    cd /home

we can verify our current location using:

    pwd

Expected output:

    /home

This confirms that we successfully moved into the `/home` directory.

---

## 17. Linux Commands Learned So Far

| Command | Meaning | Purpose |
|---|---|---|
| `pwd` | Print Working Directory | Shows the current directory |
| `ls` | List | Shows files and directories |
| `cd` | Change Directory | Moves to another directory |

---

## 18. What We Have Achieved

We successfully completed the Linux environment setup.

    Windows
       ↓
    WSL Updated
       ↓
    Docker Desktop Installed
       ↓
    Docker Engine Running
       ↓
    Ubuntu Image Downloaded
       ↓
    Ubuntu Container Created
       ↓
    Ubuntu Terminal Started
       ↓
    Linux Commands Executed

We can now use the Ubuntu container to practice Linux commands.

---

## 19. Important Understanding

Docker is not the same thing as Linux.

Docker is a platform used to run containers.

In our setup:

    Windows
       ↓
    Docker Desktop
       ↓
    Docker Engine
       ↓
    Ubuntu Container
       ↓
    Linux Environment

The Ubuntu container gives us a Linux environment where we can practice Linux commands.

---

## 20. Current Status

Docker:

    Installed ✅

Docker Engine:

    Running ✅

Ubuntu image:

    Downloaded ✅

Ubuntu container:

    Created and running ✅

Ubuntu terminal:

    Working ✅

Linux commands practiced:

    pwd ✅
    ls  ✅
    cd  → Currently learning

---

## 21. Next Linux Topics

We will continue learning Linux step by step.

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

The goal is to understand each command practically instead of simply memorizing commands.
