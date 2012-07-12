require "spec_helper"

describe FollowingsController do
  describe "routing" do

    it "routes to #create" do
      post("/users/1/follow").should route_to("followings#create")
    end

    it "routes to #destroy" do
      delete("/users/1/follow/1").should route_to("followings#destroy", :id => "1", :user_id => "1")
    end
# profile_comments POST   /profiles/:profile_id/comments(.:format)     comments#create
# profile_comment DELETE /profiles/:profile_id/comments/:id(.:format) comments#destroy

  end
end
