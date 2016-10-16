# == Schema Information
#
# Table name: subscription_events
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  subscription_id     :string
#  event               :string
#  stripe_event_id     :string
#  subscription_status :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class SubscriptionEvent < ActiveRecord::Base
end
