class SentCode < ActiveRecord::Base
  belongs_to :sign_up_code, foreign_key: :code, primary_key: :code
end
