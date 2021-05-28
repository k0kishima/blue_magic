class Trick
  include Singleton

  def id
    raise NotImplementedError
  end

  def available_course_number
    raise NotImplementedError
  end

  def winning_trick?
    raise NotImplementedError
  end

  def assist_trick?
    raise NotImplementedError
  end
end
