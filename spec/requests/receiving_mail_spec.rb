require 'spec_helper'
require 'email_processor'

describe "incoming mail to application" do
	describe "through email processor" do
		context "with valid data" do
			context "if request doesn't exist" do
				before :each do
					FactoryGirl.create(:desk, desks_mailbox: "podpora@seznam.cz")
				end
				it "creates new request in database" do
					expect{EmailProcessor.process FactoryGirl.attributes_for(:email, subject: "novy dotaz")}.to change(Request, :count).by(1)
				end
				it "creates first part of new request" do
					expect{EmailProcessor.process FactoryGirl.attributes_for(:email, subject: "novy dotaz")}.to change(Part, :count).by(1)
				end
			end
			context "if request exists" do
				before :each do
					FactoryGirl.create(:desk, desks_mailbox: "podpora@seznam.cz")
					FactoryGirl.create(:request, user_id: 1, desk_id: 1)
				end
				it "doesn't create new request" do
					expect{EmailProcessor.process FactoryGirl.attributes_for(:email)}.not_to change(Request, :count)
				end
				it "creates new part for right request" do
					expect{EmailProcessor.process FactoryGirl.attributes_for(:email)}.to change(Part, :count).by(1)
				end
			end
		end
	end
end