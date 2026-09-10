# 🐧 Linux File Permissions — Complete Practical

In this practical, I am going to understand Linux file permissions using different users, files, directories, `chmod`, and `chown`.

The main idea is:

> **Linux permissions decide who can read, write, and execute a file or access a directory.**

---

# 1. Create Two Users

First, I make sure I am logged in as root.

```bash
whoami
```

It should show:

```text
root
```

Now I create the `developer` user:

```bash
adduser developer
```

I set a password and press **Enter** for the other details.

Then I create the `qe` user:

```bash
adduser qe
```

Again, I set a password and press **Enter** for the other details.

---

# 2. Verify Both Users

To check the users:

```bash
cat /etc/passwd
```

I should find entries for:

```text
developer
qe
```

---

# 3. Open Two Terminals

I use two terminal tabs so that I can work as two different users.

```text
Terminal 1 → developer
Terminal 2 → qe
```

### Terminal 1

```bash
su - developer
```

### Terminal 2

```bash
su - qe
```

Now I have:

```text
Terminal 1 → developer
Terminal 2 → qe
```

This helps me practically understand how permissions work between different users.

---

# 4. Developer Creates a Shell Script

In the **developer terminal**, I go to `/tmp`:

```bash
cd /tmp
```

Now I create the script using `vi`:

```bash
vi HelloWorld.sh
```

I press:

```text
i
```

Then I enter:

```bash
#!/bin/bash
echo Hello World
```

To save and exit:

```text
Esc
:wq!
```

---

# 5. Verify the File

Still as `developer`:

```bash
ls -ltr
```

I should see:

```text
HelloWorld.sh
```

---

# 6. QE Tries to Read the File

Now I go to the **qe terminal**.

```bash
cd /tmp
```

Check the file:

```bash
ls -ltr
```

I should be able to see:

```text
HelloWorld.sh
```

Now I read it:

```bash
cat HelloWorld.sh
```

I should see:

```bash
#!/bin/bash
echo Hello World
```

So currently:

> `qe` can **read** the file.

---

# 7. QE Tries to Modify the File

Still as `qe`:

```bash
vi HelloWorld.sh
```

Press:

```text
i
```

Then add something like:

```text
Hello from QE
```

Save and exit:

```text
Esc
:wq!
```

I should get an error similar to:

```text
Can't open file for writing
```

This means:

> `qe` cannot **write/modify** the file.

---

# 8. Check That the File Was Not Changed

Run:

```bash
cat HelloWorld.sh
```

It should still contain:

```bash
#!/bin/bash
echo Hello World
```

So the changes made by `qe` were not saved.

---

# 9. QE Tries to Delete the File

Run:

```bash
rm HelloWorld.sh
```

I may be asked:

```text
Are you sure you want to remove this file?
```

Enter:

```text
y
```

I should get:

```text
Operation not permitted
```

So:

> `qe` cannot delete the file.

---

# 10. Understand the Permissions

Now I go back to the **developer terminal**.

```bash
cd /tmp
ls -ltr
```

I look at the permission string.

It may look similar to:

```text
-rw-rw-r--
```

The exact permissions can vary depending on the environment.

The important structure is:

```text
- | rw- | rw- | r--
  |     |     |
  |     |     └── Others
  |     └──────── Group
  └────────────── User
```

There are **9 permission characters**, divided into 3 sets:

```text
rw- | rw- | r--
 ↓     ↓     ↓
User  Group Others
```

Each set contains:

```text
r w x
```

Meaning:

```text
r = read
w = write
x = execute
```

---

# 11. Understand User, Group and Others

### User

The user who owns or created the file.

In this example:

```text
developer
```

### Group

The group associated with the file.

### Others

Other users who are not the owner or part of the group.

In this example:

```text
developer       → User
developer's group → Group
qe              → Other
```

---

# 12. Practice `chmod` With Letters

Now I practice changing permissions using letters.

I remember:

```text
u = user
g = group
o = others
```

First, I go to root:

```bash
su -
```

Then:

```bash
cd /tmp
```

---

## Give Execute Permission to the User

Run:

```bash
chmod u=rwx HelloWorld.sh
```

Now switch to developer:

```bash
su - developer
```

Go to `/tmp`:

```bash
cd /tmp
```

Execute the script:

```bash
./HelloWorld.sh
```

I should get:

```text
Hello World
```

So now the user has execute permission.

---

# 13. Remove Execute Permission

Go back to root:

```bash
su -
```

Then:

```bash
cd /tmp
```

Run:

```bash
chmod u=rw HelloWorld.sh
```

Now go back to developer:

```bash
su - developer
```

Then:

```bash
cd /tmp
./HelloWorld.sh
```

I should get:

```text
Permission denied
```

Why?

Because:

```text
u = rw-
```

The user does not have `x` permission.

So the file cannot be executed.

---

# 14. Give Permissions to Others

Now I go back to root:

```bash
su -
```

Go to `/tmp`:

```bash
cd /tmp
```

Run:

```bash
chmod o=rwx HelloWorld.sh
```

Now switch to `qe`:

```bash
su - qe
```

Go to `/tmp`:

```bash
cd /tmp
```

Execute:

```bash
./HelloWorld.sh
```

Now `qe` should be able to execute the script.

---

# 15. QE Modifies the File

Still as `qe`:

```bash
vi HelloWorld.sh
```

Press:

```text
i
```

Change:

```bash
echo Hello World
```

to:

```bash
echo Hello World from QE
```

Save:

```text
Esc
:wq!
```

Now execute:

```bash
./HelloWorld.sh
```

Output:

```text
Hello World from QE
```

This proves that because `others` has `rwx`, `qe` can:

* Read
* Write
* Execute

the file.

---

# 16. Numeric `chmod`

Now I use numbers for permissions.

I remember:

```text
r = 4
w = 2
x = 1
```

Therefore:

```text
r-- = 4
-w- = 2
--x = 1

rw- = 4 + 2 = 6
r-x = 4 + 1 = 5
-wx = 2 + 1 = 3
rwx = 4 + 2 + 1 = 7
```

So every permission set can be represented using a number from `0` to `7`.

---

# 17. Practice `chmod 444`

Go to root:

```bash
su -
```

Then:

```bash
cd /tmp
```

Run:

```bash
chmod 444 HelloWorld.sh
```

This means:

```text
444

User    → r--
Group   → r--
Others  → r--
```

So everyone can:

```text
Read
```

But nobody can:

```text
Write
Execute
```

---

# 18. Practice `chmod 666`

Run:

```bash
chmod 666 HelloWorld.sh
```

This means:

```text
666

User    → rw-
Group   → rw-
Others  → rw-
```

Everyone can:

```text
Read
Write
```

Nobody can:

```text
Execute
```

---

# 19. Practice `chmod 777`

Run:

```bash
chmod 777 HelloWorld.sh
```

This means:

```text
777

User    → rwx
Group   → rwx
Others  → rwx
```

Everyone has:

```text
Read
Write
Execute
```

So this is a completely open file.

---

# 20. Practice `chmod 400`

Run:

```bash
chmod 400 HelloWorld.sh
```

This means:

```text
400

User    → r--
Group   → ---
Others  → ---
```

Only the user can read the file.

---

# 21. Practice `chmod 764`

I can also understand permissions using:

```bash
chmod 764 HelloWorld.sh
```

Break it down:

```text
7 → rwx
6 → rw-
4 → r--
```

Therefore:

```text
User    → rwx
Group   → rw-
Others  → r--
```

---

# 22. Practice Directory Permissions

Now I practice the same concept with directories.

First, go to the `developer` user:

```bash
su - developer
```

Check `/home`:

```bash
cd /home
ls -ltr
```

I should see the `developer` directory.

Now try:

```bash
cd developer
```

Now switch to `qe`:

```bash
su - qe
```

Try:

```bash
cd /home/developer
```

I should get:

```text
Permission denied
```

This happens because the directory does not give `qe` the required access.

---

# 23. Change Directory Permissions

Go to root:

```bash
su -
```

Run:

```bash
chmod 757 /home/developer
```

The important point is that the **Others** permission has now been changed.

Switch to `qe`:

```bash
su - qe
```

Try:

```bash
cd /home/developer
```

Now `qe` can access the directory according to the permissions assigned.

Create a file:

```bash
touch test
```

Then go back to developer:

```bash
su - developer
```

Run:

```bash
cd /home/developer
ls -ltr
```

I should see:

```text
test
```

This shows that directory permissions affect whether another user can access and work inside that directory.

---

# 24. Practice `chown`

Now I practice ownership.

Switch to developer:

```bash
su - developer
```

Go to `/tmp`:

```bash
cd /tmp
```

Create a file:

```bash
touch test.sh
```

Check it:

```bash
ls -ltr
```

I should see ownership similar to:

```text
developer developer test.sh
```

Meaning:

```text
Owner → developer
Group → developer
```

---

# 25. Change Ownership Using `chown`

Go to root:

```bash
su -
```

Go to `/tmp`:

```bash
cd /tmp
```

Run:

```bash
chown qe:qe test.sh
```

Now check:

```bash
ls -ltr
```

Previously:

```text
developer developer
```

Now:

```text
qe qe
```

So:

> `chown` changes the **owner and group** of a file.

---

# 26. Final and Most Important Practical — Directory vs File

This is the most important concept.

My teacher explained this using the **bank and locker example**.

Think about:

```text
Bank
 │
 └── Locker
```

The bank represents:

```text
Directory
```

The locker represents:

```text
File
```

I can have permission to the locker, but if I cannot enter the bank, I cannot reach the locker.

Linux works the same way.

For example:

```text
/tmp
 │
 └── demo
```

I need access to:

```text
/tmp
```

before I can access:

```text
/tmp/demo
```

So:

> **First I need permission to access the directory, then I need permission to access the file.**

---

# 27. Demonstrate the Directory vs File Concept

As root:

```bash
su -
```

Change `/tmp` permissions:

```bash
chmod 700 /tmp
```

Now go to `/tmp`:

```bash
cd /tmp
```

Create a file:

```bash
touch demo
```

Give the file completely open permissions:

```bash
chmod 777 demo
```

Check:

```bash
ls -ltr
```

The file has:

```text
777
```

But `/tmp` has:

```text
700
```

---

# 28. Try as QE

Switch to `qe`:

```bash
su - qe
```

Try:

```bash
cd /tmp
```

I should get:

```text
Permission denied
```

Now try directly:

```bash
cd /tmp/demo
```

I still cannot access it.

Even though:

```text
demo → 777
```

because:

```text
/tmp → no access for qe
```

This is the important concept:

```text
          /tmp
            │
            │
     Directory permission
            │
            ▼
          demo
            │
            │
        File permission
```

### 🏦 Bank and Locker

I remember it like this:

> **First I need permission to access the directory, then I need permission to access the file.**

---

# 🎯 Final Cheat Sheet

## Linux File Permissions

```text
Linux File Permissions
        │
        ├── User
        ├── Group
        └── Others
              │
              ├── r = Read = 4
              ├── w = Write = 2
              └── x = Execute = 1
```

### Check permissions

```bash
ls -ltr
```

### Change permissions

```bash
chmod
```

### Change ownership

```bash
chown
```

---

## Common Numeric Permissions

```text
400 → User read only

444 → Everyone read

600 → User read/write

644 → User read/write, others read

666 → Everyone read/write

700 → User full access

755 → User full, others read/execute

777 → Everyone full access
```

---

## Permission Structure

```text
-rwxr-xr--

   │  │  │
   │  │  └── Others
   │  └───── Group
   └──────── User
```

---

# 🧠 Commands From This Practical

```bash
ls -ltr

chmod u=rwx HelloWorld.sh

chmod o=rwx HelloWorld.sh

chmod 777 HelloWorld.sh

chmod 666 HelloWorld.sh

chmod 444 HelloWorld.sh

chmod 400 HelloWorld.sh

chown qe:qe test.sh
```

The main things I need to understand from this practical are:

```text
chmod
  ↓
Changes permissions

chown
  ↓
Changes ownership

User / Group / Others
  ↓
Who gets the permissions?

r / w / x
  ↓
What can they do?

Directory permissions
  ↓
Can I reach the file?
```
