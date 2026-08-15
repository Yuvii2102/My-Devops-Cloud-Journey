<div align="center">

# DAY 01 — DevOps with Yuva

## Understanding DevOps

### `Build • Break • Fix • Repeat`

<br>

<img src="https://img.shields.io/badge/DEVOPS-JOURNEY-0A66C2?style=for-the-badge&logo=cloudflare&logoColor=white"/>
<img src="https://img.shields.io/badge/DAY-01-2962FF?style=for-the-badge"/>
<img src="https://img.shields.io/badge/STATUS-COMPLETED-2EA44F?style=for-the-badge"/>

</div>

---

## 🎯 Today's Goal

Today was the first day of documenting my DevOps journey.

I started with the basics:

> **What is DevOps? Why do we need it? And what problem does it solve?**

I didn't want to just memorize a definition.  
I wanted to understand the idea behind it.

---

## 🧠 What I Understood About DevOps

In simple words, **DevOps is about improving the way software is built and delivered.**

The main goals I understood are:

| Focus | What it means |
|---|---|
| 🚀 **Software Delivery** | Deliver software faster |
| 🤖 **Automation** | Reduce repetitive manual work |
| ✅ **Quality** | Maintain software quality |
| 🔄 **Testing** | Test continuously |
| 📊 **Monitoring** | Keep track of applications |
| 🛡️ **Reliability** | Make systems work consistently |

---

## 🔤 Where Does "DevOps" Come From?

```mermaid
flowchart LR
    A["👨‍💻 DEV<br/><br/>Development<br/><br/>Build Software"]
    --> C["🚀 DEVOPS<br/><br/>Better Collaboration<br/><br/>Reliable Delivery"]

    B["⚙️ OPS<br/><br/>Operations<br/><br/>Deploy & Maintain"]
    --> C
```

### 👨‍💻 Dev → Development

Developers are responsible for writing and building the application.

### ⚙️ Ops → Operations

Operations teams are responsible for deploying, managing, and maintaining applications.

DevOps brings these areas closer together so software can be delivered **faster and more reliably**.

---

## ⚙️ Why Do We Need DevOps?

One thing that became clear to me today is that **building an application is only one part of the process.**

The application also needs to be:

```mermaid
flowchart TD
    A["🔨 BUILD"]
    --> B["🧪 TEST"]
    --> C["🚀 DEPLOY"]
    --> D["🛠️ MAINTAIN"]
    --> E["📊 MONITOR"]
    --> F["💡 IMPROVE"]
    --> A
```

If these steps are done manually every time, the process can become slow and mistakes can happen.

This is where **automation and DevOps practices** become useful.

---

## 🤖 Automation

One simple example I used to understand automation was a **washing machine**.

You put the clothes in, select the required settings, and start it.

The machine performs the process automatically instead of requiring you to do every step manually.

In the same way, in DevOps we try to automate repetitive tasks wherever possible.

```mermaid
flowchart TD
    A["👨‍💻 MANUAL WORK"]
    --> B["🔁 REPETITIVE TASKS"]
    --> C["🤖 AUTOMATION"]
    --> D["📉 LESS MANUAL WORK"]
    --> E["⚡ FASTER PROCESS"]
    --> F["✅ FEWER MISTAKES"]
```

---

## 🔄 Reliability

I also learned the difference between something simply **working** and something being **reliable**.

For example, a clock is reliable when it consistently shows the correct time.

Similarly, an application should work correctly and consistently when users depend on it.

> **Reliability = A system working correctly and consistently.**

```mermaid
flowchart LR
    A["⚙️ SYSTEM"]
    --> B["✅ WORKS CORRECTLY"]
    --> C["🔄 WORKS CONSISTENTLY"]
    --> D["🛡️ RELIABLE SYSTEM"]
```

---

## 🏦 A Simple Example

I used a banking application as an example to understand this.

Imagine a banking application receives a new update.

The update should not simply be given to users immediately.

It needs to go through processes such as:

```mermaid
flowchart TD
    A["🆕 NEW UPDATE"]
    --> B["🧪 TESTING"]
    --> C["✅ QUALITY CHECKS"]
    --> D["🚀 DEPLOYMENT"]
    --> E["📊 MONITORING"]
```

If these processes are reliable and automated, the chances of problems reaching users can be reduced.

---

## ☁️ Before Cloud — What I Understood

I also started thinking about how applications were managed before cloud platforms became common.

A simplified flow I understood was:

```mermaid
flowchart TD
    A["👨‍💻 DEVELOPER"]
    --> B["🔨 BUILDS APPLICATION"]
    --> C["🖥️ SERVER"]
    --> D["🚀 APPLICATION DEPLOYED"]
    --> E["⚙️ SERVER ADMINISTRATOR"]
    --> F["🛠️ MANAGES SERVER"]
```

The server was needed because applications had to run somewhere outside the developer's personal machine, especially when testing or deploying them for others.

This also meant that different teams had responsibilities around the application and the infrastructure.

---

## 🔍 Something I Noticed

One interesting thing I understood today was the shift from larger separate responsibilities toward teams working more closely together.

Instead of development and operations working completely separately, **DevOps encourages better collaboration between them.**

The goal is simple:

> **Improve the process of delivering software.**

```mermaid
flowchart LR
    A["👨‍💻 DEVELOPMENT"]
    --> C["🤝 COLLABORATION"]
    B["⚙️ OPERATIONS"]
    --> C
    C --> D["🚀 BETTER SOFTWARE DELIVERY"]
```

---

## 📸 My Day 01 Notes

These are the handwritten notes I made while learning the fundamentals.

### 📝 DevOps Fundamentals

<p align="center">
  <img src="./images/day-01-devops-fundamentals.jpg" width="750"/>
</p>

---

## 💡 What I Learned Today

My biggest takeaway from Day 1:

> **DevOps is not just a list of tools.**

Before learning tools, I need to understand why those tools exist and what problems they solve.

Today I understood three important ideas:

### 🤖 Automation

**Reduce repetitive manual work.**

```mermaid
flowchart LR
    A["🔁 Repetitive Work"]
    --> B["🤖 Automation"]
    --> C["⚡ Faster & Easier"]
```

### 🔄 Reliability

**Make systems work correctly and consistently.**

```mermaid
flowchart LR
    A["⚙️ System"]
    --> B["✅ Correct"]
    --> C["🔄 Consistent"]
    --> D["🛡️ Reliable"]
```

### 🚀 DevOps

**Improve the overall process of building and delivering software.**

```mermaid
flowchart LR
    A["💡 Build"]
    --> B["🧪 Test"]
    --> C["🚀 Deploy"]
    --> D["📊 Monitor"]
    --> E["💡 Improve"]
    --> A
```

---

## 🧠 My Simple Mental Model

The easiest way I remember Day 1:

```mermaid
flowchart TD
    A["💡 SOFTWARE IDEA"]
    --> B["👨‍💻 DEVELOPMENT"]
    --> C["🤝 DEV + OPS"]
    --> D["🤖 AUTOMATION"]
    --> E["🧪 TESTING"]
    --> F["🚀 DEPLOYMENT"]
    --> G["📊 MONITORING"]
    --> H["🛡️ RELIABILITY"]
    --> I["💡 CONTINUOUS IMPROVEMENT"]
    --> B
```

> **DevOps = Collaboration + Automation + Reliability + Continuous Improvement**

---

<div align="center">

# 🚀 DAY 01 COMPLETE

### `Build • Break • Fix • Repeat`

**Learning → Practicing → Documenting**

<br>

`Development → Operations → Automation → Deployment → Monitoring → Improvement`

<br>

📌 **More coming tomorrow...**

**DAY 02 → SDLC • HLD • LLD**

</div>
