require 'spec_helper'

describe DesksController do

    describe "GET #new" do
        context "as signed in user" do
            before :each do
                @user = FactoryGirl.create(:user)
                sign_in @user
            end
            it "assigns new Desk to @desk" do
                get :new
                assigns[:desk].should be_new_record
            end
            it "renders :new view" do
                get :new
                response.should render_template :new
            end
        end
        context "as non-signed in user" do
            it "redirect_to :home" do
                get :new
                response.should redirect_to root_url
            end
        end
    end

    describe "POST #create" do
        context "as signed in user" do
            before :each do
                @user = FactoryGirl.create(:user)
                sign_in @user
            end
            context "with valid input" do
                it "saves new desk into database" do
                    expect{post :create, desk: FactoryGirl.attributes_for(:desk, user_id: @user)}.to change(Desk, :count).by(1)
                end
                it "redirects to :show view" do
                    post :create, desk: FactoryGirl.attributes_for(:desk, user_id: @user)
                    response.should redirect_to Desk.last
                end
            end
            context "with invalid input" do
                it "doesn't save anything to database" do
                    expect{post :create, desk: FactoryGirl.attributes_for(:desk, name: "")}.not_to change(Desk, :count)
                end
                it "renders :new view" do
                    post :create, desk: FactoryGirl.attributes_for(:desk, name: "")
                    response.should render_template :new
                end
            end
        end

        context "as non-signed in user" do
            it "doesn't create record in database" do
                expect{post :create, desk: FactoryGirl.attributes_for(:desk)}.not_to change(Desk, :count)
            end
            it "redirect_to :home" do
                post :create, desk: FactoryGirl.attributes_for(:desk)
                response.should redirect_to root_url
            end
        end
    end

    describe "PATCH #update" do
        before :each do
            @user = FactoryGirl.create(:user)
            @desk = FactoryGirl.create(:desk, name: "Shop", user_id: @user.id)
        end
        context "as correct user" do
            before :each do
                sign_in @user
            end
            it "updates the record record" do
                patch :update, id: @desk, desk: FactoryGirl.attributes_for(:desk, name: "Obchod")
                @desk.reload
                @desk.name.should eq("Obchod")
            end
            it "redirect to :show view" do
                patch :update, id: @desk, desk: FactoryGirl.attributes_for(:desk, name: "Obchod")
                response.should redirect_to @desk
            end
        end
        context "as other user" do
            before :each do
                @other_user = FactoryGirl.create(:user)
                sign_in @other_user
            end
            it "doesn't update anything" do
                patch :update, id: @desk, desk: FactoryGirl.attributes_for(:desk, name: "Obchod")
                @desk.reload
                @desk.name.should eq("Shop")
            end
            it "redirects to :home" do
                patch :update, id: @desk, desk: FactoryGirl.attributes_for(:desk, name: "Obchod")
                response.should redirect_to root_url
            end
        end
    end

    describe "GET 'destroy'" do
        before :each do
            @user = FactoryGirl.create(:user)
            @desk = FactoryGirl.create(:desk, user_id: @user.id)
        end
        context "as correct user" do
            before :each do
                sign_in @user
            end
            it "destroys record in database" do
                expect{delete :destroy, id: @desk}.to change(Desk, :count).by(-1)
            end
            it "redirects to users/index view" do
                delete :destroy, id: @desk
                response.should redirect_to user_url
            end
        end
        context "as incorrect user" do
            before do
                @other_user = FactoryGirl.create(:user)
                sign_in @other_user
            end
            it "doesn't destroy anything" do
                expect{delete :destroy, id: @desk}.not_to change(Desk, :count)
            end
            it "redirects to :home view" do
                delete :destroy, id: @desk
                response.should redirect_to root_url
            end
        end
    end

    describe "GET 'show'" do
        before :each do
            @user = FactoryGirl.create(:user)
            @desk = FactoryGirl.create(:desk, user_id: @user.id)
            @admin = FactoryGirl.create(:admin)
        end
        context "as correct user" do
            before :each do
                sign_in @user
            end
            it "assigns correct record to @desk" do
                get :show, id: @desk
                assigns[:desk].should eq(@desk)
            end
            it "renders :show view" do
                get :show, id: @desk
                response.should render_template :show
            end
        end
        context "as other user" do
            before :each do
                @other_user = FactoryGirl.create(:user)
                sign_in @other_user
            end
            it "redirects to :home view" do
                get :show, id: @desk
                response.should redirect_to root_url
            end
        end
    end
end
