class AttributionalKpi < Kpi
  def value!
    validate!(:calculation)
    entry_object.try!(attribute_name)
  end
end
