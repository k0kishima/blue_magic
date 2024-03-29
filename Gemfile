source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '7.0.3.1'
# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.5'
# Use Puma as the app server
gem 'puma', '~> 5.6'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'annotate'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'shoulda-matchers'
  gem 'rspec-collection_matchers'
  gem 'vcr'
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# bundle add で済むものに関してはこのコマンドでインストールしていくので時系列順で並ぶ
# アルファベット順に手動でソートなどは特に行わない
gem "nokogiri", "~> 1.13"

gem "rubocop", "~> 1.12"

gem "pry-rails", "~> 0.3.9"

gem "hiredis", "~> 0.6.3"

gem "redis", "~> 4.2"

gem "sidekiq", "~> 7.1"

# cache_store はこれがなくても引数で名前空間効いたが sidekiq でredis設定するときにnamespace引数使うなら必要
gem "redis-namespace", "~> 1.8"

gem 'composite_primary_keys', :github => 'composite-primary-keys/composite_primary_keys'

gem "factory_bot", "~> 6.1"

gem "jp_prefecture", "~> 1.0"

gem "activerecord-import", "~> 1.0"

gem "shrine", "~> 3.3"

gem "sidekiq-scheduler", "~> 3.0"

gem "slack-ruby-client", "~> 1.0"

gem "retryable", "~> 3.0"

gem "rails-settings-cached", "~> 2.5"

gem "graphql", "~> 1.12"

gem "graphiql-rails", "~> 1.7"

gem "hashie", "~> 4.1"

gem "colorize", "~> 0.8.1"

gem 'psych', '~> 3.1'

gem "net-smtp"

gem "faraday", "~> 1.10"

gem "faraday_middleware", "~> 1.2"
