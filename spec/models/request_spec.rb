# == Schema Information
#
# Table name: requests
#
#  id          :integer          not null, primary key
#  created_at  :datetime
#  updated_at  :datetime
#  desk_id     :string(255)      not null
#  status_flag :integer          not null
#  subject     :string(255)      not null
#  to          :string(255)      not null
#  from        :string(255)      not null
#  user_id     :string(255)
#

require 'spec_helper'

describe Request do
	
	it "has a valid factory" do
		FactoryGirl.create(:request).should be_valid
	end

	it "desk_id is not null" do
		FactoryGirl.build(:request, desk_id: nil).should_not be_valid
	end

	it "subject is not null" do
		FactoryGirl.build(:request, subject: nil).should_not be_valid
	end

	it "to is not null" do
		FactoryGirl.build(:request, to: nil).should_not be_valid
	end

	it "from is not null" do
		FactoryGirl.build(:request, from: nil).should_not be_valid
	end

	it "status_flag is not null" do
		FactoryGirl.build(:request, status_flag: nil).should_not be_valid
	end

	describe "method all_resolved_requests" do
		before :each do
			@user = FactoryGirl.create(:user)
			@other_user = FactoryGirl.create(:user)
			@req1 = FactoryGirl.create(:request, desk_id: 1, user_id: @user.id)
			@req2 = FactoryGirl.create(:request, desk_id: 1, user_id: @user.id)
			@req3 = FactoryGirl.create(:request, desk_id: 2, status_flag: 1, user_id: @user.id)
			@req4 = FactoryGirl.create(:request, desk_id: 3, user_id: @other_user.id)
			@req5 = FactoryGirl.create(:request, desk_id: 4, status_flag: 1, user_id: @other_user.id)

		end
		it "returns all resolved requests for current_user" do
			all_resolved =  Request.all_resolved_requests(@user.id)
			all_resolved.should include(@req3)
		end
		it "doesn't return anything else" do
			all_resolved = Request.all_resolved_requests(@user.id)
			all_resolved.should_not include(@req1, @req2, @req4, @req5)
		end
	end

	describe "method all_unresolved_requests" do
		before :each do
			@user = FactoryGirl.create(:user)
			@req1 = FactoryGirl.create(:request, desk_id: 1, user_id: @user.id)
			@req2 = FactoryGirl.create(:request, desk_id: 1, user_id: @user.id)
			@req3 = FactoryGirl.create(:request, desk_id: 2, status_flag: 1, user_id: @user.id)
			@req4 = FactoryGirl.create(:request, desk_id: 3, user_id: "23")
			@req5 = FactoryGirl.create(:request, desk_id: 4, status_flag: 1, user_id: "34")
		end
		it "returns all resolved requests for current_user" do
			all_unresolved =  Request.all_unresolved_requests(@user.id)
			all_unresolved.should include(@req1, @req2)
		end
		it "doesn't return anything else" do
			all_unresolved = Request.all_unresolved_requests(@user.id)
			all_unresolved.should_not include(@req3, @req4, @req5)
		end
	end

	it "belongs to desk" do
		request = FactoryGirl.create(:request)
		request.should belong_to(:desk)
	end

	it "has many parts" do
		should have_many(:parts)
	end
end
