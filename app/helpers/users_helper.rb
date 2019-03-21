# frozen_string_literal: true

module UsersHelper
  class Create
    def execute(auth_hash, user)
      return photo_acces(auth_hash, user) if user

      user = User.create(uid: auth_hash['uid'],
                         access_token: auth_hash['credentials']['token'])
      user.image_url = auth_hash['extra']['raw_info']['photo_200_orig']
      name_email_url auth_hash, user
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
      user.url = auth_hash['info']['urls']['Vkontakte']
      user.ban = true if $ban_list.include?(user.uid)
      user.email = auth_hash['info']['email'] if auth_hash['info']['email']
      user.set_access_token
      user.save!
      user
    end
  end
end
