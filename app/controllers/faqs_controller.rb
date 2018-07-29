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

class FaqsController < ApplicationController

  # GET /faqs
  # GET /faqs.json
  def index
    @faqs = Faq.all
  end
end
