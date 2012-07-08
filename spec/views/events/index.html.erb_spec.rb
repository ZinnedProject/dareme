require 'spec_helper'

describe "events/index" do
  before(:each) do
    assign(:events, [
      stub_model(Event,
        :user_id => 1,
        :event_date => 2,
        :title => "Title",
        :location => "Location",
        :minimum => "9.99",
        :duration => "",
        :description => "MyText"
      ),
      stub_model(Event,
        :user_id => 1,
        :event_date => 2,
        :title => "Title",
        :location => "Location",
        :minimum => "9.99",
        :duration => "",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of events" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
