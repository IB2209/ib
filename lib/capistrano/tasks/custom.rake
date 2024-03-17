# custom.rake

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  desc 'Restart unicorn server'
  task :restart do
    invoke 'unicorn:restart'
  end
end
