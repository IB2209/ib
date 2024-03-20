# config valid for current version and patch releases of Capistrano
lock "~> 3.18.1"

set :application, "ib."
set :repo_url, "git@github.com:IB2209/ib.git"
set :user, "deploy"
set :branch, "main"
set :deploy_to, '/var/www/ib.'
set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"

# 並列数
set :bundle_jobs, 2

# リリース間で共有するリソースのファイルパスを書く
append :linked_files, "config/master.key"

# 各リリースが共通で読み込むディレクトリを設定する
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets",  '.bundle'

# config/deploy.rb

# データベースの設定
set :database_config, -> { "#{shared_path}/config/database.yml" }

# デプロイ時にデータベース設定ファイルを読み込む
namespace :deploy do
  desc 'Copy database.yml to the current release'
  task :copy_database_config do
    on roles(:app) do
      execute :cp, fetch(:database_config), "#{release_path}/config/database.yml"
    end
  end
end

before 'deploy:starting', 'deploy:copy_database_config'
