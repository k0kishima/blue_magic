class Kpi::Stadium::Base < Kpi::Base
  def self.operand
    :stadium
  end

  def name
    I18n.t("kpi.stadium.#{key}.name")
  end

  def description
    I18n.t("kpi.stadium.#{key}.description")
  end

  def subject
    @subject ||= source.stadium
  end
end
