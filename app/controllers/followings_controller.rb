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
    @following = Following.new(followable:get_profile(params).user, user_id:current_user.id )  

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
    @following = Following.find(params[:id])
    @following.destroy

    respond_to do |format|
      format.html { redirect_to followings_url }
      format.json { head :no_content }
    end
  end
end
