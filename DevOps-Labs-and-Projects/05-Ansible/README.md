# Ansible Hands-On Journey - From Installation to GitHub

<p align="center">

## ⚙️ Ansible Hands-On Practice

**Installing Ansible → SSH Configuration → Inventory → Ad-Hoc Commands → Playbook → Nginx → GitHub**

</p>

---

## 📌 Overview

This page documents my complete hands-on Ansible practice, starting from installing Ansible on an AWS EC2 instance and ending with pushing my Ansible files to my GitHub repository.

I used two Ubuntu EC2 instances:

- **Ansible Server** — Control Node
- **Target Server** — Managed Node

The complete workflow was performed using the AWS EC2 Instance Connect terminal, SSH, Vim, Ansible, Git and GitHub.

---

## 🖥️ EC2 Server Setup

I used two Ubuntu EC2 instances.

```text
Ansible Server / Control Node
Private IP: 172.31.23.102

Target Server / Managed Node
Private IP: 172.31.31.9
```

The Ansible Server is responsible for controlling the Target Server.

The Target Server receives commands and automation tasks from Ansible through SSH.

### Architecture

```text
                 AWS EC2
                    │
          ┌─────────┴─────────┐
          │                   │
          ▼                   ▼
 ┌─────────────────┐   ┌─────────────────┐
 │ Ansible Server  │   │ Target Server   │
 │ Control Node    │   │ Managed Node    │
 │                 │   │                 │
 │ Ubuntu          │   │ Ubuntu          │
 │ Ansible         │   │ Nginx           │
 └────────┬────────┘   └─────────────────┘
          │
          │ SSH
          ▼
   Remote Automation
          │
          ▼
       GitHub
```

---

# 1️⃣ Install Ansible on the Ansible Server

First, I connected to my Ansible Server using **AWS EC2 Instance Connect**.

Then I updated the package lists:

```bash
sudo apt update
```

After that, I installed Ansible:

```bash
sudo apt install ansible -y
```

I verified the installation:

```bash
ansible --version
```

This confirmed that Ansible was successfully installed on the Control Node.

---

# 2️⃣ Generate an SSH Key on the Ansible Server

Ansible communicates with managed nodes through SSH.

I generated an RSA SSH key pair on the Ansible Server:

```bash
ssh-keygen -t rsa
```

I used the default location:

```text
/home/ubuntu/.ssh/id_rsa
```

This generated two files:

```text
~/.ssh/id_rsa
~/.ssh/id_rsa.pub
```

The files are:

```text
id_rsa      → Private Key
id_rsa.pub  → Public Key
```

I checked my public key using:

```bash
cat ~/.ssh/id_rsa.pub
```

> ⚠️ The private key `id_rsa` should never be shared or pushed to GitHub.

---

# 3️⃣ Configure SSH on the Target Server

Next, I connected to the Target Server:

```bash
ssh ubuntu@172.31.31.9
```

I created the SSH directory:

```bash
mkdir -p ~/.ssh
```

Then I set the correct permission:

```bash
chmod 700 ~/.ssh
```

I opened the `authorized_keys` file using **Vim**:

```bash
vim ~/.ssh/authorized_keys
```

I pasted the public SSH key from the Ansible Server into the file.

I saved and exited Vim using:

```text
ESC
:wq
ENTER
```

Then I set the correct permissions:

```bash
chmod 600 ~/.ssh/authorized_keys
```

---

# 4️⃣ Test SSH Connection

I returned to the Ansible Server and tested the SSH connection:

```bash
ssh ubuntu@172.31.31.9
```

The first connection asked:

```text
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

I entered:

```text
yes
```

The SSH connection was successful.

After verifying the connection, I exited:

```bash
exit
```

Output:

```text
Connection to 172.31.31.9 closed.
```

This confirmed that the Ansible Server could successfully connect to the Target Server.

---

# 5️⃣ Create the Ansible Inventory

Ansible needs an inventory file to know which servers it should manage.

I created the inventory using **Vim**:

```bash
vim inventory
```

I added:

```ini
[targets]
172.31.31.9
```

I saved the file:

```text
ESC
:wq
ENTER
```

Then I verified it:

```bash
cat inventory
```

Output:

```text
[targets]
172.31.31.9
```

My inventory structure was:

```text
[targets]
172.31.31.9
```

---

# 6️⃣ First Ansible Ad-Hoc Command — Ping

I used the Ansible `ping` module to test communication with the Target Server:

```bash
ansible -i inventory 172.31.31.9 -m ping
```

The result was:

```text
172.31.31.9 | SUCCESS
```

This confirmed that:

```text
Ansible Server
      │
      │ SSH + Ansible
      ▼
Target Server
      │
      ▼
SUCCESS
```

---

# 7️⃣ Ad-Hoc Command — whoami

I used the `command` module to check the user on the Target Server:

```bash
ansible -i inventory 172.31.31.9 -m command -a "whoami"
```

Output:

```text
ubuntu
```

This confirmed that Ansible was executing the command as the `ubuntu` user.

---

# 8️⃣ Ad-Hoc Command — hostname

I checked the hostname of the Target Server:

```bash
ansible -i inventory 172.31.31.9 -m command -a "hostname"
```

The hostname was returned successfully.

---

# 9️⃣ Ad-Hoc Command — ls

I executed the Linux `ls` command remotely:

```bash
ansible -i inventory 172.31.31.9 -m command -a "ls"
```

The command executed successfully on the Target Server.

---

# 🔟 Ad-Hoc Command — Disk Usage

I checked the disk usage of the Target Server:

```bash
ansible -i inventory 172.31.31.9 -m command -a "df"
```

The Target Server returned filesystem information.

Example:

```text
Filesystem      1K-blocks    Used Available Use% Mounted on
/dev/root         6931592 2125864   4789344  31% /
```

This demonstrated remote system monitoring using Ansible.

---

# 1️⃣1️⃣ Ad-Hoc Command — Memory Usage

I checked the memory usage:

```bash
ansible -i inventory 172.31.31.9 -m command -a "free -h"
```

Example output:

```text
               total        used        free      shared  buff/cache   available
Mem:           908Mi       323Mi       353Mi       2.8Mi       341Mi       585Mi
Swap:             0B          0B          0B
```

This completed my basic Ansible Ad-Hoc command practice.

---

# 1️⃣2️⃣ Ansible Ad-Hoc Command Structure

The general syntax I learned is:

```bash
ansible -i <inventory> <target> -m <module> -a "<arguments>"
```

Example:

```bash
ansible -i inventory 172.31.31.9 -m command -a "hostname"
```

### Breakdown

| Part | Meaning |
|---|---|
| `ansible` | Runs an Ansible Ad-Hoc command |
| `-i inventory` | Specifies the inventory file |
| `172.31.31.9` | Target host |
| `-m command` | Uses the command module |
| `-a` | Passes arguments to the module |
| `"hostname"` | Linux command to execute |

---

# 1️⃣3️⃣ Create My First Ansible Playbook

After practicing Ad-Hoc commands, I created my first Ansible Playbook.

The task was:

> **Install and start Nginx on the Target Server.**

I created the playbook using **Vim**:

```bash
vim install-nginx.yml
```

I wrote the following playbook:

```yaml
---
- name: Install Nginx
  hosts: targets
  become: yes

  tasks:

    - name: Install Nginx
      apt:
        name: nginx
        state: present
        update_cache: yes

    - name: Start Nginx
      service:
        name: nginx
        state: started
        enabled: yes
```

I saved and exited Vim:

```text
ESC
:wq
ENTER
```

---

# 1️⃣4️⃣ Understanding the Playbook

### Play Name

```yaml
- name: Install Nginx
```

This describes the purpose of the play.

### Hosts

```yaml
hosts: targets
```

This tells Ansible to run the play against the hosts defined inside the `targets` group in the inventory.

### Become

```yaml
become: yes
```

This allows Ansible to use elevated privileges.

### Install Nginx

```yaml
- name: Install Nginx
  apt:
    name: nginx
    state: present
    update_cache: yes
```

This installs Nginx using Ubuntu's APT package manager.

### Start Nginx

```yaml
- name: Start Nginx
  service:
    name: nginx
    state: started
    enabled: yes
```

This starts Nginx and enables it to start automatically.

---

# 1️⃣5️⃣ Run the Ansible Playbook

I executed my first playbook using:

```bash
ansible-playbook -i inventory install-nginx.yml
```

Ansible connected to the Target Server and executed the tasks.

The output showed:

```text
TASK [Install Nginx]
changed: [172.31.31.9]

TASK [Start Nginx]
ok: [172.31.31.9]
```

The playbook completed successfully.

### Playbook Flow

```text
Ansible Server
      │
      │ reads inventory
      ▼
  [targets]
      │
      │ 172.31.31.9
      ▼
Target Server
      │
      ├── Install Nginx
      │
      └── Start Nginx
```

---

# 1️⃣6️⃣ Final Ansible Files

After completing the practical, I had:

```text
Ansible/
├── install-nginx.yml
└── inventory
```

### inventory

```ini
[targets]
172.31.31.9
```

### install-nginx.yml

```yaml
---
- name: Install Nginx
  hosts: targets
  become: yes

  tasks:

    - name: Install Nginx
      apt:
        name: nginx
        state: present
        update_cache: yes

    - name: Start Nginx
      service:
        name: nginx
        state: started
        enabled: yes
```

---

# 1️⃣7️⃣ Clone My GitHub Repository

After completing the Ansible practical on EC2, I wanted to document and store my work in my GitHub repository.

My repository is:

```text
My-Devops-Cloud-Journey
```

I cloned the repository:

```bash
git clone https://github.com/Yuvi2102/My-Devops-Cloud-Journey.git
```

Then I entered the repository:

```bash
cd My-Devops-Cloud-Journey
```

I checked the repository:

```bash
git status
```

---

# 1️⃣8️⃣ Navigate to DevOps-Labs-and-Projects

Inside the repository, I navigated to:

```bash
cd DevOps-Labs-and-Projects
```

I created the Ansible directory:

```bash
mkdir -p Ansible
```

Then:

```bash
cd Ansible
```

The required GitHub structure was:

```text
My-Devops-Cloud-Journey/
└── DevOps-Labs-and-Projects/
    └── Ansible/
```

---

# 1️⃣9️⃣ Add the Ansible Files

I placed my completed Ansible files inside the GitHub repository:

```text
DevOps-Labs-and-Projects/
└── Ansible/
    ├── install-nginx.yml
    └── inventory
```

I verified the files:

```bash
ls
```

Output:

```text
install-nginx.yml
inventory
```

---

# 2️⃣0️⃣ Check Git Status

I checked the repository status:

```bash
git status
```

Git detected the new Ansible files.

The files were:

```text
new file: DevOps-Labs-and-Projects/Ansible/install-nginx.yml
new file: DevOps-Labs-and-Projects/Ansible/inventory
```

---

# 2️⃣1️⃣ Stage the Files

I added the Ansible files:

```bash
git add DevOps-Labs-and-Projects/Ansible/install-nginx.yml
git add DevOps-Labs-and-Projects/Ansible/inventory
```

Then I checked the status again:

```bash
git status
```

The files were now staged.

---

# 2️⃣2️⃣ Commit the Ansible Work

I created a Git commit:

```bash
git commit -m "Add Ansible Nginx playbook and inventory"
```

The commit was created successfully.

---

# 2️⃣3️⃣ Push to GitHub

Finally, I pushed the changes to the `main` branch:

```bash
git push origin main
```

The push completed successfully.

My Ansible work was now available in my GitHub repository.

---

# 2️⃣4️⃣ Final GitHub Structure

My repository now contains:

```text
My-Devops-Cloud-Journey/
│
├── README.md
│
├── My-Journey/
│
└── DevOps-Labs-and-Projects/
    │
    └── Ansible/
        │
        ├── install-nginx.yml
        └── inventory
```

---

# 🔄 Complete Hands-On Workflow

```text
AWS EC2
   │
   ▼
Create Ansible Server
   │
   ▼
Install Ansible
   │
   ▼
Generate SSH Key
   │
   ▼
Configure Target Server
   │
   ▼
Add Public Key using Vim
   │
   ▼
Test SSH Connection
   │
   ▼
Create Inventory using Vim
   │
   ▼
Run Ansible Ping
   │
   ▼
Run Ad-Hoc Commands
   │
   ├── whoami
   ├── hostname
   ├── ls
   ├── df
   └── free -h
   │
   ▼
Create install-nginx.yml using Vim
   │
   ▼
Run Ansible Playbook
   │
   ▼
Install Nginx
   │
   ▼
Start Nginx
   │
   ▼
Clone GitHub Repository
   │
   ▼
Add Ansible Files
   │
   ▼
git status
   │
   ▼
git add
   │
   ▼
git commit
   │
   ▼
git push
   │
   ▼
GitHub ✅
```

---

# 📚 Commands Practiced

### Ansible Installation

```bash
sudo apt update
sudo apt install ansible -y
ansible --version
```

### SSH

```bash
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub
ssh ubuntu@172.31.31.9
exit
```

### SSH Configuration

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
vim ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

### Inventory

```bash
vim inventory
cat inventory
```

### Ansible Ad-Hoc Commands

```bash
ansible -i inventory 172.31.31.9 -m ping
```

```bash
ansible -i inventory 172.31.31.9 -m command -a "whoami"
```

```bash
ansible -i inventory 172.31.31.9 -m command -a "hostname"
```

```bash
ansible -i inventory 172.31.31.9 -m command -a "ls"
```

```bash
ansible -i inventory 172.31.31.9 -m command -a "df"
```

```bash
ansible -i inventory 172.31.31.9 -m command -a "free -h"
```

### Playbook

```bash
vim install-nginx.yml
```

```bash
ansible-playbook -i inventory install-nginx.yml
```

### Git and GitHub

```bash
git clone https://github.com/Yuvi2102/My-Devops-Cloud-Journey.git
```

```bash
cd My-Devops-Cloud-Journey
```

```bash
git status
```

```bash
git add DevOps-Labs-and-Projects/Ansible/install-nginx.yml
```

```bash
git add DevOps-Labs-and-Projects/Ansible/inventory
```

```bash
git commit -m "Add Ansible Nginx playbook and inventory"
```

```bash
git push origin main
```

---

# 🎯 Key Takeaways

| Concept | What I Practiced |
|---|---|
| Ansible | Installed and configured Ansible |
| Control Node | Used an EC2 instance as the Ansible Server |
| Managed Node | Used an EC2 instance as the Target Server |
| SSH | Configured SSH communication |
| SSH Keys | Generated an RSA key pair |
| Vim | Created and edited configuration files |
| Inventory | Defined managed hosts |
| Ping Module | Tested Ansible connectivity |
| Command Module | Executed Linux commands remotely |
| Ad-Hoc Commands | Practiced remote command execution |
| Playbook | Created my first Ansible Playbook |
| APT Module | Installed Nginx |
| Service Module | Started and enabled Nginx |
| Git | Tracked Ansible files |
| GitHub | Published my Ansible work |
| DevOps | Practiced infrastructure automation |

---

# 🧠 What I Learned

Through this hands-on practice, I learned how Ansible works from the beginning.

I started by installing Ansible on an AWS EC2 instance and using another EC2 instance as the Target Server. I configured SSH authentication between the two servers using an RSA key pair.

I used **Vim** to create and edit my SSH configuration and Ansible inventory.

After establishing the connection, I practiced Ansible Ad-Hoc commands such as:

```text
ping
whoami
hostname
ls
df
free -h
```

This helped me understand how Ansible can remotely execute commands on managed servers.

After that, I created my first Ansible Playbook using Vim. The playbook automated the installation and startup of Nginx on the Target Server.

Finally, I cloned my GitHub repository, organized my Ansible files under `DevOps-Labs-and-Projects/Ansible`, committed the changes and pushed them to GitHub.

The complete practical workflow was:

```text
Install
   ↓
Configure SSH
   ↓
Create Inventory
   ↓
Test Connection
   ↓
Run Ad-Hoc Commands
   ↓
Create Playbook
   ↓
Install Nginx
   ↓
Verify
   ↓
Git
   ↓
GitHub
```

---

# 🏆 Final Result

```text
              ANSIBLE HANDS-ON COMPLETE
                       │
                       ▼
              ┌────────────────┐
              │ Ansible Server │
              │  Control Node  │
              └───────┬────────┘
                      │
                      │ SSH
                      ▼
              ┌────────────────┐
              │ Target Server  │
              │ Managed Node   │
              └───────┬────────┘
                      │
                      ▼
                Nginx Installed
                & Started
                      │
                      ▼
              ┌────────────────┐
              │     GitHub     │
              │                │
              │ DevOps-Labs-   │
              │ and-Projects/  │
              │     Ansible/   │
              │                │
              │ inventory      │
              │ install-nginx  │
              │     .yml       │
              └────────────────┘
```

<p align="center">

## 🎉 ANSIBLE HANDS-ON COMPLETE 🎉

**Learn → Practice → Automate → Document → Push**

</p>
