# EC2 SSH Login Guide

## 1. What I Need Before Connecting

I need these 3 things:

- EC2 Public IPv4 address
- `.pem` private key
- EC2 username

For my Ubuntu EC2:

- Username: `ubuntu`
- Key: `Practice.pem`
- Key location:

`C:\Users\Yuvraj\Downloads\Practice.pem`

> **Important:** Never share the `.pem` file or upload it to GitHub. It is my private SSH key.

---

## 2. Open Windows Command Prompt

Press:

`Windows + R`

Type:

`cmd`

Press **Enter**.

I should see:

```text
C:\Users\Yuvraj>
```

---

## 3. Get the EC2 Public IP

Go to:

**AWS Console → EC2 → Instances → Select my EC2 instance**

Find:

**Public IPv4 address**

Example:

```text
54.225.27.97
```

> **Important:** The public IP can change if the EC2 instance is stopped and started, unless an Elastic IP is being used. Always check the current Public IPv4 address before connecting.

---

## 4. SSH Into EC2

From **Windows CMD**, run:

```cmd
ssh -i "C:\Users\Yuvraj\Downloads\Practice.pem" ubuntu@YOUR_EC2_PUBLIC_IP
```

Example:

```cmd
ssh -i "C:\Users\Yuvraj\Downloads\Practice.pem" ubuntu@54.225.27.97
```

### SSH Command Structure

```text
ssh -i "PATH_TO_PEM_FILE" USERNAME@EC2_PUBLIC_IP
```

For my EC2:

```text
ssh
 ↓
-i
 ↓
Practice.pem
 ↓
ubuntu
 ↓
@
 ↓
EC2 Public IP
```

---

## 5. First-Time Connection

The first time I connect, SSH may ask:

```text
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

Type:

```text
yes
```

Press **Enter**.

---

## 6. Successful Login

If the connection is successful, I will see something similar to:

```text
Welcome to Ubuntu ...
```

and finally:

```text
ubuntu@ip-172-31-21-198:~$
```

This means:

```text
Windows CMD
     ↓
    SSH
     ↓
AWS EC2
     ↓
Ubuntu Linux
```

I am now inside my EC2 Linux server.

I can now execute Linux commands such as:

```bash
pwd
ls
whoami
```

---

## 7. IMPORTANT — Where Should I Run the SSH Command?

The SSH command must be run from **my Windows computer** because the `.pem` file is stored on my Windows computer.

### Correct

```text
Windows CMD
C:\Users\Yuvraj>
        |
        | SSH + Practice.pem
        ↓
EC2 Ubuntu
ubuntu@ip-172-31-21-198:~$
```

### Wrong

```text
EC2 Ubuntu
ubuntu@ip-172-31-21-198:~$
        |
        └── ssh -i "C:\Users\Yuvraj\Downloads\Practice.pem" ... ❌
```

Why?

Because:

```text
C:\Users\Yuvraj\Downloads\Practice.pem
```

is a **Windows path**.

The `Practice.pem` file is on my Windows computer, not inside EC2.

---

## 8. If I Get "Permission Denied (publickey)"

If I see:

```text
Permission denied (publickey).
```

Check the following.

### Check 1 — Username

For Ubuntu EC2, the username is normally:

```text
ubuntu
```

The command should be:

```cmd
ssh -i "C:\Users\Yuvraj\Downloads\Practice.pem" ubuntu@YOUR_EC2_PUBLIC_IP
```

### Check 2 — PEM File

Make sure this file exists:

```text
C:\Users\Yuvraj\Downloads\Practice.pem
```

### Check 3 — EC2 Public IP

Go to:

**AWS Console → EC2 → Instances → Select instance → Public IPv4 address**

Use the **current** IP address.

### Check 4 — Security Group

The EC2 Security Group should allow SSH:

```text
Type: SSH
Protocol: TCP
Port: 22
Source: My IP
```

---

## 9. If I Get "UNPROTECTED PRIVATE KEY FILE"

If SSH shows:

```text
WARNING: UNPROTECTED PRIVATE KEY FILE!
```

or:

```text
Permissions for 'Practice.pem' are too open.
```

SSH is refusing to use the private key because other Windows users have access to the `.pem` file.

### Fix It Manually

Go to:

**Downloads → Practice.pem → Right-click → Properties → Security → Advanced**

Then make sure unnecessary users/groups do not have access to the private key.

Make sure my Windows account has access.

Then click:

**Apply → OK → OK**

Try SSH again:

```cmd
ssh -i "C:\Users\Yuvraj\Downloads\Practice.pem" ubuntu@YOUR_EC2_PUBLIC_IP
```

---

## 10. How to Exit EC2

When I finish working on EC2, run:

```bash
exit
```

I should return to Windows:

```text
C:\Users\Yuvraj>
```

This means I have disconnected from EC2.

---

## 11. Complete EC2 SSH Flow

```text
1. Open Windows CMD
        ↓
2. Go to AWS EC2
        ↓
3. Find current Public IPv4 address
        ↓
4. Make sure Practice.pem is available
        ↓
5. Run:

ssh -i "C:\Users\Yuvraj\Downloads\Practice.pem" ubuntu@YOUR_EC2_PUBLIC_IP

        ↓
6. If asked:

Are you sure you want to continue connecting?

Type:

yes

        ↓
7. Successful login:

ubuntu@ip-xxx-xxx-xxx-xxx:~$

        ↓
8. Execute Linux commands
        ↓
9. When finished:

exit

        ↓
10. Back to Windows CMD
```

---

## 12. The One Command I Need to Remember

```cmd
ssh -i "C:\Users\Yuvraj\Downloads\Practice.pem" ubuntu@YOUR_EC2_PUBLIC_IP
```

Replace only:

```text
YOUR_EC2_PUBLIC_IP
```

with the **current Public IPv4 address of my EC2 instance**.

Example:

```cmd
ssh -i "C:\Users\Yuvraj\Downloads\Practice.pem" ubuntu@54.225.27.97
```

If successful:

```text
ubuntu@ip-172-31-21-198:~$
```

**I am now inside my EC2 Ubuntu Linux server and can execute Linux commands.**
