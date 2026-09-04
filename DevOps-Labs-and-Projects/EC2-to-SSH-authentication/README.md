# GitHub Authentication from EC2 using SSH

## Objective

Configure an Ubuntu EC2 instance to authenticate with GitHub using SSH and successfully push the local Git repository to GitHub.

Repository:

`Yuvii2102/github-actions-practice`

Local directory:

`~/github-actions-practice`

---

## Step 1: Check the Current Git Branch

First, we checked the current branch:

```bash
git branch
```

Output:

```text
* main
```

This confirmed that the current branch is:

```text
main
```

---

## Step 2: Check the GitHub Remote

We checked the configured Git remote:

```bash
git remote -v
```

Output:

```text
origin  https://github.com/Yuvii2102/github-actions-practice.git (fetch)
origin  https://github.com/Yuvii2102/github-actions-practice.git (push)
```

The repository was initially using HTTPS authentication.

---

## Step 3: First Push Attempt

We attempted to push the `main` branch:

```bash
git push origin main
```

Git asked for:

```text
Username for 'https://github.com':
```

We entered:

```text
Yuvii2102
```

Git then asked:

```text
Password for 'https://Yuvii2102@github.com':
```

The push failed with:

```text
remote: Permission to Yuvii2102/github-actions-practice.git denied to Yuvii2102.

fatal: unable to access 'https://github.com/Yuvii2102/github-actions-practice.git/': The requested URL returned error: 403
```

The error was:

```text
403 Permission Denied
```

---

## Step 4: Try Personal Access Token

GitHub HTTPS Git operations do not use the normal GitHub account password.

A Personal Access Token (PAT) can be used instead of the password.

We created a GitHub Personal Access Token and tried again:

```bash
git push origin main
```

Username:

```text
Yuvii2102
```

Password:

```text
<Personal Access Token>
```

However, the push still returned:

```text
403 Permission Denied
```

So we continued troubleshooting.

---

## Step 5: Switch from HTTPS to SSH

Instead of continuing to troubleshoot HTTPS/PAT authentication, we switched the repository to SSH authentication.

SSH allows the EC2 instance to authenticate with GitHub using an SSH key.

The authentication flow is:

```text
EC2
 |
 | SSH Private Key
 v
GitHub
 |
 | Verify Public Key
 v
GitHub Account
 |
 v
Repository
```

---

## Step 6: Generate an SSH Key

On the EC2 instance, we ran:

```bash
ssh-keygen -t ed25519 -C "yuvrajmysuru@gmail.com"
```

Git asked:

```text
Enter file in which to save the key (/home/ubuntu/.ssh/id_ed25519):
```

We accepted the default location by pressing:

```text
Enter
```

Git then asked:

```text
Enter passphrase (empty for no passphrase):
```

For this practical, we left the passphrase empty and pressed:

```text
Enter
```

Then we pressed `Enter` again to confirm.

The SSH key was successfully created.

The generated files were:

```text
/home/ubuntu/.ssh/id_ed25519
/home/ubuntu/.ssh/id_ed25519.pub
```

---

## Step 7: Understand the SSH Key Files

Two SSH key files were created.

### Private Key

```text
~/.ssh/id_ed25519
```

This is the private key.

It must NEVER be shared with anyone.

### Public Key

```text
~/.ssh/id_ed25519.pub
```

This is the public key.

The public key can be added to GitHub.

The authentication concept is:

```text
EC2
 |
 | Private Key
 |
 v
GitHub
 |
 | Compare with registered Public Key
 |
 v
Authentication Successful
```

---

## Step 8: Display the Public Key

We displayed the public key using:

```bash
cat ~/.ssh/id_ed25519.pub
```

The output looked similar to:

```text
ssh-ed25519 AAAA... yuvrajmysuru@gmail.com
```

We copied the entire public-key line.

Important:

```text
~/.ssh/id_ed25519.pub
```

is the public key and can be added to GitHub.

But:

```text
~/.ssh/id_ed25519
```

is the private key and must remain secret.

---

## Step 9: Add the Public Key to GitHub

In GitHub, we opened:

```text
Settings
→ SSH and GPG keys
→ New SSH key
```

We provided a title such as:

```text
EC2 GitHub Actions Practice
```

We copied the public key using:

```bash
cat ~/.ssh/id_ed25519.pub
```

Then we pasted the complete public key into GitHub and added the SSH key.

---

## Step 10: Change the Git Remote from HTTPS to SSH

The original remote was:

```text
https://github.com/Yuvii2102/github-actions-practice.git
```

We changed it to SSH using:

```bash
git remote set-url origin git@github.com:Yuvii2102/github-actions-practice.git
```

Then we verified the remote:

```bash
git remote -v
```

The output became:

```text
origin  git@github.com:Yuvii2102/github-actions-practice.git (fetch)
origin  git@github.com:Yuvii2102/github-actions-practice.git (push)
```

Now the repository was configured to use SSH instead of HTTPS.

---

## Step 11: Test SSH Authentication

We tested the SSH connection to GitHub:

```bash
ssh -T git@github.com
```

The first time, GitHub may ask:

```text
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

We entered:

```text
yes
```

GitHub then returned:

```text
Hi Yuvii2102! You've successfully authenticated, but GitHub does not provide shell access.
```

This means SSH authentication was successful.

The message:

```text
GitHub does not provide shell access.
```

does NOT mean authentication failed.

It means:

```text
SSH Authentication = SUCCESS
GitHub Shell Access = NOT PROVIDED
```

GitHub successfully accepted the SSH key and identified the account as:

```text
Yuvii2102
```

---

## Step 12: Push the Main Branch

After successful SSH authentication, we ran:

```bash
git push origin main
```

The push completed successfully.

The important output was:

```text
To github.com:Yuvii2102/github-actions-practice.git
   ... main -> main
```

This confirmed:

```text
EC2 → GitHub = SUCCESS
```

The local `main` branch was successfully pushed to the GitHub repository.

---

## Step 13: Final Working Configuration

The final Git remote is:

```text
git@github.com:Yuvii2102/github-actions-practice.git
```

The final authentication flow is:

```text
                    EC2
                     |
                     |
              SSH Private Key
                     |
                     v
                  GitHub
                     |
              Verify Public Key
                     |
                     v
              Yuvii2102 Account
                     |
                     v
        github-actions-practice
                     |
                     v
                   main
```

---

## Step 14: HTTPS vs SSH

### Initial HTTPS Setup

Initially, the setup was:

```text
EC2
 |
 | HTTPS
 | Username + Password/PAT
 v
GitHub
```

This resulted in:

```text
403 Permission Denied
```

### Final SSH Setup

After the fix:

```text
EC2
 |
 | SSH Key
 v
GitHub
 |
 | Authentication Successful
 v
Repository
```

This worked successfully.

---

## Step 15: Important Commands Used

### Check Current Branch

```bash
git branch
```

### Check Git Remote

```bash
git remote -v
```

### Check Global Credential Helper

```bash
git config --global --get credential.helper
```

### Check Local Credential Helper

```bash
git config --local --get credential.helper
```

### Check Git Configuration

```bash
git config --list --show-origin | grep -Ei 'credential|remote.origin'
```

### Generate SSH Key

```bash
ssh-keygen -t ed25519 -C "yuvrajmysuru@gmail.com"
```

### Display Public SSH Key

```bash
cat ~/.ssh/id_ed25519.pub
```

### Change Remote from HTTPS to SSH

```bash
git remote set-url origin git@github.com:Yuvii2102/github-actions-practice.git
```

### Test GitHub SSH Authentication

```bash
ssh -T git@github.com
```

### Push Code to Main

```bash
git push origin main
```

---

## Step 16: What We Learned

The original problem was that the EC2 instance was trying to push to GitHub using HTTPS:

```text
https://github.com/Yuvii2102/github-actions-practice.git
```

The push returned:

```text
403 Permission Denied
```

We checked the Git configuration and confirmed that no credential helper was configured.

Instead of continuing with HTTPS authentication, we configured SSH authentication.

The steps were:

1. Generate an ED25519 SSH key.
2. Copy the public SSH key.
3. Add the public key to GitHub.
4. Change the Git remote from HTTPS to SSH.
5. Test SSH authentication.
6. Push the `main` branch.
7. Verify that the push succeeded.

---

## Step 17: Final Result

```text
✅ EC2 Git repository connected to GitHub

✅ GitHub account authenticated through SSH

✅ SSH public key added to GitHub

✅ HTTPS remote changed to SSH

✅ SSH authentication tested successfully

✅ main branch pushed successfully

✅ EC2 → GitHub connection is working
```

The final successful command was:

```bash
git push origin main
```

The successful result was:

```text
To github.com:Yuvii2102/github-actions-practice.git
   ... main -> main
```

---

## Step 18: Current Status

Current directory:

```text
~/github-actions-practice
```

Current branch:

```text
main
```

Current Git remote:

```text
git@github.com:Yuvii2102/github-actions-practice.git
```

Authentication method:

```text
SSH
```

GitHub account:

```text
Yuvii2102
```

Repository:

```text
github-actions-practice
```

Everything is now working correctly.

---

## Step 19: Next Step

The GitHub authentication setup is complete.

The next step in the GitHub Actions practical is to create the workflow:

```text
.github/workflows/hello.yml
```

The overall flow will be:

```text
EC2
  ↓
Git Push
  ↓
GitHub Repository
  ↓
GitHub Actions
  ↓
Workflow
  ↓
Job
  ↓
Runner
  ↓
Steps
```

---

# Conclusion

We successfully solved the GitHub `403 Permission Denied` authentication problem on the EC2 instance.

The repository now uses SSH authentication, and the EC2 instance can successfully push code to GitHub without entering a GitHub username, password, or Personal Access Token.

Final working command:

```bash
git push origin main
```

Final working remote:

```text
git@github.com:Yuvii2102/github-actions-practice.git
```

Final status:

```text
EC2 → SSH → GitHub → main branch = SUCCESS
```
