Rails.application.config.middleware.use OmniAuth::Builder do
  provider :youtube, ENV['YOUTUBE_KEY'], ENV['YOUTUBE_SECRET'], {:access_type => 'offline', :approval_prompt => ''}
end