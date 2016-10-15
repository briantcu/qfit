class PagesController < ApplicationController
  before_action :verify_logged_in_html, only: [:coaches, :account]
  before_action :verify_is_coach, only: [:coaches]
  before_action :set_gon_info, only: [:coaches, :account]

  def home
    render template: 'pages/home'
  end

  def account
    render template: 'pages/account'
  end

  def coaches
    render template: 'pages/coaches'
  end

  def leaders
    gon.push(
        {
            current_user_id: current_user.id
        }
    )
    render template: 'pages/leaders'
  end

  private

  def verify_is_coach
    unless current_user.is_coach?
      redirect_to '/'
    end
  end

  def set_gon_info
    gon.push(
        {
            user_id: current_user.id,
            is_coach: current_user.is_coach?,
            is_sub_user: current_user.is_sub_user?,
            is_individual: current_user.is_individual?,
            coach_account_id: current_user.coach_account.try(:id)
        }
    )
  end
end