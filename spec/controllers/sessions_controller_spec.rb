require 'spec_helper'

describe SessionsController do
	describe "GET #new" do
		it "renders :new template" do
			get :new
			response.should render_template :new
		end
	end

	describe "POST #create" do
		before :each do 
			@user = FactoryGirl.create(:user, email: "p@p.cz", password: "foobar")
		end
		context "successfull authentication of user" do
			before :each do
				post :create, email: "p@p.cz", password: "foobar"
			end
			it "sets remember_token cookie" do
				cookies[:remember_token].should eq(@user.remember_token)
			end
			xit "assigns user to current_user" do
				current_user.should eq(@user)
			end
			it "redirects to root_url" do
				response.should redirect_to root_url
			end
		end

		context "unsuccessfull authentication of user" do
			it "renders :new view" do
				post :create, email: "p@p.cz", password: "bazbar"
				response.should render_template :new
			end
		end
	end

	describe "DELETE #destroy" do
		before :each do
			@user = FactoryGirl.create(:user, email: "p@p.cz", password: "foobar")
			delete :destroy
		end
		it "sets remember_token cookie as nil" do
			cookies[:remember_token].should eq(nil)
		end
		xit "sets current_user as nil"
		it "redirects to root_url" do
			response.should redirect_to root_url
		end
	end

end
