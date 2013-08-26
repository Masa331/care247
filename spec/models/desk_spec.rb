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
#  desks_mailbox       :string(255)
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

	describe "method resolved_requests" do
		before :each do
			@desk = FactoryGirl.create(:desk)
			@req1 = FactoryGirl.create(:request, desk_id:@desk.id)
			@req2 = FactoryGirl.create(:request, desk_id:@desk.id)
			@req3 = FactoryGirl.create(:request, desk_id:@desk.id, status_flag: 1)
		end
		it "returns resolved requests" do
			resolved =  @desk.resolved_requests
			resolved.should include(@req3)
		end
		it "doesn't return anything else" do
			resolved = @desk.resolved_requests
			resolved.should_not include(@req1, @req2)
		end
	end

	describe "method unresolved_requests" do
		before :each do
			@desk = FactoryGirl.create(:desk)
			@req1 = FactoryGirl.create(:request, desk_id:@desk.id)
			@req2 = FactoryGirl.create(:request, desk_id:@desk.id)
			@req3 = FactoryGirl.create(:request, desk_id:@desk.id, status_flag: 1)
		end
		it "returns unresolved requests" do
			unresolved =  @desk.unresolved_requests
			unresolved.should include(@req1, @req2)
		end
		it "doesn't return anything else" do
			unresolved = @desk.unresolved_requests
			unresolved.should_not include(@req3)
		end
	end
end
