require 'spec_helper'

describe "events/new" do
  before(:each) do
    assign(:event, stub_model(Event,
      :user_id => 1,
      :event_date => 1,
      :title => "MyString",
      :location => "MyString",
      :minimum => "9.99",
      :duration => "",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => events_path, :method => "post" do
      assert_select "input#event_user_id", :name => "event[user_id]"
      assert_select "input#event_event_date", :name => "event[event_date]"
      assert_select "input#event_title", :name => "event[title]"
      assert_select "input#event_location", :name => "event[location]"
      assert_select "input#event_minimum", :name => "event[minimum]"
      assert_select "input#event_duration", :name => "event[duration]"
      assert_select "textarea#event_description", :name => "event[description]"
    end
  end
end
