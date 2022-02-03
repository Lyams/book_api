# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

gem 'bcrypt', '~> 3.1', '>= 3.1.16'
gem 'faker', '~> 2.19'
gem 'fast_jsonapi', '~> 1.5'
gem 'good_job'
gem 'kaminari', '~> 1.2', '>= 1.2.2'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.1'
gem 'valid_email2', '~> 4.0', '>= 4.0.1'
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false
# A pure ruby implementation of the RFC 7519 OAuth JSON Web Token (JWT) standard.
gem 'jwt', '~> 2.3'
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'rspec-rails', '~> 5.0', '>= 5.0.2'
  # Security tools
  gem 'brakeman', '~> 5.2', '>= 5.2.1'
  gem 'bundler-audit', '~> 0.9.0.1'
  # Linter
  gem 'rubocop', '~> 1.25', '>= 1.25.1'
  gem 'rubocop-rails', '~> 2.13', '>= 2.13.2'
  gem 'rubocop-rspec', '~> 2.8'
end

group :development do
  gem 'open_mailer', '~> 0.1.2'
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem 'codecov'
  gem 'database_cleaner-active_record'
  gem 'rspec-openapi', '~> 0.4.1'
  gem 'shoulda-matchers', '~> 5.1'
end
