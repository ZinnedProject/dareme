require 'spec_helper'

describe Profile do
	it "has a valid factoryGirl" do
		FactoryGirl.create(:profile, user_name: "fefeefefe").should be_valid
	end

	before do
  	@profile = FactoryGirl.create(:profile)
  end

	subject { @profile }

	describe "attributes" do
		it { should respond_to(:about) }
		it { should respond_to(:first_name) }
		it { should respond_to(:last_name) }
		it { should respond_to(:user_id) }
		it { should respond_to(:user_name) }
		it { should respond_to(:image) }
		it { should respond_to(:remote_image_url) }
		it { should respond_to(:created_at) }
		it { should respond_to(:updated_at) }
	end

	describe "Associations" do
		before do	
			@user = FactoryGirl.create(:user)
			@profile.user_id = @user.id
  	end

  	it "Should respond to a user" do
  		@profile.user.should eq(@user)
  	end
	end

	describe "Validations" do
		it "should not be valid if user_id is nil" do
			@profile.should validate_presence_of :user_id
		end  
		it "should not be valid if user_name is nil" do
			@profile.should validate_presence_of :user_name
		end 
		it "should not be valid if user_name has more than letter and numbers" do
			@profile.user_name = "8*78f8%"
			@profile.save.should be_false
		end 
		it "should not be valid if user_name has reserved names" do
			@profile.user_name = "contact"
			@profile.save.should be_false
		end 
		it "should not be valid if user_name is to long" do
			@profile.user_name = "contact35g57835363338683753535353yusgfuihdhjsfguih4t879gryugdhj"
			@profile.save.should be_false
		end 
		it "should not be valid if user_name is not unique" do
			@profile.user_name = "coji"
			@profile.save
			@profile2 = @profile
			@profile2.id = nil
			@profile2.user_name = 'coJi'
			@profile2.save.should be_false
		end 
		it "should not be valid if user_name is to short" do
			@profile.user_name = "con"
			@profile.save.should be_false
		end 

	end
	
	describe "Callbacks" do
		it "should downcase the user_name when storing" do
  		@profile.user_name = "DiddyDog"
  		@profile.save
  		@profile.user_name.downcase.should be_true
		end
	end

	describe "Functions" do
	end

end
