# frozen_string_literal: true

module Comments
  class Acieve < ActiveInteraction::Base
    object :photo

    def execute
      photo.comments.create(body: 'Красавчеек',
                            user_id: User.find_by(moderator: true).id,
                            parent_comment_id: nil)
    end
  end
end
