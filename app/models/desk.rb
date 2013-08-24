# == Schema Information
#
# Table name: desks
#
#  id                  :integer          not null, primary key
#  name                :string(255)      not null
#  notificate          :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  resolved_requests   :integer          default(0)
#  unresolved_requests :integer          default(0)
#  user_id             :integer          not null
#  desks_mailbox       :string(255)
#

class Desk < ActiveRecord::Base

	belongs_to :user
	has_many :requests, dependent: :destroy

	# attr_reader :id
	
	validates :name, presence: true
	validates :user_id, presence: true
	validates :desks_mailbox, presence: true
	validates_numericality_of :resolved_requests, greater_than: -1
	validates_numericality_of :unresolved_requests, greater_than: -1
	
	def resolved_requests
		self.requests.where status_flag: 1
	end

	def unresolved_requests
		self.requests.where status_flag: 0
	end
end
