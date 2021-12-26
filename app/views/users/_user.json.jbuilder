json.cache! [user] do
  json.extract! user, :id, :email, :role

  json.url user_url(user)

  json.name do
    json.first user.first_name
    json.middle user.middle_name
    json.last user.last_name
  end
end
