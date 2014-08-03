# == Schema Information
#
# Table name: sign_up_codes
#
#  id         :integer          not null, primary key
#  code       :string(255)
#  user_id    :integer
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class SignUpCode < ActiveRecord::Base
  belongs_to :user
  scope :with_code, ->(code) { where(:code => code) }

end
