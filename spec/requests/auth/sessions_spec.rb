require "rails_helper"

RSpec.describe "Auth::Sessions", type: :request do
  let!(:user) { create :user, password: "1234pass" }

  let(:valid_attributes) {
    {
      email: user.email,
      password: "1234pass",
    }
  }

  let(:valid_headers) do
    auth_headers(user)
  end

  describe "POST /login" do
    it "returns 401 unauthorized when invalid credentials are given" do
      post user_session_url, xhr: true, params: {
                               user: {
                                 email: "some-random-email@example.com",
                                 password: "very wrong password",
                               },
                             }
      expect(response).to have_http_status(:unauthorized)
    end

    context "correct credentials" do
      before do
        post user_session_url, xhr: true,
                               params: {
                                 user: valid_attributes,
                               }
      end

      it "succeeds" do
        expect(response).to have_http_status(:ok)
      end

      it "returns jwt token" do
        expect(json["token"]).not_to be_nil
      end
    end
  end

  describe "DELETE /logout" do
    it "returns no-content" do
      delete destroy_user_session_url, xhr: true, headers: valid_headers
      expect(response).to have_http_status(:no_content)
    end

    xit "revokes the user token" do; end
  end
end
