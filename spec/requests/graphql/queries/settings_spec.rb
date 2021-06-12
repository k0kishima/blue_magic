require 'rails_helper'

describe 'graphql settingQuery', type: :request do
  subject { post graphql_path, params: { query: query } }

  let(:query) do
    <<~QUERY
      {
        settings {
          var
          value
        }
      }
    QUERY
  end

  before do
    allow_any_instance_of(Setting).to receive(:value).and_return(true)
  end

  it 'returns all settings' do
    subject
    json_response = JSON.parse(response.body)
    expect(json_response['data']['settings']).to contain_exactly(
      {
        "var" => "voting_enable",
        "value" => true
      },
      {
        "var" => "crawling_enable",
        "value" => true
      }
    )
  end
end
