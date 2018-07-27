class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

   def is_admin
		if !current_user || current_user.role != "admin"
			return render text: "Not Authorised", status: 404
		end
	end

	def is_taker
		if !current_user || current_user.role != "taker"
			return render text: "Not Authorised", status: 404
		end
	end
end
