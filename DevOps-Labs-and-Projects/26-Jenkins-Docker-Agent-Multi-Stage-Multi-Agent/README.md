# 🚀 Jenkins Docker Agent — Multi-Stage & Multi-Agent Practical

## 🎯 Objective

Demonstrate how Jenkins can use **different Docker agents for different stages** of the same pipeline.

In this practical:

- The **Back-end** stage uses a Maven Docker image.
- The **Front-end** stage uses a Node.js Docker image.
- `agent none` is used at the pipeline level.
- Each stage defines its own Docker agent.

---

# 📁 Project Structure

```text
26-Jenkins-Docker-Agent-Multi-Stage-Multi-Agent
│
├── src
│   └── main
│       └── java
│           └── HelloWorld.java
│
├── Jenkinsfile
│
└── pom.xml
```

---

# 1. Java Application

The project contains a simple Java application:

```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello World from Jenkins");
    }
}
```

This project is configured as a Maven project using `pom.xml`.

---

# 2. Jenkinsfile

The pipeline uses `agent none` and assigns a different Docker agent to each stage.

```groovy
pipeline {
    agent none

    stages {
        stage('Back-end') {
            agent {
                docker {
                    image 'maven:3.8.1-adoptopenjdk-11'
                }
            }

            steps {
                sh 'mvn --version'
            }
        }

        stage('Front-end') {
            agent {
                docker {
                    image 'node:16-alpine'
                }
            }

            steps {
                sh 'node --version'
            }
        }
    }
}
```

---

# 3. Create a Jenkins Pipeline Job

Open Jenkins:

```text
Jenkins Dashboard
        ↓
New Item
        ↓
Enter Item Name
        ↓
Pipeline
        ↓
Create
```

Create the project as a **Pipeline** job.

---

# 4. Configure Pipeline from Git

Configure Jenkins to obtain the Jenkinsfile from the Git repository.

```text
Pipeline
    ↓
Pipeline script from SCM
    ↓
SCM → Git
    ↓
Repository URL
    ↓
Branch → main
    ↓
Script Path → Jenkinsfile
```

Jenkins will retrieve the `Jenkinsfile` from the repository.

---

# 5. Run the Pipeline

After configuring the Pipeline:

```text
Build Now
```

Jenkins reads the `Jenkinsfile` and starts executing the pipeline.

---

# 6. Pipeline Execution

The pipeline starts with:

```groovy
agent none
```

This means that there is **no single global agent** for the entire pipeline.

Instead, each stage defines its own execution environment.

```text
                 Jenkins Pipeline
                        │
                   agent none
                        │
              ┌─────────┴─────────┐
              ↓                   ↓
        Back-end Stage       Front-end Stage
              ↓                   ↓
        Maven Docker           Node Docker
           Agent                  Agent
```

---

# 7. Back-end Stage

The first stage is:

```groovy
stage('Back-end') {
```

It uses:

```groovy
agent {
    docker {
        image 'maven:3.8.1-adoptopenjdk-11'
    }
}
```

Jenkins uses the Maven Docker image as the execution environment.

Then it runs:

```bash
mvn --version
```

This verifies that Maven is available inside the Docker environment.

### Flow

```text
Jenkins
   ↓
Back-end Stage
   ↓
Maven Docker Image
   ↓
Docker Container
   ↓
mvn --version
```

---

# 8. Front-end Stage

After the Back-end stage completes, Jenkins moves to:

```groovy
stage('Front-end') {
```

This stage uses a different Docker image:

```groovy
agent {
    docker {
        image 'node:16-alpine'
    }
}
```

Jenkins then runs:

```bash
node --version
```

This verifies that Node.js is available inside the Docker environment.

### Flow

```text
Jenkins
   ↓
Front-end Stage
   ↓
Node Docker Image
   ↓
Docker Container
   ↓
node --version
```

---

# 9. Different Docker Agents

The important part of this practical is that the two stages use different Docker environments.

```text
Back-end
   │
   └── maven:3.8.1-adoptopenjdk-11
             │
             └── mvn --version


Front-end
   │
   └── node:16-alpine
             │
             └── node --version
```

Therefore, one Jenkins Pipeline can use multiple environments depending on the requirements of each stage.

---

# 10. Pipeline Result

Jenkins executes both stages:

```text
Back-end
   ✅

Front-end
   ✅
```

If both stages complete successfully:

```text
Finished: SUCCESS
```

The Jenkins pipeline is successful.

---

# 🔄 Complete Execution Flow

```text
Developer
    ↓
GitHub Repository
    ↓
Jenkins Pipeline Job
    ↓
Read Jenkinsfile
    ↓
agent none
    ↓
┌───────────────────────────┐
│ Back-end Stage            │
│                           │
│ Maven Docker Agent        │
│ maven:3.8.1-adoptopenjdk-11│
│                           │
│ mvn --version             │
└─────────────┬─────────────┘
              ↓
┌───────────────────────────┐
│ Front-end Stage           │
│                           │
│ Node Docker Agent         │
│ node:16-alpine            │
│                           │
│ node --version            │
└─────────────┬─────────────┘
              ↓
          SUCCESS
```

---

# 🧠 Key Concepts Learned

## `agent none`

```groovy
agent none
```

No global execution agent is assigned to the pipeline.

---

## Stage-Level Agent

Each stage can define its own agent:

```groovy
stage('Back-end') {
    agent {
        docker {
            image 'maven:3.8.1-adoptopenjdk-11'
        }
    }
}
```

and:

```groovy
stage('Front-end') {
    agent {
        docker {
            image 'node:16-alpine'
        }
    }
}
```

---

## Multi-Stage

One pipeline contains multiple stages:

```text
Back-end
   ↓
Front-end
```

---

## Multi-Agent

Different stages use different execution environments:

```text
Back-end  → Maven Docker Agent
Front-end → Node Docker Agent
```

---

# 🎯 What This Practical Demonstrates

This practical demonstrates:

```text
One Jenkins Pipeline
        ↓
Multiple Stages
        ↓
Different Docker Agents
        ↓
Different Tool Environments
```

For example:

```text
Java/Maven Application
        ↓
Maven Docker Agent

        +

Node.js Application
        ↓
Node Docker Agent
```

This approach allows each stage to use the tools and runtime versions it requires without installing every tool on one permanent Jenkins worker.

---

# 🚀 Final Mental Model

```text
                     Jenkins
                        │
                        ▼
                   Jenkinsfile
                        │
                   agent none
                        │
             ┌──────────┴──────────┐
             ↓                     ↓
       Back-end Stage        Front-end Stage
             ↓                     ↓
     Maven Docker Agent      Node Docker Agent
             ↓                     ↓
      mvn --version          node --version
             ↓                     ↓
          SUCCESS               SUCCESS
```

> **One Pipeline → Multiple Stages → Different Docker Agents → Isolated Tool Environments**
