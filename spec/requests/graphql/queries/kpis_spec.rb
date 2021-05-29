require 'rails_helper'

describe 'graphql kpiQuery', type: :request do
  subject { post graphql_path, params: { query: query } }

  let(:kpi_1) { Kpi.find_by!(entry_object_class_name: 'Race', attribute_name: 'series_grade') }
  let(:kpi_2) {
    Kpi.find_by!(entry_object_class_name: 'RaceEntry',
                 attribute_name: 'nige_succeed_rate_on_start_course_in_exhibition')
  }

  before do
    allow(Kpi).to receive(:all).and_return([kpi_1, kpi_2])
  end

  let(:query) do
    <<~QUERY
      {
        kpis {
          entryObjectClassName
          key
          name
          description
        }
      }
    QUERY
  end

  it 'returns all kpis' do
    subject
    json_response = JSON.parse(response.body)
    expect(json_response['data']['kpis']).to contain_exactly(
      {
        "entryObjectClassName" => "Race",
        "key" => "series_grade",
        "name" => "グレード",
        "description" => "節のグレード"
      },
      {
        "entryObjectClassName" => "RaceEntry",
        "key" => "nige_succeed_rate_on_start_course_in_exhibition",
        "name" => "逃げ成功率",
        "description" => "決まり手「逃げ」での1着回数 / 1コース出走回数"
      }
    )
  end
end
