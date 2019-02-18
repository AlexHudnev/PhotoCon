# frozen_string_literal: true

# photo model
class Photo < ApplicationRecord
  include AASM
  require 'kaminari'
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  scope :by_approve, -> { where(aasm_state: :approved) }
  default_scope -> { order(created_at: :desc) }
  scope :by_rating, -> { reorder(rating: :desc) }
  mount_uploader :photography, ImageUploader
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 64, minimum: 3 }
  validates :photography, presence: true

  def share(url)
    ref = 'http://vk.com/share.php?url=' + url
    ref + '&title=' + name + '&noparse=false'
  end
  aasm do
    state :moderated, initial: true
    state :approved
    state :banned
    event :approve do
      transitions from: :moderated, to: :approved
      transitions from: :banned, to: :approved
    end

    event :ban do
      transitions from: :moderated, to: :banned
      transitions from: :approved, to: :banned
    end
  end
end
