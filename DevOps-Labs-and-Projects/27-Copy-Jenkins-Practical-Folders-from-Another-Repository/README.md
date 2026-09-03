# 📁 Copy Jenkins Practical Folders from Another Repository

This documents how to copy selected Jenkins practical folders from the teacher's repository into my own DevOps repository.

## 🎯 Objective

Copy these folders:

- `my-first-pipeline`
- `multi-stage-multi-agent`

From:

```text
iam-veeramalla/Jenkins-Zero-To-Hero
```

Into:

```text
Yuvii2102/My-Devops-Cloud-Journey
└── DevOps-Labs-and-Projects
    └── 26-Jenkins
```

---

## 1. Clone the Source Repository

Go to the home directory:

```bash
cd ~
```

Clone the Jenkins repository:

```bash
git clone https://github.com/iam-veeramalla/Jenkins-Zero-To-Hero.git
```

Verify the repository:

```bash
ls ~/Jenkins-Zero-To-Hero
```

---

## 2. Go to My Repository

```bash
cd ~/My-Devops-Cloud-Journey
```

Check the repository status:

```bash
git status
```

---

## 3. Get the Latest Changes

Fetch the latest information from GitHub:

```bash
git fetch origin
```

Pull the latest changes:

```bash
git pull origin main
```

---

## 4. Verify the Jenkins Directory

```bash
ls DevOps-Labs-and-Projects/26-Jenkins
```

---

## 5. Copy `my-first-pipeline`

Go inside the Jenkins directory:

```bash
cd ~/My-Devops-Cloud-Journey/DevOps-Labs-and-Projects/26-Jenkins
```

Copy the first practical:

```bash
cp -r ~/Jenkins-Zero-To-Hero/my-first-pipeline .
```

---

## 6. Copy `multi-stage-multi-agent`

```bash
cp -r ~/Jenkins-Zero-To-Hero/multi-stage-multi-agent .
```

---

## 7. Verify the Copied Folders

```bash
ls
```

Expected:

```text
my-first-pipeline
multi-stage-multi-agent
README.md
```

---

## 8. Go to Repository Root

```bash
cd ~/My-Devops-Cloud-Journey
```

Check Git status:

```bash
git status
```

---

## 9. Add the Jenkins Practicals

```bash
git add DevOps-Labs-and-Projects/26-Jenkins/my-first-pipeline
git add DevOps-Labs-and-Projects/26-Jenkins/multi-stage-multi-agent
```

Or:

```bash
git add DevOps-Labs-and-Projects/26-Jenkins/
```

---

## 10. Commit the Changes

```bash
git commit -m "Add Jenkins pipeline practicals"
```

---

## 11. Push to GitHub

```bash
git push origin main
```

---

# 🎯 Final Repository Structure

```text
My-Devops-Cloud-Journey
└── DevOps-Labs-and-Projects
    └── 26-Jenkins
        ├── README.md
        ├── my-first-pipeline
        └── multi-stage-multi-agent
```

---

# 🧠 Quick Command Summary

```bash
cd ~

git clone https://github.com/iam-veeramalla/Jenkins-Zero-To-Hero.git

cd ~/My-Devops-Cloud-Journey

git fetch origin
git pull origin main

cd ~/My-Devops-Cloud-Journey/DevOps-Labs-and-Projects/26-Jenkins

cp -r ~/Jenkins-Zero-To-Hero/my-first-pipeline .
cp -r ~/Jenkins-Zero-To-Hero/multi-stage-multi-agent .

ls

cd ~/My-Devops-Cloud-Journey

git status

git add DevOps-Labs-and-Projects/26-Jenkins/

git commit -m "Add Jenkins pipeline practicals"

git push origin main
```
