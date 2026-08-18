# DAY 16 — LINUX, GIT & AWS DEVOPS

## Linux File Permissions

There are 3 types of users:
1. User (Owner)
2. Group
3. Others

Permission types:
- r (read) = 4 → view
- w (write) = 2 → modify, edit, delete
- x (execute) = 1 → run a file / execute a program

Example:
rwx r-x r-x = 755
rwx = 7
r-x = 5
r-x = 5

Another example:
rw- r-- r-- = 644
rw- = 6
r-- = 4
r-- = 4

chmod is used to change permissions of a file or directory.

Example:
chmod 755 file.txt

755 gives:
Owner → read, write, execute
Group → read, execute
Others → read, execute

chown is used to change the owner and group of a file or directory.

Example:
chown yuva file.txt
chown yuva:dev file.txt

chgrp is used to change the group of a file.

Example:
chgrp yuva notes.txt

## Basic Linux Commands

ls → list files and directories
cd → change directory
mkdir → create directory
touch → create file
cp → copy files
mv → rename / move files
rm → delete files
cat → display file content
wc → count lines, words and characters
sort → sort content
man → display manual
history → show command history
whoami → show current user
sudo → execute command as another user / with elevated privileges
ps → show running processes
df → display disk space
free → display free and used memory
ssh → secure shell / remote login
apt → advanced package tool
env → display environment variables
chgrp → change group
du → show disk usage

Examples:

cp file.txt backup.txt
mv old.txt new.txt
rm file.txt
touch file.txt
cat file.txt
wc file.txt
wc -l file.txt
sort file.txt
sort -n numbers.txt
man ls
man grep
history
whoami
sudo <command>
ps
df -h
free -h
ssh user@remote-host
apt update
env
du
du -sh path

## GIT — PHASE 6

1. Check files:
ls

2. Delete file using Git:
git rm career.html

3. Check status:
git status

It shows:
deleted: career.html

4. Commit the deletion:
git commit -m "removed webpage"

5. Push to GitHub:
git push

After pushing, the file will disappear from GitHub.

## GIT — PHASE 7

git rm = delete one file

Example:
git rm career.html

git rm -rf = delete an entire folder and everything inside it.

Example:
git rm -rf Images

-r = recursive delete
-f = force delete

## Live Example — git rm -rf

1. Create a folder:
mkdir Images

2. Go inside:
cd Images

3. Create 3 files:
touch logo.png icon.png m.png

4. Go back:
cd ..

5. Check:
ls

6. Add the folder:
git add .

7. Commit:
git commit -m "added images files"

8. Push:
git push

9. Delete the folder:
git rm -rf Images

10. Verify:
ls

The Images folder should be deleted.

11. Commit the deletion:
git commit -m "removed images folder"

12. Push:
git push

## GIT LOG

git log is used to see the history of commits.

To view commit history in one line:
git log --oneline

git log shows:
- Commit ID
- Author
- Date
- Commit message

Short history:
git log --oneline

Last 3 commits:
git log -3

Shortcut for last 3 commits:
git log --oneline -3

## AWS / DEVOPS SERVICES

Important AWS services:

1. EC2 — Elastic Compute Cloud
2. VPC — Virtual Private Cloud
3. EBS — Elastic Block Store
4. S3 — Simple Storage Service
5. IAM — Identity and Access Management
6. CloudWatch
7. Lambda
8. CodePipeline
9. CodeBuild
10. CodeDeploy
11. ECR — Elastic Container Registry
12. Billing & Cost Management
13. KMS — Key Management Service
14. CloudTrail
15. EKS — Elastic Kubernetes Service
16. Fargate
17. ELK Stack

## EC2 — Elastic Compute Cloud

EC2 is a virtual computer/server on AWS.

It is used to run applications, websites and other workloads.

Simple idea:
EC2 = virtual server in the cloud.

## VPC — Virtual Private Cloud

VPC is a private network inside AWS.

It provides a private networking environment for AWS resources.

Simple idea:
VPC = your private network inside AWS.

## EBS — Elastic Block Store

EBS is block storage for EC2.

Simple idea:
EBS = disk/storage for EC2.

## S3 — Simple Storage Service

S3 is used for object storage.

It can store:
- Files
- Images
- Videos
- Documents
- Backups

Simple idea:
S3 = storage for files/objects.

## IAM — Identity and Access Management

IAM controls who can access what in AWS.

IAM includes:
- Users
- Groups
- Roles
- Permissions

Simple idea:
IAM = access control.

## CloudWatch

CloudWatch is used for monitoring AWS resources and applications.

It can monitor:
- CPU usage
- Network activity
- Logs
- Metrics
- Alarms

Example:
A hospital wants to monitor its server health.
CloudWatch checks server CPU usage, memory and logs.

Simple idea:
CloudWatch = monitoring.

## Lambda

Lambda is a serverless service.

It runs code without managing servers.

Example:
A photo is uploaded to S3.
S3 triggers Lambda.
Lambda processes the photo.

Simple idea:
Lambda = run code without managing servers.

## CodePipeline

CodePipeline is used to create an automated CI/CD pipeline.

Basic flow:
GitHub → CodePipeline → CodeBuild → CodeDeploy → Application

CodePipeline connects the different stages of software delivery.

## CodeBuild

CodeBuild is used to build and test code.

Basic flow:
Source Code → CodeBuild → Build → Test

Simple idea:
CodeBuild = build + test.

## CodeDeploy

CodeDeploy is used to deploy an application.

Basic flow:
Application → CodeDeploy → Server

Simple idea:
CodeDeploy = deployment.

## Simple AWS DevOps Flow

Developer
↓
GitHub
↓
CodePipeline
↓
CodeBuild
↓
CodeDeploy
↓
Application / Server

## ECR — Elastic Container Registry

ECR is used to store container images.

Example:
Docker Image → ECR → Container image stored

Simple idea:
ECR = container image storage.

## EKS — Elastic Kubernetes Service

EKS is AWS's managed Kubernetes service.

It is used to run Kubernetes workloads on AWS.

Simple idea:
EKS = managed Kubernetes.

## Fargate

Fargate is used to run containers without managing servers.

Simple idea:
Fargate = serverless container compute.

## Billing & Cost Management

AWS Billing and Cost Management is used to track AWS costs.

It shows:
- AWS bill
- Daily spending
- Monthly cost
- Budget
- Cloud expenses

Simple idea:
Billing = track AWS cloud expenses.

## AWS KMS — Key Management Service

KMS is used to manage encryption keys and protect data.

Simple example:
Locker = Data
Key = KMS

KMS manages the keys used to encrypt and protect data.

Simple idea:
KMS = encryption key management.

## CloudTrail

CloudTrail records every action/activity performed in AWS.

It can answer:
- Who logged in?
- Who created EC2?
- Who deleted S3?
- Who performed an AWS action?

Simple idea:
CloudTrail = AWS activity / auditing.

Think of it like CCTV for AWS activity.

## AWS Config

AWS Config is used to track configuration changes.

It helps answer:
- What changed?
- Who changed it?
- When was it changed?

Simple idea:
AWS Config = track configuration changes.

## CI — Continuous Integration

Continuous Integration means developers continuously integrate their code.

Basic flow:
Developer → Code → Build → Test

## CD — Continuous Deployment

Continuous Deployment means the application is deployed automatically after the required process succeeds.

Basic flow:
Code → Build → Test → Deploy

## Complete CI/CD Flow

Developer
↓
Write Code
↓
GitHub
↓
CodePipeline
↓
CodeBuild
↓
Build + Test
↓
CodeDeploy
↓
Application

## CloudWatch vs CloudTrail

CloudWatch:
- Monitoring
- Metrics
- Logs
- Alarms

Remember:
CloudWatch → How is my system doing?

CloudTrail:
- Recording AWS activity
- Auditing
- Tracking actions

Remember:
CloudTrail → Who did what?

## EBS vs S3

EBS:
- Block storage
- Usually attached to EC2

S3:
- Object storage
- Stores files / objects

Easy memory:
EBS → Disk for EC2
S3 → Storage for files/objects

## EC2 vs Lambda

EC2:
- Virtual server
- You manage the server

Lambda:
- Serverless
- Run code without managing servers

Easy memory:
EC2 → You manage a virtual server
Lambda → AWS manages the server infrastructure

## EKS vs Fargate

EKS:
- Managed Kubernetes service

Fargate:
- Serverless compute for containers

## AWS Services Quick Revision

EC2 → Virtual Server
VPC → Private Network
EBS → Block Storage
S3 → Object Storage
IAM → Users, Roles & Permissions
CloudWatch → Monitoring
Lambda → Serverless Code Execution
CodePipeline → CI/CD Pipeline
CodeBuild → Build & Test
CodeDeploy → Deployment
ECR → Container Image Storage
EKS → Managed Kubernetes
Fargate → Serverless Containers
KMS → Encryption Key Management
CloudTrail → AWS Activity / Auditing
AWS Config → Configuration Tracking
Billing & Cost Management → Cost Tracking

## Complete AWS DevOps Flow

Developer
↓
GitHub
↓
CodePipeline
↓
CodeBuild
↓
CodeDeploy
↓
AWS Application
↓
CloudWatch
↓
Monitoring

## Git + AWS DevOps Flow

Developer
↓
Write Code
↓
Git
↓
GitHub
↓
CodePipeline
↓
CodeBuild
↓
Build + Test
↓
CodeDeploy
↓
Application
↓
CloudWatch
↓
Monitor

## Final Day 16 Revision

LINUX:
ls → list files
cd → change directory
mkdir → create directory
touch → create file
cp → copy
mv → move / rename
rm → remove
cat → display file
wc → count
sort → sort content
man → manual
history → command history
whoami → current user
sudo → elevated privileges
ps → processes
df → disk space
free → memory
ssh → remote login
apt → package management
env → environment variables
chmod → permissions
chown → owner
chgrp → group
du → disk usage

GIT:
git status → check status
git add . → stage changes
git rm file.txt → delete file through Git
git rm -rf folder → delete folder recursively
git commit -m "message" → save changes
git push → push to GitHub
git log --oneline → commit history
git log --oneline -3 → last 3 commits

AWS:
EC2 → Virtual Server
VPC → Private Network
EBS → Block Storage
S3 → Object Storage
IAM → Access Control
Lambda → Serverless
CloudWatch → Monitoring
CloudTrail → Activity / Audit
AWS Config → Configuration Tracking
KMS → Encryption Keys
ECR → Container Images
EKS → Kubernetes
Fargate → Serverless Containers
CodePipeline → CI/CD Pipeline
CodeBuild → Build / Test
CodeDeploy → Deployment
Billing → Cost Management

FINAL MEMORY FLOW:

Linux
↓
Manage files, permissions & system
↓
Git
↓
Track code changes
↓
GitHub
↓
Store/share code
↓
CodePipeline
↓
Automate pipeline
↓
CodeBuild
↓
Build + Test
↓
CodeDeploy
↓
Deploy
↓
AWS
↓
Run application
↓
CloudWatch
↓
Monitor
↓
CloudTrail
↓
Track AWS activity
↓
IAM
↓
Control access
↓
KMS
↓
Protect data
↓
ECR / EKS / Fargate
↓
Containers
↓
Billing
↓
Track cloud cost
