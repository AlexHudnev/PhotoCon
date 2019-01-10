# like model
class Like < ActiveRecord::Base
  belongs_to :photo, counter_cache: :rating
  belongs_to :user
  validates :photo_id, uniqueness: { scope: :user_id }
end
