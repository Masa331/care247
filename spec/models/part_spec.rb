# == Schema Information
#
# Table name: parts
#
#  id         :integer          not null, primary key
#  request_id :string(255)      not null
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#  user_id    :string(255)
#

require 'spec_helper'

describe Part do
	it "has a valid factory" do
		FactoryGirl.create(:part).should be_valid
	end

	it "has request_id" do
		FactoryGirl.build(:part, request_id: nil).should_not be_valid
	end

	it "belongs to request" do
		request = FactoryGirl.create(:part)
		request.should belong_to(:request)
	end
end
