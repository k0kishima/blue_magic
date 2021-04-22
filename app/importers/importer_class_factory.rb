class ImporterClassFactory
  def self.create!(parser)
    case parser.class.name
    when 'EventListParser'
      EventsImporter
    else
      raise NotImplementedError
    end
  end
end
