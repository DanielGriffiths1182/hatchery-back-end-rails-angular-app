json.user do
  json.id       @user.id
  json.username @user.username
  json.email    @user.email
  json.admin    @user.admin
end
