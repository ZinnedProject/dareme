class FollowingsController < ApplicationController
include ApplicationHelper

  def index
    @followings = Following.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @followings }
    end
  end

  def create
    if session[:followable_type].to_s == 'User'
      @followable = User.find(session[:followable_id].to_i)
    elsif session[:followable_type].to_s == 'Event'
      @followable = Event.find(session[:followable_id].to_i)
    end

    @following = Following.new(followable: @followable, user_id:current_user.id )  

    #Rails.logger.info("PARAMS: #{params.inspect}")   
    respond_to do |format|
      if @following.save
        format.html { redirect_to :back, notice: 'Are are now following...' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @following = Following.find_by_id(params[:id])  
    if @following.followable_type == 'User' then
      @f = User.find(@following.followable_id.to_i)
    elsif @following.followable_type == 'Event' then
      @f = Event.find(@following.followable_id.to_i)
    end

   @following.destroy if Following.find_by_id_and_user_id(@following.id, @following.user_id)

    respond_to do |format|
      format.html { redirect_to @f, notice: "You are no longer following..." }
      format.json { head :no_content }
    end
  end
end
