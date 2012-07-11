require 'spec_helper'

describe "followings/show" do
  before(:each) do
    @following = assign(:following, stub_model(Following,
      :user_id => 1,
      :following_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
