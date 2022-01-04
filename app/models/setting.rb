# RailsSettings Model
class Setting < RailsSettings::Base
  cache_prefix { "v1" }

  field :voting_enable, type: :boolean, default: false
  field :crawling_enable, type: :boolean, default: true
  field :slack_notification_enable, type: :boolean, default: false
end

# == Schema Information
#
# Table name: settings
#
#  id         :bigint           not null, primary key
#  var        :string(255)      not null
#  value      :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_settings_on_var  (var) UNIQUE
#
