require 'spec_helper'

describe User do
	it "has a valid factoryGirl" do
		FactoryGirl.create(:user, email: "3f3ok@gmail.com").should be_valid
	end

	before do
  	@user = FactoryGirl.create(:user)
		@profile = FactoryGirl.create(:profile, user_id: @user.id)
		@event = FactoryGirl.create(:event, user_id: @user.id)
		@comment = FactoryGirl.create(:comment, user_id: @user.id)
  end

	subject { @user }

	describe "attributes" do
		it { should respond_to(:email) }
		it { should respond_to(:password) }
		it { should respond_to(:password_confirmation) }
		it { should respond_to(:remember_me) }
	end

	describe "when email address is already taken" do
		it  "should not be valid" do
			user_with_same_email = @user.dup
			user_with_same_email.save.should_not be_true
			end
	end
	describe "create_profile" do
		it "should create a new profile after a user gets created" do
			@user.save!
			@user.profile.nil?.should be_false
		end
	end
	

	describe "Associations" do
  	it "Should respond to a user" do
  		@user.profile.should eq(@profile)
  	end
  	it "Should respond to an event" do   		
  		@user.events.first.should eq(@event)
  	end
  	it "Should respond to a comment I've left" do   		
  		@user.comments.first.should eq(@comment)
  	end

	end


end
