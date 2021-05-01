RSpec.shared_context 'with an unavailable official website proxy', shared_context: :metadata do
  before do
    httparty_mock = class_double(HTTParty)
    stub_const('HTTParty', httparty_mock)
    allow(httparty_mock).to receive(:get).and_raise(Errno::ECONNREFUSED)
  end
end
