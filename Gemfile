source "https://rubygems.org"


gem "rails", "~> 8.0.1"
gem "propshaft"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"

gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

gem "bootsnap", require: false

gem "kamal", require: false

gem "thruster", require: false

group :development, :test do
  gem "rspec-rails", "~> 7.0.0"
  gem "factory_bot_rails"
  gem "faker"
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "pry-byebug", "~> 3.9"
  gem "shoulda-matchers", "~> 6.0"
end

group :development do
  gem "web-console"
end

group :test do
  gem "simplecov", require: false
end

gem "jsbundling-rails", "~> 1.3"
