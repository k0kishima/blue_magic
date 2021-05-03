RSpec.shared_context 'with a mocked slack client', shared_context: :metadata do
  before do
    slack_client_instance_mock = double('slack_client_instance_mock')

    stub_const 'ENV', ENV.to_h.tap { |env|
      env['SLACK_OAUTH_ACCESS_TOKEN'] = '*****'
    }

    allow(Slack::Web::Client).to receive(:new).and_return(slack_client_instance_mock)
    allow(slack_client_instance_mock).to receive(:chat_postMessage)
  end
end
