# == Schema Information
#
# Table name: routine_messages
#
#  id               :integer          not null, primary key
#  daily_routine_id :integer
#  message          :text
#  created_at       :datetime
#  updated_at       :datetime
#

require 'rails_helper'

RSpec.describe RoutineMessage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
