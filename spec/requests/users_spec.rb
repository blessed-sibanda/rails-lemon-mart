require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:manager) { create :user, role: User::MANAGER }
  let(:user) { create :user, role: User::NONE }

  def expect_correct_json_details_for(user)
    expect(json["name"]["first"]).to eq user.first_name
    expect(json["name"]["last"]).to eq user.last_name
    expect(json["address"]["city"]).to eq user.city
    expect(json["address"]["zip"]).to eq user.zip
    expect(json["address"]["state"]).to eq user.state
    expect(json["address"]["line1"]).to eq user.line1
    expect(json["role"]).to eq user.role
    expect(json["email"]).to eq user.email
    expect(json["id"]).to eq user.id
  end

  describe "GET /index" do
    context "authenticated user" do
      before(:all) do
        create_list :user, (3.5 * User.per_page).ceil
      end

      it "returns http success" do
        get "/users", headers: auth_headers(user)
        expect(response).to have_http_status(:success)
      end

      it "returns paginated list of users in ascending order" do
        get users_url, headers: auth_headers(user)
        expect_correct_paginated_result(
          json,
          url: users_url,
          base_class: User,
          headers: auth_headers(user),
          desc: false,
        )
      end

      it "allows searching/filtering" do
        search_text = ("a".."z").to_a.sample(1).join
        get users_url(filter: search_text), headers: auth_headers(user)

        search_text.downcase!
        json["data"].each do |data|
          search_criteria = data["role"].downcase.starts_with?(search_text) ||
                            data["name"]["first"].downcase.starts_with?(search_text) ||
                            data["name"]["last"].downcase.starts_with?(search_text) ||
                            data["email"].downcase.starts_with?(search_text)
          expect(search_criteria).to be_truthy
        end
      end

      it "allows custom sorting" do
        sort_key = "first_name"
        get users_url(sort: sort_key), headers: auth_headers(user)
        sort_criteria = json["data"][0]["name"]["first"] <= json["data"][1]["name"]["first"] &&
                        json["data"][1]["name"]["first"] <= json["data"][2]["name"]["first"] &&
                        json["data"][2]["name"]["first"] <= json["data"][3]["name"]["first"]
        expect(sort_criteria).to be_truthy

        sort_key = "-last_name"
        get users_url(sort: sort_key), headers: auth_headers(user)
        sort_criteria = json["data"][0]["name"]["last"] >= json["data"][1]["name"]["last"] &&
                        json["data"][1]["name"]["last"] >= json["data"][2]["name"]["last"] &&
                        json["data"][2]["name"]["last"] >= json["data"][3]["name"]["last"]
        expect(sort_criteria).to be_truthy

        sort_key = "email"
        get users_url(sort: sort_key), headers: auth_headers(user)
        sort_criteria = json["data"][0]["email"] <= json["data"][1]["email"] &&
                        json["data"][1]["email"] <= json["data"][2]["email"] &&
                        json["data"][2]["email"] <= json["data"][3]["email"]
        expect(sort_criteria).to be_truthy

        sort_key = "role"
        get users_url(sort: sort_key), headers: auth_headers(user)
        sort_criteria = json["data"][0]["role"] <= json["data"][1]["role"] &&
                        json["data"][1]["role"] <= json["data"][2]["role"] &&
                        json["data"][2]["role"] <= json["data"][3]["role"]
        expect(sort_criteria).to be_truthy
      end

      it "allows both searching and sorting at the same time" do
        create :user, first_name: "Blessed"
        create :user, last_name: "Blakes"
        search_text = "Bl"
        sort_key = "-first_name"
        get users_url(filter: search_text, sort: sort_key), headers: auth_headers(user)

        search_text.downcase!
        json["data"].each do |data|
          search_criteria = data["role"].downcase.starts_with?(search_text) ||
                            data["name"]["first"].downcase.starts_with?(search_text) ||
                            data["name"]["last"].downcase.starts_with?(search_text) ||
                            data["email"].downcase.starts_with?(search_text)
          expect(search_criteria).to be_truthy
        end

        sort_criteria = json["data"][0]["name"]["first"] >= json["data"][1]["name"]["first"]
        expect(sort_criteria).to be_truthy
      end

      it "rejects invalid sort-key" do
        sort_key = "blah"
        get users_url(sort: sort_key), headers: auth_headers(user)
        expect(json["error"]).to eq "'#{sort_key}' is not a valid sort field"
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "unathenticated user" do
      it "returns http unauthorized" do
        get "/users"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET /show" do
    context "authenticated user" do
      context "authorized" do
        it "returns http success if requesting user is profile owner" do
          get user_url(user), headers: auth_headers(manager)
          expect(response).to have_http_status(:success)
        end

        it "returns http success if requesting user is profile owner" do
          get user_url(user), headers: auth_headers(user)
          expect(response).to have_http_status(:success)
        end

        it "returns full user details" do
          get user_url(user), headers: auth_headers(user)
          expect_correct_json_details_for user
        end
      end

      it "returns http forbidden if requesting user is neither profile owner nor manager" do
        get user_url(manager), headers: auth_headers(user)
        expect(response).to have_http_status(:forbidden)
      end
    end

    context "unathenticated user" do
      it "returns http unauthorized" do
        get user_url(user)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET /me" do
    context "authenticated user" do
      it "returns http success" do
        get me_users_url, headers: auth_headers(user)
        expect(response).to have_http_status(:success)
      end

      it "returns logged-in user's profile" do
        get me_users_url, headers: auth_headers(user)
        expect_correct_json_details_for user
      end
    end

    context "unathenticated user" do
      it "returns http unauthorized" do
        get me_users_url
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
