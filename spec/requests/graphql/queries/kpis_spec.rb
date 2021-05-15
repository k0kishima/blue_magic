require 'rails_helper'

describe 'graphql kpiQuery', type: :request do
  subject { post graphql_path, params: { query: query } }

  let(:kpi1) { Kpi::RaceEntry::NigeSucceedRate.instance }
  let(:kpi2) { Kpi::RaceEntry::MakurareRate.instance }

  before do
    allow(Kpi::Base).to receive(:all).and_return([kpi1, kpi2])
  end

  context 'when any keyword not specified' do
    let(:query) do
      <<~QUERY
        {
          kpis {
            key
            name
            description
            subject
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
          "subject" => "RaceEntry"
        },
        {
          "key" => "makurare_rate",
          "name" => "まくられ率",
          "description" => "1コースから進入し、決まり手が「まくり」で負けたレース数 / 指定したコースで進入したレース数（「まくり」が決まらなかった場合も含む）",
          "subject" => "RaceEntry"
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
            subject
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
          "subject" => "RaceEntry"
        },
      )
    end
  end
end
