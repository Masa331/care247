require 'spec_helper'

describe UsersController do

	describe "GET #new" do
		it "assigns new User to @user" do
			get :new
			assigns[:user].should be_new_record
		end

		it "renders :new view" do
			get :new
			response.should render_template :new
		end
	end

	describe "POST #create" do
		context "with valid input" do
			it "saves record to database" do
				expect{post :create, user: FactoryGirl.attributes_for(:whitelist)}.to change(User, :count).by(1)
			end
			it "renders :show view" do
				post :create, user: FactoryGirl.attributes_for(:whitelist) 
				response.should render_template('show')
			end
		end

		context "with invalid input" do
			it "doesn't save form input in database" do
				expect{post :create, user: FactoryGirl.attributes_for(:non_whitelist)}.to_not change(User, :count)
			end
			it "renders :new view" do
				post :create, user: FactoryGirl.attributes_for(:non_whitelist)
				response.should render_template('new')
			end
		end
	end

	describe "PUT #update" do
		before :each do
			@user = FactoryGirl(:user, name = "Martin")
		context "with valid id" do
			xit "finds some record in database"
				put :update, id: @user
				assigns[:user].should eq(@user)
			end
			xit "updates that record" do
				put :update, id: @user, name: "Petr"
				@user.reload
				@user.name.should eq("Petr")
			end
			xit "renders :show view" do
				put :update, id: @user
				response.should redirect_to @user
			end
		end

		context "with invalid id" do
			xit "doesn't assign anything" do
				put :update, id: "sdjkcdksadj"
				assigns[:user].should eq(nil)
			end
			xit "renders some page" do
				put :update, id: "sdjkcdksadj"
				response.should redirect_to :home
			end
		end

		context "as wrong user" do
			it "doesn't update anything"
		end
	end

	describe "GET #show" do
		context "with existing record" do
			xit "assigns some database record to @user" do
				user = FactoryGirl(:user)
				get :show, id: user
				assigns[:user].should eq(user)
			end
			xit "renders :show view" do
				get :show, id: FactoryGirl(:user)
				response.should render_template :show
			end
		end

		context "with non-existant record" do
			xit "it doesn't assign anything" do
				get :show, id: "dacacsad"
				assigns[:user].should eq(nil)
			end
			xit "renders some page" do
				get :show, id: "dacacsad"
				response.should render_template :fail
			end
		end

		context "as non-owner user" do
			it "blahblahblah"
		end
	end

	describe "GET #index" do
		context "signed in as admin user" do
			before{sign_in_as_admin}
			xit "assigns database records to @users" do
				get :index
				assigns[:users].should eq(User.all)
			end
			xit "renders :index view" do
				get :index
				response.should render_template :index
			end
		end

		context "as non-admin user" do
			before{sign_in_as_user}
			xit "doesn't assign anything" do
				get :index
				assigns[:users].should eq(nil)
			end
			xit "renders users :show view" do
				get :index
				response.should render_template :show
			end
		end
	end

	describe "POST #delete" do
		before :each do
			@user = FactoryGirl(:user)
		end
		context "signed in as admin user" do
			before{sign_in_as_admin}
			xit "finds some user" do
				delete :destroy, id: @user
				assigns[:user].should eq(@user)
			end
			xit "deletes that user" do
				expect{delete :destroy, id: @user}.to change(User, :count).by(-1)
			end
			xit "renders :index view" do
				delete :destroy, id: @user
				response.should redirect_to :index
			end
		end

		context "as non-admin user" do
			xit "it doesn't delete anything" do
				expect{delete :destroy, id: "sdcsadsd"}.not_to change(User,:count)
			end
			xit "renders :home view" do
				delete :destroy, id: "sdcsadsd"
				response.shoul redirect_to :index
			end
		end
	end
end
