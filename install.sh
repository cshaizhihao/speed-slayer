#!/usr/bin/env bash
set -euo pipefail

# Speed Slayer short installer
# Usage:
#   bash <(curl -fsSL https://github.com/cshaizhihao/speed-slayer/raw/main/install.sh) --all

API_URL="https://api.github.com/repos/cshaizhihao/speed-slayer/contents/scripts/vps-argo-vmess-oneclick.sh?ref=main&ts=$(date +%s)"
RAW_URL="https://raw.githubusercontent.com/cshaizhihao/speed-slayer/main/scripts/vps-argo-vmess-oneclick.sh?ts=$(date +%s)"
TMP="/tmp/speed-slayer-install.sh"

if curl -fsSL -H "Accept: application/vnd.github.raw" -H "Cache-Control: no-cache" "$API_URL" -o "$TMP"; then
  :
else
  curl -fsSL -H "Cache-Control: no-cache" "$RAW_URL" -o "$TMP"
fi

if ! head -n 1 "$TMP" | grep -qE '^#!/usr/bin/env bash|^#!/bin/bash'; then
  echo "Speed Slayer installer error: downloaded content is not a bash script." >&2
  head -n 5 "$TMP" >&2 || true
  exit 1
fi

bash -n "$TMP"
exec bash "$TMP" "$@"
