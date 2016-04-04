class SignUpCode < ActiveRecord::Base
  belongs_to :user
  has_many :sent_codes, foreign_key: :code
end
