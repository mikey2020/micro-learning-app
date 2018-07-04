def authenticate(path)
    if session[:user_id].nil?
        redirect to('/user/signup')
    end
end