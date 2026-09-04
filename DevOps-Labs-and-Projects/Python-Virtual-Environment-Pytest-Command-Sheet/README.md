# 🐍 Python Virtual Environment + Pytest — Complete Command Sheet

This guide explains how to fix the `externally-managed-environment` / PEP 668 error on Ubuntu by creating a Python virtual environment and installing `pytest` safely inside it.

---

## 1. Go to the GitHub Actions project

```bash
cd ~/github-actions-practice
```

**Explanation:** Moves into the `github-actions-practice` project directory.

---

## 2. Update Ubuntu packages

```bash
sudo apt update
```

**Explanation:** Updates Ubuntu's package information so the latest available packages can be installed.

---

## 3. Install Python virtual environment support

```bash
sudo apt install python3-venv -y
```

**Explanation:** Installs the package required to create Python virtual environments.

---

## 4. Create a Python virtual environment

```bash
python3 -m venv venv
```

**Explanation:** Creates an isolated Python environment named `venv` inside the project.

The project will now contain:

```text
github-actions-practice/
└── venv/
```

---

## 5. Activate the virtual environment

```bash
source venv/bin/activate
```

**Explanation:** Activates the virtual environment so Python packages are installed inside `venv` instead of the Ubuntu system Python.

Before activation:

```text
ubuntu@ip-172-31-69-255:~/github-actions-practice$
```

After activation:

```text
(venv) ubuntu@ip-172-31-69-255:~/github-actions-practice$
```

The `(venv)` confirms that the virtual environment is active.

---

## 6. Install pytest

```bash
pip install pytest
```

**Explanation:** Installs `pytest` inside the virtual environment.

This avoids the Ubuntu PEP 668 `externally-managed-environment` error.

---

## 7. Verify pytest installation

```bash
pytest --version
```

**Explanation:** Checks whether `pytest` was installed successfully.

Expected output:

```text
pytest 8.x.x
```

The exact version may be different.

---

## 8. Verify the Python executable

```bash
which python
```

**Explanation:** Confirms that the active Python comes from the virtual environment.

Expected output:

```text
/home/ubuntu/github-actions-practice/venv/bin/python
```

---

## 9. Verify the pip executable

```bash
which pip
```

**Explanation:** Confirms that `pip` is also coming from the virtual environment.

Expected output:

```text
/home/ubuntu/github-actions-practice/venv/bin/pip
```

---

## 10. Deactivate the virtual environment

```bash
deactivate
```

**Explanation:** Exits the virtual environment.

The `(venv)` will disappear from the terminal.

---

# 🚀 All Commands Together

For easy copy-paste:

```bash
cd ~/github-actions-practice

sudo apt update

sudo apt install python3-venv -y

python3 -m venv venv

source venv/bin/activate

pip install pytest

pytest --version

which python

which pip
```

When finished:

```bash
deactivate
```

---

# 🧠 Why Did `pip install pytest` Fail?

The original command was:

```bash
python3 -m pip install pytest
```

Ubuntu blocked it with:

```text
error: externally-managed-environment
```

This happens because newer Ubuntu/Python environments follow PEP 668, which protects the system Python installation from being modified directly with `pip`.

Instead of installing packages into the system Python:

```text
System Python
      |
      | pip install pytest
      |
      ❌ PEP 668 blocks it
```

we create an isolated virtual environment:

```text
Project
   |
   └── venv/
        |
        ├── Python
        ├── pip
        └── pytest
```

Then:

```text
Create venv
     ↓
Activate venv
     ↓
pip install pytest
     ↓
pytest works ✅
```

---

# ⚠️ Do Not Use `--break-system-packages`

Ubuntu may suggest:

```bash
python3 -m pip install pytest --break-system-packages
```

Do not use this for our practical.

The recommended approach is:

```bash
python3 -m venv venv
source venv/bin/activate
pip install pytest
```

This keeps the Ubuntu system Python clean and keeps project dependencies isolated.

---

# 📁 Project Structure

After creating the virtual environment, the project can look like:

```text
github-actions-practice/
│
├── venv/
│
├── .github/
│   └── workflows/
│       └── first-workflow.yml
│
├── app.py
│
├── test_app.py
│
└── ...
```

The `venv/` directory is the local Python virtual environment.

---

# 🚫 Do Not Commit `venv/` to GitHub

The virtual environment should normally not be pushed to GitHub.

Add this to `.gitignore`:

```text
venv/
```

This tells Git to ignore the local virtual environment.

---

# 🔄 Local Python vs GitHub Actions

The local virtual environment is useful when running the project and tests on the Ubuntu/EC2 machine.

GitHub Actions runs on its own GitHub-hosted runner.

The basic idea is:

```text
LOCAL MACHINE
     |
     ├── venv/
     └── pytest
     
     ↓

      Git Push
     
     ↓

GITHUB ACTIONS
     |
     ├── Fresh Runner
     ├── Setup Python
     ├── Install Dependencies
     └── Run pytest
```

We do not need to upload the local `venv/` directory to GitHub.

GitHub Actions creates a fresh environment and installs the required dependencies during the workflow.

---

# 🧩 Important Commands to Remember

Create the virtual environment:

```bash
python3 -m venv venv
```

Activate it:

```bash
source venv/bin/activate
```

Install pytest:

```bash
pip install pytest
```

Check pytest:

```bash
pytest --version
```

Check Python:

```bash
which python
```

Check pip:

```bash
which pip
```

Deactivate:

```bash
deactivate
```

---

# 📝 Simple Concept to Remember

```text
Ubuntu System Python
        |
        | pip install
        ↓
   PEP 668 ❌
        |
        ↓
Create Virtual Environment
        |
        ↓
      venv/
        |
        ↓
Activate venv
        |
        ↓
pip install pytest
        |
        ↓
     pytest ✅
```

---

# ✅ Final Command Flow

```text
1. cd ~/github-actions-practice
              ↓
2. sudo apt update
              ↓
3. sudo apt install python3-venv -y
              ↓
4. python3 -m venv venv
              ↓
5. source venv/bin/activate
              ↓
6. pip install pytest
              ↓
7. pytest --version
              ↓
8. which python
              ↓
9. which pip
              ↓
10. deactivate
```

**Main commands to remember:**

```bash
python3 -m venv venv
source venv/bin/activate
pip install pytest
pytest --version
deactivate
```

**Result:** `pytest` is installed safely inside the Python virtual environment without modifying Ubuntu's protected system Python.
