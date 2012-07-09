class CommentsController < ApplicationController
  before_filter :load_commentable

  def create
    @comment = @commentable.comments.new(params[:comment])
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back, notice: 'Comment was successfully created.' }
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

   def load_commentable
    if params[:profile_id]
      @commentable = Profile.find(params[:profile_id])
    elsif params[:event_id]
      @commentable = Event.find(params[:event_id])
    end

   end



end
