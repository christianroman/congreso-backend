module Api
    module V1
    	class CommissionsController < ApplicationController
	    	skip_before_filter :authorize

	    	def index
	    		@commissions = Commission.all
				@status = @commissions.blank? ? "NO_RESULTS" : "OK"
				self.response.headers["Content-Type"] = "application/json; charset=UTF-8"
	    	end

	    	def show
	    		@commission = Commission.find(params[:id])
	    		@status = @commission.blank? ? "NO_RESULTS" : "OK"
				self.response.headers["Content-Type"] = "application/json; charset=UTF-8"
	    	end

		end
    end
end
