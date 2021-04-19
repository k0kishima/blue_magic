class Racer < ApplicationRecord
  self.primary_key = :registration_number

  enum gender: { male: 1, female: 2, }
  enum status: { active: 1, retired: 2, }

  # NOTE:
  # 基本的に全属性をNOT NULL にすべきだが、
  # 引退したレーサーはそもそもデータが取れない、
  # レコード生成時は時系列的には出走表からパースするが、その時点では氏名や級別などしか取れない
  # などの事情から NULL を許可しているカラムが多い
  validates :registration_number, uniqueness: true
  validates :branch_id, inclusion: { in: Branch.all.map(&:id) }, allow_nil: true
  validates :birth_prefecture_id, inclusion: { in: Prefecture.all.map(&:id) }, allow_nil: true

  def full_name
    @full_name ||= [last_name, first_name].join(' ')
  end
end

# == Schema Information
#
# Table name: racers
#
#  birth_date          :date
#  first_name          :string(255)      default(""), not null
#  gender              :integer
#  height              :integer
#  last_name           :string(255)      default(""), not null
#  registration_number :integer          not null, primary key
#  status              :integer
#  term                :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  birth_prefecture_id :integer
#  branch_id           :integer
#
