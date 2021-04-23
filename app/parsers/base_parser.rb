require 'csv'

class BaseParser
  def initialize(csv)
    @csv = CSV.read(csv)
  end

  def parse!
    raise NotImplementedError
  end

  private

  attr_reader :csv

  def header
    @header ||= @csv[0]
  end

  def rows
    @rows ||= @csv.slice(1..)
  end

  def validate_header_keys!
    return if header.map(&:to_s) == self.class::HEADER_KEYS.map(&:to_s)

    raise 'invalid headers'
  end
end
