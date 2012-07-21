class UsersController < Devise::SessionsController
  before_filter :authenticate_user!
  include ApplicationHelper

  def dashboard
    @user = current_user
    respond_to do |format|
      format.html # dashboard.html.erb
    end
  end

  def show

    #@user = get_profile(params).user
    @user = User.find(params[:id])   
    @following = Following.find_by_followable_type_and_followable_id_and_user_id("User",@user.id,current_user.id)


    @profile = @user.profile
    @events = Event.find_all_by_user_id(@user.id)
    session[:commentable_id] = @user.id
    session[:commentable_type] = @user.class  
    session[:followable_id] = @user.id
    session[:followable_type] = @user.class
    @comments = @user.comments.page(params[:page]).per(10)
    @comment = Comment.new
    @commentable = @user

    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
end