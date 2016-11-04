json.egg do
  json.total    @egg.total
  json.user_eggs @egg.user_eggs
  # json.token @user.token
end

json.success "OK"
