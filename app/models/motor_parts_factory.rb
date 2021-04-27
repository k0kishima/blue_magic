class MotorPartsFactory
  def self.create!(parts_name)
    case parts_name
    when /電気/
      :electrical_system
    when /キャブ/
      :carburetor
    when /\Aピストン\z/
      :piston
    when /リング/
      :piston_ring
    when /シリンダ/
      :cylinder
    when /シャフト/
      :crankshaft
    when /ギ[アヤ]/
      :gear_case
    when /キャリ/
      :carrier_body
    else
      raise NotImplementedError
    end
  end
end
