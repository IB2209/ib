after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  desc 'Restart unicorn server'
  task :restart do
    on roles(:app) do
      invoke 'unicorn:restart'
    end
  end
end
