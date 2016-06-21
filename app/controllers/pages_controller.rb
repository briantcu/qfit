class PagesController < ApplicationController
  before_filter :verify_logged_in_html, only: [:get_started]
  before_filter :can_access_user, only: [:get_started]

  def sign_up
    render layout: 'full_page'
  end

  def get_started
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
    gon.push({
                 current_user_id: session[:current_user_id] || current_user.id
             })
    render template: 'pages/do_work'
  end

  private

  def can_access_user
    return unauthorized if current_user.nil?
    unauthorized unless (current_user.id == session[:current_user_id] ||
        (current_user.is_coach_of_user?(session[:current_user_id])) ||
        (current_user.is_super_user?))
  end


end