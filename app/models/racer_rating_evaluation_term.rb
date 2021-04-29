class RacerRatingEvaluationTerm
  FIRST_HALF_START_MONTH = 5
  SECOND_HALF_START_MONTH = 11

  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :starts_on, :date
  attribute :ends_on, :date

  validates :starts_on, presence: true
  validates :ends_on, presence: true

  validate :starts_on_must_be_the_1st_of_may_or_november
  validate :ends_on_must_be_the_end_of_april_or_october

  class << self
    def in_first_half?(date:)
      (first_half_starts_on(year: date.year)..first_half_ends_on(year: date.year)).include?(date)
    end

    def initialize_by(date:)
      starts_on, ends_on = if in_first_half?(date: date)
                             [first_half_starts_on(year: date.year), first_half_ends_on(year: date.year)]
                           else
                             year = date.month <= 4 ? date.year.pred : date.year
                             [second_half_starts_on(year: year), second_half_ends_on(year: year)]
                           end
      new(starts_on: starts_on, ends_on: ends_on)
    end

    def first_half_starts_on(year:)
      Date.new(year, self::FIRST_HALF_START_MONTH)
    end

    def first_half_ends_on(year:)
      Date.new(year, self::SECOND_HALF_START_MONTH.pred).end_of_month
    end

    def second_half_starts_on(year:)
      Date.new(year, self::SECOND_HALF_START_MONTH)
    end

    def second_half_ends_on(year:)
      Date.new(year.next, FIRST_HALF_START_MONTH.pred).end_of_month
    end
  end

  def calculate_debut_term!
    validate!

    # 新人のデビューは前期が偶数期、後期が奇数期
    # 2020年をオフセットとすれば、126期が5月にデビュー
    term = 126 + -((2020 - starts_on.year) * 2)
    if second_half?
      term += 1
    end
    term
  end

  private

  def starts_on_must_be_the_1st_of_may_or_november
    return if starts_on.blank?

    if starts_on.month.in?([FIRST_HALF_START_MONTH, SECOND_HALF_START_MONTH])
      if starts_on.day != 1
        errors.add(:starts_on, "must be start from the 1st of the month")
      end
    else
      errors.add(:starts_on, "must be within May or November")
    end
  end

  def ends_on_must_be_the_end_of_april_or_october
    return if ends_on.blank?

    if ends_on.month.in?([SECOND_HALF_START_MONTH.pred, FIRST_HALF_START_MONTH.pred])
      if ends_on != ends_on.end_of_month
        errors.add(:ends_on, "must be end on the end of month")
      end
    else
      errors.add(:ends_on, "must be within April or October")
    end
  end

  def first_half?
    starts_on.month == self.class::FIRST_HALF_START_MONTH
  end

  def second_half?
    starts_on.month == self.class::SECOND_HALF_START_MONTH
  end
end
