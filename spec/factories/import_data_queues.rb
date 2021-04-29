FactoryBot.define do
  factory :import_data_queue do
    trait :with_sample_csv do
      file { Rack::Test::UploadedFile.new('spec/fixtures/uploadable/documents/sample.csv', 'text/csv') }
    end
  end
end

# == Schema Information
#
# Table name: import_data_queues
#
#  id             :bigint           not null, primary key
#  status         :integer          default("waiting_to_start"), not null
#  file_data      :json             not null
#  error_messages :text(65535)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
