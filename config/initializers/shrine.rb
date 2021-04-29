require 'shrine'
require 'shrine/storage/file_system'
require 'shrine/storage/memory'

Shrine.plugin :activerecord
Shrine.plugin :determine_mime_type, analyzer: :marcel

if Rails.env.test?
  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new,
  }
else
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'),
    store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads'),
  }
end
