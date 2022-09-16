# README

## 概要

ボートレースの予想から舟券の購入を自動で行うプロダクトです。  
※ ボートレースがなんなのかわからない方は一旦は競馬に置き換えてもらえれば問題ないと思います(賭け式などはほぼ同じでレースでの着順を予想するギャンブルであるという点は変わりません)

レース開催時間中に起動させておけば予め組み立てておいた予想ロジックにしたがって全自動で投票されます。  

## 運用イメージ

費用対効果の面からAWSなどのクラウドでの運用は今のところ対応しておらず、パソコンのローカル環境を利用して運用することを想定しています。

### 運用の流れ

<table>
    <tr>
        <th colspan="2">分析・シミュレーションを繰り返す</th>
    </tr>
    <tr>
        <td><img alt="analyzing_example_1" src="https://user-images.githubusercontent.com/56298669/148702696-c4c96f99-9b3a-4f72-9533-c21972aa61d5.png"></td>
        <td><img alt="simulation_example_1" src="https://user-images.githubusercontent.com/56298669/148702725-ddc074f2-cd2d-4277-b07a-08925f6eca6b.png"></td>
    </tr>
    <tr>
        <th colspan="2">予想や投票に関する処理が定期実行されるよう設定</th>
    </tr>
    <tr>
        <td><img alt="jenkins_example_1" src="https://user-images.githubusercontent.com/56298669/148702739-3fd8cad1-3c1e-4b52-9a5a-02e517ce6251.png"></td>
        <td><img alt="sidekiq_example_1" src="https://user-images.githubusercontent.com/56298669/148702753-b13ba4a4-c686-46e4-99fa-8d679e6cb8e8.png">
</td>
    </tr>
    <tr>
        <th colspan="2">あとは的中通知を待つだけ</th>
    </tr>
    <tr>
        <td><img alt="jackpot_notification" src="https://user-images.githubusercontent.com/56298669/148702770-1c2dffab-6fb6-494d-87c5-850669993fd3.png"></td>
        <td></td>
    </tr>
</table>

※ 旧バージョンのキャプチャを含んでいるが参考程度に掲載

## ドキュメント

### 開発環境構築手順

- [公式サイトからのデータ取得をできるようにするまで](./docs/dev-step1.md)
- [データ設計](./docs/data-design.md)

### 運用方法

- [データの収集と管理方法](./docs/how-to-manage-data.md)
- [シミュレーション実行方法](./docs/how-to-simulate.md)
