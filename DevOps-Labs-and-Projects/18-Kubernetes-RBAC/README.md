<div align="center">

# DAY 39 — KUBERNETES RBAC PRACTICAL

</div>

<p align="center">
  <img src="https://img.shields.io/badge/Kubernetes-RBAC-blue?style=for-the-badge&logo=kubernetes" alt="Kubernetes RBAC">
  <img src="https://img.shields.io/badge/Day-39-orange?style=for-the-badge" alt="Day 39">
  <img src="https://img.shields.io/badge/Hands--On-Practical-success?style=for-the-badge" alt="Hands-On Practical">
</p>

<p align="center">
  <b>Role-Based Access Control — ServiceAccount → Role → RoleBinding → ClusterRole → ClusterRoleBinding</b>
</p>

---

## 🎯 Objective

In this practical, I implemented and tested **Kubernetes RBAC (Role-Based Access Control)** using a **Minikube Kubernetes cluster**.

The main goal was to understand:

> **WHO can perform WHAT actions on WHICH Kubernetes resources.**

This practical covered:

- Namespace
- ServiceAccount
- Role
- RoleBinding
- ClusterRole
- ClusterRoleBinding
- `kubectl auth can-i`
- Namespace-scoped permissions
- Cluster-wide permissions

---

# 🧠 What is Kubernetes RBAC?

**RBAC = Role-Based Access Control**

RBAC is the Kubernetes mechanism used to control access to Kubernetes resources.

The basic concept is:

```text
                         RBAC
                          │
              ┌───────────┴───────────┐
              │                       │
           Identity               Permissions
              │                       │
     User / ServiceAccount          Role
              │                       │
              └───────────┬───────────┘
                          │
                     RoleBinding
                          │
                          ↓
                  Access is granted
```

A simple way to remember RBAC:

```text
WHO
 │
 └── User / ServiceAccount
             │
             │ RoleBinding
             ↓
WHAT
 │
 └── Role
       │
       ├── Resource
       └── Verb
```

### 🔑 RBAC Formula

```text
WHO?
 ↓
User / ServiceAccount

WHAT?
 ↓
Role / ClusterRole

WHO GETS WHAT?
 ↓
RoleBinding / ClusterRoleBinding
```

---

# 🏗️ RBAC Architecture

```text
                    KUBERNETES RBAC
                           │
          ┌────────────────┴────────────────┐
          │                                 │
       Identity                         Permissions
          │                                 │
   User / ServiceAccount              Role / ClusterRole
          │                                 │
          └────────────────┬────────────────┘
                           │
                    Binding connects them
                           │
             ┌─────────────┴─────────────┐
             │                           │
        RoleBinding              ClusterRoleBinding
             │                           │
             ↓                           ↓
     Namespace Scope             Cluster Scope
```

---

# 🚀 PRACTICAL IMPLEMENTATION

## 1️⃣ Initial Attempt

Initially, I accidentally tried:

```bash
create ns test
```

This failed because `create` by itself is not a Kubernetes command.

The terminal returned:

```text
Command 'create' not found
```

The correct Kubernetes command is:

```bash
kubectl create ns test
```

However, when I first tried the correct command, the Kubernetes API Server was unreachable:

```text
Unable to connect to the server:
dial tcp 192.168.49.2:8443: connect: no route to host
```

This happened because the Minikube cluster was not currently reachable.

---

# 2️⃣ Start Minikube

I started Minikube:

```bash
minikube start
```

Minikube successfully started the existing cluster.

I checked the Pods:

```bash
kubectl get pods
```

I also checked the Minikube status:

```bash
minikube status
```

The result showed:

```text
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```

This confirmed:

```text
Minikube
   │
   ├── Control Plane → Running
   ├── Kubelet      → Running
   ├── API Server   → Running
   └── Kubeconfig   → Configured
```

### ⚠️ Version Warning

Minikube also showed a warning that the installed `kubectl` version was different from the Kubernetes version:

```text
kubectl:     v1.31.0
Kubernetes:  v1.35.1
```

The practical continued successfully.

---

# 3️⃣ Create the Test Namespace

I created a namespace called `test`:

```bash
kubectl create ns test
```

Output:

```text
namespace/test created
```

The namespace was created specifically for the RBAC practical.

```text
Kubernetes Cluster
       │
       └── test Namespace
```

---

# 4️⃣ Create a ServiceAccount

I opened the ServiceAccount manifest:

```bash
vim serviceaccount.yaml
```

The YAML was:

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: foo
  namespace: test
```

I initially made a YAML syntax mistake and received:

```text
error parsing serviceaccount.yaml:
error converting YAML to JSON:
yaml: line 3: could not find expected ':'
```

I corrected the YAML and checked it:

```bash
cat serviceaccount.yaml
```

The corrected file was:

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: foo
  namespace: test
```

Then I applied it:

```bash
kubectl apply -f serviceaccount.yaml
```

Output:

```text
serviceaccount/foo created
```

---

# 🧠 What is a ServiceAccount?

A **ServiceAccount** provides an identity for workloads/applications running inside Kubernetes.

In this practical:

```text
ServiceAccount
      │
      └── foo
          │
          └── namespace: test
```

So:

```text
WHO?
 ↓
ServiceAccount: foo
```

At this stage, the identity exists, but we have not yet assigned the required RBAC permissions.

---

# 5️⃣ Check Permissions Before Creating a Role

I checked whether the ServiceAccount `foo` could get Pods:

```bash
kubectl auth can-i --as system:serviceaccount:test:foo get pods -n test
```

Output:

```text
no
```

### 🧠 Why did it return `no`?

Because the ServiceAccount existed, but it had not yet been connected to a Role containing the required permissions.

```text
ServiceAccount: foo
        │
        ↓
     Identity
        │
        └── No custom RBAC permission
```

---

# 🔍 Understanding `kubectl auth can-i`

The command:

```bash
kubectl auth can-i
```

is used to check whether an identity is authorized to perform an action.

The command:

```bash
kubectl auth can-i --as system:serviceaccount:test:foo get pods -n test
```

means:

> Can the ServiceAccount `foo` from the `test` namespace get Pods in the `test` namespace?

The ServiceAccount identity format is:

```text
system:serviceaccount:<namespace>:<serviceaccount-name>
```

So:

```text
system:serviceaccount:test:foo
              │      │
              │      └── ServiceAccount name
              └───────── Namespace
```

The other parts are:

```text
get
 ↓
Verb / Action

pods
 ↓
Resource

-n test
 ↓
Namespace
```

Therefore:

```text
WHO?
 ↓
foo

WHAT?
 ↓
get

WHICH RESOURCE?
 ↓
pods

WHERE?
 ↓
test namespace
```

---

# 6️⃣ Create the Role

Next, I created the Role:

```bash
vim role.yaml
```

The YAML was:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: test
  name: testadmin
rules:
- apiGroups: ["*"]
  resources: ["*"]
  verbs: ["*"]
```

I applied it:

```bash
kubectl apply -f role.yaml
```

Output:

```text
role.rbac.authorization.k8s.io/testadmin created
```

---

# 🧠 Understanding the Role

A **Role defines WHAT permissions are available.**

The Role name is:

```text
testadmin
```

and it belongs to:

```text
test namespace
```

The important section is:

```yaml
rules:
- apiGroups: ["*"]
  resources: ["*"]
  verbs: ["*"]
```

### `apiGroups: ["*"]`

The wildcard represents all API groups covered by the rule.

### `resources: ["*"]`

The wildcard represents all resources covered by the rule.

Examples:

```text
Pods
Deployments
Services
ConfigMaps
Secrets
```

### `verbs: ["*"]`

The wildcard represents all actions covered by the rule.

Examples:

```text
get
list
watch
create
update
patch
delete
```

So this Role intentionally gives very broad permissions for the learning practical.

---

# 7️⃣ Check Permission Again After Creating the Role

After creating the Role, I ran:

```bash
kubectl auth can-i --as system:serviceaccount:test:foo get pods -n test
```

Result:

```text
no
```

### 🧠 Why is it still `no`?

This is one of the most important RBAC concepts.

Creating a Role **only defines permissions**.

It does not automatically give those permissions to the ServiceAccount.

At this point:

```text
ServiceAccount: foo
        │
        │ ❌ Not connected
        │
Role: testadmin
```

So:

```text
Role
 ↓
Defines WHAT can be done
```

But we still need:

```text
WHO gets those permissions?
```

That is the purpose of **RoleBinding**.

---

# 8️⃣ Create the RoleBinding

I created:

```bash
vim rolebinding.yaml
```

The YAML was:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: testadminbinding
  namespace: test
subjects:
- kind: ServiceAccount
  name: foo
  apiGroup: ""
roleRef:
  kind: Role
  name: testadmin
  apiGroup: rbac.authorization.k8s.io
```

I applied it:

```bash
kubectl apply -f rolebinding.yaml
```

Output:

```text
rolebinding.rbac.authorization.k8s.io/testadminbinding created
```

---

# 🧠 Understanding RoleBinding

RoleBinding connects:

```text
WHO
 ↓
ServiceAccount: foo
```

to:

```text
WHAT
 ↓
Role: testadmin
```

The relationship becomes:

```text
ServiceAccount: foo
          │
          ↓
RoleBinding: testadminbinding
          │
          ↓
Role: testadmin
          │
          ↓
Permissions
```

### `subjects`

```yaml
subjects:
- kind: ServiceAccount
  name: foo
  apiGroup: ""
```

This identifies **WHO receives the permissions**.

### `roleRef`

```yaml
roleRef:
  kind: Role
  name: testadmin
  apiGroup: rbac.authorization.k8s.io
```

This identifies **WHICH Role is being granted**.

---

# 9️⃣ Verify Permission After RoleBinding

I ran:

```bash
kubectl auth can-i --as system:serviceaccount:test:foo get pods -n test
```

This time:

```text
yes
```

🔥 This proved that the RBAC configuration was working.

The complete chain became:

```text
ServiceAccount: foo
        │
        ↓
RoleBinding: testadminbinding
        │
        ↓
Role: testadmin
        │
        ↓
Permissions
        │
        ↓
get Pods → YES
```

This demonstrates the core RBAC relationship:

```text
WHO
 ↓
ServiceAccount

WHO GETS WHAT?
 ↓
RoleBinding

WHAT?
 ↓
Role
```

---

# 🔟 Test Create Pod Permission

I checked whether the ServiceAccount could create Pods:

```bash
kubectl auth can-i --as system:serviceaccount:test:foo create pods -n test
```

Output:

```text
yes
```

This means:

> The ServiceAccount `foo` is authorized to create Pods in the `test` namespace.

The reason is that the Role contains:

```yaml
resources: ["*"]
verbs: ["*"]
```

---

# 1️⃣1️⃣ Test Create Deployment Permission

I also checked whether the ServiceAccount could create Deployments:

```bash
kubectl auth can-i --as system:serviceaccount:test:foo create deploy -n test
```

Output:

```text
yes
```

Again, this is because the Role contains:

```yaml
resources: ["*"]
verbs: ["*"]
```

So the ServiceAccount has broad permissions within the namespace covered by the RoleBinding.

---

# 1️⃣2️⃣ Test Another Namespace

Next, I tested the same ServiceAccount in another namespace:

```bash
kubectl auth can-i --as system:serviceaccount:test:foo create deploy -n test-space
```

Output:

```text
no
```

### 🧠 Why?

The Role was created in:

```yaml
namespace: test
```

and the RoleBinding was also created in:

```yaml
namespace: test
```

Therefore, this RoleBinding provides namespace-scoped authorization.

```text
test
 │
 └── foo
      ↓
   RoleBinding
      ↓
   testadmin
      ↓
   Permission ✅


test-space
 │
 └── No permission from this namespace-scoped RoleBinding ❌
```

This demonstrated **namespace-scoped RBAC**.

---

# 🔥 WHO + WHAT + WHERE

At this stage, the practical can be remembered using three questions:

```text
WHO?
 ↓
ServiceAccount: foo

WHAT?
 ↓
Role: testadmin
 ↓
Resources + Verbs

WHERE?
 ↓
test namespace
```

The RoleBinding connects the identity to the permissions:

```text
ServiceAccount
      │
      │ RoleBinding
      ↓
     Role
      │
      ↓
Permissions
```

---

# 1️⃣3️⃣ Create ClusterRoleBinding

After demonstrating namespace-scoped RBAC, I moved to cluster-wide authorization.

I created:

```bash
vim clusterrolebinding.yaml
```

The YAML was:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: testadmininclusterbinding
subjects:
- kind: ServiceAccount
  name: foo
  apiGroup: ""
  namespace: test
roleRef:
  kind: ClusterRole
  name: cluster-admin
  apiGroup: rbac.authorization.k8s.io
```

I applied it:

```bash
kubectl apply -f clusterrolebinding.yaml
```

Output:

```text
clusterrolebinding.rbac.authorization.k8s.io/testadmininclusterbinding created
```

---

# 🧠 What Changed?

Before the ClusterRoleBinding:

```text
ServiceAccount
      ↓
RoleBinding
      ↓
Role
      ↓
Namespace-scoped authorization
```

After the ClusterRoleBinding:

```text
ServiceAccount
      ↓
ClusterRoleBinding
      ↓
ClusterRole
      ↓
Cluster-wide authorization
```

The ServiceAccount is still:

```text
foo
```

and it still belongs to:

```text
test namespace
```

It was **not moved** to another namespace.

Instead, the ClusterRoleBinding grants the referenced ClusterRole's permissions at cluster scope.

---

# 1️⃣4️⃣ ClusterRole: `cluster-admin`

The ClusterRole referenced in this practical is:

```text
cluster-admin
```

`cluster-admin` is a built-in Kubernetes ClusterRole with extremely broad administrative permissions.

The relationship is:

```text
ServiceAccount: foo
        │
        ↓
ClusterRoleBinding
        │
        ↓
ClusterRole: cluster-admin
        │
        ↓
Cluster-wide authorization
```

---

# 1️⃣5️⃣ Test Access in `kube-system`

I tested:

```bash
kubectl auth can-i --as system:serviceaccount:test:foo create deploy -n kube-system
```

Output:

```text
yes
```

This demonstrated that the ServiceAccount could perform the requested operation in the `kube-system` namespace through the ClusterRoleBinding.

```text
foo
 │
 ↓
ClusterRoleBinding
 │
 ↓
cluster-admin
 │
 ↓
kube-system
 │
 └── create deployment → YES
```

---

# 1️⃣6️⃣ Test Access in `default`

I also tested:

```bash
kubectl auth can-i --as system:serviceaccount:test:foo create deploy -n default
```

Output:

```text
yes
```

This further demonstrated the cluster-wide authorization provided by the ClusterRoleBinding.

```text
foo
 │
 ↓
ClusterRoleBinding
 │
 ↓
cluster-admin
 │
 ├── test → YES
 ├── kube-system → YES
 └── default → YES
```

---

# 🧠 Role vs ClusterRole

| Feature | Role | ClusterRole |
|---|---|---|
| Scope | Namespace-oriented | Cluster-scoped definition |
| Example | `testadmin` | `cluster-admin` |
| Used with | RoleBinding | ClusterRoleBinding |
| Purpose | Define permissions for namespace-level use | Define cluster-level or reusable permissions |

### Easy Mental Model

```text
Role
 ↓
WHAT permissions are available
for namespace-oriented authorization

ClusterRole
 ↓
WHAT permissions are defined at
cluster scope or for reusable bindings
```

---

# 🔗 RoleBinding vs ClusterRoleBinding

### RoleBinding

```text
WHO
 ↓
User / ServiceAccount
 ↓
RoleBinding
 ↓
Role
 ↓
Namespace-scoped authorization
```

### ClusterRoleBinding

```text
WHO
 ↓
User / ServiceAccount
 ↓
ClusterRoleBinding
 ↓
ClusterRole
 ↓
Cluster-wide authorization
```

---

# 🌍 ServiceAccount Namespace vs Permission Scope

One important concept demonstrated in this practical is:

> **The namespace where a ServiceAccount exists and the scope where it is authorized to act are different concepts.**

The ServiceAccount:

```text
foo
```

still belongs to:

```text
test namespace
```

even after creating the ClusterRoleBinding.

It was not moved to:

```text
default
```

or:

```text
kube-system
```

Instead:

```text
ServiceAccount
foo
namespace: test
       │
       ↓
ClusterRoleBinding
       │
       ↓
ClusterRole
       │
       ↓
Cluster-wide authorization
```

So:

> The ServiceAccount can remain in the `test` namespace while being authorized to perform actions in other namespaces through a ClusterRoleBinding.

---

# 🔐 Authentication vs Authorization

RBAC mainly deals with **authorization**.

### Authentication

Authentication asks:

```text
WHO ARE YOU?
```

For workloads:

```text
Application
 ↓
ServiceAccount
 ↓
Identity
```

### Authorization

Authorization asks:

```text
WHAT ARE YOU ALLOWED TO DO?
```

For example:

```text
ServiceAccount
      ↓
RBAC
      ↓
Can get Pods?
Can create Pods?
Can delete Pods?
```

Therefore:

```text
AUTHENTICATION
      ↓
WHO ARE YOU?
      ↓
AUTHORIZATION
      ↓
WHAT CAN YOU DO?
```

---

# ⚠️ Security Lesson — Principle of Least Privilege

The practical intentionally used:

```yaml
apiGroups: ["*"]
resources: ["*"]
verbs: ["*"]
```

and later:

```text
ClusterRole: cluster-admin
```

These are extremely broad permissions.

They are useful for understanding RBAC during a lab, but they should **not normally be assigned to application ServiceAccounts in production.**

The recommended security principle is:

> **Principle of Least Privilege**

Meaning:

> Give each user or application only the permissions it actually needs.

Example:

```text
QA
 ↓
Read Pods + Logs

Developer
 ↓
Required application resources

Application
 ↓
Only required Kubernetes API permissions

DevOps
 ↓
Administrative permissions where required
```

---

# 📁 RBAC Files Created

```text
RBAC Practical
│
├── serviceaccount.yaml
│     └── ServiceAccount: foo
│
├── role.yaml
│     └── Role: testadmin
│
├── rolebinding.yaml
│     └── Binds foo → testadmin
│
└── clusterrolebinding.yaml
      └── Binds foo → cluster-admin
```

---

# 📋 Complete Commands Used

```bash
# Initial incorrect command
create ns test

# Start Minikube
minikube start

# Check Pods
kubectl get pods

# Check Minikube status
minikube status

# Create namespace
kubectl create ns test

# Create ServiceAccount YAML
vim serviceaccount.yaml

# View ServiceAccount YAML
cat serviceaccount.yaml

# Apply ServiceAccount
kubectl apply -f serviceaccount.yaml

# Check permission before RoleBinding
kubectl auth can-i --as system:serviceaccount:test:foo get pods -n test

# Create Role YAML
vim role.yaml

# Apply Role
kubectl apply -f role.yaml

# Check permission after Role but before RoleBinding
kubectl auth can-i --as system:serviceaccount:test:foo get pods -n test

# Create RoleBinding YAML
vim rolebinding.yaml

# Apply RoleBinding
kubectl apply -f rolebinding.yaml

# Check get Pod permission
kubectl auth can-i --as system:serviceaccount:test:foo get pods -n test

# Check create Pod permission
kubectl auth can-i --as system:serviceaccount:test:foo create pods -n test

# Check create Deployment permission
kubectl auth can-i --as system:serviceaccount:test:foo create deploy -n test

# Test another namespace
kubectl auth can-i --as system:serviceaccount:test:foo create deploy -n test-space

# Create ClusterRoleBinding YAML
vim clusterrolebinding.yaml

# Apply ClusterRoleBinding
kubectl apply -f clusterrolebinding.yaml

# Test access in kube-system
kubectl auth can-i --as system:serviceaccount:test:foo create deploy -n kube-system

# Test access in default namespace
kubectl auth can-i --as system:serviceaccount:test:foo create deploy -n default
```

---

# 🧩 Complete Practical Flow

```text
1. Start Minikube
        ↓
2. Create test namespace
        ↓
3. Create ServiceAccount: foo
        ↓
4. Check permission
        ↓
      NO ❌
        ↓
5. Create Role: testadmin
        ↓
6. Check permission
        ↓
      NO ❌
   Role exists but is not bound
        ↓
7. Create RoleBinding
        ↓
8. Check permission
        ↓
      YES ✅
        ↓
9. Test create Pod
        ↓
      YES ✅
        ↓
10. Test create Deployment
        ↓
      YES ✅
        ↓
11. Test test-space
        ↓
      NO ❌
   Namespace-scoped access
        ↓
12. Create ClusterRoleBinding
        ↓
13. Bind foo → cluster-admin
        ↓
14. Test kube-system
        ↓
      YES ✅
        ↓
15. Test default
        ↓
      YES ✅
   Cluster-wide authorization
```

---

# 📊 Practical Results

| Test | Result | Reason |
|---|---:|---|
| `foo` → `get pods` in `test` before RoleBinding | ❌ `no` | No applicable permission |
| `foo` → `get pods` after Role creation | ❌ `no` | Role existed but was not bound |
| `foo` → `get pods` after RoleBinding | ✅ `yes` | `foo` was connected to `testadmin` |
| `foo` → `create pods` in `test` | ✅ `yes` | Role allows `*` resources and `*` verbs |
| `foo` → `create deploy` in `test` | ✅ `yes` | Role allows `*` resources and `*` verbs |
| `foo` → `create deploy` in `test-space` | ❌ `no` | Namespace-scoped RoleBinding |
| `foo` → `create deploy` in `kube-system` | ✅ `yes` | ClusterRoleBinding |
| `foo` → `create deploy` in `default` | ✅ `yes` | ClusterRoleBinding |

---

# 🎯 What I Learned

### 1. ServiceAccount

```text
ServiceAccount = WHO
```

It provides an identity for a workload/application.

### 2. Role

```text
Role = WHAT
```

It defines permissions on Kubernetes resources using API groups, resources and verbs.

### 3. RoleBinding

```text
RoleBinding = WHO GETS WHAT
```

It connects a User or ServiceAccount to a Role.

### 4. Creating a Role Is Not Enough

```text
Role created
      ↓
Permissions defined
      ↓
But access is not granted yet ❌
```

The Role must be connected to an identity through a binding.

```text
ServiceAccount
      +
Role
      ↓
RoleBinding
      ↓
Permissions granted
```

### 5. Namespace Scope

A Role and RoleBinding provide namespace-scoped authorization.

```text
test
 ↓
✅ Permission

test-space
 ↓
❌ No permission from this RoleBinding
```

### 6. ClusterRoleBinding

A ClusterRoleBinding can grant the referenced ClusterRole's permissions at cluster scope.

```text
ServiceAccount
      ↓
ClusterRoleBinding
      ↓
ClusterRole
      ↓
Cluster-wide authorization
```

### 7. `kubectl auth can-i`

This command verifies authorization:

```bash
kubectl auth can-i --as system:serviceaccount:test:foo <verb> <resource> -n <namespace>
```

Result:

```text
yes → Authorized ✅

no → Not authorized ❌
```

---

# 🏆 FINAL RBAC MENTAL MODEL

```text
                         KUBERNETES RBAC
                                │
                ┌───────────────┴───────────────┐
                │                               │
             WHO?                            WHAT?
                │                               │
      User / ServiceAccount            Role / ClusterRole
                │                               │
                └───────────────┬───────────────┘
                                │
                         HOW TO CONNECT?
                                │
                 ┌──────────────┴──────────────┐
                 │                             │
            RoleBinding              ClusterRoleBinding
                 │                             │
                 ↓                             ↓
       Namespace-scoped              Cluster-wide
       authorization                 authorization
```

### 🔥 RBAC IN ONE SENTENCE

> **Kubernetes RBAC controls who can perform what actions on Kubernetes resources by connecting an identity such as a User or ServiceAccount to permissions defined by a Role or ClusterRole through a RoleBinding or ClusterRoleBinding.**

---

<p align="center">

# 🎉 DAY 39 COMPLETE

### 🔐 KUBERNETES RBAC PRACTICAL COMPLETED

**ServiceAccount → Role → RoleBinding → Namespace Scope → ClusterRole → ClusterRoleBinding → Cluster-wide Authorization**

</p>
