require 'rails_helper'

describe 'graphql kpiQuery', type: :request do
  subject { post graphql_path, params: { query: query } }

  let(:kpi_class_1) { Kpi::RaceEntry::NigeSucceedRate }
  let(:kpi_class_2) { Kpi::RaceEntry::MakurareRate }

  before do
    allow(Kpi::Base).to receive(:applicable).and_return([kpi_class_1, kpi_class_2])
  end

  context 'when any keyword not specified' do
    let(:query) do
      <<~QUERY
        {
          kpis {
            key
            name
            description
            type
          }
        }
      QUERY
    end

    it 'returns all kpis' do
      subject
      json_response = JSON.parse(response.body)
      expect(json_response['data']['kpis']).to contain_exactly(
        {
          "key" => "nige_succeed_rate",
          "name" => "逃げ成功率",
          "description" => "決まり手「逃げ」での1着回数 / 1コース出走回数",
          "type" => "RaceEntry"
        },
        {
          "key" => "makurare_rate",
          "name" => "まくられ率",
          "description" => "1コースから進入し、決まり手が「まくり」で負けたレース数 / 指定したコースで進入したレース数（「まくり」が決まらなかった場合も含む）",
          "type" => "RaceEntry"
        }
      )
    end
  end

  context 'when a keyword specified' do
    let(:query) do
      <<~QUERY
        {
          kpis(keyword: "#{keyword}") {
            key
            name
            description
            type
          }
        }
      QUERY
    end
    let(:keyword) { '逃げ' }

    it 'returns filtered kpis' do
      subject
      json_response = JSON.parse(response.body)
      expect(json_response['data']['kpis']).to contain_exactly(
        {
          "key" => "nige_succeed_rate",
          "name" => "逃げ成功率",
          "description" => "決まり手「逃げ」での1着回数 / 1コース出走回数",
          "type" => "RaceEntry"
        },
      )
    end
  end
end
