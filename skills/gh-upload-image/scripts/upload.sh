#!/bin/bash
# GitHub PR/Issueに画像を添付し、公開URLを取得する。
# 使い方: upload.sh <repo:owner/name> <file-path> [name]
set -euo pipefail

REPO="$1"
FILE="$2"
NAME="${3:-$(basename "$FILE")}"
MIME=$(file --mime-type -b "$FILE")

REPO_ID=$(gh api "repos/$REPO" --jq .id)
TOKEN=$(gh auth token)

curl -sf "https://uploads.github.com/user-attachments/assets?name=$NAME&content_type=$MIME&repository_id=$REPO_ID" \
  -X POST -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/json" \
  --data-binary "@$FILE"
