# 🐧 Linux Folder Structure — DevOps/Cloud Essentials

Now I need to understand the **Linux folder structure**.

In Linux, everything starts from one main directory called `/`.

The basic structure looks like this:

```text
/
├── bin
├── sbin
├── etc
├── home
├── root
├── opt
├── var
├── tmp
├── usr
├── boot
├── dev
├── proc
├── sys
├── run
├── mnt
└── srv
```

I don't need to memorize everything at once. I mainly need to understand what each important directory is used for.

---

# 1. `/` — Root of the Filesystem ⭐⭐⭐

`/` is the **top-level directory** in Linux.

Everything starts from `/`.

For example:

```bash
cd /
ls
```

When I run `cd /`, I move to the top-level directory.

I can think of `/` as the **starting point of the Linux filesystem**.

In Windows, we commonly think about `C:\` as a starting point.

In Linux, the filesystem starts from:

```text
/
```

So:

> `/` = **root of the filesystem**

---

# 2. `/home` — Normal Users ⭐⭐⭐

The `/home` directory is generally used for **normal users**.

Each normal user usually has their own directory inside `/home`.

For example:

```text
/home/ubuntu
/home/abhishek
```

If my username is `ubuntu`, I can go to my home directory using:

```bash
cd /home/ubuntu
```

This is where user-specific files are stored.

For example, my own files, scripts and other working files can be inside my home directory.

### DevOps use

I will commonly work with `/home` when dealing with:

* Users
* SSH
* Application files
* Permissions

So:

> `/home` = **normal users' home directories**

---

# 3. `/root` — Root User's Home ⭐⭐⭐

In Linux, `root` is the **administrator user**.

The home directory of the root user is:

```text
/root
```

This is different from `/home`.

So I should remember:

```text
/root       → root user's home

/home/...   → normal users' home directories
```

For example:

```text
/home/ubuntu
/home/abhishek
```

are normal user directories, while:

```text
/root
```

belongs to the root user.

So:

> `/root` = **root user's home directory**

---

# 4. `/etc` — Configuration Files ⭐⭐⭐⭐⭐

This is **very important for DevOps**.

`/etc` contains configuration files for the system and applications.

Some examples are:

```text
/etc/hosts
/etc/passwd
/etc/ssh/
/etc/nginx/
```

When I configure Linux services or applications, I will frequently come across `/etc`.

For example, I may work with configuration related to:

* SSH
* Networking
* Users
* Services
* Web servers
* System settings

So the easiest way to remember it is:

> `/etc` = **Configuration**

This is one of the directories I should definitely remember for DevOps.

---

# 5. `/var` — Logs & Changing Data ⭐⭐⭐⭐⭐

`/var` is another **very important DevOps directory**.

It contains data that changes while the system is running.

One of the most important locations is:

```text
/var/log
```

This is where system and application logs are commonly stored.

For example:

```bash
cd /var/log
ls
```

When something is not working, logs are often one of the first things I need to check.

For example:

```text
Application not working
        ↓
Check logs
        ↓
/var/log
```

So I should remember:

> `/var` = **variable/changing data**

And especially:

> `/var/log` = **logs**

---

# 6. `/usr` — User Programs & Libraries ⭐⭐⭐⭐

`/usr` contains many programs, binaries and libraries used by the system.

Some important locations inside it are:

```text
/usr/bin
/usr/sbin
/usr/lib
```

Commands such as `ls`, `cat` and many other programs are available through locations under `/usr`.

I normally don't need to manually modify `/usr`.

The simple way to remember it is:

> `/usr` = **Programs, binaries and libraries**

---

# 7. `/bin` — Essential User Commands ⭐⭐⭐

`/bin` contains commonly used executable commands.

Examples include:

```text
ls
cat
cp
mv
```

These are common commands that we use while working with Linux.

On modern Ubuntu systems, `/bin` may be linked to `/usr/bin`.

For now, I just need to remember:

> `/bin` = **Common user commands**

---

# 8. `/sbin` — System/Admin Commands ⭐⭐⭐

`/sbin` contains commands mainly used for **system administration**.

For example:

```text
useradd
mount
```

So I can remember the difference like this:

```text
bin
 ↓
Regular/common commands

sbin
 ↓
System/admin commands
```

On modern Ubuntu systems, `/sbin` may also be linked to `/usr/sbin`.

So:

> `/sbin` = **System/Admin commands**

---

# 9. `/opt` — Optional / Third-Party Software ⭐⭐⭐⭐

`/opt` is commonly used for **third-party or custom software**.

For example:

```text
/opt/myapp
/opt/custom-tool
```

If an organization installs a custom application or tool, `/opt` can be an appropriate location for it.

So:

> `/opt` = **Optional / third-party applications**

---

# 10. `/tmp` — Temporary Files ⭐⭐⭐⭐

`/tmp` is used for **temporary files**.

The directory is:

```text
/tmp
```

Files stored here should **not be treated as permanent storage**.

For example, I might have:

```text
Temporary script output
Temporary files
Temporary application data
        ↓
      /tmp
```

So the easy way to remember:

> `/tmp` = **Temporary files**

---

# 11. `/boot` — Boot Files ⭐⭐

`/boot` contains files required for the Linux system to **boot/start**.

These files are important when the system starts.

As a DevOps engineer, I normally won't modify `/boot` during regular work.

So:

> `/boot` = **Linux startup/boot files**

---

# 12. `/dev` — Devices ⭐⭐⭐

Linux represents many hardware devices as files under `/dev`.

For example:

```text
/dev/sda
/dev/nvme0n1
```

These are commonly seen when working with disks and storage.

`/dev` becomes useful when working with:

* Disks
* Storage
* Volumes

So:

> `/dev` = **Devices**

---

# 13. `/proc` — Process & Kernel Information ⭐⭐⭐⭐

`/proc` is a **virtual filesystem**.

It contains information about things such as:

* Running processes
* CPU
* Memory
* Kernel

For example:

```bash
cat /proc/cpuinfo
```

This gives information about the CPU.

I will come across `/proc` when doing things like:

* Linux troubleshooting
* System monitoring

So:

> `/proc` = **Process/System information**

---

# 14. `/sys` — Kernel & Hardware Information ⭐⭐⭐

`/sys` is another **virtual filesystem**.

It exposes information related to:

* Hardware
* Devices
* Kernel

I don't need to work with `/sys` every day, but I should know what it represents.

So:

> `/sys` = **System/Kernel information**

---

# 15. `/run` — Runtime Data ⭐⭐

`/run` contains temporary **runtime information** created while the system and services are running.

So:

> `/run` = **Runtime information**

---

# 16. `/mnt` — Mount Point ⭐⭐⭐

`/mnt` is used as a location where filesystems or disks can be mounted.

For example:

```text
/mnt
```

It becomes useful when working with:

* Disks
* Storage
* Mounted volumes

So:

> `/mnt` = **Mount storage**

---

# 17. `/srv` — Service Data ⭐⭐

`/srv` is used for data related to services provided by the system.

I won't use it as frequently as directories such as:

```text
/etc
/var
/home
```

But I should know what it represents.

So:

> `/srv` = **Service data**

---

# ⭐ The Most Important Directories for DevOps

I don't need to memorize all directories equally.

I should focus more on these:

| Directory  | What I should remember      | DevOps Importance |
| ---------- | --------------------------- | ----------------: |
| `/`        | Root of filesystem          |             ⭐⭐⭐⭐⭐ |
| `/etc`     | Configuration               |             ⭐⭐⭐⭐⭐ |
| `/var/log` | Logs                        |             ⭐⭐⭐⭐⭐ |
| `/home`    | Normal users                |             ⭐⭐⭐⭐⭐ |
| `/root`    | Root user's home            |              ⭐⭐⭐⭐ |
| `/usr`     | Programs/libraries          |              ⭐⭐⭐⭐ |
| `/opt`     | Third-party software        |              ⭐⭐⭐⭐ |
| `/tmp`     | Temporary files             |              ⭐⭐⭐⭐ |
| `/dev`     | Devices/disks               |               ⭐⭐⭐ |
| `/proc`    | Process/system information  |               ⭐⭐⭐ |
| `/mnt`     | Mounted storage             |               ⭐⭐⭐ |
| `/boot`    | Boot files                  |                ⭐⭐ |
| `/run`     | Runtime data                |                ⭐⭐ |
| `/sys`     | Kernel/hardware information |                ⭐⭐ |
| `/srv`     | Service data                |                ⭐⭐ |

---

# 🧠 Easy Way to Remember

I can remember the Linux folders like this:

```text
/       → Everything starts here

/home   → Normal users

/root   → Root user's home

/etc    → Configuration

/var    → Logs / changing data

/usr    → Programs & libraries

/bin    → Common commands

/sbin   → Admin commands

/opt    → Third-party software

/tmp    → Temporary files

/dev    → Devices

/proc   → Processes / system information

/sys    → Kernel / hardware information

/mnt    → Mounted disks / storage

/boot   → Boot files

/run    → Runtime data

/srv    → Service data
```

### ⭐ My main memory trick

```text
/etc      → Configuration
/var/log  → Logs
/home     → Users
/root     → Root user's home
/usr      → Programs & libraries
/opt      → Third-party software
/tmp      → Temporary
/dev      → Devices
/proc     → Processes / system info
/sys      → Kernel / hardware info
/mnt      → Mounted storage
/boot     → Boot
/run      → Runtime
/srv      → Service
```

So for DevOps, the directories I should especially remember are:

```text
/
├── /etc       → Configuration
├── /var/log   → Logs
├── /home      → Users
├── /root      → Root user
├── /usr       → Programs / libraries
├── /opt       → Third-party software
├── /tmp       → Temporary files
├── /dev       → Devices
├── /proc      → Process/system information
└── /mnt       → Mounted storage
```

The main idea is simply:

> **Linux has a standard filesystem structure, and each directory has a specific purpose. For DevOps, `/etc`, `/var/log`, `/home`, `/root`, `/usr`, `/opt`, `/tmp`, `/dev`, `/proc`, and `/mnt` are especially important to understand.**
