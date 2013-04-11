module Admin
    class BaseController < ApplicationController
	layout 'admin'
	before_filter :authorize

	protected
	def authorize
	    unless User.find_by_id(session[:user_id])
		redirect_to admin_login_url, notice: "Please Log In"
	    end
	end
    end
end
