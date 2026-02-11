#!/bin/bash
# n8nのSQLiteデータベースをバックアップする
# 出力先: リポジトリルートの backups/ ディレクトリ（gitignore対象）

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
BACKUP_DIR="$REPO_ROOT/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

mkdir -p "$BACKUP_DIR"

docker cp n8n:/home/node/.n8n/database.sqlite \
  "$BACKUP_DIR/database_${TIMESTAMP}.sqlite"

echo "DBを $BACKUP_DIR/database_${TIMESTAMP}.sqlite にバックアップした"
