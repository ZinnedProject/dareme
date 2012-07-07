require 'spec_helper'

describe "profiles/index" do
  before(:each) do
    assign(:profiles, [
      stub_model(Profile,
        :first_name => "First Name",
        :last_name => "Last Name",
        :user_id => "User",
        :integer => "Integer",
        :about => "About"
      ),
      stub_model(Profile,
        :first_name => "First Name",
        :last_name => "Last Name",
        :user_id => "User",
        :integer => "Integer",
        :about => "About"
      )
    ])
  end

  it "renders a list of profiles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "User".to_s, :count => 2
    assert_select "tr>td", :text => "Integer".to_s, :count => 2
    assert_select "tr>td", :text => "About".to_s, :count => 2
  end
end
