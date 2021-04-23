class ImporterClassFactory
  def self.create!(parser)
    case parser.class.name
    when 'EventListParser'
      EventsImporter
    when 'RacerListParser'
      RacersImporter
    else
      raise NotImplementedError
    end
  end
end
