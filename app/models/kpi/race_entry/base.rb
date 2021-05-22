class Kpi::RaceEntry::Base < Kpi::Base
  attribute :pit_number
  validates :pit_number, presence: true

  def type
    RaceEntry
  end

  def name
    I18n.t("kpi.race_entry.#{key}.name")
  end

  def description
    I18n.t("kpi.race_entry.#{key}.description")
  end

  def subject
    @subject ||= -> do
      validate!

      race_entry = source.race_entries.find{|race_entry| race_entry.pit_number == pit_number }
      raise DataNotPrepared, 'the race does not have a race entry at which specified pit_number' if race_entry.blank?
      race_entry
    end.call
  end
end
