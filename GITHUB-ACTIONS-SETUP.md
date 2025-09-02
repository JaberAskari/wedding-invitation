# GitHub Actions CI/CD Setup Guide

## 🚀 Automatic Deployment Configuration

Your wedding invitation website is now configured for automatic deployment! Every time you push changes to GitHub, it will automatically update your live website.

## 📋 Required Setup Steps

### Step 1: Add GitHub Secrets

You need to add your AWS credentials as GitHub repository secrets:

1. **Go to your GitHub repository**: https://github.com/JaberAskari/wedding-invitation

2. **Navigate to Settings**:
   - Click on your repository
   - Click "Settings" (top menu)
   - Scroll down to "Security" section in the left sidebar
   - Click "Secrets and variables" → "Actions"

3. **Add these secrets** by clicking "New repository secret":

   **Secret Name**: `AWS_ACCESS_KEY_ID`
   **Secret Value**: `Your AWS Access Key ID (starts with AKIA...)`

   **Secret Name**: `AWS_SECRET_ACCESS_KEY`
   **Secret Value**: `Your AWS Secret Access Key`

   💡 **Where to find these credentials:**
   - Use the same credentials you configured in AWS CLI earlier
   - Or get them from AWS Console → IAM → Users → Security credentials

### Step 2: Test the Workflow

1. **Commit and push these changes**:
   ```bash
   git add .
   git commit -m "Setup AWS S3 auto-deployment with GitHub Actions"
   git push origin master
   ```

2. **Monitor the deployment**:
   - Go to your repository on GitHub
   - Click "Actions" tab
   - You'll see the deployment workflow running
   - Click on the workflow to see detailed logs

## 🔄 How It Works

### Triggers
The deployment runs automatically when you:
- Push to `master` or `main` branch
- Create a pull request to `master` or `main` branch

### What It Does
1. **Checks out your code** from GitHub
2. **Configures AWS credentials** using your secrets
3. **Syncs files to S3** (excluding unnecessary files like .git, scripts, etc.)
4. **Sets proper content types** for all file types (HTML, CSS, JS, images, audio)
5. **Invalidates CloudFront cache** (if you have CloudFront set up)
6. **Displays success message** with your website URL

### Files Deployed
✅ `index.html` - Main website  
✅ `styles/` - CSS files  
✅ `js/` - JavaScript files  
✅ `images/` - All images and favicons  
✅ `mus.mp3` - Background music  
✅ `favicon.ico` - Website icon  

### Files Excluded
❌ `.git/` - Git files  
❌ `.github/` - GitHub Actions workflows  
❌ `*.md` - Documentation files  
❌ `*.sh` - Deployment scripts  
❌ `Dockerfile` - Docker configuration  
❌ `.DS_Store` - macOS system files  

## 🧪 Testing Your Setup

1. **Make a small change** to your website (e.g., edit `index.html`)
2. **Commit and push**:
   ```bash
   git add .
   git commit -m "Test auto-deployment"
   git push origin master
   ```
3. **Check GitHub Actions** to see the deployment progress
4. **Visit your website** in a few minutes to see the changes

## 🌐 Your Live Website

**URL**: http://my-jbr.s3-website.eu-central-1.amazonaws.com

## 🔧 Troubleshooting

### Common Issues:

1. **Deployment fails with AWS credentials error**:
   - Verify secrets are correctly added in GitHub
   - Check that AWS access key has S3 permissions

2. **Website not updating**:
   - Check the Actions tab for any error messages
   - Ensure you're pushing to the correct branch (`master`)

3. **Images/styles not loading**:
   - The workflow sets proper content types automatically
   - If issues persist, check S3 bucket permissions

### Useful Commands:

```bash
# Check current branch
git branch

# Check repository status
git status

# View recent commits
git log --oneline -5

# Push to master branch
git push origin master
```

## 💡 Benefits of This Setup

✅ **Automatic deployments** - No manual intervention needed  
✅ **Version control** - All changes are tracked in Git  
✅ **Rollback capability** - Easy to revert to previous versions  
✅ **Collaboration friendly** - Multiple people can contribute  
✅ **Professional workflow** - Industry-standard CI/CD practices  

## 🎉 You're All Set!

Your wedding invitation website now has professional-grade automatic deployment! Every change you make will be live within minutes of pushing to GitHub.

**Next time you want to update your website:**
1. Edit your files locally
2. Commit and push to GitHub
3. Watch the magic happen! ✨

---
*Happy wedding planning! 💒*
