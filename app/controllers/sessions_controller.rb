class SessionsController < ApplicationController
def new
    
end
def create
    email_or_username = params[:email_or_username].downcase
   
    user = User.find_by(email: email_or_username) || User.find_by(username: email_or_username)

    if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       redirect_to (session[:intended_url] || user), notice: "Welcome back, #{user.name}"
       session[:intended_url] = nil
    else 
        flash.now[:alert] = "Invalid email/password combination"
        render :new 
    end 
end
def destroy
    session[:user_id]=nil
    redirect_to movies_url, notice: "You are now signed out"
end

end
