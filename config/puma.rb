# config/puma.rb

environment 'production'
threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
threads threads_count, threads_count
port        ENV.fetch('PORT') { 3000 }
preload_app!

rackup      DefaultRackup
workers     ENV.fetch('WEB_CONCURRENCY') { 2 }
on_worker_boot do
  ActiveRecord::Base.establish_connection
end
