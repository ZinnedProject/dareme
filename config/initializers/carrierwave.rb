CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                         # required
    :aws_access_key_id      => ENV['AWS_ACCESS'],       # required
    :aws_secret_access_key  => ENV['AWS_SECRET'],       # required
#    :region                 => 'US-Standard'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'dm.pf.images'                          # required
  #config.fog_host       = 'http://localhost:3000'            # optional, defaults to nil
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end