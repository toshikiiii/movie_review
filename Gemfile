source "https://rubygems.org"

gem "rails", "~> 8.0.2", ">= 8.0.2.1"
gem "propshaft"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
# gem "solid_cache"
# gem "solid_queue"
# gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

# 認証関連
gem "bcrypt", "~> 3.1"

# ページネーション & フォーム
gem "kaminari", "~> 1.2"
gem "simple_form", "~> 5.3"

group :development, :test do
  # DB → 開発・テストは SQLite
  gem "sqlite3", "~> 1.7"

  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

group :production do
  # 本番は PostgreSQL
  gem "pg", "~> 1.5"
  gem "aws-sdk-s3", require: false
end