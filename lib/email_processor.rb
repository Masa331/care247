class EmailProcessor
	def self.process(email)
		@request = Request.new
		@request.save
		redirect_to root_url
	end
end