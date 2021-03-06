class CommentsController < ApplicationController

  def create

    if session[:commentable_type].to_s == 'User'
      @commentable = User.find(session[:commentable_id].to_i)
    elsif session[:commentable_type].to_s == 'Event'
      @commentable = Event.find(session[:commentable_id].to_i)
    end

    @comment = @commentable.comments.new(params[:comment])
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @commentable, notice: 'Comment was successfully created.' }
        format.json { render json: @commentable, status: :created, location: @comment }
      else
        format.html { redirect_to :back, notice: 'Sorry we were unable to save your comment' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end



end
