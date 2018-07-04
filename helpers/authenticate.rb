def authenticate
    if session[:user_id].nil?
        redirect to('/user/login')
    end
end