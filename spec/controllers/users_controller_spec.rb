require 'spec_helper'

describe UsersController do

	describe "GET #new" do
		it "returns http success" do
			get 'new'
			response.should be_success
		end
		it "assigns new User to @user"
	end

	describe "POST #create" do
		context "with valid input" do
			it "saves the form input in database"
			it "renders some page"
		end

		context "with invalid input" do
			it "doesn't save form input in database"
			it "renders some other page"
		end
	end

	describe "PUT #update" do
		it "updates some database record"
		it "renders some page"
	end

	describe "GET #show" do
		it "assigns some database record to @user"
		it "renders some page"
	end

	describe "GET #index" do
		context "signed in as admin user" do
			it "assigns database records to @users"
			it "renders some page"
		end

		context "as non-admin user" do
			it "renders some other page"
		end
	end

	describe "POST #delete" do
		context "signed in as admin user" do
			it "finds some user"
			it "deletes that user"
			it "renders some page"
		end

		context "as non-admin user" do
			it "renders some other page"
		end
	end
end
