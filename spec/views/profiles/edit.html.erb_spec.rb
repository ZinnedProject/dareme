require 'spec_helper'

describe "profiles/edit" do
  before(:each) do
    @profile = assign(:profile, stub_model(Profile,
      :first_name => "MyString",
      :last_name => "MyString",
      :user_id => "MyString",
      :integer => "MyString",
      :about => "MyString"
    ))
  end

  it "renders the edit profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => profiles_path(@profile), :method => "post" do
      assert_select "input#profile_first_name", :name => "profile[first_name]"
      assert_select "input#profile_last_name", :name => "profile[last_name]"
      assert_select "input#profile_user_id", :name => "profile[user_id]"
      assert_select "input#profile_integer", :name => "profile[integer]"
      assert_select "input#profile_about", :name => "profile[about]"
    end
  end
end
