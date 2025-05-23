source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.7.7'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem "puma", ">= 5.3.1"
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "sprockets", "3.7.2"
gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'webpacker'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'rails-i18n'
# Use Active Storage variant
gem 'image_processing', '~> 1.12'
gem 'devise'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.13', require: false
# gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'popper_js', '~> 1.12.9'
gem "aws-sdk-s3", require: false
gem 'dotenv-rails'
gem 'rest-client'
gem 'friendly_id', '~> 5.4.0'
gem "activestorage-office-previewer"
gem 'metamagic'
gem 'audit-log', git: 'https://github.com/justincadburywong/audit-log'
# gem 'pdfjs_viewer-rails'
gem 'store_model'
gem 'lograge'
gem 'faker'
gem 'discard', '~> 1.4'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'bullet'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'binding_of_caller'
  gem 'better_errors'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "nokogiri", ">= 1.11.4"
gem "actionpack", ">= 6.1.4.1"
gem "addressable", ">= 2.8.0"
gem "net-smtp", require: false # for ruby > 3.1
gem "net-imap", require: false # for ruby > 3.1
gem "net-pop", require: false # for ruby > 3.1
