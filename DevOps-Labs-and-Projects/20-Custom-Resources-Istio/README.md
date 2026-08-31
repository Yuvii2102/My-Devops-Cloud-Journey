<div align="center">

# Kubernetes Custom Resources — Istio Practical

### 🔧 Installing Istio CRDs & Control Plane Using Helm

![Kubernetes](https://img.shields.io/badge/Kubernetes-1.35.1-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Istio](https://img.shields.io/badge/Istio-1.30.4-466BB0?style=for-the-badge&logo=istio&logoColor=white)
![Helm](https://img.shields.io/badge/Helm-3.x-0F1689?style=for-the-badge&logo=helm&logoColor=white)
![Minikube](https://img.shields.io/badge/Minikube-1.38.1-F2C811?style=for-the-badge&logo=kubernetes&logoColor=black)

<br>

**Hands-on practical to understand Kubernetes Custom Resource Definitions (CRDs) using Istio**

</div>

---

# 🎯 1. Practical Objective

The objective of this practical was to understand how an external Kubernetes project such as **Istio** can extend the Kubernetes API using **Custom Resource Definitions (CRDs)**.

Before starting the commands, I first went to the **Istio documentation** and checked the available installation methods.

From the Istio documentation, I selected:

> **Install with Helm**

The practical therefore followed this flow:

```text
Istio Documentation
        │
        ▼
Installation Guide
        │
        ▼
Install with Helm
        │
        ▼
Add Istio Helm Repository
        │
        ▼
Install Istio Base
        │
        ▼
Istio CRDs Installed
        │
        ▼
Kubernetes API Extended
        │
        ▼
Install istiod
        │
        ▼
Istio Control Plane Running
```

---

# 🌐 2. What Is Istio?

**Istio is an open-source service mesh** that helps manage communication between services running in Kubernetes.

It provides capabilities such as:

- 🔐 Security and mutual TLS
- 🚦 Traffic management
- 📊 Observability
- 🔄 Retries and timeouts
- ⚖️ Traffic splitting
- 🌐 Service-to-service communication management

Istio also introduces its own Kubernetes resources, such as:

```text
VirtualService
DestinationRule
Gateway
PeerAuthentication
AuthorizationPolicy
ServiceEntry
Sidecar
Telemetry
...
```

These Istio-specific resources are examples of **Custom Resources**.

---

# 🧩 3. Why Do We Need Custom Resources?

Kubernetes already provides native resources such as:

```text
Pod
Deployment
Service
ConfigMap
Secret
Ingress
Job
CronJob
...
```

But Kubernetes cannot natively provide every possible feature required by every external Kubernetes project.

For example, Istio provides **service mesh capabilities**, so Istio needs its own resource types.

Instead of changing the Kubernetes source code, Kubernetes provides an extension mechanism through **Custom Resource Definitions**.

The basic idea is:

```text
CRD
 │
 │ Defines a new resource type
 ▼
Custom Resource
 │
 │ Watched / processed by
 ▼
Controller / Control Plane
 │
 ▼
Actual Functionality
```

### 🧠 Simple Memory Trick

```text
CRD        → Definition
CR         → Actual Resource / Object
Controller → Watches + Reconciles + Acts
```

---

# 🏗️ 4. Native Resource vs Custom Resource

A native Kubernetes resource already has its definition and controller available inside Kubernetes.

For example:

```text
Deployment
    │
    ▼
Deployment Controller
    │
    ▼
ReplicaSet
    │
    ▼
Pods
```

For a custom resource:

```text
VirtualService CRD
        │
        ▼
VirtualService CR
        │
        ▼
Istio Control Plane
        │
        ▼
Istio Functionality
```

The major difference is:

```text
Native Resource
→ Kubernetes already provides the required resource type
  and controller logic.

Custom Resource
→ An external project extends Kubernetes with its own
  resource types and the components that process them.
```

---

# 👨‍💻 5. Actors in This Practical

### DevOps Engineer

The DevOps engineer installs the required Istio components:

```text
DevOps Engineer
       │
       ├──────────────► Istio CRDs
       │
       └──────────────► Istio Control Plane
```

### User

After the CRDs are available, a user can create Istio Custom Resources.

For example:

```text
User
 │
 ▼
VirtualService CR
```

---

# 📖 6. First Go to Istio Documentation

Before running any command, I first went to the **Istio documentation**.

The Istio installation documentation provides different installation methods.

For this practical, I selected:

```text
Install with Helm
```

The documentation provided the Helm repository commands:

```bash
helm repo add istio https://blob.istio.io/istio-release/charts
helm repo update
```

I then used these commands in my Kubernetes environment.

---

# 📦 7. Step 1 — Add Istio Helm Repository

I added the Istio Helm repository:

```bash
helm repo add istio https://blob.istio.io/istio-release/charts
```

Output:

```text
"istio" has been added to your repositories
```

Then I updated the Helm repository information:

```bash
helm repo update
```

Output:

```text
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "kubeshark" chart repository
...Successfully got an update from the "istio" chart repository
Update Complete. ⎈Happy Helming!⎈
```

### 🧠 What happened?

The first command tells Helm:

> Add the Istio chart repository.

The second command tells Helm:

> Refresh the information about the available charts.

Conceptually:

```text
Istio Helm Repository
        │
        ▼
       Helm
        │
        ▼
Istio Charts Available
```

---

# ❌ 8. Step 2 — First Istio Installation Attempt

After adding the repository, I tried to install the Istio base chart:

```bash
helm install istio-base istio/base -n istio-system --set defaultRevision=default --create-namespace
```

The installation failed with:

```text
Error: INSTALLATION FAILED: Kubernetes cluster unreachable:
Get "https://192.168.49.2:8443/version":
dial tcp 192.168.49.2:8443: connect: no route to host
```

### 🧠 Why Did It Fail?

Helm needs to communicate with the Kubernetes API Server.

At that moment, the Kubernetes API Server was not reachable.

The flow was:

```text
Helm
  │
  ▼
Kubernetes API Server
  │
  ✕
Not reachable
```

So the problem was with the Kubernetes cluster being unavailable, not with the Istio chart itself.

---

# 🚀 9. Step 3 — Start Minikube

I started the Minikube Kubernetes cluster:

```bash
minikube start
```

Important output:

```text
* minikube v1.38.1 on Ubuntu 26.04 (xen/amd64)
* Using the docker driver based on existing profile
* Starting "minikube" primary control-plane node in "minikube" cluster
* Pulling base image v0.0.50 ...
* Restarting existing docker container for "minikube" ...
* Preparing Kubernetes v1.35.1 on Docker 29.2.1 ...
* Verifying Kubernetes components...
* Verifying ingress addon...
* Enabled addons: storage-provisioner, ingress, default-storageclass
* Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
```

Then I checked the cluster:

```bash
minikube status
```

Output:

```text
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```

### 🧠 Important

The most important line was:

```text
apiserver: Running
```

This confirmed that the Kubernetes API Server was running.

The communication path was now:

```text
Helm / kubectl
       │
       ▼
Kubernetes API Server
       │
       ▼
Minikube Kubernetes Cluster
```

---

# ⚠️ 10. kubectl Version Warning

Minikube also displayed:

```text
/usr/local/bin/kubectl is version 1.31.0,
which may have incompatibilities with Kubernetes 1.35.1.
```

The Kubernetes server version was:

```text
Kubernetes v1.35.1
```

The installed kubectl version was:

```text
kubectl v1.31.0
```

Minikube suggested:

```bash
minikube kubectl -- get pods -A
```

### 🧠 Understanding

`kubectl` is the Kubernetes client.

The API Server is the Kubernetes server.

```text
kubectl
   │
   │ API requests
   ▼
Kubernetes API Server
```

It is recommended to use reasonably compatible client and server versions.

---

# 📦 11. Step 4 — Install Istio Base

Now that the Kubernetes API Server was running, I repeated the installation:

```bash
helm install istio-base istio/base -n istio-system --set defaultRevision=default --create-namespace
```

This time the installation succeeded:

```text
NAME: istio-base
LAST DEPLOYED: Mon Aug 31 05:43:24 2026
NAMESPACE: istio-system
STATUS: deployed
REVISION: 1
```

Istio reported:

```text
Istio base successfully installed!
```

### 🧠 What Did We Install?

The `istio/base` Helm chart installs Istio's base resources, including the **Custom Resource Definitions**.

Conceptually:

```text
Helm
 │
 ▼
istio/base
 │
 ▼
Istio CRDs
 │
 ▼
Kubernetes API Extended
```

This is the first major step where we actually see the **Custom Resources concept in practice**.

---

# 📁 12. Understanding `--create-namespace`

The installation command contained:

```bash
--create-namespace
```

The namespace was:

```text
istio-system
```

This option tells Helm:

> Create the namespace if it does not already exist.

Therefore:

```text
helm install
     │
     │ --create-namespace
     ▼
istio-system
     │
     ▼
Namespace created if required
```

---

# ⚠️ 13. Step 5 — Creating the Namespace Again

After the Helm installation, I ran:

```bash
kubectl create namespace istio-system
```

Kubernetes returned:

```text
Error from server (AlreadyExists):
namespaces "istio-system" already exists
```

### 🧠 Why?

Because the Helm installation had already created the namespace using:

```text
--create-namespace
```

Therefore:

```text
istio-system
      │
      ▼
Already exists ✅
```

This was not a problem.

---

# 🔎 14. Step 6 — Verify the Istio Helm Release

I checked the installed Helm releases:

```bash
helm ls -n istio-system
```

Output:

```text
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
istio-base      istio-system    1               2026-08-31 05:43:24.516907291 +0000 UTC deployed        base-1.30.4     1.30.4
```

This confirmed:

```text
NAME:        istio-base
NAMESPACE:   istio-system
STATUS:      deployed
CHART:       base-1.30.4
APP VERSION: 1.30.4
```

So the Istio base chart was successfully installed.

---

# 🔐 15. Step 7 — Check the Custom Resource Definitions

This was the **most important command in this practical**:

```bash
kubectl get crd
```

The cluster returned:

```text
authorizationpolicies.security.istio.io
destinationrules.networking.istio.io
envoyfilters.networking.istio.io
gateways.networking.istio.io
peerauthentications.security.istio.io
proxyconfigs.networking.istio.io
requestauthentications.security.istio.io
serviceentries.networking.istio.io
sidecars.networking.istio.io
telemetries.telemetry.istio.io
trafficextensions.extensions.istio.io
virtualservices.networking.istio.io
wasmplugins.extensions.istio.io
workloadentries.networking.istio.io
workloadgroups.networking.istio.io
```

🔥 This was the practical proof that Istio had extended the Kubernetes API.

---

# 🧩 16. Istio CRDs Found in the Cluster

Some of the CRDs installed by Istio were:

```text
authorizationpolicies.security.istio.io
destinationrules.networking.istio.io
envoyfilters.networking.istio.io
gateways.networking.istio.io
peerauthentications.security.istio.io
proxyconfigs.networking.istio.io
requestauthentications.security.istio.io
serviceentries.networking.istio.io
sidecars.networking.istio.io
telemetries.telemetry.istio.io
trafficextensions.extensions.istio.io
virtualservices.networking.istio.io
wasmplugins.extensions.istio.io
workloadentries.networking.istio.io
workloadgroups.networking.istio.io
```

Important examples include:

```text
VirtualService
Gateway
DestinationRule
PeerAuthentication
AuthorizationPolicy
ServiceEntry
Telemetry
EnvoyFilter
...
```

---

# ⭐ 17. Understanding `virtualservices.networking.istio.io`

One of the most important CRDs we found was:

```text
virtualservices.networking.istio.io
```

This defines the Istio resource type:

```text
VirtualService
```

Conceptually:

```text
VirtualService CRD
        │
        ▼
Defines the VirtualService resource type
        │
        ▼
Kubernetes now understands:
kind: VirtualService
```

Before the CRD:

```text
Kubernetes API
      │
      └── VirtualService
              │
              ▼
             ❌
      Not a native resource
```

After installing the CRD:

```text
Kubernetes API
      │
      ├── Deployment
      ├── Service
      ├── Pod
      ├── ConfigMap
      │
      └── VirtualService ✅
```

---

# 🧠 18. CRD vs CR

At this stage, I had installed the:

```text
CRD
```

But I had **not yet created an actual VirtualService Custom Resource**.

This distinction is extremely important.

### CRD

Defines the resource type:

```text
VirtualService
```

### CR

Creates an actual object of that type:

```yaml
apiVersion: networking.istio.io/v1
kind: VirtualService

metadata:
  name: my-app

spec:
  ...
```

Therefore:

```text
CRD
 │
 │ defines
 ▼
VirtualService type
 │
 │ user creates
 ▼
VirtualService CR
```

### 🧠 Simple Analogy

```text
CRD = Blueprint
CR  = Actual object created from the blueprint
```

---

# ⚙️ 19. Step 8 — Install Istio Control Plane

After installing the Istio CRDs, I installed the Istio control plane using:

```bash
helm install istiod istio/istiod -n istio-system --wait
```

The installation succeeded:

```text
NAME: istiod
LAST DEPLOYED: Mon Aug 31 05:47:08 2026
NAMESPACE: istio-system
STATUS: deployed
REVISION: 1
```

Istio reported:

```text
"istiod" successfully installed!
```

---

# 🧠 20. Why Do We Need the Istio Control Plane?

A CRD defines/registers a new resource type and its schema.

But creating a Custom Resource alone does not provide the actual application/service-mesh functionality.

Something needs to process the configuration.

For Istio, this is handled by its **control plane**, including `istiod`.

Conceptually:

```text
Istio CRD
     │
     ▼
Defines resource type
     │
     ▼
Custom Resource
     │
     ▼
Istio Control Plane
     │
     ▼
Processes configuration
     │
     ▼
Istio Functionality
```

This is similar to the Ingress concept learned earlier:

```text
Ingress
   │
   ▼
Ingress Controller
   │
   ▼
Actual routing behavior
```

Similarly:

```text
Istio Custom Resource
        │
        ▼
Istio Control Plane
        │
        ▼
Istio behavior
```

> **Important:** `istiod` should be understood as Istio's control-plane component rather than simply calling it a small standalone custom controller. It provides/coordinates the control-plane functionality that processes Istio configuration and manages the service mesh.

---

# 🔎 21. Step 9 — Verify Helm Releases Again

I checked the Helm releases again:

```bash
helm ls -n istio-system
```

Output:

```text
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
istio-base      istio-system    1               2026-08-31 05:43:24.516907291 +0000 UTC deployed        base-1.30.4     1.30.4
istiod          istio-system    1               2026-08-31 05:47:08.867906054 +0000 UTC deployed        istiod-1.30.4   1.30.4
```

Now there were two Helm releases:

```text
istio-base
    │
    └── Istio base resources / CRDs

istiod
    │
    └── Istio control plane
```

---

# 🔍 22. Step 10 — Check Istiod Status

I checked the status of the Istiod Helm release:

```bash
helm status istiod -n istio-system
```

The output showed:

```text
NAME: istiod
NAMESPACE: istio-system
STATUS: deployed
```

This confirmed that the Istio control-plane Helm release was successfully deployed.

---

# 🚀 23. Step 11 — Verify Istiod Deployment

I checked the Istiod Deployment:

```bash
kubectl get deployments -n istio-system --output wide
```

Output:

```text
NAME     READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS   IMAGES                                   SELECTOR
istiod   1/1     1            1           ...   discovery    registry.istio.io/release/pilot:1.30.4   istio=pilot
```

The important value was:

```text
READY
1/1
```

This means:

```text
1 desired replica
1 ready replica
```

Therefore, the Istio control plane was running successfully.

---

# 🏗️ 24. What Did We Build?

After completing the installation, the cluster conceptually looks like this:

```text
                         KUBERNETES CLUSTER
                                │
                                ▼
                        ┌──────────────┐
                        │  API SERVER  │
                        └──────┬───────┘
                               │
              ┌────────────────┴────────────────┐
              │                                 │
              ▼                                 ▼
       Native Resources                    Istio CRDs
              │                                 │
       ┌──────┼──────┐                  ┌───────┼──────────┐
       │      │      │                  │       │          │
   Deployment Service Pod          VirtualService Gateway DestinationRule
                                          │
                                          ▼
                                  Istio Control Plane
                                          │
                                          ▼
                                        istiod
```

---

# 🔄 25. Complete Custom Resource Flow

The complete concept demonstrated by this practical is:

```text
                    DEVOPS ENGINEER
                           │
                           │
                           ▼
                         Helm
                           │
                ┌──────────┴──────────┐
                │                     │
                ▼                     ▼
           istio/base              istiod
                │                     │
                ▼                     ▼
           Istio CRDs           Istio Control Plane
                │                     │
                │                     │
                ▼                     │
     ┌────────────────────┐            │
     │ VirtualService CRD │            │
     │ Gateway CRD        │            │
     │ DestinationRule    │            │
     │ etc.               │            │
     └─────────┬──────────┘            │
               │                       │
               │ defines               │ processes
               ▼                       │
             USER                      │
               │                       │
               ▼                       │
      VirtualService CR ───────────────┘
               │
               ▼
        Kubernetes API Server
               │
               ▼
           Validation
               │
               ▼
          CR Stored
               │
               ▼
       Istio Control Plane
               │
               ▼
        Reconciliation
               │
               ▼
        Istio Functionality
```

---

# 🧠 26. What Is a Schema?

A **schema** is simply a set of rules that describes how a resource should be structured.

For example, conceptually:

```text
replicas → number
name     → string
hosts    → list
```

The CRD contains a schema describing the expected structure of the Custom Resource.

Therefore:

```text
Custom Resource
       │
       ▼
     Schema
       │
       ▼
   Validation
       │
   ┌───┴────┐
   ▼        ▼
 Valid    Invalid
   │        │
   ▼        ▼
Accepted  Rejected
```

### Simple Definition

> **Schema = Rules describing the structure and allowed values of a resource.**

---

# 🔄 27. What Is Reconciliation?

**Reconciliation** means continuously trying to make the actual state match the desired state.

For example:

```text
Desired State:
"I want configuration X."
          │
          ▼
      Controller
          │
          ▼
Compare Desired State
with Actual State
          │
          ▼
      Difference?
       /       \
     Yes        No
      │          │
      ▼          ▼
    Fix it     Nothing
      │
      ▼
Actual State matches
Desired State
```

### Simple Definition

> **Reconciliation = Making the actual state match the desired state.**

This is one of the most important ideas behind Kubernetes controllers.

---

# 🆚 28. Native Resource vs Custom Resource

### Native Kubernetes Resource

```text
Deployment
     │
     ▼
Deployment Controller
     │
     ▼
ReplicaSet
     │
     ▼
Pods
```

Kubernetes already provides the resource definition and controller.

### Custom Resource

```text
VirtualService CRD
        │
        ▼
VirtualService CR
        │
        ▼
Istio Control Plane
        │
        ▼
Istio Functionality
```

The external project provides the additional resource types and the components that implement their behavior.

---

# 📦 29. Manifest vs Helm

### Kubernetes Manifest

A **manifest** is a YAML file describing the desired Kubernetes resources.

Example:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
```

Simple meaning:

> **Manifest = YAML instructions describing what you want Kubernetes to create.**

### Helm

**Helm** is a package manager/tool for installing and managing Kubernetes applications using charts.

Instead of manually managing many YAML files:

```text
deployment.yaml
service.yaml
configmap.yaml
secret.yaml
...
```

a Helm chart can package and template the application's Kubernetes resources.

Simple meaning:

> **Helm = Package manager for Kubernetes applications.**

---

# 🔥 30. What Exactly Happened in This Practical?

```text
1. Went to Istio Documentation
             │
             ▼
2. Selected "Install with Helm"
             │
             ▼
3. Added Istio Helm Repository
             │
             ▼
4. Updated Helm Repository
             │
             ▼
5. Tried installing Istio Base
             │
             ▼
6. Installation failed because
   Kubernetes API Server was unreachable
             │
             ▼
7. Started Minikube
             │
             ▼
8. Verified API Server was running
             │
             ▼
9. Installed istio-base
             │
             ▼
10. Istio CRDs were installed
             │
             ▼
11. Verified with:
    kubectl get crd
             │
             ▼
12. Installed istiod
             │
             ▼
13. Verified Helm releases
             │
             ▼
14. Verified istiod status
             │
             ▼
15. Verified istiod Deployment
             │
             ▼
16. Istio control plane is running ✅
```

---

# 📋 31. All Commands Used in This Practical

### Add Istio Helm repository

```bash
helm repo add istio https://blob.istio.io/istio-release/charts
```

### Update Helm repositories

```bash
helm repo update
```

### Start Minikube

```bash
minikube start
```

### Check Minikube status

```bash
minikube status
```

### Install Istio base

```bash
helm install istio-base istio/base -n istio-system --set defaultRevision=default --create-namespace
```

### Create namespace manually

```bash
kubectl create namespace istio-system
```

> This returned `AlreadyExists` because `--create-namespace` had already created `istio-system`.

### List Helm releases

```bash
helm ls -n istio-system
```

### List Custom Resource Definitions

```bash
kubectl get crd
```

### Install Istio control plane

```bash
helm install istiod istio/istiod -n istio-system --wait
```

### Check Istiod Helm status

```bash
helm status istiod -n istio-system
```

### Check Istio deployments

```bash
kubectl get deployments -n istio-system --output wide
```

---

# 💡 32. Key Takeaways

| Concept | Simple Meaning |
|---|---|
| **Istio** | Service mesh that adds networking, security and observability capabilities |
| **CRD** | Defines/registers a new Kubernetes resource type |
| **CR** | An actual object created using that custom resource type |
| **Schema** | Rules describing the resource structure and allowed values |
| **Validation** | Checking a resource against its schema |
| **Custom Controller** | Watches Custom Resources and performs required actions |
| **Istiod** | Istio's control-plane component |
| **Reconciliation** | Making actual state match desired state |
| **Manifest** | YAML describing desired Kubernetes resources |
| **Helm** | Package manager/tool for Kubernetes applications |
| **VirtualService** | An Istio Custom Resource used for traffic-management configuration |

---

# 🧠 33. Final Mental Model

```text
                    KUBERNETES
                         │
                         │
                  Want something
                       new?
                         │
                         ▼
                        CRD
                         │
               "Define a new type"
                         │
                         ▼
                         CR
                         │
              "What configuration
                 do I want?"
                         │
                         ▼
               Controller /
               Control Plane
                         │
                 "Watch + Act"
                         │
                         ▼
                  Reconciliation
                         │
               "Make actual state
                match desired state"
                         │
                         ▼
                Actual Functionality
```

---

# 🏆 34. Final Practical Architecture

```text
                         KUBERNETES CLUSTER
                                │
                                ▼
                         ┌─────────────┐
                         │ API SERVER  │
                         └──────┬──────┘
                                │
                ┌───────────────┴────────────────┐
                │                                │
                ▼                                ▼
        Native Resources                   Istio CRDs
                │                                │
          Deployment                        VirtualService
          Service                           Gateway
          Pod                               DestinationRule
          ConfigMap                         PeerAuthentication
                │                                │
                ▼                                ▼
        Native Controllers              Istio Custom Resources
                │                                │
                ▼                                ▼
    Kubernetes behavior                 Istio Control Plane
                                                │
                                                ▼
                                              istiod
                                                │
                                                ▼
                                          Reconciliation
                                                │
                                                ▼
                                        Istio Functionality
```

---

# 🎯 35. Practical Summary

The practical started from the **Istio documentation**, where I selected the **Helm installation method**.

I then added and updated the Istio Helm repository:

```text
helm repo add
helm repo update
```

The first installation attempt failed because the Kubernetes API Server was unreachable, so I started Minikube and verified that:

```text
apiserver: Running
```

After that, I installed:

```text
istio-base
```

which installed Istio's **Custom Resource Definitions**.

I verified the CRDs using:

```text
kubectl get crd
```

and observed Istio-specific resource types such as:

```text
VirtualService
Gateway
DestinationRule
PeerAuthentication
AuthorizationPolicy
...
```

Then I installed:

```text
istiod
```

which provided the Istio control plane.

Finally, I verified the Helm releases and confirmed that the `istiod` Deployment was:

```text
READY: 1/1
```

Therefore, this practical demonstrated the core Custom Resources concept:

```text
Istio Documentation
        │
        ▼
      Helm
        │
        ▼
   istio/base
        │
        ▼
     Istio CRDs
        │
        ▼
Kubernetes API Extended
        │
        ▼
   Custom Resources
        │
        ▼
      istiod
        │
        ▼
 Istio Control Plane
        │
        ▼
    Reconciliation
        │
        ▼
 Istio Functionality
```

---

<div align="center">

# 🚀 PRACTICAL COMPLETE

### Kubernetes Custom Resources — Istio

**Istio Documentation → Helm → istio/base → CRDs → istiod → Control Plane**

<br>

### 🔥 CRD → CR → Controller/Control Plane → Reconciliation → Functionality

</div>
