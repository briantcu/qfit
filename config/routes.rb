Qfit::Application.routes.draw do

  get '/schedule/program_type/:program_type_id/weight_schedule/:weight_schedule_id', to: 'workout_schedule_suggestions#retrieve_suggested_schedule'

  resources :program_types

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    post 'sign_in', to: 'users/sessions#create'

    get 'sign_out', to: 'users/sessions#destroy'

    get 'sign_up', to: 'users/registrations#new'
    post 'users', to: 'users/registrations#create'
  end

  resources :weekly_schedule_days

  resources :warmups

  resources :user_schedules

  resources :user_maxes

  resources :users
  post '/users/:user_id/fitness', to: 'users#fitness_assessment'
  get '/users/:user_id/calendar/year/:year_id/month/:month_id', to: 'users#get_calendar'

  resources :tips

  resources :sprint_detail_sequences

  resources :sprint_details

  resources :sprints

  resources :weight_sets

  resources :sent_codes

  resources :sign_up_codes

  resources :program_phase_lookups

  resources :program_day_sequences

  resources :program_days

  resources :programs

  resources :pod_invites

  resources :plyometrics

  resources :phases

  resources :performed_warm_ups

  resources :performed_sprints

  resources :performed_plyometrics

  resources :performed_exercises

  resources :one_rep_maxes

  resources :messages

  resources :likes

  resources :leaders

  resources :laps

  resources :group_schedule_days

  resources :group_schedules

  resources :group_routines

  resources :group_performed_warmups

  resources :group_performed_sprints

  resources :group_performed_plyos

  resources :group_performed_exercises

  resources :group_joins

  resources :group_custom_exercises

  resources :friends

  resources :faqs

  resources :exercise_types

  resources :exercises

  resources :day_exercises

  resources :daily_routines

  resources :custom_exercises

  resources :groups

  resources :coach_accounts

  root :to => "home#index"

end
