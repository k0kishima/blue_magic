class WinningTrick < Trick
  module ID
    NIGE = 1
    SASHI = 2
    MAKURI = 3
    MAKURIZASHI = 4
    NUKI = 5
    MEGUMARE = 6
  end

  def self.ids
    ID.constants.map { |constant_name| ID.const_get(constant_name) }.sort
  end

  def winning_trick?
    true
  end

  def assist_trick?
    false
  end

  class Nige < WinningTrick
    def id
      ID::NIGE
    end

    def available_course_numbers
      [1]
    end
  end

  class Sashi < WinningTrick
    def id
      ID::SASHI
    end

    def available_course_numbers
      [2, 3, 4, 5, 6]
    end
  end

  class Makuri < WinningTrick
    def id
      ID::MAKURI
    end

    def available_course_numbers
      [2, 3, 4, 5, 6]
    end
  end

  class Makurizashi < WinningTrick
    def id
      ID::MAKURIZASHI
    end

    def available_course_numbers
      [3, 4, 5, 6]
    end
  end

  class Nuki < WinningTrick
    def id
      ID::NIGE
    end

    def available_course_numbers
      [1, 2, 3, 4, 5, 6]
    end
  end

  class Megumare < WinningTrick
    def id
      ID::MEGUMARE
    end

    def available_course_numbers
      [1, 2, 3, 4, 5, 6]
    end
  end
end
