class SessionControllerController < ApplicationController
  def create
    begin
	    @user = User.from_omniauth(request.env['omniauth.auth'])
	    session[:user_id] = @user.id
	    flash[:success] = "Hello, #{@user.name}!"
    rescue
	    flash[:warning] = "Some problems..."
	  end
	  redirect_to root_path
  end

  def destroy
	  if current_user
	    session.delete(:user_id)
	    flash[:success] = 'Goodbye'
	  end
	  redirect_to root_path
  end

  def auth_failure
    redirect_to root_path
  end

end
