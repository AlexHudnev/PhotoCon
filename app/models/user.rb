# frozen_string_literal: true

# User model
class User < ActiveRecord::Base
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_secure_token :authenticity_token

  class << self
    def from_omniauth(auth_hash)
      user = User.where(uid: auth_hash['uid']).first
      helper = UsersHelper::Create.new
      helper.execute(auth_hash, user)
    end
  end

  def set_access_token
    self.authenticity_token = generate_token
  end

  private

  def generate_token
    loop do
      token = SecureRandom.hex(10)
      break token unless User.where(authenticity_token: token).exists?
    end
  end
end
