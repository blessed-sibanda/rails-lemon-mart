json.cache! [@user] do
  json.partial! "v2/users/user", user: @user, cached: true

  json.address do
    json.line1 @user.line1
    json.line2 @user.line2
    json.city @user.city
    json.state @user.state
    json.zip @user.zip
  end
end
