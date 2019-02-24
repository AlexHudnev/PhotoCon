# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'noreply@photocon.com'

  def state_change_email(photo,state)
    @user = User.find_by(id: photo.user_id)
    return unless @user.email

    @photo = photo
    @state = state
    mail to: @user.email, subject: 'State changed'
  end
end
