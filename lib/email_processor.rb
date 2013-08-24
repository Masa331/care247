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

	module EmailProcessor
		
		module_function

		def process(email)
			#if req_id = extract_request_id(email.subject)
			#	append_to_request(req_id , email.body)
			#else
			#	new_request(email)
			#end
			new_request(email)
		end

		def extract_request_id(subject)
			nil
		end

		def find_desk(mailboxes)
			mailboxes.each do |m|
				if desk = Desk.where(desks_mailbox: m)
			binding.pry
					
					desk.id
				end
			end
		end

		def append_to_request(request_id, email_body)
			nil
		#	Part.create(request_id: request_id, body: email_body, user_id:)
		end

		def extract_mails(to)
			mail_arry = []
			to.each do |t|
				mail_arry << t[:full]
			end
			mail_arry
		end

		def new_request(email)
			request = Request.new
			
			request.status_flag = 0
			request.subject = email[:subject]
			request.to = extract_mails email[:to]
			request.from = email[:from]
			request.desk_id = find_desk(extract_mails email[:to])

			request.save

			append_to_request(request.id, email[:body])
		end
	end