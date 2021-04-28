RSpec.shared_context 'with an unavailable official website proxy', shared_context: :metadata do
  before do
    open_uri_mock = class_double(OpenURI)
    stub_const('OpenURI', open_uri_mock)
    allow(open_uri_mock).to receive(:open_uri).and_raise(Errno::ECONNREFUSED)
  end
end
