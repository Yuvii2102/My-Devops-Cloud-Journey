<div align="center">

# 🔐 GITHUB PERSONAL ACCESS TOKEN (PAT) AUTHENTICATION FROM AWS EC2

### 🚀 AWS EC2 → Git → GitHub → PAT Authentication → Secure Push

![AWS](https://img.shields.io/badge/AWS-EC2-FF9900?style=for-the-badge\&logo=amazonaws\&logoColor=white)
![Git](https://img.shields.io/badge/Git-Version%20Control-F05032?style=for-the-badge\&logo=git\&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-Repository-181717?style=for-the-badge\&logo=github\&logoColor=white)
![PAT](https://img.shields.io/badge/GitHub-PAT-2088FF?style=for-the-badge\&logo=github\&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-EC2-E95420?style=for-the-badge\&logo=ubuntu\&logoColor=white)

</div>

---

## 📌 Overview

This hands-on practical demonstrates how to authenticate with **GitHub from an AWS EC2 Ubuntu instance using a GitHub Fine-grained Personal Access Token (PAT)**.

In this practical, I worked through the complete workflow of cloning a repository, renaming a project folder, committing the changes, creating a Fine-grained PAT, configuring repository permissions, authenticating GitHub from EC2, pushing the changes, and verifying the repository status.

### 🔄 Complete Workflow

```text
AWS EC2
   │
   ▼
Clone GitHub Repository
   │
   ▼
Rename Project Folder
   │
   ▼
git add
   │
   ▼
git commit
   │
   ▼
Create GitHub Fine-grained PAT
   │
   ▼
Configure Repository Permissions
   │
   ▼
GitHub Authentication
   │
   ▼
git push origin main
   │
   ▼
GitHub Repository Updated
   │
   ▼
git status
   │
   ▼
Working Tree Clean ✅
```

---

## 🎯 Objective

The objective of this practical was to:

* Work with a GitHub repository from AWS EC2
* Rename an existing project folder
* Track the rename using Git
* Stage and commit the changes
* Understand GitHub HTTPS authentication
* Understand why a normal GitHub password cannot be used for Git HTTPS authentication
* Create a Fine-grained GitHub Personal Access Token
* Restrict the token to a specific repository
* Configure the required repository permission
* Authenticate Git from AWS EC2 using the PAT
* Push the changes to GitHub
* Verify that the local repository is synchronized with GitHub

---

## ☁️ Environment

| Component         | Details                            |
| ----------------- | ---------------------------------- |
| Cloud Platform    | AWS                                |
| Compute Service   | EC2                                |
| Operating System  | Ubuntu                             |
| Version Control   | Git                                |
| Remote Repository | GitHub                             |
| Authentication    | Fine-grained Personal Access Token |
| Branch            | `main`                             |
| Repository        | `My-Devops-Cloud-Journey`          |

---

# 01 — Clone the GitHub Repository

First, move to the home directory of the EC2 Ubuntu user:

```bash
cd ~
```

Clone the GitHub repository:

```bash
git clone https://github.com/Yuvii2102/My-Devops-Cloud-Journey.git
```

Enter the repository:

```bash
cd My-Devops-Cloud-Journey
```

Check the repository contents:

```bash
ls
```

Check the Git status:

```bash
git status
```

The repository is now available locally on the EC2 instance.

---

# 02 — Rename the Project Folder

The original project documentation folder was:

```text
What-I-Learnt
```

I wanted to give it a more professional name:

```text
DevOps-Labs-and-Projects
```

Instead of using the normal Linux `mv` command, Git's rename command was used:

```bash
git mv What-I-Learnt DevOps-Labs-and-Projects
```

Check the directory:

```bash
ls
```

The repository now contains:

```text
My-Journey/
DevOps-Labs-and-Projects/
README.md
```

Using `git mv` allows Git to track the file and folder rename.

---

# 03 — Check the Changes

Check the repository status:

```bash
git status
```

Git detects the files as renamed from:

```text
What-I-Learnt/
```

to:

```text
DevOps-Labs-and-Projects/
```

The folder contains multiple README files, practical documentation, and screenshots, so Git detects the corresponding file changes.

---

# 04 — Stage the Changes

Stage all changes:

```bash
git add .
```

The renamed files are now staged and ready to be committed.

---

# 05 — Create a Git Commit

Create a commit describing the folder rename:

```bash
git commit -m "Rename What-I-Learnt to DevOps-Labs-and-Projects"
```

Git records the rename in the local repository history.

Example:

```text
25 files changed
```

At this point, the changes exist in the local Git repository but have not yet been pushed to GitHub.

---

# 06 — Attempt to Push to GitHub

To upload the commit to GitHub:

```bash
git push origin main
```

Git asks for authentication:

```text
Username for 'https://github.com':
Password for 'https://Yuvii2102@github.com':
```

The first authentication attempt failed because a normal GitHub account password is not accepted for Git HTTPS operations.

Example error:

```text
remote: Invalid username or token.
fatal: Authentication failed
```

This is where the **GitHub Personal Access Token (PAT)** is required.

---

# 07 — What Is a GitHub Personal Access Token?

A **Personal Access Token (PAT)** is a credential that can be used to authenticate GitHub operations.

For Git operations over HTTPS, the PAT can be used in place of the GitHub account password.

```text
Git on EC2
     │
     │ HTTPS
     │
     │ Username + PAT
     ▼
GitHub
     │
     ▼
Repository
```

A **Fine-grained PAT** is useful because access can be restricted to specific repositories and permissions.

---

# 08 — Create a Fine-grained GitHub PAT

Go to GitHub:

```text
GitHub
   ↓
Settings
   ↓
Developer Settings
   ↓
Personal access tokens
   ↓
Fine-grained tokens
   ↓
Generate new token
```

The Fine-grained Personal Access Token page allows the token to be configured with specific repository access and permissions.

---

# 09 — Configure the PAT

## Token Name

Use a descriptive name:

```text
EC2-GitHub-Access
```

## Description

Example:

```text
Git access for pushing DevOps Cloud Journey from AWS EC2
```

The description explains the purpose of the token.

---

# 10 — Configure Token Expiration

Choose an appropriate expiration period.

For example:

```text
90 days
```

An expiration date is recommended because it limits how long the credential remains valid.

When the token expires, a new token can be created.

---

# 11 — Configure Repository Access

GitHub provides different repository access options.

For this practical, instead of giving the token access to every repository, select:

```text
Only select repositories
```

Then select:

```text
My-Devops-Cloud-Journey
```

This follows the principle of least privilege.

```text
❌ All repositories

        vs.

✅ My-Devops-Cloud-Journey only
```

---

# 12 — Configure Repository Permissions

Under **Repository permissions**, configure:

```text
Contents → Read and write
```

This permission allows Git to read and write repository contents, which is required for pushing changes.

The permission model is:

```text
Fine-grained PAT
      │
      ▼
My-Devops-Cloud-Journey
      │
      ▼
Contents
      │
      ▼
Read and write
```

Avoid granting unnecessary permissions.

---

# 13 — Generate the Token

After configuring the token:

```text
Generate token
```

GitHub generates a token similar to:

```text
github_pat_xxxxxxxxxxxxxxxxxxxxxxxxx
```

The actual token is secret.

Copy it immediately and store it securely.

---

# 🚨 PAT SECURITY

A GitHub PAT should be treated like a password.

## ❌ Never

* Share your PAT with anyone
* Send your PAT in chat
* Upload your PAT to GitHub
* Put your PAT inside source code
* Put your PAT inside a README
* Commit your PAT to Git
* Store your PAT in a public `.env` file
* Include your PAT in screenshots
* Paste your PAT into a public issue or discussion

## ✅ Always

* Use the minimum required permissions
* Restrict the token to required repositories
* Set an expiration date
* Store the token securely
* Revoke the token if it becomes exposed

---

# 14 — Authenticate Git Using the PAT

Return to the EC2 terminal and run:

```bash
git push origin main
```

Git asks:

```text
Username for 'https://github.com':
```

Enter your GitHub username:

```text
Yuvii2102
```

Git then asks:

```text
Password for 'https://Yuvii2102@github.com':
```

At this point, paste the **GitHub Personal Access Token**.

> 💡 Nothing will appear on the terminal while the token is being typed or pasted. This is normal behavior for password-style input.

Press:

```text
Enter
```

GitHub verifies the token and its permissions.

---

# 15 — Successful Git Push

After successful authentication, Git uploads the commit.

Typical output:

```text
Enumerating objects...
Counting objects...
Compressing objects...
Writing objects...
Total...
```

Then Git confirms the remote repository:

```text
To https://github.com/Yuvii2102/My-Devops-Cloud-Journey.git
```

And the branch update:

```text
main -> main
```

This confirms that the commit was successfully pushed to GitHub.

---

# 16 — Verify the Repository

After pushing the changes, run:

```bash
git status
```

Expected output:

```text
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

This confirms:

```text
✅ Commit exists
✅ Changes were pushed
✅ Local branch is synchronized
✅ Working tree is clean
```

---

# 17 — Verify the Remote Repository

You can also check the configured remote:

```bash
git remote -v
```

Expected output:

```text
origin  https://github.com/Yuvii2102/My-Devops-Cloud-Journey.git (fetch)
origin  https://github.com/Yuvii2102/My-Devops-Cloud-Journey.git (push)
```

This confirms that the local repository is connected to the correct GitHub repository.

---

# 18 — Before vs After

| Before                         | After                           |
| ------------------------------ | ------------------------------- |
| `What-I-Learnt`                | `DevOps-Labs-and-Projects`      |
| Folder rename pending          | Rename committed                |
| GitHub password authentication | Fine-grained PAT authentication |
| Push authentication failed     | Push authentication successful  |
| Changes only on EC2            | Changes pushed to GitHub        |
| Repository not synchronized    | Repository synchronized         |
| Uncommitted changes            | Working tree clean              |

---

# 19 — Important Git Commands Learned

### Clone Repository

```bash
git clone <repository-url>
```

### Enter Repository

```bash
cd <repository-name>
```

### Rename Tracked Folder

```bash
git mv <old-name> <new-name>
```

### Check Repository Status

```bash
git status
```

### Stage Changes

```bash
git add .
```

### Create Commit

```bash
git commit -m "commit message"
```

### Push Changes

```bash
git push origin main
```

### Check Remote

```bash
git remote -v
```

---

# 20 — Complete Command Sequence

The complete Git workflow used in this practical:

```bash
cd ~
git clone https://github.com/Yuvii2102/My-Devops-Cloud-Journey.git
cd My-Devops-Cloud-Journey
ls
git status

git mv What-I-Learnt DevOps-Labs-and-Projects

git status
git add .
git commit -m "Rename What-I-Learnt to DevOps-Labs-and-Projects"

git push origin main

git status
git remote -v
```

During the `git push` step, GitHub authentication is performed using the Fine-grained PAT.

---

# 21 — Complete Architecture

```text
┌──────────────────────────────┐
│          AWS EC2             │
│           Ubuntu             │
│                              │
│  ┌────────────────────────┐  │
│  │   Local Git Repository  │  │
│  │                        │  │
│  │ My-Devops-Cloud-Journey│  │
│  └────────────┬───────────┘  │
│               │              │
│          git add             │
│               │              │
│          git commit          │
│               │              │
└───────────────┼──────────────┘
                │
                │ HTTPS
                │ Username + PAT
                ▼
┌──────────────────────────────┐
│           GitHub             │
│                              │
│  My-Devops-Cloud-Journey     │
│                              │
│  DevOps-Labs-and-Projects    │
└──────────────────────────────┘
                │
                ▼
       Repository Updated
                │
                ▼
         git status
                │
                ▼
      Working Tree Clean ✅
```

---

# 22 — Security Principle: Least Privilege

This practical demonstrates the **Principle of Least Privilege**.

Instead of allowing the PAT to access every repository:

```text
❌ All repositories
```

the PAT was restricted to:

```text
✅ My-Devops-Cloud-Journey
```

Instead of granting unnecessary permissions:

```text
❌ Unnecessary permissions
```

only the required permission was configured:

```text
✅ Contents → Read and write
```

This reduces the potential impact if the token is ever compromised.

---

# 23 — Troubleshooting

## Authentication Failed

If you see:

```text
remote: Invalid username or token.
fatal: Authentication failed
```

Check the following:

* GitHub username is correct
* PAT is valid
* PAT has not expired
* Correct repository is selected
* `Contents` permission is set to `Read and write`
* PAT is being used instead of the GitHub account password
* The token has not been revoked

---

## PAT Expired

If the token expires:

```text
Create a new Fine-grained PAT
        ↓
Select required repository
        ↓
Grant Contents → Read and write
        ↓
Use the new token
```

---

## PAT Accidentally Exposed

If a PAT is accidentally exposed:

```text
1. Revoke the exposed token
2. Create a new token
3. Update authentication
4. Check whether the token was committed
5. Remove sensitive credentials from Git history if necessary
```

Never continue using an exposed credential.

---

# 24 — Key Learnings

Through this practical, I learned:

* How to clone a GitHub repository on AWS EC2
* How Git tracks folder and file renames
* How to use `git mv`
* How to stage changes using `git add`
* How to create commits using `git commit`
* How `git push` transfers commits to GitHub
* How GitHub HTTPS authentication works
* Why a normal GitHub password cannot be used for Git HTTPS authentication
* What a Personal Access Token is
* How to create a Fine-grained PAT
* How to restrict a PAT to a specific repository
* How to configure `Contents → Read and write`
* How to authenticate Git from an EC2 instance
* How to verify a successful push
* How to use `git status` to verify repository synchronization
* Why credentials must never be committed or exposed
* How the principle of least privilege applies to GitHub authentication

---

# 🏆 Practical Outcome

Successfully completed a real-world Git and GitHub workflow from AWS EC2:

```text
AWS EC2
   │
   ▼
GitHub Repository Cloned
   │
   ▼
What-I-Learnt
   │
   │ git mv
   ▼
DevOps-Labs-and-Projects
   │
   │ git add .
   ▼
Staged Changes
   │
   │ git commit
   ▼
Local Commit
   │
   │ GitHub PAT
   ▼
HTTPS Authentication
   │
   │ git push origin main
   ▼
GitHub Repository Updated
   │
   │ git status
   ▼
Working Tree Clean ✅
```

---

# 📚 Practical Summary

| Step | Action               | Command / Tool              |
| ---- | -------------------- | --------------------------- |
| 01   | Clone repository     | `git clone`                 |
| 02   | Enter repository     | `cd`                        |
| 03   | Rename folder        | `git mv`                    |
| 04   | Check changes        | `git status`                |
| 05   | Stage changes        | `git add .`                 |
| 06   | Create commit        | `git commit`                |
| 07   | Create PAT           | GitHub Settings             |
| 08   | Restrict repository  | Fine-grained PAT            |
| 09   | Configure permission | `Contents → Read and write` |
| 10   | Authenticate         | GitHub PAT                  |
| 11   | Push changes         | `git push origin main`      |
| 12   | Verify               | `git status`                |

---

<div align="center">

# 🟢 PRACTICAL COMPLETE

### 🔐 GitHub PAT Authentication from AWS EC2

**AWS EC2 → Git → GitHub → Fine-grained PAT → Secure Push**

### Learn • Practice • Troubleshoot • Document • Improve

</div>
