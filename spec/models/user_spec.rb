# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  street        :string(255)
#  city          :string(255)
#  zip_code      :string(255)
#  country       :string(255)
#  dic           :string(255)
#  email         :string(255)
#  password_hash :string(255)
#  password_salt :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  phone         :string(255)
#  admin         :boolean
#  ic            :string(255)
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
	it "is invalid with non-digit characters in phone" do
		FactoryGirl.build(:user, phone: "dkcdnc").should_not be_valid
	end
	it "is invalid with non-digit characters in ic" do
		FactoryGirl.build(:user, ic: "adikcdn").should_not be_valid
	end
	it "is invalid without password" do
		FactoryGirl.build(:user, password: nil).should_not be_valid
	end
	it "encrypts password into password_salt and password_hash" do
		user = FactoryGirl.create(:user, password_salt: nil, password_hash: nil)
		user.password_salt.should_not == nil
		user.password_hash.should_not == nil
	end
end
