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
    { id: 1, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "逃げ成功率", description: "決まり手「逃げ」での1着回数 / 1コース出走回数", attribute_name: "nige_succeed_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 2, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "差し成功率", description: "決まり手「差し」での1着回数 / 2〜6コースでの出走回数", attribute_name: "sashi_succeed_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 3, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "まくり成功率", description: "決まり手「まくり」での1着回数 / 2〜6コースでの出走回数", attribute_name: "makuri_succeed_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 4, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "まくり差し成功率", description: "決まり手「まくり差し」での1着回数 / 3〜6コースでの出走回数", attribute_name: "makurizashi_succeed_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 5, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "逃がし率", description: "指定したコースで進入した際に決まり手が「逃げ」で負けたレース数 / 指定したコースで進入したレース数（「逃げ」が決まらなかった場合も含む）", attribute_name: "nigashi_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 6, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "差され率", description: "1コースから進入し、決まり手が「差し」で負けたレース数 / 指定したコースで進入したレース数（「差し」が決まらなかった場合も含む）\n※ ここではまくり差しと差しを区別しない(= 「まくり差し」で負けても分子は増える)", attribute_name: "sasare_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 7, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "まくられ率", description: "1コースから進入し、決まり手が「まくり」で負けたレース数 / 指定したコースで進入したレース数（「まくり」が決まらなかった場合も含む）", attribute_name: "makurare_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 8, type: "AttributionalKpi", entry_object_class_name: "Race", name: "場全レースでの逃げ成功率平均（※展示時点での水面・気象情報の場合）", description: "指定された風速・風向での決まり手「逃げ」成功率", attribute_name: "nige_succeed_rate_of_stadium_in_current_weather_condition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 9, type: "AttributionalKpi", entry_object_class_name: "Race", name: "場全レースでの地差し成功率平均（※展示時点での水面・気象情報の場合）", description: "指定された風速・風向での決まり手「差し」成功率", attribute_name: "sashi_succeed_rate_of_stadium_in_current_weather_condition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 10, type: "AttributionalKpi", entry_object_class_name: "Race", name: "場全レースでのまくり成功率平均（※展示時点での水面・気象情報の場合）", description: "指定された風速・風向での決まり手「まくり」成功率", attribute_name: "makuri_succeed_rate_of_stadium_in_current_weather_condition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 11, type: "AttributionalKpi", entry_object_class_name: "Race", name: "場全レースでのまくり差し成功率平均（※展示時点での水面・気象情報の場合）", description: "指定された風速・風向での決まり手「まくり差し」成功率", attribute_name: "makurizashi_succeed_rate_of_stadium_in_current_weather_condition", created_at: Time.zone.now, updated_at: Time.zone.now, },
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
    { id: 23, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "今期失格回数合計", description: "", attribute_name: "disqualification_total_in_current_rating_term", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 24, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "今期F回数", description: "", attribute_name: "flying_count_in_current_rating_term", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 25, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "今期L回数", description: "", attribute_name: "lateness_count_in_current_rating_term", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 26, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "今節失格回数合計", description: "", attribute_name: "disqualification_total_in_current_series", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 27, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "今節F回数", description: "", attribute_name: "flying_count_in_current_series", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 28, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "今節L回数", description: "", attribute_name: "lateness_count_in_current_series", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 29, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "展示進入コースでの1着率", description: "集計対象: 全場、集計期間: 当該レースから過去1年", attribute_name: "first_place_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 30, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "展示進入コースでの2着率", description: "集計対象: 全場、集計期間: 当該レースから過去1年", attribute_name: "second_place_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 31, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "展示進入コースでの3着率", description: "集計対象: 全場、集計期間: 当該レースから過去1年", attribute_name: "third_place_rate_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 32, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "今節平均着順", description: "※不完走は集計対象外", attribute_name: "order_of_arrival_average_in_current_series", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 33, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "今節着順標準偏差", description: "※不完走は集計対象外", attribute_name: "order_of_arrival_stdev_in_current_series", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 34, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "今節平均ST", description: "", attribute_name: "start_time_average_in_current_series", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 35, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "今節ST標準偏差", description: "", attribute_name: "start_time_stdev_in_current_series", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 36, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "今期平均ST", description: "", attribute_name: "start_time_average_in_current_rating_term", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 37, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "今期ST標準偏差", description: "", attribute_name: "start_time_stdev_in_current_rating_term", created_at: Time.zone.now, updated_at: Time.zone.now, },
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
    { id: 53, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "[独自KPI] 序列系のKPI値総和", description: "", attribute_name: "order_sum", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 54, type: "AttributionalKpi", entry_object_class_name: "Race", name: "進入固定フラグ", description: "", attribute_name: "course_fixed", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 55, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "今節平均スタート順", description: "", attribute_name: "start_order_average_in_current_series", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 56, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "今節スタート順標準偏差", description: "", attribute_name: "start_order_stdev_in_current_series", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 57, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "今期平均スタート順", description: "", attribute_name: "start_order_average_in_current_rating_term", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 58, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "今期スタート順標準偏差", description: "", attribute_name: "start_order_stdev_in_current_rating_term", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 59, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "出走者全国勝率", description: "", attribute_name: "winning_rate_in_all_stadium", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 60, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "出走者当地勝率", description: "", attribute_name: "winning_rate_in_event_going_stadium", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 61, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "今節完走回数", description: "", attribute_name: "finished_count_in_current_series", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 62, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "展示進入コースでのST平均", description: "集計対象: 全場、集計期間: 当該レースから過去1年", attribute_name: "start_time_average_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 63, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "展示進入コースでのST標準偏差", description: "集計対象: 全場、集計期間: 当該レースから過去1年", attribute_name: "start_time_stdev_on_start_course_in_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 64, type: "AttributionalKpi", entry_object_class_name: "Race", name: "安定版着用フラグ", description: "", attribute_name: "use_stabilizer", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 65, type: "AttributionalKpi", entry_object_class_name: "Race", name: "出走者最高勝率", description: "勝率が最も高い出走者の勝率の値", attribute_name: "winning_rate_in_all_stadium_first", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 66, type: "AttributionalKpi", entry_object_class_name: "Race", name: "出走者最高モーター2連対率", description: "", attribute_name: "motor_quinella_rate_first", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 67, type: "AttributionalKpi", entry_object_class_name: "Race", name: "出走者最高モーター3連対率", description: "", attribute_name: "motor_trio_rate_first", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 68, type: "AttributionalKpi", entry_object_class_name: "Race", name: "場全レースでの1コースの差され率平均（※展示時点での水面・気象情報の場合）", description: "", attribute_name: "sasare_rate_of_stadium_in_current_weather_condition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 69, type: "AttributionalKpi", entry_object_class_name: "Race", name: "場全レースでの1コースのまくられ率平均（※展示時点での水面・気象情報の場合）", description: "", attribute_name: "makurare_rate_of_stadium_in_current_weather_condition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 70, type: "AttributionalKpi", entry_object_class_name: "Race", name: "出走者最速ST", description: "STが最も速い出走者のSTの値", attribute_name: "start_time_average_on_start_course_in_exhibition_first", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 71, type: "AttributionalKpi", entry_object_class_name: "Race", name: "最高パフォーマンススコア(PS)", description: "PSが最も高い出走者のPSの値", attribute_name: "performance_score_first", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 72, type: "AttributionalKpi", entry_object_class_name: "Race", name: "最高パフォーマンススコア出走者枠番", description: "PSが最も高い出走者の枠番", attribute_name: "best_performance_score_pit_number", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 73, type: "AttributionalKpi", entry_object_class_name: "RaceEntry", name: "パフォーマンススコア(PS)", description: "", attribute_name: "performance_score", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 74, type: "AttributionalKpi", entry_object_class_name: "Odds", name: "三連単1着", description: "", attribute_name: "first", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 75, type: "AttributionalKpi", entry_object_class_name: "Odds", name: "三連単2着", description: "", attribute_name: "second", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 76, type: "AttributionalKpi", entry_object_class_name: "Odds", name: "三連単3着", description: "", attribute_name: "third", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 77, type: "AttributionalKpi", entry_object_class_name: "Race", name: "モーター使用日数", description: "初卸日からの経過日数", attribute_name: "motor_lapsed_days_from_renewed", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 78, type: "AttributionalKpi", entry_object_class_name: "Race", name: "展示時の天候", description: "", attribute_name: "weather_when_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 79, type: "AttributionalKpi", entry_object_class_name: "Race", name: "展示時の気温", description: "", attribute_name: "air_temperature_when_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
    { id: 80, type: "AttributionalKpi", entry_object_class_name: "Race", name: "展示時の水温", description: "", attribute_name: "water_temperature_when_exhibition", created_at: Time.zone.now, updated_at: Time.zone.now, },
  ]
)
# rubocop:enable Layout/LineLength

Setting.keys.each { |key| Setting.try("#{key}=", Setting.try(key)) } unless Setting.any?

Forecaster.create(
  id: 1,
  status: :simulating,
  name: 'Copy A2 from V2',
  betting_strategy: :take_all_forecasting_patterns
)

ForecastingPattern.upsert_all(
  [
    {
      id: 1,
      name: '前付けでの波乱狙い',
      race_select_condition: {
        and: [
          # レース絞り込み共通条件
          {
            or: [
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'NO_GRADE' },
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'G3' },
                ]
              },
            ],
          },
          {
            '==': [
              { item: :itself, attribute: :is_special_race },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_selection_race },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_semifinal },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_final },
              { item: :literal, value: false },
            ]
          },
          {
            '!=': [
              { item: :itself, attribute: :stadium_tel_code },
              { item: :literal, value: 3 },
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :race_number },
              { item: :literal, value: 10 },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :absent_race_entries_count },
              { item: :literal, value: 0 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_first },
              { item: :literal, value: 6.6 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_mean },
              { item: :literal, value: 6 }
            ]
          },
          # /レース絞り込み共通条件
          {
            '<=': [
              { item: :itself, attribute: :nige_succeed_rate_of_stadium_in_current_weather_condition },
              { item: :literal, value: 0.5 }
            ]
          },
          {
            '<': [
              { item: :pit_number_1, attribute: :nige_succeed_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.65 }
            ]
          },
          {
            '<': [
              {
                '+': [
                  {
                    '*': [
                      { item: :pit_number_1, attribute: :first_place_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 10 },
                    ]
                  },
                  {
                    '+': [
                      {
                        '-': [
                          { item: :literal, value: 7 },
                          { item: :pit_number_1, attribute: :motor_quinella_rate_rank },
                        ]
                      },
                      {
                        '-': [
                          { item: :literal, value: 7 },
                          { item: :pit_number_1, attribute: :exhibition_time_order },
                        ]
                      },
                    ]
                  }
                ]
              },
              { item: :literal, value: 11 },
            ]
          },
          {
            or: [
              {
                and: [
                  {
                    '<=': [
                      { item: :pit_number_4, attribute: :course_number_in_exhibition },
                      { item: :literal, value: 2 },
                    ]
                  },
                  {
                    '<=': [
                      {
                        '+': [
                          {
                            '*': [
                              { item: :pit_number_4, attribute: :first_place_rate_on_start_course_in_exhibition },
                              { item: :literal, value: 10 },
                            ]
                          },
                          {
                            '+': [
                              {
                                '-': [
                                  { item: :literal, value: 7 },
                                  { item: :pit_number_4, attribute: :motor_quinella_rate_rank },
                                ]
                              },
                              {
                                '-': [
                                  { item: :literal, value: 7 },
                                  { item: :pit_number_4, attribute: :exhibition_time_order },
                                ]
                              },
                            ]
                          }
                        ]
                      },
                      { item: :literal, value: 10 },
                    ]
                  },
                ]
              },
              {
                and: [
                  {
                    '<=': [
                      { item: :pit_number_5, attribute: :course_number_in_exhibition },
                      { item: :literal, value: 2 },
                    ]
                  },
                  {
                    '<=': [
                      {
                        '+': [
                          {
                            '*': [
                              { item: :pit_number_5, attribute: :first_place_rate_on_start_course_in_exhibition },
                              { item: :literal, value: 10 },
                            ]
                          },
                          {
                            '+': [
                              {
                                '-': [
                                  { item: :literal, value: 7 },
                                  { item: :pit_number_5, attribute: :motor_quinella_rate_rank },
                                ]
                              },
                              {
                                '-': [
                                  { item: :literal, value: 7 },
                                  { item: :pit_number_5, attribute: :exhibition_time_order },
                                ]
                              },
                            ]
                          }
                        ]
                      },
                      { item: :literal, value: 10 },
                    ]
                  },
                ]
              },
              {
                and: [
                  {
                    '<=': [
                      { item: :pit_number_6, attribute: :course_number_in_exhibition },
                      { item: :literal, value: 2 },
                    ]
                  },
                  {
                    '<=': [
                      {
                        '+': [
                          {
                            '*': [
                              { item: :pit_number_6, attribute: :first_place_rate_on_start_course_in_exhibition },
                              { item: :literal, value: 10 },
                            ]
                          },
                          {
                            '+': [
                              {
                                '-': [
                                  { item: :literal, value: 7 },
                                  { item: :pit_number_6, attribute: :motor_quinella_rate_rank },
                                ]
                              },
                              {
                                '-': [
                                  { item: :literal, value: 7 },
                                  { item: :pit_number_6, attribute: :exhibition_time_order },
                                ]
                              },
                            ]
                          }
                        ]
                      },
                      { item: :literal, value: 10 },
                    ]
                  },
                ]
              },
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_sd },
              { item: :literal, value: 1.5 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_first },
              { item: :literal, value: 6.5 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_mean },
              { item: :literal, value: 6.5 }
            ]
          },
        ],
      },
      first_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 2 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_first },
                      { item: :literal, value: 10 }
                    ]
                  },
                ]
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_first },
                      { item: :literal, value: 9 }
                    ]
                  },
                ]
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_first },
                      { item: :literal, value: 10 }
                    ]
                  },
                ]
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 5 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_first },
                      { item: :literal, value: 9 }
                    ]
                  },
                ]
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 6 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_first },
                      { item: :literal, value: 10 }
                    ]
                  },
                ]
              },
            ],
          },
          {
            '>=': [
              { item: :itself, attribute: :course_number_in_exhibition },
              { item: :literal, value: 3 }
            ]
          },
          {
            '<=': [
              { item: :itself, attribute: :course_number_in_exhibition },
              { item: :literal, value: 5 }
            ]
          },
          # 1着絞り込み共通条件
          {
            or: [
              {
                '<': [
                  { item: :race, attribute: :day_count_in_event },
                  { item: :literal, value: 4 },
                ]
              },
              {
                or: [
                  {
                    '<': [
                      { item: :itself, attribute: :order_of_arrival_average_in_current_series },
                      { item: :literal, value: 5 },
                    ]
                  },
                  {
                    '>': [
                      { item: :itself, attribute: :order_of_arrival_stdev_in_current_series },
                      { item: :literal, value: 1 },
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '<=': [
                      { item: :itself, attribute: :order_of_arrival_average_in_current_series },
                      { item: :literal, value: 4 },
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :start_order_average_in_current_series },
                      { item: :literal, value: 3.75 },
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :start_time_stdev_in_current_series },
                      { item: :literal, value: 0.125 },
                    ]
                  },
                ]
              },
            ],
          },
          {
            or: [
              {
                '==': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 1 },
                ]
              },
              {
                '>=': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  {
                    '-': [
                      { item: :race, attribute: :winning_rate_in_all_stadium_mean },
                      { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                    ]
                  },
                ]
              },
            ],
          },
          {
            '<=': [
              { item: :itself, attribute: :flying_count_in_current_rating_term },
              { item: :literal, value: 1 }
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :flying_count_in_current_series },
              { item: :literal, value: 0 }
            ]
          },
          # /1着絞り込み共通条件
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
        ]
      },
      second_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 1 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 12 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 2 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 11 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 9 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 9.5 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 5 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 8.5 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 6 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 12 }
                    ]
                  },
                ],
              },
            ]
          },
          # 2着絞り込み共通条件
          {
            or: [
              {
                '<': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>=': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  {
                    '-': [
                      { item: :race, attribute: :winning_rate_in_all_stadium_mean },
                      { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                    ]
                  },
                ]
              },
            ],
          },
          # /2着絞り込み共通条件
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
          # 2・3着共通条件
          {
            or: [
              {
                '<=': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 2 },
                ]
              },
            ],
          },
          # /2・3着共通条件
        ]
      },
      third_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 1 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 9.5 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 2 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 12 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 12 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 10.5 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 5 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 10.5 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 6 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 10 }
                    ]
                  },
                ],
              },
            ]
          },
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
          # 2・3着共通条件
          {
            or: [
              {
                '<=': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 2 },
                ]
              },
            ],
          },
          # /2・3着共通条件
        ]
      },
      odds_select_condition: {
        and: [
          {
            '>=': [
              { item: :itself, attribute: :ratio },
              { item: :literal, value: 100 }
            ]
          },
          {
            '<=': [
              { item: :itself, attribute: :ratio },
              { item: :literal, value: 300 }
            ]
          }
        ]
      },
      created_at: Time.zone.now,
      updated_at: Time.zone.now,
    },
    {
      id: 2,
      name: 'イン逃げ',
      race_select_condition: {
        and: [
          # レース絞り込み共通条件
          {
            or: [
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'NO_GRADE' },
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'G3' },
                ]
              },
            ],
          },
          {
            '==': [
              { item: :itself, attribute: :is_special_race },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_selection_race },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_semifinal },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_final },
              { item: :literal, value: false },
            ]
          },
          {
            '!=': [
              { item: :itself, attribute: :stadium_tel_code },
              { item: :literal, value: 3 },
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :race_number },
              { item: :literal, value: 10 },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :absent_race_entries_count },
              { item: :literal, value: 0 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_first },
              { item: :literal, value: 6.8 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_mean },
              { item: :literal, value: 6 }
            ]
          },
          # /レース絞り込み共通条件
          {
            '==': [
              { item: :pit_number_1, attribute: :course_number_in_exhibition },
              { item: :literal, value: 1 }
            ]
          },
          {
            '==': [
              { item: :pit_number_2, attribute: :course_number_in_exhibition },
              { item: :literal, value: 2 }
            ]
          },
          {
            '==': [
              { item: :pit_number_1, attribute: :flying_count_in_current_rating_term },
              { item: :literal, value: 0 }
            ]
          },
          {
            '>': [
              { item: :itself, attribute: :nige_succeed_rate_of_stadium_in_current_weather_condition },
              { item: :literal, value: 0.55 }
            ]
          },
          {
            '>': [
              { item: :pit_number_1, attribute: :nige_succeed_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.65 }
            ]
          },
          {
            '>': [
              { item: :pit_number_2, attribute: :nigashi_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.5 }
            ]
          },
          {
            '<': [
              { item: :pit_number_3, attribute: :performance_score },
              { item: :literal, value: 17 }
            ]
          },
          {
            '<': [
              { item: :pit_number_4, attribute: :performance_score },
              { item: :literal, value: 17 }
            ]
          },
          {
            '<=': [
              { item: :itself, attribute: :wind_velocity_when_exhibition },
              { item: :literal, value: 4 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_sd },
              { item: :literal, value: 1.5 }
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :course_fixed },
              { item: :literal, value: false }
            ]
          },
          {
            '!=': [
              { item: :pit_number_6, attribute: :winning_rate_in_all_stadium },
              { item: :itself, attribute: :winning_rate_in_all_stadium_first },
            ]
          },
          {
            '!=': [
              { item: :pit_number_6, attribute: :start_time_average_on_start_course_in_exhibition },
              { item: :itself, attribute: :start_time_average_on_start_course_in_exhibition_first },
            ]
          },
        ]
      },
      first_place_select_condition: {
        and: [
          {
            '==': [
              { item: :itself, attribute: :pit_number },
              { item: :literal, value: 1 }
            ]
          },
          {
            '>=': [
              { item: :itself, attribute: :performance_score },
              { item: :literal, value: 12 }
            ]
          },
          # 1着絞り込み共通条件
          {
            or: [
              {
                '<': [
                  { item: :race, attribute: :day_count_in_event },
                  { item: :literal, value: 4 },
                ]
              },
              {
                or: [
                  {
                    '<': [
                      { item: :itself, attribute: :order_of_arrival_average_in_current_series },
                      { item: :literal, value: 5 },
                    ]
                  },
                  {
                    '>': [
                      { item: :itself, attribute: :order_of_arrival_stdev_in_current_series },
                      { item: :literal, value: 1 },
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '<=': [
                      { item: :itself, attribute: :order_of_arrival_average_in_current_series },
                      { item: :literal, value: 4 },
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :start_order_average_in_current_series },
                      { item: :literal, value: 3.75 },
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :start_time_stdev_in_current_series },
                      { item: :literal, value: 0.125 },
                    ]
                  },
                ]
              },
            ],
          },
          {
            or: [
              {
                '==': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 1 },
                ]
              },
              {
                '>=': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  {
                    '-': [
                      { item: :race, attribute: :winning_rate_in_all_stadium_mean },
                      { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                    ]
                  },
                ]
              },
            ],
          },
          {
            '<=': [
              { item: :itself, attribute: :flying_count_in_current_rating_term },
              { item: :literal, value: 1 }
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :flying_count_in_current_series },
              { item: :literal, value: 0 }
            ]
          },
          # /1着絞り込み共通条件
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
        ]
      },
      second_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 2 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 10.5 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 9.5 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 9 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 5 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 8.5 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 6 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 8 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :course_number_in_exhibition },
                      { item: :literal, value: 5 }
                    ]
                  },
                ],
              },
            ]
          },
          # 2着絞り込み共通条件
          {
            or: [
              {
                '<': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>=': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  {
                    '-': [
                      { item: :race, attribute: :winning_rate_in_all_stadium_mean },
                      { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                    ]
                  },
                ]
              },
            ],
          },
          # /2着絞り込み共通条件
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
          # 2・3着共通条件
          {
            or: [
              {
                '<=': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 2 },
                ]
              },
            ],
          },
          # /2・3着共通条件
        ]
      },
      third_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 2 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 10.5 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 9.5 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 9.5 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 5 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 8.5 }
                    ]
                  },
                  {
                    '>': [
                      { item: :itself, attribute: :trio_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 6 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 8.5 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :trio_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0 }
                    ]
                  },
                ],
              },
            ]
          },
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
          # 2・3着共通条件
          {
            or: [
              {
                '<=': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 2 },
                ]
              },
            ],
          },
          # /2・3着共通条件
        ]
      },
      odds_select_condition: {
        and: [
          {
            '>=': [
              { item: :itself, attribute: :ratio },
              { item: :literal, value: 20 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :ratio },
              { item: :literal, value: 40 }
            ]
          }
        ]
      }
    },
    {
      id: 3,
      name: '安定版着用の荒れ水面',
      race_select_condition: {
        and: [
          # レース絞り込み共通条件
          {
            or: [
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'NO_GRADE' },
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'G3' },
                ]
              },
            ],
          },
          {
            '==': [
              { item: :itself, attribute: :is_special_race },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_selection_race },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_semifinal },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_final },
              { item: :literal, value: false },
            ]
          },
          {
            '!=': [
              { item: :itself, attribute: :stadium_tel_code },
              { item: :literal, value: 3 },
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :race_number },
              { item: :literal, value: 10 },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :absent_race_entries_count },
              { item: :literal, value: 0 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_first },
              { item: :literal, value: 6.8 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_mean },
              { item: :literal, value: 6 }
            ]
          },
          # /レース絞り込み共通条件
          {
            '==': [
              { item: :pit_number_1, attribute: :course_number_in_exhibition },
              { item: :literal, value: 1 }
            ]
          },
          {
            '>': [
              { item: :itself, attribute: :wind_velocity_when_exhibition },
              { item: :literal, value: 4 }
            ]
          },
          {
            '<=': [
              { item: :itself, attribute: :nige_succeed_rate_of_stadium_in_current_weather_condition },
              { item: :literal, value: 0.45 }
            ]
          },
          {
            '<': [
              { item: :pit_number_1, attribute: :nige_succeed_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.65 }
            ]
          },
          {
            '<': [
              { item: :pit_number_2, attribute: :nigashi_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.5 }
            ]
          },
          {
            or: [
              {
                '>=': [
                  { item: :pit_number_1, attribute: :flying_count_in_current_rating_term },
                  { item: :literal, value: 1 }
                ]
              },
              {
                '>=': [
                  { item: :pit_number_1, attribute: :performance_score },
                  { item: :literal, value: 8 }
                ]
              },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :course_fixed },
              { item: :literal, value: false }
            ]
          },
          {
            '!=': [
              { item: :itself, attribute: :use_stabilizer },
              { item: :literal, value: false }
            ]
          },
        ]
      },
      first_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 2 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 8 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 10 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 9 }
                    ]
                  },
                ],
              },
            ]
          },
          # 1着絞り込み共通条件
          {
            or: [
              {
                '<': [
                  { item: :race, attribute: :day_count_in_event },
                  { item: :literal, value: 4 },
                ]
              },
              {
                or: [
                  {
                    '<': [
                      { item: :itself, attribute: :order_of_arrival_average_in_current_series },
                      { item: :literal, value: 5 },
                    ]
                  },
                  {
                    '>': [
                      { item: :itself, attribute: :order_of_arrival_stdev_in_current_series },
                      { item: :literal, value: 1 },
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '<=': [
                      { item: :itself, attribute: :order_of_arrival_average_in_current_series },
                      { item: :literal, value: 4 },
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :start_order_average_in_current_series },
                      { item: :literal, value: 3.75 },
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :start_time_stdev_in_current_series },
                      { item: :literal, value: 0.125 },
                    ]
                  },
                ]
              },
            ],
          },
          {
            or: [
              {
                '==': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 1 },
                ]
              },
              {
                '>=': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  {
                    '-': [
                      { item: :race, attribute: :winning_rate_in_all_stadium_mean },
                      { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                    ]
                  },
                ]
              },
            ],
          },
          {
            '<=': [
              { item: :itself, attribute: :flying_count_in_current_rating_term },
              { item: :literal, value: 1 }
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :flying_count_in_current_series },
              { item: :literal, value: 0 }
            ]
          },
          # /1着絞り込み共通条件
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
        ]
      },
      second_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 2 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 9 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.3 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 8 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.1 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 8 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.1 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 5 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 9 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.09 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 6 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 8 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.05 }
                    ]
                  },
                ],
              },
            ]
          },
          # 2着絞り込み共通条件
          {
            or: [
              {
                '<': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>=': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  {
                    '-': [
                      { item: :race, attribute: :winning_rate_in_all_stadium_mean },
                      { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                    ]
                  },
                ]
              },
            ],
          },
          # /2着絞り込み共通条件
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
          # 2・3着共通条件
          {
            or: [
              {
                '<=': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 2 },
                ]
              },
            ],
          },
          # /2・3着共通条件
        ]
      },
      third_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 1 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.4 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 8 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.1 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 8 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.1 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 5 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 9 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.09 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 6 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 8 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.05 }
                    ]
                  },
                ],
              },
            ]
          },
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
          # 2・3着共通条件
          {
            or: [
              {
                '<=': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 2 },
                ]
              },
            ],
          },
          # /2・3着共通条件
        ]
      },
      odds_select_condition: {
        and: [
          {
            '>=': [
              { item: :itself, attribute: :ratio },
              { item: :literal, value: 100 }
            ]
          },
          {
            '<=': [
              { item: :itself, attribute: :ratio },
              { item: :literal, value: 300 }
            ]
          }
        ]
      }
    },
    {
      id: 4,
      name: '強風（安定版なし）',
      race_select_condition: {
        and: [
          # レース絞り込み共通条件
          {
            or: [
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'NO_GRADE' },
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'G3' },
                ]
              },
            ],
          },
          {
            '==': [
              { item: :itself, attribute: :is_special_race },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_selection_race },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_semifinal },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_final },
              { item: :literal, value: false },
            ]
          },
          {
            '!=': [
              { item: :itself, attribute: :stadium_tel_code },
              { item: :literal, value: 3 },
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :race_number },
              { item: :literal, value: 10 },
            ]
          },
          # /レース絞り込み共通条件
          {
            '==': [
              { item: :pit_number_1, attribute: :course_number_in_exhibition },
              { item: :literal, value: 1 }
            ]
          },
          {
            '==': [
              { item: :pit_number_2, attribute: :course_number_in_exhibition },
              { item: :literal, value: 2 }
            ]
          },
          {
            '==': [
              { item: :pit_number_3, attribute: :course_number_in_exhibition },
              { item: :literal, value: 3 }
            ]
          },
          {
            '==': [
              { item: :pit_number_4, attribute: :course_number_in_exhibition },
              { item: :literal, value: 4 }
            ]
          },
          {
            '>': [
              { item: :itself, attribute: :wind_velocity_when_exhibition },
              { item: :literal, value: 4 }
            ]
          },
          {
            '<=': [
              { item: :itself, attribute: :nige_succeed_rate_of_stadium_in_current_weather_condition },
              { item: :literal, value: 0.45 }
            ]
          },
          {
            '>=': [
              { item: :itself, attribute: :makurare_rate_of_stadium_in_current_weather_condition },
              { item: :literal, value: 0.2 }
            ]
          },
          {
            or: [
              {
                '<': [
                  { item: :pit_number_1, attribute: :nige_succeed_rate_on_start_course_in_exhibition },
                  { item: :literal, value: 0.65 }
                ]
              },
              {
                and: [
                  {
                    '>=': [
                      { item: :pit_number_1, attribute: :flying_count_in_current_rating_term },
                      { item: :literal, value: 1 }
                    ]
                  },
                  {
                    '<': [
                      { item: :pit_number_1, attribute: :performance_score },
                      { item: :literal, value: 9 }
                    ]
                  },
                ],
              },
            ]
          },
          {
            '>': [
              { item: :pit_number_1, attribute: :makurare_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.2 }
            ]
          },
          {
            '<': [
              { item: :pit_number_2, attribute: :nigashi_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.5 }
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :course_fixed },
              { item: :literal, value: false }
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :use_stabilizer },
              { item: :literal, value: false }
            ]
          },
        ]
      },
      first_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 2 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 12 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 11 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 12 }
                    ]
                  },
                ],
              },
            ]
          },
          # 1着絞り込み共通条件
          {
            or: [
              {
                '<': [
                  { item: :race, attribute: :day_count_in_event },
                  { item: :literal, value: 4 },
                ]
              },
              {
                or: [
                  {
                    '<': [
                      { item: :itself, attribute: :order_of_arrival_average_in_current_series },
                      { item: :literal, value: 5 },
                    ]
                  },
                  {
                    '>': [
                      { item: :itself, attribute: :order_of_arrival_stdev_in_current_series },
                      { item: :literal, value: 1 },
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '<=': [
                      { item: :itself, attribute: :order_of_arrival_average_in_current_series },
                      { item: :literal, value: 4 },
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :start_order_average_in_current_series },
                      { item: :literal, value: 3.75 },
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :start_time_stdev_in_current_series },
                      { item: :literal, value: 0.125 },
                    ]
                  },
                ]
              },
            ],
          },
          {
            or: [
              {
                '==': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 1 },
                ]
              },
              {
                '>=': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  {
                    '-': [
                      { item: :race, attribute: :winning_rate_in_all_stadium_mean },
                      { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                    ]
                  },
                ]
              },
            ],
          },
          # /1着絞り込み共通条件
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
        ]
      },
      second_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 2 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 13 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.3 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 13 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.1 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 13 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.1 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 5 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 12 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.09 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 6 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 13 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.05 }
                    ]
                  },
                ],
              },
            ]
          },
          # 2着絞り込み共通条件
          {
            or: [
              {
                '<': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>=': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  {
                    '-': [
                      { item: :race, attribute: :winning_rate_in_all_stadium_mean },
                      { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                    ]
                  },
                ]
              },
            ],
          },
          # /2着絞り込み共通条件
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
          # 2・3着共通条件
          {
            or: [
              {
                '<=': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 2 },
                ]
              },
            ],
          },
          # /2・3着共通条件
        ]
      },
      third_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 1 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.4 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 8 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 13 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.1 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 13 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.1 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 5 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 12 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.09 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 6 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 13 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.05 }
                    ]
                  },
                ],
              },
            ]
          },
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
          # 2・3着共通条件
          {
            or: [
              {
                '<=': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 2 },
                ]
              },
            ],
          },
          # /2・3着共通条件
        ]
      },
      odds_select_condition: {
        and: [
          {
            '>=': [
              { item: :itself, attribute: :ratio },
              { item: :literal, value: 100 }
            ]
          },
          {
            '<=': [
              { item: :itself, attribute: :ratio },
              { item: :literal, value: 300 }
            ]
          }
        ]
      }
    },
    {
      id: 5,
      name: '2コース差し',
      race_select_condition: {
        and: [
          # レース絞り込み共通条件
          {
            or: [
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'NO_GRADE' },
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'G3' },
                ]
              },
            ],
          },
          {
            '==': [
              { item: :itself, attribute: :is_special_race },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_selection_race },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_semifinal },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_final },
              { item: :literal, value: false },
            ]
          },
          {
            '!=': [
              { item: :itself, attribute: :stadium_tel_code },
              { item: :literal, value: 3 },
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :race_number },
              { item: :literal, value: 10 },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :absent_race_entries_count },
              { item: :literal, value: 0 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_first },
              { item: :literal, value: 6.6 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_mean },
              { item: :literal, value: 6 }
            ]
          },
          # /レース絞り込み共通条件
          {
            '<': [
              { item: :pit_number_2, attribute: :nigashi_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.48 }
            ]
          },
          {
            or: [
              {
                '<': [
                  { item: :pit_number_1, attribute: :nige_succeed_rate_on_start_course_in_exhibition },
                  { item: :literal, value: 0.65 }
                ]
              },
              {
                and: [
                  {
                    '>=': [
                      { item: :pit_number_1, attribute: :flying_count_in_current_rating_term },
                      { item: :literal, value: 1 }
                    ]
                  },
                  {
                    '<': [
                      { item: :pit_number_1, attribute: :performance_score },
                      { item: :literal, value: 9 }
                    ]
                  },
                ],
              },
            ]
          },
          {
            '>=': [
              { item: :pit_number_1, attribute: :sasare_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.3 }
            ]
          },
          {
            '<=': [
              { item: :pit_number_1, attribute: :makurare_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.15 }
            ]
          },
          {
            '>=': [
              { item: :pit_number_2, attribute: :sashi_succeed_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.1 }
            ]
          },
          {
            '==': [
              { item: :pit_number_1, attribute: :course_number_in_exhibition },
              { item: :literal, value: 1 }
            ]
          },
          {
            '==': [
              { item: :pit_number_2, attribute: :course_number_in_exhibition },
              { item: :literal, value: 2 }
            ]
          },
          {
            '>=': [
              { item: :pit_number_5, attribute: :course_number_in_exhibition },
              { item: :literal, value: 4 }
            ]
          },
          {
            '>=': [
              { item: :pit_number_6, attribute: :course_number_in_exhibition },
              { item: :literal, value: 4 }
            ]
          },
          {
            '>=': [
              { item: :pit_number_1, attribute: :quinella_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.35 }
            ]
          },
          {
            '>=': [
              { item: :pit_number_1, attribute: :base_point_as_first },
              { item: :literal, value: 8 }
            ]
          },
          {
            '<=': [
              { item: :pit_number_1, attribute: :base_point_as_first },
              { item: :literal, value: 18 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_sd },
              { item: :literal, value: 1.7 }
            ]
          },
          {
            '<': [
              { item: :pit_number_5, attribute: :base_point_as_first },
              { item: :literal, value: 16 }
            ]
          },
          {
            '<': [
              { item: :pit_number_6, attribute: :base_point_as_first },
              { item: :literal, value: 16 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :nige_succeed_rate_of_stadium_in_current_weather_condition },
              { item: :literal, value: 0.50 }
            ]
          },
        ]
      },
      first_place_select_condition: {
        and: [
          {
            '==': [
              { item: :itself, attribute: :pit_number },
              { item: :literal, value: 2 }
            ]
          },
          {
            '>=': [
              { item: :itself, attribute: :base_point_as_first },
              { item: :literal, value: 8 }
            ]
          },
          # 1着絞り込み共通条件
          {
            or: [
              {
                '<': [
                  { item: :race, attribute: :day_count_in_event },
                  { item: :literal, value: 4 },
                ]
              },
              {
                or: [
                  {
                    '<': [
                      { item: :itself, attribute: :order_of_arrival_average_in_current_series },
                      { item: :literal, value: 5 },
                    ]
                  },
                  {
                    '>': [
                      { item: :itself, attribute: :order_of_arrival_stdev_in_current_series },
                      { item: :literal, value: 1 },
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '<=': [
                      { item: :itself, attribute: :order_of_arrival_average_in_current_series },
                      { item: :literal, value: 4 },
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :start_order_average_in_current_series },
                      { item: :literal, value: 3.75 },
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :start_time_stdev_in_current_series },
                      { item: :literal, value: 0.125 },
                    ]
                  },
                ]
              },
            ],
          },
          {
            or: [
              {
                '==': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 1 },
                ]
              },
              {
                '>=': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  {
                    '-': [
                      { item: :race, attribute: :winning_rate_in_all_stadium_mean },
                      { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                    ]
                  },
                ]
              },
            ],
          },
          {
            '<=': [
              { item: :itself, attribute: :flying_count_in_current_rating_term },
              { item: :literal, value: 1 }
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :flying_count_in_current_series },
              { item: :literal, value: 0 }
            ]
          },
          # /1着絞り込み共通条件
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
        ]
      },
      second_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 1 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 10 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 10 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 9 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 5 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 8 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 6 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 8 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :course_number_in_exhibition },
                      { item: :literal, value: 5 }
                    ]
                  },
                ],
              },
            ]
          },
          # 2着絞り込み共通条件
          {
            or: [
              {
                '<': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>=': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  {
                    '-': [
                      { item: :race, attribute: :winning_rate_in_all_stadium_mean },
                      { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                    ]
                  },
                ]
              },
            ],
          },
          # /2着絞り込み共通条件
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
          # 2・3着共通条件
          {
            or: [
              {
                '<=': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 2 },
                ]
              },
            ],
          },
          # /2・3着共通条件
        ]
      },
      third_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 1 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 10 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 10 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 9 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 5 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 8 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 6 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 8 }
                    ]
                  },
                ],
              },
            ]
          },
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
          # 2・3着共通条件
          {
            or: [
              {
                '<=': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 2 },
                ]
              },
            ],
          },
          # /2・3着共通条件
        ]
      },
      odds_select_condition: {
        and: [
          {
            or: [
              {
                '==': [
                  { item: :itself, attribute: :second },
                  { item: :literal, value: 1 }
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :third },
                  { item: :literal, value: 1 }
                ]
              },
            ],
          },
          {
            '>=': [
              { item: :itself, attribute: :ratio },
              { item: :literal, value: 20 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :ratio },
              { item: :literal, value: 50 }
            ]
          }
        ]
      }
    },
    {
      id: 6,
      name: '安定版着用の荒れ水面',
      race_select_condition: {
        and: [
          # レース絞り込み共通条件
          {
            or: [
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'NO_GRADE' },
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'G3' },
                ]
              },
            ],
          },
          {
            '==': [
              { item: :itself, attribute: :is_special_race },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_selection_race },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_semifinal },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_final },
              { item: :literal, value: false },
            ]
          },
          {
            '!=': [
              { item: :itself, attribute: :stadium_tel_code },
              { item: :literal, value: 3 },
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :race_number },
              { item: :literal, value: 10 },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :absent_race_entries_count },
              { item: :literal, value: 0 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_first },
              { item: :literal, value: 6.8 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_mean },
              { item: :literal, value: 6 }
            ]
          },
          # /レース絞り込み共通条件
          {
            '==': [
              { item: :pit_number_1, attribute: :course_number_in_exhibition },
              { item: :literal, value: 1 }
            ]
          },
          {
            '<=': [
              { item: :itself, attribute: :nige_succeed_rate_of_stadium_in_current_weather_condition },
              { item: :literal, value: 0.44 }
            ]
          },
          {
            '<': [
              { item: :pit_number_1, attribute: :nige_succeed_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.65 }
            ]
          },
          {
            '<': [
              { item: :pit_number_2, attribute: :nigashi_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.48 }
            ]
          },
          {
            or: [
              {
                '>=': [
                  { item: :pit_number_1, attribute: :flying_count_in_current_rating_term },
                  { item: :literal, value: 1 }
                ]
              },
              {
                '>=': [
                  { item: :pit_number_1, attribute: :performance_score },
                  { item: :literal, value: 8 }
                ]
              },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :course_fixed },
              { item: :literal, value: false }
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :use_stabilizer },
              { item: :literal, value: true }
            ]
          },
        ]
      },
      first_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 2 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 8 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 10 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 9 }
                    ]
                  },
                ],
              },
            ]
          },
          # 1着絞り込み共通条件
          {
            or: [
              {
                '<': [
                  { item: :race, attribute: :day_count_in_event },
                  { item: :literal, value: 4 },
                ]
              },
              {
                or: [
                  {
                    '<': [
                      { item: :itself, attribute: :order_of_arrival_average_in_current_series },
                      { item: :literal, value: 5 },
                    ]
                  },
                  {
                    '>': [
                      { item: :itself, attribute: :order_of_arrival_stdev_in_current_series },
                      { item: :literal, value: 1 },
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '<=': [
                      { item: :itself, attribute: :order_of_arrival_average_in_current_series },
                      { item: :literal, value: 4 },
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :start_order_average_in_current_series },
                      { item: :literal, value: 3.75 },
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :start_time_stdev_in_current_series },
                      { item: :literal, value: 0.125 },
                    ]
                  },
                ]
              },
            ],
          },
          {
            or: [
              {
                '==': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 1 },
                ]
              },
              {
                '>=': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  {
                    '-': [
                      { item: :race, attribute: :winning_rate_in_all_stadium_mean },
                      { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                    ]
                  },
                ]
              },
            ],
          },
          {
            '<=': [
              { item: :itself, attribute: :flying_count_in_current_rating_term },
              { item: :literal, value: 1 }
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :flying_count_in_current_series },
              { item: :literal, value: 0 }
            ]
          },
          # /1着絞り込み共通条件
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
        ]
      },
      second_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 2 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 9 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.3 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 8 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.1 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 8 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.1 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 5 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 9 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.09 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 6 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 8 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.05 }
                    ]
                  },
                ],
              },
            ]
          },
          # 2着絞り込み共通条件
          {
            or: [
              {
                '<': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>=': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  {
                    '-': [
                      { item: :race, attribute: :winning_rate_in_all_stadium_mean },
                      { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                    ]
                  },
                ]
              },
            ],
          },
          # /2着絞り込み共通条件
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
          # 2・3着共通条件
          {
            or: [
              {
                '<=': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 2 },
                ]
              },
            ],
          },
          # /2・3着共通条件
        ]
      },
      third_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 1 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 10 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :third_place_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.6 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 8 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.1 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 8 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.1 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 5 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 9 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.09 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 6 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :performance_score },
                      { item: :literal, value: 8 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.05 }
                    ]
                  },
                ],
              },
            ]
          },
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
          # 2・3着共通条件
          {
            or: [
              {
                '<=': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 2 },
                ]
              },
            ],
          },
          # /2・3着共通条件
        ]
      },
      odds_select_condition: {
        and: [
          {
            or: [
              {
                '>=': [
                  { item: :race, attribute: :best_performance_score_pit_number },
                  { item: :literal, value: 5 },
                ]
              },
              {
                '<=': [
                  { item: :race, attribute: :performance_score_first },
                  { item: :literal, value: 14 },
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :first },
                  { item: :race, attribute: :best_performance_score_pit_number },
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :second },
                  { item: :race, attribute: :best_performance_score_pit_number },
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :third },
                  { item: :race, attribute: :best_performance_score_pit_number },
                ]
              },
            ],
          },
          {
            '>=': [
              { item: :itself, attribute: :ratio },
              { item: :literal, value: 100 }
            ]
          },
          {
            '<=': [
              { item: :itself, attribute: :ratio },
              { item: :literal, value: 300 }
            ]
          }
        ]
      }
    },
    {
      id: 7,
      name: '前付けでの波乱狙い',
      race_select_condition: {
        and: [
          # レース絞り込み共通条件
          {
            or: [
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'NO_GRADE' },
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'G3' },
                ]
              },
            ],
          },
          {
            '==': [
              { item: :itself, attribute: :is_special_race },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_selection_race },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_semifinal },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_final },
              { item: :literal, value: false },
            ]
          },
          {
            '!=': [
              { item: :itself, attribute: :stadium_tel_code },
              { item: :literal, value: 3 },
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :race_number },
              { item: :literal, value: 10 },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :absent_race_entries_count },
              { item: :literal, value: 0 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_first },
              { item: :literal, value: 6.6 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_mean },
              { item: :literal, value: 6 }
            ]
          },
          # /レース絞り込み共通条件
          {
            '<=': [
              { item: :itself, attribute: :nige_succeed_rate_of_stadium_in_current_weather_condition },
              { item: :literal, value: 0.5 }
            ]
          },
          {
            or: [
              {
                '<': [
                  { item: :pit_number_1, attribute: :nige_succeed_rate_on_start_course_in_exhibition },
                  { item: :literal, value: 0.6 }
                ]
              },
              {
                and: [
                  {
                    '>=': [
                      { item: :pit_number_1, attribute: :flying_count_in_current_rating_term },
                      { item: :literal, value: 1 }
                    ]
                  },
                  {
                    '<': [
                      { item: :pit_number_1, attribute: :nige_succeed_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.65 }
                    ]
                  },
                ]
              },
            ],
          },
          {
            '<': [
              {
                '+': [
                  {
                    '*': [
                      { item: :pit_number_1, attribute: :first_place_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 10 },
                    ]
                  },
                  {
                    '+': [
                      {
                        '-': [
                          { item: :literal, value: 7 },
                          { item: :pit_number_1, attribute: :motor_quinella_rate_rank },
                        ]
                      },
                      {
                        '-': [
                          { item: :literal, value: 7 },
                          { item: :pit_number_1, attribute: :exhibition_time_order },
                        ]
                      },
                    ]
                  }
                ]
              },
              { item: :literal, value: 11 },
            ]
          },
          {
            or: [
              {
                and: [
                  {
                    '<=': [
                      { item: :pit_number_4, attribute: :course_number_in_exhibition },
                      { item: :literal, value: 2 },
                    ]
                  },
                  {
                    '<=': [
                      {
                        '+': [
                          {
                            '*': [
                              { item: :pit_number_4, attribute: :first_place_rate_on_start_course_in_exhibition },
                              { item: :literal, value: 10 },
                            ]
                          },
                          {
                            '+': [
                              {
                                '-': [
                                  { item: :literal, value: 7 },
                                  { item: :pit_number_4, attribute: :motor_quinella_rate_rank },
                                ]
                              },
                              {
                                '-': [
                                  { item: :literal, value: 7 },
                                  { item: :pit_number_4, attribute: :exhibition_time_order },
                                ]
                              },
                            ]
                          }
                        ]
                      },
                      { item: :literal, value: 10 },
                    ]
                  },
                ]
              },
              {
                and: [
                  {
                    '<=': [
                      { item: :pit_number_5, attribute: :course_number_in_exhibition },
                      { item: :literal, value: 2 },
                    ]
                  },
                  {
                    '<=': [
                      {
                        '+': [
                          {
                            '*': [
                              { item: :pit_number_5, attribute: :first_place_rate_on_start_course_in_exhibition },
                              { item: :literal, value: 10 },
                            ]
                          },
                          {
                            '+': [
                              {
                                '-': [
                                  { item: :literal, value: 7 },
                                  { item: :pit_number_5, attribute: :motor_quinella_rate_rank },
                                ]
                              },
                              {
                                '-': [
                                  { item: :literal, value: 7 },
                                  { item: :pit_number_5, attribute: :exhibition_time_order },
                                ]
                              },
                            ]
                          }
                        ]
                      },
                      { item: :literal, value: 10 },
                    ]
                  },
                ]
              },
              {
                and: [
                  {
                    '<=': [
                      { item: :pit_number_6, attribute: :course_number_in_exhibition },
                      { item: :literal, value: 2 },
                    ]
                  },
                  {
                    '<=': [
                      {
                        '+': [
                          {
                            '*': [
                              { item: :pit_number_6, attribute: :first_place_rate_on_start_course_in_exhibition },
                              { item: :literal, value: 10 },
                            ]
                          },
                          {
                            '+': [
                              {
                                '-': [
                                  { item: :literal, value: 7 },
                                  { item: :pit_number_6, attribute: :motor_quinella_rate_rank },
                                ]
                              },
                              {
                                '-': [
                                  { item: :literal, value: 7 },
                                  { item: :pit_number_6, attribute: :exhibition_time_order },
                                ]
                              },
                            ]
                          }
                        ]
                      },
                      { item: :literal, value: 10 },
                    ]
                  },
                ]
              },
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_sd },
              { item: :literal, value: 1.5 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_first },
              { item: :literal, value: 6.5 }
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :winning_rate_in_all_stadium_mean },
              { item: :literal, value: 6.5 }
            ]
          },
        ],
      },
      first_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 2 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_first },
                      { item: :literal, value: 10 }
                    ]
                  },
                ]
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_first },
                      { item: :literal, value: 9 }
                    ]
                  },
                ]
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_first },
                      { item: :literal, value: 10 }
                    ]
                  },
                ]
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 5 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_first },
                      { item: :literal, value: 9 }
                    ]
                  },
                ]
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 6 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_first },
                      { item: :literal, value: 10 }
                    ]
                  },
                ]
              },
            ],
          },
          {
            '>=': [
              { item: :itself, attribute: :course_number_in_exhibition },
              { item: :literal, value: 3 }
            ]
          },
          {
            '<=': [
              { item: :itself, attribute: :course_number_in_exhibition },
              { item: :literal, value: 5 }
            ]
          },
          # 1着絞り込み共通条件
          {
            or: [
              {
                '<': [
                  { item: :race, attribute: :day_count_in_event },
                  { item: :literal, value: 4 },
                ]
              },
              {
                or: [
                  {
                    '<': [
                      { item: :itself, attribute: :order_of_arrival_average_in_current_series },
                      { item: :literal, value: 5 },
                    ]
                  },
                  {
                    '>': [
                      { item: :itself, attribute: :order_of_arrival_stdev_in_current_series },
                      { item: :literal, value: 1 },
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '<=': [
                      { item: :itself, attribute: :order_of_arrival_average_in_current_series },
                      { item: :literal, value: 4 },
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :start_order_average_in_current_series },
                      { item: :literal, value: 3.75 },
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :start_time_stdev_in_current_series },
                      { item: :literal, value: 0.125 },
                    ]
                  },
                ]
              },
            ],
          },
          {
            or: [
              {
                '==': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 1 },
                ]
              },
              {
                '>=': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  {
                    '-': [
                      { item: :race, attribute: :winning_rate_in_all_stadium_mean },
                      { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                    ]
                  },
                ]
              },
            ],
          },
          {
            '<=': [
              { item: :itself, attribute: :flying_count_in_current_rating_term },
              { item: :literal, value: 1 }
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :flying_count_in_current_series },
              { item: :literal, value: 0 }
            ]
          },
          # /1着絞り込み共通条件
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
        ]
      },
      second_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 1 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 13 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 2 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 11 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 9 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 9.5 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 5 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 8.5 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 6 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_second },
                      { item: :literal, value: 12 }
                    ]
                  },
                ],
              },
            ]
          },
          # 2着絞り込み共通条件
          {
            or: [
              {
                '<': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>=': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  {
                    '-': [
                      { item: :race, attribute: :winning_rate_in_all_stadium_mean },
                      { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                    ]
                  },
                ]
              },
            ],
          },
          # /2着絞り込み共通条件
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
          # 2・3着共通条件
          {
            or: [
              {
                '<=': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 2 },
                ]
              },
            ],
          },
          # /2・3着共通条件
        ]
      },
      third_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 1 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 9.5 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 2 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 12 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 12 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 10.5 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 5 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 10.5 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 6 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :base_point_as_third },
                      { item: :literal, value: 10 }
                    ]
                  },
                ],
              },
            ]
          },
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
          # 2・3着共通条件
          {
            or: [
              {
                '<=': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 2 },
                ]
              },
            ],
          },
          # /2・3着共通条件
        ]
      },
      odds_select_condition: {
        and: [
          {
            or: [
              {
                '>=': [
                  { item: :race, attribute: :best_performance_score_pit_number },
                  { item: :literal, value: 5 },
                ]
              },
              {
                '<=': [
                  { item: :race, attribute: :performance_score_first },
                  { item: :literal, value: 14 },
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :first },
                  { item: :race, attribute: :best_performance_score_pit_number },
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :second },
                  { item: :race, attribute: :best_performance_score_pit_number },
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :third },
                  { item: :race, attribute: :best_performance_score_pit_number },
                ]
              },
            ],
          },
          {
            '>=': [
              { item: :itself, attribute: :ratio },
              { item: :literal, value: 100 }
            ]
          },
          {
            '<=': [
              { item: :itself, attribute: :ratio },
              { item: :literal, value: 300 }
            ]
          }
        ]
      }
    },
    {
      id: 8,
      name: '強風（安定板なし）',
      race_select_condition: {
        and: [
          # レース絞り込み共通条件
          {
            or: [
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'NO_GRADE' },
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :series_grade },
                  { item: :literal, value: 'G3' },
                ]
              },
            ],
          },
          {
            '==': [
              { item: :itself, attribute: :is_special_race },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_selection_race },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_semifinal },
              { item: :literal, value: false },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :is_final },
              { item: :literal, value: false },
            ]
          },
          {
            '!=': [
              { item: :itself, attribute: :stadium_tel_code },
              { item: :literal, value: 3 },
            ]
          },
          {
            '<': [
              { item: :itself, attribute: :race_number },
              { item: :literal, value: 10 },
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :absent_race_entries_count },
              { item: :literal, value: 0 }
            ]
          },
          # /レース絞り込み共通条件
          {
            '>': [
              { item: :itself, attribute: :wind_velocity_when_exhibition },
              { item: :literal, value: 4 }
            ]
          },
          {
            '<=': [
              { item: :itself, attribute: :nige_succeed_rate_of_stadium_in_current_weather_condition },
              { item: :literal, value: 0.45 }
            ]
          },
          {
            '>=': [
              { item: :itself, attribute: :makurare_rate_of_stadium_in_current_weather_condition },
              { item: :literal, value: 0.18 }
            ]
          },
          {
            or: [
              {
                '<': [
                  { item: :pit_number_1, attribute: :nige_succeed_rate_on_start_course_in_exhibition },
                  { item: :literal, value: 0.6 }
                ]
              },
              {
                and: [
                  {
                    '>=': [
                      { item: :pit_number_1, attribute: :flying_count_in_current_rating_term },
                      { item: :literal, value: 1 }
                    ]
                  },
                  {
                    '<': [
                      { item: :pit_number_1, attribute: :nige_succeed_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.65 }
                    ]
                  },
                ]
              },
            ],
          },
          {
            '>=': [
              { item: :pit_number_1, attribute: :makurare_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.15 }
            ]
          },
          {
            '<': [
              { item: :pit_number_2, attribute: :nigashi_rate_on_start_course_in_exhibition },
              { item: :literal, value: 0.48 }
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :course_fixed },
              { item: :literal, value: false }
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :use_stabilizer },
              { item: :literal, value: false }
            ]
          },
        ]
      },
      first_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 2 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 11 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 11 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 12 }
                    ]
                  },
                ],
              },
            ]
          },
          # 1着絞り込み共通条件
          {
            or: [
              {
                '<': [
                  { item: :race, attribute: :day_count_in_event },
                  { item: :literal, value: 4 },
                ]
              },
              {
                or: [
                  {
                    '<': [
                      { item: :itself, attribute: :order_of_arrival_average_in_current_series },
                      { item: :literal, value: 5 },
                    ]
                  },
                  {
                    '>': [
                      { item: :itself, attribute: :order_of_arrival_stdev_in_current_series },
                      { item: :literal, value: 1 },
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '<=': [
                      { item: :itself, attribute: :order_of_arrival_average_in_current_series },
                      { item: :literal, value: 4 },
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :start_order_average_in_current_series },
                      { item: :literal, value: 3.75 },
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :start_time_stdev_in_current_series },
                      { item: :literal, value: 0.125 },
                    ]
                  },
                ]
              },
            ],
          },
          {
            or: [
              {
                '==': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 1 },
                ]
              },
              {
                '>=': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  {
                    '-': [
                      { item: :race, attribute: :winning_rate_in_all_stadium_mean },
                      { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                    ]
                  },
                ]
              },
            ],
          },
          {
            '<=': [
              { item: :itself, attribute: :flying_count_in_current_rating_term },
              { item: :literal, value: 1 }
            ]
          },
          {
            '==': [
              { item: :itself, attribute: :flying_count_in_current_series },
              { item: :literal, value: 0 }
            ]
          },
          # /1着絞り込み共通条件
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
        ]
      },
      second_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 2 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 13 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.3 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 13 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.1 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 13 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.1 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 5 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 12 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.09 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 6 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 13 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.05 }
                    ]
                  },
                ],
              },
            ]
          },
          # 2着絞り込み共通条件
          {
            or: [
              {
                '<': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>=': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  {
                    '-': [
                      { item: :race, attribute: :winning_rate_in_all_stadium_mean },
                      { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                    ]
                  },
                ]
              },
            ],
          },
          # /2着絞り込み共通条件
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
          # 2・3着共通条件
          {
            or: [
              {
                '<=': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 2 },
                ]
              },
            ],
          },
          # /2・3着共通条件
        ]
      },
      third_place_select_condition: {
        and: [
          {
            or: [
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 1 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :trio_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.6 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 2 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 13 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.1 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 3 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 13 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.1 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 4 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 13 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.1 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 5 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 12 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.09 }
                    ]
                  },
                ],
              },
              {
                and: [
                  {
                    '==': [
                      { item: :itself, attribute: :pit_number },
                      { item: :literal, value: 6 }
                    ]
                  },
                  {
                    '<=': [
                      { item: :itself, attribute: :order_sum },
                      { item: :literal, value: 13 }
                    ]
                  },
                  {
                    '>=': [
                      { item: :itself, attribute: :quinella_rate_on_start_course_in_exhibition },
                      { item: :literal, value: 0.05 }
                    ]
                  },
                ],
              },
            ]
          },
          # 全着順絞り込み共通条件
          {
            or: [
              {
                '<=': [
                  { item: :race, attribute: :winning_rate_in_all_stadium_sd },
                  { item: :literal, value: 1.5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 1.75 },
                ]
              },
            ],
          },
          # /全着順絞り込み共通条件
          # 2・3着共通条件
          {
            or: [
              {
                '<=': [
                  { item: :itself, attribute: :course_number_in_exhibition },
                  { item: :literal, value: 5 },
                ]
              },
              {
                '>': [
                  { item: :itself, attribute: :winning_rate_in_all_stadium },
                  { item: :literal, value: 2 },
                ]
              },
            ],
          },
          # /2・3着共通条件
        ]
      },
      odds_select_condition: {
        and: [
          {
            or: [
              {
                '>=': [
                  { item: :race, attribute: :best_performance_score_pit_number },
                  { item: :literal, value: 5 },
                ]
              },
              {
                '<=': [
                  { item: :race, attribute: :performance_score_first },
                  { item: :literal, value: 14 },
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :first },
                  { item: :race, attribute: :best_performance_score_pit_number },
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :second },
                  { item: :race, attribute: :best_performance_score_pit_number },
                ]
              },
              {
                '==': [
                  { item: :itself, attribute: :third },
                  { item: :race, attribute: :best_performance_score_pit_number },
                ]
              },
            ],
          },
          {
            '>=': [
              { item: :itself, attribute: :ratio },
              { item: :literal, value: 100 }
            ]
          },
          {
            '<=': [
              { item: :itself, attribute: :ratio },
              { item: :literal, value: 300 }
            ]
          }
        ]
      }
    },
  ]
)

ForecastersForecastingPattern.create(
  id: 1,
  forecaster_id: 1,
  forecasting_pattern_id: 1,
  budget_amount_per_race: 50_000,
  fund_allocation_method: FundAllocationMethod::ID::CANCEL_IF_OVER_BUDGET,
  composition_odds: 7.0,
)

ForecastersForecastingPattern.create(
  id: 2,
  forecaster_id: 1,
  forecasting_pattern_id: 2,
  budget_amount_per_race: 50_000,
  fund_allocation_method: FundAllocationMethod::ID::CANCEL_IF_OVER_BUDGET,
  composition_odds: 7.0,
)

ForecastersForecastingPattern.create(
  id: 3,
  forecaster_id: 1,
  forecasting_pattern_id: 3,
  budget_amount_per_race: 50_000,
  fund_allocation_method: FundAllocationMethod::ID::CANCEL_IF_OVER_BUDGET,
  composition_odds: 7.0,
)

ForecastersForecastingPattern.create(
  id: 4,
  forecaster_id: 1,
  forecasting_pattern_id: 4,
  budget_amount_per_race: 50_000,
  fund_allocation_method: FundAllocationMethod::ID::CANCEL_IF_OVER_BUDGET,
  composition_odds: 7.0,
)

ForecastersForecastingPattern.create(
  id: 5,
  forecaster_id: 1,
  forecasting_pattern_id: 5,
  budget_amount_per_race: 50_000,
  fund_allocation_method: FundAllocationMethod::ID::CANCEL_IF_OVER_BUDGET,
  composition_odds: 7.0,
)

ForecastersForecastingPattern.create(
  id: 6,
  forecaster_id: 1,
  forecasting_pattern_id: 6,
  budget_amount_per_race: 50_000,
  fund_allocation_method: FundAllocationMethod::ID::CANCEL_IF_OVER_BUDGET,
  composition_odds: 7.0,
)

ForecastersForecastingPattern.create(
  id: 7,
  forecaster_id: 1,
  forecasting_pattern_id: 7,
  budget_amount_per_race: 50_000,
  fund_allocation_method: FundAllocationMethod::ID::CANCEL_IF_OVER_BUDGET,
  composition_odds: 7.0,
)

ForecastersForecastingPattern.create(
  id: 8,
  forecaster_id: 1,
  forecasting_pattern_id: 8,
  budget_amount_per_race: 50_000,
  fund_allocation_method: FundAllocationMethod::ID::CANCEL_IF_OVER_BUDGET,
  composition_odds: 7.0,
)
