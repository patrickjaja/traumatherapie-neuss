---
name: deploy
description: Deploy this static site to the traumatherapie-neuss.de webroot (one.com) via rsync over SSH. Use when the user says "deploy", "publish" or "push the site live".
disable-model-invocation: true
---

# Deploy traumatherapie-neuss.de

The site is plain static files (`index.html`, `css/`, `img/`, `favicon.png`). `scripts/deploy.sh` mirrors the repo to the server webroot with `rsync --delete`, using the credentials in `.env` (gitignored, never print or commit it).

Steps:

1. Run `git status --short`. If there are uncommitted changes, tell the user and ask whether to deploy anyway (the live site should normally match `main`).
2. Run `scripts/deploy.sh --dry-run` and show the user which files will be uploaded or deleted on the server.
3. If the dry run looks as expected (no surprise deletions), run `scripts/deploy.sh`.
4. Verify: `curl -s https://traumatherapie-neuss.de/ | diff -q - index.html` should report no difference. Report the result.

If `.env` is missing, ask the user for the SSH password and recreate it with `DEPLOY_HOST=ssh.cn8z99t2h.service.one`, `DEPLOY_USER=cn8z99t2h_ssh`, `DEPLOY_PASSWORD=...`, `DEPLOY_PATH=webroots/www/`.
