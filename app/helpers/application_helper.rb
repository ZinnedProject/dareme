module ApplicationHelper
	def get_profile(params)
		if params[:user_name].nil?
      @profile = current_user.profile
    else
      @profile = Profile.find_by_user_name(params[:user_name].downcase)
    end
  	return @profile
  end
  
end
