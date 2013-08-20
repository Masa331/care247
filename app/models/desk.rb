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
#

class Desk < ActiveRecord::Base

	belongs_to :user
	has_many :requests
	
	validates :name, presence: true
	validates :user_id, presence: true
	validates_numericality_of :resolved_requests, greater_than: -1
	validates_numericality_of :unresolved_requests, greater_than: -1
	
end
