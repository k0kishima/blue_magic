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
select
	EXTRACT(year_month FROM date) AS year,
	forecasters_forecasting_pattern_id,
    sum(betting_amount) as spent,
    sum(refunded_amount) - sum(adjustment_amount) as gained,
    sum(refunded_amount) - sum(adjustment_amount) - sum(betting_amount) as benefits,
    (sum(refunded_amount) - sum(adjustment_amount)) / sum(betting_amount) * 100
from
    bettings
where
	forecasters_forecasting_pattern_id in (1, 2)
group by 
	EXTRACT(year FROM date)
order by year, forecasters_forecasting_pattern_id;
```
