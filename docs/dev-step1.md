# 公式サイトからのデータ取得をできるようにする

## 概要

レースの予想を行うためには過去のレースデータが必要になります。  
ここではデータを公式サイトから取得してDBに永続化できるようにします。

## 依存コンテナの起動

以下の依存サービスの環境構築を先んじて行います。

- [ボートレース公式サイトのプロキシ](https://github.com/k0kishima/boatrace_official_website_proxy)

## 環境変数設定

雛型である `.env.default` をコピーして適宜編集します。

```bash
cp .env.default .env
```

## コンテナの起動

```bash
docker-compose up --build --detach
```

## DB 設定

### スキーマ生成

```bash
docker-compose exec app bundle exec rake db:create db:migrate db:seed
```
### 初期データ投入

seeds で入れるマスターデータ以外のトランザクション系のデータは半年単位（ドメイン用語になるがレーサーの級別審査期間毎）で保存してあります。  
環境に応じて必要な分をクライアントツールや CLI を利用して適宜インポートしてください。

## 動作確認

rake task でデータを月別や日別に取得することが可能です。  
`lib/tasks/official_website/crawl.rake` に実装があり、コメントに実行例も記載されています。  

以下は指定した日付でデータ収集を実行する例です。

```bash
docker-compose exec app bundle exec rake official_website:crawl:crawl_all_data_of_a_day DATE='2022-01-01'
```

これで指定した日付のデータが正常に取得できているなら動作確認完了です。
