class CsvUploader < Shrine
  plugin :validation_helpers

  Attacher.validate do
    validate_max_size 100.megabytes
    validate_extension %w[csv]
    validate_mime_type %w[text/csv]
  end
end
