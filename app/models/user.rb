# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  street        :string(255)
#  city          :string(255)
#  zip_code      :string(255)
#  country       :string(255)
#  ic            :integer
#  dic           :string(255)
#  phone         :integer
#  email         :string(255)
#  password_hash :string(255)
#  password_salt :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class User < ActiveRecord::Base

	validates :name, presence: true
	validates :email, presence: true
end
