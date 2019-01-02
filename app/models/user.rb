class User < ActiveRecord::Base

has_many :photos
has_many :comments
has_many :likes, through: :photos
class << self
	  def from_omniauth(auth_hash)

	    user = find_or_create_by(uid: auth_hash['uid'], access_token: auth_hash['provider'])
	    user.first_name = auth_hash['info']['first_name']
	user.last_name = auth_hash['info']['last_name']
         user.email = auth_hash['info']['email'] if auth_hash['info']['email']

	    user.image_url = auth_hash['info']['image']

	    user.url = auth_hash['info']['urls'][user.access_token.capitalize]
	    user.save!
	    user

	end
end
end
