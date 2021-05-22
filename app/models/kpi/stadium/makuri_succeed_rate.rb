module Kpi::Stadium
  class MakuriSucceedRate < WinningTrickKpi
    private

    def trick
      @trick ||= WinningTrick::Makuri.instance
    end
  end
end
