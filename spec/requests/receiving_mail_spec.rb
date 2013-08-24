require 'spec_helper'
require 'email_processor'

describe "incoming mail to application" do
	describe "through email processor" do
		context "with valid data" do
			context "as new request" do
				it "creates new request in database" do
					#binding.pry
					FactoryGirl.create(:desk, desks_mailbox: "podpora@seznam.cz")
					expect{EmailProcessor.process FactoryGirl.attributes_for(:email)}.to change(Request, :count).by(1)
				end
			end
		end
	end
end