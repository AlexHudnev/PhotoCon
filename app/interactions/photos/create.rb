# frozen_string_literal: true

module Photos
  class Create < ActiveInteraction::Base
    string :name
    string :description, default: nil
    file :photography, default: nil
    object :user
    string :remote_photography_url, default: nil
    validates :name, presence: true
    validate(:photography || :remote_photography_url)

    def to_model
      Photo.new
    end

    def execute
      photo = user.photos.create!(name: name, photography: photography,
                                  description: description,
                                  remote_photography_url: remote_photography_url)
      ActionCable.server.broadcast 'ReportsChannel', report: photo.to_json
      errors.merge!(photo.errors) unless photo.save
    end
  end
end
