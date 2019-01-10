# session controller
class SessionControllerController < ApplicationController
  def create
    begin
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if session[:user_id] = @user.id
      flash[:success] = "Hello, #{@user.first_name}!"
    else
      flash[:warning] = 'Some problems with auth...'
    end
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
