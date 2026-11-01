# 🐳 Docker Compose – Complete Beginner Notes

## 1. What is Docker?

Docker is a platform used to build, run and manage containers.

Imagine a developer creates a Python application. To run this application on different machines, we need Python and all its required dependencies.

Instead of installing everything separately on every machine, we can package the application and its dependencies into a Docker image and run it as a container.

Docker helps us manage the complete container lifecycle.

### Docker Lifecycle

There are three main steps:

1. Create a Dockerfile.
2. Build a Docker image.
3. Run a Docker container.

**Example:**

```bash
# Build a Docker image
docker build -t my-python-app .

# Run a container
docker run -d -p 5000:5000 my-python-app

# Check running containers
docker ps

# Stop a container
docker stop <container-id>
```

### Important Docker Terms

| Term | Meaning |
|---|---|
| Dockerfile | Contains instructions to build an image |
| Docker Image | A package used to create containers |
| Docker Container | A running instance of an image |
| Docker CLI | Used to communicate with Docker through commands |

---

## 2. Why Do We Need Docker Compose?

Imagine you are working on an e-commerce application.

This application may contain:

- Frontend application
- Backend application
- Payment service
- User service
- MySQL database
- Redis cache
- Nginx web server

Each service may run inside a separate container.

If we use Docker commands individually, we need to build and run every container separately.

We also need to manage:

- Container dependencies
- Port mapping
- Networking
- Volumes
- Starting and stopping containers

Managing all these things individually becomes difficult when an application has many containers.

This is where Docker Compose comes in.

## 3. What is Docker Compose?

Docker Compose is a tool used to define and manage multi-container applications using a single YAML configuration file.

Instead of running multiple Docker commands individually, we can define all our services inside one file called `compose.yaml`.

Then we can start the entire application using one command.

```bash
docker compose up -d
```

To stop and remove the containers:

```bash
docker compose down
```

**In simple words:**

Docker helps us build and run containers, whereas Docker Compose helps us manage multiple services together.

---

## 4. What is a Dockerfile?

A Dockerfile is a text file that contains instructions to build a Docker image.

It tells Docker what is required to prepare our application inside an image.

### Example Dockerfile

```dockerfile
FROM python:3.12

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

CMD ["python", "app.py"]
```

### Explanation

| Instruction | Purpose |
|---|---|
| FROM | Selects the base image |
| WORKDIR | Sets the working directory |
| COPY | Copies files into the image |
| RUN | Executes commands while building the image |
| CMD | Specifies the default command when the container starts |

**Remember:** A Dockerfile explains how to build an image.

---

## 5. What is a YAML File?

YAML stands for YAML Ain't Markup Language.

It is a simple and readable format used to write configuration files.

YAML is commonly used in:

- Docker Compose
- Kubernetes
- Ansible
- GitHub Actions
- CI/CD pipelines

### Example YAML File

```yaml
name: my-project

services:
  web:
    image: nginx
    ports:
      - "8080:80"

  redis:
    image: redis
```

Here, we are defining two services: Nginx and Redis.

**Remember:** YAML is a format used to write configuration in a structured way.

---

## 6. Dockerfile vs Docker Compose YAML

Both files are important, but they have different purposes.

| Dockerfile | Compose YAML |
|---|---|
| Contains instructions to build an image | Defines how application services should run |
| Used by Docker | Used by Docker Compose |
| Uses FROM, RUN, COPY and CMD | Uses services, image, build, ports and volumes |
| Usually named Dockerfile | Usually named compose.yaml |

### How Do They Work Together?

1. Dockerfile contains instructions to build an image.
2. Docker builds the image using the Dockerfile.
3. Compose YAML defines the services and their configurations.
4. Docker Compose uses the image or builds it using the Dockerfile.
5. Docker Compose creates and starts the required containers.

**Note:** Docker Compose can also use existing images directly without requiring a Dockerfile for every service.

---

## 7. Understanding Nginx, Node.js and Redis

In today's class, we learned an example containing Nginx, two Node.js application instances and Redis.

Before understanding the Compose file, let's understand what each component does.

### A. What is Node.js?

Node.js is a JavaScript runtime environment.

It allows developers to execute JavaScript outside a web browser, especially on the server side.

In our example, Node.js is used to run the backend application.

### B. Why Are There Two Node.js Instances?

We have two copies of the same backend application:

- Web 1
- Web 2

Both run the same application code.

Running multiple instances allows us to distribute incoming requests instead of sending everything to a single backend instance.

### C. What is Nginx?

Nginx is a web server that can also work as a reverse proxy and load balancer.

In our example, Nginx receives requests from users and forwards them to the Node.js instances.

For example:

```text
Request 1 → Web 1
Request 2 → Web 2
Request 3 → Web 1
Request 4 → Web 2
```

### What is Load Balancing?

Load balancing means distributing incoming requests across multiple backend servers.

It helps prevent a single server from handling all the traffic.

### What is Round Robin?

Round Robin is a load-balancing method where requests are distributed between servers in a rotating order.

Example:

```text
Web 1 → Web 2 → Web 1 → Web 2
```

### D. What is Redis?

Redis is an in-memory data store commonly used for caching.

Caching means storing frequently used information so that it can be accessed quickly.

In today's practical, Redis was used to store the number of visits.

For example:

```text
First request:
Web 1
Number of visits: 1

Second request:
Web 2
Number of visits: 2

Third request:
Web 1
Number of visits: 3
```

Both Web 1 and Web 2 communicate with the same Redis instance.

So even when the request goes to a different Node.js instance, the visit count continues from the previous value.

---

## 8. Understanding the Complete Architecture

The architecture contains four main components:

```text
             USER
               |
               |
             NGINX
          (Load Balancer)
               |
          -------------
          |           |
        WEB 1       WEB 2
       Node.js     Node.js
          |           |
          -------------
               |
             REDIS
         (Stores Visit Count)
```

### How Does a Request Work?

1. A user opens the application in a browser.
2. Nginx receives the request.
3. Nginx forwards the request to Web 1 or Web 2.
4. The Node.js application processes the request.
5. The application communicates with Redis to get and update the visit count.
6. The backend sends the response through Nginx.
7. The user sees the result in the browser.

This is how all the components work together.

---

## 9. What is Docker Compose File?

A Docker Compose file is a YAML file used to define and manage multiple application services.

The default file name can be `compose.yaml`.

### Example Compose File

```yaml
services:

  web1:
    build: ./web
    ports:
      - "81:5000"

  web2:
    build: ./web
    ports:
      - "82:5000"

  nginx:
    build: ./nginx
    ports:
      - "80:80"
    depends_on:
      - web1
      - web2

  redis:
    image: redis:alpine
```

### Explanation of the Fields

| Field | Purpose |
|---|---|
| services | Defines all application services |
| web1 | First backend service |
| web2 | Second backend service |
| build | Location of the Dockerfile and build context |
| image | Uses an existing Docker image |
| ports | Maps host ports to container ports |
| depends_on | Defines service startup dependencies |

### Understanding Port Mapping

Example:

```yaml
ports:
  - "81:5000"
```

Here:

- 81 is the host machine port.
- 5000 is the container port.

This means we can access the first application instance through port 81 on the host machine.

Similarly, the second instance uses host port 82.

### What is depends_on?

`depends_on` is used to define the startup order between services.

For example:

```yaml
nginx:
  build: ./nginx
  depends_on:
    - web1
    - web2
```

This tells Docker Compose to start the Web 1 and Web 2 services before starting Nginx.

**Important:** `depends_on` does not automatically guarantee that an application is fully ready. Health checks can be used when a service must wait until another service is ready.

---

## 10. Docker vs Docker Compose

| Docker | Docker Compose |
|---|---|
| Used to build and run containers | Used to manage multiple services together |
| Uses Dockerfile to build images | Uses Compose YAML to define services |
| Uses docker build | Uses docker compose build |
| Uses docker run | Uses docker compose up |
| Individual container management | Multi-container application management |

### Without Docker Compose

We need to execute multiple commands individually:

```bash
docker build -t my-app .
docker run -d my-app
docker stop <container-id>
```

For multiple services, we need to manage each service separately.

### With Docker Compose

We define all the services inside one YAML file.

Then we use:

```bash
docker compose up -d
```

This starts all the required services.

---

## 11. Important Docker Compose Commands

| Command | Purpose |
|---|---|
| `docker compose up` | Creates and starts services |
| `docker compose up -d` | Starts services in the background |
| `docker compose down` | Stops and removes containers and default network |
| `docker compose ps` | Shows Compose services |
| `docker compose logs` | Displays service logs |
| `docker compose logs -f` | Continuously displays logs |
| `docker compose build` | Builds service images |
| `docker compose stop` | Stops services |
| `docker compose start` | Starts stopped services |
| `docker compose restart` | Restarts services |
| `docker compose pull` | Pulls required images |
| `docker compose config` | Validates and displays the Compose configuration |
| `docker compose down -v` | Also removes Compose-managed volumes |

---

## 12. Where is Docker Compose Used?

Docker Compose is commonly used in three areas.

### 1. Local Development

Developers can run all the services required for their application on their local machine.

For example:

- Frontend
- Backend
- Database
- Redis

Instead of starting everything individually, they can execute:

```bash
docker compose up -d
```

### 2. CI/CD Pipeline

Docker Compose can be used in CI/CD pipelines to start multiple services and test an application.

For example, GitHub Actions can start the application using Docker Compose, execute tests and then stop the containers.

### 3. Testing

QA engineers can use Docker Compose to start all the required services and test application changes before deploying them to other environments.

---

## 13. Docker Compose vs Kubernetes

Docker Compose and Kubernetes have different purposes.

### Docker Compose

It is commonly used for:

- Local development
- Multi-container applications
- Application testing
- Lightweight CI/CD testing

### Kubernetes

Kubernetes is a container orchestration platform used to manage containerized applications across multiple machines.

It provides features such as:

- Auto-healing
- Scaling
- Load balancing
- Rolling updates
- Service discovery
- Cluster management

### Comparison

| Docker Compose | Kubernetes |
|---|---|
| Mainly used for multi-container applications | Used for container orchestration |
| Commonly used for local development | Commonly used for production workloads |
| Simple service management | Advanced orchestration |
| Basic scaling capabilities | Advanced scaling capabilities |
| No built-in multi-node cluster orchestration | Supports multi-node clusters |

**Important:** Docker Swarm is the container orchestration solution in the Docker ecosystem that is more directly comparable to Kubernetes.

---

## 14. Docker vs Docker Compose vs Docker Swarm vs Kubernetes

| Technology | Purpose |
|---|---|
| Docker | Builds images and runs containers |
| Docker Compose | Manages multiple services using YAML |
| Docker Swarm | Orchestrates containers across a cluster |
| Kubernetes | Provides container orchestration across a cluster |

---

## 15. Practical Learning Checklist

Things I need to practise after learning Docker Compose:

- [ ] Revise Dockerfile.
- [ ] Understand Docker images and containers.
- [ ] Practise Docker build and run commands.
- [ ] Understand YAML syntax.
- [ ] Install Docker Compose.
- [ ] Create a simple Node.js application.
- [ ] Write a Dockerfile.
- [ ] Create a compose.yaml file.
- [ ] Run an application using Docker Compose.
- [ ] Understand port mapping.
- [ ] Understand Docker networking.
- [ ] Understand volumes in Compose.
- [ ] Practise depends_on.
- [ ] Run Redis with Node.js.
- [ ] Configure Nginx as a load balancer.
- [ ] Run multiple application instances.
- [ ] Practise Docker Compose up and down.

---

## 16. Useful Learning Resources

1. [Docker Compose Official Documentation](https://docs.docker.com/compose/)
2. [Docker Awesome Compose GitHub Repository](https://github.com/docker/awesome-compose)

The Awesome Compose repository contains many practical examples using different programming languages, databases and services.

---

## Final Notes

Today I learned how Docker Compose helps us manage multiple containers using a single YAML file.

I also understood the difference between Dockerfile and Compose YAML, how Nginx works as a load balancer, how Node.js runs backend applications and how Redis stores frequently used information.

The main thing I learned is that Docker is used to build and run containers, while Docker Compose makes managing multiple application services much easier.

**My key takeaway:**

Dockerfile = How to build an image.

Compose YAML = How to configure and run multiple services together.
