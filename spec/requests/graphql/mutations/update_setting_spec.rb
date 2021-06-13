require 'rails_helper'

describe 'graphql updateSetting mutation', type: :request do
  subject { post graphql_path, params: { query: query, variables: variables }, as: :json }

  let(:query) do
    <<~QUERY
      mutation updateSetting($input: UpdateSettingInput!) {
        updateSetting(input: $input) {
          setting {
            var
            value
          }
        }
      }
    QUERY
  end

  let(:variables) do
    {
      input: {
        var: var,
        value: false
      }
    }
  end

  context 'when specified setting exist' do
    let(:var) { 'voting_enable' }

    before do
      Setting.voting_enable = true
    end

    it 'updates the setting' do
      subject

      expect(Setting.voting_enable).to be false
    end

    it 'returns updated setting' do
      subject
      json_response = JSON.parse(response.body)
      expect(json_response['data']['updateSetting']['setting']).to matching(
        {
          "var" => "voting_enable",
          "value" => false
        },
      )
    end
  end

  context 'when specified setting not exist' do
    let(:var) { 'foobar' }

    it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
  end
end
