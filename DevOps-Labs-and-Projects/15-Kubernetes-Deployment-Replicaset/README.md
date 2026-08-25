# ☸️ DAY 15 — KUBERNETES DEPLOYMENT | REPLICASET | POD SELF-HEALING

<p align="center">

<img src="https://img.shields.io/badge/Kubernetes-Deployment-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white"/>
<img src="https://img.shields.io/badge/ReplicaSet-Management-6A5ACD?style=for-the-badge&logo=kubernetes&logoColor=white"/>
<img src="https://img.shields.io/badge/Pods-Self--Healing-2496ED?style=for-the-badge&logo=kubernetes&logoColor=white"/>
<img src="https://img.shields.io/badge/NGINX-Application-009639?style=for-the-badge&logo=nginx&logoColor=white"/>

</p>

<p align="center">
  <b>Deploying an NGINX Application Using Kubernetes Deployment & ReplicaSet</b>
</p>

<p align="center">
  <i>DevOps Cloud Journey — Day 34 🚀</i>
</p>

---

# 🎯 OBJECTIVE

In **Day 33**, I created a single NGINX Pod directly using a Kubernetes Pod YAML file.

In Day 34, I moved to the next important Kubernetes concept:

> **Kubernetes Deployment**

The main goal of this hands-on lab was to understand:

- How a Deployment manages Pods
- How a Deployment creates a ReplicaSet
- How a ReplicaSet manages multiple Pods
- How replicas work
- What happens when a Pod is deleted
- How Kubernetes automatically creates a replacement Pod
- How Kubernetes provides self-healing

The main practical test was:

> **If I delete a Pod managed by a Deployment, will Kubernetes create another Pod automatically?**

The answer was:

> **Yes. Kubernetes automatically created a replacement Pod to maintain the desired number of replicas.**

---

# 🧠 WHAT I LEARNED

During this hands-on lab, I learned:

- ☸️ Kubernetes Deployment
- 🔁 ReplicaSet
- 📦 Multiple Pods
- 🔢 Replicas
- ❤️ Self-healing
- 🔄 Pod replacement
- 👀 Watching Pods in real time
- 🔍 Checking Deployments
- 🔍 Checking ReplicaSets
- 🗑️ Deleting Pods
- 🧠 Desired state
- 🔄 Kubernetes reconciliation

---

# ☸️ WHAT IS A KUBERNETES DEPLOYMENT?

A **Deployment** is a Kubernetes resource used to manage an application and its Pods.

Instead of manually creating multiple Pods, we can tell Kubernetes how many replicas we want.

For example:

```yaml
replicas: 3
```

means:

```text
Keep 3 Pods running.
```

The Deployment manages a ReplicaSet, and the ReplicaSet manages the Pods.

### Deployment relationship

```mermaid
flowchart TD
    A["☸️ Deployment<br/>nginx-deployment"] --> B["🔁 ReplicaSet"]
    B --> C["📦 Pod 1"]
    B --> D["📦 Pod 2"]
    B --> E["📦 Pod 3"]

    C --> F["🐳 NGINX"]
    D --> G["🐳 NGINX"]
    E --> H["🐳 NGINX"]

    style A fill:#326CE5,color:#fff
    style B fill:#6A5ACD,color:#fff
    style C fill:#009639,color:#fff
    style D fill:#009639,color:#fff
    style E fill:#009639,color:#fff
    style F fill:#2496ED,color:#fff
    style G fill:#2496ED,color:#fff
    style H fill:#2496ED,color:#fff
```

---

# 🔁 WHAT IS A REPLICASET?

A **ReplicaSet** is responsible for maintaining the required number of Pods.

For example:

```text
Desired Pods = 3
Current Pods = 3
```

Everything is correct.

But if one Pod is deleted:

```text
Desired Pods = 3
Current Pods = 2
```

The ReplicaSet detects that one Pod is missing.

It creates a new Pod.

```mermaid
flowchart LR
    A["Desired<br/>3 Pods"] --> B["🔁 ReplicaSet<br/>Checks State"]
    B --> C["Current<br/>3 Pods"]
    C --> D["✅ State Matches"]

    E["🗑️ Pod Deleted"] --> F["Current<br/>2 Pods"]
    F --> B
    B --> G["➕ Create Replacement Pod"]
    G --> H["Current<br/>3 Pods"]

    style A fill:#326CE5,color:#fff
    style C fill:#009639,color:#fff
    style D fill:#2E8B57,color:#fff
    style E fill:#D9534F,color:#fff
    style F fill:#D9534F,color:#fff
    style G fill:#F0AD4E,color:#000
    style H fill:#009639,color:#fff
```

---

# 🏗️ DEPLOYMENT ARCHITECTURE

The important Kubernetes relationship is:

```text
Deployment
    ↓
ReplicaSet
    ↓
Pods
    ↓
Containers
```

### Complete Architecture

```mermaid
flowchart TB
    U["👨‍💻 User<br/>kubectl"] --> D["☸️ Deployment<br/>nginx-deployment"]

    D --> R["🔁 ReplicaSet<br/>nginx-deployment-77bc6bd484"]

    R --> P1["📦 Pod 1"]
    R --> P2["📦 Pod 2"]
    R --> P3["📦 Pod 3"]

    P1 --> C1["🐳 NGINX"]
    P2 --> C2["🐳 NGINX"]
    P3 --> C3["🐳 NGINX"]

    style U fill:#333,color:#fff
    style D fill:#326CE5,color:#fff
    style R fill:#6A5ACD,color:#fff
    style P1 fill:#009639,color:#fff
    style P2 fill:#009639,color:#fff
    style P3 fill:#009639,color:#fff
    style C1 fill:#2496ED,color:#fff
    style C2 fill:#2496ED,color:#fff
    style C3 fill:#2496ED,color:#fff
```

---

# 📝 DEPLOYMENT YAML

I created the Deployment YAML file using:

```bash
vim deployment.yml
```

The Deployment configuration used in the lab:

```yaml
apiVersion: apps/v1
kind: Deployment

metadata:
  name: nginx-deployment

spec:
  replicas: 3

  selector:
    matchLabels:
      app: nginx

  template:
    metadata:
      labels:
        app: nginx

    spec:
      containers:
        - name: nginx
          image: nginx:1.14.2
          ports:
            - containerPort: 80
```

---

# 🔍 UNDERSTANDING THE DEPLOYMENT YAML

## 1️⃣ `apiVersion`

```yaml
apiVersion: apps/v1
```

This specifies the Kubernetes API version used for the Deployment.

---

## 2️⃣ `kind`

```yaml
kind: Deployment
```

This tells Kubernetes:

```text
Create a Deployment.
```

---

## 3️⃣ `metadata`

```yaml
metadata:
  name: nginx-deployment
```

This gives the Deployment the name:

```text
nginx-deployment
```

---

## 4️⃣ `replicas`

```yaml
replicas: 3
```

This is one of the most important parts.

It tells Kubernetes:

```text
Maintain 3 Pods.
```

---

## 5️⃣ `selector`

```yaml
selector:
  matchLabels:
    app: nginx
```

The Deployment uses:

```text
app: nginx
```

to identify the Pods that belong to it.

---

## 6️⃣ Pod Template

```yaml
template:
  metadata:
    labels:
      app: nginx
```

This defines the labels that will be given to the Pods.

Each Pod gets:

```text
app: nginx
```

---

## 7️⃣ Container

```yaml
containers:
  - name: nginx
    image: nginx:1.14.2
```

Each Pod runs an NGINX container using:

```text
nginx:1.14.2
```

---

## 8️⃣ Container Port

```yaml
ports:
  - containerPort: 80
```

NGINX uses:

```text
Port 80
```

---

# 🚀 CREATE THE DEPLOYMENT

After creating `deployment.yml`, I created the Deployment using:

```bash
kubectl create -f deployment.yml
```

Expected output:

```text
deployment.apps/nginx-deployment created
```

This means the Deployment was successfully created.

---

# 🔎 CHECK THE DEPLOYMENT

To check the Deployment:

```bash
kubectl get deploy
```

The output was similar to:

```text
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   3/3     3            3           ...
```

### Understanding the output

| Column | Meaning |
|---|---|
| NAME | Deployment name |
| READY | Ready replicas / desired replicas |
| UP-TO-DATE | Pods using the current configuration |
| AVAILABLE | Available Pods |
| AGE | Deployment age |

The important result was:

```text
READY = 3/3
```

This means:

```text
Desired Pods = 3
Ready Pods   = 3
```

---

# 📦 CHECK THE PODS

I checked the Pods using:

```bash
kubectl get pods
```

The output showed three NGINX Pods similar to:

```text
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-77bc6bd484-tgnd    1/1     Running   0          ...
nginx-deployment-77bc6bd484-lgk6c    1/1     Running   0          ...
nginx-deployment-77bc6bd484-vphnk    1/1     Running   0          ...
```

All three Pods were:

```text
1/1
Running
0 restarts
```

### Visual representation

```mermaid
flowchart LR
    D["☸️ nginx-deployment"] --> R["🔁 ReplicaSet"]

    R --> P1["📦 Pod<br/>1/1 Running"]
    R --> P2["📦 Pod<br/>1/1 Running"]
    R --> P3["📦 Pod<br/>1/1 Running"]

    style D fill:#326CE5,color:#fff
    style R fill:#6A5ACD,color:#fff
    style P1 fill:#009639,color:#fff
    style P2 fill:#009639,color:#fff
    style P3 fill:#009639,color:#fff
```

---

# 🔁 CHECK THE REPLICASET

To check the ReplicaSet:

```bash
kubectl get rs
```

The output was similar to:

```text
NAME                       DESIRED   CURRENT   READY   AGE
nginx-deployment-77bc6bd484   3        3        3      ...
```

This shows:

```text
DESIRED = 3
CURRENT = 3
READY   = 3
```

So the ReplicaSet was successfully maintaining three Pods.

---

# 🧠 WHAT HAPPENED BEHIND THE SCENES?

When I executed:

```bash
kubectl create -f deployment.yml
```

Kubernetes created the following relationship:

```mermaid
flowchart TD
    A["📄 deployment.yml"] --> B["kubectl create"]
    B --> C["☸️ Deployment"]
    C --> D["🔁 ReplicaSet"]
    D --> E["📦 Pod 1"]
    D --> F["📦 Pod 2"]
    D --> G["📦 Pod 3"]

    style A fill:#333,color:#fff
    style B fill:#555,color:#fff
    style C fill:#326CE5,color:#fff
    style D fill:#6A5ACD,color:#fff
    style E fill:#009639,color:#fff
    style F fill:#009639,color:#fff
    style G fill:#009639,color:#fff
```

I only specified:

```yaml
replicas: 3
```

Kubernetes automatically created and managed the three Pods.

---

# 🗑️ DELETE A POD

Now I tested Kubernetes self-healing.

First, I checked the Pods:

```bash
kubectl get pods
```

Then I selected one Pod and deleted it:

```bash
kubectl delete pod <pod-name>
```

For example:

```bash
kubectl delete pod nginx-deployment-77bc6bd484-68w77
```

Kubernetes returned:

```text
pod "nginx-deployment-77bc6bd484-68w77" deleted from default namespace
```

The Pod was successfully deleted.

---

# 👀 WATCH POD CHANGES

To see what Kubernetes does after deleting the Pod, I used:

```bash
kubectl get pods -w
```

The `-w` means:

```text
watch
```

Instead of displaying the Pods once, Kubernetes continuously watches for changes.

This allowed me to see the Pod replacement happening in real time.

---

# ❤️ KUBERNETES SELF-HEALING

This was the main concept demonstrated in this lab.

Before deleting a Pod:

```text
Pod A ✅
Pod B ✅
Pod C ✅

Total = 3
```

After deleting Pod B:

```text
Pod A ✅
Pod B ❌
Pod C ✅

Total = 2
```

The ReplicaSet detects:

```text
Desired = 3
Current = 2
```

Then it creates another Pod.

```text
Pod A ✅
Pod C ✅
Pod D 🆕

Total = 3
```

### Self-Healing Flow

```mermaid
flowchart TD
    A["🟢 3 Pods Running"] --> B["🗑️ Delete One Pod"]
    B --> C["🔴 Pod Terminates"]
    C --> D["🔁 ReplicaSet Detects<br/>Only 2 Pods"]
    D --> E["➕ Create Replacement Pod"]
    E --> F["🟡 Pending"]
    F --> G["🟠 ContainerCreating"]
    G --> H["🟢 Running"]
    H --> I["✅ 3 Pods Restored"]

    style A fill:#009639,color:#fff
    style B fill:#D9534F,color:#fff
    style C fill:#D9534F,color:#fff
    style D fill:#6A5ACD,color:#fff
    style E fill:#F0AD4E,color:#000
    style F fill:#F0AD4E,color:#000
    style G fill:#F0AD4E,color:#000
    style H fill:#009639,color:#fff
    style I fill:#2E8B57,color:#fff
```

---

# 🔄 WHAT HAPPENS AFTER POD DELETION?

The process is:

```text
1. Pod is running
        ↓
2. Pod is manually deleted
        ↓
3. ReplicaSet notices the Pod is missing
        ↓
4. Current replicas become 2
        ↓
5. Desired replicas are still 3
        ↓
6. ReplicaSet creates a new Pod
        ↓
7. New Pod becomes Pending
        ↓
8. Container is created
        ↓
9. New Pod becomes Running
        ↓
10. Replica count returns to 3
```

### Mermaid Flow

```mermaid
flowchart TD
    A["📦 Pod Running"] --> B["🗑️ Delete Pod"]
    B --> C["Current Replicas = 2"]
    C --> D["ReplicaSet compares state"]
    D --> E{"Desired = 3?"}
    E -->|Yes| F["➕ Create New Pod"]
    F --> G["🟡 Pending"]
    G --> H["🟠 ContainerCreating"]
    H --> I["🟢 Running"]
    I --> J["Current Replicas = 3"]
    J --> K["✅ Desired State Restored"]

    style A fill:#009639,color:#fff
    style B fill:#D9534F,color:#fff
    style C fill:#D9534F,color:#fff
    style D fill:#6A5ACD,color:#fff
    style E fill:#F0AD4E,color:#000
    style F fill:#F0AD4E,color:#000
    style G fill:#F0AD4E,color:#000
    style H fill:#F0AD4E,color:#000
    style I fill:#009639,color:#fff
    style J fill:#009639,color:#fff
    style K fill:#2E8B57,color:#fff
```

---

# ⚠️ IMPORTANT — THE OLD POD IS NOT RESTORED

Kubernetes does **not** bring back the exact deleted Pod.

Instead, Kubernetes creates a **new Pod**.

For example:

```text
Before:

nginx-deployment-77bc6bd484-68w77
nginx-deployment-77bc6bd484-5ptzl
nginx-deployment-77bc6bd484-c8bsm
```

Delete:

```text
nginx-deployment-77bc6bd484-68w77
```

After replacement:

```text
nginx-deployment-77bc6bd484-5ptzl
nginx-deployment-77bc6bd484-c8bsm
nginx-deployment-77bc6bd484-mcrg8
```

The replacement Pod has a different name.

But:

```text
Desired replicas = 3
Current replicas = 3
```

---

# 🔄 POD LIFECYCLE OBSERVED

While running:

```bash
kubectl get pods -w
```

I observed Pod states such as:

```text
Pending
ContainerCreating
Running
Terminating
Completed
```

### Replacement Pod

```mermaid
flowchart LR
    A["🟡 Pending"] --> B["🟠 ContainerCreating"]
    B --> C["🟢 Running"]

    style A fill:#F0AD4E,color:#000
    style B fill:#F0AD4E,color:#000
    style C fill:#009639,color:#fff
```

### Deleted Pod

```mermaid
flowchart LR
    A["🟢 Running"] --> B["🔴 Terminating"]
    B --> C["⚫ Removed"]

    style A fill:#009639,color:#fff
    style B fill:#D9534F,color:#fff
    style C fill:#333,color:#fff
```

---

# 🔥 REPEATED SELF-HEALING TEST

I repeated the Pod deletion test multiple times.

The process was:

```bash
kubectl get pods
```

Then:

```bash
kubectl delete pod <pod-name>
```

Then:

```bash
kubectl get pods -w
```

Each time, Kubernetes created a replacement Pod.

### Repeated Test Flow

```mermaid
flowchart TD
    A["3 Pods Running"] --> B["🗑️ Delete Pod"]
    B --> C["2 Pods"]
    C --> D["ReplicaSet Detects Difference"]
    D --> E["➕ New Pod Created"]
    E --> F["3 Pods Running"]
    F --> G{"Delete Another Pod?"}
    G -->|Yes| B
    G -->|No| H["✅ Test Complete"]

    style A fill:#009639,color:#fff
    style B fill:#D9534F,color:#fff
    style C fill:#D9534F,color:#fff
    style D fill:#6A5ACD,color:#fff
    style E fill:#F0AD4E,color:#000
    style F fill:#009639,color:#fff
    style H fill:#2E8B57,color:#fff
```

---

# 🆚 DIRECT POD VS DEPLOYMENT

This is one of the most important comparisons from the lab.

## 📦 Direct Pod

When we create a Pod directly:

```mermaid
flowchart TD
    A["👨‍💻 User"] --> B["📦 Pod"]
    B --> C["🐳 NGINX"]

    D["🗑️ Delete Pod"] --> E["❌ Pod Deleted"]

    style A fill:#333,color:#fff
    style B fill:#2496ED,color:#fff
    style C fill:#009639,color:#fff
    style D fill:#D9534F,color:#fff
    style E fill:#D9534F,color:#fff
```

If the Pod is deleted:

```bash
kubectl delete pod nginx
```

the Pod is deleted.

There is no Deployment or ReplicaSet managing it.

---

# ☸️ POD MANAGED BY DEPLOYMENT

With a Deployment:

```mermaid
flowchart TD
    A["☸️ Deployment"] --> B["🔁 ReplicaSet"]
    B --> C["📦 Pod 1"]
    B --> D["📦 Pod 2"]
    B --> E["📦 Pod 3"]

    F["🗑️ Delete Pod 2"] --> G["ReplicaSet Detects<br/>Missing Replica"]
    G --> H["➕ New Pod Created"]
    H --> I["📦 Replacement Pod"]

    style A fill:#326CE5,color:#fff
    style B fill:#6A5ACD,color:#fff
    style C fill:#009639,color:#fff
    style D fill:#009639,color:#fff
    style E fill:#009639,color:#fff
    style F fill:#D9534F,color:#fff
    style G fill:#F0AD4E,color:#000
    style H fill:#F0AD4E,color:#000
    style I fill:#009639,color:#fff
```

The Deployment keeps the application at the desired replica count.

---

# 🆚 COMPARISON TABLE

| Feature | Direct Pod | Deployment |
|---|---:|---:|
| Creates Pod | ✅ | ✅ |
| Multiple replicas | Manual | ✅ |
| ReplicaSet | ❌ | ✅ |
| Self-healing | ❌ | ✅ |
| Replacement Pod | ❌ | ✅ |
| Desired state management | Limited | ✅ |
| Application management | Basic | ✅ |
| Suitable for applications | Limited | ✅ |

---

# 🧠 DESIRED STATE

One of the most important Kubernetes concepts I learned is **desired state**.

In the YAML:

```yaml
replicas: 3
```

I told Kubernetes:

```text
Desired state = 3 Pods
```

Kubernetes continuously compares:

```text
Desired State
      VS
Current State
```

### When everything is correct

```text
Desired = 3
Current = 3
```

```mermaid
flowchart LR
    A["Desired<br/>3 Pods"] --> B["☸️ Kubernetes"]
    C["Current<br/>3 Pods"] --> B
    B --> D["✅ State Matches"]

    style A fill:#326CE5,color:#fff
    style C fill:#009639,color:#fff
    style D fill:#2E8B57,color:#fff
```

### When one Pod is deleted

```text
Desired = 3
Current = 2
```

```mermaid
flowchart LR
    A["Desired<br/>3 Pods"] --> B["☸️ Kubernetes"]
    C["Current<br/>2 Pods"] --> B
    B --> D["⚠️ Difference Detected"]
    D --> E["➕ Create Pod"]
    E --> F["Current = 3"]

    style A fill:#326CE5,color:#fff
    style C fill:#D9534F,color:#fff
    style D fill:#F0AD4E,color:#000
    style E fill:#F0AD4E,color:#000
    style F fill:#009639,color:#fff
```

---

# 🏗️ COMPLETE SELF-HEALING ARCHITECTURE

```mermaid
flowchart TB
    U["👨‍💻 User"] --> D["☸️ Deployment<br/>replicas: 3"]

    D --> R["🔁 ReplicaSet"]

    R --> P1["📦 Pod A"]
    R --> P2["📦 Pod B"]
    R --> P3["📦 Pod C"]

    P1 --> N1["🐳 NGINX"]
    P2 --> N2["🐳 NGINX"]
    P3 --> N3["🐳 NGINX"]

    X["🗑️ User Deletes Pod B"] --> P2

    P2 --> T["❌ Pod Removed"]
    T --> R

    R --> CHECK{"Desired = 3<br/>Current = 2"}

    CHECK --> NEW["➕ Create New Pod"]
    NEW --> P4["📦 Pod D"]
    P4 --> N4["🐳 NGINX"]

    style U fill:#333,color:#fff
    style D fill:#326CE5,color:#fff
    style R fill:#6A5ACD,color:#fff
    style P1 fill:#009639,color:#fff
    style P2 fill:#009639,color:#fff
    style P3 fill:#009639,color:#fff
    style P4 fill:#009639,color:#fff
    style X fill:#D9534F,color:#fff
    style T fill:#D9534F,color:#fff
    style CHECK fill:#F0AD4E,color:#000
    style NEW fill:#F0AD4E,color:#000
```

---

# 📋 IMPORTANT COMMANDS

## Create Deployment

```bash
kubectl create -f deployment.yml
```

## Apply Deployment

```bash
kubectl apply -f deployment.yml
```

## Check Deployment

```bash
kubectl get deploy
```

## Check ReplicaSets

```bash
kubectl get rs
```

## Check Pods

```bash
kubectl get pods
```

## Watch Pods

```bash
kubectl get pods -w
```

## Delete a Pod

```bash
kubectl delete pod <pod-name>
```

---

# 🧪 COMPLETE HANDS-ON TEST

## STEP 1 — Create the YAML File

```bash
vim deployment.yml
```

Add:

```yaml
apiVersion: apps/v1
kind: Deployment

metadata:
  name: nginx-deployment

spec:
  replicas: 3

  selector:
    matchLabels:
      app: nginx

  template:
    metadata:
      labels:
        app: nginx

    spec:
      containers:
        - name: nginx
          image: nginx:1.14.2
          ports:
            - containerPort: 80
```

---

## STEP 2 — Create the Deployment

```bash
kubectl create -f deployment.yml
```

Expected:

```text
deployment.apps/nginx-deployment created
```

---

## STEP 3 — Check the Deployment

```bash
kubectl get deploy
```

Expected:

```text
nginx-deployment   3/3   3   3
```

---

## STEP 4 — Check the ReplicaSet

```bash
kubectl get rs
```

Expected:

```text
nginx-deployment-77bc6bd484   3   3   3
```

---

## STEP 5 — Check the Pods

```bash
kubectl get pods
```

Expected:

```text
3 Pods
```

All Pods should eventually show:

```text
Running
```

---

## STEP 6 — Start Watching Pods

```bash
kubectl get pods -w
```

Keep this command running.

---

## STEP 7 — Open Another Terminal

In another terminal, run:

```bash
kubectl get pods
```

Choose one Pod and delete it:

```bash
kubectl delete pod <pod-name>
```

---

## STEP 8 — Observe the Replacement

Go back to:

```bash
kubectl get pods -w
```

The old Pod will terminate.

A new Pod will be created.

You may observe states such as:

```text
Terminating
Pending
ContainerCreating
Running
```

---

## STEP 9 — Verify the Final State

Run:

```bash
kubectl get pods
```

The Deployment should again have:

```text
3 Pods
```

---

# ⚠️ ERRORS I ENCOUNTERED

During the hands-on practice, I made a few command mistakes.

## ❌ Mistake 1

I typed:

```bash
kubectl gte pods -w
```

instead of:

```bash
kubectl get pods -w
```

The correct command is:

```bash
kubectl get pods -w
```

---

## ❌ Mistake 2

I typed:

```bash
kubectl gte pods
```

instead of:

```bash
kubectl get pods
```

The correct command is:

```bash
kubectl get pods
```

---

## 🧠 Lesson

Small spelling mistakes in CLI commands can cause errors.

The correct command structure is:

```text
kubectl get <resource>
```

Examples:

```bash
kubectl get pods
kubectl get deploy
kubectl get rs
```

---

# 📊 LAB RESULTS

| Resource | Result |
|---|---|
| Deployment | `nginx-deployment` |
| API Version | `apps/v1` |
| Kind | `Deployment` |
| Application | NGINX |
| Image | `nginx:1.14.2` |
| Container Port | `80` |
| Desired Replicas | `3` |
| Current Replicas | `3` |
| Ready Replicas | `3` |
| ReplicaSet | `nginx-deployment-77bc6bd484` |
| Pods | `3` |
| Pod Status | `Running` |
| Pod Deletion Test | ✅ Successful |
| Replacement Pod | ✅ Automatically Created |
| Self-Healing | ✅ Successfully Demonstrated |

---

# 🧠 KEY TAKEAWAYS

```text
☸️ A Deployment manages an application.

🔁 A Deployment creates/manages a ReplicaSet.

📦 A ReplicaSet maintains the desired number of Pods.

🔢 replicas: 3 means Kubernetes tries to maintain 3 Pods.

🗑️ Deleting a Deployment-managed Pod does not permanently reduce the replica count.

❤️ The ReplicaSet automatically creates a replacement Pod.

🔄 The replacement Pod receives a new name.

👀 kubectl get pods -w watches Pod changes in real time.

🧠 Kubernetes continuously compares desired state with current state.

🛠️ Deployments provide better application management than directly creating Pods.

🚀 Deployment → ReplicaSet → Pods is a very important Kubernetes relationship.
```

---

# 🔄 COMPLETE LAB FLOW

```mermaid
flowchart TD
    A["📄 deployment.yml"] --> B["kubectl create -f deployment.yml"]

    B --> C["☸️ Deployment<br/>nginx-deployment"]

    C --> D["🔁 ReplicaSet<br/>nginx-deployment-77bc6bd484"]

    D --> E["📦 Pod 1"]
    D --> F["📦 Pod 2"]
    D --> G["📦 Pod 3"]

    E --> H["🐳 NGINX"]
    F --> I["🐳 NGINX"]
    G --> J["🐳 NGINX"]

    G --> K["🗑️ Delete Pod 3"]

    K --> L["Current Pods = 2"]
    L --> M["🔁 ReplicaSet Detects Difference"]

    M --> N["➕ New Pod"]

    N --> O["🟡 Pending"]
    O --> P["🟠 ContainerCreating"]
    P --> Q["🟢 Running"]

    Q --> R["✅ 3 Pods Restored"]

    style A fill:#333,color:#fff
    style B fill:#555,color:#fff
    style C fill:#326CE5,color:#fff
    style D fill:#6A5ACD,color:#fff
    style E fill:#009639,color:#fff
    style F fill:#009639,color:#fff
    style G fill:#D9534F,color:#fff
    style H fill:#2496ED,color:#fff
    style I fill:#2496ED,color:#fff
    style J fill:#2496ED,color:#fff
    style K fill:#D9534F,color:#fff
    style L fill:#D9534F,color:#fff
    style M fill:#F0AD4E,color:#000
    style N fill:#F0AD4E,color:#000
    style O fill:#F0AD4E,color:#000
    style P fill:#F0AD4E,color:#000
    style Q fill:#009639,color:#fff
    style R fill:#2E8B57,color:#fff
```

---

# 🆚 DAY 33 → DAY 34

## DAY 33 — DIRECT POD

```mermaid
flowchart TD
    A["👨‍💻 User"] --> B["📦 Pod"]
    B --> C["🐳 NGINX"]

    D["🗑️ Delete Pod"] --> E["❌ Pod Deleted"]

    style A fill:#333,color:#fff
    style B fill:#2496ED,color:#fff
    style C fill:#009639,color:#fff
    style D fill:#D9534F,color:#fff
    style E fill:#D9534F,color:#fff
```

### Result

```text
Pod
 ↓
Delete Pod
 ↓
Pod is gone
 ↓
No ReplicaSet
 ↓
No automatic replacement
```

---

## DAY 34 — DEPLOYMENT

```mermaid
flowchart TD
    A["👨‍💻 User"] --> B["☸️ Deployment"]
    B --> C["🔁 ReplicaSet"]
    C --> D["📦 Pod 1"]
    C --> E["📦 Pod 2"]
    C --> F["📦 Pod 3"]

    G["🗑️ Delete Pod"] --> H["ReplicaSet Detects Missing Pod"]
    H --> I["➕ Create New Pod"]
    I --> J["📦 Replacement Pod"]

    style A fill:#333,color:#fff
    style B fill:#326CE5,color:#fff
    style C fill:#6A5ACD,color:#fff
    style D fill:#009639,color:#fff
    style E fill:#009639,color:#fff
    style F fill:#009639,color:#fff
    style G fill:#D9534F,color:#fff
    style H fill:#F0AD4E,color:#000
    style I fill:#F0AD4E,color:#000
    style J fill:#009639,color:#fff
```

### Result

```text
Deployment
 ↓
ReplicaSet
 ↓
3 Pods
 ↓
Delete 1 Pod
 ↓
ReplicaSet detects missing Pod
 ↓
New Pod created
 ↓
3 Pods restored
```

---

# 📌 MAIN CONCEPT TO REMEMBER

```mermaid
flowchart TD
    A["☸️ DEPLOYMENT"] --> B["🔁 REPLICASET"]
    B --> C["📦 PODS"]
    C --> D["🐳 CONTAINERS"]

    E["🗑️ Pod Deleted"] --> B
    B --> F["🔍 Check Desired State"]
    F --> G["➕ Create Replacement Pod"]
    G --> C

    style A fill:#326CE5,color:#fff
    style B fill:#6A5ACD,color:#fff
    style C fill:#009639,color:#fff
    style D fill:#2496ED,color:#fff
    style E fill:#D9534F,color:#fff
    style F fill:#F0AD4E,color:#000
    style G fill:#F0AD4E,color:#000
```

The main concept is:

> **A Deployment manages a ReplicaSet, and the ReplicaSet maintains the desired number of Pods. If a Deployment-managed Pod is deleted, the ReplicaSet automatically creates a new Pod to restore the desired state.**

---

# 🚀 NEXT STEP

After understanding:

```text
Pod
 ↓
Deployment
 ↓
ReplicaSet
 ↓
Self-Healing
```

the next Kubernetes concept is:

```text
Deployment
     ↓
Multiple Pods
     ↓
Service
     ↓
Stable Network Access
     ↓
Load Balancing
```

This leads to the next topic:

# ☸️ KUBERNETES SERVICES

---

<p align="center">

# 🎉 DAY 34 COMPLETE

### ☸️ KUBERNETES DEPLOYMENT + REPLICASET + POD SELF-HEALING

**Created an NGINX Deployment → Created 3 replicas → Observed the ReplicaSet → Deleted Pods → Watched Kubernetes automatically create replacement Pods.**

<br>

<b>Deployment → ReplicaSet → Pods → Self-Healing ❤️</b>

<br>

<b>🚀 DevOps Cloud Journey — Day 34</b>

</p>
