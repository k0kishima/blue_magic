# README

## 概要

ボートレースの予想から投票を自動で行うシステム

## 開発環境構築手順

### 環境変数設定

雛型である `.env.default` をコピーして適宜編集する。

```bash
cp .env.default .env
```

### コンテナの起動

```bash
docker-compose up --build --detach 
```
