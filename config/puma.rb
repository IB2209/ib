# Pumaの設定ファイル

#bind "unix://var/local/work/ib./tmp/sockets/puma.sock"

# 最大スレッド数と最小スレッド数を設定します
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# 本番環境の場合、ワーカー数をプロセッサの数に設定します
if ENV["RAILS_ENV"] == "production"
  require "concurrent-ruby"
  worker_count = Integer(ENV.fetch("WEB_CONCURRENCY") { Concurrent.physical_processor_count })
  workers worker_count if worker_count > 1
end

# 開発環境の場合、ワーカータイムアウトを設定します
worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

# Pumaがリクエストを受け取るためにリッスンするポートを指定します
port ENV.fetch("PORT") { 3000 }

# Pumaが実行される環境を指定します
environment ENV.fetch("RAILS_ENV") { "development" }

# Pumaが使用するPIDファイルを指定します
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# アプリケーションの事前読み込みを許可します
preload_app!


# Railsアプリケーションのコンフィグファイルを指定します
app_dir = File.expand_path("../..", __FILE__)
rackup DefaultRackup
