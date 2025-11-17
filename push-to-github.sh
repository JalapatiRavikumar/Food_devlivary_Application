#!/bin/bash
# Bash script to push project to GitHub
# Run this script after Git is installed

echo "Starting Git setup and push to GitHub..."

# Navigate to project directory
cd "$(dirname "$0")"

# Check if git is available
if ! command -v git &> /dev/null; then
    echo "ERROR: Git is not installed or not in PATH"
    echo "Please install Git from: https://git-scm.com/download/win"
    exit 1
fi

echo "Git found: $(git --version)"

# Initialize git repository (if not already initialized)
if [ ! -d .git ]; then
    echo "Initializing Git repository..."
    git init
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to initialize Git repository"
        exit 1
    fi
else
    echo "Git repository already initialized"
fi

# Add all files
echo "Adding all files to Git..."
git add .
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to add files"
    exit 1
fi

# Check if there are changes to commit
if [ -z "$(git status --porcelain)" ]; then
    echo "No changes to commit"
else
    # Create initial commit
    echo "Creating initial commit..."
    git commit -m "first commit"
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to create commit"
        exit 1
    fi
fi

# Rename branch to main
echo "Setting branch to main..."
git branch -M main

# Check if remote already exists
if git remote get-url origin &> /dev/null; then
    echo "Remote 'origin' already exists. Removing it..."
    git remote remove origin
fi

# Add remote repository
echo "Adding remote repository..."
git remote add origin https://github.com/JalapatiRavikumar/Food_devlivary_Application.git
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to add remote repository"
    exit 1
fi

# Push to GitHub
echo "Pushing to GitHub..."
echo "Note: You may be prompted for GitHub credentials"
git push -u origin main

if [ $? -eq 0 ]; then
    echo "SUCCESS: Project pushed to GitHub!"
    echo "Repository URL: https://github.com/JalapatiRavikumar/Food_devlivary_Application.git"
else
    echo "ERROR: Failed to push to GitHub"
    echo "Possible issues:"
    echo "1. Authentication required - use GitHub Personal Access Token"
    echo "2. Repository doesn't exist on GitHub - create it first"
    echo "3. Network connectivity issues"
    exit 1
}

