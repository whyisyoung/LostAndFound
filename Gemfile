source 'http://ruby.taobao.org'
ruby '1.9.3'

gem 'rails', '3.2.13'

gem 'bootstrap-sass', '~> 2.3.2.0'
gem 'bcrypt-ruby', '~> 3.0.1'
gem 'faker', '~> 1.1.2'
gem 'will_paginate', '~> 3.0.4'
gem 'bootstrap-will_paginate', '~> 0.0.9'

group :development, :test do
  gem 'sqlite3', '~> 1.3.7'
  gem 'rspec-rails', '~> 2.13.1'
  gem 'guard-rspec', '~> 2.5.0'
  gem 'spork-rails', github: 'sporkrb/spork-rails'
  gem 'guard-spork', '~> 1.5.0'
  gem 'childprocess', '~> 0.3.6'
end

group :test do
  gem 'selenium-webdriver', '~> 2.0.0'
  gem 'capybara', '~> 2.1.0'
  gem 'libnotify', '~> 0.8.0'
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
  gem 'factory_girl_rails', '~> 4.2.1'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '~> 2.2.1'
gem 'turbolinks', '~> 1.1.1'
gem 'jbuilder', '~> 1.0.2'

group :doc do
  gem 'sdoc', '~> 0.3.20', require: false
end

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
