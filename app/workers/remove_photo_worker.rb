# frozen_string_literal: true

class RemovePhotoWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(photo_id)
    photo = Photo.find(photo_id)
    return unless photo.banned? || photo.deleted?

    photo.remove_photography!
    photo.destroy
  end
end
