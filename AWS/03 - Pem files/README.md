# 🔐 SSH — Understanding PEM File Paths

## 🎯 What I Learned

While connecting to an AWS EC2 instance using SSH, I learned that the difference between:

```bash
ssh -i demo21.pem ubuntu@PUBLIC_IP
```

and:

```bash
ssh -i /root/demo21.pem ubuntu@PUBLIC_IP
```

is simply **where my `.pem` file is located**.

---

# 1️⃣ PEM File in My Current Folder

If my `.pem` file is inside the directory I am currently working in, I can use only the filename.

For example, if I run:

```bash
ls
```

and I see:

```text
demo21.pem
```

I can connect using:

```bash
ssh -i demo21.pem ubuntu@13.220.212.212
```

Here:

```text
demo21.pem
```

is called a **relative path**.

### 🧠 Why?

Because I am telling SSH:

> "The PEM file is in the folder I am currently in."

---

# 2️⃣ PEM File Somewhere Else

If my PEM file is located somewhere else, I need to provide its full path.

For example:

```text
/root/demo21.pem
```

I can connect using:

```bash
ssh -i /root/demo21.pem ubuntu@13.220.212.212
```

Here:

```text
/root/demo21.pem
```

is called an **absolute path** or **full path**.

I can check whether the file exists using:

```bash
ls -l /root/demo21.pem
```

---

# 🧠 Relative Path vs Absolute Path

| Path                      | Meaning                            |
| ------------------------- | ---------------------------------- |
| `demo21.pem`              | PEM is in my current directory     |
| `/root/demo21.pem`        | PEM is specifically inside `/root` |
| `/home/ubuntu/demo21.pem` | PEM is inside `/home/ubuntu`       |

### Easy memory trick

**No `/` at the beginning:**

```bash
demo21.pem
```

➡️ Relative path

**Starts with `/`:**

```bash
/root/demo21.pem
```

➡️ Absolute path

---

# 3️⃣ Both Commands Do the Same Thing

These two commands can connect to the same EC2 instance:

```bash
ssh -i demo21.pem ubuntu@PUBLIC_IP
```

and:

```bash
ssh -i /root/demo21.pem ubuntu@PUBLIC_IP
```

The difference is only **how I tell SSH where the PEM file is**.

---

# 4️⃣ Why Does `/root` Come Into the Picture?

In my Ubuntu Docker container, I copied my PEM file into:

```text
/root/demo21.pem
```

So from any directory inside the container, I can use:

```bash
ssh -i /root/demo21.pem ubuntu@PUBLIC_IP
```

Because `/root/demo21.pem` gives the complete location of the file.

---

# 5️⃣ I Can Also Move to `/root`

Instead of giving the full path every time, I can first move into `/root`:

```bash
cd /root
```

Then check:

```bash
ls
```

I should see:

```text
demo21.pem
```

Now I can simply use:

```bash
ssh -i demo21.pem ubuntu@PUBLIC_IP
```

Both approaches work.

---

# 🔥 My Docker → EC2 Example

My setup looks like this:

```text
Windows
   │
   ▼
Docker Desktop
   │
   ▼
Ubuntu Container
   │
   │  /root/demo21.pem
   ▼
SSH
   │
   ▼
AWS EC2
   │
   ▼
ubuntu user
```

From inside my Ubuntu container:

```bash
ssh -i /root/demo21.pem ubuntu@PUBLIC_IP
```

Or:

```bash
cd /root
ssh -i demo21.pem ubuntu@PUBLIC_IP
```

---

# 🔑 Understanding the SSH Command

Example:

```bash
ssh -i /root/demo21.pem ubuntu@13.220.212.212
```

I can break it down like this:

```text
ssh
│
├── -i /root/demo21.pem
│      └── Private key I want SSH to use
│
└── ubuntu@13.220.212.212
       │       │
       │       └── EC2 public IP
       │
       └── Username
```

So:

* `ssh` → starts an SSH connection
* `-i` → tells SSH which private key to use
* `/root/demo21.pem` → location of my PEM file
* `ubuntu` → username on the EC2 instance
* `13.220.212.212` → EC2 public IP address

---

# 🧪 Practical

### Step 1 — Check my current directory

```bash
pwd
```

### Step 2 — Check files in the current directory

```bash
ls
```

If I see:

```text
demo21.pem
```

I can use:

```bash
ssh -i demo21.pem ubuntu@PUBLIC_IP
```

---

### Step 3 — If the PEM isn't in my current directory

I can check the known location:

```bash
ls -l /root/demo21.pem
```

If the file exists, I can use:

```bash
ssh -i /root/demo21.pem ubuntu@PUBLIC_IP
```

---

# 🧠 Master Memory

I should remember:

```text
PEM in current directory
        ↓
ssh -i demo21.pem ubuntu@PUBLIC_IP
```

```text
PEM somewhere else
        ↓
ssh -i /full/path/to/demo21.pem ubuntu@PUBLIC_IP
```

### ⭐ Most important point

**`demo21.pem` = relative path**

**`/root/demo21.pem` = absolute path**

The SSH connection itself is the same. Only the **PEM file path** is different.

# ✅ What I Learned

* I learned what a relative path is.
* I learned what an absolute path is.
* I learned when to use `demo21.pem`.
* I learned when to use `/root/demo21.pem`.
* I learned how to check the PEM location using `ls`.
* I learned that I can use the full path from any directory.
* I learned that I can use only the filename when the PEM is in my current directory.
* I understood why `/root/demo21.pem` was used in my Ubuntu Docker container.
* I understood the complete SSH command:

```bash
ssh -i /root/demo21.pem ubuntu@PUBLIC_IP
```

# 🚀 Final Memory Line

> **If the PEM is here → use its name.
> If the PEM is somewhere else → use its full path.**
