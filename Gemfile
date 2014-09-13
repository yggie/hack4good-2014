source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.5'
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby
gem 'dragonfly'

# Use jquery as the JavaScript library
gem 'jquery-rails'

group :development, :test do
  # used by pry to format output in the console
  gem 'awesome_print', '~> 1.2.0'
  # combines pry and byebug (debugger for ruby > 2.0)
  gem 'pry-byebug', '~> 1.3.3'
  # hooks into rails console to enable the pry console
  gem 'pry-rails', '~> 0.3.2'
  # used together with better_errors to provide an interactive console in the
  # development error page
  gem 'binding_of_caller', '~> 0.7.2'
  # improves upon the standard Rails error pages
  gem 'better_errors', '~> 2.0.0'
end

group :production do
  gem 'rack-cache', require: 'rack/cache'
end
