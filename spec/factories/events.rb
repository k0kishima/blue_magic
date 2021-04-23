FactoryBot.define do
  factory :event do
    sequence(:stadium_tel_code, (Stadium::TELCODE_RANGE).to_a.cycle)
    title { '帝国金融杯' }
    starts_on { Time.zone.today }
    grade { :g3 }
    kind { :uncategorized }
  end
end

# == Schema Information
#
# Table name: events
#
#  stadium_tel_code :integer          not null, primary key
#  starts_on        :date             not null, primary key
#  title            :string(255)      not null, primary key
#  grade            :integer          not null
#  kind             :integer          not null
#  canceled         :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
