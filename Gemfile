source 'https://rubygems.org'
ruby '3.3.4'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

#gem 'activerecord-oracle_enhanced-adapter', '~> 1.7'
#gem 'ruby-oci8', '~> 2.2.5'
#gem 'ruby-plsql'
gem 'bootsnap', '>= 1.4.4', require: false
#gem 'tiny_tds'

#gem 'activerecord-sqlserver-adapter'
#gem 'pg'
gem 'mysql2', '~> 0.5'
gem 'secondbase'
gem 'time_difference'
gem 'autonumeric-rails'
gem 'bootstrap-tooltip-rails'
gem 'bootstrap-sass'
# temporal off for Rails 6.1 migration (thor conflict)
# gem "select2-rails"
gem "paperclip"
gem 'nokogiri', '< 1.17'
gem 'roo', '~> 1.13.2'
gem 'chart-js-rails'
gem 'barby'
gem 'chunky_png'
gem 'rqrcode'
gem 'bootstrap-wysihtml5-rails'
gem 'dotenv-rails', '~> 2.8'

gem 'authtrail', '~> 0.4.3'

gem 'axlsx', git: 'https://github.com/randym/axlsx.git', ref: 'c8ac844'
gem 'axlsx_rails', '~> 0.5.1'

# Google Map
gem 'gmaps4rails'

gem 'carrierwave'
gem 'carrierwave-base64'
#gem 'rmagick'

#Pdf Convert
#gem 'wicked_pdf'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary','0.12.4'

gem 'whenever', :require => false

gem 'simple_form'
gem 'simple_form_autocomplete'
gem "highcharts-rails"
gem 'ransack', '~> 3.2'

gem "audited", "~> 5.7"

gem 'will_paginate'
gem 'will_paginate-bootstrap'
gem 'remotipart'

#GEMAS DATEPICKER
gem 'momentjs-rails'
#gem 'datetimepicker-rails', github: 'zpaulovics/datetimepicker-rails', branch: 'master'#, submodules: true

gem 'font-awesome-sass', '~> 4.7.0'
gem 'font_awesome5_rails'
gem 'jquery-ui-rails'
# temporal off for Rails 6.1 migration (asset pipeline incompatibility)
# gem 'ionicons-rails' # Iconos ionicons

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.8', '>= 7.0.8.7'
gem 'zeitwerk', '>= 2.6.0', '< 2.7'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 6.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '4.3.1'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.2.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'strong_password', '~> 0.0.8'
gem 'jquery-turbolinks'
gem 'rails-jquery-autocomplete'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rack-mini-profiler'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 4.0.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  #gem 'better_errors'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'brakeman'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
#gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'devise'
gem 'devise-two-factor', '~> 4.1'
gem 'rqrcode_png'
gem 'devise_ssl_session_verifiable', require: false
# server de jobs
gem 'sidekiq'
# temporal off for Rails 6.1 migration (actionpack constraint)
# gem 'redis-rails'

gem 'nice_http'
gem 'mimemagic', '~> 0.3.10'
gem 'sucker_punch'
# temporal off for Rails 7 migration (current version only supports actionmailer < 7)
# gem 'exception_notification'
gem 'slack-notifier'
# temporal off for Rails 7 migration (deprecated in Rails 7)
# gem 'webpacker', '~> 5.0'
gem 'bigdecimal', '~> 3.1.8'
