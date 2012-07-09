require 'spec_helper'

describe ProfilesController do
login_user

  describe "GET show" do
    it "assigns the requested profile as @profile" do
      profile = FactoryGirl.create(:profile)
      get :show, {:user_name => profile.user_name}
      assigns(:profile).should eq(profile)
    end
  end

  # describe "GET edit" do
  #   it "assigns the requested profile as @profile" do
  #     user = FactoryGirl.create(:user, email: "ase33@sefije.com")
  #     profile = FactoryGirl.create(:profile, user_id: user.id)
  #     get :edit, {:id => profile.user_id}
  #     assigns(:profile).should eq(profile)
  #   end
  # end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "updates the requested profile" do
  #       profile = FactoryGirl.create(:profile)
  #       Profile.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
  #       put :update, {:id => profile.to_param, :profile => {'these' => 'params'}}
  #     end

  #     it "assigns the requested profile as @profile" do
  #       profile = FactoryGirl.create(:profile)
  #       put :update, {:id => profile.to_param, :profile => profile.attributes}
  #       assigns(:profile).should eq(profile)
  #     end

  #   end

  #   describe "with invalid params" do
  #     it "assigns the profile as @profile" do
  #       profile = FactoryGirl.create(:profile)
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Profile.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => profile.to_param, :profile => {}}
  #       assigns(:profile).should eq(profile)
  #     end

  #     it "re-renders the 'edit' template" do
  #       profile = FactoryGirl.create(:profile)
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Profile.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => profile.to_param, :profile => {}}
  #       response.should render_template("edit")
  #     end
  #   end
  # end


end
