require 'spec_helper'
describe CommentsController do
  before(:each) do
    request.env["HTTP_REFERER"] = "where_I_came_from"    
  end

  describe "POST create" do
  login_user
    # describe "with valid params" do
    #   it "creates a new Comment" do
    #     @event =  FactoryGirl.create(:event,   user_id: subject.current_user.id)
    #     expect {
    #       post :create, comment: {content: "fefe"}, :event_id => @event.id
    #     }.to change(Comment, :count).by(1)
    #   end

    #   it "assigns a newly created comment as @comment" do
    #     @event =  FactoryGirl.create(:event,   user_id: subject.current_user.id)
    #     post :create, :comment => {content: "Fefe"}, :event_id => @event.id
    #     assigns(:comment).should be_a(Comment)
    #     assigns(:comment).should be_persisted
    #   end
    # end
  end

  describe "DELETE destroy" do
    it "destroys the requested comment" do
      comment = FactoryGirl.create(:comment)
      expect {
        delete :destroy, {:id => comment.id}
      }.to change(Comment, :count).by(-1)
    end
  end

end
