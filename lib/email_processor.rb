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
			if req_id = extract_request_id(email[:subject])
				create_part(req_id,Request.find(req_id.to_i).id, email[:body])
			else
				new_request(email)
			end
		end

		def extract_request_id(subject)
			req_id = subject.slice /(?<=##)\d+|(?<=##\s)\d+/
		end

		def find_desk(mailboxes)
			mailboxes.each do |m|
				if desk = Desk.find_by(desks_mailbox: m)
					return desk.id
				end
			end
		end

		def find_user(desk_id)
			Desk.find(desk_id).user_id
		end

		def create_part(request_id, user_id, email_body)
			part = Part.new

			part.request_id = request_id
			part.user_id = user_id
			part.body = email_body

			part.save
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
			request.user_id = find_user(request.desk_id)

			request.save

			create_part(request.id, request.user_id, email[:body])
		end
	end