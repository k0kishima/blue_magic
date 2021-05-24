class Kpi::Race::Base < Kpi::Base
  def self.operand
    :itself
  end

  def name
    I18n.t("kpi.race.#{key}.name")
  end

  def description
    I18n.t("kpi.race.#{key}.description")
  end

  def subject
    @subject ||= source
  end
end
