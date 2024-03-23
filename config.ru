# This file is used by Rack-based servers to start the application.

require_relative "config/production"

run Rails.application

# Production環境を指定
ENV['RAILS_ENV'] ||= 'production'
