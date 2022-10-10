# データの管理方法について

## 概要

利便性を考慮してデータはレーサーの級別審査期毎に保持するようになっています。  
例えば、2021年後期は当年の11月1日～4月30日になります。

ここではある期のデータを収集してエクスポートするまでの手順を解説します。

## 前提条件

- 集計タスク実行開始時に余計なデータが入っていないこと
- 以下の手順で余計なデータを削除できる

**1. DBをスキーマ生成直後に最低限のマスターデータだけ入ってる状態にする**

```bash
docker-compose exec app bundle exec rake db:migrate:reset
docker-compose exec app bundle exec rake db:seed
```

**2. レーサーデータのインポート**

- 既に取得してあるレーサーのデータに関しては、この段階でインポートする
- MySQLクライアントなどでエクスポートしたSQLを `racers` に流し込むなどして予めデータを入れておくこと

## 集計タスクの実行

集計は期単位でデータをバックアップしているため、期初から集計を開始する。
例えば2021年後期を対象とする場合は、2021年11月1日が集計開始日になる。

```bash
docker-compose exec app bundle exec rake official_website:crawl:crawl_all_data_of_a_month YEAR=2021 MONTH=11
```

これを期末の月まで繰り返す（ここでは2022年4月分まで）

## エクスポート

**1. 定期実行を無効にする**

エクスポートの途中に余計なデータが入り込まないようにクローラーを停止する

```irb
docker-compose exec app bundle exec rails runner 'Setting.crawling_enable = false'
```

**2. 不要なデータを消す**

期別にデータを切り分けたいので集計対象期の範疇にないデータを全て削除する

```irb
docker-compose exec app bundle exec rake utils:trim_data_for_specified_term
```

**3. エクスポート実行**

今のところデータ保持の抽象水準はSQLレベルなので、MySQLのクライアントツールなどを利用してテーブルに保存されているレコードをSQL文として吐き出す。  
トランザクションデータだけエクスポートしたいので、以下のテーブルだけエクスポート対象とする

- boat_betting_contribute_rate_aggregations
- boat_settings
- circumference_exhibition_records
- disqualified_race_entries
- events
- motor_betting_contribute_rate_aggregations
- motor_maintenances
- motor_renewals
- odds
- payoffs
- race_entries
- race_records
- racer_conditions
- racer_winning_rate_aggregations
- races
- start_exhibition_records
- weather_conditions
- winning_race_entries

これを `2021年後期.sql` のような単位で保存しておく

レーサーのテーブル（以下）も **上記とは別に**　エクスポートする

- racers

これは `racers_2017-2020.sql` など適当な名前で持っておく
