require 'rails_helper'

RSpec.describe ImportDataQueue, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
