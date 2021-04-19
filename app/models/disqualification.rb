module Disqualification
  module ID
    CAPSIZE = 1
    FALL = 2
    SINKING = 3
    VIOLATION = 4
    DISQUALIFICATION_AFTER_START = 5
    ENGINE_STOP = 6
    UNFINISHED = 7
    REPAYMENT_OTHER_THAN_FLYING_AND_LATENESS = 8
    FLYING = 9
    LATENESS = 10
    ABSENT = 11
  end

  class << self
    def all_ids
      ID.constants.map do |constant|
        ID.const_get(constant)
      end
    end

    def need_to_repayment_ids
      [
        ID::REPAYMENT_OTHER_THAN_FLYING_AND_LATENESS,
        ID::FLYING,
        ID::LATENESS,
        ID::ABSENT
      ]
    end

    # NOTE: レース前に検出できるもの
    def pre_fetchable_ids
      [
        ID::ABSENT
      ]
    end

    def cannnot_pre_fetchable_ids
      all_ids - pre_fetchable_ids
    end
  end
end
