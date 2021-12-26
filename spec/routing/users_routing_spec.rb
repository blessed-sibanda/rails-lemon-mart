require "rails_helper"

RSpec.describe V2::UsersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v2/users/").to route_to("v2/users#index", format: :json)
    end

    it "routes to #show" do
      expect(get: "/v2/users/11").to route_to("v2/users#show", id: "11", format: :json)
    end

    it "routes to #me" do
      expect(get: "/v2/users/me").to route_to("v2/users#me", format: :json)
    end
  end
end
