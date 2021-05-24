module Kpi::Race
  class AttributionalKpi < Base
    def value!
      validate!

      subject.try!(key)
    end
  end
end
