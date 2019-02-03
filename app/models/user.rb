# frozen_string_literal: true

# User model
class User < ActiveRecord::Base
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, through: :photos
  class << self
    def from_omniauth(auth_hash)
      unless user = User.where(uid: auth_hash['uid']).first
        user = find_or_create_by(uid: auth_hash['uid'], access_token: auth_hash['provider'])
        user.first_name = auth_hash['info']['first_name']
        user.last_name = auth_hash['info']['last_name']
        user.email = auth_hash['info']['email'] if auth_hash['info']['email']
        user.image_url = auth_hash['extra']['raw_info']['photo_400_orig']
        user.url = auth_hash['info']['urls'][user.access_token.capitalize]
        user.save!
        return user
      end
      user
    end
  end
end
