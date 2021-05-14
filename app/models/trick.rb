class Trick
  include Singleton

  def id
    raise NotImplementedError
  end

  def available_course_number
    raise NotImplementedError
  end
end
