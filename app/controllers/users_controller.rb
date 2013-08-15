class UsersController < ApplicationController
	
	before_filter :admin_user, only: [:index, :destroy]
	before_filter :correct_user, only: [:show, :update]

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
			@desks = @user.desks.all
			render :show
		else
			redirect_to root_url
		end
	end

	def update
		# "find_by_id" - stejne jako u show
		if @user = User.find(params[:id])
			if @user.update_attributes(params[:user].permit(:name, :email, :street, :city, :zip_code, :country, :dic, :ic, :phone))
				flash[:success] = "Uspesne jste upravil udaje"
				sign_in @user
				redirect_to @user
			else
				flash[:warning] = "Udaje se nepodarilo ulozit"
				render :show
			end
		else
			redirect_to root_url
		end
	end

	def index
		@users = User.all
	end

	def destroy
		if User.find(params[:id]).destroy
			flash[:success] = "Successfully destroyed."
			redirect_to users_url
		else
			flash[:error] = "something went wrong and user wasn't deleted..."
			redirect_to users_url
		end
	end

	private

	def admin_user
		redirect_to root_url unless current_user.admin?
	end

	def correct_user
		redirect_to root_url unless User.find(params[:id]) == current_user
	end
end
