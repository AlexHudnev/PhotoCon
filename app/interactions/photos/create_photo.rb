# frozen_string_literal: true

# create photo
class CreatePhoto < ActiveInteraction::Base
  string :photo_name
  file :photography
  object :user

  validates :photo_name, presence: true

  def to_model
    Photo.new
  end

  def execute
    photo = user.photos.create!(photo_name: photo_name,photography: photography)
    unless photo.save
      errors.merge!(photo.errors)
    end
  end
end
