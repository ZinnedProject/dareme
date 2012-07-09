require 'spec_helper'

describe Event do
	it "has a valid factoryGirl" do
		FactoryGirl.create(:event, custom_url: "fefeefefe").should be_valid
	end

	before do
  	@event = FactoryGirl.create(:event)
  end

	subject { @event }

	describe "attributes" do
		it { should respond_to(:description) }
		it { should respond_to(:raise_end) }
		it { should respond_to(:event_time) }
		it { should respond_to(:location) }
		it { should respond_to(:minimum_raise) }
		it { should respond_to(:title) }
		it { should respond_to(:user_id) }
		it { should respond_to(:custom_url) }
		it { should respond_to(:longitude) }
		it { should respond_to(:latitude) }
		it { should respond_to(:created_at) }
		it { should respond_to(:updated_at) }
	end

	describe "Associations" do
		before do	
			@user = FactoryGirl.create(:user)
			@event.user_id = @user.id
#  		@event = FactoryGirl.create(:event, user_id: @user.id)
  	end

  	it "Should respond to a user" do
  		@event.user.should eq(@user)
  	end
  	it "Should respond to a comment" do   		
  		@comment = FactoryGirl.create(:comment, commentable: @event)
  		@event.comments.first.should eq(@comment)
  	end
	end

	describe "Validations" do
		it "should not be valid if user_id is nil" do
			@event.should validate_presence_of :user_id
		end  
		it "should not be valid if description is nil" do
			@event.should validate_presence_of :description
		end 
		it "should not be valid if raise_end is nil" do
			@event.should validate_presence_of :raise_end
		end 
		it "should not be valid if event_time is nil" do
			@event.should validate_presence_of :event_time
		end 
		it "should not be valid if location is nil" do
			@event.should validate_presence_of :location
		end 
		it "should not be valid if title is nil" do
			@event.should validate_presence_of :title
		end 
		it "should not be valid if custom_url is nil" do
			@event.should validate_presence_of :custom_url
		end 
				it "should not be valid if user_name has more than letter and numbers" do
			@event.custom_url = "8*78f8%"
			@event.save.should be_false
		end 
		it "should not be valid if user_name has reserved names" do
			@event.custom_url = "contact"
			@event.save.should be_false
		end 
		it "should not be valid if user_name is to long" do
			@event.custom_url = "contact35g57835363338683753535353yusgfuihdhjsfguih4t879gryugdhj"
			@event.save.should be_false
		end 
		it "should not be valid if user_name is not unique" do
			@event.custom_url = "coji"
			@event.save
			@event2 = @event
			@event2.id = nil
			@event2.custom_url = 'coJi'
			@event2.save.should be_false
		end 
		it "should not be valid if user_name is to short" do
			@event.custom_url = "con"
			@event.save.should be_false
		end 

	end

	describe "Callbacks" do
		it "should downcase the user_name when storing" do
  		@event.custom_url = "DiddyDog"
  		@event.save
  		@event.custom_url.downcase.should be_true
		end
	end

	describe "Functions" do
		it "Should not run geocoding if test environment" do
			@event.geocoding.should be_false
		end
	end

end
