class Kpi < ApplicationRecord
  attribute :entry_object

  validates :entry_object_class_name, presence: true
  validates :name, presence: true
  validates :attribute_name, presence: true
  validates :entry_object, presence: true, on: :calculation

  # NOTE: カラム名を key にすると SQL の予約語と衝突するのでこのようなゲッターの定義としている
  # ORMでマッピングした場合以下のようなエイリアス指定だとエラーになる
  # alias_method :key, :attribute_name
  def key
    attribute_name
  end

  def value!
    raise NotImplementedError
  end
end

# rubocop:disable Layout/LineLength
# == Schema Information
#
# Table name: kpis
#
#  id                                                                                                                                                                                      :bigint           not null, primary key
#  type                                                                                                                                                                                    :string(255)      not null
#  entry_object_class_name(値の算出をするために利用するオブジェクトのことをentry object と定義し、そのクラス名をここで指定（webpackのエントリーポイントとのアナロジーからこのように命名）) :string(255)      not null
#  name                                                                                                                                                                                    :string(255)      not null
#  description                                                                                                                                                                             :text(65535)
#  attribute_name                                                                                                                                                                          :string(255)      not null
#  created_at                                                                                                                                                                              :datetime         not null
#  updated_at                                                                                                                                                                              :datetime         not null
#
# Indexes
#
#  index_kpis_on_attribute_name  (attribute_name) UNIQUE
#
