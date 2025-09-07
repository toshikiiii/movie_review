# config/environments/production.rb
require "active_support/core_ext/integer/time"

Rails.application.configure do
  # 本番はコードをリロードしない
  config.enable_reloading = false
  config.eager_load = true

  # エラー詳細は非表示
  config.consider_all_requests_local = false

  # フラグメントキャッシュ等を有効化
  config.action_controller.perform_caching = true

  # アセットに長期キャッシュ
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }

  # Active Storage はローカル（Free運用の簡易設定）
  config.active_storage.service = :local

  # 逆プロキシ越しのSSL前提
  config.assume_ssl = true
  config.force_ssl  = true

  # ログ
  config.log_tags = [:request_id]
  config.logger   = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.silence_healthcheck_path = "/up"
  config.active_support.report_deprecations = false

  # Solid Cache は使わずメモリキャッシュに（DB不要）
  config.cache_store = :memory_store

  # Active Job は Solid Queue を使わず :async に（DB不要）
  config.active_job.queue_adapter = :async
  # config.solid_queue.connects_to は不要なので削除

  # Action Mailer（必要ならホストをあなたのURLに）
  config.action_mailer.default_url_options = {
    host: ENV.fetch("APP_HOST", "cinemarks.onrender.com"),
    protocol: "https"
  }

  # i18n フォールバック
  config.i18n.fallbacks = true

  # マイグレーション後にschema.rbをダンプしない
  config.active_record.dump_schema_after_migration = false

  # inspect 出力を軽量に
  config.active_record.attributes_for_inspect = [:id]

  # Render のドメインを許可
  config.hosts << ".onrender.com"
end