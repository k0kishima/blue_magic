class AssistTrick < Trick
  module ID
    NIGASHI = 7
    SASARE = 8
    MAKURARE = 9
  end

  class Nigashi < AssistTrick
    def id
      ID::NIGASHI
    end

    def available_course_numbers
      [2, 3]
    end

    def asist_trick_ids
      [WinningTrick::ID::NIGE]
    end
  end

  # TODO: これは技でもアシストでもなく単に負パターンなのでそういうクラスに切り出す
  class Sasare < AssistTrick
    def id
      ID::SASARE
    end

    def available_course_numbers
      [1]
    end

    def asist_trick_ids
      [WinningTrick::ID::SASHI, WinningTrick::ID::MAKURIZASHI]
    end
  end

  # TODO: これは技でもアシストでもなく単に負パターンなのでそういうクラスに切り出す
  class Makurare < AssistTrick
    def id
      ID::MAKURARE
    end

    def available_course_numbers
      [1]
    end

    def asist_trick_ids
      [WinningTrick::ID::MAKURARE]
    end
  end
end
