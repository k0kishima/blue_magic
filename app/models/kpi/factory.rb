class Kpi::Factory
  def self.create!(hash)
    operand = hash.fetch(:item)
    key = hash.fetch(:attribute)
    attribute_name, value = hash.fetch(:modifier, [])

    kpi_class =
      Kpi::Base.applicable
               .select { |applicable_kpi_class| applicable_kpi_class.operand.to_sym == operand.to_sym }
               .find { |kpi_class_for_operand| kpi_class_for_operand.key.to_sym == key.to_sym }

    raise ArgumentError, "kpi class cannot create from #{hash}" if kpi_class.blank?

    kpi = kpi_class.new
    # この処理がない場合invalidになるKPIオブジェクトもあるが、ここではインスタンスを生成するまでが責務なのでvalidなものを生成するところまでの責任は負わない
    kpi.try!("#{attribute_name}=", value) if attribute_name.present?
    kpi
  end
end
