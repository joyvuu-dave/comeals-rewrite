source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.6'
# Use postgresql as the database for Active Record
gem 'pg', '>= 1.0.0'
# Use Puma as the app server
gem 'puma', '~> 4.3.8'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'rack-cors', :require => 'rack/cors'

gem 'activeadmin'
gem 'devise'
gem 'friendly_id'
gem 'scrypt'
gem 'faker'
gem 'money-rails'
gem 'counter_culture'
gem 'active_model_serializers', '~> 0.10'
gem 'pusher'
gem 'audited', '~> 4.7'
gem 'newrelic_rpm'
gem 'sendgrid-ruby'
gem 'icalendar'
gem 'platform-api'
gem 'skylight'
gem 'goldiloader'
gem 'redis'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
  gem 'heroku-deflater'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:ruby, :mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.6'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'xipio'
  gem 'bullet'
  gem 'annotate'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
