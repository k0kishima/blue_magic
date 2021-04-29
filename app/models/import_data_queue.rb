class ImportDataQueue < ApplicationRecord
  enum status: {
    waiting_to_start: 0,
    in_progress: 100,
    success: 10_000,
    failure: 99_999,
  }
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
