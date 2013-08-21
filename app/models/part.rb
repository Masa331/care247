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

class Part < ActiveRecord::Base
	belongs_to :request

	validates :request_id, presence: true
	validates :user_id, presence: true
end
