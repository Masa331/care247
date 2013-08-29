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
			describe "sends welcome_email" do
				let(:email) do
					post :create, user: FactoryGirl.attributes_for(:whitelist, email: "bozena@seznam.cz")
					ActionMailer::Base.deliveries.last
				end
				it "creates new email in deliveries array" do
					expect{post :create, user: FactoryGirl.attributes_for(:whitelist)}.to change(ActionMailer::Base.deliveries, :count).by 1
				end
				it "has right recipient" do
					email.to.should eq ["bozena@seznam.cz"]
				end
				it "has right from" do
					email.from.should eq ["info@care247.cz"]
				end
				it "has right subject" do
					email.subject.should eq "Welcome to Care247"
				end

				it "has right body" do
					email.body.encoded.should have_text "Welcome to Care247"
				end
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

	describe "PATCH #update" do
		
		before :each do
			@user = FactoryGirl.create(:user, name: "Martin")
		end

		context "as correct user" do
			before :each do
				sign_in @user
			end
			it "finds some record in database" do
				patch :update, id: @user, user: FactoryGirl.attributes_for(:user)
				assigns[:user].should eq(@user)
			end
			it "updates that record" do
				patch :update, id: @user, user: FactoryGirl.attributes_for(:user, name: "Petr")
				@user.reload
				@user.name.should eq("Petr")
			end
			it "redirect to users show view" do
				patch :update, id: @user, user: FactoryGirl.attributes_for(:user, name: "Petr")
				response.should redirect_to @user
			end
		end

		context "as wrong user" do
			before :each do
				@other_user = FactoryGirl.create(:user)
				sign_in @other_user
			end
			it "doesn't assign anything" do
				patch :update, id: @user, user: FactoryGirl.attributes_for(:user, name: "Petr")
				assigns[:user].should eq(nil)
			end
			it "renders :home page" do
				patch :update, id: @user, user: FactoryGirl.attributes_for(:user, name: "Petr")
				response.should redirect_to root_url
			end
		end

		context "as admin" do
			it "updates user"
		end
	end

	describe "GET #show" do
		context "as correct user" do
			before :each do
				@user = FactoryGirl.create(:user)
				sign_in @user
			end
			it "assigns some database record to @user" do
				get :show, id: @user
				assigns[:user].should eq(@user)
			end
			it "renders :show view" do
				get :show, id: @user
				response.should render_template :show
			end
		end

		context "as other user" do
			before do
				@user = FactoryGirl.create(:user)
				@other_user = FactoryGirl.create(:user)
				sign_in @user
			end
			it "renders :home view" do
				get :show, id: @other_user
				response.should redirect_to root_url
			end
		end
	end

	describe "GET #index" do
		context "as admin user" do
			before :each do 
				@admin = FactoryGirl.create(:admin)
				sign_in @admin
			end
			it "assigns database records to @users" do
				get :index
				assigns[:users].should eq(User.all)
			end
			it "renders :index view" do
				get :index
				response.should render_template :index
			end
		end

		context "as non-admin user" do
			before :each do
				@user = FactoryGirl.create(:user)
				sign_in @user
			end
			it "doesn't assign anything" do
				get :index
				assigns[:users].should eq(nil)
			end
			it "redirects to root_url" do
				get :index
				response.should redirect_to root_url
			end
		end
	end

	describe "DELETE #destroy" do
		
		before :each do
			@user = FactoryGirl.create(:user)
		end

		context "signed in as admin user" do
			before :each do
				@admin = FactoryGirl.create(:admin)
				sign_in @admin
			end
			it "deletes that user" do
				expect{delete :destroy, id: @user}.to change(User, :count).by(-1)
			end
			it "renders :index view" do
				delete :destroy, id: @user
				response.should redirect_to users_url
			end
		end

		context "as non-admin user" do
			before :each do
				@user2 = FactoryGirl.create(:user)
				sign_in @user2
			end
			it "it doesn't delete anything" do
				expect{delete :destroy, id: @user}.not_to change(User,:count)
			end
			it "renders :home view" do
				delete :destroy, id: @user
				response.should redirect_to root_url
			end
		end
	end
end
