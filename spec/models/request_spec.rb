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

	it "belongs to desk" do
		request = FactoryGirl.create(:request)
		request.should belong_to(:desk)
	end

	it "has many parts" do
		should have_many(:parts)
	end
end
