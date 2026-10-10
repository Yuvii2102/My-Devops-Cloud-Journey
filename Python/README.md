# 🐍 How to Run Python Code Using Command Prompt.. (CMD)

This guide explains how to install Python on Windows and run your first Python program using Command Prompt (CMD), without using VS Code.

---

## 🐍 STEP 1: Install Python

### 1. Open Your Browser

Open Google Chrome on your PC.

### 2. Visit the Official Python Website

Download Python from the official website:

🔗 [Download Python for Windows](https://www.python.org/downloads/windows/)

### 3. Download Python

- Click the download button for the latest Python version.
- Wait for the download to finish.

### 4. Install Python

1. Open the downloaded Python installer.
2. **IMPORTANT:** Tick the checkbox that says **Add Python to PATH**.
3. Click **Install Now**.
4. Wait until the installation finishes.
5. Click **Close**.

✅ Python is now installed on your PC!

---

## 💻 STEP 2: Open Command Prompt (CMD)

Follow these steps to open the terminal.

1. Press **Windows + R** on your keyboard.
2. A small window called **Run** will appear.
3. Type the following command:

```cmd
cmd
```

4. Press **Enter**.

A black window will appear. This is your **Command Prompt (CMD)**!

It may look something like this:

```text
C:\Users\YourName>
```

This is where you will enter commands.

---

## 🐍 STEP 3: Check Python Installation

Inside the CMD window, type:

```cmd
python --version
```

Press **Enter**.

If Python is installed correctly, you will see output similar to this:

```text
Python 3.14.0
```

Your Python version may be different.

### ⚠️ If the Command Doesn't Work

Try the following command:

```cmd
py --version
```

If neither command works, check whether Python was installed correctly and whether it was added to PATH.

---

## 📂 STEP 4: Create a Folder for Python

We will create a folder to store our Python programs.

### 1. Create the Folder

In the same CMD window, type:

```cmd
mkdir Python-Practice
```

Press **Enter**.

This creates a folder named `Python-Practice`.

### 2. Enter the Folder

Now type:

```cmd
cd Python-Practice
```

Press **Enter**.

Your terminal should now look something like this:

```text
C:\Users\YourName\Python-Practice>
```

✅ Great! You have successfully created a folder and entered it.

---

## 📝 STEP 5: Create Your First Python File

Now, let's create a Python file using Notepad.

### 1. Open Notepad

In the same CMD window, type:

```cmd
notepad hello.py
```

Press **Enter**.

Notepad will open in a separate window.

**Don't worry!** You haven't left the terminal permanently. You have simply opened a text editor to write your Python code.

### 2. Write Your Python Code

Inside Notepad, type the following code:

```python
print("Hello, World!")
print("I am learning Python!")
```

### 3. Save the File

1. Click **File → Save** in Notepad.
2. Make sure the filename is `hello.py`.
3. Close Notepad by clicking the **X** button.

🎉 Now you are back at your CMD window!

Your Python code is saved in a file called `hello.py`.

---

## 🚀 STEP 6: Run Your Python Code

Now, let's execute the Python program you created.

### 1. Check Your Current Directory

Look at your CMD window.

It should show something similar to this:

```text
C:\Users\YourName\Python-Practice>
```

If you are not inside the `Python-Practice` folder, enter it using:

```cmd
cd Python-Practice
```

### 2. Execute the Python File

Type the following command:

```cmd
python hello.py
```

Press **Enter**.

### 3. Check the Output

If everything works correctly, you will see:

```text
Hello, World!
I am learning Python!
```

🎉 **Congratulations!** You have successfully executed your first Python program using CMD.

### ⚠️ If the `python` Command Doesn't Work

If `py --version` works but `python --version` doesn't, try running your program using:

```cmd
py hello.py
```

---

