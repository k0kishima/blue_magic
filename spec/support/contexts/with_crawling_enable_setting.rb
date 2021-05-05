RSpec.shared_context 'with crawling enable setting', shared_context: :metadata do
  before do
    setting_mock = class_double(Setting)
    stub_const('Setting', setting_mock)
    allow(setting_mock).to receive(:crawling_enable).and_return(true)
  end
end
