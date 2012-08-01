class AuthenticationsController < ApplicationController
  # GET /authentications
  # GET /authentications.json
  def index
    @authentications = current_user.authentications if current_user

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @authentications }
    end
  end


  # POST /authentications
  # POST /authentications.json
  def create
    omniauth = request.env["omniauth.auth"]

    a = current_user.authentications.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if a.nil?
      current_user.authentications.create(provider: omniauth.provider, uid: omniauth.uid, nickname: omniauth.info.nickname, token: omniauth.credentials.token)
    end

    flash[:notice] = "Authentication successful."
    redirect_to authentications_url    
  end


  # DELETE /authentications/1
  # DELETE /authentications/1.json
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy

    respond_to do |format|
      format.html { redirect_to authentications_url }
      format.json { head :no_content }
    end
  end

  def oauth_failure
    puts params.inspect
    flash[:notice] = "There was an error authenticating with your account"
    redirect_to authentications_url
  end

end
