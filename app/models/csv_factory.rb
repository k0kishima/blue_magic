require 'csv'

class CsvFactory
  def self.create(array_of_hash)
    Tempfile.new([SecureRandom.uuid, '.csv']).tap do |file|
      header = array_of_hash.first.keys
      rows = array_of_hash.map { |hash| hash.values }

      CSV.open(file, 'wb') do |csv|
        csv << header
        rows.each { |row| csv << row }
      end
    end
  end
end
