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

	validates :desk_id, presence: true
	validates :status_flag, presence: true
	validates :subject, presence: true
	validates :to, presence: true
	validates :from, presence: true
	validates :user_id, presence: true
end
