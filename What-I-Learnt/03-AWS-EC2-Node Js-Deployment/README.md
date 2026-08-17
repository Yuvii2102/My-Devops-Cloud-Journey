<div align="center">

# 🚀 DEPLOYING A NODE.JS APPLICATION ON AWS EC2

### ☁️ Node.js • Express.js • AWS EC2 • Ubuntu • Git • npm • Security Groups

<p>
  <img src="https://img.shields.io/badge/AWS-EC2-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white"/>
  <img src="https://img.shields.io/badge/Node.js-22.x-339933?style=for-the-badge&logo=node.js&logoColor=white"/>
  <img src="https://img.shields.io/badge/Express.js-Framework-000000?style=for-the-badge&logo=express&logoColor=white"/>
  <img src="https://img.shields.io/badge/Ubuntu-Linux-E95420?style=for-the-badge&logo=ubuntu&logoColor=white"/>
  <img src="https://img.shields.io/badge/Git-Version%20Control-F05032?style=for-the-badge&logo=git&logoColor=white"/>
</p>

### 🚀 From Local Node.js Application → GitHub → AWS EC2 → Live Website

</div>

---

# 📌 PROJECT OVERVIEW

In this project, I deployed a **Node.js application on an AWS EC2 Ubuntu server** and made it accessible through the internet using the EC2 public IP address and port `3000`.

This project covers the complete deployment process:

```text
Local Node.js Application
          │
          ▼
       GitHub
          │
          ▼
     AWS EC2 Instance
          │
          ▼
        Ubuntu
          │
          ├── Git
          ├── Node.js
          └── npm
          │
          ▼
     Clone Application
          │
          ▼
       Configure .env
          │
          ▼
      npm install
          │
          ▼
     npm run start
          │
          ▼
      Port 3000
          │
          ▼
 AWS Security Group
          │
          ▼
     Public IPv4
          │
          ▼
      🌐 Browser
          │
          ▼
   🚀 LIVE APPLICATION
```

---

# 🎯 PROJECT OBJECTIVES

Through this project, I learned how to:

- Create an AWS EC2 instance
- Configure Ubuntu on EC2
- Connect to EC2 using SSH
- Install Git
- Install Node.js and npm
- Clone a Node.js project from GitHub
- Configure environment variables using `.env`
- Install project dependencies
- Run a Node.js/Express application
- Configure AWS Security Group inbound rules
- Open port `3000`
- Access the application using the EC2 public IPv4 address
- Deploy a Node.js application to AWS ☁️🚀

---

# 🧰 TECHNOLOGIES USED

| Technology | Purpose |
|---|---|
| ☁️ AWS EC2 | Cloud virtual server |
| 🐧 Ubuntu | Operating system |
| 🟢 Node.js | JavaScript runtime |
| 📦 npm | Package and dependency management |
| 🚂 Express.js | Backend web framework |
| 🐙 GitHub | Source code hosting |
| 🔧 Git | Version control |
| 🔐 AWS Security Group | Network traffic control |
| 🔑 `.env` | Environment configuration |
| 💳 Stripe | Payment integration used by the application |

---

# 🟢 PART 01 — TESTING THE PROJECT LOCALLY

Before deploying the application to AWS, the project can be tested locally.

## 1️⃣ Clone the Project

```bash
git clone https://github.com/verma-kunal/AWS-Session.git
```

Move into the project:

```bash
cd AWS-Session
```

---

## 2️⃣ Configure Environment Variables

Create a `.env` file in the project root.

```env
DOMAIN=""
PORT=3000
STATIC_DIR="./client"

PUBLISHABLE_KEY=""
SECRET_KEY=""
```

### 🔑 Environment Variables

| Variable | Purpose |
|---|---|
| `DOMAIN` | Domain/IP used by the application |
| `PORT` | Port on which the Node.js server runs |
| `STATIC_DIR` | Location of static/frontend files |
| `PUBLISHABLE_KEY` | Stripe publishable key |
| `SECRET_KEY` | Stripe secret key |

> ⚠️ Never expose your Stripe `SECRET_KEY` publicly.

---

## 3️⃣ Install Dependencies

```bash
npm install
```

---

## 4️⃣ Start the Application

```bash
npm run start
```

Expected output:

```text
Server listening on port: 3000
```

The application can now be tested locally.

---

# ☁️ PART 02 — SET UP AN AWS EC2 INSTANCE

The next step is to create a cloud server where the Node.js application will run.

## 1️⃣ Create an IAM User

Create an IAM user and use it to access the AWS Console.

For this learning project:

- Access Type → Password
- Permissions → Admin

> ⚠️ In production environments, use the principle of least privilege instead of Administrator access.

---

## 2️⃣ Create an EC2 Instance

Go to:

```text
AWS Console
     ↓
EC2
     ↓
Instances
     ↓
Launch Instance
```

Configure the instance:

| Configuration | Value |
|---|---|
| OS Image | Ubuntu |
| Instance Type | t2.micro |
| Key Pair | Create a new key pair |
| Key File | `.pem` |

Download the `.pem` file and keep it secure.

---

# 🔐 PART 03 — CONNECT TO THE EC2 INSTANCE USING SSH

After launching the EC2 instance, connect to it using SSH.

```bash
ssh -i instance.pem ubuntu@<PUBLIC_IP_ADDRESS>
```

> ⚠️ The correct Ubuntu username is `ubuntu`, not `ubunutu`.

After successful login, the terminal will look similar to:

```text
ubuntu@ip-172-31-31-76:~$
```

This means we are now connected to the AWS EC2 Ubuntu server.

---

# 🐧 PART 04 — CONFIGURING UBUNTU ON THE REMOTE VM

Once connected to EC2, configure the Ubuntu environment.

## 1️⃣ Update Packages

```bash
sudo apt update
```

This updates the package lists.

---

## 2️⃣ Install Git

Git is required to clone the project from GitHub.

```bash
sudo apt install git -y
```

Verify Git:

```bash
git --version
```

---

## 3️⃣ Install Node.js and npm

```bash
sudo apt install nodejs npm -y
```

Verify Node.js:

```bash
node -v
```

Verify npm:

```bash
npm -v
```

During this deployment, Node.js was successfully installed and the application was running with:

```text
Node.js v22.22.1
```

---

# 🚀 PART 05 — DEPLOYING THE PROJECT ON AWS

Now the Node.js application is deployed to the EC2 server.

## 1️⃣ Clone the Project on the Remote VM

Inside the EC2 Ubuntu terminal:

```bash
git clone https://github.com/verma-kunal/AWS-Session.git
```

Move into the project directory:

```bash
cd AWS-Session
```

Check the project files:

```bash
ls
```

---

# 🔐 PART 06 — CONFIGURE THE `.env` FILE ON EC2

The environment variables need to be configured on the EC2 server.

Create the `.env` file using Vim:

```bash
vim .env
```

Press:

```text
i
```

Then enter:

```env
DOMAIN=""
PORT=3000
STATIC_DIR="./client"

PUBLISHABLE_KEY="YOUR_STRIPE_PUBLISHABLE_KEY"
SECRET_KEY="YOUR_STRIPE_SECRET_KEY"
```

Save and exit Vim:

```text
ESC
:wq
ENTER
```

Verify the file:

```bash
ls -la
```

You should see:

```text
.env
```

> 🔒 Keep `.env` private and never commit your Stripe secret key to GitHub.

---

# 📦 PART 07 — INSTALL PROJECT DEPENDENCIES

Inside the project directory:

```bash
npm install
```

This installs the dependencies required by the Node.js application.

---

# ▶️ PART 08 — START THE NODE.JS APPLICATION

Run:

```bash
npm run start
```

Expected output:

```text
> stripe-integration@1.0.0 start
> node server.js

Server listening on port: 3000
```

🎉 The Node.js application is now running on the EC2 server.

---

# 🔓 PART 09 — CONFIGURE AWS SECURITY GROUP

The Node.js application is running on:

```text
Port: 3000
```

However, the application must be allowed through the EC2 Security Group before it can be accessed from the internet.

Go to:

```text
AWS Console
     ↓
EC2
     ↓
Instances
     ↓
Select Instance
     ↓
Security
     ↓
Security Groups
     ↓
Inbound Rules
     ↓
Edit Inbound Rules
```

Add the following inbound rule:

| Type | Port | Source |
|---|---:|---|
| Custom TCP | 3000 | `0.0.0.0/0` |

Save the rule.

> 📌 The Security Group controls which incoming network traffic can reach the EC2 instance.

---

# 🌐 PART 10 — ACCESS THE DEPLOYED APPLICATION

After configuring the Security Group, find the **Public IPv4 address** of the EC2 instance.

Example:

```text
18.207.96.65
```

Since the Node.js server is running on port `3000`, open:

```text
http://18.207.96.65:3000
```

Or:

```text
http://<PUBLIC_IPV4>:3000
```

🎉 The Node.js application is now accessible through the internet.

---

# 🏗️ DEPLOYMENT ARCHITECTURE

```text
                         🌐 INTERNET
                              │
                              │ HTTP :3000
                              ▼
                    ┌───────────────────┐
                    │   EC2 PUBLIC IP   │
                    │   :3000           │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │ AWS SECURITY      │
                    │ GROUP             │
                    │                   │
                    │ Inbound TCP 3000  │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │    AWS EC2        │
                    │    Ubuntu         │
                    │                   │
                    │    Node.js        │
                    │       ↓           │
                    │    Express.js     │
                    │       ↓           │
                    │    server.js      │
                    │       ↓           │
                    │      :3000        │
                    └───────────────────┘
```

---

# 🔄 COMPLETE DEPLOYMENT FLOW

```text
┌──────────────────────┐
│ Local Node.js App    │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│       GitHub         │
│    Source Code       │
└──────────┬───────────┘
           │
           │ git clone
           ▼
┌──────────────────────┐
│      AWS EC2         │
│       Ubuntu         │
└──────────┬───────────┘
           │
           ├── Install Git
           │
           ├── Install Node.js
           │
           ├── Install npm
           │
           └── Configure .env
                    │
                    ▼
             ┌──────────────┐
             │ npm install  │
             └──────┬───────┘
                    │
                    ▼
             ┌──────────────┐
             │ npm run start│
             └──────┬───────┘
                    │
                    ▼
               Node.js :3000
                    │
                    ▼
             AWS Security Group
                    │
                    ▼
               Public IPv4
                    │
                    ▼
               🌐 Browser
                    │
                    ▼
             🚀 LIVE WEBSITE
```

---

# 🧪 TROUBLESHOOTING

## ❌ Error: Unable to locate package npm

If npm cannot be found:

```bash
sudo apt update
sudo apt install nodejs npm -y
```

Then verify:

```bash
node -v
npm -v
```

---

## ❌ Error: Cannot find module 'express'

Run:

```bash
npm install
```

If Express is not listed in the project dependencies:

```bash
npm install express
```

Then:

```bash
npm run start
```

---

## ❌ Error: `paths[1]` argument must be a string

This occurred because the application expected a required environment variable/configuration value.

Creating and configuring the `.env` file resolved the configuration problem.

---

## ❌ Website Cannot Be Reached

First check whether the Node.js application is running:

```bash
npm run start
```

Expected:

```text
Server listening on port: 3000
```

Check whether port `3000` is listening:

```bash
sudo ss -tulpn | grep 3000
```

Then verify the EC2 Security Group contains:

```text
Custom TCP
Port: 3000
Source: 0.0.0.0/0
```

Finally, use the **Public IPv4 address**:

```text
http://PUBLIC_IP:3000
```

Do not use the EC2 private IP:

```text
172.31.x.x
```

---

# 📸 DEPLOYMENT RESULT

<div align="center">

### 🚀 APPLICATION SUCCESSFULLY DEPLOYED ON AWS EC2

The Node.js application is running successfully on the EC2 Ubuntu server and is accessible through the EC2 public IPv4 address on port `3000`.

</div>

### 🖼️ Live Deployment Screenshot

Add the screenshot to your project repository:

```text
images/
└── aws-ec2-nodejs-deployment.png
```

Then display it in this README:

```html
<div align="center">

<img src="./images/aws-ec2-nodejs-deployment.png" width="95%" alt="Node.js Application Deployed on AWS EC2"/>

</div>
```

---

# 📚 IMPORTANT COMMANDS USED

```bash
# Update Ubuntu packages
sudo apt update

# Install Git
sudo apt install git -y

# Install Node.js and npm
sudo apt install nodejs npm -y

# Check Node.js version
node -v

# Check npm version
npm -v

# Clone the project
git clone https://github.com/verma-kunal/AWS-Session.git

# Enter the project
cd AWS-Session

# Create environment file
vim .env

# Install project dependencies
npm install

# Start the application
npm run start

# Check port 3000
sudo ss -tulpn | grep 3000
```

---

# 🔐 SECURITY NOTES

Never commit sensitive credentials to GitHub.

Keep these values private:

```text
SECRET_KEY
AWS Access Keys
Private SSH Keys
.env
instance.pem
```

Add `.env` to `.gitignore`:

```text
.env
```

Never upload:

```text
instance.pem
```

to GitHub.

> 🔒 Secret credentials should always be protected and stored securely.

---

# 🧠 KEY LEARNINGS

Through this project, I learned:

| Concept | What I Learned |
|---|---|
| ☁️ AWS EC2 | How to create and use a cloud server |
| 🐧 Ubuntu | How to configure a Linux server |
| 🔐 SSH | How to remotely connect to EC2 |
| 🐙 Git | How to clone source code |
| 🟢 Node.js | How to run JavaScript applications on a server |
| 📦 npm | How to install project dependencies |
| 🚂 Express | How the Node.js web server runs |
| 🔑 `.env` | How application configuration is managed |
| 🔓 Security Groups | How AWS controls inbound traffic |
| 🌐 Public IP | How to expose the application to users |
| 🚀 Deployment | How to move an application from local development to AWS |

---

# 🎯 WHAT I BUILT

```text
                 🚀 NODE.JS AWS DEPLOYMENT

                         GitHub
                            │
                            ▼
                     Node.js Project
                            │
                            ▼
                       AWS EC2
                            │
                    ┌───────┴───────┐
                    │    Ubuntu     │
                    │               │
                    │    Node.js    │
                    │       ↓       │
                    │    Express    │
                    │       ↓       │
                    │   server.js   │
                    └───────┬───────┘
                            │
                         Port 3000
                            │
                            ▼
                    Security Group
                            │
                            ▼
                       Public IP
                            │
                            ▼
                        🌐 Browser
                            │
                            ▼
                     🎉 LIVE APP
```

---

# 📈 PROJECT STATUS

| Stage | Status |
|---|---|
| Project cloned | ✅ Complete |
| `.env` configured | ✅ Complete |
| Dependencies installed | ✅ Complete |
| AWS EC2 created | ✅ Complete |
| Ubuntu configured | ✅ Complete |
| Git installed | ✅ Complete |
| Node.js installed | ✅ Complete |
| npm installed | ✅ Complete |
| Application started | ✅ Complete |
| Port `3000` configured | ✅ Complete |
| Security Group configured | ✅ Complete |
| Application accessible from browser | ✅ Complete |
| 🚀 AWS Deployment | ✅ COMPLETE |

---

# 🔮 NEXT LEVEL DEVOPS IMPROVEMENTS

The current deployment is a basic EC2 deployment.

It can later be improved into a more production-style DevOps architecture:

```text
                 GitHub
                    │
                    ▼
              GitHub Actions
                    │
                    ▼
                   CI/CD
                    │
                    ▼
                 AWS EC2
                    │
                    ▼
                  Nginx
                    │
                    ▼
             Reverse Proxy
                    │
                    ▼
             Node.js / Express
                    │
                    ▼
              PM2 Process Manager
                    │
                    ▼
               HTTPS / SSL
                    │
                    ▼
              Custom Domain
                    │
                    ▼
                 🌐 Users
```

Possible future improvements:

- 🔄 CI/CD using GitHub Actions
- ⚙️ PM2 for process management
- 🌐 Nginx reverse proxy
- 🔒 HTTPS with SSL/TLS
- 🌍 Custom domain
- 📊 Monitoring and logging
- 🐳 Docker containerization
- ☸️ Kubernetes deployment
- ☁️ AWS Load Balancer
- 📈 Auto Scaling

---

# 📝 PROJECT SUMMARY

This project demonstrates the complete process of deploying a Node.js application to AWS EC2.

The application was first tested locally, then the source code was cloned from GitHub onto an Ubuntu EC2 instance. Git, Node.js and npm were configured on the server, environment variables were created using `.env`, project dependencies were installed, and the Node.js server was started using `npm run start`.

The EC2 Security Group was then configured to allow inbound traffic on port `3000`. Finally, the application was accessed through the EC2 public IPv4 address.

```text
Local Development
        ↓
      GitHub
        ↓
     AWS EC2
        ↓
      Ubuntu
        ↓
  Node.js + npm
        ↓
     Express
        ↓
      .env
        ↓
   npm install
        ↓
  npm run start
        ↓
     Port 3000
        ↓
Security Group
        ↓
   Public IPv4
        ↓
   🌐 Browser
        ↓
🚀 LIVE APPLICATION
```

---

<div align="center">

# 🎉 PROJECT COMPLETE 🎉

### 🚀 NODE.JS APPLICATION SUCCESSFULLY DEPLOYED ON AWS EC2

**Local Machine → GitHub → EC2 → Ubuntu → Node.js → Express → Security Group → Live Website**

<br>

### ☁️ AWS • 🐧 Linux • 🐙 Git • 🟢 Node.js • 🚂 Express • 🔐 Networking

<br>

## ✅ DEPLOYMENT SUCCESSFUL

</div>
