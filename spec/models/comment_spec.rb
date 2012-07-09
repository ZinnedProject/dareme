require 'spec_helper'

describe Comment do
	before do
  	@comment = FactoryGirl.create(:comment)
  end

	it "has a valid factoryGirl" do
		FactoryGirl.create(:comment).should be_valid
	end

	subject { @comment }

	describe "attributes" do
	  before do
  #		@comment = FactoryGirl.create(:comment)
  	end

		it { should respond_to(:content) }
		it { should respond_to(:commentable_id) }
		it { should respond_to(:commentable_type) }
		it { should respond_to(:user_id) }
	end

	describe "Associations" do
		before do	
			@user = FactoryGirl.create(:user)
  		@event = FactoryGirl.create(:event)
  		@profile = FactoryGirl.create(:profile)
  		@comment.user_id =  @user.id
  	end

  	it "Should respond to an event" do
  		@comment.commentable = @event
  		@comment.commentable.should eq(@event)
  	end
  	it "Should respond to a profile" do
  		@comment.commentable = @profile
  		@comment.commentable.should eq(@profile)
  	end
	end

	describe "Validations" do

		it "should not be valid if user_id is nil" do
			@comment.should validate_presence_of :user_id
		end  
		it "should not be valid if content is nil" do
			@comment.should validate_presence_of :content
		end 
	end



end
