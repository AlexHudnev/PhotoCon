# frozen_string_literal: true

module Photos
# create photo
  class Create < ActiveInteraction::Base
    string :name
    file :photography, default: nil
    object :user
    string :remote_photography_url, default: nil
    validates :name, presence: true

    def to_model
      Photo.new
    end

    def execute
      photo = user.photos.create!(name: name,photography: photography, remote_photography_url: remote_photography_url)
      unless photo.save
        errors.merge!(photo.errors)
      end
    end
  end
end
