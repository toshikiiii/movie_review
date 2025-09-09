# config/environments/production.rb
require "active_support/core_ext/integer/time"

Rails.application.configure do
  # --- 基本 ---
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false

  # --- キャッシュ / アセット ---
  config.action_controller.perform_caching = true
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }
  # Solid Cacheは使わない（DB不要）
  config.cache_store = :memory_store

  # --- SSL ---
  config.assume_ssl = true
  config.force_ssl  = true
  # 例：ヘルスチェックのHTTP→HTTPSリダイレクトを避けたければ下を有効化
  # config.ssl_options = { redirect: { exclude: ->(r) { r.path == "/up" } } }

  # --- ログ ---
  config.log_tags  = [:request_id]
  config.logger    = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.silence_healthcheck_path = "/up"
  config.active_support.report_deprecations = false

  # --- Active Job ---
  # Solid Queueは使わず非同期(:async)でOK（単一プロセス前提）
  config.active_job.queue_adapter = :async

  # --- Action Mailer（必要ならホストを書き換え）---
  config.action_mailer.default_url_options = {
    host: ENV.fetch("APP_HOST", "cinemarks.onrender.com"),
    protocol: "https"
  }

  # --- I18n / DBダンプなど ---
  config.i18n.fallbacks = true
  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [:id]

  # --- Host許可 ---
  config.hosts << ".onrender.com"

  config.active_storage.service = :amazon
end