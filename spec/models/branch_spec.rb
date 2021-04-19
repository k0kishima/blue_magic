require 'rails_helper'

RSpec.describe Branch, type: :model do
  describe 'validation' do
    subject { branch }

    context 'when prefecture id of which does not exist stadium given ' do
      let(:branch) { Branch.new(prefecture_id: 1) }

      it { is_expected.to be_invalid }
    end

    context 'when prefecture id of which exist stadium given ' do
      let(:branch) { Branch.new(prefecture_id: 13) }

      it { is_expected.to be_valid }
    end
  end

  describe '.all' do
    subject { described_class.all }

    it 'returns all branch' do
      expect(subject.map(&:name)).to eq [
        "群馬支部", "埼玉支部", "東京支部",
        "静岡支部", "愛知支部", "三重支部",
        "福井支部", "滋賀支部",
        "大阪支部", "兵庫支部",
        "徳島支部", "香川支部",
        "岡山支部", "広島支部", "山口支部",
        "福岡支部", "佐賀支部", "長崎支部"
      ]
    end
  end
end
