# Git Commands to Push Project to GitHub

Run these commands in order from the project root directory:

```bash
# Initialize git repository
git init

# Add all files to staging
git add .

# Create initial commit
git commit -m "first commit"

# Rename branch to main
git branch -M main

# Add remote repository
git remote add origin https://github.com/JalapatiRavikumar/Food_devlivary_Application.git

# Push to GitHub
git push -u origin main
```

**Note:** If the repository already exists on GitHub and has files, you may need to pull first:
```bash
git pull origin main --allow-unrelated-histories
```

Then push again:
```bash
git push -u origin main
```

