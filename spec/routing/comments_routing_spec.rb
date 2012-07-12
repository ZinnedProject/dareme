require "spec_helper"

describe CommentsController do
  describe "routing" do

    it "routes to #destroy" do
      delete("/comments/1").should route_to("comments#destroy", :id => "1")
    end

  end
end
