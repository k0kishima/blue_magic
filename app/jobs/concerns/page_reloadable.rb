module PageReloadable
  extend ActiveSupport::Concern

  included do
    def no_cache
      attempt_number >= 1
    end
  end
end
