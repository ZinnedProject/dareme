require 'spec_helper'

describe "profiles/new" do
  before(:each) do
    assign(:profile, stub_model(Profile,
      :first_name => "MyString",
      :last_name => "MyString",
      :user_id => "MyString",
      :integer => "MyString",
      :about => "MyString"
    ).as_new_record)
  end

  it "renders new profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => profiles_path, :method => "post" do
      assert_select "input#profile_first_name", :name => "profile[first_name]"
      assert_select "input#profile_last_name", :name => "profile[last_name]"
      assert_select "input#profile_user_id", :name => "profile[user_id]"
      assert_select "input#profile_integer", :name => "profile[integer]"
      assert_select "input#profile_about", :name => "profile[about]"
    end
  end
end
