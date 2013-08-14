# == Schema Information
#
# Table name: desks
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  notificate :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Desk < ActiveRecord::Base
end
