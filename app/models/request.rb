# == Schema Information
#
# Table name: requests
#
#  id          :integer          not null, primary key
#  created_at  :datetime
#  updated_at  :datetime
#  desk_id     :string(255)      not null
#  status_flag :integer          not null
#  subject     :string(255)      not null
#  to          :string(255)      not null
#  from        :string(255)      not null
#  user_id     :string(255)
#

class Request < ActiveRecord::Base
	belongs_to :desk
	has_many :parts, dependent: :destroy

	serialize :to

	validates :desk_id, presence: true
	validates :status_flag, presence: true
	validates :subject, presence: true
	validates :to, presence: true
	validates :from, presence: true
	validates :user_id, presence: true

	def self.all_resolved_requests(user_id)
		all_resolved_requests = Request.where user_id: user_id, status_flag: 1
	end

	def self.all_unresolved_requests(user_id)
		all_resolved_requests = Request.where user_id: user_id, status_flag: 0
	end
end
