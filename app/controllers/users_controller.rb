class UsersController < Devise::SessionsController
  before_filter :authenticate_user!
  include ApplicationHelper

  def show

    #@user = get_profile(params).user
    @user = User.find(params[:id])
    @profile = @user.profile
    @events = Event.find_all_by_user_id(@user.id)
    session[:followable_id] = @user.id
    session[:followable_type] = @user.class  
    @comments = @user.comments.page(params[:page]).per(10)
    @comment = Comment.new
    @commentable = @user

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @profile }
    end
  end
  
end