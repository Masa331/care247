require 'spec_helper'

describe RequestsController do

	before :each do
		@user = FactoryGirl.create(:user)
		@other_user = FactoryGirl.create(:user)
		@desk = FactoryGirl.create(:desk, user_id: @user.id)
		@req = FactoryGirl.create(:request, desk_id: @desk.id, status_flag: 0)
		@part1 = FactoryGirl.create(:part, request_id: @req.id, user_id: @user.id)
		@part2 = FactoryGirl.create(:part, request_id: @req.id, user_id: @user.id, body: "djkcahjs sah sasb sashbh assahjg. Skkssnjkn. sdcakjsjsxnas xcajka ACLJBD ")
		@part3 = FactoryGirl.create(:part, request_id: "345", user_id: @other_user.id, body: "Tohle nechci videt!")
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
			it "assigns all apropriate parts to @parts" do
				get :show, id: @req
				assigns[:parts].should include(@part1, @part2)
				assigns[:parts].should_not include(@part3)
			end
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
			it "doesn't assign anything to @parts" do
				get :show, id: @req
				assigns[:parts].should eq(nil)
			end
			it "redirects to :root" do
				get :show, id: @req
				response.should redirect_to root_url
			end
		end
	end

	describe "GET :index" do
		before :each do
			@req1 = FactoryGirl.create(:request, user_id:@user.id)
			@req2 = FactoryGirl.create(:request, user_id:@user.id, status_flag: 1)
			@other_users_req = FactoryGirl.create(:request, user_id:@other_user.id)
		end
		context "as some user" do
			before :each do
				sign_in @user
			end
			it "assigns right records to all_resolved_requests" do
				get :index
				assigns[:all_resolved_requests].should include(@req2)
			end
			it "assigns right records to all_unresolved_requests" do
				get :index
				assigns[:all_unresolved_requests].should include(@req1)
			end
			it "doesn't assign other users records" do
				get :index
				assigns[:all_resolved_requests].should_not include(@other_users_req)
			end
			it "renders :index view" do
				get :index
				response.should render_template :index
			end
		end
		context "as other user" do
			before :each do
				sign_in @other_user
			end
			it "assigns right records to all_resolved_requests" do
				get :index
				assigns[:all_resolved_requests].should eq([])
			end
			it "assigns right records to all_unresolved_requests" do
				get :index
				assigns[:all_unresolved_requests].should include(@other_users_req)
			end
			it "doesn't assign other users records" do
				get :index
				assigns[:all_resolved_requests].should_not include(@req1, @req2)
			end
			it "renders :index view" do
				get :index
				response.should render_template :index
			end
		end
	end

	describe "PATCH :update" do
		context "as correct user" do
			before :each do
				sign_in @user
			end
			it "updates right record" do
				patch :update, id: @req, request: FactoryGirl.attributes_for(:request, status_flag: 1)
				@req.reload
				@req.status_flag.should eq(1)
			end
			it "redirects to desks/show" do
				patch :update, id: @req, request: FactoryGirl.attributes_for(:request, status_flag: 1)
				response.should redirect_to desk_url(@desk)
			end
		end
		context "as other user" do
			before :each do
				sign_in @other_user
			end
			it "doesn't assign anything to @request" do
				patch :update, id: @req, request: FactoryGirl.attributes_for(:request, status_flag: 1)
				@req.reload
				@req.status_flag.should eq(0)
			end
			it "redirects to :root" do
				patch :update, id: @req, request: FactoryGirl.attributes_for(:request, status_flag: 1)
				response.should redirect_to root_url
			end
		end
	end

	describe "DELETE :destroy" do
		context "as correct user" do
			before :each do
				sign_in @user
			end
			it "destroys record in database" do
				expect{delete :destroy, id: @req}.to change(Request, :count).by(-1)
			end

			it "redirects to desks/show" do
				delete :destroy, id: @req
				response.should redirect_to desk_url(@desk)
			end
		end
		context "as other user" do
			before :each do
				sign_in @other_user
			end
			it "doesn't assign anything" do
				expect{delete :destroy, id: @req}.not_to change(Request, :count)
			end
			it "redirects to :root" do
				delete :destroy, id: @req
				response.should redirect_to root_url
			end
		end
	end
end
