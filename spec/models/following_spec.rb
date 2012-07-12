require 'spec_helper'

describe Following do
  it "has a valid factoryGirl" do
		FactoryGirl.create(:following).should be_valid
	end

	before do
  	@user = FactoryGirl.create(:user)
  	@user2 = FactoryGirl.create(:user, email: "aefije@eee.com", slug: "fishy")
  	@following = FactoryGirl.create(:following, user_id: @user.id, followable: @user2)

  end

	subject { @following }

	describe "attributes" do
		it { should respond_to(:user) }
		it { should respond_to(:user_id) }
		it { should respond_to(:followable_id) }
		it { should respond_to(:followable_type) }
	end

	describe "Associations" do
  	it "Should respond to a user" do
  		@following.user.should eq(@user)
  	end
  end

end
