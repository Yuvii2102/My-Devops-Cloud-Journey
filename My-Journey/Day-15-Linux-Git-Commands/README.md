# 📘 DAY 15 — COMPLETE NOTES

> **All Day 15 notes are kept inside this ONE Markdown page.**
> No separate Markdown pages or separate code blocks.

# 🐧 LINUX COMMANDS & BASIC SYSTEM CONCEPTS

## 1. Linux Directory Structure

### `/root`
- Top-level directory of the **root user**.
- The root user has administrative privileges.

### `/home`
- Contains the personal directories and files of normal users.
- Example:
  `/home/user`

### `/etc`
- Contains configuration files for various system services and applications.

### `/var`
- Contains variable data such as logs and other data that changes during system operation.

### `/bin`
- Contains binary executable files and essential commands.

### `/usr`
- Contains many user-related programs, libraries and other system resources.

---

# ⚙️ PROCESS MANAGEMENT

## `ps`

`ps` is used to view currently running processes.

Example:

    ps

## `ps -ef`

Displays detailed information about running processes.

    ps -ef

## `top`

Used to see running processes and system activity in real time.

    top

## `kill`

Used to terminate a process using its Process ID.

    kill <PID>

## `kill -9`

Used to forcefully terminate a process.

    kill -9 <PID>

## `grep`

Used to search for specific text or patterns.

    grep "text" file

## `find`

Used to search for files and directories.

    find /path -name "filename"

---

# 🐙 GIT & GITHUB

## What is Git?

Git is a distributed version-control system used to track changes in a project.

It allows developers to:

- Track changes.
- Save different versions of a project.
- Work with branches.
- Collaborate with other developers.
- Revert or inspect previous changes.

## What is GitHub?

GitHub is a platform used to host Git repositories remotely.

Basic idea:

    Local Computer
          ↓
    Local Git Repository
          ↓
       GitHub
          ↓
    Remote Repository

---

# 🧩 PHASE 1 — CREATE THE LOCAL PROJECT

## 1. Go to the home directory

    cd ~

`~` represents the current user's home directory.

## 2. Check the current directory

    pwd

`pwd` means **print working directory**.

It tells you where you currently are.

## 3. List files and directories

    ls

To show hidden files as well:

    ls -a

## 4. Create a project directory

Example:

    mkdir myproject

`mkdir` means **make directory**.

## 5. Enter the project directory

    cd myproject

## 6. Create a file

Example:

    touch index.html

The project can contain files such as:

    myproject/
        index.html
        style.css
        script.js

---

# 🌐 BASIC HTML PROJECT

Example `index.html`:

    <!DOCTYPE html>
    <html>
    <head>
        <title>My Website</title>
    </head>
    <body>
        <h1>Hello World</h1>
    </body>
    </html>

The important idea is that Git can track the files belonging to this project.

---

# 🔧 PHASE 2 — INITIALIZE GIT

## 1. Initialize the Git repository

Inside the project directory:

    git init

`git init` initializes a new Git repository.

It creates the `.git` directory.

Example:

    myproject/
        .git/
        index.html
        style.css
        script.js

The `.git` directory contains the information Git uses to track the project.

---

# 🔍 CHECK THE PROJECT STATUS

Use:

    git status

`git status` tells you the current state of the repository.

It can show:

- Untracked files.
- Modified files.
- Staged files.
- The current branch.
- Changes that are ready to be committed.

---

# ➕ ADD FILES TO THE STAGING AREA

To add one file:

    git add index.html

To add all changes:

    git add .

`git add` moves changes into the **staging area**.

---

# 💾 COMMIT THE CHANGES

After staging the changes:

    git commit -m "initial commit"

A commit records the staged changes in the local Git repository.

Example workflow:

    Working Directory
           ↓
       git add
           ↓
      Staging Area
           ↓
      git commit
           ↓
     Git Repository

---

# 🌿 GIT BRANCHES

A branch is a separate line of development.

## Check branches

    git branch

## Create a branch

    git branch feature

## Switch to a branch

    git checkout feature

Or:

    git switch feature

## Create and switch to a branch

    git checkout -b feature

Or:

    git switch -c feature

Example:

    main
      \
       feature

The developer can work on the feature without directly changing the main branch.

---

# 🧠 GIT WORKING AREAS

## Working Directory

The files you are currently working on.

## Staging Area

The changes selected for the next commit.

## Local Repository

The Git repository stored on your computer.

## Remote Repository

The repository stored remotely, such as on GitHub.

Complete flow:

    Working Directory
           ↓
       git add
           ↓
      Staging Area
           ↓
      git commit
           ↓
    Local Repository
           ↓
       git push
           ↓
    Remote Repository

---

# 🐙 PHASE 3 — CONNECT THE LOCAL PROJECT TO GITHUB

First create a repository on GitHub.

Then connect the local Git repository to the GitHub repository.

## Add the remote

    git remote add origin <repository-url>

Example:

    git remote add origin https://github.com/username/myproject.git

Here:

- `remote` manages remote repositories.
- `add` adds a remote.
- `origin` is the conventional name for the remote.
- `<repository-url>` is the GitHub repository URL.

---

# 🔎 CHECK THE REMOTE

Use:

    git remote -v

This displays the remote repository information.

Typical idea:

    origin  <repository-url>  (fetch)
    origin  <repository-url>  (push)

---

# 🚀 PUSH TO GITHUB

After committing the changes:

    git push -u origin main

The `-u` option establishes the upstream relationship between the local branch and the remote branch.

After the upstream relationship has been established, future pushes can usually be done with:

    git push

Basic flow:

    Local Project
          ↓
       git add
          ↓
      git commit
          ↓
       git push
          ↓
    GitHub Repository

---

# 📥 GIT PULL

If changes are available on GitHub and you want them in the local project:

    git pull

`git pull` obtains changes from the remote repository and integrates them into the current branch.

Basic idea:

    GitHub
       ↓
    git pull
       ↓
    Local Repository

---

# 📡 GIT FETCH

To download information about changes from the remote without immediately integrating them:

    git fetch

Basic idea:

    git fetch
        ↓
    Download remote changes
        ↓
    Do not automatically merge them

Whereas:

    git pull
        ↓
    Fetch remote changes
        +
    Integrate them into the current branch

---

# 📥 GIT CLONE

If a project already exists on GitHub and you want to download it:

    git clone <repository-url>

Example:

    git clone https://github.com/username/project.git

Then enter the project:

    cd project

Basic flow:

    GitHub Repository
          ↓
       git clone
          ↓
    Local Computer

---

# 🔐 GITHUB USING SSH

An SSH GitHub remote can look like:

    git@github.com:username/project.git

You can test the SSH connection with:

    ssh -T git@github.com

A remote can be added using the SSH URL:

    git remote add origin git@github.com:username/project.git

Then push:

    git push -u origin main

---

# 📜 VIEW GIT HISTORY

To view the commit history:

    git log

For a shorter history:

    git log --oneline

Example:

    a1b2c3d initial commit
    d4e5f6g added homepage

---

# ↩️ RESTORE CHANGES

If a file was modified but the working-directory change should be discarded:

    git restore <file>

To unstage a file:

    git restore --staged <file>

---

# 🔀 GIT MERGE

To merge one branch into another:

    git switch main
    git merge feature

Basic idea:

    feature branch
          ↓
       git merge
          ↓
         main

---

# ⚠️ MERGE CONFLICT

A merge conflict can occur when different branches modify the same part of a file in incompatible ways.

General process:

    git merge feature
          ↓
       Conflict
          ↓
    Open the conflicting file
          ↓
    Resolve the changes
          ↓
       git add .
          ↓
       git commit

After resolving the conflict:

    git add .
    git commit -m "resolved merge conflict"

---

# 👥 COLLABORATION WORKFLOW

A developer can clone the project:

    git clone <repository-url>

Then:

    cd project

Make changes.

Check them:

    git status

Stage them:

    git add .

Commit them:

    git commit -m "added feature"

Push them:

    git push

Other developers can obtain the changes:

    git pull

Complete collaboration flow:

    GitHub Repository
          ↓
       git clone
          ↓
    Developer Computer
          ↓
       Edit files
          ↓
       git add
          ↓
       git commit
          ↓
       git push
          ↓
    GitHub Repository
          ↓
    Other developer
          ↓
       git pull

---

# 🌿 FEATURE BRANCH WORKFLOW

A common workflow is:

    main
      ↓
    Create feature branch
      ↓
    Work on feature
      ↓
    git add .
      ↓
    git commit
      ↓
    git push
      ↓
    GitHub
      ↓
    Merge feature into main

Example:

    git switch -c feature

After making changes:

    git add .
    git commit -m "added feature"
    git push -u origin feature

Then the feature branch can be merged into the main branch.

---

# 🧪 COMMON PROJECT CHECKING WORKFLOW

Whenever changes are made:

    Edit files
       ↓
    git status
       ↓
    git add .
       ↓
    git commit -m "message"
       ↓
    git push
       ↓
    Check GitHub

If changes already exist remotely:

    git pull

---

# 🗂️ IMPORTANT GIT COMMANDS

    git init
    git status
    git add .
    git add <file>
    git commit -m "message"
    git branch
    git switch <branch>
    git checkout <branch>
    git checkout -b <branch>
    git log
    git log --oneline
    git restore <file>
    git restore --staged <file>
    git remote -v
    git remote add origin <URL>
    git fetch
    git pull
    git push
    git push -u origin main
    git clone <URL>
    git merge <branch>

---

# 🎯 INTERVIEW-READY QUESTIONS & ANSWERS

## What is Git?

Git is a distributed version-control system used to track changes in source code and manage different versions of a project.

## What is GitHub?

GitHub is a platform used to host Git repositories remotely and collaborate with other developers.

## What does `git init` do?

It initializes a new Git repository in the current directory.

## What does `git status` do?

It shows the current state of the working directory and staging area.

## What does `git add .` do?

It stages the changes in the current directory for the next commit.

## What does `git commit` do?

It records the staged changes in the local Git repository.

## What does `git push` do?

It sends local commits to a remote repository such as GitHub.

## What does `git pull` do?

It retrieves changes from the remote repository and integrates them into the current branch.

## What does `git fetch` do?

It downloads information about remote changes without automatically integrating them.

## What does `git clone` do?

It creates a local copy of an existing remote Git repository.

## What is a branch?

A branch is an independent line of development that allows developers to work on changes separately.

## What is `origin`?

`origin` is the conventional name used for the main remote repository.

## What is the staging area?

The staging area contains changes that have been selected to be included in the next commit.

## What is a commit?

A commit is a saved snapshot of staged changes in the Git repository.

## What is a remote repository?

A remote repository is a Git repository stored on another system or service, such as GitHub.

## What is a merge?

A merge combines changes from one branch into another branch.

## What is a merge conflict?

A merge conflict happens when Git cannot automatically determine which changes should be kept when combining branches.

---

# 🔥 DAY 15 QUICK REVISION

    Linux
      ├── /root
      ├── /home
      ├── /etc
      ├── /var
      ├── /bin
      └── /usr

    Process Commands
      ├── ps
      ├── ps -ef
      ├── top
      ├── kill
      ├── kill -9
      ├── grep
      └── find

    Git
      ├── git init
      ├── git status
      ├── git add
      ├── git commit
      ├── git branch
      ├── git switch
      ├── git checkout
      ├── git log
      ├── git restore
      ├── git remote
      ├── git fetch
      ├── git pull
      ├── git push
      ├── git clone
      └── git merge

    GitHub
      └── Remote Git repository

---

# 🧠 ONE-LINE MEMORY FLOW

    CREATE PROJECT
        ↓
    git init
        ↓
    git status
        ↓
    git add .
        ↓
    git commit -m "message"
        ↓
    git remote add origin <URL>
        ↓
    git push -u origin main
        ↓
    GITHUB

    For future changes:

    Edit
      ↓
    git status
      ↓
    git add .
      ↓
    git commit
      ↓
    git push

    To receive remote changes:

    git pull

# ✅ END OF DAY 15
