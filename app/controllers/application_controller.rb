class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

   def is_admin
		if !current_user || current_user.role != "admin"
			return redirect_to "/"
		end
	end

	def is_taker

		#for api check the token from header
		#this is the basic implementation of api authentication.
		#TODO Jsonwebtoken
		@current_user = User.find_by(authentication_token: request.headers['X-Auth-Token']) 
    	if !@current_user.present? || @current_user.role != "taker"
        	return render json: {error: I18n.t('errors.invalid_user')}, status: 422
    	end
	end
end
