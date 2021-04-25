require 'csv'

class CsvFactory
  def self.create!(array_of_hash)
    Tempfile.new([SecureRandom.uuid, '.csv']).tap do |file|
      header = array_of_hash.first.keys
      raise ArgumentError.new('there is difference in hash structure.') unless array_of_hash.all? { |hash|
                                                                                 hash.keys == header
                                                                               }

      rows = array_of_hash.map { |hash| hash.values }

      CSV.open(file, 'wb') do |csv|
        csv << header
        rows.each { |row| csv << row }
      end
    end
  end
end
