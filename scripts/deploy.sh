#!/usr/bin/env bash
# Mirror the static site to the one.com webroot via rsync over SSH.
# Usage: scripts/deploy.sh [--dry-run]
set -euo pipefail

cd "$(dirname "$0")/.."

if [[ ! -f .env ]]; then
    echo "Missing .env (needs DEPLOY_HOST, DEPLOY_USER, DEPLOY_PASSWORD, DEPLOY_PATH)" >&2
    exit 1
fi
set -a; . ./.env; set +a
export SSHPASS="$DEPLOY_PASSWORD"

rsync -rlptvz --delete --itemize-changes ${1:+"$1"} \
    --exclude '.git/' --exclude '.gitignore' --exclude '.env' \
    --exclude '.claude/' --exclude '.playwright-mcp/' --exclude 'scripts/' --exclude '*.md' \
    -e "sshpass -e ssh -o PubkeyAuthentication=no" \
    ./ "$DEPLOY_USER@$DEPLOY_HOST:$DEPLOY_PATH"
