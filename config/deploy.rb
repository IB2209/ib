# config valid for current version and patch releases of Capistrano
lock "~> 3.18.1"

set :application, "ib."
set :repo_url, "git@github.com:IB2209/ib.git"
set :branch, 'main'
set :deploy_to, '/var/www/ib.'
set :linked_files, %w(config/master.key)
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system)
set :keep_releases, 5
set :rbenv_ruby, '3.3.0'
set :log_level, :debug
set :default_env, {
  rbenv_root: "/home/rails/.rbenv",
  path: "/home/rails/.rbenv/bin:$PATH"
}

append :linked_files, "config/master.key"

namespace :deploy do
  desc "Upload master key"
  task :upload_master_key do
    on roles(:app) do
      upload!("/Users/ib.//ema/ib/config/master.key", "#{shared_path}/config/master.key")
    end
  end
end

after "deploy:check:linked_files", "deploy:upload_master_key"
