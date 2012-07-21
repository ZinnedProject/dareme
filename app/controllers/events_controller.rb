class EventsController < ApplicationController
  before_filter :authenticate_user!


  def index
    @type = params[:index_type]
    @query = params[:query]

    if not @query.nil?
      @events = Event.text_search(@query).default_order.limit_me
    elsif @type == 'local'  #This needs some work.  Very non optimal especially if having a ton of events
      @events = Event.all
      @events.sort! {|a,b| Geocoder::Calculations.distance_between([current_user.profile.latitude,current_user.profile.longitude],[a.latitude,a.longitude]) <=> Geocoder::Calculations.distance_between([current_user.profile.latitude,current_user.profile.longitude],[b.latitude,b.longitude]) }
    elsif @type == 'completed'
      @events = Event.completed.default_order.limit_me
    elsif @type == 'most_popular_open'
      @events = Event.open.popular.limit_me    
    elsif @type == 'most_popular_completed'
      @events = Event.completed.popular.limit_me
    else
      @events = Event.open.default_order.limit_me
    end

    if @events.kind_of?(Array) then
      @events = Kaminari.paginate_array(@events).page(params[:page]).per(10)
    else
      @events = @events.page(params[:page]).per(10)
    end

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
#    if not current_user.authentications.youtube.exists? then
#      redirect_to authentications_path, notice: 'Please authenticate with Youtube before creating an event!' 
#    else
      @event = Event.new
#    end    
  end

  def vote_for
    @event = Event.find(params[:id])
    if current_user.voted_on?(@event) then
      Vote.find_by_voteable_id_and_voteable_type(@event.id, 'Event').destroy
    else
      current_user.vote_exclusively_for(@event)
      respond_to do |format|
        format.js
      end
    end
  end

  def vote_against
    @event = Event.find(params[:id])
    if current_user.voted_on?(@event) then
      Vote.find_by_voteable_id_and_voteable_type(@event.id, 'Event').destroy
    else
      current_user.vote_exclusively_against(@event)
      respond_to do |format|
        format.js
      end
    end
  end


  def edit
    @event = Event.find(params[:id])
  #   auth = current_user.authentications.youtube.first

  # require 'faraday'

  # conn = Faraday.new(:url => 'https://accounts.google.com',:ssl => {:verify => false}) do |faraday|
  #  faraday.request  :url_encoded
  #  faraday.response :logger
  #  faraday.adapter  Faraday.default_adapter
  # end

  # results = conn.post '/o/oauth2/token', {'code' => auth.token,
  # 'client_id' => ENV['YOUTUBE_KEY'],
  # 'client_secret' => ENV['YOUTUBE_SECRET'],
  # 'redirect_uri' => "http://localhost:3000/auth/youtube/callback&",
  # 'grant_type' => 'authorization_code'}

  #   client = YouTubeIt::OAuth2Client.new(
  #    client_access_token: auth.token, 
  #    client_id: ENV['YOUTUBE_KEY'], 
  #    client_secret: ENV['YOUTUBE_SECRET'], 
  #    dev_key: ENV['YOUTUBE_DEV'])
   
#   puts "-------------------------results>"
 #  puts results.to_yaml
  # puts "---------------------__>end results"

#puts results.body.to_yaml
#    a = client.my_videos
    #puts a.to_yaml
  end

  def create
    @event = Event.new(params[:event])
    @event.user_id = current_user.id

    respond_to do |format|
      if @event.save
        Following.create(user_id: current_user.id, followable: @event)
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

