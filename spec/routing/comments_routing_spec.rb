require "spec_helper"

describe CommentsController do
  describe "routing" do

    it "routes to #create" do
      post("/events/1/comments").should route_to("comments#create", :event_id => "1")
    end
    it "routes to #create" do
      post("/profiles/1/comments").should route_to("comments#create", :profile_id => "1")
    end

    it "routes to #destroy" do
      delete("/comments/1").should route_to("comments#destroy", :id => "1")
    end

  end
end
