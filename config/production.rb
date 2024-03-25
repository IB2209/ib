require File.expand_path('../config/environment', __dir__)

Rails.application.configure do


  # アセットのプリコンパイル
  config.assets.compile = false
  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :sass

  # ロギングの設定
  config.log_level = :info
  config.log_formatter = ::Logger::Formatter.new
  config.log_tags = [:request_id]

  # セキュリティ設定（Force SSL）
  config.force_ssl = true
  config.public_file_server.headers = {
    'Cache-Control' => 'public, max-age=31536000',
    'Expires' => 1.year.from_now.to_formatted_s(:rfc822)
  }

end
