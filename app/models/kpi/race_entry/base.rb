class Kpi::RaceEntry::Base
  include Singleton
  include ActiveModel::Model
  include ActiveModel::Attributes

  def subject
    RaceEntry
  end

  def key
    raise NotImplementedError
  end

  def name
    I18n.t("kpi.race_entry.#{key}.name")
  end

  def description
    I18n.t("kpi.race_entry.#{key}.description")
  end
end
