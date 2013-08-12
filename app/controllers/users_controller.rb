class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user].permit(:name, :email, :password))
		if @user.save
			redirect_to user_url
			flash[:success] = "Byl jste uspesne zaregistrovan"
			# session things
			# ..
			#..
		else
			flash[:error] = "Bohuzel se pri registraci neco zvrtlo, zkuste to znovu."
			render :new
		end
	end

	def show
		if @user = User.find(params[:id])
			render :show
		else
			render :home
		end
	end
end
