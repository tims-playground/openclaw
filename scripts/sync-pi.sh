#!/usr/bin/env bash
# Rsync ~/.openclaw/ from the Raspberry Pi 5 into pi-sync/ at the repo root.
# Requires Tailscale access to the Pi.

set -euo pipefail

PI_HOST="${PI_HOST:-tim@100.85.23.70}"
REMOTE_PATH="${REMOTE_PATH:-~/.openclaw/}"
REPO_ROOT="$(git rev-parse --show-toplevel)"
LOCAL_DIR="$REPO_ROOT/pi-sync"

mkdir -p "$LOCAL_DIR"

echo "Syncing $PI_HOST:$REMOTE_PATH → $LOCAL_DIR/"

rsync -avz --progress \
  --exclude='credentials/' \
  --exclude='*.key' \
  --exclude='*.pem' \
  --exclude='*.p12' \
  "$PI_HOST:$REMOTE_PATH" \
  "$LOCAL_DIR/"

echo "Done. Files at $LOCAL_DIR/"
