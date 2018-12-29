Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :vkontakte, ENV['6801647'], ENV['TQAAJspmTR3LFlielwkV']

end

OmniAuth.config.on_failure do |env|
  error_type = env['omniauth.error.type']
  new_path = "#{env['SCRIPT_NAME']}#{OmniAuth.config.path_prefix}/failure?message=#{error_type}",[301, {'Location' => new_path, 'Content-Type' => 'text/html'}, []]
end
