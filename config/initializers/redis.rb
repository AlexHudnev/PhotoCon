# frozen_string_literal: true

uri = URI.parse('redis://localhost:6379/')
uri = URI.parse(ENV['REDIS_URL']) if Rails.env.production?
REDIS = Redis.new(url: uri)
