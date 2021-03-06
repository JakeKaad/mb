source 'https://rubygems.org'
ruby "2.3.0"

gem 'rails', '5.0.0.beta3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks', '5.0.0.beta1'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

# For docx processing/storage
gem 'docx', '~> 0.2.07', :require => ["docx"]
gem 'aws-sdk', '< 2.0'
gem 'paperclip'

gem 'cancancan', '~> 1.10'

# Bootstrap
gem 'bootstrap', '~> 4.0.0.alpha3'
source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end

gem 'devise', github: 'plataformatec/devise', branch: 'master'
gem 'faker'

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'sqlite3'
  gem 'pry'
  gem 'pry-remote'
  gem 'pry-nav'
  gem "rspec-rails", git: "https://github.com/rspec/rspec-rails.git", branch: "master"
  gem "rspec-core", git: "https://github.com/rspec/rspec-core.git", branch: "master"
  gem "rspec-support", git: "https://github.com/rspec/rspec-support.git", branch: "master"
  gem "rspec-expectations", git: "https://github.com/rspec/rspec-expectations.git", branch: "master"
  gem "rspec-mocks", git: "https://github.com/rspec/rspec-mocks.git", branch: "master"
  gem 'dotenv-rails'
  gem 'git-up'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
  gem 'factory_girl_rails', '~> 4.4.1'
end
