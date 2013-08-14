class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.authenticate(params[:email],params[:password])
		if user
			sign_in user
			redirect_to root_url
		else
			flash[:error] = "Prihlaseni se nezdarilo"
			render :new
		end
	end

	def destroy
		cookies.delete(:remember_token)
		current_user=nil
		redirect_to root_url
	end
end
