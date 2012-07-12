require 'spec_helper'

describe Profile do
	it "has a valid factoryGirl" do
		FactoryGirl.create(:profile).should be_valid
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
	end
	

	describe "Functions" do
	end

end
