require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  poster_id  :integer
#  message    :text
#  parent_id  :integer
#  to_id      :integer
#  type       :integer
#  created_at :datetime
#  updated_at :datetime
#
