# my-n8n

## 概要

セルフホストのn8n用の設定ファイルなどを管理するリポジトリ。

## プロジェクト構成

- `docker-compose.yml` — n8nサービス定義（環境変数は `.env` から読み込み）
- `scripts/export-workflows.sh` — ワークフローをJSONエクスポート
- `scripts/backup-db.sh` — SQLiteデータベースのバックアップ
- `workflows/` — エクスポートされたワークフローJSON（git管理対象）
- `backups/` — DBバックアップ（gitignore対象、コミット禁止）

## 開発ルール

- `.env` にはシークレット（`N8N_ENCRYPTION_KEY` 等）が含まれるため絶対にコミットしない
- `backups/` には機密データが含まれるためコミットしない
- スクリプトは `scripts/` に配置し、実行権限を付与すること
- n8nコンテナ名は `n8n` で固定（スクリプトが依存している）
