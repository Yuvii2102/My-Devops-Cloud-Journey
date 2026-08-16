<div align="center">

## DAY 08 — ANSIBLE & CONFIGURATION MANAGEMENT

### ⚙️ Automate Infrastructure • Manage Servers • Scale Operations

</div>

---

# 🧭 DAY 08 ROADMAP

```mermaid
flowchart LR
    A["⚙️ Configuration Management"]
    B["🤖 Ansible"]
    C["🏗️ Ansible Architecture"]
    D["🔄 Master-Agent vs Agentless"]
    E["📤 Push Model"]
    F["📥 Pull Model"]
    G["📋 Playbooks"]
    H["🗂️ Inventory"]
    I["🔐 SSH"]
    J["☁️ AWS EC2"]
    K["🚀 Automation"]

    A --> B
    B --> C
    C --> D
    D --> E
    D --> F
    B --> G
    B --> H
    B --> I
    I --> J
    G --> K
    H --> K
    J --> K
```

---

# ⚙️ 01 — CONFIGURATION MANAGEMENT

## 📚 What I Learned

**Configuration Management (CM)** is the process of managing the configuration of servers and infrastructure automatically.

Imagine a company has:

```text
🏢 Company
   │
   ├── 🖥️ Server 1
   ├── 🖥️ Server 2
   ├── 🖥️ Server 3
   ├── 🖥️ Server 4
   └── 🖥️ Server 5
```

As infrastructure grows:

```text
5 Servers
    ↓
50 Servers
    ↓
500 Servers
    ↓
1000 Servers
```

Every server may need:

- 🐧 Latest OS updates
- 🔐 Security patches
- 🐳 Docker
- 📦 Git
- ⚙️ Software installation
- 🔧 Configuration updates
- 🚀 Application deployment

Doing all of this manually becomes difficult and time-consuming.

Therefore, we use **Configuration Management**.

---

# ❌ WITHOUT CONFIGURATION MANAGEMENT

Before Configuration Management, an administrator might have to manually connect to every server.

```text
SSH → Server 1 → Install Git
SSH → Server 2 → Install Git
SSH → Server 3 → Install Git
SSH → Server 4 → Install Git
SSH → Server 5 → Install Git
        .
        .
        .
SSH → Server 500 → Install Git
```

### 🚨 Problems

- ⏳ Time-consuming
- 👤 Human errors
- 🔁 Repetitive work
- 📈 Difficult to scale
- 🐛 Different configurations between servers

---

# ✅ WITH CONFIGURATION MANAGEMENT

Instead of manually configuring every server:

```mermaid
flowchart LR
    ADMIN["👨‍💻 Administrator"]
    CONFIG["📝 Configuration"]
    TOOL["⚙️ Configuration Management"]
    SERVERS["🖥️ Multiple Servers"]

    ADMIN --> CONFIG
    CONFIG --> TOOL
    TOOL --> SERVERS
```

One configuration can be applied across many servers automatically.

---

# 🤖 02 — WHAT IS ANSIBLE?

**Ansible** is an automation and configuration-management tool used to automate tasks across multiple servers.

It can automate:

- 📦 Software installation
- 🔄 Package updates
- ⚙️ Server configuration
- 📁 File management
- 🚀 Application deployment
- 🖥️ Server administration
- 🔐 Remote execution
- 🔁 Repetitive tasks

### 🧠 Simple Definition

> **Ansible allows us to automate the configuration and management of multiple servers from one controller.**

---

# 🏗️ 03 — ANSIBLE ARCHITECTURE

The basic Ansible architecture is:

```text
🤖 Ansible Controller
          ↓
        🔐 SSH
          ↓
   🖥️ Managed Servers
```

```mermaid
flowchart TD
    ADMIN["👨‍💻 DevOps Engineer"]
    CONTROLLER["🤖 Ansible Controller"]
    SSH["🔐 SSH"]

    S1["🖥️ Server 1"]
    S2["🖥️ Server 2"]
    S3["🖥️ Server 3"]

    ADMIN --> CONTROLLER
    CONTROLLER --> SSH
    SSH --> S1
    SSH --> S2
    SSH --> S3
```

### 🔑 Key Idea

```text
Ansible Controller
        ↓
       SSH
        ↓
Managed Servers
```

---

# 🏢 04 — TRADITIONAL MASTER-AGENT MODEL

Some Configuration Management systems use a **Master-Agent architecture**.

```mermaid
flowchart TD
    MASTER["🧠 Master Server"]

    A1["🤖 Agent — Server 1"]
    A2["🤖 Agent — Server 2"]
    A3["🤖 Agent — Server 3"]

    MASTER --> A1
    MASTER --> A2
    MASTER --> A3
```

### 📌 How it works

```text
Master Server
      ↓
   Agent 1
   Agent 2
   Agent 3
      ↓
Managed Servers
```

In this model, agent software is installed on the managed servers.

---

# 🤖 05 — ANSIBLE AGENTLESS MODEL

Ansible uses an **agentless approach** for common Linux/Unix management.

Instead of installing an Ansible agent on every server:

```mermaid
flowchart TD
    CONTROLLER["🤖 Ansible Controller"]
    SSH["🔐 SSH"]

    S1["🖥️ Server 1"]
    S2["🖥️ Server 2"]
    S3["🖥️ Server 3"]

    CONTROLLER --> SSH
    SSH --> S1
    SSH --> S2
    SSH --> S3
```

### 🔑 Main Idea

```text
No Ansible Agent
        ↓
Ansible Controller
        ↓
       SSH
        ↓
Managed Servers
```

---

# ⚔️ 06 — MASTER-AGENT VS AGENTLESS

| Feature | 🏢 Master-Agent | 🤖 Ansible Agentless |
|---|---|---|
| Architecture | Master + Agents | Controller + Remote Connection |
| Agent installation | Required | Not required for common SSH-based Linux management |
| Communication | Master ↔ Agents | Controller → SSH → Servers |
| Setup | More components | Simpler |
| Linux management | Agent-based | SSH-based |
| Automation | Yes | Yes |

---

# 📤 07 — PUSH MODEL

In the **Push Model**, the controller pushes configuration and tasks to the managed servers.

```mermaid
flowchart LR
    CONTROLLER["🤖 Ansible Controller"]
    PUSH["📤 PUSH"]

    S1["🖥️ Server 1"]
    S2["🖥️ Server 2"]
    S3["🖥️ Server 3"]

    CONTROLLER --> PUSH
    PUSH --> S1
    PUSH --> S2
    PUSH --> S3
```

### Example

```text
Controller
     │
     ├── 📤 Install Git → Server 1
     ├── 📤 Install Git → Server 2
     └── 📤 Install Git → Server 3
```

The controller tells the servers what needs to be done.

---

# 📥 08 — PULL MODEL

In the **Pull Model**, managed systems obtain their configuration from a central source.

```mermaid
flowchart LR
    SERVER["🖥️ Managed Server"]
    CENTRAL["🧠 Central System"]
    CONFIG["📦 Configuration"]

    SERVER -->|"Request"| CENTRAL
    CENTRAL --> CONFIG
    CONFIG --> SERVER
```

### Simple Difference

```text
📤 PUSH
Controller → Servers

📥 PULL
Servers → Central System
```

---

# 📋 09 — ANSIBLE PLAYBOOK

A **Playbook** contains the tasks that Ansible should perform.

Playbooks are written using **YAML**.

```text
📋 Playbook
     ↓
⚙️ Tasks
     ↓
🤖 Ansible
     ↓
🔐 SSH
     ↓
🖥️ Managed Servers
```

### Example

```yaml
- name: Install Git
  hosts: all

  tasks:
    - name: Install Git
      package:
        name: git
        state: present
```

### 🧠 Remember

**Playbook = What should Ansible do?**

---

# 🗂️ 10 — ANSIBLE INVENTORY

The **Inventory** tells Ansible which servers it needs to manage.

Example:

```ini
[webservers]
server1
server2
server3
```

Or:

```ini
[webservers]
192.168.1.10
192.168.1.11
192.168.1.12
```

```mermaid
flowchart TD
    INVENTORY["🗂️ Ansible Inventory"]

    INVENTORY --> S1["🖥️ Server 1"]
    INVENTORY --> S2["🖥️ Server 2"]
    INVENTORY --> S3["🖥️ Server 3"]
```

### 🧠 Remember

**Inventory = On which servers should the tasks run?**

---

# 🔄 11 — DYNAMIC INVENTORY

In cloud environments, servers can be created and removed dynamically.

For example:

```text
☁️ AWS
   ↓
🖥️ EC2 Instances
   ↓
➕ New Instances
➖ Removed Instances
   ↓
🔄 Dynamic Inventory
```

```mermaid
flowchart LR
    AWS["☁️ AWS"]
    EC2["🖥️ EC2 Instances"]
    DI["🔄 Dynamic Inventory"]
    ANSIBLE["🤖 Ansible"]

    AWS --> EC2
    EC2 --> DI
    DI --> ANSIBLE
```

Dynamic inventory helps Ansible work with changing infrastructure.

---

# 🔐 12 — SSH AUTHENTICATION

Ansible commonly uses **SSH** to connect to Linux servers.

```text
🤖 Ansible Controller
          ↓
        🔐 SSH
          ↓
   🖥️ Linux Server
```

SSH keys can be used for authentication.

```text
Client
 ├── 🔑 Private Key
 └── 🔓 Public Key

Server
 └── 🔓 Authorized Public Key
```

### 🔐 Important

The **private key must be kept secure**.

---

# 🔑 13 — PASSWORDLESS SSH

With SSH key-based authentication, Ansible can connect to servers without requiring an interactive password every time.

```mermaid
sequenceDiagram
    participant C as 🤖 Ansible Controller
    participant S as 🖥️ Server

    C->>S: SSH Connection
    S->>C: Authentication Request
    C->>S: SSH Key Authentication
    S-->>C: Access Granted
```

---

# 🐍 14 — ANSIBLE & PYTHON

Ansible is built using **Python** and has a Python-based ecosystem.

Python can also be used for custom modules and automation requirements.

```mermaid
flowchart LR
    PYTHON["🐍 Python"]
    ANSIBLE["🤖 Ansible"]
    MODULES["🧩 Modules"]
    AUTOMATION["⚡ Automation"]

    PYTHON --> ANSIBLE
    ANSIBLE --> MODULES
    MODULES --> AUTOMATION
```

---

# ⚡ 15 — ANSIBLE ADVANTAGES

- ✅ Agentless approach
- ✅ SSH-based Linux management
- ✅ Automation
- ✅ Reusable Playbooks
- ✅ Human-readable YAML
- ✅ Can manage many servers
- ✅ Useful for cloud environments
- ✅ Python-based ecosystem
- ✅ Reduces repetitive manual work
- ✅ Helps maintain consistent configurations

---

# ⚠️ 16 — CHALLENGES

- 🪟 Windows environments may require different connection mechanisms
- 🐛 Failed Playbooks require troubleshooting
- 📈 Large-scale environments can introduce operational and performance challenges
- 🔐 SSH credentials and keys must be handled securely

---

# ☁️ 17 — ANSIBLE WITH AWS EC2

Ansible can be used to automate configuration across EC2 instances.

Imagine:

```text
☁️ AWS
 │
 ├── 🖥️ EC2-1
 ├── 🖥️ EC2-2
 ├── 🖥️ EC2-3
 ├── 🖥️ EC2-4
 └── 🖥️ EC2-5
```

Instead of manually connecting to every instance:

```mermaid
flowchart TD
    ADMIN["👨‍💻 DevOps Engineer"]
    PLAYBOOK["📋 Playbook"]
    INVENTORY["🗂️ Inventory"]
    ANSIBLE["🤖 Ansible Controller"]
    SSH["🔐 SSH"]
    EC2["☁️ AWS EC2 Instances"]

    ADMIN --> PLAYBOOK
    ADMIN --> INVENTORY

    PLAYBOOK --> ANSIBLE
    INVENTORY --> ANSIBLE

    ANSIBLE --> SSH
    SSH --> EC2
```

Ansible can automate the configuration across multiple EC2 instances.

---

# 🏢 18 — REAL-WORLD EXAMPLE

Suppose there are **20 EC2 instances**.

Every server needs:

```text
📦 Git
🐳 Docker
🔧 Configuration
📦 Packages
🚀 Application
```

### ❌ Manual Approach

```text
SSH → EC2 #1 → Configure
SSH → EC2 #2 → Configure
SSH → EC2 #3 → Configure
...
SSH → EC2 #20 → Configure
```

### ✅ Ansible Approach

```mermaid
flowchart TD
    ADMIN["👨‍💻 DevOps Engineer"]

    PLAYBOOK["📋 PLAYBOOK"]
    INVENTORY["🗂️ INVENTORY"]

    ANSIBLE["🤖 ANSIBLE"]
    SSH["🔐 SSH"]
    EC2["☁️ EC2 SERVERS"]
    AUTOMATION["🚀 AUTOMATION"]

    ADMIN --> PLAYBOOK
    ADMIN --> INVENTORY

    PLAYBOOK --> ANSIBLE
    INVENTORY --> ANSIBLE

    ANSIBLE --> SSH
    SSH --> EC2
    EC2 --> AUTOMATION
```

---

# 🔄 19 — COMPLETE ANSIBLE WORKFLOW

```mermaid
flowchart LR
    DEV["👨‍💻 DevOps Engineer"]

    PLAYBOOK["📋 Playbook<br/>What to do?"]
    INVENTORY["🗂️ Inventory<br/>Where to do it?"]

    CONTROLLER["🤖 Ansible Controller"]
    SSH["🔐 SSH"]
    SERVERS["🖥️ Managed Servers"]
    TASKS["⚙️ Execute Tasks"]

    DEV --> PLAYBOOK
    DEV --> INVENTORY

    PLAYBOOK --> CONTROLLER
    INVENTORY --> CONTROLLER

    CONTROLLER --> SSH
    SSH --> SERVERS
    SERVERS --> TASKS
```

---

# 🧠 20 — THE 3 THINGS TO REMEMBER

```text
📋 PLAYBOOK
     ↓
WHAT should be done?

🗂️ INVENTORY
     ↓
WHERE should it be done?

🔐 SSH
     ↓
HOW does Ansible connect?
```

Together:

```mermaid
flowchart TD
    PLAYBOOK["📋 PLAYBOOK<br/>What?"]
    INVENTORY["🗂️ INVENTORY<br/>Where?"]
    SSH["🔐 SSH<br/>How?"]

    PLAYBOOK --> ANSIBLE["🤖 ANSIBLE"]
    INVENTORY --> ANSIBLE
    SSH --> ANSIBLE

    ANSIBLE --> SERVERS["🖥️ MANAGED SERVERS"]
```

---

# 🏆 DAY 08 — COMPLETE CONCEPT MAP

```mermaid
mindmap
  root((🤖 ANSIBLE))
    ⚙️ Configuration Management
      Automation
      Server Configuration
      Software Installation
      Updates
    🏗️ Architecture
      Controller
      Managed Servers
      SSH
    🏢 Master-Agent
      Master
      Agents
    🤖 Agentless
      No Agent
      SSH
      Controller
    📤 Push Model
      Controller
      Servers
    📥 Pull Model
      Servers
      Central System
    📋 Playbook
      YAML
      Tasks
    🗂️ Inventory
      Hosts
      Groups
      Dynamic Inventory
    🔐 SSH
      Authentication
      SSH Keys
      Private Key
      Public Key
    ☁️ AWS
      EC2
      Cloud Automation
    🐍 Python
      Ansible Ecosystem
      Modules
```

---

# 🔥 DAY 08 IN ONE FLOW

```mermaid
flowchart LR
    CONFIG["⚙️ Configuration Management"]
    ANSIBLE["🤖 Ansible"]
    PLAYBOOK["📋 Playbook"]
    INVENTORY["🗂️ Inventory"]
    SSH["🔐 SSH"]
    SERVERS["☁️ Managed Servers"]
    AUTO["🚀 Automated Configuration"]

    CONFIG --> ANSIBLE
    ANSIBLE --> PLAYBOOK
    ANSIBLE --> INVENTORY
    PLAYBOOK --> SSH
    INVENTORY --> SSH
    SSH --> SERVERS
    SERVERS --> AUTO
```

---

<div align="center">

# 🚀 DAY 08 COMPLETE

## 🤖 CONFIGURATION MANAGEMENT → ANSIBLE → PLAYBOOK → INVENTORY → SSH → AUTOMATION

### `LEARN → PRACTICE → AUTOMATE → SCALE`

**☁️ DevOps Cloud Journey**

</div>
