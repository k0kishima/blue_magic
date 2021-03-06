require 'rails_helper'

describe OfficialWebsite::CrawlRaceExhibitionInformationsJob, type: :job do
  include_context 'with a mocked slack client'

  describe '#perform_now' do
    context 'when use version "1707"' do
      let(:version) { '1707' }

      context 'when all entries had done exhibition normally' do
        subject do
          VCR.use_cassette 'official_web_site_proxy/v1707/race_exhibition_informations/04_20210424_1R' do
            described_class.perform_now(
              stadium_tel_code: stadium_tel_code, race_opened_on: race_opened_on, race_number: race_number,
              version: version
            )
          end
        end

        let(:stadium_tel_code) { 4 }
        let(:race_opened_on) { Date.new(2021, 4, 24) }
        let(:race_number) { 1 }

        it 'saves start exhibition records' do
          expect { subject }.to change { StartExhibitionRecord.count }.by(6)
          expect(StartExhibitionRecord.all).to contain_exactly(
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              pit_number: 1,
              course_number: 1,
              start_time: 0.01,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              pit_number: 2,
              course_number: 2,
              start_time: 0.09,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              pit_number: 3,
              course_number: 3,
              start_time: 0.12,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              pit_number: 4,
              course_number: 4,
              start_time: 0.04,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              pit_number: 5,
              course_number: 5,
              start_time: -0.12,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              pit_number: 6,
              course_number: 6,
              start_time: -0.04,
            ),
          )
        end

        it 'saves circumference exhibition records' do
          expect { subject }.to change { CircumferenceExhibitionRecord.count }.by(6)
          expect(CircumferenceExhibitionRecord.all).to contain_exactly(
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              pit_number: 1,
              exhibition_time: 6.82,
              exhibition_time_order: 4,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              pit_number: 2,
              exhibition_time: 6.78,
              exhibition_time_order: 2,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              pit_number: 3,
              exhibition_time: 6.73,
              exhibition_time_order: 1,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              pit_number: 4,
              exhibition_time: 6.78,
              exhibition_time_order: 2,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              pit_number: 5,
              exhibition_time: 6.89,
              exhibition_time_order: 6,
            ),
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              pit_number: 6,
              exhibition_time: 6.82,
              exhibition_time_order: 4,
            ),
          )
        end

        it 'saves racer conditions' do
          expect { subject }.to change { RacerCondition.count }.by(6)
          expect(RacerCondition.all).to contain_exactly(
            have_attributes(
              racer_registration_number: 3306,
              date: race_opened_on,
              weight: 54.0,
              adjust: 0.0,
            ),
            have_attributes(
              racer_registration_number: 4496,
              date: race_opened_on,
              weight: 52.0,
              adjust: 0.0,
            ),
            have_attributes(
              racer_registration_number: 4752,
              date: race_opened_on,
              weight: 51.0,
              adjust: 1.0,
            ),
            have_attributes(
              racer_registration_number: 4785,
              date: race_opened_on,
              weight: 52.1,
              adjust: 0.0,
            ),
            have_attributes(
              racer_registration_number: 4945,
              date: race_opened_on,
              weight: 51.0,
              adjust: 1.0,
            ),
            have_attributes(
              racer_registration_number: 5019,
              date: race_opened_on,
              weight: 44.5,
              adjust: 2.5,
            ),
          )
        end

        it 'saves weather conditions in exhibition races' do
          expect { subject }.to change { WeatherCondition.count }.by(1)
          expect(WeatherCondition.all).to contain_exactly(
            have_attributes(
              stadium_tel_code: stadium_tel_code,
              date: race_opened_on,
              race_number: race_number,
              in_performance: false,
              weather: 'cloudy',
              wind_velocity: 5.0,
              wind_angle: 45.0,
              wavelength: 3.0,
              air_temperature: 19.0,
              water_temperature: 17.0,
            )
          )
        end
      end

      context 'when all entries had not done exhibition normally' do
        context 'when someone had been lateness' do
          subject do
            VCR.use_cassette 'official_web_site_proxy/v1707/race_exhibition_informations/17_20170511_2R' do
              described_class.perform_now(
                stadium_tel_code: stadium_tel_code, race_opened_on: race_opened_on, race_number: race_number,
                version: version
              )
            end
          end

          let(:stadium_tel_code) { 17 }
          let(:race_opened_on) { Date.new(2017, 5, 11) }
          let(:race_number) { 2 }

          it 'saves start exhibition records which includes lateness entries' do
            expect { subject }.to change { StartExhibitionRecord.count }.by(6)
            expect(StartExhibitionRecord.all).to contain_exactly(
              have_attributes(:date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                              :pit_number => 1, :course_number => 6, :start_time => 1.01),
              have_attributes(:date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                              :pit_number => 2, :course_number => 1, :start_time => 0.07),
              have_attributes(:date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                              :pit_number => 3, :course_number => 2, :start_time => 0.05),
              have_attributes(:date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                              :pit_number => 4, :course_number => 3, :start_time => 0.17),
              have_attributes(:date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                              :pit_number => 5, :course_number => 4, :start_time => 0.04),
              have_attributes(:date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                              :pit_number => 6, :course_number => 5, :start_time => 0.06)
            )
          end

          it 'saves circumference exhibition records which includes lateness entries' do
            expect { subject }.to change { CircumferenceExhibitionRecord.count }.by(6)
            expect(CircumferenceExhibitionRecord.all).to contain_exactly(
              have_attributes(:date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                              :pit_number => 1, :exhibition_time => 6.65, :exhibition_time_order => 4),
              have_attributes(:date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                              :pit_number => 2, :exhibition_time => 6.54, :exhibition_time_order => 1),
              have_attributes(:date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                              :pit_number => 3, :exhibition_time => 6.59, :exhibition_time_order => 2),
              have_attributes(:date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                              :pit_number => 4, :exhibition_time => 6.64, :exhibition_time_order => 3),
              have_attributes(:date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                              :pit_number => 5, :exhibition_time => 6.66, :exhibition_time_order => 5),
              have_attributes(:date => Date.new(2017, 5, 11), :stadium_tel_code => 17, :race_number => 2,
                              :pit_number => 6, :exhibition_time => 6.69, :exhibition_time_order => 6)
            )
          end
        end

        context 'when someone absent the start exhibition' do
          subject do
            VCR.use_cassette 'official_web_site_proxy/v1707/race_exhibition_informations/06_20170625_10R' do
              described_class.perform_now(
                stadium_tel_code: stadium_tel_code, race_opened_on: race_opened_on, race_number: race_number,
                version: version
              )
            end
          end

          let(:stadium_tel_code) { 6 }
          let(:race_opened_on) { Date.new(2017, 6, 25) }
          let(:race_number) { 10 }

          it 'saves start exhibition records which exclude absented entries' do
            expect { subject }.to change { StartExhibitionRecord.count }.by(5)

            expect(StartExhibitionRecord.all).to contain_exactly(
              have_attributes(:date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                              :pit_number => 1, :course_number => 1, :start_time => 0.02),
              have_attributes(:date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                              :pit_number => 2, :course_number => 2, :start_time => 0.32),
              have_attributes(:date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                              :pit_number => 3, :course_number => 3, :start_time => 0.05),
              have_attributes(:date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                              :pit_number => 4, :course_number => 4, :start_time => 0.19),
              have_attributes(:date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                              :pit_number => 6, :course_number => 5, :start_time => 0.16)
            )
          end

          it 'saves circumference exhibition records which includes absented entries' do
            expect { subject }.to change { CircumferenceExhibitionRecord.count }.by(6)

            expect(CircumferenceExhibitionRecord.all).to contain_exactly(
              have_attributes(:date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                              :pit_number => 1, :exhibition_time => 6.66, :exhibition_time_order => 1),
              have_attributes(:date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                              :pit_number => 2, :exhibition_time => 6.76, :exhibition_time_order => 5),
              have_attributes(:date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                              :pit_number => 3, :exhibition_time => 6.71, :exhibition_time_order => 2),
              have_attributes(:date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                              :pit_number => 4, :exhibition_time => 6.77, :exhibition_time_order => 6),
              have_attributes(:date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                              :pit_number => 5, :exhibition_time => 6.73, :exhibition_time_order => 3),
              have_attributes(:date => Date.new(2017, 6, 25), :stadium_tel_code => 6, :race_number => 10,
                              :pit_number => 6, :exhibition_time => 6.73, :exhibition_time_order => 3)
            )
          end
        end
      end
    end
  end
end
