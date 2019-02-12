# frozen_string_literal: true

if Rails.env.development?
  unless AdminUser.find_by(email: 'admin@example.com')
    AdminUser.create!(email: 'admin@example.com',
                      password: 'password',
                      password_confirmation: 'password')
  end
end

unless User.find_by(access_token: 'abracadabra', uid: 'abracadabra')
  User.create!(access_token: 'abracadabra', uid: 'abracadabra',
               first_name: 'Модератор', last_name: 'Великий',
               email: 'moderator@examle.com',
               image_url: '/assets/log.png',
               url: '1', moderator: true)
end
