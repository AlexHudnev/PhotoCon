# frozen_string_literal: true

module Users
  class Create < ActiveInteraction::Base
    hash :auth_hash
    object :user


    def update
      photo_acces
    end

    def execute
      puts(auth_hash)
      return update if user

      user = create(uid: auth_hash['uid'],
                    access_token: auth_hash['credentials']['token'])
      user.image_url = auth_hash['extra']['raw_info']['photo_200_orig']
      name_email_url auth_hash, user
    end

    private

    def photo_acces
      user.access_token = auth_hash['credentials']['token']
      user.image_url = auth_hash['extra']['raw_info']['photo_200_orig']
      user.url = auth_hash['info']['urls']['Vkontakte']
      user.save!
      user
    end

    def name_email_url(auth_hash, user)
      user.first_name = auth_hash['info']['first_name']
      user.last_name = auth_hash['info']['last_name']
      user.url = auth_hash['info']['urls']['Vkontakte']
      user.email = auth_hash['info']['email'] if auth_hash['info']['email']
      user.save!
      user
    end
  end
end
