# unicorn.rake

namespace :unicorn do
  task :environment do
    set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"
    set :unicorn_config, "#{current_path}/config/unicorn.rb"
  end

  def start_unicorn
    on roles(:app) do
      within current_path do
        execute :bundle, :exec, :unicorn, "-c #{fetch(:unicorn_config)} -E #{fetch(:rails_env)} -D"
      end
    end
  end

  def stop_unicorn
    on roles(:app) do
      execute :kill, "-s QUIT $(< #{fetch(:unicorn_pid)})"
    end
  end

  def restart_unicorn
    on roles(:app) do
      if test("[ -f #{fetch(:unicorn_pid)} ]")
        execute :kill, "-s USR2 $(< #{fetch(:unicorn_pid)})"
      else
        start_unicorn
      end
    end
  end

  def force_stop_unicorn
    on roles(:app) do
      execute :kill, "$(< #{fetch(:unicorn_pid)})"
    end
  end

  desc "Start unicorn server"
  task start: :environment do
    start_unicorn
  end

  desc "Stop unicorn server gracefully"
  task stop: :environment do
    stop_unicorn
  end

  desc "Restart unicorn server gracefully"
  task restart: :environment do
    restart_unicorn
  end

  desc "Stop unicorn server immediately"
  task force_stop: :environment do
    force_stop_unicorn
  end
end
