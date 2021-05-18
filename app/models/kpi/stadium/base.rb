class Kpi::Stadium::Base
  include Singleton
  include ActiveModel::Model
  include ActiveModel::Attributes

  def subject
    Stadium
  end

  def key
    raise NotImplementedError
  end

  def name
    I18n.t("kpi.stadium.#{key}.name")
  end

  def description
    I18n.t("kpi.stadium.#{key}.description")
  end
end
