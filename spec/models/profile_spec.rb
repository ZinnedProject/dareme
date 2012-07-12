require 'spec_helper'

describe Profile do
	it "has a valid factoryGirl" do
		FactoryGirl.create(:profile, slug: "fefeefefe").should be_valid
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
		it { should respond_to(:slug) }
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
		it "should not be valid if slug is nil" do
			@profile.should validate_presence_of :slug
		end 
		it "should not be valid if slug has more than letter and numbers" do
			@profile.slug = "8*78f8%"
			@profile.save.should be_false
		end 
		it "should not be valid if slug has reserved names" do
			@profile.slug = "contact"
			@profile.save.should be_false
		end 
		it "should not be valid if slug is to long" do
			@profile.slug = "contact35g57835363338683753535353yusgfuihdhjsfguih4t879gryugdhj"
			@profile.save.should be_false
		end 
		it "should not be valid if slug is not unique" do
			@profile.slug = "coji"
			@profile.save
			@profile2 = @profile
			@profile2.id = nil
			@profile2.slug = 'coJi'
			@profile2.save.should be_false
		end 
		it "should not be valid if slug is to short" do
			@profile.slug = "con"
			@profile.save.should be_false
		end 

	end
	
	describe "Callbacks" do
		it "should downcase the slug when storing" do
  		@profile.slug = "DiddyDog"
  		@profile.save
  		@profile.slug.downcase.should be_true
		end
	end

	describe "Functions" do
	end

end
