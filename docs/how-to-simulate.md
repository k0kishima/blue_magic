## シミュレーションの実施

### 1. データをインポートする

期毎にエクスポートして管理しているデータをインポートしておく  
最低でも予想対象の直近2期(2018年前期のレースを予想するなら2017年の前期・後期)あることが望ましい。データは多い方が多いほど予想の精度が高くなる

### 2. 予想ロジックの作成

作成中・・・ 
現時点だとJSONを手動で編集しないといけないのでかなり面倒

### 3. 予想タスクの実行

以下で指定した期間の予想シミュレーションができる

```
docker-compose exec app bundle exec rake bet:enqueue_bet_jobs FORECASTER_ID=1 FROM=2018-05-01 TO=2018-05-01
```

### 4. 結果の取得

前節のタスクは予想だけ行って結果は取得しないので以下のタスクで結果を取得する

```
docker-compose exec app bundle exec rake bet:enqueue_fetch_result_jobs
```

結果は以下のように確認することができる。

```sql
SELECT
    EXTRACT(year_month FROM date) AS year,
    forecasters_forecasting_pattern_id,
    sum(betting_amount) as spent,
    sum(refunded_amount) - sum(adjustment_amount) as gained,
    sum(refunded_amount) - sum(adjustment_amount) - sum(betting_amount) as benefits,
    (sum(refunded_amount) - sum(adjustment_amount)) / sum(betting_amount) * 100 as ROI
FROM
    bettings
#WHERE forecasters_forecasting_pattern_id IN (1, 2, 3, 4, 5, 6, 7, 8)
#WHERE forecasters_forecasting_pattern_id NOT in (2)
GROUP BY EXTRACT(year FROM date)
#GROUP BY EXTRACT(year_month FROM date)
#GROUP BY EXTRACT(year FROM date), forecasters_forecasting_pattern_id
#GROUP BY EXTRACT(year_month FROM date), forecasters_forecasting_pattern_id
#GROUP BY forecasters_forecasting_pattern_id
ORDER BY year;
#ORDER BY forecasters_forecasting_pattern_id;
#ORDER BY year, forecasters_forecasting_pattern_id;
#ORDER BY forecasters_forecasting_pattern_id, year;
```
