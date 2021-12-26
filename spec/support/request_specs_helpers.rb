require "devise/jwt/test_helpers"

module RequestSpecsHelpers
  def json
    JSON.parse(response.body)
  end

  def auth_headers(user)
    headers = {}
    Devise::JWT::TestHelpers.auth_headers(headers, user)
  end

  def expect_correct_paginated_result(
    json_response, url:, base_class:, headers:, desc: false
  )
    if desc
      expect(json_response["data"][0]["id"] > json_response["data"][1]["id"]).to be_truthy
    else
      expect(json_response["data"][0]["id"] < json_response["data"][1]["id"]).to be_truthy
    end

    expect(json_response["_links"]["current_page"]).to eq "#{url}?page=1"
    expect(json_response["_links"]["prev_page"]).to be_nil
    expect(json_response["_links"]["next_page"]).to eq "#{url}?page=2"

    total_pages = (base_class.count.to_f / base_class.per_page).ceil

    expect(json_response["_links"]["last_page"]).to eq "#{url}?page=#{total_pages}"
    expect(json_response["_meta"]["total_count"]).to eq base_class.count
    expect(json_response["_meta"]["total_pages"]).to eq total_pages
    expect(json_response["_meta"]["page"]).to eq 1
    expect(json_response["data"].length <= base_class.per_page).to be_truthy

    get json_response["_links"]["next_page"], headers: headers, as: :json
    expect(json["_links"]["prev_page"]).to eq "#{url}?page=1"
    expect(json["_meta"]["page"]).to eq 2

    get json["_links"]["last_page"], headers: headers, as: :json
    expect(json["_links"]["next_page"]).to be_nil
    expect(json["_meta"]["page"]).to eq total_pages
  end
end

RSpec.configure do |c|
  c.include RequestSpecsHelpers, type: :request
end
