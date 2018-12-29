Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :vkontakte, ENV['27a59c8d27a59c8d27a59c8d0f27c25462227a527a59c8d7b82e768530ae227ce45c8a8'], ENV['fXOWMBzt8k6KYr6FEQlF']

end

OmniAuth.config.on_failure do |env|
  error_type = env['omniauth.error.type']
  new_path = "#{env['SCRIPT_NAME']}#{OmniAuth.config.path_prefix}/failure?message=#{error_type}",[301, {'Location' => new_path, 'Content-Type' => 'text/html'}, []]
end
