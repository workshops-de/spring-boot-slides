# Template Sync Documentation

This repository uses [actions-template-sync](https://github.com/AndreasAugustin/actions-template-sync) to stay in sync with the upstream template repository.

## 🔄 How It Works

The GitHub Action automatically syncs changes from the template repository:
- **Template Repository**: `git@github.com:workshops-de/workshop-slides-template.git`
- **Sync Schedule**: Every Monday at 3 AM UTC
- **Manual Trigger**: Available via GitHub Actions UI

When changes are detected, the action creates a pull request with the updates.

## 🛡️ Protected Files

The following files/directories are protected from sync (defined in `.templatesyncignore`):

- `lessons/` - Your custom lesson content
- `00-index.md` - Your custom index
- `sources.md` - Your custom sources
- `slides.md` - Your custom slides
- Build artifacts and dependencies
- IDE and OS-specific files

## 🚀 Manual Sync

To manually trigger a sync:

1. Go to **Actions** tab in GitHub
2. Select **Template Sync** workflow
3. Click **Run workflow**
4. Select the branch and click **Run workflow**

## 📝 Reviewing Sync Pull Requests

When a sync PR is created:

1. **Review the changes** carefully
2. **Check for conflicts** with your custom content
3. **Test locally** if needed:
   ```bash
   git fetch origin
   git checkout template-sync-<timestamp>
   npm install
   npm run dev
   ```
4. **Merge** when ready

## ⚙️ Configuration

### Changing Sync Schedule

Edit `.github/workflows/template-sync.yml`:

```yaml
schedule:
  - cron: '0 3 * * 1'  # Every Monday at 3 AM UTC
```

Common schedules:
- Daily: `'0 3 * * *'`
- Weekly (Monday): `'0 3 * * 1'`
- Monthly (1st): `'0 3 1 * *'`

### Adding Protected Files

Edit `.templatesyncignore` to add files/directories that should NOT be synced:

```
# Add custom files to ignore
my-custom-file.md
custom-directory/
```

### Using SSH for Private Templates

If the template repository is private, you need to set up SSH authentication:

1. **Generate SSH key pair**:
   ```bash
   ssh-keygen -t ed25519 -C "template-sync" -f template-sync-key
   ```

2. **Add public key to template repository**:
   - Go to template repo → Settings → Deploy keys
   - Add the public key (`template-sync-key.pub`)
   - Enable read-only access

3. **Add private key as secret**:
   - Go to this repo → Settings → Secrets → Actions
   - Create `TEMPLATE_SYNC_SSH_KEY`
   - Paste the private key content

4. **Uncomment in workflow**:
   ```yaml
   ssh_private_key: ${{ secrets.TEMPLATE_SYNC_SSH_KEY }}
   ```

### Using HTTPS Instead of SSH

If you prefer HTTPS (for public templates):

Edit `.github/workflows/template-sync.yml`:

```yaml
source_repo_path: https://github.com/workshops-de/workshop-slides-template.git
```

## 🔍 Troubleshooting

### Sync Fails with "Permission Denied"

**Solution**: Set up SSH keys (see above) or switch to HTTPS for public repos.

### Merge Conflicts

**Solution**:
1. Checkout the PR branch locally
2. Resolve conflicts manually
3. Push the resolved changes

### Unwanted Files Being Synced

**Solution**: Add them to `.templatesyncignore`

### Sync Not Running

**Solution**:
- Check Actions tab for errors
- Verify workflow file syntax
- Ensure GitHub Actions are enabled for the repository

## 📚 Resources

- [actions-template-sync Documentation](https://github.com/AndreasAugustin/actions-template-sync)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Cron Expression Generator](https://crontab.guru/)

## 🤝 Contributing

If you need to modify the sync behavior:

1. Update `.github/workflows/template-sync.yml`
2. Update `.templatesyncignore` if needed
3. Test with manual trigger
4. Document changes in this file

