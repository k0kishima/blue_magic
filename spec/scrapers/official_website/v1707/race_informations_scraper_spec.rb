require 'rails_helper'

describe OfficialWebsite::V1707::RaceInformationsScraper do
  shared_examples :cacheable do
    it 'データ取得結果をキャッシュすること' do
      expect(subject).to eq scraper.cache
    end
  end

  describe '#scrape!' do
    subject { scraper.scrape! }

    let(:scraper) { described_class.new(file: file) }

    context 'ファイルがセットされているとき' do
      let(:file) { File.new(file_path, 'r') }

      context 'レース情報ページのファイルが引数として渡されたとき' do
        context '進入固定レースではないとき' do
          context '安定板が使用されていないとき' do
            let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/race/2015_10_16_08#_2R.html" }

            it 'レースの概要がパースされること' do
              expect(subject).to eq([{ stadium_tel_code: 8,
                                       date: Date.new(2015, 10, 16),
                                       is_course_fixed: false,
                                       use_stabilizer: false,
                                       deadline: '11:13',
                                       title: '予選',
                                       number: 2,
                                       metre: 1800, }])
            end

            it_behaves_like :cacheable
          end

          context '安定板が使用されているとき' do
            let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/race/2018_03_01_07#_8R.html" }

            it 'レースの概要がパースされること' do
              expect(subject).to eq([{ stadium_tel_code: 7,
                                       date: Date.new(2018, 3, 1),
                                       is_course_fixed: false,
                                       use_stabilizer: true,
                                       deadline: '18:26',
                                       title: '一般戦',
                                       number: 8,
                                       metre: 1800, }])
            end

            it_behaves_like :cacheable
          end
        end

        context '進入固定レースのとき' do
          context '安定板が使用されていないとき' do
            let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/race/2015_11_16_09#_9R.html" }

            it 'レースの概要がパースされること' do
              expect(subject).to eq([{ stadium_tel_code: 9,
                                       date: Date.new(2015, 11, 16),
                                       is_course_fixed: true,
                                       use_stabilizer: false,
                                       deadline: '14:17',
                                       title: '一般',
                                       number: 9,
                                       metre: 1800, }])
            end

            it_behaves_like :cacheable
          end

          context '安定板が使用されているとき' do
            let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/race/2018_03_01_07#_7R.html" }

            it 'レースの概要がパースされること' do
              expect(subject).to eq([{ stadium_tel_code: 7,
                                       date: Date.new(2018, 3, 1),
                                       is_course_fixed: true,
                                       use_stabilizer: true,
                                       deadline: '17:57',
                                       title: '一般戦',
                                       number: 7,
                                       metre: 1800, }])
            end

            it_behaves_like :cacheable
          end
        end
      end

      context 'レース情報ページではないファイルが引数として渡されたとき' do
        let(:file_path) { "#{Rails.root}/spec/fixtures/files/official_website/v1707/racer/4444/profile.html" }

        it 'エラーが発生すること' do
          expect { subject }.to raise_error(StandardError)
        end
      end
    end

    context 'ファイルがセットされていないとき' do
      let(:file) { nil }

      it { expect { subject }.to raise_error(ActiveModel::ValidationError) }
    end
  end
end
