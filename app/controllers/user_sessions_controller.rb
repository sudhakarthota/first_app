class UserSessionsController < ApplicationController
  
  def new
  end

  def create
  user = User.find_by(email: params[:user_session][:email].downcase)
  if user && user.authenticate(params[:user_session][:password])

  	if params[:remember_me]
        cookies.permanent[:user_id] = user.id
      else
        cookies[:user_id] = user.id  
      end
      redirect_to user_path(user), notice: "Logged in!"
    # Sign the user in and redirect to the user's show page.
  else
     flash[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
  end
  end

  def destroy
  	cookies.delete(cookies[:user_id])
    cookies[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

end
