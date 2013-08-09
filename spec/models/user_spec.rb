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
#  ic            :integer
#  dic           :string(255)
#  phone         :integer
#  email         :string(255)
#  password_hash :string(255)
#  password_salt :string(255)
#  created_at    :datetime
#  updated_at    :datetime
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
	it "is invalid with bad characters in email"
	it "has password hash" do
		FactoryGirl.build(:user, password_hash: nil).should_not be_valid
	end
	it "has password salt" do
		FactoryGirl.build(:user, password_salt: nil).should_not be_valid
	end
	it "is invalid with non-integer characters"
	it "has minimum digits in phone field"
end
