require 'csv'

class CsvFactory
  def self.create!(*array_of_array_of_hash)
    flattened_array_of_hash = []

    # 配列の配列が渡ってくるから他の要素と長さが一致していないと不正なデータとみなす
    unless array_of_array_of_hash.map { |array_of_hash| array_of_hash.size }.uniq.size == 1
      raise ArgumentError.new('there is difference in array size.')
    end

    # この時点で各配列の長さは均等であることが保証されているので最初の配列のサイズを基準に逐次処理していく
    array_of_array_of_hash.first.size.times do |i|
      array_of_hashes = array_of_array_of_hash.map { |array_of_hash| array_of_hash[i] }
      flattened_array_of_hash << array_of_hashes.reduce(&:merge)
    end

    header = flattened_array_of_hash.first.keys
    if flattened_array_of_hash.any? { |hash| hash.keys != header }
      raise ArgumentError.new('there is difference in hash structure.')
    end

    Tempfile.new([SecureRandom.uuid, '.csv']).tap do |file|
      CSV.open(file, 'wb') do |csv|
        csv << header
        flattened_array_of_hash.each { |hash| csv << hash.values }
      end
    end
  end
end
