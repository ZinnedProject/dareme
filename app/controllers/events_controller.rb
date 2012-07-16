class EventsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @events = Event.default_order

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def show
    @event = Event.find(params[:id])
    @following = Following.find_by_followable_type_and_followable_id_and_user_id("Event",@event.id,current_user.id)
    @comments = @event.comments.page(params[:page]).per(10)
    @comment = Comment.new
    @commentable = @event
    
    #Session variables for polymorphics
    session[:commentable_id] = @event.id
    session[:commentable_type] = @event.class  
    session[:followable_id] = @event.id
    session[:followable_type] = @event.class

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end
  def new
    if not current_user.authentications.youtube.exists? then
      redirect_to authentications_path, notice: 'Please authenticate with Youtube before creating an event!' 
    else
      @event = Event.new
    end    
  end

  def edit
    @event = Event.find(params[:id])
    puts "fesdfasdfasdfasf879239"
    auth = current_user.authentications.youtube.first
    puts auth.to_yaml
  
 require 'faraday'

 conn = Faraday.new(:url => 'https://accounts.google.com',:ssl => {:verify => false}) do |faraday|
   faraday.request  :url_encoded
   faraday.response :logger
   faraday.adapter  Faraday.default_adapter
  end
puts conn.to_yaml
 results = conn.post '/o/oauth2/token', {'code' => auth.token,
 'client_id' => ENV['YOUTUBE_KEY'],
 'client_secret' => ENV['YOUTUBE_SECRET'],
 'redirect_uri' => "http://localhost:3000/auth/youtube/callback",
 'grant_type' => 'authorization_code'}

 puts results.body.inspect

    #    @yt_session ||= YouTubeIt::Client.new(:username => YouTubeITConfig.username , :password => YouTubeITConfig.password , :dev_key => YouTubeITConfig.dev_key)    
    # @client = YouTubeIt::OAuth2Client.new(
    #   client_access_token: auth.token, 
    #   client_refresh_token: "refresh_token", 
    #   client_id: ENV['YOUTUBE_KEY'], 
    #   client_secret: ENV['YOUTUBE_SECRET'], 
    #   dev_key: ENV['YOUTUBE_DEV'],
    #   expires_at: "expiration time")

    puts @client.to_yaml

  end

  def create
    @event = Event.new(params[:event])
    @event.user_id = current_user.id

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def upload
    @upload_info = YouTubeIt::Client.new.upload_token(params, videos_url)
  end


end
