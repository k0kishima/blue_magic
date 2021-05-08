# NOTE:
# YAGNI原則に則って現時点では三連単のみ対応
module BettingMethodSelector
  extend ActiveSupport::Concern

  included do
    enum betting_method: { trifecta: 1 }

    validates :betting_method, presence: true
    validates :betting_number, presence: true, format: { with: /\A[1-6]{3}\z/ }

    validate :number_cannot_duplicate_digit

    private

    def number_cannot_duplicate_digit
      if betting_number.to_s.split('').uniq.count != betting_number.to_s.length
        errors.add(:betting_number, 'number duplicated.')
      end
    end
  end
end
