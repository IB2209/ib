# Pumaの設定ファイル

threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

rails_env = ENV.fetch('RAILS_ENV') { 'development' }

# socket
bind "unix:/var/www/ib./shared/tmp/sockets/puma.sock"

#rails_root = Dir.pwd
state_path File.join(rails_root, 'tmp', 'pids', 'puma.state')
stdout_redirect(
  File.join(rails_root, 'log', 'puma.log'),
  File.join(rails_root, 'log', 'puma-error.log'),
  true
)

# daemonizeを有効にする
daemonize true

# Specifies the `environment` that Puma will run in.
environment rails_env

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
