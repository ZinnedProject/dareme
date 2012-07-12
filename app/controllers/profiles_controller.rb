class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  
  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to '/profile/'+@profile.slug, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

end
