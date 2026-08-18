# 🐳 How I Pushed My Docker Work to GitHub

In this step, I pushed my Docker work and documentation to my own GitHub repository.

My GitHub project structure is:

```text
My-Devops-Cloud-Journey
└── DevOps-Labs-and-Projects
    └── 07-Docker
        └── README.md
```

---

## 1️⃣ Go to My Docker Folder

First, I went to my Docker folder inside my GitHub project.

```bash
cd ~/My-Devops-Cloud-Journey/DevOps-Labs-and-Projects/07-Docker
```

I checked my current location:

```bash
pwd
```

I should be inside:

```text
/home/ubuntu/My-Devops-Cloud-Journey/DevOps-Labs-and-Projects/07-Docker
```

Then I checked the files:

```bash
ls
```

I should see:

```text
README.md
```

---

## 2️⃣ Check Git Status

I checked the Git status to see what files were changed or added.

```bash
git status
```

This helps me understand what Git is going to track before I push anything.

---

## 3️⃣ Pull the Latest Changes

Since I created my `README.md` directly on GitHub, I first pulled the latest changes to my EC2 machine.

```bash
git pull origin main
```

If I see:

```text
Already up to date.
```

it means my local repository already has the latest changes from GitHub.

---

## 4️⃣ Check My Docker Folder

I checked the contents of the folder:

```bash
ls -la
```

I should see:

```text
README.md
```

---

## 5️⃣ Create an Images Folder

I wanted to keep all my Docker screenshots organized, so I created an `images` folder.

```bash
mkdir -p images
```

Now my Docker folder can look like this:

```text
07-Docker/
├── README.md
└── images/
    ├── 01-docker-installation.png
    ├── 02-docker-status.png
    ├── 03-docker-build.png
    ├── 04-docker-run.png
    ├── 05-dockerhub-push.png
    └── ...
```

This keeps my README and screenshots organized.

---

## 6️⃣ Check Git Status Again

After adding my files, I checked the status again:

```bash
git status
```

This shows me which files Git has detected.

---

## 7️⃣ Add the Files to Git

I added my Docker files to the Git staging area:

```bash
git add .
```

The `.` means I want to add the files from the current folder and its subfolders.

---

## 8️⃣ Commit My Docker Work

I created a commit with a simple message:

```bash
git commit -m "Add Docker first container hands-on lab"
```

This saves my changes in Git history.

---

## 9️⃣ Push My Work to GitHub

Finally, I pushed my changes to the `main` branch:

```bash
git push origin main
```

Git uploads my committed changes to my GitHub repository.

I should see output similar to:

```text
Enumerating objects...
Counting objects...
Writing objects...
To https://github.com/Yuvii2102/My-Devops-Cloud-Journey.git
   xxxxxxx..xxxxxxx  main -> main
```

---

# 🔄 Complete GitHub Push Flow

```text
My Docker Work
      │
      ▼
07-Docker/
      │
      ├── README.md
      │
      └── images/
            │
            ▼
       git status
            │
            ▼
      git pull origin main
            │
            ▼
         git add .
            │
            ▼
   git commit -m "Add Docker first container hands-on lab"
            │
            ▼
      git push origin main
            │
            ▼
        GitHub 🚀
```

---

# 📁 Final GitHub Structure

After pushing, my GitHub repository should look like:

```text
My-Devops-Cloud-Journey/
│
└── DevOps-Labs-and-Projects/
    │
    └── 07-Docker/
        │
        ├── README.md
        │
        └── images/
            ├── 01-docker-installation.png
            ├── 02-docker-status.png
            ├── 03-docker-build.png
            ├── 04-docker-run.png
            ├── 05-dockerhub-push.png
            └── ...
```

---

# 🧠 What I Learned

* I learned how to move to my GitHub project folder using `cd`.
* I learned how to check changes using `git status`.
* I learned why I should use `git pull` before pushing when changes were made directly on GitHub.
* I learned how to create an `images` folder for screenshots.
* I learned how to stage files using `git add .`.
* I learned how to save changes using `git commit`.
* I learned how to upload my changes using `git push`.
* I learned how to keep my Docker documentation and screenshots organized inside my GitHub repository.

---

# 🚀 My Git Commands

The complete commands I used are:

```bash
cd ~/My-Devops-Cloud-Journey/DevOps-Labs-and-Projects/07-Docker

pwd

ls

git status

git pull origin main

ls -la

mkdir -p images

git status

git add .

git commit -m "Add Docker first container hands-on lab"

git push origin main
```

---

<div align="center">

# ✅ DOCKER WORK PUSHED TO GITHUB 🚀

### 🐳 Docker → Git → GitHub

</div>
