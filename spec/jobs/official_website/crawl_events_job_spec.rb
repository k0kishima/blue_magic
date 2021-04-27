require 'rails_helper'

describe OfficialWebsite::CrawlEventsJob, type: :model do
  describe '#perform_now' do
    subject do
      VCR.use_cassette 'official_web_site_proxy/v1707/event_schedule' do
        described_class.perform_now(year: year, month: month, version: version)
      end
    end

    context 'when use version "1707"' do
      let(:version) { "1707" }
      let(:year) { 2021 }
      let(:month) { 4 }

      it 'saves events in specified year and month' do
        expect { subject }.to change { Event.count }.by(74)

        # 件数的に全部チェックは難しいので一部を確認
        expect(Event.all).to include(
          have_attributes(
            stadium_tel_code: 1, starts_on: Date.new(2021, 4, 8), title: '第１４回ドラキリュウカップ・３世代対抗戦',
            grade: 'no_grade', kind: 'uncategorized', canceled: false
          ),
          have_attributes(
            stadium_tel_code: 12, starts_on: Date.new(2021, 4, 1), title: '太閤賞競走開設６５周年記念',
            grade: 'g1', kind: 'uncategorized', canceled: false
          ),
          have_attributes(
            stadium_tel_code: 22, starts_on: Date.new(2021, 4, 1), title: 'ヴィーナスシリーズ第１戦・マクール杯',
            grade: 'no_grade', kind: 'venus', canceled: false
          )
        )
      end
    end
  end
end
