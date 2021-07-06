class BinaryExpressionFactory
  def self.create!(hash)
    raise ArgumentError unless hash.keys.count == 1
    raise ArgumentError unless hash.values.first.count == 2

    operator = hash.keys.first
    left_operand_processor, right_operand_processor = hash.values.first.map do |h|
      begin
        OperandProcessorFactory.create!(h)
      rescue StandardError
        self.create!(h)
      end
    end

    ->(object) do
      # 今期F回数などのKPI値が入る
      value_to_be_compared = left_operand_processor.call(object)

      if value_to_be_compared.nil?
        # 本来なら以下のような対応にしたい
        # raise DataNotFound, "cannot operate #{hash} because of nil"
        #
        # 今の実装は and や or でグルーピングした全式を評価している
        # つまり or は最初の条件が false であれば false をリターンするという短絡実行ではなくて、続く条件も評価されてしまう
        # それらで例外があがったらそこで処理が止まってしまう
        # 理想的には or が言語の論理演算子と同じように振る舞い短絡実行をしてくれることが望ましいが、
        # 今は暫定的に例外が起こりうるケースでも false を返して処理が止まらないように暫定対応している
        return false
      end

      # KPI値を閾値と比較する
      # 以下だと閾値は1で、これをoperatorである >= で比較している
      # {">="=>[{"item"=>"pit_number_1", "attribute"=>"flying_count_in_current_rating_term"}, {"item"=>"literal", "value"=>1}]}
      value_to_be_compared.try(operator, right_operand_processor.call(object))
    end
  end
end
