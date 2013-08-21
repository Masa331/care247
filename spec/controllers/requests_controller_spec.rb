require 'spec_helper'

describe RequestsController do

	before :each do
		@user = FactoryGirl.create(:user)
		@other_user = FactoryGirl.create(:user)
		@desk = FactoryGirl.create(:desk, user_id: @user.id)
		@req = FactoryGirl.create(:request, desk_id: @desk.id, status_flag: 0)
	end

	describe "GET :show" do
		context "as correct user" do
			before :each do
				sign_in @user
			end
			it "assigns right request to @req" do
				get :show, id: @req
				assigns[:request].should eq(@req)
			end
			it "assigns all apropriate parts to @parts"
			it "renders :show view" do
				get :show, id: @req
				response.should render_template :show
			end
		end
		context "as other user" do
			before :each do
				sign_in @other_user
			end
			it "doesn't assign anything to @req" do
				get :show, id: @req
				assigns[:request].should eq(nil)
			end
			it "doesn't assign anything to @parts"
			it "redirects to :root" do
				get :show, id: @req
				response.should redirect_to root_url
			end
		end
	end

	describe "PATCH :update" do
		context "as correct user" do
			before :each do
				sign_in @user
			end
			xit "updates right record" do
				patch :update, id: @request, request: FactoryGirl.attributes_for(:request, status_flag: 1)
				@request.reload
				@request.status_flag.should eq(1)
			end
			xit "redirects to desks/show" do
				patch :update, id: @request, request: FactoryGirl.attributes_for(:request, status_flag: 1)
				response.should redirect_to desk_url, id: @desk
			end
		end
		context "as other user" do
			before :each do
				sign_in @other_user
			end
			xit "doesn't assign anything to @request" do
				patch :update, id: @request, request: FactoryGirl.attributes_for(:request, status_flag: 1)
				@request.reload
				@request.status_flag.should eq(0)
			end
			xit "redirects to :root" do
				patch :update, id: @request, request: FactoryGirl.attributes_for(:request, status_flag: 1)
				response.should redirect_to root_url
			end
		end
	end

	describe "DELETE :destroy" do
		context "as correct user" do
			before :each do
				sign_in @user
			end
			xit "destroys record in database" do
				expect{delete :destroy, id: @request}.to change(Request, :count).by(-1)
			end

			xit "redirects to desks/show" do
				delete :destroy, id: @request
				response.should redirect_to desk_url, id: @desk
			end
		end
		context "as other user" do
			before :each do
				sign_in @other_user
			end
			xit "doesn't assign anything" do
				expect{delete :destroy, id: @request}.not_to change(Request, :count)
			end
			xit "redirects to :root" do
				delete :destory, id: @request
				response.should redirect_to root_url
			end
		end
	end
end
