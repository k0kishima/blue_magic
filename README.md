# README

## 概要

ボートレースの予想から舟券の購入を自動で行うプロダクトです。  
※ ボートレースがなんなのかわからない方は一旦は競馬に置き換えてもらえれば問題ないと思います(賭け式などはほぼ同じでレースでの着順を予想するギャンブルであるという点は変わりません)

docker-compose をメインにセットアップして、環境が整ったパソコンをレース開催時間中に起動させておけば予め組み立てておいた予想ロジックにしたがって全自動で投票されます。

## 開発環境構築手順

### 依存コンテナの起動

以下の依存サービスの環境構築を先んじて行います。

- [ボートレース公式サイトの proxy](https://github.com/k0kishima/boatrace_official_website_proxy)

### 環境変数設定

雛型である `.env.default` をコピーして適宜編集します。

```bash
cp .env.default .env
```

### コンテナの起動

```bash
docker-compose up --build --detach
```

### DB 設定

```bash
docker-compose exec app bundle exec rake db:create db:migrate db:seed
```

### 初期データ

seeds で入れるマスターデータ以外のトランザクション系のデータは半年単位（ドメイン用語になるがレーサーの級別審査期間毎）で保存してあります。  
環境に応じて必要な分をクライアントツールや CLI を利用して適宜インポートしてください。

rake task で月別や日別に取得することも可能です。  
`lib/tasks/official_website/crawl.rake` に実装があり、コメントに実行例も記載されています。  
以下は指定した日付でデータ収集を実行する例です。

```bash
docker-compose exec app bundle exec rake official_website:crawl:crawl_all_data_of_a_day DATE='2022-01-01'
```

これが正常に動作するなら環境構築は成功しています。

## データ設計

![ER図](https://user-images.githubusercontent.com/56298669/125150627-35d0c200-e17c-11eb-84f5-8bf604add30a.png)

※ 予想の素材となるデータ（公式サイトから取得できるデータ）のテーブルのみ抜粋

## 運用

### 管理画面

以上の設定により下表のサービスが利用可能になります。

| サービス | URL                            | 備考                                                             |
| -------- | ------------------------------ | ---------------------------------------------------------------- |
| app      | http://localhost:53000/sidekiq | API モードなので管理画面などの UI はなく GUI は sidekiq/web のみ |

クローラーの制御やデータの管理などの機能を備えた管理画面は別途 SPA で実装されています。  
これらを利用するには以下のサービスを別途利用します。  
https://github.com/k0kishima/blue_magic_front
