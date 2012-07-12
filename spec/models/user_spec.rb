require 'spec_helper'

describe User do
	it "has a valid factoryGirl" do
		FactoryGirl.create(:user, email: "3f3ok@gmail.com", slug: 'testslugy').should be_valid
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
  	it "Should respond to a profile" do
  		@profile = FactoryGirl.create(:profile, user_id: @user.id)
  		@user.profile.should eq(@profile)
  	end
  	it "Should respond to an event" do   		
  		@event = FactoryGirl.create(:event, user_id: @user.id)
  		@user.events.first.should eq(@event)
  	end
  	it "Should respond to a comments_made" do   		
  		@user2 = FactoryGirl.create(:user, email:"asdfdf@aseij.com", slug: 'testslugy')
  		@comment = FactoryGirl.create(:comment, user_id: @user.id, commentable: @user2)
   		@user.comments_made.first.should eq(@comment)
  	end
  	it "Should respond to a comments" do   		
  		@user2 = FactoryGirl.create(:user, email:"asdfdf@aseij.com", slug: 'testslugy')
  		@comment = FactoryGirl.create(:comment, user_id: @user.id, commentable: @user2)
   		@user2.comments.first.should eq(@comment)
  	end
  	it "Should respond to a comments_senders" do   		
  		@user2 = FactoryGirl.create(:user, email:"asdfdf@aseij.com", slug: 'testslugy')
  		@comment = FactoryGirl.create(:comment, user_id: @user.id, commentable: @user2)
   		@user2.comments_senders.first.should eq(@user)
  	end

  	it "Should respond to followings (show a list of people who I am following" do
			@user2 = FactoryGirl.create(:user, email:"asdfdf@aseij.com", slug: 'testslugy')
			@follower = FactoryGirl.create(:following, user_id: @user.id, followable:@user2)
   		@user.follows.first.should eq(@follower)
  	end
  	it "Should respond to followers (show a list of people who are following me" do
			@user2 = FactoryGirl.create(:user, email:"asdfdf@aseij.com", slug: 'testslugy')
			@follower = FactoryGirl.create(:following, user_id: @user2.id, followable:@user)
   		@user.followers.first.should eq(@user2)
  	end
  	it "Should respond to followed_user" do
			@user2 = FactoryGirl.create(:user, email:"asdfdf@aseij.com", slug: 'testslugy')
			@follower = FactoryGirl.create(:following, user_id: @user.id, followable:@user2)
   		@user.followed_users.first.should eq(@user2)
  	end
  	it "Should respond to followed_events" do
			@event = FactoryGirl.create(:event, user_id: @user.id)			
			@follower = FactoryGirl.create(:following, user_id: @user.id, followable:@event)
   		@user.followed_events.first.should eq(@event)
  	end
	end

  describe "validations" do 
    it "should not be valid if slug is nil" do
      @user.should validate_presence_of :slug
    end 
    it "should not be valid if slug has more than letter and numbers" do
      @user.slug = "8*78f8%"
      @user.save.should be_false
    end 
    it "should not be valid if slug has reserved names" do
      @user.slug = "contact"
      @user.save.should be_false
    end 
    it "should not be valid if slug is to long" do
      @user.slug = "contact35g57835363338683753535353yusgfuihdhjsfguih4t879gryugdhj"
      @user.save.should be_false
    end 
    it "should not be valid if slug is not unique" do
      @user.slug = "coji"
      @user.save
      @user2 = @user
      @user2.id = nil
      @user2.slug = 'coJi'
      @user2.save.should be_false
    end 
    it "should not be valid if slug is to short" do
      @user.slug = "con"
      @user.save.should be_false
    end 
  end

  describe "Callbacks" do
    it "should downcase the slug when storing" do
      @user.slug = "DiddyDog"
      @user.save
      @user.slug.downcase.should be_true
    end
  end

end
