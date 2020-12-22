source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"

gem "rails", "~> 6.1.0"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 5.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.7"
gem "bcrypt", "~> 3.1.7"
gem "pundit", "~> 2.1"
gem "view_component", require: "view_component/engine"
gem "octicons_helper"
gem "active_link_to", "~> 1.0", ">= 1.0.5"
# gem "redis", "~> 4.0"
# gem "image_processing", "~> 1.2"
gem "bootsnap", ">= 1.4.4", require: false

group :development, :test do
  gem "capybara", "~> 3.33"
  gem "rspec-rails", "~> 4.0", ">= 4.0.1"
  gem "shoulda-matchers", "~> 4.4", ">= 4.4.1"
  gem "factory_bot_rails", "~> 6.1"
  gem "pundit-matchers", "~> 1.6"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "guard-rspec", "~> 4.7", ">= 4.7.3"
  gem "better_errors", "~> 2.8", ">= 2.8.3"
  gem "binding_of_caller", "~> 0.8.0"
  gem "web-console", ">= 4.1.0"
  gem "rack-mini-profiler", "~> 2.0"
  gem "listen", "~> 3.3"
  gem "spring"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
