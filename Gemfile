source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.7.1"

gem "rails", "~> 6.1.6"

gem "bcrypt", "3.1.13"

gem "bootstrap-sass", "3.4.1"

gem "mysql2", "~> 0.5"

gem "puma", "~> 5.0"

gem "config"

gem "sass-rails", ">= 6"

gem "webpacker", "~> 5.0"

gem "turbolinks", "~> 5"

gem "jbuilder", "~> 2.7"

gem "faker", "2.1.2"

gem "pagy"

gem "bootsnap", ">= 1.4.4", require: false

gem "rails-i18n"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rubocop", "~> 1.26", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.14.0", require: false
end

group :development do
  gem "web-console", ">= 4.1.0"

  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"

  gem "spring"
  gem "spring-watcher-listen", "2.0.1"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver", ">= 4.0.0.rc1"

  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
