# Template Sync Setup Guide

This guide will help you set up and configure the template sync for your workshop slides repository.

## 🎯 Overview

Your repository is now configured to automatically sync with the upstream template repository at `git@github.com:workshops-de/workshop-slides-template.git`. This ensures you receive bug fixes, new features, and improvements from the template while keeping your custom content safe.

## 📋 What Was Set Up

### 1. GitHub Actions Workflows

Two workflows were created:

#### **Automatic Sync** (`.github/workflows/template-sync.yml`)

- Runs every Monday at 3 AM UTC
- Can be triggered manually
- Creates a PR when template changes are detected

#### **Manual Sync** (`.github/workflows/template-sync-manual.yml`)

- Provides more control over sync options
- Allows choosing specific branches
- Supports dry-run mode

### 2. Ignore File (`.templatesyncignore`)

Protects your custom content from being overwritten:

- ✅ Your lessons are safe
- ✅ Your custom slides are safe
- ✅ Your configuration files are safe
- ✅ Build artifacts are ignored

### 3. Documentation

- **TEMPLATE_SYNC.md**: Detailed sync documentation
- **pull_request_template.md**: PR template with sync checklist
- **This file**: Setup guide

## 🚀 Getting Started

### Step 1: Verify Repository Permissions

Ensure GitHub Actions can create PRs:

1. Go to **Settings** → **Actions** → **General**
2. Under "Workflow permissions":
   - Select **"Read and write permissions"**
   - ✅ Enable **"Allow GitHub Actions to create and approve pull requests"**
3. Click **Save**

### Step 2: Verify the Setup

Check that the workflows are present:

```bash
ls -la .github/workflows/
# Should show:
# - template-sync.yml
# - template-sync-manual.yml
```

### Step 3: Test Manual Sync

1. Go to your repository on GitHub
2. Click **Actions** tab
3. Select **Template Sync (Manual)**
4. Click **Run workflow**
5. Leave defaults and click **Run workflow**

This will test the sync without waiting for the schedule.

### Step 4: Review the First Sync PR

When the action runs, it will:

1. Compare your repo with the template
2. Create a PR if differences are found
3. Label it with `template-sync` and `automated`

Review the PR carefully to ensure:

- No custom content was affected
- Changes make sense
- No conflicts exist

## 🔧 Configuration Options

### Option 1: Default Configuration (Already Set Up)

The workflows use the simple `owner/repo` format which works for both public and private repositories:

```yaml
source_repo_path: workshops-de/workshop-slides-template
```

This is the recommended approach as it's clean and works universally. For public repos, no additional setup is needed!

### Option 2: Use SSH for Private Templates

If the template is **private**, you need SSH authentication:

#### 1. Generate SSH Key

```bash
ssh-keygen -t ed25519 -C "template-sync-spring-boot-slides" -f ~/.ssh/template-sync-key
```

#### 2. Add Public Key to Template Repository

```bash
# Display public key
cat ~/.ssh/template-sync-key.pub
```

Then:

1. Go to template repository
2. Settings → Deploy keys → Add deploy key
3. Paste the public key
4. Title: "Template Sync - Spring Boot Slides"
5. ✅ Check "Allow read access"
6. Click "Add key"

#### 3. Add Private Key as GitHub Secret

```bash
# Display private key
cat ~/.ssh/template-sync-key
```

Then:

1. Go to **your** repository
2. Settings → Secrets and variables → Actions
3. Click "New repository secret"
4. Name: `TEMPLATE_SYNC_SSH_KEY`
5. Paste the **private key** (entire content)
6. Click "Add secret"

#### 4. Update Workflow

**Edit `.github/workflows/template-sync.yml`:**

Add the SSH key (source_repo_path is already in the correct format):

```yaml
source_repo_path: workshops-de/workshop-slides-template
source_repo_ssh_private_key: ${{ secrets.TEMPLATE_SYNC_SSH_KEY }}
```

### Option 3: Change Sync Schedule

**Edit `.github/workflows/template-sync.yml`:**

```yaml
schedule:
  - cron: '0 3 * * 1' # Current: Every Monday at 3 AM UTC
```

**Common schedules:**

```yaml
# Daily at 3 AM UTC
- cron: '0 3 * * *'

# Every Monday at 3 AM UTC (current)
- cron: '0 3 * * 1'

# First day of month at 3 AM UTC
- cron: '0 3 1 * *'

# Every 6 hours
- cron: '0 */6 * * *'
```

Use [crontab.guru](https://crontab.guru/) to create custom schedules.

### Option 4: Customize Protected Files

**Edit `.templatesyncignore`:**

```bash
# Add files/directories you want to protect
my-custom-config.json
custom-scripts/
special-lesson/
```

**Example: Sync package.json but not package-lock.json**

Remove this line from `.templatesyncignore`:

```
package-lock.json
```

## 🎯 Recommended Workflow

### For Template Updates

1. **Receive PR**: GitHub Action creates a PR automatically
2. **Review Changes**: Check what changed in the template
3. **Test Locally**:
   ```bash
   git fetch origin
   git checkout template-sync-<timestamp>
   npm install
   npm run dev
   ```
4. **Verify Lessons**: Make sure all lessons still work
5. **Merge**: If everything looks good, merge the PR

### For Custom Changes

1. **Make Your Changes**: Edit lessons, add content
2. **Commit & Push**: Normal git workflow
3. **Template Sync**: Continues to work independently
4. **No Conflicts**: Your content is protected

## 🔍 Troubleshooting

### Problem: Sync Creates Empty PRs

**Cause**: Repository is already in sync

**Solution**: This is normal! The action will close the PR automatically.

### Problem: Merge Conflicts

**Cause**: Template changed a file you also modified

**Solution**:

```bash
# Checkout the PR branch
git fetch origin
git checkout template-sync-<timestamp>

# Resolve conflicts
git status
# Edit conflicting files
git add .
git commit -m "chore: resolve template sync conflicts"
git push origin template-sync-<timestamp>
```

### Problem: Workflow Not Running

**Checks**:

1. Go to Actions tab
2. Check if workflows are enabled
3. Check for error messages
4. Verify cron schedule is correct

### Problem: SSH Permission Denied

**Solutions**:

1. Verify SSH key is added to template repository
2. Verify private key is in GitHub Secrets
3. Try HTTPS instead (for public repos)

### Problem: Custom File Was Overwritten

**Solution**:

1. Add the file to `.templatesyncignore`
2. Restore from git history:
   ```bash
   git checkout HEAD~1 -- path/to/file
   ```

## 📚 Additional Resources

- [actions-template-sync Documentation](https://github.com/AndreasAugustin/actions-template-sync)
- [GitHub Actions Workflow Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [Cron Expression Generator](https://crontab.guru/)
- [SSH Key Generation Guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

## 🤝 Need Help?

If you encounter issues:

1. Check the [TEMPLATE_SYNC.md](.github/TEMPLATE_SYNC.md) documentation
2. Review GitHub Actions logs
3. Check the [actions-template-sync issues](https://github.com/AndreasAugustin/actions-template-sync/issues)
4. Contact the template maintainers

## ✅ Next Steps

- [ ] Test manual sync to verify setup
- [ ] Review and merge first sync PR
- [ ] Customize `.templatesyncignore` if needed
- [ ] Adjust sync schedule if desired
- [ ] Set up SSH keys if using private template
- [ ] Document any custom configuration

---

**Happy syncing! 🚀**
