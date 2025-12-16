# Template Sync Troubleshooting Guide

## Common Errors and Solutions

### ❌ Error: "Input 'github_token' has been deprecated"

**Error Message:**

```
Warning: Input 'github_token' has been deprecated with message:
please use source_gh_token instead to have a declarative name
```

**Cause:** The action updated its parameter names.

**Solution:** ✅ Already fixed in the workflows. The correct parameter is now:

```yaml
source_gh_token: ${{ secrets.GITHUB_TOKEN }}
```

---

### ❌ Error: "Unexpected input(s) 'pr_ignore_file'"

**Error Message:**

```
Warning: Unexpected input(s) 'pr_ignore_file', valid inputs are [...]
```

**Cause:** Parameter name changed in the action.

**Solution:** ✅ Already fixed. The correct parameter is:

```yaml
template_sync_ignore_file_path: .templatesyncignore
```

---

### ❌ Error: "Repository not found" with malformed URL

**Error Message:**

```
fatal: repository 'https://github.com/git@github.com:workshops-de/workshop-slides-template.git/' not found
```

**Cause:** Mixing SSH and HTTPS URL formats.

**Wrong:**

```yaml
source_repo_path: git@github.com:workshops-de/workshop-slides-template.git
```

**Correct format (works for both public and private repos):**

```yaml
source_repo_path: workshops-de/workshop-slides-template
```

**For private repos, add SSH key:**

```yaml
source_repo_path: workshops-de/workshop-slides-template
source_repo_ssh_private_key: ${{ secrets.TEMPLATE_SYNC_SSH_KEY }}
```

**Solution:** ✅ Already fixed. The workflow now uses HTTPS format.

---

### ❌ Error: "Permission denied (publickey)"

**Error Message:**

```
Permission denied (publickey).
fatal: Could not read from remote repository.
```

**Cause:** SSH authentication failed or not configured.

**Solutions:**

1. **Already configured correctly:** The `owner/repo` format works for both public and private repos

   ```yaml
   source_repo_path: workshops-de/workshop-slides-template
   ```

2. **If template is private:** Set up SSH keys
   - Generate SSH key pair
   - Add public key to template repo (Settings → Deploy keys)
   - Add private key as GitHub secret (`TEMPLATE_SYNC_SSH_KEY`)
   - Update workflow to use SSH format

See [SETUP_GUIDE.md](SETUP_GUIDE.md#option-2-use-ssh-for-private-templates) for detailed steps.

---

### ❌ Error: "Resource not accessible by integration"

**Error Message:**

```
Error: Resource not accessible by integration
```

**Cause:** Insufficient permissions for GitHub token.

**Solutions:**

1. **Check repository settings:**
   - Settings → Actions → General
   - Workflow permissions → "Read and write permissions"
   - ✅ Enable "Allow GitHub Actions to create and approve pull requests"

2. **Use a Personal Access Token (if needed):**

   ```yaml
   source_gh_token: ${{ secrets.PAT_TOKEN }}
   ```

   Create PAT with `repo` scope: Settings → Developer settings → Personal access tokens

---

### ❌ Error: "No changes detected" but you expect changes

**Cause:** Repository is already in sync, or changes are ignored.

**Solutions:**

1. **Check `.templatesyncignore`:**
   - Verify files aren't accidentally ignored
   - Remove entries if you want them synced

2. **Check template repository:**
   - Verify template has actual changes
   - Check the correct branch is being synced

3. **Force a sync:**
   - Run manual workflow with dry-run disabled
   - Check workflow logs for details

---

### ❌ Error: "Merge conflicts"

**Error Message:**

```
CONFLICT (content): Merge conflict in <file>
```

**Cause:** Template changed a file you also modified.

**Solution:**

```bash
# 1. Fetch the sync PR branch
git fetch origin
git checkout template-sync-<timestamp>

# 2. Check conflicting files
git status

# 3. Resolve conflicts manually
# Edit each conflicting file
# Remove conflict markers (<<<<<<, ======, >>>>>>)

# 4. Stage resolved files
git add <resolved-files>

# 5. Commit the resolution
git commit -m "chore: resolve template sync conflicts"

# 6. Push back to PR branch
git push origin template-sync-<timestamp>
```

---

### ❌ Error: "fatal: refusing to merge unrelated histories"

**Cause:** Template and your repo have completely different git histories.

**Solution:**

This is a complex scenario. Options:

1. **Allow unrelated histories** (not recommended):

   ```yaml
   git_remote_pull_params: '--allow-unrelated-histories'
   ```

2. **Manual sync** (recommended):
   - Download template files manually
   - Copy relevant updates
   - Commit changes yourself

---

### ❌ Workflow doesn't run on schedule

**Cause:** Various reasons.

**Solutions:**

1. **Check Actions are enabled:**
   - Settings → Actions → General
   - Ensure Actions are enabled

2. **Verify cron syntax:**

   ```yaml
   schedule:
     - cron: '0 3 * * 1' # Must be valid cron expression
   ```

   Test at [crontab.guru](https://crontab.guru/)

3. **Check repository activity:**
   - GitHub may disable scheduled workflows on inactive repos
   - Make a commit or run workflow manually to reactivate

4. **Branch must exist:**
   - Scheduled workflows only run on default branch (usually `main`)

---

### ❌ Custom files were overwritten

**Cause:** Files not in `.templatesyncignore`.

**Solution:**

```bash
# 1. Add file to ignore list
echo "path/to/file.md" >> .templatesyncignore

# 2. Restore file from git history
git checkout HEAD~1 -- path/to/file.md

# 3. Commit the restoration
git add .templatesyncignore path/to/file.md
git commit -m "chore: protect custom file from sync"
git push
```

---

### ❌ PR is created but empty

**Cause:** No actual differences after applying ignore rules.

**Solution:** This is normal behavior. The action will:

- Create the PR
- Detect no changes
- Automatically close the PR

No action needed.

---

### ❌ Error: "Rate limit exceeded"

**Cause:** Too many GitHub API calls.

**Solutions:**

1. **Reduce sync frequency:**

   ```yaml
   schedule:
     - cron: '0 3 * * 1' # Weekly instead of daily
   ```

2. **Use a PAT with higher rate limits:**
   ```yaml
   source_gh_token: ${{ secrets.PAT_TOKEN }}
   ```

---

## Debugging Steps

### 1. Check Workflow Logs

```
GitHub → Actions → Template Sync → Select run → View logs
```

Look for:

- Error messages
- API responses
- Git command outputs

### 2. Test Locally

```bash
# Clone template
git clone https://github.com/workshops-de/workshop-slides-template.git /tmp/template

# Check differences
cd /tmp/template
git diff --name-only origin/main

# Compare with your repo
diff -r /tmp/template /path/to/your/repo --exclude=.git --exclude=node_modules
```

### 3. Dry Run

Use the manual workflow with dry-run enabled:

```
GitHub → Actions → Template Sync (Manual) →
Run workflow → Enable "Dry run" → Run
```

This shows what would happen without creating a PR.

### 4. Validate Configuration

```bash
# Check workflow syntax
cat .github/workflows/template-sync.yml

# Check ignore file
cat .templatesyncignore

# Verify template URL is accessible
curl -I https://github.com/workshops-de/workshop-slides-template.git
```

---

## Getting Help

If you're still stuck:

1. **Review documentation:**
   - [QUICK_REFERENCE.md](QUICK_REFERENCE.md)
   - [SETUP_GUIDE.md](SETUP_GUIDE.md)
   - [TEMPLATE_SYNC.md](TEMPLATE_SYNC.md)

2. **Check action documentation:**
   - [actions-template-sync](https://github.com/AndreasAugustin/actions-template-sync)
   - [Action issues](https://github.com/AndreasAugustin/actions-template-sync/issues)

3. **Review workflow logs:**
   - Look for specific error messages
   - Check which step failed

4. **Ask for help:**
   - Template repository maintainers
   - GitHub Actions community
   - Stack Overflow

---

## Prevention Tips

✅ **Test changes:**

- Always test workflow changes with manual trigger
- Use dry-run mode first

✅ **Keep documentation updated:**

- Document custom configurations
- Note any special requirements

✅ **Monitor workflow runs:**

- Check Actions tab regularly
- Set up notifications for failures

✅ **Backup important files:**

- Commit often
- Use branches for experiments

✅ **Review PRs carefully:**

- Check all changed files
- Test locally before merging

---

**Most issues are now resolved in the updated workflow files! 🎉**
