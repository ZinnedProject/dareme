OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :youtube, ENV['YOUTUBE_KEY'], ENV['YOUTUBE_SECRET'], {:access_type => 'offline', :approval_prompt => ''}
#  provider :google_oauth2, ENV['YOUTUBE_KEY'], ENV['YOUTUBE_SECRET'], {access_type: 'offline', approval_prompt: '', scope:'http://gdata.youtube.com'}
#provider :google_oauth2, ENV['YOUTUBE_KEY'], ENV['YOUTUBE_SECRET'], {access_type: 'offline', approval_prompt: ''}
#	if Rails.env.development?
#		OmniAuth.config.full_host = "http://127.0.0.1:3000"
#	end
		#OmniAuth.config.on_failure = AuthenticationsController.action(:oauth_failure)
end