class RemovePhotoWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(photo_id)
    photo = Photo.find(photo_id)
    if photo.banned?
      photo.remove_photography!
      photo.likes.each { |like| like.destroy }
      photo.comments.each { |comment| comment.destroy }
      photo.destroy
      photo.destroy
    end
  end
end
