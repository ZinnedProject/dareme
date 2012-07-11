require 'spec_helper'

describe "followings/edit" do
  before(:each) do
    @following = assign(:following, stub_model(Following,
      :user_id => 1,
      :following_id => 1
    ))
  end

  it "renders the edit following form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => followings_path(@following), :method => "post" do
      assert_select "input#following_user_id", :name => "following[user_id]"
      assert_select "input#following_following_id", :name => "following[following_id]"
    end
  end
end
