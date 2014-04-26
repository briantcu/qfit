# == Schema Information
#
# Table name: sent_codes
#
#  id         :integer          not null, primary key
#  code       :string(255)
#  receiver   :string(255)
#  used       :boolean
#  created_at :datetime
#  updated_at :datetime
#

class SentCode < ActiveRecord::Base
end
