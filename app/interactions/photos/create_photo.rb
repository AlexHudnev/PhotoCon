# frozen_string_literal: true

# create photo
class CreatePhoto < ActiveInteraction::Base
  string :name
  file :photography
  object :user

  validates :name, presence: true

  def to_model
    Photo.new
  end

  def execute
    photo = user.photos.create!(name: name,photography: photography)
    unless photo.save
      errors.merge!(photo.errors)
    end
  end
end
