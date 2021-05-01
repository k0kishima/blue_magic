class ImportDataQueue < ApplicationRecord
  include CsvUploader::Attachment(:file)

  enum status: {
    uploaded: 0,
    waiting_to_start: 100,
    in_progress: 200,
    success: 10_000,
    failure: 99_999,
  }

  validates :status, presence: true
  validates :file_data, presence: true

  scope :startable, -> { uploaded.order(id: :asc) }
end

# == Schema Information
#
# Table name: import_data_queues
#
#  id             :bigint           not null, primary key
#  status         :integer          default("uploaded"), not null
#  file_data      :json             not null
#  error_messages :text(65535)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
