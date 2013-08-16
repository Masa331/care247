source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'turbolinks'
gem 'bcrypt-ruby', require: 'bcrypt'
gem 'griddler'

group :development do
	gem 'annotate'
end

group :test do
	gem 'capybara'
	gem 'faker'
	gem 'guard-rspec'
	gem 'launchy'
	gem 'shoulda-matchers'
end

group :production do
	gem 'pg', '0.15.1'
	gem 'rails_12factor'
end

group :development, :test do
	gem 'sqlite3'
	gem 'rspec-rails'
	gem 'factory_girl_rails'
	gem 'jquery-rails'
end