source 'https://rubygems.org'

gem 'rails', '3.2.6'

gem 'pg', '~> 0.13.2'
gem 'thin'
gem 'devise'

#Loading and dumping database data
#rake db:data:dump   ->   Dump contents of Rails database to db/data.yml
#rake db:data:load   ->   Load contents of db/data.yml into the database

gem 'yaml_db'			#https://github.com/ludicast/yaml_db

gem 'execjs'
#gem 'therubyracer'
#gem 'bootstrap-sass', ['~> 2.0', '>= 2.0.3']
#https://github.com/seyhunak/twitter-bootstrap-rails/

#Image processing
	gem 'carrierwave'
	gem "rmagick"		#sudo apt-get install libmagickwand-dev
	gem "mini_magick"	
	gem "fog", "~> 1.3.1"

#Simply URL helper
	gem 'friendly_id'


#Authentications
	gem 'omniauth', :git => 'git://github.com/intridea/omniauth.git'
	gem 'omniauth-oauth2', :git => 'git://github.com/intridea/omniauth-oauth2.git'
	gem 'omniauth-youtube', :git => 'git://github.com/jamiew/omniauth-youtube.git'

	gem 'authbuttons-rails'
#	gem 'omniauth-google-oauth2'		#https://github.com/intridea/omniauth/wiki'
#Background Jobs
#	gem "queue_classic", "2.0.0"

#Pagination
	#gem 'will_paginate', '~> 3.0' --WARNING: Uses GEM kaminari for RAILS_ADMIN

#Acts as votable
	gem 'thumbs_up'

#Youtube Gem
	gem 'youtube_it'

#Get the location of an event
	gem 'geocoder'

#WYSIWYG Editor
	gem 'ckeditor', "3.7.1" 				#https://github.com/galetahub/ckeditor

#Administrative tool for manually editing records
	gem 'rails_admin'

	gem 'chosen-rails'	#Nice looking JQuery multi-select boxes
	gem 'jquery-rails'

group :development, :test do
	gem 'quiet_assets'	#Removes asset pipelines in logger window
	gem 'rspec-rails'
	gem 'guard-rspec'
	gem 'jasmine-rails'
	gem "factory_girl_rails", "~> 3.0"
	gem 'debugger'	#Rails Debugger
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test do
	gem 'rspec-rails'
	gem 'capybara'
	gem 'rb-fsevent', :require => false
	gem 'growl'
	gem 'guard-spork', :git => 'git://github.com/guard/guard-spork.git'
	gem 'spork'
	gem 'shoulda'	#Extra testing help
	gem 'rb-inotify', '0.8.8'
  gem 'libnotify', '0.5.9'
end

