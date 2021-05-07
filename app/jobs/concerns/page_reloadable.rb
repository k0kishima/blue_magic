module PageReloadable
  extend ActiveSupport::Concern

  included do
    def no_cache
      # NOTE: perform_now で実行した時は0で、perform_later は初回時に1,それからリトライの都度インクリメントされるので注意
      attempt_number > 1
    end
  end
end
