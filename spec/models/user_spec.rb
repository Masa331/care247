# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  street         :string(255)
#  city           :string(255)
#  zip_code       :string(255)
#  country        :string(255)
#  dic            :string(255)
#  email          :string(255)
#  password_hash  :string(255)
#  password_salt  :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  phone          :string(255)
#  admin          :boolean
#  ic             :string(255)
#  remember_token :string(255)
#

require 'spec_helper'

describe User do
	it "has a valid factory" do
		FactoryGirl.create(:user).should be_valid
	end
	it "is invalid without name" do
		FactoryGirl.build(:user, name: nil).should_not be_valid
	end
	it "is invalid without email" do
		FactoryGirl.build(:user, email: nil).should_not be_valid
	end
	it "is invalid with bad characters in email" do
		FactoryGirl.build(:user, email: "rd*/@suk.cz").should_not be_valid
	end
	it "is invalid without password" do
		FactoryGirl.build(:user, password: nil).should_not be_valid
	end
	it "encrypts password into password_salt and password_hash" do
		user = FactoryGirl.create(:user, password_salt: nil, password_hash: nil)
		user.password_salt.should_not == nil
		user.password_hash.should_not == nil
	end
	it "creates remember_token" do
		user = FactoryGirl.create(:user)
		user.remember_token.should_not == nil
	end
	it "has many desks" do
		should have_many(:desks)
	end

	describe "authenticate method" do
		before :each do
			@user = FactoryGirl.create(:user, email: "p@p.cz", password: "foobar" )
		end
		it "returns right user when given right email and password" do
			user_right = User.authenticate("p@p.cz", "foobar")
			user_right.should eq(@user)
		end
		it "returns nil when given wrong combination of email and password" do
			user_wrong = User.authenticate("p@p.cz", "bazbar")
			user_wrong.should eq(nil)
		end
	end

	describe "when email is already taken" do
		before do
			@user = FactoryGirl.create(:user)

			@same_email_user = @user.dup
			@same_email_user.email = @user.email.upcase
			@same_email_user.save
		end
		it "it doesn't save it" do
			@same_email_user.should_not be_valid
		end
	end


end
