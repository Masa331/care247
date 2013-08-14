class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user].permit(:name, :email, :password))
		if @user.save
			redirect_to @user
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
		# I'm using "find_by_id" beause simple "find" it returns error RecordNotFound and doesn't execute the if-else when queriing qith non-existant id 
		if @user = User.find_by_id(params[:id])
			render :show
		else
			redirect_to root_url
		end
	end

	def update
		# "find_by_id" - stejne jako u show
		if @user = User.find_by_id(params[:id])
			@user.update_attributes(params[:user].permit(:name, :email, :street, :city, :zip_code, :country, :dic, :ic, :phone))
			flash[:success] = "Uspesne jste upravil udaje"
			redirect_to @user
		else
			redirect_to root_url
		end
	end

	def index
	end

	def destroy
	end
end
