source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

##################################################
#
# Heroku config:
gem 'thin'
#
# Local config:
#
##################################################

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

#Gems used only for testing
group :test do
  gem 'shoulda'
  gem 'mocha'
  gem 'capybara'
end

group :development, :test do
  gem 'factory_girl_rails'
end

# The next two are needed to run Rails on Ubuntu. They shouldn't be required for Heroku.
group :development do
  gem 'libv8', '~> 3.11'
  gem 'therubyracer', '~> 0.11'
end

gem 'pg'

gem 'rmagick', '~>2.0'
gem 'jquery-rails'
gem 'bootstrap-sass', '~>2.0'
gem 'dropbox-sdk'
gem 'devise'
gem 'simple_form'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
