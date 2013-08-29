class MyMailer < ActionMailer::Base
	default from: "info@care247.cz"

	def welcome_email(user)
		@user = user
		mail(to: @user.email, subject: 'Welcome to Care247')
	end

	def answer_request_email(to, from, subject, text)
		@text = text
		mail(to: to, subject: subject, from: from)
	end
end
