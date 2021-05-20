class Kpi::RaceEntry::Base < Kpi::Base
  def subject
    RaceEntry
  end

  def name
    I18n.t("kpi.race_entry.#{key}.name")
  end

  def description
    I18n.t("kpi.race_entry.#{key}.description")
  end
end
