json.cache! [@users] do
  json.partial! "shared/pagination", url: v2_users_url, data: @users, base_class: User 

  json.data @users, partial: "v2/users/user", as: :user, cached: true
end
