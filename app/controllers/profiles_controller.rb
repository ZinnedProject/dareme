class ProfilesController < ApplicationController
  before_filter :authenticate_user!

  def show

    if params[:user_name].nil?
      @profile = current_user.profile
    else
      @profile = Profile.find_by_user_name(params[:user_name].downcase)
    end

    @events = Event.find_all_by_user_id(@profile.user_id)
    @comments = current_user.profile.comments.paginate(:page => params[:page], :per_page => 10)
    
    @comment = Comment.new
    @commentable = @profile

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @profile }
    end
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to '/profile/'+@profile.user_name, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

end
