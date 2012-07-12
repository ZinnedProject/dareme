require 'spec_helper'

describe FollowingsController do


   describe "POST create" do
     describe "with valid params" do
       # it "creates a new Following" do
       #   expect {
           
       #     post :create, {:following => FactoryGirl.build(:following)}
       #   }.to change(Following, :count).by(1)
       # end

  #     it "assigns a newly created following as @following" do
  #       post :create, {:following => valid_attributes}
  #       assigns(:following).should be_a(Following)
  #       assigns(:following).should be_persisted
  #     end

  #     it "redirects to the created following" do
  #       post :create, {:following => valid_attributes}
  #       response.should redirect_to(Following.last)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved following as @following" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Following.any_instance.stub(:save).and_return(false)
  #       post :create, {:following => {}}
  #       assigns(:following).should be_a_new(Following)
  #     end

  #     it "re-renders the 'new' template" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Following.any_instance.stub(:save).and_return(false)
  #       post :create, {:following => {}}
  #       response.should render_template("new")
  #     end
     end
   end


  # describe "DELETE destroy" do
  #   it "destroys the requested following" do
  #     following = Following.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => following.to_param}
  #     }.to change(Following, :count).by(-1)
  #   end

  #   it "redirects to the followings list" do
  #     following = Following.create! valid_attributes
  #     delete :destroy, {:id => following.to_param}
  #     response.should redirect_to(followings_url)
  #   end
  # end

end
