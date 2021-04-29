require 'rails_helper'

describe CsvFactory do
  describe '.create' do
    context 'when a array of hash given' do
      subject { described_class.create!(array_of_hash) }

      context 'when there is no difference in hash structure' do
        let(:array_of_hash) {
          [
            { foo: 1, bar: 2 },
            { foo: 3, bar: 4 },
          ]
        }

        it 'creates csv' do
          csv = subject
          expect(csv.read).to eq "foo,bar\n1,2\n3,4\n"
        end
      end

      context 'when there is difference in hash structure' do
        let(:array_of_hash) {
          [
            { foo: 1, bar: 2 },
            { hoge: 3, bar: 4 },
          ]
        }

        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end

    context 'when some array of hashes given' do
      subject { described_class.create!(*array_of_array_of_hash) }

      context 'when there is no difference in array size' do
        context 'when there is same structure each element' do
          let(:array_of_array_of_hash) {
            [
              [
                { foo: 1, bar: 2 },
                { foo: 3, bar: 4 },
              ],
              [
                { foo: 5, bar: 6 },
                { foo: 7, bar: 8 },
              ]
            ]
          }

          it 'creates csv' do
            csv = subject
            expect(csv.read).to eq "foo,bar\n5,6\n7,8\n"
          end
        end

        context 'when there is not same structure each element' do
          context 'when there is no difference hash structure in one dimensional array' do
            let(:array_of_array_of_hash) {
              [
                [
                  { foo: 1, bar: 2 },
                  { foo: 3, bar: 4 },
                ],
                [
                  { foo: 1, bar: 2, hoge: 3 },
                  { foo: 3, bar: 4, hoge: 4 },
                ]
              ]
            }

            it 'creates csv' do
              csv = subject
              expect(csv.read).to eq "foo,bar,hoge\n1,2,3\n3,4,4\n"
            end
          end

          context 'when there is difference hash structure in one dimensional array' do
            let(:array_of_array_of_hash) {
              [
                [
                  { foo: 1, bar: 2 },
                  { foo: 3, bar: 4 },
                ],
                [
                  { foo: 1, bar: 2, hoge: 3 },
                  { foo: 3, bar: 4, piyo: 4 },  # <- difference
                ]
              ]
            }

            it { expect { subject }.to raise_error(ArgumentError) }
          end
        end
      end

      context 'when there is difference in array size' do
        let(:array_of_array_of_hash) {
          [
            [
              { foo: 1, bar: 2 },
              { foo: 3, bar: 4 },
            ],
            [
              { foo: 1, bar: 2, hoge: 3 },
            ]
          ]
        }

        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end
  end
end
