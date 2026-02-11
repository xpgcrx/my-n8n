# my-n8n

n8n のセルフホスト環境を Docker Compose で管理するためのリポジトリ。

## 概要

このプロジェクトでは、n8n の設定、ボリューム、ポートマッピングなどを `docker-compose.yml` でコード化して管理する。

## 使い方

### 1. 準備

n8n のデータを保存するためのボリュームを作成する（既に作成済みの場合は不要）。

```bash
docker volume create n8n_data
```

### 2. 環境変数の設定

`.env` ファイルをリポジトリルートに作成し、暗号化キーを設定する。

```bash
echo "N8N_ENCRYPTION_KEY=$(openssl rand -hex 32)" > .env
```

このキーはクレデンシャルの暗号化に使用される。一度設定したら変更しないこと。

### 3. 起動

Docker Compose を使用してバックグラウンドで起動する。

```bash
docker compose up -d
```

起動後、[http://localhost:5678](http://localhost:5678) にアクセスして初期設定を行う。

### 4. 停止

コンテナを停止する。

```bash
docker compose down
```

### 5. ワークフローのエクスポート

n8n上で作成したワークフローをJSONファイルとしてエクスポートし、git管理する。

```bash
./scripts/export-workflows.sh
```

`workflows/` ディレクトリにワークフローごとのJSONファイルが出力される。

### 6. データベースのバックアップ

SQLiteデータベースのスナップショットを取得する。クレデンシャル情報や実行履歴を含むため、gitには含めない（`.gitignore` で除外済み）。

```bash
./scripts/backup-db.sh
```

`backups/` ディレクトリにタイムスタンプ付きのファイルが保存される。

## ディレクトリ構成

- `docker-compose.yml`: n8n のサービス定義
- `scripts/`: エクスポート・バックアップ用スクリプト
- `workflows/`: エクスポートされたワークフローJSON（git管理対象）
- `backups/`: DBバックアップ（gitignore対象）
- `.gitignore`: Git 管理から除外するファイルの定義
- `.steering/`: 作業計画や履歴のドキュメント

## 注意事項

- データは Docker ボリューム `n8n_data` に保存される。このボリュームを削除しない限り、コンテナを再作成してもデータは保持される。
- セキュリティのため、公開環境で使用する場合はリバースプロキシ（Nginx, Caddy等）の設定や認証の強化を検討すること。
