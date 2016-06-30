class PagesController < ApplicationController
  before_filter :verify_logged_in_html, only: [:get_started]
  before_filter :can_access_user, only: [:get_started]

  def sign_up
    render layout: 'full_page'
  end

  def setup
    gon.push({
                 current_user_id: session[:current_user_id] || current_user.id
             })
    render template: 'pages/setup'
  end

  def schedule
    gon.push({
                 current_user_id: session[:current_user_id] || current_user.id
             })
    render template: 'pages/setup'
  end

  def do_work
    current_user_id = session[:current_user_id] || current_user.id
    routine = nil
    if params[:year].present?
      routine = DailyRoutine.get_routine_by_date(params[:month], params[:year], params[:day], current_user_id)
    end

    gon.push({
                 current_user_id: session[:current_user_id] || current_user.id,
                 routine: routine
             })
    render template: 'pages/do_work'
  end

  def setup_redirect
    redirect_to '/setup/goal'
  end

  def more_info
    gon.push({
                 new_user: session["devise.facebook_user"]
             })
    render layout: 'full_page'
  end

  private

  def can_access_user
    return unauthorized if current_user.nil?
    unauthorized unless (current_user.id == session[:current_user_id] ||
        (current_user.is_coach_of_user?(session[:current_user_id])) ||
        (current_user.is_super_user?))
  end


end