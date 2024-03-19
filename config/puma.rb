# Pumaの設定ファイル
# この設定ファイルはPumaによって評価されます。ここで呼び出されるトップレベルのメソッドは、Pumaの設定DSLの一部です。
# DSLによって提供されるメソッドについての詳細は、https://puma.io/puma/Puma/DSL.htmlを参照してください。

# Pumaは、内部スレッドプールからスレッドごとにリクエストを処理できます。
# `threads`メソッドの設定には2つの数値が必要です：最小値と最大値。
# スレッドプールを使用するライブラリは、Pumaの最大値に一致するように構成する必要があります。
# デフォルトでは、最小値と最大値のデフォルトは5スレッドに設定されており、これはActive Recordのデフォルトのスレッドサイズに一致します。
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# 本番環境では、ワーカー数をプロセッサの数に等しくすることを指定します。
if ENV["RAILS_ENV"] == "production"
  require "concurrent-ruby"
  worker_count = Integer(ENV.fetch("WEB_CONCURRENCY") { Concurrent.physical_processor_count })
  workers worker_count if worker_count > 1
end

# 開発環境では、Pumaがワーカーを終了するまでの`worker_timeout`閾値を指定します。
worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

# Pumaがリクエストを受け取るためにリッスンするポートを指定します。デフォルトは3000です。
port ENV.fetch("PORT") { 3000 }

# Pumaが実行される`environment`を指定します。
environment ENV.fetch("RAILS_ENV") { "development" }

# Pumaが使用する`pidfile`を指定します。
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# `bin/rails restart`コマンドによってPumaを再起動できるようにします。
plugin :tmp_restart

# アプリケーションの事前読み込みを許可します。
preload_app!

# アプリケーションの起動方法を指定します。
rackup      DefaultRackup

# ポート番号と環境のデフォルト値を指定します。
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

# ワーカーブート時にActiveRecordの接続を確立します。
on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end
