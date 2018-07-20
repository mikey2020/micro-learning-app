def authenticate
  redirect to('/user/login') unless session[:user_id]
end
