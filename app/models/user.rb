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
#  email         :string(255)
#  password_hash :string(255)
#  password_salt :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  phone         :string(255)
#  admin         :boolean
#

class User < ActiveRecord::Base

	# Regexp for email format validation. Only emails with numbers, letters, "-" and "." pass
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	# Variable for saving users input from form and then creating password_hash and password_salt from it. Not saved to database.
	attr_accessor :password

	before_save :encrypt_password

	validates :name, presence: true
	validates :email, presence: true, format:{with: VALID_EMAIL_REGEX}
	validates :password, presence: true
	validates :phone, numericality: true

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end
end
