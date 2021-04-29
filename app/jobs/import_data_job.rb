class ImportDataJob < ApplicationJob
  def perform(queue_id)
    queue = ImportDataQueue.find(queue_id)

    queue.with_lock do
      raise ArgumentError,
            "import job can't start because queue is invalid status '#{queue.status}'" unless queue.waiting_to_start?

      queue.in_progress!
    end

    begin
      # HACK:
      # 一つのファイルから取得できるデータの種類は複数ある（複数のモデルが対応）
      # ※ 但し、ここでのモデルはORM
      # したがって、ここで全部処理するのではなく保存するデータ別にジョブを分けるのが望ましい
      # なぜならAというデータの保存に成功してもBというデータも同様に保存できるとは限らないため
      # 例えばレース結果のCSVをパースするときにrece_recordsは保存成功しても disqualified_race_entries は失敗するかもしれない
      # そういったケースで queue のステータスを success にするのは違和感があるし、エラーメッセージの内容も混沌としてしまう
      # 各々のモデルごとに子レコードを作ってそこでステータスやエラーメッセージを持てばすっきりするが、
      # その場合ファイルをモデルごとにファイルをダウンロードするというコストもかかるので一旦ここで全部処理することにする
      csv = queue.file.download
      applicable_parser_classes = ParserClassFactory.bulk_create(csv)
      applicable_parser_classes.each do |parser_class|
        parser = parser_class.new(csv)
        available_importer_class = ImporterClassFactory.create!(parser)
        available_importer_class.new.import!(parser.parse!)
      end

      queue.success!
    rescue StandardError => e
      queue.update!(status: :failure, error_messages: e.message)
    end
  end
end
