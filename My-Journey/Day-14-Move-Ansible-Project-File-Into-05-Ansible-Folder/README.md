# 📦 Move Ansible Project into 05-Ansible

## 🎯 Objective

I had an **Ansible project/folder present outside the `05-Ansible` folder** inside my GitHub repository.

The structure was initially:

    DevOps-Labs-and-Projects/
    │
    ├── 05-Ansible/
    ├── Ansible/                 ← Ansible project was here
    ├── 06-Terraform/
    ├── 07-Docker/
    └── 08-Dockerizing-Python-Django-Web-Application/

I wanted to organize it properly by moving the existing `Ansible` folder **inside `05-Ansible`**.

The final structure I wanted was:

    DevOps-Labs-and-Projects/
    │
    ├── 05-Ansible/
    │   └── Ansible/
    │
    ├── 06-Terraform/
    ├── 07-Docker/
    └── 08-Dockerizing-Python-Django-Web-Application/

Since the `Ansible` folder was already tracked by Git, I used **`git mv`** instead of copying it.

---

## 🚀 Commands Used

### 1. Go to the Git repository

    cd ~/My-Devops-Cloud-Journey

### 2. Check the folders

    ls -la DevOps-Labs-and-Projects/

### 3. Move the existing Ansible folder into 05-Ansible

    git mv DevOps-Labs-and-Projects/Ansible DevOps-Labs-and-Projects/05-Ansible/

### 4. Verify the new location

    ls -la DevOps-Labs-and-Projects/05-Ansible/

Expected:

    README.md
    Ansible/

### 5. Check Git status

    git status

### 6. Stage the change

    git add -A

### 7. Commit the move

    git commit -m "Move Ansible project into 05-Ansible"

### 8. Push to GitHub

    git push origin main

---

# ⚠️ Push Error

The push was rejected:

    ! [rejected]        main -> main (fetch first)

    error: failed to push some refs to
    'https://github.com/Yuvii2102/My-Devops-Cloud-Journey.git'

### Why?

GitHub had newer changes that were not present in my EC2 repository.

So Git would not allow the local branch to overwrite the newer remote history.

---

# 🔄 Fix the Push Error

### 9. Go to the repository

    cd ~/My-Devops-Cloud-Journey

### 10. Check the local status

    git status

### 11. Pull the latest changes from GitHub

    git pull --rebase origin main

This gets the latest remote changes and reapplies my local Ansible move on top of them.

### 12. Push again

    git push origin main

---

# 🔄 Complete Flow

    Ansible folder outside 05-Ansible
                ↓
    git mv Ansible → 05-Ansible/
                ↓
    git status
                ↓
    git add -A
                ↓
    git commit
                ↓
    git push origin main
                ↓
          ❌ fetch first
                ↓
    git pull --rebase origin main
                ↓
    git push origin main
                ↓
          GitHub ✅

---

# 📂 Final GitHub Structure

    DevOps-Labs-and-Projects/
    │
    ├── 04-GitHub-PAT-Authentication/
    │
    ├── 05-Ansible/
    │   └── Ansible/
    │
    ├── 06-Terraform/
    │
    ├── 07-Docker/
    │
    └── 08-Dockerizing-Python-Django-Web-Application/

---

# 🧾 Commands to Remember

    cd ~/My-Devops-Cloud-Journey

    ls -la DevOps-Labs-and-Projects/

    git mv DevOps-Labs-and-Projects/Ansible DevOps-Labs-and-Projects/05-Ansible/

    ls -la DevOps-Labs-and-Projects/05-Ansible/

    git status

    git add -A

    git commit -m "Move Ansible project into 05-Ansible"

    git push origin main

    git pull --rebase origin main

    git push origin main

---

# 💡 Important Lessons

### `git mv`

Used when moving an existing Git-tracked file or folder.

    git mv OLD_LOCATION NEW_LOCATION

### `git pull --rebase`

Used when GitHub has newer commits and the local repository is behind.

    git pull --rebase origin main

Then push again:

    git push origin main

### Remember

    Remote has newer changes
            ↓
    git pull --rebase
            ↓
    git push

# 🎉 ANSIBLE PROJECT ORGANIZED SUCCESSFULLY
