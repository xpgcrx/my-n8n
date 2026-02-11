#!/bin/bash
# n8nコンテナからワークフローをJSONエクスポートする
# 出力先: リポジトリルートの workflows/ ディレクトリ

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
OUTPUT_DIR="$REPO_ROOT/workflows"

mkdir -p "$OUTPUT_DIR"

# コンテナ内の一時ディレクトリにエクスポート
docker exec n8n n8n export:workflow --backup --output=/tmp/workflows/

# コンテナからホストにコピー
docker cp n8n:/tmp/workflows/. "$OUTPUT_DIR/"

# コンテナ内の一時ファイルを削除
docker exec n8n rm -rf /tmp/workflows

echo "ワークフローを $OUTPUT_DIR にエクスポートした"
