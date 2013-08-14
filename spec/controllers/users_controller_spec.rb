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
				response.should redirect_to User.last
			end
		end

		context "with invalid input" do
			it "doesn't save form input in database" do
				expect{post :create, user: FactoryGirl.attributes_for(:non_whitelist)}.not_to change(User, :count)
			end
			it "renders :new view" do
				post :create, user: FactoryGirl.attributes_for(:non_whitelist)
				response.should render_template :new
			end
		end
	end

	describe "PUT #update" do
		
		before :each do
			@user = FactoryGirl.create(:user, name: "Martin")
		end

		context "with valid id" do
			it "finds some record in database" do
				put :update, id: @user, user: FactoryGirl.attributes_for(:user)
				assigns[:user].should eq(@user)
			end
			it "updates that record" do
				put :update, id: @user, user: FactoryGirl.attributes_for(:user, name: "Petr")
				@user.reload
				@user.name.should eq("Petr")
			end
			it "redirect to users show view" do
				put :update, id: @user, user: FactoryGirl.attributes_for(:user, name: "Petr")
				response.should redirect_to @user
			end
		end

		context "with invalid id" do
			it "doesn't assign anything" do
				put :update, id: "sdjkcdksadj", user: FactoryGirl.attributes_for(:user, name: "Petr")
				assigns[:user].should eq(nil)
			end
			it "renders :home page" do
				put :update, id: "sdjkcdksadj", user: FactoryGirl.attributes_for(:user, name: "Petr")
				response.should redirect_to root_url
			end
		end

		context "as wrong user" do
			it "doesn't update anything"
		end
	end

	describe "GET #show" do
		context "with existing record" do
			it "assigns some database record to @user" do
				user = FactoryGirl.create(:user)
				get :show, id: user
				assigns[:user].should eq(user)
			end
			it "renders :show view" do
				user = FactoryGirl.create(:user)
				get :show, id: user
				response.should render_template :show
			end
		end

		context "with non-existant record" do
			it "renders :home view" do
				get :show, id: "jknvsdcvn2213"
				response.should redirect_to root_url
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

	describe "DELETE #destroy" do
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
