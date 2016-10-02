# == Schema Information
#
# Table name: sign_up_codes
#
#  id              :integer          not null, primary key
#  code            :string(255)
#  user_id         :integer
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  sign_up_type    :string
#  sent_to         :string
#  sent_to_type    :string
#  used            :boolean          default(FALSE)
#  group_id        :integer
#  program_type_id :integer
#  redeemed_at     :datetime
#

# sign_up_type: 'member', 'team'
# sent_to_type: 'phone', 'email'

class SignUpCode < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  validates_presence_of :user_id, :code, :sign_up_type, :sent_to, :sent_to_type, :group_id
  scope :unused, -> {where(used: false)}

  def self.unique_code
    code = loop do
      random_token = SecureRandom.hex(3)
      break random_token unless SignUpCode.where(code: random_token).present?
    end
    code
  end
end
