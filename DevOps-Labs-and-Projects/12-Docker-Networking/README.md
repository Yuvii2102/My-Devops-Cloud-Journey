<div align="center">

# 🐳 DOCKER NETWORKING — BRIDGE & CUSTOM NETWORK

### 🔐 Container Communication, Network Isolation & Custom Bridge Network

![Docker](https://img.shields.io/badge/Docker-Networking-2496ED?style=for-the-badge\&logo=docker\&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge\&logo=ubuntu\&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-EC2-FF9900?style=for-the-badge\&logo=amazon-aws\&logoColor=white)

</div>

---

# 📌 Today's Learning

Today I learned and practically demonstrated **Docker Networking** using an AWS EC2 Ubuntu instance.

The main concepts covered were:

* Docker default `bridge` network
* Docker custom bridge network
* Creating `secure-network`
* Running containers on specific networks
* Inspecting container network configuration
* Container IP addresses
* Network isolation
* Testing connectivity using `ping`
* Connecting containers to a custom network
* Docker's internal DNS / container-name communication
* Understanding why containers on different networks cannot communicate directly
* Understanding the difference between the **Docker host** and a **Docker container**

---

# 🧠 What is Docker Networking?

Docker Networking allows containers to communicate with:

* Other containers
* The Docker host
* External networks / the internet

Docker provides networking mechanisms that determine **which containers can communicate with each other**.

A simplified architecture:

```text
                         Docker Host / EC2
                                │
               ┌────────────────┴────────────────┐
               │                                 │
        Default Bridge                     Custom Network
          (bridge)                      (secure-network)
               │                                 │
          ┌────┴────┐                     ┌──────┴──────┐
          │         │                     │             │
       login      logout                finance       payment
```

---

# 🌉 1. Docker Default Bridge Network

Docker automatically provides a default network called:

```bash
bridge
```

Check available Docker networks:

```bash
docker network ls
```

Example output:

```text
NETWORK ID     NAME             DRIVER    SCOPE
ef747d975ff8   bridge           bridge    local
d47843a3ebba   host             host      local
15efeb2ac09c   none             null      local
```

### Default Docker Networks

| Network  | Driver | Purpose                          |
| -------- | ------ | -------------------------------- |
| `bridge` | bridge | Default container networking     |
| `host`   | host   | Container shares host networking |
| `none`   | null   | No network connectivity          |

---

# 🐳 2. Running the `login` Container

The `login` container was created using the default Docker bridge network.

Check its configuration:

```bash
docker inspect login
```

The inspection showed:

```text
"NetworkMode": "bridge"
```

The `login` container received:

```text
IP Address: 172.17.0.3
Gateway:    172.17.0.1
```

The container was running the:

```text
nginx:latest
```

image.

The inspection confirmed that `login` was attached to the default `bridge` network and had IP address `172.17.0.3`.

---

# 🚪 3. Creating the `logout` Container

Another NGINX container named `logout` was created:

```bash
docker run -d --name logout nginx:latest
```

The purpose was to practice working with multiple containers and understand how Docker networking affects communication between them.

> **Note:** If no `--network` option is provided, Docker normally attaches the container to the default `bridge` network.

---

# 🔐 4. Creating a Custom Secure Network

To demonstrate network isolation, I created a custom Docker network:

```bash
docker network create secure-network
```

Docker returned a network ID:

```text
9302402016d72916fbdeba41d44a5fbf6fa7cbee6d5c93ebe565b0365e65bf7c
```

Then I verified it:

```bash
docker network ls
```

Output:

```text
NETWORK ID     NAME             DRIVER    SCOPE
ef747d975ff8   bridge           bridge    local
d47843a3ebba   host             host      local
15efeb2ac09c   none             null      local
9302402016d7   secure-network   bridge    local
```

This demonstrated that `secure-network` is a **custom bridge network**.

---

# 💳 5. Creating the `finance` Container on `secure-network`

The `finance` container was created using:

```bash
docker run -d --name finance --network=secure-network nginx:latest
```

> ⚠️ During the hands-on, I accidentally typed `docker run docker run ...`. Docker therefore interpreted `docker` as the image name and downloaded `docker:latest`. The correct command contains only one `docker run`.

The `finance` container was successfully configured with:

```text
NetworkMode: secure-network
```

and received:

```text
IP Address: 172.18.0.2
Gateway:    172.18.0.1
```

The Docker inspection confirmed that `finance` was attached to `secure-network` with IP `172.18.0.2`.

---

# 🔍 6. Inspecting the `finance` Container

Command:

```bash
docker inspect finance
```

Important networking information:

```text
NetworkMode: secure-network

Gateway:     172.18.0.1
IPAddress:   172.18.0.2
```

Docker also provided DNS names for the container:

```text
finance
97a20c199886
```

The container's network configuration showed `secure-network` and the DNS name `finance`.

---

# 🌐 7. Testing `finance` from the Docker Host

From the Ubuntu EC2 host:

```bash
ping 172.18.0.2
```

The host successfully reached the `finance` container:

```text
64 bytes from 172.18.0.2: icmp_seq=1 ttl=64 time=0.078 ms
64 bytes from 172.18.0.2: icmp_seq=2 ttl=64 time=0.054 ms
...
```

Final result:

```text
15 packets transmitted
15 received
0% packet loss
```

This proves that the **Docker host can communicate with the `finance` container**.

---

# 🔒 8. Network Isolation Demonstration

This was the main practical concept of today's session.

Current setup:

```text
                    Docker Host
                         │
             ┌───────────┴───────────┐
             │                       │
       Default bridge          secure-network
             │                       │
           login                   finance
         172.17.0.3              172.18.0.2
```

`login` belongs to:

```text
bridge
```

while `finance` belongs to:

```text
secure-network
```

The `login` container inspection confirmed:

```text
NetworkMode: bridge
IPAddress:   172.17.0.3
```

while `finance` was configured with:

```text
NetworkMode: secure-network
IPAddress:   172.18.0.2
```

## This configuration is visible in the container inspection output.

# 🧪 9. Testing Communication from `login` → `finance`

First, I entered the `login` container:

```bash
docker exec -it login /bin/bash
```

Inside the container:

```text
root@922ca6e4fc1e:/#
```

Then I tested the `finance` IP:

```bash
ping 172.18.0.2
```

The result was:

```text
PING 172.18.0.2 (172.18.0.2) 56(84) bytes of data.

73 packets transmitted, 0 received, 100% packet loss
```

### ✅ Result

```text
login → finance
❌ Communication failed
100% packet loss
```

This successfully demonstrated **network isolation**.

`login` was connected to the default `bridge` network, while `finance` was connected to `secure-network`.

---

# 🧩 10. Why `ping finance` Failed

Inside the `login` container, I also tried:

```bash
ping finance
```

The result was:

```text
ping: finance: No address associated with hostname
```

This happened because `login` was not attached to `secure-network`.

Docker's automatic container-name DNS works within the appropriate user-defined network. Since `login` and `finance` were not sharing the same custom network, `login` could not resolve `finance` by its container name.

The recorded experiment showed both the failed IP-based ping and failed `ping finance` lookup.

---

# 🧠 11. Important Difference: Host vs Container

One important concept I learned was the difference between running commands on the **Docker host** and inside a **container**.

### Docker Host

Example:

```text
ubuntu@ip-172-31-3-195:~$
```

Docker commands work here:

```bash
docker ps
docker run
docker exec
docker network ls
docker network inspect
```

### Inside Container

Example:

```text
root@922ca6e4fc1e:/#
```

The Docker CLI is not automatically available inside the container.

Therefore:

```bash
docker run ...
```

inside the container can result in:

```text
bash: docker: command not found
```

To return to the Docker host:

```bash
exit
```

---

# 🛠️ 12. Entering a Container as Root

To enter the `login` container as root:

```bash
docker exec -it -u root login /bin/bash
```

Or:

```bash
docker exec -it login /bin/bash
```

The resulting shell was:

```text
root@922ca6e4fc1e:/#
```

---

# 📡 13. Installing `ping` Inside the Container

Initially:

```bash
ping -V
```

returned:

```text
bash: ping: command not found
```

I accidentally typed:

```bash
apt-get install iputile-ping
```

which failed because the package name was incorrect.

The correct package is:

```bash
iputils-ping
```

I installed it using:

```bash
apt-get update
apt-get install -y iputils-ping
```

Then:

```bash
ping -V
```

returned:

```text
ping from iputils 20240905
```

This confirmed that `ping` was successfully installed.

---

# 🧪 14. Correct Ping Testing

### Test the `finance` container by IP

```bash
ping 172.18.0.2
```

### Test by container name

```bash
ping finance
```

However, `ping finance` only works when the containers are connected to the same user-defined network that provides Docker's internal DNS resolution.

---

# 🔄 15. Connecting `login` to `secure-network`

After demonstrating isolation, the next step is to connect `login` to the same custom network:

```bash
docker network connect secure-network login
```

Now the architecture becomes:

```text
                 secure-network
                /              \
               /                \
            login              finance
          172.18.x.x           172.18.0.2
```

Both containers are now members of the same network.

Then:

```bash
docker exec -it login /bin/bash
```

Inside `login`:

```bash
ping finance
```

should now be able to resolve `finance` through Docker's internal DNS and communicate with it.

---

# 🔥 16. Complete Networking Demonstration

The entire practical flow can be summarized as:

```text
                         DOCKER HOST
                              │
                 ┌────────────┴────────────┐
                 │                         │
          Default bridge             secure-network
                 │                         │
          ┌──────┴──────┐           ┌──────┴──────┐
          │             │           │             │
        login         logout      finance       payment
          │
       172.17.x.x
                                      172.18.0.2
```

### Before connecting `login`

```text
login ── bridge

finance ── secure-network

login ──X── finance
```

Result:

```text
100% packet loss
```

### After connecting `login`

```text
login ───────┐
             │
             ├── secure-network
             │
finance ─────┘
```

Result:

```text
login ────→ finance
     ✅ communication
```

---

# 📋 17. Important Commands Learned

### List Docker networks

```bash
docker network ls
```

### Create custom network

```bash
docker network create secure-network
```

### Run container on a custom network

```bash
docker run -d --name finance --network=secure-network nginx:latest
```

### Inspect container

```bash
docker inspect login
```

```bash
docker inspect finance
```

### Inspect a network

```bash
docker network inspect secure-network
```

### Connect an existing container to a network

```bash
docker network connect secure-network login
```

### Enter container

```bash
docker exec -it login /bin/bash
```

### Enter container as root

```bash
docker exec -it -u root login /bin/bash
```

### Install ping

```bash
apt-get update
apt-get install -y iputils-ping
```

### Test connectivity

```bash
ping 172.18.0.2
```

```bash
ping finance
```

### Exit container

```bash
exit
```

---

# ⚠️ 18. Mistakes I Encountered and What I Learned

### Mistake 1 — Wrong Docker exec syntax

Incorrect:

```bash
docker exec -it login/bin/bash
```

Correct:

```bash
docker exec -it login /bin/bash
```

---

### Mistake 2 — Wrong package name

Incorrect:

```bash
apt-get install iputile-ping
```

Correct:

```bash
apt-get install -y iputils-ping
```

---

### Mistake 3 — Running Docker inside a container

Incorrect context:

```bash
root@container:/# docker run ...
```

The Docker CLI was not available inside the container.

Correct:

```bash
exit
docker run ...
```

---

### Mistake 4 — Duplicate `docker run`

Incorrect:

```bash
docker run docker run -d --name finance --network=secure-network nginx:latest
```

Correct:

```bash
docker run -d --name finance --network=secure-network nginx:latest
```

---

### Mistake 5 — Typing an IP address as a command

Incorrect:

```bash
172.18.0.2
```

Correct:

```bash
ping 172.18.0.2
```

---

### Mistake 6 — Assuming container names work across every network

Inside `login`:

```bash
ping finance
```

returned:

```text
ping: finance: No address associated with hostname
```

because `login` was not connected to `secure-network`.

---

# 📊 19. Networking Comparison

| Feature                   | Default `bridge`  | Custom `secure-network`           |
| ------------------------- | ----------------- | --------------------------------- |
| Driver                    | bridge            | bridge                            |
| Automatically created     | ✅                 | ❌                                 |
| User-defined              | ❌                 | ✅                                 |
| Container isolation       | Basic             | Better controlled                 |
| Container-name DNS        | Limited           | ✅                                 |
| Custom network membership | ❌                 | ✅                                 |
| Example                   | `login`, `logout` | `finance`, `payment`              |
| Use case                  | Basic containers  | Application/service communication |

---

# 🏗️ 20. Real-World Architecture

A real application can use custom networks to separate different services.

```text
                         INTERNET
                            │
                            ▼
                      Load Balancer
                            │
                            ▼
                     ┌─────────────┐
                     │   Frontend  │
                     └──────┬──────┘
                            │
                     secure-network
                            │
              ┌─────────────┼─────────────┐
              │             │             │
              ▼             ▼             ▼
           Backend       Payment       Finance
              │
              │
              ▼
           Database
```

This allows applications to organize services into appropriate network boundaries instead of putting every container into one shared network.

---

# 🧠 21. Key Takeaways

> 🔹 Docker Networking controls communication between containers.

> 🔹 Docker provides default networks such as `bridge`, `host`, and `none`.

> 🔹 A custom bridge network can be created with `docker network create`.

> 🔹 Containers attached to different isolated networks cannot directly communicate with each other through those network interfaces.

> 🔹 `login` was on the default `bridge` network while `finance` was on `secure-network`.

> 🔹 `login` attempting to ping `finance` at `172.18.0.2` resulted in **100% packet loss**, demonstrating isolation.

> 🔹 A container can be connected to another network using `docker network connect`.

> 🔹 User-defined networks provide Docker's internal DNS-based container-name resolution.

> 🔹 `ping finance` is preferable to relying on a hard-coded container IP when testing communication on a user-defined network.

> 🔹 Container IP addresses can change, so applications should generally communicate using service/container names or other stable discovery mechanisms rather than hard-coded IP addresses.

---

# 🚀 Today's Practical Result

```text
                    🐳 DOCKER NETWORKING LAB

                           Docker Host
                               │
             ┌─────────────────┴─────────────────┐
             │                                   │
       Default Bridge                       secure-network
             │                                   │
       ┌─────┴─────┐                    ┌────────┴────────┐
       │           │                    │                 │
     login       logout              finance           payment
       │
       │
       └───────❌───────→ finance
             isolated

                  ↓ Network Connect

       login ───────────────→ finance
                  ✅
             communication
```

### 🏆 What I Successfully Demonstrated

```text
✅ Created Docker containers
✅ Used the default bridge network
✅ Created a custom bridge network
✅ Connected finance to secure-network
✅ Inspected Docker container networking
✅ Found container IP addresses
✅ Installed and used ping
✅ Tested host → container communication
✅ Tested login → finance communication
✅ Demonstrated 100% packet loss due to network isolation
✅ Tested Docker container-name resolution
✅ Learned docker network connect
✅ Learned the difference between host and container
✅ Troubleshot Docker networking errors
```

---

<div align="center">

# 🐳 DOCKER NETWORKING COMPLETE

### 🌉 Bridge Network → 🔐 Custom Network → 🔒 Isolation → 🔗 Container Communication

**Learn • Build • Break • Fix • Document • Repeat**

</div>
