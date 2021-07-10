# README

## 概要

ボートレースの予想から舟券の購入を自動で行うプロダクトです。
※ ボートレースがなんなのかわからない方は一旦は競馬に置き換えてもらえれば問題ないと思います(賭け式などはほぼ同じでレースでの着順を予想するギャンブルであるという点は変わりません)

docker-composeをメインにセットアップして、環境が整ったパソコンをレース開催時間中に起動させておけば予め組み立てておいた予想ロジックにしたがって全自動で投票されます。

## 開発環境構築手順

### 依存コンテナの起動

以下の環境構築を先んじて行う。

* [ボートレース公式サイトのproxy](https://github.com/k0kishima/boatrace_official_website_proxy)

### 環境変数設定

雛型である `.env.default` をコピーして適宜編集する。

```bash
cp .env.default .env
```

### コンテナの起動

```bash
docker-compose up --build --detach 
```

### DB設定

```bash
docker-compose exec app bundle exec rake db:create db:migrate db:seed
```

## データ設計

![ER図](https://user-images.githubusercontent.com/56298669/125150627-35d0c200-e17c-11eb-84f5-8bf604add30a.png)

※ 予想の素材となるデータ（公式サイトから取得できるデータ）のテーブルのみ抜粋