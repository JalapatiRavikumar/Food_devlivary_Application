# GitHub Setup Instructions

## Prerequisites

1. **Install Git** (if not already installed):
   - Download from: https://git-scm.com/download/win
   - Install and restart your terminal

2. **Create GitHub Repository** (if not already created):
   - Go to: https://github.com/JalapatiRavikumar/Food_devlivary_Application
   - If it doesn't exist, create a new repository with this name

3. **GitHub Authentication**:
   - GitHub no longer accepts passwords for HTTPS
   - You need a **Personal Access Token (PAT)**
   - Create one at: https://github.com/settings/tokens
   - Select scopes: `repo` (full control of private repositories)

## Method 1: Using PowerShell Script (Recommended for Windows)

1. Open PowerShell in the project directory
2. Run:
   ```powershell
   .\push-to-github.ps1
   ```
3. When prompted for credentials:
   - Username: Your GitHub username
   - Password: Use your Personal Access Token (not your GitHub password)

## Method 2: Manual Commands

Run these commands one by one in your terminal:

```bash
# Navigate to project directory
cd "C:\Users\rravi\Downloads\mern-food-delivery-app-main\mern-food-delivery-app-main"

# Initialize Git (if not already done)
git init

# Add all files
git add .

# Create initial commit
git commit -m "first commit"

# Set branch to main
git branch -M main

# Add remote (remove if already exists)
git remote remove origin 2>$null
git remote add origin https://github.com/JalapatiRavikumar/Food_devlivary_Application.git

# Push to GitHub
git push -u origin main
```

## Troubleshooting

### Error: "remote origin already exists"
```bash
git remote remove origin
git remote add origin https://github.com/JalapatiRavikumar/Food_devlivary_Application.git
```

### Error: "Repository not found"
- Make sure the repository exists on GitHub
- Check the repository name is correct: `Food_devlivary_Application`
- Verify you have access to the repository

### Error: "Authentication failed"
- Use Personal Access Token instead of password
- Make sure the token has `repo` scope
- Try using SSH instead: `git@github.com:JalapatiRavikumar/Food_devlivary_Application.git`

### Error: "Failed to push some refs"
If the repository on GitHub already has files:
```bash
git pull origin main --allow-unrelated-histories
git push -u origin main
```

## Using SSH (Alternative)

If you prefer SSH authentication:

1. Generate SSH key (if you don't have one):
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```

2. Add SSH key to GitHub:
   - Copy public key: `cat ~/.ssh/id_ed25519.pub`
   - Add to GitHub: Settings → SSH and GPG keys → New SSH key

3. Change remote URL:
   ```bash
   git remote set-url origin git@github.com:JalapatiRavikumar/Food_devlivary_Application.git
   git push -u origin main
   ```

## What Gets Pushed

The `.gitignore` file ensures these are NOT pushed:
- `node_modules/` - Dependencies (too large)
- `.env` files - Environment variables (already in config.js)
- Build files and logs
- IDE and OS files

Everything else in your project will be pushed to GitHub.

