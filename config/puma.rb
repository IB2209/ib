# Specifies the `environment` that Puma will run in.
environment 'production'


# Pumaの設定ファイル


threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

# socket
bind "unix:/var/www/ib./shared/tmp/sockets/puma.sock"

rails_root = File.expand_path('..', __dir__)
log_dir = '/var/www/ib./shared/log'  # 新しいログディレクトリのパス

state_path File.join(rails_root, 'tmp', 'pids', 'puma.state')
stdout_redirect(
  File.join(log_dir, 'puma.log'),           # 標準出力ログファイルのパスを変更
  File.join(log_dir, 'puma-error.log'),     # 標準エラー出力ログファイルのパスを変更
  true
)


# Specifies the `pidfile` that Puma will use.
pidfile File.join(rails_root, 'tmp', 'pids', 'server.pid')

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
