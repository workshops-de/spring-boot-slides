# Template Sync - Quick Reference

## 🚀 Common Commands

### Manual Sync
```bash
# Via GitHub UI
GitHub → Actions → Template Sync (Manual) → Run workflow
```

### Test Sync PR Locally
```bash
git fetch origin
git checkout template-sync-<timestamp>
npm install
npm run dev
```

### Resolve Merge Conflicts
```bash
git fetch origin
git checkout template-sync-<timestamp>
# Edit conflicting files
git add .
git commit -m "chore: resolve conflicts"
git push origin template-sync-<timestamp>
```

### Restore Overwritten File
```bash
# From previous commit
git checkout HEAD~1 -- path/to/file

# From specific commit
git checkout <commit-hash> -- path/to/file
```

## 📁 Key Files

| File | Purpose |
|------|---------|
| `.github/workflows/template-sync.yml` | Automatic sync workflow |
| `.github/workflows/template-sync-manual.yml` | Manual sync with options |
| `.templatesyncignore` | Files to exclude from sync |
| `.github/TEMPLATE_SYNC.md` | Full documentation |
| `.github/SETUP_GUIDE.md` | Setup instructions |

## 🛡️ Protected Content

These are automatically protected:
- ✅ `lessons/` - All your lessons
- ✅ `00-index.md` - Your index
- ✅ `sources.md` - Your sources
- ✅ `slides.md` - Your slides
- ✅ `node_modules/` - Dependencies
- ✅ `dist/` - Build output

## ⚙️ Quick Configuration

### Switch to HTTPS (Public Template)
```yaml
# .github/workflows/template-sync.yml
source_repo_path: https://github.com/workshops-de/workshop-slides-template.git
```

### Change Schedule
```yaml
# .github/workflows/template-sync.yml
schedule:
  - cron: '0 3 * * 1'  # Every Monday 3 AM UTC
  # - cron: '0 3 * * *'  # Daily 3 AM UTC
  # - cron: '0 3 1 * *'  # Monthly (1st) 3 AM UTC
```

### Protect Additional Files
```bash
# .templatesyncignore
echo "my-custom-file.md" >> .templatesyncignore
echo "custom-directory/" >> .templatesyncignore
```

## 🔍 Troubleshooting Quick Fixes

### Empty PRs
**Normal behavior** - repo is in sync

### Permission Denied
1. Use HTTPS for public repos
2. Set up SSH keys for private repos (see SETUP_GUIDE.md)

### Workflow Not Running
1. Check Actions tab is enabled
2. Verify workflow syntax
3. Check cron schedule

### Custom File Overwritten
1. Add to `.templatesyncignore`
2. Restore from git history

## 📊 Workflow Status

Check workflow runs:
```
GitHub → Actions → Template Sync
```

View logs:
```
Actions → Select run → View logs
```

## 🔗 Quick Links

- [Full Documentation](.github/TEMPLATE_SYNC.md)
- [Setup Guide](.github/SETUP_GUIDE.md)
- [actions-template-sync](https://github.com/AndreasAugustin/actions-template-sync)
- [Cron Generator](https://crontab.guru/)

## 📞 Support

1. Check documentation files
2. Review GitHub Actions logs
3. Check template-sync issues on GitHub
4. Contact template maintainers

