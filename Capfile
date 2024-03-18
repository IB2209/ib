# Capfile

require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git
require "capistrano/safe_deploy_to"
require "capistrano/rbenv"
require "capistrano/bundler"
require "capistrano/rails/assets" # アセットをプリコンパイルするため
require "capistrano/rails/migrations" # マイグレーションをするため

# CapistranoのPumaプラグインが定義されているかどうかを確認し、定義されていればロードする
if defined?(Capistrano::Puma)
  require "capistrano/puma"
  install_plugin Capistrano::Puma # CapistranoとPumaを連携
  install_plugin Capistrano::Puma::Nginx # PumaとNginxを連携
end

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
