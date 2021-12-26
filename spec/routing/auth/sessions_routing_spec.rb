require "rails_helper"

RSpec.describe Auth::SessionsController, type: :routing do
  describe "routing" do
    it "routes to #login" do
      expect(post: "/auth/login").to route_to("auth/sessions#create", format: :json)
    end

    it "routes to #logout" do
      expect(delete: "/auth/logout").to route_to("auth/sessions#destroy", format: :json)
    end
  end
end
