# == Schema Information
#
# Table name: desks
#
#  id                  :integer          not null, primary key
#  name                :string(255)      not null
#  notificate          :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  resolved_requests   :integer          default(0)
#  unresolved_requests :integer          default(0)
#  user_id             :integer          not null
#

require 'spec_helper'

describe Desk do
	it "it has a valid factory" do
		FactoryGirl.create(:desk).should be_valid
	end
	it "it always has a name" do
		FactoryGirl.build(:desk, name: "").should_not be_valid
	end
	it "resolved_requests can't be negative" do
		FactoryGirl.build(:desk, resolved_requests: -3).should_not be_valid
	end
	it "unresolved_requests can't be negative" do
		FactoryGirl.build(:desk, unresolved_requests: -8).should_not be_valid
	end
	it "has :user_id" do
		FactoryGirl.build(:desk, user_id: nil).should_not be_valid
	end
	it "always belongs to some User" do
		desk = FactoryGirl.create(:desk)
		desk.should belong_to(:user)
	end
	it "has many requests" do
		should have_many(:requests)
	end
end
