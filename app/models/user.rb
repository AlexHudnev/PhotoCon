# frozen_string_literal: true

# User model
class User < ActiveRecord::Base
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  class << self
    def from_omniauth(auth_hash)
      unless (user = User.where(uid: auth_hash['uid']).first)
        user = create(uid: auth_hash['uid'],
                      access_token: auth_hash['credentials']['token'])
        user.image_url = auth_hash['extra']['raw_info']['photo_200_orig']
        return name_email_url auth_hash, user
      end
      photo_acces auth_hash, user
    end

    private

    def photo_acces(auth_hash, user)
      user.access_token = auth_hash['credentials']['token']
      user.image_url = auth_hash['extra']['raw_info']['photo_200_orig']
      user.url = auth_hash['info']['urls']['Vkontakte']
      user.save!
      user
    end

    def name_email_url(auth_hash, user)
      user.first_name = auth_hash['info']['first_name']
      user.last_name = auth_hash['info']['last_name']
      user.email = auth_hash['info']['email'] if auth_hash['info']['email']
      user.save!
      user
    end
  end
end
