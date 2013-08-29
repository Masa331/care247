require "spec_helper"

describe MyMailer do

	describe "welcome_email" do
		before :each do
			@user = FactoryGirl.build(:user, email: "petr@seznam.cz")
		end
		it "creates new mail in deliveries array" do
			expect{MyMailer.welcome_email(@user).deliver}.to change(ActionMailer::Base.deliveries, :count).by 1
		end
		describe "with right attributes for" do
			let(:email) do
				MyMailer.welcome_email(@user).deliver
				ActionMailer::Base.deliveries.last
			end
			it "has subject" do
				email.subject.should eq "Welcome to Care247"
			end
			it "has recipient" do
				email.to.should eq ["petr@seznam.cz"]
			end
			it "has sender" do
				# prohlednout Mail::AddressContainer
				email.from.should eq ["info@care247.cz"]
			end
			it "has body" do
				# projit cely Mail a metod encoded, decoded a to_s
				email.body.encoded.should have_text("Welcome to Care247")
			end
		end
	end

	describe "answer_request_email" do
		before :each do
			@user = FactoryGirl.create(:user, email: "petr@seznam.cz")
		end
		it "creates new email in deliveries array" do
			expect{MyMailer.answer_request_email(@user.id, "testovaci@podpora.cz", "testovaci predmet", "toto je v body").deliver}.to change(ActionMailer::Base.deliveries, :count).by 1
		end
		describe "with right attributes for" do
			let(:email) do
				MyMailer.answer_request_email("petr@seznam.cz", "testovaci@podpora.cz", "testovaci predmet", "toto je v body").deliver
				ActionMailer::Base.deliveries.last
			end
			it "subject" do
				email.subject.should eq "testovaci predmet"
			end
			it "recipient" do
				email.to.should eq ["petr@seznam.cz"]
			end
			it "sender" do
				# prohlednout Mail::AddressContainer
				email.from.should eq ["testovaci@podpora.cz"]
			end
			it "body" do
				# projit cely Mail a metod encoded, decoded a to_s
				email.body.encoded.should have_text("toto je v body")
			end
		end
	end
end
