# == Schema Information
#
# Table name: user_points
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  points     :integer
#  created_at :datetime
#  updated_at :datetime
#  diff       :integer
#

require 'rails_helper'

RSpec.describe UserPoints, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
