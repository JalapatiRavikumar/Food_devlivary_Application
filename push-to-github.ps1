# PowerShell script to push project to GitHub
# Run this script after Git is installed

Write-Host "Starting Git setup and push to GitHub..." -ForegroundColor Green

# Navigate to project directory
$projectPath = "C:\Users\rravi\Downloads\mern-food-delivery-app-main\mern-food-delivery-app-main"
Set-Location $projectPath

# Check if git is available
try {
    $gitVersion = git --version
    Write-Host "Git found: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Git is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Git from: https://git-scm.com/download/win" -ForegroundColor Yellow
    Write-Host "After installation, restart your terminal and run this script again." -ForegroundColor Yellow
    exit 1
}

# Initialize git repository (if not already initialized)
if (-not (Test-Path .git)) {
    Write-Host "Initializing Git repository..." -ForegroundColor Cyan
    git init
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Failed to initialize Git repository" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "Git repository already initialized" -ForegroundColor Yellow
}

# Add all files
Write-Host "Adding all files to Git..." -ForegroundColor Cyan
git add .
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Failed to add files" -ForegroundColor Red
    exit 1
}

# Check if there are changes to commit
$status = git status --porcelain
if ([string]::IsNullOrWhiteSpace($status)) {
    Write-Host "No changes to commit" -ForegroundColor Yellow
} else {
    # Create initial commit
    Write-Host "Creating initial commit..." -ForegroundColor Cyan
    git commit -m "first commit"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Failed to create commit" -ForegroundColor Red
        exit 1
    }
}

# Rename branch to main
Write-Host "Setting branch to main..." -ForegroundColor Cyan
git branch -M main
if ($LASTEXITCODE -ne 0) {
    Write-Host "WARNING: Failed to rename branch (may already be main)" -ForegroundColor Yellow
}

# Check if remote already exists
$remoteExists = git remote get-url origin 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "Remote 'origin' already exists. Removing it..." -ForegroundColor Yellow
    git remote remove origin
}

# Add remote repository
Write-Host "Adding remote repository..." -ForegroundColor Cyan
git remote add origin https://github.com/JalapatiRavikumar/Food_devlivary_Application.git
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Failed to add remote repository" -ForegroundColor Red
    exit 1
}

# Push to GitHub
Write-Host "Pushing to GitHub..." -ForegroundColor Cyan
Write-Host "Note: You may be prompted for GitHub credentials" -ForegroundColor Yellow
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "SUCCESS: Project pushed to GitHub!" -ForegroundColor Green
    Write-Host "Repository URL: https://github.com/JalapatiRavikumar/Food_devlivary_Application.git" -ForegroundColor Cyan
} else {
    Write-Host "ERROR: Failed to push to GitHub" -ForegroundColor Red
    Write-Host "Possible issues:" -ForegroundColor Yellow
    Write-Host "1. Authentication required - use GitHub Personal Access Token" -ForegroundColor Yellow
    Write-Host "2. Repository doesn't exist on GitHub - create it first" -ForegroundColor Yellow
    Write-Host "3. Network connectivity issues" -ForegroundColor Yellow
    exit 1
}

