# 🚀 Jenkins Docker Agent — Multi-Stage Multi-Agent Pipeline

## 🎯 Objective

In this practical, we learned how Jenkins can use **Docker containers as agents** and how to create a **Multi-Stage Multi-Agent Jenkins Pipeline**.

The complete flow is:

```text
GitHub
   ↓
Jenkinsfile
   ↓
Jenkins
   ↓
Pipeline
   ↓
Multiple Stages
   ↓
Different Docker Agents
   ↓
Back-end → Maven Docker Agent
Front-end → Node Docker Agent
   ↓
SUCCESS
```

---

# 1. 🐳 Docker as Jenkins Agent

Jenkins can use Docker containers as temporary execution environments.

Instead of installing every tool directly on the Jenkins server, Jenkins can start a Docker container containing the required tool.

For example:

```text
Jenkins
   ↓
Docker
   ↓
node:16-alpine
   ↓
Run Node.js commands
```

For a Java/Maven application:

```text
Jenkins
   ↓
Docker
   ↓
maven:3.8.1-adoptopenjdk-11
   ↓
Run Maven commands
```

---

# 2. 🔐 Docker Permissions for Jenkins

Jenkins needs permission to communicate with Docker.

We configured Docker access using:

```bash
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu
```

This allows Jenkins to execute Docker commands such as:

```bash
docker pull
docker run
docker stop
docker rm
```

After changing permissions, Jenkins was restarted.

---

# 3. 🔌 Docker Pipeline Plugin

We installed the Jenkins **Docker Pipeline** plugin.

Navigation:

```text
Manage Jenkins
      ↓
Plugins
      ↓
Available plugins
      ↓
Search: Docker Pipeline
      ↓
Install
```

The Docker Pipeline plugin allows us to use Docker containers inside Jenkins Pipeline syntax.

Example:

```groovy
agent {
    docker {
        image 'node:16-alpine'
    }
}
```

---

# 4. 🏗️ Creating the First Jenkins Pipeline

From the Jenkins Dashboard:

```text
New Item
    ↓
Enter item name
    ↓
Select Pipeline
    ↓
OK
```

We created:

```text
First-Jenkins
```

---

# 5. 🧪 First Docker Agent Pipeline

Our first Pipeline was:

```groovy
pipeline {
  agent {
    docker { image 'node:16-alpine' }
  }

  stages {
    stage('Test') {
      steps {
        sh 'node --version'
      }
    }
  }
}
```

---

# 6. 🧠 Understanding the First Pipeline

## `pipeline`

```groovy
pipeline {
```

This defines the Jenkins Pipeline.

---

## `agent`

```groovy
agent {
    docker {
        image 'node:16-alpine'
    }
}
```

This tells Jenkins:

> Run the Pipeline using a Docker container created from the `node:16-alpine` image.

---

## `stage`

```groovy
stage('Test') {
```

This creates a stage named:

```text
Test
```

A stage represents one logical part of the Pipeline.

---

## `steps`

```groovy
steps {
```

The commands that Jenkins needs to execute are placed inside `steps`.

---

## `sh`

```groovy
sh 'node --version'
```

This executes the Linux shell command:

```bash
node --version
```

The output was:

```text
v16.20.2
```

This confirmed that Node.js was available inside the Docker container.

---

# 7. 🔄 What Happened During Execution?

The process was:

```text
Jenkins
   ↓
Pull node:16-alpine Docker image
   ↓
Create Docker container
   ↓
Run node --version
   ↓
Output: v16.20.2
   ↓
Remove Docker container
   ↓
Pipeline SUCCESS
```

Jenkins console showed:

```text
+ node --version
v16.20.2
```

And finally:

```text
Finished: SUCCESS
```

Therefore, we confirmed that:

```text
Jenkins → Docker → Node.js
```

was working correctly.

---

# 8. 🏢 Multi-Stage Pipeline

A Jenkins Pipeline can contain multiple stages.

For example:

```text
Back-end
    ↓
Front-end
```

So:

```text
One Pipeline
      |
      ├── Back-end
      |
      └── Front-end
```

Each stage performs a different task.

---

# 9. 🤖 Multi-Agent Pipeline

Different stages can use different execution environments.

For example:

```text
Back-end  → Maven Docker Agent
Front-end → Node Docker Agent
```

So we can have:

```text
              Jenkins Pipeline
                    |
             agent none
                    |
          ┌─────────┴─────────┐
          ↓                   ↓
     Back-end             Front-end
          ↓                   ↓
   Maven Docker Agent    Node Docker Agent
```

This is called a:

# Multi-Stage Multi-Agent Pipeline

---

# 10. ⭐ `agent none`

The most important concept is:

```groovy
agent none
```

It means:

> Do not assign one common agent to the entire Pipeline.

Instead, each stage will define its own agent.

Example:

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
    }

    stage('Front-end') {
      agent {
        docker {
          image 'node:16-alpine'
        }
      }
    }
  }
}
```

Therefore:

```text
Pipeline
   |
   |-- agent none
   |
   ├── Back-end
   |      ↓
   |   Maven Docker
   |
   └── Front-end
          ↓
       Node Docker
```

---

# 11. ☕ Back-end Stage

The Back-end stage is:

```groovy
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
```

Here Jenkins uses:

```text
maven:3.8.1-adoptopenjdk-11
```

Docker image.

Then Jenkins runs:

```bash
mvn --version
```

The concept is:

```text
Back-end Stage
      ↓
Maven Docker Image
      ↓
Maven Docker Container
      ↓
mvn --version
```

---

# 12. 🌐 Front-end Stage

The Front-end stage is:

```groovy
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
```

Here Jenkins uses:

```text
node:16-alpine
```

Docker image.

Then Jenkins runs:

```bash
node --version
```

Output:

```text
v16.20.2
```

The concept is:

```text
Front-end Stage
      ↓
Node Docker Image
      ↓
Node Docker Container
      ↓
node --version
```

---

# 13. 🧩 Complete Multi-Stage Multi-Agent Pipeline

Our complete Jenkinsfile is:

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

# 14. 📦 Why Different Docker Agents?

Imagine a real application:

```text
Application
│
├── Back-end
│     └── Java + Maven
│
└── Front-end
      └── Node.js
```

The Back-end needs Maven.

The Front-end needs Node.js.

Instead of installing both environments directly on Jenkins, Docker provides the required environment for each stage.

```text
Back-end
   ↓
Maven Docker Container
   ↓
Maven commands


Front-end
   ↓
Node Docker Container
   ↓
Node commands
```

This keeps the execution environments isolated and appropriate for each stage.

---

# 15. 🆚 Single-Agent vs Multi-Agent

## Single-Agent

Example:

```groovy
pipeline {
  agent {
    docker {
      image 'node:16-alpine'
    }
  }

  stages {
    stage('Test') {
      steps {
        sh 'node --version'
      }
    }
  }
}
```

Concept:

```text
Pipeline
   ↓
One Docker Agent
   ↓
node:16-alpine
```

---

## Multi-Agent

Example:

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

Concept:

```text
Pipeline
   |
   ├── Back-end
   |      ↓
   |   Maven Docker Agent
   |
   └── Front-end
          ↓
       Node Docker Agent
```

---

# 16. 🐙 GitHub Repository

We used our own GitHub repository:

```text
https://github.com/Yuvii2102/My-Devops-Cloud-Journey
```

Inside the repository:

```text
My-Devops-Cloud-Journey
│
└── DevOps-Labs-and-Projects
    │
    └── 26-Jenkins-Docker-Agent-Multi-Stage-Multi-Agent
        │
        └── Jenkinsfile
```

The `Jenkinsfile` contains our Pipeline code.

---

# 17. 📝 Pipeline Script vs Pipeline Script from SCM

Jenkins provides two common ways to provide Pipeline code.

## Pipeline Script

We directly write the Pipeline inside Jenkins.

```text
Jenkins
   ↓
Pipeline Script
   ↓
Paste Jenkinsfile
```

This is useful for learning and quick testing.

---

## Pipeline Script from SCM

We store the Jenkinsfile inside GitHub.

```text
GitHub
   ↓
Jenkinsfile
   ↓
Jenkins
   ↓
Pipeline
```

SCM means:

```text
Source Code Management
```

In our practical, GitHub is our SCM.

---

# 18. ⚙️ Configure Pipeline from SCM

Go to:

```text
First-Jenkins
      ↓
Configure
      ↓
Pipeline
```

Under:

```text
Definition
```

select:

```text
Pipeline script from SCM
```

Then:

```text
SCM → Git
```

---

# 19. 🔗 Repository URL

Repository URL:

```text
https://github.com/Yuvii2102/My-Devops-Cloud-Journey
```

This tells Jenkins:

> This is the Git repository from which Jenkins should retrieve the Jenkinsfile.

---

# 20. 🔐 Credentials

Our repository is public, so we used:

```text
Credentials:
- none -
```

For a private GitHub repository, Jenkins would need appropriate credentials.

---

# 21. 🌿 Branch Specifier

We used:

```text
*/main
```

This tells Jenkins to use the:

```text
main
```

branch.

---

# 22. 📄 Script Path

Our Jenkinsfile is located at:

```text
DevOps-Labs-and-Projects/
26-Jenkins-Docker-Agent-Multi-Stage-Multi-Agent/
Jenkinsfile
```

Therefore the Script Path is:

```text
DevOps-Labs-and-Projects/26-Jenkins-Docker-Agent-Multi-Stage-Multi-Agent/Jenkinsfile
```

The important point:

> Script Path means the location of the Jenkinsfile inside the Git repository.

Repository structure:

```text
My-Devops-Cloud-Journey
        |
        └── DevOps-Labs-and-Projects
                 |
                 └── 26-Jenkins-Docker-Agent-Multi-Stage-Multi-Agent
                           |
                           └── Jenkinsfile
```

Therefore:

```text
Script Path =
DevOps-Labs-and-Projects/26-Jenkins-Docker-Agent-Multi-Stage-Multi-Agent/Jenkinsfile
```

---

# 23. ✅ Final Jenkins Configuration

Our Jenkins configuration was:

```text
Definition:
Pipeline script from SCM

SCM:
Git

Repository URL:
https://github.com/Yuvii2102/My-Devops-Cloud-Journey

Credentials:
- none -

Branch Specifier:
*/main

Script Path:
DevOps-Labs-and-Projects/26-Jenkins-Docker-Agent-Multi-Stage-Multi-Agent/Jenkinsfile
```

Then:

```text
Save
```

---

# 24. ▶️ Build Now

After saving the Pipeline:

```text
Build Now
```

Jenkins performs the following process:

```text
Jenkins
   ↓
Connect to GitHub
   ↓
Checkout Repository
   ↓
Find Jenkinsfile
   ↓
Read Pipeline
   ↓
Back-end Stage
   ↓
Maven Docker Container
   ↓
mvn --version
   ↓
Front-end Stage
   ↓
Node Docker Container
   ↓
node --version
   ↓
SUCCESS
```

---

# 25. 🖥️ Console Output

Jenkins confirmed that it obtained the Jenkinsfile from GitHub:

```text
Obtained DevOps-Labs-and-Projects/26-Jenkins-Docker-Agent-Multi-Stage-Multi-Agent/Jenkinsfile
from git https://github.com/Yuvii2102/My-Devops-Cloud-Journey
```

Then:

```text
[Pipeline] stage
[Pipeline] { (Back-end)
```

Jenkins used the Maven Docker image:

```text
maven:3.8.1-adoptopenjdk-11
```

Then the Front-end stage:

```text
[Pipeline] stage
[Pipeline] { (Front-end)
```

Jenkins used:

```text
node:16-alpine
```

And executed:

```text
+ node --version
v16.20.2
```

Finally:

```text
[Pipeline] End of Pipeline

Finished: SUCCESS
```

---

# 26. 📊 Jenkins Stage View

Jenkins displayed the stages:

```text
Start
  |
  ▼
Back-end ✓
  |
  ▼
Front-end ✓
  |
  ▼
End
```

Both stages completed successfully:

```text
Back-end   ✓
Front-end  ✓
```

---

# 27. 🔄 What Happens Internally?

When Jenkins executes this:

```groovy
agent {
    docker {
        image 'maven:3.8.1-adoptopenjdk-11'
    }
}
```

Jenkins effectively does something similar to:

```text
Jenkins
   ↓
Check Docker image
   ↓
Pull image if required
   ↓
Create temporary container
   ↓
Execute stage commands
   ↓
Stage completes
   ↓
Container is removed
```

Then for the next stage:

```text
Front-end
   ↓
node:16-alpine
   ↓
Create Node container
   ↓
Run Node commands
   ↓
Stage completes
   ↓
Container is removed
```

So each stage can have its own isolated environment.

---

# 28. 🏗️ Real-World Example

Consider a real application:

```text
Application
│
├── Back-end
│     └── Java + Maven
│
├── Front-end
│     └── Node.js
│
└── Testing
      └── Python
```

A Jenkins Pipeline could use:

```text
Back-end Stage
      ↓
Maven Docker Agent


Front-end Stage
      ↓
Node Docker Agent


Testing Stage
      ↓
Python Docker Agent
```

The same Jenkins Pipeline can therefore work with different technologies.

---

# 29. 🧠 Important Jenkins Concepts

| Concept | Meaning |
|---|---|
| `pipeline` | Defines the Jenkins Pipeline |
| `agent` | Defines where Jenkins executes |
| `agent none` | No global agent; individual stages choose their agents |
| `docker` | Uses a Docker container as an agent |
| `image` | Docker image used for the container |
| `stages` | Collection of Pipeline stages |
| `stage` | A logical part of the Pipeline |
| `steps` | Commands executed inside a stage |
| `sh` | Executes a shell command |
| `Jenkinsfile` | File containing the Jenkins Pipeline |
| `SCM` | Source Code Management |
| `Pipeline script from SCM` | Jenkins gets the Pipeline script from Git |
| `Repository URL` | Git repository Jenkins should access |
| `Branch Specifier` | Branch Jenkins should use |
| `Script Path` | Location of the Jenkinsfile inside the repository |

---

# 30. 🎯 What This Practical Demonstrates

This practical demonstrates:

```text
✓ Jenkins Pipeline
✓ Docker as Jenkins Agent
✓ Docker Pipeline Plugin
✓ Pipeline Script
✓ Pipeline Script from SCM
✓ GitHub as SCM
✓ Jenkinsfile
✓ Repository URL
✓ Branch Specifier
✓ Script Path
✓ Multi-Stage Pipeline
✓ Multi-Agent Pipeline
✓ agent none
✓ Stage-level Docker Agents
✓ Maven Docker Agent
✓ Node Docker Agent
✓ Git Checkout
✓ Docker Container Creation
✓ Pipeline Execution
✓ Jenkins Stage View
✓ Console Output
✓ Successful Pipeline Execution
```

---

# 31. 🏆 Complete Architecture

```text
                         GITHUB
                           |
                           |
                My-Devops-Cloud-Journey
                           |
                           ▼
                      Jenkinsfile
                           |
                           ▼
                         JENKINS
                           |
                           ▼
                       PIPELINE
                           |
                      agent none
                           |
             ┌─────────────┴─────────────┐
             │                           │
             ▼                           ▼
       BACK-END STAGE              FRONT-END STAGE
             │                           │
             ▼                           ▼
     Maven Docker Agent           Node Docker Agent
             │                           │
             ▼                           ▼
      Maven Container              Node Container
             │                           │
             ▼                           ▼
      mvn --version               node --version
             │                           │
             ▼                           ▼
         SUCCESS                     SUCCESS
             │                           │
             └─────────────┬─────────────┘
                           ▼
                    PIPELINE SUCCESS
```

---

# 32. 🧠 Final Understanding

The entire concept can be remembered very simply:

```text
ONE PIPELINE
     |
     ├── MULTIPLE STAGES
     |
     └── EACH STAGE CAN USE A DIFFERENT AGENT
```

In our practical:

```text
Back-end
   ↓
Maven Docker Agent
   ↓
mvn --version


Front-end
   ↓
Node Docker Agent
   ↓
node --version
```

And because our Jenkinsfile is stored in GitHub:

```text
GitHub
   ↓
Repository
   ↓
Jenkinsfile
   ↓
Jenkins
   ↓
Pipeline from SCM
   ↓
Multi-Stage
   ↓
Multi-Agent
   ↓
Docker Containers
   ↓
SUCCESS ✅
```

# 🎉 Jenkins Docker Agent — Multi-Stage Multi-Agent Practical Completed Successfully!

```text
Back-end  → Maven Docker Agent → SUCCESS ✅
Front-end → Node Docker Agent  → SUCCESS ✅
```
