class Like < ActiveRecord::Base
  belongs_to :liker, foreign_key: :liker, class_name: 'User'
  belongs_to :message
end
