<div align="center">

# 🚀 GIT & GITHUB

## Complete DevOps / Cloud Engineer Notes

</div>

> My goal with these notes is simple: if I open this GitHub repository later, I should be able to understand **Git, GitHub, branches, commits, PRs, conflicts, undoing changes, collaboration, authentication, and how Git connects to CI/CD** without needing another basic Git document.

---

# 1. First — What is Git?

Git is a **distributed version control system**.

I use Git to track changes in my code and configuration files.

Instead of having files like:

```text
project-final
project-final-v2
project-final-v3
project-final-final
```

I can use Git to keep a proper history of my changes.

For example:

```text
Commit A
   ↓
Commit B
   ↓
Commit C
   ↓
Commit D
```

Each commit represents a point in my project's history.

### Why Git is important for DevOps

As a DevOps/Cloud Engineer, I may work with:

* Application code
* Dockerfiles
* Kubernetes YAML
* Terraform
* Ansible
* Jenkinsfiles
* GitHub Actions workflows
* Shell scripts
* Cloud configuration
* Monitoring configuration

All of these can be stored and version-controlled using Git.

---

# 2. What is GitHub?

GitHub is a platform where Git repositories can be hosted and collaborated on.

I can think of it like this:

```text
Git
 ↓
Version control tool

GitHub
 ↓
Platform for hosting and collaborating on Git repositories
```

Git itself can work without GitHub.

For example:

```text
My Laptop
   ↓
Git repository
```

I can use Git locally without uploading anything.

When I connect it to GitHub:

```text
My Laptop
   ↓
Local Git Repository
   ↓ git push
GitHub
   ↓
Remote Repository
```

---

# 3. Git vs GitHub

| Git                     | GitHub                              |
| ----------------------- | ----------------------------------- |
| Version control system  | Platform for hosting/collaboration  |
| Runs locally            | Cloud-based service                 |
| Tracks changes          | Hosts Git repositories              |
| Creates commits         | Stores remote repositories          |
| Handles branches        | Provides PRs, Issues, Actions, etc. |
| Can work without GitHub | Uses Git repositories               |

### Easy interview answer

> Git is a distributed version control system used to track changes in files, while GitHub is a platform used to host Git repositories and collaborate with other developers.

---

# 4. The Complete Git Picture

As a DevOps engineer, I think about Git like this:

```text
                    GITHUB
               Remote Repository
                       ☁️
                       ↑
                    git push
                       |
             ┌─────────┴─────────┐
             |                   |
        My Laptop           CI/CD Pipeline
             |            Jenkins / Actions
             |
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
           GitHub
```

The most important basic flow is:

```text
Modify code
    ↓
git status
    ↓
git add
    ↓
git commit
    ↓
git push
    ↓
GitHub
```

---

# 5. Git Has Three Important Areas

This is something I need to understand properly.

```text
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
GitHub / Remote Repository
```

## Working Directory

This is where I actually modify files.

Example:

```text
app.py
Dockerfile
deployment.yaml
```

I edit them here.

---

## Staging Area

After:

```bash
git add app.py
```

the changes are placed in the staging area.

I can think:

> "I want this change to be included in my next commit."

---

## Local Repository

After:

```bash
git commit -m "Fix application configuration"
```

the staged changes become a commit in my local Git repository.

---

## Remote Repository

After:

```bash
git push
```

my commits are sent to the remote repository, commonly GitHub.

---

# 6. Create a Git Repository — `git init`

If I have a normal project directory and want Git to start tracking it:

```bash
git init
```

Example:

```bash
mkdir my-project
cd my-project
git init
```

Git creates a hidden:

```text
.git/
```

directory.

That `.git` directory contains the information Git needs to manage the repository.

I should **not manually modify `.git`** unless I know exactly what I'm doing.

---

# 7. Clone an Existing Repository

If the repository already exists on GitHub:

```bash
git clone <repository-url>
```

Example:

```bash
git clone https://github.com/user/project.git
```

Then:

```bash
cd project
```

Think:

```text
GitHub Repository
       ↓
   git clone
       ↓
Local Repository
```

This is extremely common when working on:

* Development machines
* Cloud servers
* CI/CD machines
* Jenkins workers
* Deployment environments

---

# 8. Git Configuration

Before using Git, I should configure my identity.

```bash
git config --global user.name "My Name"
git config --global user.email "myemail@example.com"
```

Check:

```bash
git config --global --list
```

Or:

```bash
git config --list
```

I can also check individual values:

```bash
git config user.name
git config user.email
```

### Why?

Git records author information with commits.

---

# 9. Check Git Version

```bash
git --version
```

Example:

```text
git version 2.x.x
```

Useful when troubleshooting whether Git is installed and which version I'm using.

---

# 10. Git Status ⭐⭐⭐⭐⭐

One of the commands I should use constantly:

```bash
git status
```

It tells me things such as:

* Which branch I am on
* Modified files
* Untracked files
* Staged changes
* Changes that can be committed

Example:

```text
On branch main

Changes not staged for commit:
  modified: app.py

Untracked files:
  test.py
```

My habit should be:

```bash
git status
```

before and after important operations.

---

# 11. Git Add ⭐⭐⭐⭐⭐

To stage a specific file:

```bash
git add app.py
```

Multiple files:

```bash
git add app.py Dockerfile
```

All current changes:

```bash
git add .
```

Think:

```text
Working Directory
       ↓
    git add
       ↓
Staging Area
```

### Important

`git add` does **not** mean GitHub.

It only stages changes locally.

---

# 12. Git Commit ⭐⭐⭐⭐⭐

Commit staged changes:

```bash
git commit -m "Fix application configuration"
```

A commit is basically a saved checkpoint in Git history.

Think:

```text
Changes
   ↓
git add
   ↓
Staging
   ↓
git commit
   ↓
Saved Git history
```

Good commit:

```bash
git commit -m "Fix nginx configuration"
```

Bad commit:

```bash
git commit -m "changes"
```

I should make commit messages meaningful.

---

# 13. Git Log

To see commit history:

```bash
git log
```

Useful compact version:

```bash
git log --oneline
```

Example:

```text
a1b2c3d Fix nginx configuration
d4e5f6g Add Kubernetes deployment
h7i8j9k Update Dockerfile
```

I can use this to understand what happened in the repository.

---

# 14. Git Show

To inspect a specific commit:

```bash
git show <commit-hash>
```

Example:

```bash
git show a1b2c3d
```

This helps me see what that commit changed.

---

# 15. Git Diff ⭐⭐⭐⭐⭐

`git diff` shows changes that have not been staged.

```bash
git diff
```

Think:

```text
Current file
     ↓
git diff
     ↓
What did I change?
```

To see staged changes:

```bash
git diff --staged
```

This is useful before committing.

---

# 16. Remote Repository

A remote repository is a Git repository stored somewhere outside my local machine, usually GitHub.

```text
Local Repository
       ↓
      push
       ↓
GitHub Repository
```

Check remotes:

```bash
git remote -v
```

I may see:

```text
origin  https://github.com/user/project.git
origin  https://github.com/user/project.git
```

---

# 17. What is `origin`?

`origin` is simply a conventional/default name for a remote repository.

I can think:

```text
origin = remote GitHub repository
```

It is only a name.

For example, I could technically name a remote:

```text
github
```

instead of:

```text
origin
```

---

# 18. Add a Remote

```bash
git remote add origin <URL>
```

Example:

```bash
git remote add origin https://github.com/user/project.git
```

Check:

```bash
git remote -v
```

---

# 19. Change Remote URL

```bash
git remote set-url origin <new-url>
```

Example:

```bash
git remote set-url origin https://github.com/user/new-project.git
```

---

# 20. Remove a Remote

If I no longer need a remote:

```bash
git remote remove origin
```

Check again:

```bash
git remote -v
```

---

# 21. Push — Local → Remote ⭐⭐⭐⭐⭐

`git push` sends my local commits to the remote repository.

```bash
git push origin main
```

Think:

```text
Local main
    ↓
 git push
    ↓
GitHub main
```

Another common command:

```bash
git push -u origin main
```

`-u` sets the upstream relationship.

After that, I can often simply use:

```bash
git push
```

Example:

```bash
git add .
git commit -m "Update application configuration"
git push origin main
```

---

# 22. Pull — Remote → Local ⭐⭐⭐⭐⭐

```bash
git pull origin main
```

`git pull` downloads remote changes and integrates them into my current branch.

Think:

```text
GitHub
   ↓
git pull
   ↓
Local branch
```

### Important difference

```text
git push
Local → Remote

git pull
Remote → Local
```

---

# 23. Fetch — Remote → Local Without Automatically Merging ⭐⭐⭐⭐⭐

```bash
git fetch origin
```

`git fetch` downloads the latest remote information but does not merge those changes into my current branch.

Think:

```text
GitHub
   ↓
git fetch
   ↓
Local Git knowledge

❌ No automatic merge
```

Then I can inspect the changes before deciding what to do.

### Pull vs Fetch

| Command     | Downloads remote changes | Automatically integrates |
| ----------- | -----------------------: | -----------------------: |
| `git fetch` |                        ✅ |                        ❌ |
| `git pull`  |                        ✅ |                        ✅ |

### Interview answer

> `git fetch` downloads remote changes without integrating them into my current branch, while `git pull` downloads and integrates them into the current branch.

---

# 24. Branches ⭐⭐⭐⭐⭐

Branches allow me to work on changes separately.

Suppose:

```text
main
```

contains production code.

I don't want everyone directly changing production code.

I create:

```bash
git branch feature/login
```

Switch:

```bash
git switch feature/login
```

Or create and switch at the same time:

```bash
git switch -c feature/login
```

Older command:

```bash
git checkout -b feature/login
```

---

# 25. Branch Example

```text
main

A
|
B
|
C
 \
  D
  |
  E
feature/login
```

I work on:

```text
feature/login
```

Then:

```bash
git add .
git commit -m "Add login feature"
git push -u origin feature/login
```

Then I create a Pull Request.

---

# 26. List Branches

Local branches:

```bash
git branch
```

All local + remote branches:

```bash
git branch -a
```

Remote branches:

```bash
git branch -r
```

---

# 27. Switch Branch

Modern command:

```bash
git switch main
```

Switch to feature branch:

```bash
git switch feature/login
```

Create and switch:

```bash
git switch -c feature/login
```

Older syntax:

```bash
git checkout feature/login
```

---

# 28. Delete a Branch

After merging a local feature branch:

```bash
git branch -d feature/login
```

Force delete:

```bash
git branch -D feature/login
```

Be careful with `-D` because it can delete a branch even when Git believes it has unmerged changes.

Delete a remote branch:

```bash
git push origin --delete feature/login
```

---

# 29. Tracking Branches / Upstream

When I run:

```bash
git push -u origin feature/login
```

Git remembers the relationship between:

```text
local feature/login
        ↓
remote origin/feature/login
```

After that, I can usually use:

```bash
git push
git pull
```

without specifying the remote and branch every time.

---

# 30. Pull Request ⭐⭐⭐⭐⭐

A Pull Request means:

> "I have made changes in my branch. Please review them and merge them into another branch."

Typical workflow:

```text
feature/login
      ↓
   git push
      ↓
    GitHub
      ↓
 Pull Request
      ↓
 Code Review
      ↓
 CI/CD Tests
      ↓
 Approval
      ↓
   Merge
      ↓
    main
```

A PR is **not the same thing as `git pull`**.

This is an important distinction.

* `git pull` = Git command
* Pull Request = GitHub collaboration/review mechanism

---

# 31. Merge

Suppose:

```text
main:
A → B → C

feature:
      \
       D → E
```

I can merge the feature branch into main:

```bash
git switch main
git merge feature
```

Depending on the history, Git may create a merge commit.

Conceptually:

```text
A → B → C
         \
          D → E
```

becomes integrated into `main`.

---

# 32. Merge Conflict ⭐⭐⭐⭐⭐

Suppose two branches modify the same part of a file.

```text
main:
Hello World

feature:
Hello DevOps
```

Git may not know which change should win.

I might see:

```text
<<<<<<< HEAD
Hello World
=======
Hello DevOps
>>>>>>> feature
```

I manually decide the correct final content.

Then:

```bash
git add .
git commit
```

If the conflict happened during a merge and I want to cancel it:

```bash
git merge --abort
```

### My conflict-resolution process

```text
Conflict
   ↓
Open conflicted file
   ↓
Understand both changes
   ↓
Choose/combine correct code
   ↓
Remove conflict markers
   ↓
git add <file>
   ↓
Complete merge
```

### Interview answer

> A merge conflict occurs when Git cannot automatically combine changes, usually because different branches changed the same part of a file. I resolve the conflicting content manually, stage the resolved files, and complete the merge.

---

# 33. Rebase ⭐⭐⭐⭐

Rebase moves/replays my branch commits onto a new base.

Before:

```text
main:
A → B → C

feature:
      \
       D → E
```

If main has moved forward, I can use:

```bash
git rebase main
```

Conceptually:

```text
A → B → C → D' → E'
```

My feature commits are replayed on top of the latest main.

### Why use rebase?

It can create a cleaner, more linear history.

### Important warning

I should avoid rebasing commits that other people are already depending on, especially shared/public branches, because rebase rewrites commit history.

### Merge vs Rebase

| Merge                             | Rebase                                   |
| --------------------------------- | ---------------------------------------- |
| Combines histories                | Replays commits onto another base        |
| Can create merge commit           | Usually produces linear history          |
| Does not rewrite existing commits | Rewrites/recreates commits               |
| Common for shared integration     | Useful for keeping feature history clean |

### Interview answer

> Merge combines histories, while rebase replays commits onto a new base to create a cleaner history.

---

# 34. Restore vs Reset vs Revert ⭐⭐⭐⭐⭐

This is something I must know properly.

---

## `git restore`

Mainly used to restore/discard file changes or unstage files.

Discard an uncommitted change:

```bash
git restore app.py
```

Meaning:

> Discard my current uncommitted changes in `app.py`.

Unstage:

```bash
git restore --staged app.py
```

---

# 35. `git reset`

Reset moves `HEAD` and can move the branch pointer backward.

Suppose:

```text
A → B → C
        ↑
       HEAD
```

```bash
git reset --soft HEAD~1
```

moves HEAD backward one commit but keeps the changes staged.

### Soft

```bash
git reset --soft HEAD~1
```

Keeps changes staged.

### Mixed

```bash
git reset --mixed HEAD~1
```

Keeps changes in the working directory but unstages them.

### Hard

```bash
git reset --hard HEAD~1
```

Discards the changes represented by the reset.

⚠️ Be extremely careful with:

```bash
git reset --hard
```

It can permanently discard work that isn't otherwise saved.

---

# 36. `git revert` ⭐⭐⭐⭐⭐

`git revert` is particularly important for shared branches.

Suppose:

```text
A → B → C
```

I want to undo B.

I use:

```bash
git revert <commit-hash>
```

Git creates a **new commit** that reverses the earlier change:

```text
A → B → C → D
             ↑
        D undoes B
```

The old history remains.

### Why is revert safer for shared branches?

Because I am not rewriting existing shared history.

### Interview answer

> `git revert` creates a new commit that reverses the changes of an earlier commit, making it safer for shared branches.

---

# 37. Restore vs Reset vs Revert — Easy Memory Trick

```text
restore
   ↓
file changes

reset
   ↓
move HEAD/branch backward

revert
   ↓
new commit that undoes an old commit
```

| Command   | Main purpose                                  |
| --------- | --------------------------------------------- |
| `restore` | Restore/unstage file changes                  |
| `reset`   | Move HEAD/branch backward                     |
| `revert`  | Create a new commit that undoes an old commit |

For production/shared branches:

```text
Prefer:
git revert

Be careful with:
git reset --hard
```

---

# 38. Git Stash ⭐⭐⭐⭐

Suppose I am working on:

```text
feature/login
```

and I have unfinished changes.

Suddenly I need to switch branches.

I don't want to commit unfinished work.

I can use:

```bash
git stash
```

My changes are temporarily stored.

Then:

```bash
git switch main
```

Do my work.

Later:

```bash
git switch feature/login
git stash pop
```

My changes come back.

Think:

```text
Unfinished work
      ↓
 git stash
      ↓
Temporary storage
      ↓
Switch branch
      ↓
git stash pop
      ↓
Continue work
```

Useful commands:

```bash
git stash
git stash list
git stash pop
git stash apply
git stash drop
git stash clear
```

### `pop` vs `apply`

```text
git stash pop
```

Applies the stash and removes it if successful.

```text
git stash apply
```

Applies the stash but keeps the stash entry.

---

# 39. Git Tags ⭐⭐⭐⭐

Tags mark important points in Git history.

They are commonly used for releases.

Example:

```text
A → B → C → D → E
        ↑
      v1.0.0
```

Create:

```bash
git tag v1.0.0
```

Annotated tag:

```bash
git tag -a v1.0.0 -m "Release version 1.0.0"
```

List:

```bash
git tag
```

Push one:

```bash
git push origin v1.0.0
```

Push all:

```bash
git push origin --tags
```

### Why DevOps cares

CI/CD pipelines can use tags to identify release versions.

Example:

```text
v1.0.0 → Production
v1.1.0 → Production
v2.0.0 → Production
```

---

# 40. Cherry-pick ⭐⭐⭐⭐

Cherry-pick means:

> Take one specific commit from another branch and apply it to my current branch.

Example:

```text
feature:

A → B → C
        ↑
       fix
```

I need only C on main.

```bash
git switch main
git cherry-pick <commit-hash>
```

Conceptually:

```text
main:

A → B → C'
```

The commit is applied as a new commit on the current branch.

### DevOps example

Suppose a bug fix exists in a development branch, but production needs only that fix.

Instead of merging the whole branch:

```bash
git cherry-pick <commit>
```

I can apply just the required fix.

---

# 41. `.gitignore` ⭐⭐⭐⭐⭐

`.gitignore` tells Git which files/directories should not normally be tracked.

Example:

```text
.env
node_modules/
*.log
*.tmp
__pycache__/
.vscode/
```

I should normally avoid committing:

```text
.env
passwords
API keys
AWS credentials
private keys
logs
temporary files
build output
```

### Very important

`.gitignore` is **not a security mechanism**.

If I already committed a secret:

```text
password
API key
AWS access key
```

adding it to `.gitignore` does not magically erase the secret from Git history.

I need to:

1. Remove the secret properly
2. Rotate/revoke the exposed credential
3. Clean history if required
4. Make sure it is ignored going forward

---

# 42. GitHub Authentication ⭐⭐⭐⭐⭐

When I work with GitHub from my laptop or a server, GitHub needs to know that I am authorized to access the repository.

Common approaches include:

```text
HTTPS authentication
SSH authentication
```

For HTTPS, GitHub commonly uses a **Personal Access Token (PAT)** rather than an account password for Git operations.

For SSH, I use an SSH key pair.

---

# 43. SSH Authentication

The basic idea:

```text
My Machine
   |
   | SSH private key
   ↓
GitHub
   |
   | verifies public key
   ↓
Access
```

I generally keep:

```text
Private key → ONLY on my machine
Public key  → Can be registered with GitHub
```

### Important security rule

Never share my private SSH key.

For example, a private key might be:

```text
~/.ssh/id_ed25519
```

The corresponding public key:

```text
~/.ssh/id_ed25519.pub
```

The `.pub` key can be added to GitHub.

---

# 44. Test GitHub SSH Access

A common test is:

```bash
ssh -T git@github.com
```

If authentication is configured correctly, GitHub can identify the authenticated account.

---

# 45. HTTPS vs SSH Git Remote

HTTPS remote:

```text
https://github.com/user/project.git
```

SSH remote:

```text
git@github.com:user/project.git
```

Check:

```bash
git remote -v
```

I should understand which authentication method the repository is using.

---

# 46. Personal Access Token — PAT

When using HTTPS Git operations, GitHub may require a Personal Access Token instead of a password.

A PAT is essentially a credential/token used to authenticate GitHub API or Git operations according to its permissions.

### Important

I should:

* Give it only required permissions
* Keep it secret
* Never commit it into Git
* Never paste it into public repositories
* Rotate/revoke it if exposed

---

# 47. Fork ⭐⭐⭐⭐

A **fork** is my own GitHub copy of another repository under my GitHub account/namespace.

Typical open-source workflow:

```text
Original Repository
        ↓
      Fork
        ↓
My GitHub Repository
        ↓
Clone
        ↓
My Laptop
        ↓
Changes
        ↓
Push
        ↓
My Fork
        ↓
Pull Request
        ↓
Original Repository
```

This is very common when I don't have direct write access to the original repository.

---

# 48. `origin` vs `upstream` ⭐⭐⭐⭐

This becomes important when working with forks.

Suppose:

```text
Original project
      ↓
    upstream

My fork
      ↓
    origin
```

I clone my fork:

```bash
git clone <my-fork-url>
```

Usually:

```text
origin = my fork
```

I can add the original repository:

```bash
git remote add upstream <original-repository-url>
```

Then:

```bash
git remote -v
```

could show:

```text
origin
upstream
```

Think:

```text
upstream = original project
origin   = my fork
```

---

# 49. Keeping a Fork Updated

I can fetch changes from the original project:

```bash
git fetch upstream
```

Then update my branch appropriately, for example:

```bash
git switch main
git merge upstream/main
```

or use an appropriate rebase workflow when suitable.

The exact strategy depends on the team's workflow.

---

# 50. GitHub Repository Permissions ⭐⭐⭐⭐

GitHub repositories can have different access levels.

The important idea is:

```text
Who can see?
Who can contribute?
Who can administer?
```

In an organization, access can be controlled through:

* Repository permissions
* Teams
* Organization membership
* Branch protection/rules
* Code review requirements

As a DevOps engineer, I should understand that repository access is part of the security model.

---

# 51. Protected Branches ⭐⭐⭐⭐⭐

Production branches such as:

```text
main
production
```

may be protected.

A protected branch can enforce rules such as:

```text
Direct push ❌
       ↓
Pull Request ✅
       ↓
Code Review
       ↓
Required checks
       ↓
Merge
```

Typical protections can include:

* Pull Request requirement
* Required approvals
* Required status checks
* Restrictions on who can push
* Restrictions on force pushes

This is extremely relevant to DevOps because it prevents accidental direct changes to production code.

---

# 52. Pull Request Review Workflow

A practical DevOps workflow may look like:

```text
Developer
   ↓
Create feature branch
   ↓
Make changes
   ↓
git add
   ↓
git commit
   ↓
git push
   ↓
Create PR
   ↓
Automated CI checks
   ↓
Code review
   ↓
Approval
   ↓
Merge
   ↓
Deployment
```

If CI fails:

```text
PR
 ↓
CI fails
 ↓
Developer fixes code
 ↓
Commit + push
 ↓
CI runs again
```

---

# 53. GitHub Issues

Issues can track:

```text
🐛 Bugs
📝 Tasks
✨ Features
💬 Work items
```

Example:

```text
Issue #123
"Application is returning 502 error"
```

I can use Issues to track infrastructure/application problems.

---

# 54. GitHub Releases

A GitHub Release represents a published version of a project.

Example:

```text
v1.0.0
v1.1.0
v2.0.0
```

A release can include:

* Version/tag
* Release notes
* Build artifacts
* Packages

CI/CD pipelines can use tags/releases as deployment triggers.

---

# 55. GitHub Actions ⭐⭐⭐⭐⭐

GitHub Actions is GitHub's automation/CI/CD platform.

A basic pipeline can look like:

```text
Code Push
   ↓
GitHub Actions
   ↓
Build
   ↓
Test
   ↓
Docker Image
   ↓
Push Image
   ↓
Deploy
```

For DevOps, this is extremely important.

---

# 56. GitHub Actions Workflow

GitHub Actions workflows are commonly stored inside:

```text
.github/workflows/
```

Example:

```text
.github/
└── workflows/
    └── ci.yml
```

A workflow defines automation that GitHub Actions should execute.

A simplified example:

```yaml
name: CI

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Run tests
        run: echo "Running tests"

      - name: Build
        run: echo "Building application"
```

I don't need to memorize every YAML field immediately.

I need to understand the structure:

```text
Workflow
   ↓
Trigger
   ↓
Job
   ↓
Steps
```

---

# 57. GitHub Actions — Important Concepts

### Workflow

The complete automation definition.

### Trigger

Defines when it runs.

Examples:

```text
push
pull_request
workflow_dispatch
schedule
```

### Job

A unit of work.

### Step

An individual command/action inside a job.

Conceptually:

```text
Workflow
   |
   ├── Trigger
   |
   └── Job
        |
        ├── Step
        ├── Step
        └── Step
```

---

# 58. CI/CD Connection

This is one of the most important DevOps concepts.

```text
Developer
   ↓
Git commit
   ↓
Push
   ↓
GitHub
   ↓
CI Pipeline
   ↓
Build
   ↓
Test
   ↓
Security checks
   ↓
Build artifact / Docker image
   ↓
Deployment
   ↓
Cloud / Kubernetes
```

So Git is not just a developer tool.

For DevOps, Git becomes the starting point for automation.

---

# 59. Git + Docker + Kubernetes

A real DevOps workflow can look like:

```text
Developer
   ↓
Git commit
   ↓
GitHub
   ↓
Pull Request
   ↓
CI
   ↓
Build Docker Image
   ↓
Push Image to Registry
   ↓
Update Kubernetes deployment
   ↓
Deploy to Kubernetes
```

Example repository:

```text
my-app/
├── application/
├── Dockerfile
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
└── .github/
    └── workflows/
        └── ci.yml
```

This is why Git/GitHub knowledge is essential for DevOps.

---

# 60. GitFlow — Understand the Concept

One traditional branching model is GitFlow:

```text
main
develop
feature/*
release/*
hotfix/*
```

I should understand the concept, but I don't need to memorize every detail.

For modern DevOps interviews, the more important concepts are:

```text
main
feature branches
Pull Request
code review
CI/CD
merge
release/tag
deployment
```

---

# 61. Feature Branch Workflow ⭐⭐⭐⭐⭐

A common workflow:

```text
main
  |
  ├── feature/login
  |
  ├── feature/payment
  |
  └── bugfix/nginx
```

Example:

```bash
git switch main
git pull origin main

git switch -c feature/login

# make changes

git status
git add .
git commit -m "Add login feature"

git push -u origin feature/login
```

Then:

```text
Create PR
   ↓
Review
   ↓
CI
   ↓
Approval
   ↓
Merge
```

---

# 62. Best Practices ⭐⭐⭐⭐⭐

## 1. Meaningful commits

Good:

```bash
git commit -m "Fix nginx configuration"
```

Bad:

```bash
git commit -m "changes"
```

---

## 2. Small logical commits

Instead of:

```text
One huge unrelated commit
```

prefer:

```text
Commit 1 → Fix Dockerfile
Commit 2 → Update Kubernetes manifest
Commit 3 → Fix monitoring configuration
```

---

## 3. Use feature branches

Avoid everyone directly modifying:

```text
main
```

---

## 4. Pull/fetch before starting work

For example:

```bash
git switch main
git pull origin main
```

Or inspect first:

```bash
git fetch origin
```

Then decide whether to merge/rebase as appropriate.

---

## 5. Never commit secrets

Never commit:

```text
password
API key
AWS access key
private key
.env
```

---

# 63. Common Git Status States

I should understand these states:

```text
Untracked
Modified
Staged
Committed
Pushed
```

Think:

```text
New file
   ↓
Untracked
   ↓ git add
Staged
   ↓ git commit
Committed
   ↓ git push
Remote
```

For modified existing files:

```text
Modified
   ↓ git add
Staged
   ↓ git commit
Committed
   ↓ git push
Remote
```

---

# 64. Common Real-World Workflow

If I start work in the morning:

```bash
git switch main
git pull origin main

git switch -c feature/my-change
```

Make changes.

Then:

```bash
git status
git diff
```

Stage:

```bash
git add .
```

Check staged changes:

```bash
git diff --staged
```

Commit:

```bash
git commit -m "Implement required change"
```

Push:

```bash
git push -u origin feature/my-change
```

Then:

```text
GitHub
   ↓
Pull Request
   ↓
Review
   ↓
CI
   ↓
Merge
```

---

# 65. If I Need to Temporarily Leave My Work

```bash
git stash
git switch main
```

After finishing:

```bash
git switch feature/my-change
git stash pop
```

---

# 66. If I Need to Undo an Uncommitted File Change

```bash
git restore app.py
```

---

# 67. If I Accidentally Staged a File

```bash
git restore --staged app.py
```

The file remains modified, but it is no longer staged.

---

# 68. If I Need to Undo a Shared Commit

Prefer:

```bash
git revert <commit-hash>
```

rather than rewriting shared history.

---

# 69. If I Need to Inspect Remote Changes

Instead of immediately pulling:

```bash
git fetch origin
```

Then inspect:

```bash
git log
git diff
```

and decide what to integrate.

---

# 70. Common Git Troubleshooting

## Problem: "Why isn't my file included in the commit?"

I would check:

```bash
git status
```

Maybe I forgot:

```bash
git add <file>
```

Then:

```bash
git commit
```

---

## Problem: "My push was rejected"

I would check:

```bash
git status
git fetch origin
```

There may be remote commits I don't have locally.

Then I need to integrate them according to the team's workflow.

---

## Problem: "I have a merge conflict"

I would:

```text
Check conflicted files
      ↓
Open files
      ↓
Resolve conflict markers
      ↓
git add <resolved-file>
      ↓
Complete merge
```

---

## Problem: "I committed the wrong change"

First I need to understand whether the commit is:

```text
Local/private
```

or:

```text
Already shared/pushed
```

For shared history, `git revert` is generally safer.

---

# 71. Git Clean

To see files that are untracked:

```bash
git status
```

Git also has:

```bash
git clean
```

which can remove untracked files.

⚠️ This can be destructive, so I should understand exactly what it will remove before using force options.

---

# 72. HEAD

`HEAD` is my current position in Git history.

For example:

```text
A → B → C
        ↑
       HEAD
```

If I move to another commit:

```bash
git checkout <commit>
```

or use other modern Git commands as appropriate, `HEAD` can point somewhere else.

For everyday work, the main thing I need to remember is:

```text
HEAD = where I am currently positioned in Git history
```

---

# 73. HEAD~1

If:

```text
A → B → C
        ↑
       HEAD
```

then:

```text
HEAD~1
```

means the commit immediately before HEAD.

And:

```text
HEAD~2
```

means two commits before HEAD.

Example:

```bash
git reset --soft HEAD~1
```

means move back one commit while keeping the changes staged.

---

# 74. Commit Hash

Each Git commit has an identifier/hash.

Example:

```text
a1b2c3d...
```

I can use a commit hash with commands such as:

```bash
git show <hash>
git revert <hash>
git cherry-pick <hash>
```

---

# 75. Detached HEAD — Know the Concept

Normally I am on a branch:

```text
main
  ↓
HEAD
```

If I directly check out a commit:

```bash
git checkout <commit-hash>
```

I may enter a **detached HEAD** state.

Conceptually:

```text
main
 ↓
A → B → C

HEAD
 ↓
C
```

but HEAD is not attached to a branch in the normal way.

For normal development, I generally want to work on a branch.

---

# 76. `.git` vs `.gitignore`

Do not confuse these.

```text
.git
```

is Git's internal repository data.

```text
.gitignore
```

contains patterns telling Git which files should normally be ignored.

---

# 77. GitHub Repository Structure

A DevOps repository may look like:

```text
project/
│
├── application/
│
├── Dockerfile
│
├── docker-compose.yml
│
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
│
├── terraform/
│
├── scripts/
│
├── Jenkinsfile
│
├── .github/
│   └── workflows/
│       └── ci.yml
│
├── .gitignore
└── README.md
```

Git can version-control all of these files.

---

# 78. GitHub README

A `README.md` usually explains the project.

It may contain:

```text
Project description
Installation
Usage
Architecture
Configuration
Deployment
Troubleshooting
```

For DevOps projects, a good README can make it much easier for another engineer to understand the repository.

---

# 79. GitHub Actions Secrets

CI/CD sometimes needs sensitive values.

For example:

```text
Cloud credentials
API tokens
Registry credentials
Deployment credentials
```

I should not hard-code them in:

```text
workflow YAML
source code
Dockerfile
Git repository
```

Instead, GitHub Actions can use repository/environment/organization secret mechanisms according to the setup.

Conceptually:

```text
GitHub Secret
      ↓
GitHub Actions
      ↓
Pipeline
```

The important rule:

> Secrets should be managed securely, not committed into Git.

---

# 80. CI/CD and Branches

Different branches can trigger different automation.

For example:

```text
feature/*
   ↓
Tests

main
   ↓
Build
   ↓
Deploy to staging

release/tag
   ↓
Production deployment
```

The exact strategy depends on the organization.

---

# 81. Git Tags + Docker + Deployment

A useful DevOps pattern:

```text
Code
 ↓
Commit
 ↓
CI
 ↓
Build Docker image
 ↓
Tag image
 ↓
Push image
 ↓
Deploy
```

Example:

```text
myapp:v1.0.0
```

Git release:

```text
v1.0.0
```

This gives me a way to associate:

```text
Source code
    ↓
Git commit
    ↓
Git tag
    ↓
Docker image
    ↓
Deployment
```

This traceability is very useful in production.

---

# 82. Pull Request vs Merge

These are not the same.

### Pull Request

A GitHub request asking:

> "Please review and merge my changes."

### Merge

The actual Git operation that combines histories.

Think:

```text
Feature branch
      ↓
Pull Request
      ↓
Review
      ↓
Approval
      ↓
Merge
```

---

# 83. GitHub vs GitLab vs Bitbucket

The Git concept remains the same.

Git is the version-control system.

Platforms such as:

```text
GitHub
GitLab
Bitbucket
```

provide platforms around Git repositories.

For my DevOps preparation, I should focus first on:

```text
Git fundamentals
+
GitHub workflow
+
CI/CD integration
```

---

# 84. Most Important Commands

## ⭐⭐⭐⭐⭐ Must Know

```bash
git clone
git init
git status
git add
git commit
git push
git pull
git fetch

git branch
git switch
git checkout

git merge
git rebase

git log
git diff
git show

git remote -v
git remote add
git remote set-url

git restore
git reset
git revert

git stash
git stash pop

git tag
git cherry-pick
```

Also understand:

```text
.gitignore
GitHub Pull Requests
GitHub Actions
SSH authentication
PAT
protected branches
forks
origin/upstream
```

---

# 85. Commands I Can Learn Later

I don't need to memorize every advanced Git feature immediately.

Examples:

```text
Git aliases
Advanced cherry-pick scenarios
Advanced rebase scenarios
Complex GitFlow
Advanced tag management
GitHub issue templates
Advanced GitHub Actions
Complex hooks
Git internals
```

First become strong in the core workflow.

---

# 86. My DevOps Git Cheat Sheet

## GET CODE

```bash
git clone <url>
```

---

## START A NEW REPOSITORY

```bash
git init
```

---

## CHECK

```bash
git status
git log
git log --oneline
git diff
git diff --staged
git show <commit>
```

---

## SAVE WORK

```bash
git add .
git commit -m "meaningful message"
```

---

## SEND TO GITHUB

```bash
git push origin main
```

First push for a branch:

```bash
git push -u origin main
```

---

## GET FROM GITHUB

```bash
git pull origin main
```

---

## GET WITHOUT AUTOMATICALLY INTEGRATING

```bash
git fetch origin
```

---

## BRANCH

```bash
git branch
git branch -a

git switch -c feature/login
git switch main
```

---

## MERGE

```bash
git merge feature/login
```

---

## REMOTE

```bash
git remote -v
git remote add origin <URL>
git remote set-url origin <URL>
```

---

## UNDO

```bash
git restore <file>
git restore --staged <file>

git reset --soft HEAD~1
git reset --mixed HEAD~1
git reset --hard HEAD~1

git revert <commit>
```

---

## TEMPORARY WORK

```bash
git stash
git stash list
git stash pop
git stash apply
```

---

## RELEASE

```bash
git tag v1.0.0
git push origin v1.0.0
```

---

## SPECIFIC COMMIT

```bash
git cherry-pick <hash>
```

---

## SSH TEST

```bash
ssh -T git@github.com
```

---

# 87. The One Workflow I Must Master ⭐⭐⭐⭐⭐

```text
Developer
   ↓
Clone repository
   ↓
git clone
   ↓
Create feature branch
   ↓
git switch -c feature/login
   ↓
Make changes
   ↓
git status
   ↓
git diff
   ↓
git add
   ↓
git diff --staged
   ↓
git commit
   ↓
git push
   ↓
GitHub
   ↓
Pull Request
   ↓
Code Review
   ↓
CI/CD Tests
   ↓
Approval
   ↓
Merge
   ↓
main
   ↓
Build
   ↓
Docker Image
   ↓
Registry
   ↓
Deploy
   ↓
Cloud / Kubernetes
```

This is the workflow I should be able to explain confidently.

---

# 88. Cloud / DevOps Troubleshooting Mindset

If a deployment is failing, Git can be one of the first places I investigate.

I can ask:

```text
What changed?
      ↓
Which commit?
      ↓
Which branch?
      ↓
Which PR?
      ↓
Did CI pass?
      ↓
Which artifact/image was built?
      ↓
Which version was deployed?
```

For example:

```text
Production issue
      ↓
Find deployment version
      ↓
Find Docker image tag
      ↓
Find Git tag/commit
      ↓
Inspect commit
      ↓
Find PR
      ↓
Understand change
      ↓
Fix/revert
```

This is where Git becomes extremely useful for production troubleshooting.

---

# 89. Production Rollback Thinking

Suppose:

```text
v1.0.0 → Working
v1.1.0 → Working
v1.2.0 → Production problem
```

I need to identify:

```text
Which Git commit?
Which Git tag?
Which Docker image?
Which deployment?
```

Then the organization can decide whether to:

```text
revert code
or
redeploy a known-good version
```

The important DevOps concept is **traceability**.

---

# 90. What I Should Never Do

I should never casually:

```text
Commit passwords
Commit AWS credentials
Commit private keys
Commit API tokens
Force-push shared branches
Run git reset --hard without understanding it
Delete important branches without checking
Modify production directly without the team's workflow
```

---

# 91. Interview Questions I Must Be Able to Answer

### Git fundamentals

1. What is Git?
2. What is GitHub?
3. Git vs GitHub?
4. Why do we use Git?
5. What is a Git repository?
6. What is a local repository?
7. What is a remote repository?
8. What is `.git`?
9. What is `.gitignore`?
10. What is a commit?

### Basic commands

11. What does `git status` do?
12. What does `git add` do?
13. What does `git commit` do?
14. What does `git push` do?
15. What does `git pull` do?
16. What does `git fetch` do?
17. Pull vs fetch?
18. What does `git clone` do?
19. What does `git init` do?
20. What does `git remote -v` do?

### Branching

21. What is a branch?
22. Why do we use feature branches?
23. How do you create a branch?
24. How do you switch branches?
25. How do you delete a branch?
26. What is a tracking branch?
27. What is `origin`?

### Collaboration

28. What is a Pull Request?
29. Pull Request vs `git pull`?
30. What is code review?
31. What is a protected branch?
32. What is a merge?
33. What is a merge conflict?
34. How do you resolve a merge conflict?

### History

35. Merge vs rebase?
36. What is `HEAD`?
37. What is `HEAD~1`?
38. What is a commit hash?
39. What is `git log`?
40. What is `git diff`?
41. What is `git show`?

### Undoing changes

42. Restore vs reset vs revert?
43. What is `git reset --soft`?
44. What is `git reset --mixed`?
45. What is `git reset --hard`?
46. Why is `git revert` safer for shared branches?

### Advanced/common

47. What is Git stash?
48. What is cherry-pick?
49. What are Git tags?
50. What is a fork?
51. `origin` vs `upstream`?
52. What is a detached HEAD?
53. How does GitHub authentication work?
54. HTTPS vs SSH?
55. What is a PAT?
56. Why shouldn't secrets be committed?

### DevOps

57. How does Git fit into CI/CD?
58. What is GitHub Actions?
59. What is a GitHub Actions workflow?
60. What is a trigger?
61. What is a job?
62. What is a step?
63. How can a Git push trigger CI/CD?
64. How would Git help troubleshoot a production deployment?
65. How do Git tags help with releases?
66. How do Git, Docker, and Kubernetes work together?

---

# 92. Strong Interview Answer — My Git Workflow

If an interviewer asks:

> "Explain your Git workflow."

I can answer:

> "I normally start by updating my main branch and creating a feature branch for my work. I make the required changes, check them using `git status` and `git diff`, stage them using `git add`, and create a meaningful commit using `git commit`. Then I push the feature branch to GitHub and create a Pull Request. The PR goes through code review and CI/CD checks. Once the required checks and approvals are completed, the branch is merged into the main branch. The merge can then trigger the build and deployment pipeline."

---

# 93. Strong Interview Answer — Git + DevOps

If they ask:

> "How is Git used in DevOps?"

I can say:

> "Git acts as the source-control system and often becomes the starting point of the CI/CD process. Developers push code to GitHub, Pull Requests can trigger automated testing, and after merging, the pipeline can build an application or Docker image, push it to a registry, and deploy it to cloud infrastructure or Kubernetes. Git commits and tags also provide traceability for what version is running in an environment."

---

# 94. Strong Interview Answer — Production Issue

If asked:

> "How would Git help you troubleshoot a production issue?"

I can say:

> "I would first identify the deployed application or image version and trace it back to the corresponding Git commit or tag. Then I would inspect the commit and Pull Request to understand what changed. I would also check whether CI passed for that change. Based on the organization's rollback process, we could revert the problematic change or redeploy a known-good version."

---

# 95. Final Mental Model

This is what I want to remember:

```text
                         GITHUB
                    Remote Repository
                           ☁️
                           ↑
                         push
                           |
                    Pull Request
                           |
                    Code Review
                           |
                      CI / CD
                           |
                         Merge
                           |
                          main
                           |
                         Build
                           |
                     Docker Image
                           |
                        Deploy
                           |
                  Cloud / Kubernetes
```

And locally:

```text
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
GitHub
```

---

# 🏆 FINAL GIT & GITHUB CHEAT SHEET

```text
GIT
---
Version control system.

GITHUB
-------
Platform for hosting/collaborating on Git repositories.

REPOSITORY
----------
Project tracked by Git.

WORKING DIRECTORY
-----------------
Where I modify files.

STAGING AREA
------------
Changes prepared for the next commit.

COMMIT
------
Saved point in Git history.

REMOTE
------
Repository stored outside my local machine.

ORIGIN
------
Common name for the default remote.

PUSH
----
Local → Remote.

PULL
----
Remote → Local + integration.

FETCH
-----
Remote → Local information, without automatically integrating.

BRANCH
------
Separate line of development.

PULL REQUEST
------------
Request to review and merge branch changes.

MERGE
-----
Combines histories.

REBASE
------
Replays commits onto a new base.

CONFLICT
--------
Git cannot automatically combine changes.

RESTORE
-------
Restore/unstage file changes.

RESET
-----
Move HEAD/branch backward.

REVERT
------
Create a new commit that undoes an old commit.

STASH
-----
Temporarily store unfinished changes.

TAG
---
Mark an important point/version.

CHERRY-PICK
-----------
Apply a specific commit to the current branch.

FORK
----
My GitHub copy of another repository.

UPSTREAM
--------
Common name for the original repository when working with a fork.

.GITIGNORE
----------
Files Git should normally not track.

SSH
---
Key-based authentication.

PAT
---
Token-based authentication for GitHub operations.

PROTECTED BRANCH
----------------
Branch with rules preventing unsafe direct changes.

GITHUB ACTIONS
--------------
GitHub's automation/CI/CD platform.
```

---

# 🔥 THE MOST IMPORTANT DEVOPS FLOW

```text
Code Change
    ↓
git status
    ↓
git diff
    ↓
git add
    ↓
git diff --staged
    ↓
git commit
    ↓
git push
    ↓
GitHub
    ↓
Pull Request
    ↓
Code Review
    ↓
CI Tests
    ↓
Merge
    ↓
Build
    ↓
Docker Image
    ↓
Registry
    ↓
Cloud / Kubernetes
    ↓
Deployment
```

## My final takeaway

I don't need to memorize hundreds of Git commands.

I need to be **very strong with the workflow**:

```text
clone
  ↓
branch
  ↓
modify
  ↓
status
  ↓
diff
  ↓
add
  ↓
commit
  ↓
push
  ↓
Pull Request
  ↓
review
  ↓
CI/CD
  ↓
merge
  ↓
deploy
```

And when something goes wrong, I should know where to look:

```text
Status
  ↓
Diff
  ↓
Log
  ↓
Branch
  ↓
Remote
  ↓
Fetch/Pull
  ↓
Conflict
  ↓
Revert/Reset/Restore
  ↓
PR
  ↓
CI/CD
  ↓
Deployment
```

**If I understand this flow properly, I have the Git/GitHub foundation I need for DevOps and Cloud Engineer work.**

