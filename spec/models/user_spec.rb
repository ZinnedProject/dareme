require 'spec_helper'

describe User do
	it "has a valid factoryGirl" do
		FactoryGirl.create(:user, email: "3f3ok@gmail.com").should be_valid
	end

	before do
  	@user = FactoryGirl.create(:user)

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
  		@profile = FactoryGirl.create(:profile, user_id: @user.id)
  		@user.profile.should eq(@profile)
  	end
  	it "Should respond to an event" do   		
  		@event = FactoryGirl.create(:event, user_id: @user.id)
  		@user.events.first.should eq(@event)
  	end
  	it "Should respond to a comment I've left" do   		
  		@comment = FactoryGirl.create(:comment, user_id: @user.id)
  		@user.comments.first.should eq(@comment)
  	end
  	it "Should respond to followings (show a list of people who I am following" do
			@user2 = FactoryGirl.create(:user, email:"asdfdf@aseij.com")
			@follower = FactoryGirl.create(:following, user_id: @user.id, followable:@user2)
   		@user.follows.first.should eq(@follower)
  	end
  	it "Should respond to followers (show a list of people who are following me" do
			@user2 = FactoryGirl.create(:user, email:"asdfdf@aseij.com")
			@follower = FactoryGirl.create(:following, user_id: @user2.id, followable:@user)
   		@user.followers.first.should eq(@user2)
  	end
  	it "Should respond to followed_user" do
			@user2 = FactoryGirl.create(:user, email:"asdfdf@aseij.com")
			@follower = FactoryGirl.create(:following, user_id: @user.id, followable:@user2)
   		@user.followed_users.first.should eq(@user2)
  	end
  	it "Should respond to followed_events" do
			@event = FactoryGirl.create(:event, user_id: @user.id)
			puts @event.to_yaml
			@follower = FactoryGirl.create(:following, user_id: @user.id, followable:@event)
   		@user.followed_events.first.should eq(@event)
  	end
	end


end
