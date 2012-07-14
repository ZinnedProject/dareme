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

    #Videos
    @request_video = @event.videos.request_video
    @proof_video = @event.videos.proof_video

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  def edit
    @event = Event.find(params[:id])
        #Videos
    @request_video = @event.videos.request_video
    @proof_video = @event.videos.proof_video

    puts @request_video.to_yaml
    puts @request_video.class
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
end
