class WinningTrickFactory
  def self.create!(name)
    case name
    when '逃げ'
      :nige
    when '差し'
      :sashi
    when 'まくり'
      :makuri
    when 'まくり差し'
      :makurizashi
    when '抜き'
      :nuki
    when '恵まれ'
      :megumare
    else
      raise NotImplementedError.new("#{name} is unknown winning trick")
    end
  end
end