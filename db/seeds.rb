# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# rubocop:disable Layout/LineLength
Stadium.insert_all(
  [
    { "tel_code" => 1, "name" => "桐生", "prefecture_id" => 10, "water_quality" => "fresh", "tide_fluctuation" => false, "lat" => 36.4039, "lng" => 139.291, "elevation" => 130.3, created_at: Time.zone.now, updated_at: Time.zone.now, },
    { "tel_code" => 2, "name" => "戸田", "prefecture_id" => 11, "water_quality" => "fresh", "tide_fluctuation" => false, "lat" => 35.8031, "lng" => 139.655, "elevation" => 5.0, created_at: Time.zone.now, updated_at: Time.zone.now, },
    { "tel_code" => 3, "name" => "江戸川", "prefecture_id" => 13, "water_quality" => "brackish", "tide_fluctuation" => true, "lat" => 35.6925, "lng" => 139.859, "elevation" => 1.8, created_at: Time.zone.now, updated_at: Time.zone.now, },
    { "tel_code" => 4, "name" => "平和島", "prefecture_id" => 13, "water_quality" => "sea", "tide_fluctuation" => true, "lat" => 35.5853, "lng" => 139.738, "elevation" => 2.3, created_at: Time.zone.now, updated_at: Time.zone.now, },
    { "tel_code" => 5, "name" => "多摩川", "prefecture_id" => 13, "water_quality" => "sea", "tide_fluctuation" => false, "lat" => 35.6573, "lng" => 139.495, "elevation" => 41.5, created_at: Time.zone.now, updated_at: Time.zone.now, },
    { "tel_code" => 6, "name" => "浜名湖", "prefecture_id" => 22, "water_quality" => "brackish", "tide_fluctuation" => true, "lat" => 34.6985, "lng" => 137.57, "elevation" => 5.2, created_at: Time.zone.now, updated_at: Time.zone.now, },
    { "tel_code" => 7, "name" => "蒲郡", "prefecture_id" => 23, "water_quality" => "brackish", "tide_fluctuation" => false, "lat" => 34.8233, "lng" => 137.203, "elevation" => 4.4, created_at: Time.zone.now, updated_at: Time.zone.now, },
    { "tel_code" => 8, "name" => "常滑", "prefecture_id" => 23, "water_quality" => "sea", "tide_fluctuation" => false, "lat" => 34.8857, "lng" => 136.832, "elevation" => 4.1, created_at: Time.zone.now, updated_at: Time.zone.now, },
    { "tel_code" => 9, "name" => "津", "prefecture_id" => 24, "water_quality" => "brackish", "tide_fluctuation" => false, "lat" => 34.6812, "lng" => 136.517, "elevation" => 4.1, created_at: Time.zone.now, updated_at: Time.zone.now, },
    { "tel_code" => 10, "name" => "三国", "prefecture_id" => 18, "water_quality" => "fresh", "tide_fluctuation" => false, "lat" => 36.2327, "lng" => 136.183, "elevation" => 7.1, created_at: Time.zone.now, updated_at: Time.zone.now, },
    { "tel_code" => 11, "name" => "びわこ", "prefecture_id" => 25, "water_quality" => "fresh", "tide_fluctuation" => false, "lat" => 35.0173, "lng" => 135.859, "elevation" => 87.1, created_at: Time.zone.now, updated_at: Time.zone.now, },
    { "tel_code" => 12, "name" => "住之江", "prefecture_id" => 27, "water_quality" => "fresh", "tide_fluctuation" => false, "lat" => 34.6116, "lng" => 135.469, "elevation" => 4.9, created_at: Time.zone.now, updated_at: Time.zone.now, },
    { "tel_code" => 13, "name" => "尼崎", "prefecture_id" => 28, "water_quality" => "fresh", "tide_fluctuation" => false, "lat" => 34.7195, "lng" => 135.392, "elevation" => 3.6, created_at: Time.zone.now, updated_at: Time.zone.now, },
    { "tel_code" => 14, "name" => "鳴門", "prefecture_id" => 36, "water_quality" => "sea", "tide_fluctuation" => true, "lat" => 34.1908, "lng" => 134.607, "elevation" => 1.1, created_at: Time.zone.now, updated_at: Time.zone.now,  },
    { "tel_code" => 15, "name" => "丸亀", "prefecture_id" => 37, "water_quality" => "sea", "tide_fluctuation" => true, "lat" => 34.3033, "lng" => 133.794, "elevation" => 5.6, created_at: Time.zone.now, updated_at: Time.zone.now,  },
    { "tel_code" => 16, "name" => "児島", "prefecture_id" => 33, "water_quality" => "sea", "tide_fluctuation" => true, "lat" => 34.4488, "lng" => 133.807, "elevation" => 10.5, created_at: Time.zone.now, updated_at: Time.zone.now, },
    { "tel_code" => 17, "name" => "宮島", "prefecture_id" => 34, "water_quality" => "sea", "tide_fluctuation" => true, "lat" => 34.0105, "lng" => 131.833, "elevation" => 6.5, created_at: Time.zone.now, updated_at: Time.zone.now,  },
    { "tel_code" => 18, "name" => "徳山", "prefecture_id" => 35, "water_quality" => "sea", "tide_fluctuation" => true, "lat" => 34.3149, "lng" => 132.304, "elevation" => 1.5, created_at: Time.zone.now, updated_at: Time.zone.now,  },
    { "tel_code" => 19, "name" => "下関", "prefecture_id" => 35, "water_quality" => "sea", "tide_fluctuation" => true, "lat" => 34.0192, "lng" => 131.002, "elevation" => 4.8, created_at: Time.zone.now, updated_at: Time.zone.now,  },
    { "tel_code" => 20, "name" => "若松", "prefecture_id" => 40, "water_quality" => "sea", "tide_fluctuation" => true, "lat" => 33.8873, "lng" => 130.763, "elevation" => 2.2, created_at: Time.zone.now, updated_at: Time.zone.now,  },
    { "tel_code" => 21, "name" => "芦屋", "prefecture_id" => 40, "water_quality" => "fresh", "tide_fluctuation" => false, "lat" => 33.874, "lng" => 130.662, "elevation" => 5.0, created_at: Time.zone.now, updated_at: Time.zone.now, },
    { "tel_code" => 22, "name" => "福岡", "prefecture_id" => 40, "water_quality" => "brackish", "tide_fluctuation" => true, "lat" => 33.5993, "lng" => 130.395, "elevation" => 5.0, created_at: Time.zone.now, updated_at: Time.zone.now, },
    { "tel_code" => 23, "name" => "唐津", "prefecture_id" => 41, "water_quality" => "fresh", "tide_fluctuation" => false, "lat" => 33.4242, "lng" => 129.994, "elevation" => 5.0, created_at: Time.zone.now, updated_at: Time.zone.now, },
    { "tel_code" => 24, "name" => "大村", "prefecture_id" => 42, "water_quality" => "sea", "tide_fluctuation" => true, "lat" => 32.8972, "lng" => 129.95, "elevation" => 6.0, created_at: Time.zone.now, updated_at: Time.zone.now, }
  ]
)

Kpi.upsert_all(
  [
    { id: 1, type: "RacerWinningTrickKpi", entry_object_class_name: "RaceEntry", name: "逃げ成功率", description: "決まり手「逃げ」での1着回数 / 1コース出走回数", attribute_name: "nige_succeed_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 2, type: "RacerWinningTrickKpi", entry_object_class_name: "RaceEntry", name: "差し成功率", description: "決まり手「差し」での1着回数 / 2〜6コースでの出走回数", attribute_name: "sashi_succeed_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 3, type: "RacerWinningTrickKpi", entry_object_class_name: "RaceEntry", name: "まくり成功率", description: "決まり手「まくり」での1着回数 / 2〜6コースでの出走回数", attribute_name: "makuri_succeed_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 4, type: "RacerWinningTrickKpi", entry_object_class_name: "RaceEntry", name: "まくり差し成功率", description: "決まり手「まくり差し」での1着回数 / 3〜6コースでの出走回数", attribute_name: "makurizashi_succeed_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 5, type: "RacerAssistTrickKpi", entry_object_class_name: "RaceEntry", name: "逃がし率", description: "指定したコースで進入した際に決まり手が「逃げ」で負けたレース数 / 指定したコースで進入したレース数（「逃げ」が決まらなかった場合も含む）", attribute_name: "nigashi_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 6, type: "RacerAssistTrickKpi", entry_object_class_name: "RaceEntry", name: "差され率", description: "1コースから進入し、決まり手が「差し」で負けたレース数 / 指定したコースで進入したレース数（「差し」が決まらなかった場合も含む）\n※ ここではまくり差しと差しを区別しない(= 「まくり差し」で負けても分子は増える)", attribute_name: "sasare_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 7, type: "RacerAssistTrickKpi", entry_object_class_name: "RaceEntry", name: "まくられ率", description: "1コースから進入し、決まり手が「まくり」で負けたレース数 / 指定したコースで進入したレース数（「まくり」が決まらなかった場合も含む）", attribute_name: "makurare_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 8, type: "StadiumWinningTrickKpi", entry_object_class_name: "Race", name: "場全レースでの逃げ成功率平均（※展示時点での水面・気象情報の場合）", description: "指定された風速・風向での決まり手「逃げ」成功率", attribute_name: "nige_succeed_rate_of_stadium_in_current_weather_condition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 9, type: "StadiumWinningTrickKpi", entry_object_class_name: "Race", name: "場全レースでの地差し成功率平均（※展示時点での水面・気象情報の場合）", description: "指定された風速・風向での決まり手「差し」成功率", attribute_name: "sashi_succeed_rate_of_stadium_in_current_weather_condition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 10, type: "StadiumWinningTrickKpi", entry_object_class_name: "Race", name: "場全レースでのまくり成功率平均（※展示時点での水面・気象情報の場合）", description: "指定された風速・風向での決まり手「まくり」成功率", attribute_name: "makuri_succeed_rate_of_stadium_in_current_weather_condition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 11, type: "StadiumWinningTrickKpi", entry_object_class_name: "Race", name: "場全レースでのまくり差し成功率平均（※展示時点での水面・気象情報の場合）", description: "指定された風速・風向での決まり手「まくり差し」成功率", attribute_name: "makurizashi_succeed_rate_of_stadium_in_current_weather_condition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 12, type: "AttributionalKpi", entry_object_class_name: "Race", name: "節のグレード", description: "SG, G1 など", attribute_name: "series_grade", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 13, type: "AttributionalKpi", entry_object_class_name: "Race", name: "特選・特賞フラグ", description: "特選レースもしくは特賞レースかどうか", attribute_name: "is_special_race", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 14, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "枠番", description: "", attribute_name: "pit_number", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 15, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "スタート展示進入コース", description: "", attribute_name: "course_number_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 16, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "スタート展示ST", description: "", attribute_name: "start_time_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 17, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "展示タイム", description: "", attribute_name: "exhibition_time", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 18, type: "AttributionalKpi", entry_object_class_name: "Odds", name: "倍率", description: "", attribute_name: "ratio", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 19, type: "AttributionalKpi", entry_object_class_name: "Race", name: "選抜フラグ", description: "選抜レースかどうか", attribute_name: "is_selection_race", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 20, type: "AttributionalKpi", entry_object_class_name: "Race", name: "準優勝戦フラグ", description: "準優勝戦かどうか", attribute_name: "is_semifinal", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 21, type: "AttributionalKpi", entry_object_class_name: "Race", name: "優勝戦フラグ", description: "優勝戦かどうか", attribute_name: "is_final", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 22, type: "AttributionalKpi", entry_object_class_name: "Race", name: "欠場艇数", description: "", attribute_name: "absent_race_entries_count", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 23, type: "RacerDisqualificationKpi", entry_object_class_name: "RaceEntry", name: "今期失格回数合計", description: "", attribute_name: "disqualification_total_in_current_term", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 24, type: "RacerDisqualificationKpi", entry_object_class_name: "RaceEntry", name: "今期F回数", description: "", attribute_name: "flying_count_in_current_term", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 25, type: "RacerDisqualificationKpi", entry_object_class_name: "RaceEntry", name: "今期L回数", description: "", attribute_name: "lateness_count_in_current_term", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 26, type: "RacerDisqualificationKpi", entry_object_class_name: "RaceEntry", name: "今節失格回数合計", description: "", attribute_name: "disqualification_total_in_current_series", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 27, type: "RacerDisqualificationKpi", entry_object_class_name: "RaceEntry", name: "今節F回数", description: "", attribute_name: "flying_count_in_current_series", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 28, type: "RacerDisqualificationKpi", entry_object_class_name: "RaceEntry", name: "今節L回数", description: "", attribute_name: "lateness_count_in_current_series", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 29, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "展示進入コースでの1着率", description: "集計対象: 全場、集計期間: 当該レースから過去1年", attribute_name: "first_place_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 30, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "展示進入コースでの2着率", description: "集計対象: 全場、集計期間: 当該レースから過去1年", attribute_name: "second_place_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 31, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "展示進入コースでの3着率", description: "集計対象: 全場、集計期間: 当該レースから過去1年", attribute_name: "third_place_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 32, type: "RacerCurrentSeriesPlacingRecordKpi", entry_object_class_name: "RaceEntry", name: "今節平均着順", description: "", attribute_name: "placing_average_in_current_series", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 33, type: "RacerCurrentSeriesPlacingRecordKpi", entry_object_class_name: "RaceEntry", name: "今節着順標準偏差", description: "", attribute_name: "placing_stdev_in_current_series", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 34, type: "RacerStartTimeKpi", entry_object_class_name: "RaceEntry", name: "今節平均ST", description: "", attribute_name: "start_time_average_in_current_series", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 35, type: "RacerStartTimeKpi", entry_object_class_name: "RaceEntry", name: "今節ST標準偏差", description: "", attribute_name: "start_time_stdev_in_current_series", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 36, type: "RacerStartTimeKpi", entry_object_class_name: "RaceEntry", name: "今期平均ST", description: "", attribute_name: "start_time_average_in_current_term", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 37, type: "RacerStartTimeKpi", entry_object_class_name: "RaceEntry", name: "今期ST標準偏差", description: "", attribute_name: "start_time_stdev_in_current_term", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 38, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "展示進入コースでの2連対率", description: "集計対象: 全場、集計期間: 当該レースから過去1年", attribute_name: "quinella_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 39, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "展示進入コースでの3連対率", description: "集計対象: 全場、集計期間: 当該レースから過去1年", attribute_name: "trio_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 40, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "[独自KPI] 1着指標", description: "", attribute_name: "base_point_as_first", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 41, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "[独自KPI] 2連対指標", description: "", attribute_name: "base_point_as_second", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 42, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "[独自KPI] 3連対指標", description: "", attribute_name: "base_point_as_third", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 43, type: "AttributionalKpi", entry_object_class_name: "Race", name: "場コード", description: "", attribute_name: "stadium_tel_code", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 44, type: "AttributionalKpi", entry_object_class_name: "Race", name: "レース番号", description: "", attribute_name: "race_number", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 45, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "2連対率順位", description: "※ 順位は出走表内でのもの", attribute_name: "motor_quinella_rate_rank", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 46, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "展示タイム順位", description: "※ 順位は出走表内でのもの", attribute_name: "exhibition_time_order", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 47, type: "AttributionalKpi", entry_object_class_name: "Race", name: "出走者全国勝率平均", description: "", attribute_name: "winning_rate_in_all_stadium_mean", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 48, type: "AttributionalKpi", entry_object_class_name: "Race", name: "出走者全国勝率標準偏差", description: "", attribute_name: "winning_rate_in_all_stadium_sd", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 49, type: "AttributionalKpi", entry_object_class_name: "Race", name: "モーター2連対率平均", description: "", attribute_name: "motor_quinella_rate_mean", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 50, type: "AttributionalKpi", entry_object_class_name: "Race", name: "モーター2連対率標準偏差", description: "", attribute_name: "motor_quinella_rate_sd", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 51, type: "AttributionalKpi", entry_object_class_name: "Race", name: "節の進捗(開催n日目)", description: "", attribute_name: "day_count_in_event", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 52, type: "AttributionalKpi", entry_object_class_name: "Race", name: "展示時の風速/m", description: "", attribute_name: "wind_velocity_when_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
  ]
)
# rubocop:enable Layout/LineLength

Setting.keys.each { |key| Setting.try("#{key}=", Setting.try(key)) } unless Setting.any?

