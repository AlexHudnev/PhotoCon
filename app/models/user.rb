# frozen_string_literal: true

# User model
class User < ActiveRecord::Base
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  class << self
    def from_omniauth(auth_hash)
      user = User.where(uid: auth_hash['uid']).first
      helper = UsersHelper::Create.new
      helper.execute(auth_hash, user)
    end
  end
end
