class UsersController < Devise::SessionsController
  before_filter :require_login

  def require_login
    unless user_signed_in?
      redirect_to new_user_session_path, flash: {:error => "You must be logged in to continue to access this section"}
    end
  end

  #before_filter :authenticate_user!


  def dashboard
    @notifications = current_user.follows.joins('INNER JOIN notifications ON followings.followable_id = notifications.notifiable_id AND followings.followable_type = notifications.notifiable_type').select('*')    
    @followed_users = current_user.followed_users.includes(:profile)
    @followed_events = current_user.followed_events

    respond_to do |format|
      format.html # dashboard.html.erb
    end
  end

  def show
    @user = User.find(params[:id])   
    @following = Following.find_by_followable_type_and_followable_id_and_user_id("User",@user.id,current_user.id)

   # @user =@user.includes(:profile)
    @profile = @user.profile
    #@events = Event.find_all_by_user_id(@user.id)
    session[:commentable_id] = @user.id
    session[:commentable_type] = @user.class  
    session[:followable_id] = @user.id
    session[:followable_type] = @user.class
    @comments = @user.comments.includes(:user).page(params[:page]).per(10)
    @comment = Comment.new
    @commentable = @user

    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
end