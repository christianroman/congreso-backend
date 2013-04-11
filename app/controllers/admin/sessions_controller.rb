module Admin
    class SessionsController < BaseController
	skip_before_filter :authorize
	def new
	end

	def create
	    user = User.find_by_username(params[:username])
	    if user and user.authenticate(params[:password])
		session[:user_id] = user.id
		redirect_to admin_root_path
	    else
		redirect_to admin_login_url, alert: "Invalid user/password"
	    end
	end

	def destroy
	    session[:user_id] = nil
	    redirect_to admin_login_url, notice: "Logged out"
	end
    end
end
