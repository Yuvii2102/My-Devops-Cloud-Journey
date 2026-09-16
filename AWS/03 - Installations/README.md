# 🚀 LINUX PRACTICAL — SSH FROM UBUNTU CONTAINER & JENKINS INSTALLATION

Today I’m connecting to my AWS EC2 instance through an Ubuntu Docker container and then installing Jenkins on the EC2 server.

My complete flow is:

```text
Windows
   ↓
Docker Desktop
   ↓
Ubuntu Docker Container
   ↓
SSH Client
   ↓
AWS EC2
   ↓
Jenkins Installation
```

---

# 🔐 PART 1 — SSH CLIENT INSIDE MY UBUNTU CONTAINER

I want to use SSH from my Ubuntu Docker container to connect to my AWS EC2 instance.

My PEM key is currently on Windows, so I first need to:

1. Check SSH inside the container
2. Copy my PEM file into the container
3. Secure the PEM file
4. SSH into EC2

---

# 🧠 1. Check SSH Inside the Container

Inside my Ubuntu container, I run:

```bash
ssh -V
```

If I get something like:

```text
OpenSSH_...
```

then SSH is already installed.

If I get:

```text
ssh: command not found
```

I install the SSH client:

```bash
apt update
apt install openssh-client -y
```

Then I check again:

```bash
ssh -V
```

I should see something similar to:

```text
OpenSSH_9.x ...
```

---

# 🪟 2. My PEM Key is on Windows

My `demo21.pem` file is on Windows, for example:

```text
C:\Users\Yuvraj\Downloads\demo21.pem
```

I **cannot directly use**:

```bash
ssh -i demo21.pem ...
```

from inside the container if the PEM file hasn't been copied into the container.

So first I exit the container:

```bash
exit
```

I should return to Windows:

```text
C:\Users\Yuvraj>
```

---

# 🔎 3. Find My Docker Container

From Windows CMD, I run:

```cmd
docker ps -a
```

I may see something like:

```text
CONTAINER ID   IMAGE     ...
5310cfb59118   ubuntu    ...
```

Here my container ID is:

```text
5310cfb59118
```

My actual container ID may be different, so I should use the ID shown on my machine.

---

# 📥 4. Copy the PEM File Into the Container

From Windows CMD, I run:

```cmd
docker cp "C:\Users\Yuvraj\Downloads\demo21.pem" 5310cfb59118:/root/demo21.pem
```

This copies:

```text
Windows
C:\Users\Yuvraj\Downloads\demo21.pem
        ↓
Docker Container
/root/demo21.pem
```

So now the PEM key is inside the container.

---

# ▶️ 5. Start the Container Again

I run:

```cmd
docker start -ai 5310cfb59118
```

Now I'm back inside my Ubuntu container.

I should see something similar to:

```text
root@5310cfb59118:/#
```

---

# 🔍 6. Check the PEM File

Inside the container:

```bash
ls -l /root/demo21.pem
```

I should see the file.

Then I secure its permissions:

```bash
chmod 400 /root/demo21.pem
```

This is important because the private key should not be broadly accessible.

---

# 🚀 7. SSH Into My EC2 Instance

Now I can use:

```bash
ssh -i /root/demo21.pem ubuntu@13.220.212.212
```

Here:

```text
ssh
 ↓
SSH client

-i /root/demo21.pem
 ↓
Use my private key

ubuntu
 ↓
EC2 login username

13.220.212.212
 ↓
EC2 public IP
```

If the key belongs to that EC2 instance and SSH access is correctly configured, I should get something similar to:

```text
Welcome to Ubuntu...
ubuntu@ip-172-31-xx-xx:~$
```

🎉 Now my path is:

```text
Windows CMD
     ↓
Docker Ubuntu Container
     ↓
SSH
     ↓
AWS EC2
```

---

# 🧠 PART 2 — SSH INTO EC2 AS `ubuntu`

The normal Ubuntu EC2 login user is commonly:

```text
ubuntu
```

So from my Ubuntu container I use:

```bash
ssh -i /root/demo21.pem ubuntu@EC2_PUBLIC_IP
```

For example:

```bash
ssh -i /root/demo21.pem ubuntu@13.220.212.212
```

After successful login, my prompt may look like:

```text
ubuntu@ip-172-31-85-13:~$
```

The `$` tells me I'm operating as a normal user.

I can confirm:

```bash
whoami
```

Output:

```text
ubuntu
```

---

# 👑 PART 3 — BECOMING ROOT ON EC2

Once I'm logged in as `ubuntu`, I can check:

```bash
whoami
```

If it says:

```text
ubuntu
```

I'm a normal user.

For administrative tasks, I can become root with:

```bash
sudo -i
```

Then:

```bash
whoami
```

should show:

```text
root
```

My prompt may now look like:

```text
root@ip-172-31-85-13:~#
```

The `#` indicates I'm operating as root.

So my flow is:

```text
ubuntu@server:~$
        ↓
    sudo -i
        ↓
root@server:~#
```

---

# 🧠 4. ROOT vs UBUNTU

I should remember:

```text
ubuntu@server:~$
       ↓
Normal user
       ↓
Usually needs sudo for administrative commands
```

While:

```text
root@server:~#
       ↓
Root user
       ↓
Already has administrative privileges
       ↓
No sudo needed
```

For example, as root:

```bash
apt update
```

is enough.

As `ubuntu`:

```bash
sudo apt update
```

is normally used.

---

# 🔥 PART 4 — JENKINS INSTALLATION AS ROOT

Once I'm on the EC2 server and become root:

```bash
sudo -i
```

I should see:

```text
root@ip-172-31-85-13:~#
```

Now I can install Jenkins.

---

# 🧰 STEP 1 — Update Packages

As root:

```bash
apt update
```

Because I'm already root, I don't need:

```bash
sudo apt update
```

---

# ☕ STEP 2 — Install Java 21

First I install the required packages:

```bash
apt install fontconfig openjdk-21-jre -y
```

Then check Java:

```bash
java -version
```

I should see Java 21 or later according to the Jenkins installation requirement I'm following.

---

# 🔑 STEP 3 — Create the Keyrings Directory

I run:

```bash
mkdir -p /etc/apt/keyrings
```

This creates the directory if it doesn't already exist.

---

# 🔐 STEP 4 — Download the Jenkins Signing Key

I run:

```bash
wget -O /etc/apt/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
```

This places the Jenkins signing key at:

```text
/etc/apt/keyrings/jenkins-keyring.asc
```

---

# 🌐 STEP 5 — Add the Jenkins Repository

I run:

```bash
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
https://pkg.jenkins.io/debian-stable binary/ \
> /etc/apt/sources.list.d/jenkins.list
```

Now my system knows where to obtain the Jenkins package.

---

# 🔄 STEP 6 — Update Package Information Again

After adding a new repository, I run:

```bash
apt update
```

This refreshes the package information and includes the newly configured Jenkins repository.

---

# 📥 STEP 7 — Install Jenkins

Now I run:

```bash
apt install jenkins -y
```

⚠️ I need to make sure the command is exactly:

```bash
apt install jenkins -y
```

and **not** something accidentally joined with another piece of text.

---

# 🔍 STEP 8 — Check Jenkins Version

After installation:

```bash
jenkins --version
```

If installation was successful, I should get a Jenkins version number.

Before installation, I might have received:

```text
jenkins: command not found
```

After installation, I should get the version.

---

# ▶️ STEP 9 — Enable Jenkins

I run:

```bash
systemctl enable jenkins
```

This configures Jenkins to start automatically during boot.

---

# 🚀 STEP 10 — Start Jenkins

I run:

```bash
systemctl start jenkins
```

This starts Jenkins now.

Remember from Day 10:

```text
start
  ↓
Start NOW

enable
  ↓
Start automatically at BOOT
```

---

# 🔎 STEP 11 — Check Jenkins Status

I run:

```bash
systemctl status jenkins
```

I want to see:

```text
Active: active (running)
```

That means the Jenkins service is running.

---

# 🌐 STEP 12 — Jenkins Port

Jenkins normally listens on:

```text
8080
```

So my basic flow is:

```text
Browser
   ↓
EC2 Public IP
   ↓
Port 8080
   ↓
Jenkins
```

For the web UI to be reachable externally, the EC2 networking/security configuration must also allow the required traffic.

---

# 🧑‍💻 PART 5 — INSTALLING JENKINS WHEN I'M LOGGED IN AS `ubuntu`

I don't have to SSH directly as root.

A common workflow is:

```text
SSH as ubuntu
      ↓
sudo -i
      ↓
Become root
      ↓
Install Jenkins
```

So I can SSH into EC2 as:

```bash
ssh -i /root/demo21.pem ubuntu@EC2_PUBLIC_IP
```

Then:

```bash
sudo -i
```

Now:

```bash
whoami
```

Output:

```text
root
```

Then I can run the Jenkins installation commands.

---

# 🧠 IMPORTANT — WHY I DON'T NEED `sudo` AFTER `sudo -i`

If I see:

```text
root@ip-172-31-85-13:~#
```

I'm already root.

Therefore:

```bash
apt update
```

is enough.

I don't need:

```bash
sudo apt update
```

The same applies to:

```bash
apt install jenkins -y
systemctl start jenkins
systemctl enable jenkins
```

So:

```text
ROOT
 ↓
No sudo required
```

While:

```text
UBUNTU
 ↓
Use sudo for administrative commands
```

---

# 🔥 PART 6 — COMPLETE SSH + JENKINS FLOW

I can remember the complete process like this:

```text
                    WINDOWS
                       │
                       ↓
                Docker Desktop
                       │
                       ↓
              Ubuntu Container
                       │
                       ↓
               Check SSH client
                       │
                       ↓
              Copy demo21.pem
                       │
                       ↓
               chmod 400 PEM
                       │
                       ↓
             SSH to EC2 as ubuntu
                       │
                       ↓
                ubuntu@server
                       │
                       ↓
                  sudo -i
                       │
                       ↓
                 root@server
                       │
                       ↓
                  Java 21
                       │
                       ↓
              Jenkins Repository
                       │
                       ↓
               apt update
                       │
                       ↓
           apt install jenkins -y
                       │
                       ↓
             systemctl enable
                       │
                       ↓
             systemctl start
                       │
                       ↓
             systemctl status
                       │
                       ↓
             Jenkins Running 🚀
```

---

# 🧠 PART 7 — JENKINS ROOT CHEAT SHEET

When I'm already root:

```bash
apt update

apt install fontconfig openjdk-21-jre -y

java -version

mkdir -p /etc/apt/keyrings

wget -O /etc/apt/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
https://pkg.jenkins.io/debian-stable binary/ \
> /etc/apt/sources.list.d/jenkins.list

apt update

apt install jenkins -y

jenkins --version

systemctl enable jenkins

systemctl start jenkins

systemctl status jenkins
```

---

# 🔐 PART 8 — SSH CHEAT SHEET

## From Windows → Docker Container

First:

```cmd
docker ps -a
```

Then copy the PEM:

```cmd
docker cp "C:\Users\Yuvraj\Downloads\demo21.pem" CONTAINER_ID:/root/demo21.pem
```

Start the container:

```cmd
docker start -ai CONTAINER_ID
```

---

## Inside Ubuntu Container

Check SSH:

```bash
ssh -V
```

If missing:

```bash
apt update
apt install openssh-client -y
```

Check PEM:

```bash
ls -l /root/demo21.pem
```

Secure it:

```bash
chmod 400 /root/demo21.pem
```

SSH to EC2:

```bash
ssh -i /root/demo21.pem ubuntu@EC2_PUBLIC_IP
```

---

# 👤 PART 9 — UBUNTU → ROOT CHEAT SHEET

After SSH:

```bash
whoami
```

If:

```text
ubuntu
```

then:

```bash
sudo -i
```

Check:

```bash
whoami
```

Now:

```text
root
```

Then I can perform administrative tasks without `sudo`.

---

# 🚨 PART 10 — IMPORTANT TROUBLESHOOTING

If SSH doesn't work, I should not randomly retry.

I should investigate:

```text
SSH connection failed
       ↓
Is EC2 running?
       ↓
Correct public IP?
       ↓
Correct username?
       ↓
Correct PEM key?
       ↓
PEM permissions?
       ↓
SSH service running?
       ↓
Port 22 allowed?
       ↓
Security/network configuration?
```

For Ubuntu EC2, the username is commonly:

```text
ubuntu
```

And SSH normally uses:

```text
TCP 22
```

---

# 🚨 PART 11 — IF JENKINS INSTALLATION FAILS

I should look at the exact error.

My investigation can include:

```text
Jenkins installation failed
        ↓
Java installed?
        ↓
java -version
        ↓
Repository configured?
        ↓
apt update successful?
        ↓
Network connectivity?
        ↓
Package available?
        ↓
Disk space?
        ↓
Exact apt error
```

If Jenkins installs but doesn't start:

```bash
systemctl status jenkins
```

Then:

```bash
journalctl -u jenkins
```

This connects directly to what I learned on **OS Day 10 — Services & systemd**.

---

# 🎯 PART 12 — DAY 10 CONNECTION

I learned:

```text
systemctl status <service>
```

and:

```bash
journalctl -u <service>
```

Now I can apply it to Jenkins:

```bash
systemctl status jenkins
```

and:

```bash
journalctl -u jenkins
```

So I'm not just memorizing commands.

I'm actually applying my OS knowledge to a real DevOps application.

---

# 🏆 FINAL MEMORY

The most important things I should remember are:

```text
Windows
   ↓
Docker Ubuntu
   ↓
SSH Client
   ↓
PEM Key
   ↓
EC2
   ↓
ubuntu user
   ↓
sudo -i
   ↓
root
   ↓
Java
   ↓
Jenkins Repository
   ↓
apt update
   ↓
apt install jenkins
   ↓
systemctl enable jenkins
   ↓
systemctl start jenkins
   ↓
systemctl status jenkins
```

And the most important user distinction:

```text
ubuntu@server:~$
       ↓
Normal user
       ↓
sudo for admin tasks

root@server:~#
       ↓
Root
       ↓
No sudo needed
```

---

# 🎯 QUICK COMMAND MEMORY

### SSH

```bash
ssh -i /root/demo21.pem ubuntu@EC2_PUBLIC_IP
```

### Check user

```bash
whoami
```

### Become root

```bash
sudo -i
```

### Check Java

```bash
java -version
```

### Install Jenkins

```bash
apt install jenkins -y
```

### Start Jenkins

```bash
systemctl start jenkins
```

### Enable Jenkins

```bash
systemctl enable jenkins
```

### Check Jenkins

```bash
systemctl status jenkins
```

### Check Jenkins logs

```bash
journalctl -u jenkins
```

---

# ✅ PRACTICAL COMPLETE

I should now understand this complete real-world workflow:

> **I use Windows to manage my Docker container, use the Ubuntu container as my SSH client, use my PEM key to connect to EC2 as the `ubuntu` user, use `sudo -i` to become root, and then install and manage Jenkins using `apt` and `systemctl`.**

🔥 This practical connects:

```text
Linux
+
SSH
+
Users
+
Root
+
Permissions
+
Package Management
+
systemd
+
Jenkins
+
AWS EC2
```

That is exactly how the concepts I have been learning start connecting together in a real DevOps environment.
