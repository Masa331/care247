class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.authenticate(params[:email],params[:password])
		if user
			cookies[:remember_token] = user.remember_token
			current_user = user
			redirect_to root_url
		else
			flash[:error] = "Prihlaseni se nezdarilo"
			render :new
		end
	end

	def destroy
		cookies.delete(:remember_token)
		current_user=nil
	end
end
