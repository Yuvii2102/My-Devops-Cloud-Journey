# 📤 Push Django Docker Project from EC2 to GitHub

## 🎯 Objective

After completing the Django Docker project, I pushed the project files from my AWS EC2 instance to my GitHub repository and organized them inside the `08-Dockerizing-Python-Django-Web-Application` folder.

---

## 📁 Project Locations

### Django project on EC2

    ~/Docker-Zero-to-Hero/examples/python-web-app

### GitHub repository on EC2

    ~/My-Devops-Cloud-Journey

### Final GitHub structure

    DevOps-Labs-and-Projects/
    └── 08-Dockerizing-Python-Django-Web-Application/
        ├── README.md
        └── python-web-app/
            ├── Dockerfile
            ├── requirements.txt
            └── devops/

---

## 🚀 Commands Used

### 1. Go to the Git repository

    cd ~/My-Devops-Cloud-Journey

### 2. Check Git status

    git status

Initially Git showed:

    nothing to commit, working tree clean

This happened because the Django project was not inside the Git repository yet.

### 3. Check whether the Dockerization folder existed

    ls -la DevOps-Labs-and-Projects/Dockerizing-Python-Django-Web-Application

It showed:

    No such file or directory

So I checked the actual folder name and used:

    08-Dockerizing-Python-Django-Web-Application

### 4. Copy the Django project into the Git repository

    cp -r ~/Docker-Zero-to-Hero/examples/python-web-app DevOps-Labs-and-Projects/

### 5. Check the copied project

    ls -la DevOps-Labs-and-Projects/python-web-app

The project contained:

    Dockerfile
    requirements.txt
    devops/

### 6. Check Git status again

    git status

Git detected the Django project as new files.

### 7. Add the Django project

    git add DevOps-Labs-and-Projects/python-web-app/

### 8. Commit the project

    git commit -m "Add Django Docker project"

### 9. Push the project to GitHub

    git push origin main

GitHub asked for authentication:

    Username for 'https://github.com':
    Yuvii2102

    Password for 'https://Yuvii2102@github.com':

After successful authentication, the project was pushed to GitHub.

---

## 📂 10. Move the Project into the Correct Dockerization Folder

Initially, GitHub showed:

    DevOps-Labs-and-Projects/
    ├── 08-Dockerizing-Python-Django-Web-Application/
    │   └── README.md
    │
    └── python-web-app/
        ├── Dockerfile
        ├── requirements.txt
        └── devops/

I wanted `python-web-app` inside the Dockerization folder.

### Move the folder

    cd ~/My-Devops-Cloud-Journey

    git mv DevOps-Labs-and-Projects/python-web-app DevOps-Labs-and-Projects/08-Dockerizing-Python-Django-Web-Application/

### Check the folder

    ls -la DevOps-Labs-and-Projects/08-Dockerizing-Python-Django-Web-Application/

Expected:

    README.md
    python-web-app

### Check Git status

    git status

### Add the changes

    git add -A

### Commit the move

    git commit -m "Move Django Docker project into Dockerization folder"

### Push the final structure

    git push origin main

---

## 🔄 Complete Flow

    Django Project on EC2
            ↓
    cd ~/My-Devops-Cloud-Journey
            ↓
    git status
            ↓
    Copy Project
            ↓
    git status
            ↓
    git add
            ↓
    git commit
            ↓
    git push origin main
            ↓
    Move Project into Dockerization Folder
            ↓
    git add -A
            ↓
    git commit
            ↓
    git push origin main
            ↓
    GitHub 🚀

---

## 🧾 Commands to Remember

    cd ~/My-Devops-Cloud-Journey

    git status

    cp -r ~/Docker-Zero-to-Hero/examples/python-web-app DevOps-Labs-and-Projects/

    ls -la DevOps-Labs-and-Projects/python-web-app

    git add DevOps-Labs-and-Projects/python-web-app/

    git commit -m "Add Django Docker project"

    git push origin main

    git mv DevOps-Labs-and-Projects/python-web-app DevOps-Labs-and-Projects/08-Dockerizing-Python-Django-Web-Application/

    ls -la DevOps-Labs-and-Projects/08-Dockerizing-Python-Django-Web-Application/

    git status

    git add -A

    git commit -m "Move Django Docker project into Dockerization folder"

    git push origin main

---

# ✅ FINAL RESULT

    EC2
      ↓
    Git Repository
      ↓
    Django Project
      ↓
    git add
      ↓
    git commit
      ↓
    git push origin main
      ↓
    Dockerization Folder
      ↓
    GitHub 🚀

## 📂 Final GitHub Structure

    08-Dockerizing-Python-Django-Web-Application/
    │
    ├── README.md
    │
    └── python-web-app/
        ├── Dockerfile
        ├── requirements.txt
        └── devops/

# 🎉 PROJECT PUSHED AND ORGANIZED SUCCESSFULLY
