class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    
    omniauth = request.env["omniauth.auth"]

    #puts omniauth.to_yaml
    user = User.from_omniauth(omniauth)

    if user.persisted?
      flash.notice = "Signed in!"
      sign_in_and_redirect user
    else
      	session["devise.user_attributes"] = user.attributes
   
		if current_user
			Authentication.create(nickname: omniauth.info.nickname,  
	              user_id: current_user.id, 
	              provider: omniauth.provider, 
	              uid: omniauth.uid)
			flash.notice = "Authenticated!"
			sign_in_and_redirect current_user
		else
		  hash = omniauth.slice(:provider, :uid)
	      hash.email = omniauth.info.email
	      hash.nickname = omniauth.info.nickname
	      session["devise.omniauth_attributes"] = hash
	      redirect_to new_user_registration_url
	    end
	end
  end # End All

  alias_method :facebook, :all
  alias_method :youtube, :all
end # End Controller