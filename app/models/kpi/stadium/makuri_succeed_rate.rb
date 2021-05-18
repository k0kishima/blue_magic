module Kpi::Stadium
  class MakuriSucceedRate < WinningTrickKpi
    def key
      :makuri_succeed_rate
    end

    private

    def trick
      @trick ||= WinningTrick::Makuri.instance
    end
  end
end
