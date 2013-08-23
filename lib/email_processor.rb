#  Griddler in his mail object delivers:
# => to[] - array of hashes with: :token, :host, :email, :full, :name
# => :from
# => :subject
# => :body - everything above delimiter
# => :raw_text
# => :raw_html
# => :raw_body
# => attachments[] - array of attachments
# => headers{} - 
# => :raw_headers

class EmailProcessor
	def self.process(email)
		if req_id = extract_request_id(email.subject)
			append_to_request(req_id , email.body)
		else
			new_request(email)
		end
	end

	private

	def extract_request_id(subject)
		nil
	end

	def find_desk_by_mailbox(mailbox)
		Desk.where(desks_mailbox == mailbox).id
	end

	def append_to_request(request_id, email_body)
		Part.create(request_id: request_id, body: email_body, user_id:)
	end

	def new_request(email)
		request = Request.new
		
		request.status_flag = 0
		request.subject = email.subject
		request.to = email.to[:email]
		request.from = email.from
		request.desk_id = find_desk(email.to[:email])

		request.save
		
		append_to_request(request.id, email.body)
	end
end