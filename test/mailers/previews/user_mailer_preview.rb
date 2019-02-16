# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def state_change_email
    photo = Photo.first
    UserMailer.state_change_email(photo)
  end
end
