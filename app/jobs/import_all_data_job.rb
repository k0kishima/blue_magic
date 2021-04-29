class ImportAllDataJob < ApplicationJob
  def perform
    ImportDataQueue.startable.each do |import_data_queue|
      import_data_queue.with_lock do
        if import_data_queue.uploaded?
          import_data_queue.waiting_to_start!
          ImportDataJob.perform_later(import_data_queue.id)
        end
      end
    end
  end
end
