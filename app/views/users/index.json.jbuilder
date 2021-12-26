json.cache! [@users] do
  json.partial! "shared/pagination", url: users_url, data: @users, base_class: User

  json.data @users, partial: "users/user", as: :user, cached: true
end
