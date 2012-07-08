require 'spec_helper'

describe "events/show" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :user_id => 1,
      :event_date => 2,
      :title => "Title",
      :location => "Location",
      :minimum => "9.99",
      :duration => "",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Title/)
    rendered.should match(/Location/)
    rendered.should match(/9.99/)
    rendered.should match(//)
    rendered.should match(/MyText/)
  end
end
