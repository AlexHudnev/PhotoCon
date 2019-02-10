# frozen_string_literal: true

class AchievementWorker
  include Sidekiq::Worker

  def perform(photo_id)
    @photo = Photo.find(photo_id)
    Comments::Create.run(comment_params) if @photo.rating == 3
  end

  private

  def comment_params
    { photo: @photo, user: User.find_by(moderator: true),
      body: 'Красавчеек' }
  end
end
