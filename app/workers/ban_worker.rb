# frozen_string_literal: true

class BanWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    user.ban = false
    user.save
    Redis.current.del(user.uid)
  end
end
