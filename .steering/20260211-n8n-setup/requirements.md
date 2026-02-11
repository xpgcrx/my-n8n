# 要求内容

## 概要

このリポジトリでセルフホストのn8nの設定を管理するため、Docker Composeを導入する。

## 背景

手動の `docker run` コマンドによる運用は、設定の再現性や管理性が低いため、`docker-compose.yml` を用いて設定をコードとして管理（Infrastructure as Code）したい。

## 実装対象の機能

### 1. Docker Compose による n8n の起動管理

- `docker-compose.yml` を作成し、コマンド一つで n8n を起動できるようにする。
- 既存の `n8n_data` ボリュームを継続して使用できるように設定する。
- ポート番号（5678）を固定する。

### 2. リポジトリ管理の整備

- `.gitignore` を適切に設定し、リポジトリに不要なファイル（ランタイムデータなど）が含まれないようにする。
- `README.md` に Docker Compose を使った起動・停止方法を追記する。

## 受け入れ条件

### Docker Compose 設定

- [ ] `docker compose up -d` で n8n が起動すること。
- [ ] `docker compose down` で n8n が正常に停止すること。
- [ ] ブラウザから `http://localhost:5678` で n8n にアクセスできること。
- [ ] 既存の `n8n_data` ボリューム内のデータが保持されていること（再起動してもデータが消えない）。

## 成功指標

- 手動コマンド（`docker run`）を記憶・記録しておく必要がなくなる。
- 設定変更が Git の履歴に残るようになる。

## スコープ外

- 外部データベース（PostgreSQLなど）の導入（今回はデフォルトの SQLite を継続使用）。
- 外部公開（HTTPS/Reverse Proxy）の設定。
- バックアップスクリプトの作成。

## 参照ドキュメント

- [n8n Docker Setup Documentation](https://docs.n8n.io/hosting/installation/docker/)
