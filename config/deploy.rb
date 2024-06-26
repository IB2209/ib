#deploy.rb

# config valid for current version and patch releases of Capistrano
lock "~> 3.18.1"

set :application, "ib."
set :repo_url, "git@github.com:IB2209/ib.git"
set :user, "ib"
set :branch, "main"
set :deploy_to, '/home/deploy/ib.'
set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"

set :ssh_options, {
  keys: %w(/home/deploy/.ssh/ib.pem),
  forward_agent: false,
  auth_methods: %w(publickey)
}


# 並列数
set :bundle_jobs, 2

# リリース間で共有するリソースのファイルパスを書く
append :linked_files, "config/database.yml", "config/master.key"
# deploy.rb

# .envファイルをリンクする
append :linked_files, "config/.env"


# 各リリースが共通で読み込むディレクトリを設定する
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets",  '.bundle'
