require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/users/").to route_to("users#index", format: :json)
    end

    it "routes to #show" do
      expect(get: "/users/11").to route_to("users#show", id: "11", format: :json)
    end

    it "routes to #me" do
      expect(get: "/users/me").to route_to("users#me", format: :json)
    end
  end
end
