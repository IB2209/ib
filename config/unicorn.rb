# unicorn.rb

# アプリケーションのディレクトリを指定します
working_directory "/var/www/ib/current"


# ポートの設定
listen 443

# プロセスの数
worker_processes 2

# ログの場所
stderr_path '/Users/ib./ema/ib/log/unicorn.stderr.log'
stdout_path '/Users/ib./ema/ib/log/unicorn.stdout.log'

# デーモン化
daemonize true
