# == Schema Information
#
# Table name: faqs
#
#  id         :integer          not null, primary key
#  question   :text
#  answer     :text
#  created_at :datetime
#  updated_at :datetime
#

class Faq < ActiveRecord::Base
end
