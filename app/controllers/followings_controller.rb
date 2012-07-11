class FollowingsController < ApplicationController
  # GET /followings
  # GET /followings.json
  def index
    @followings = Following.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @followings }
    end
  end


  # POST /followings
  # POST /followings.json
  def create
    @following = Following.new(params[:following])

    respond_to do |format|
      if @following.save
        format.html { redirect_to @following, notice: 'Following was successfully created.' }
        format.json { render json: @following, status: :created, location: @following }
      else
        format.html { render action: "new" }
        format.json { render json: @following.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /followings/1
  # DELETE /followings/1.json
  def destroy
    @following = Following.find(params[:id])
    @following.destroy

    respond_to do |format|
      format.html { redirect_to followings_url }
      format.json { head :no_content }
    end
  end
end
