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
  get '/groups/:group_id/group_routines/year/:year/month/:month/day/:day', to: 'group_routines#routine_by_date'
  post '/group_routines/:id/weights/:exercise_id', to: 'group_routines#add_weight'
  post '/group_routines/:id/sprinting/:sprint_id', to: 'group_routines#add_sprint'
  post '/group_routines/:id/warmups/:warmup_id', to: 'group_routines#add_warmup'
  post '/group_routines/:id/plyos/:plyometric_id', to: 'group_routines#add_plyo'
  post '/group_routines/:id/custom/:type/:name', to: 'group_routines#add_custom'

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
  get '/users/:user_id/daily_routines/year/:year/month/:month/day/:day', to: 'daily_routines#routine_by_date'
  post '/daily_routines/:id/weights/:exercise_id', to: 'daily_routines#add_weight'
  post '/daily_routines/:id/sprinting/:sprint_id', to: 'daily_routines#add_sprint'
  post '/daily_routines/:id/warmups/:warmup_id', to: 'daily_routines#add_warmup'
  post '/daily_routines/:id/plyos/:plyometric_id', to: 'daily_routines#add_plyo'
  put '/daily_routines/:id/close', to: 'daily_routines#close'
  put '/daily_routines/:id/skip', to: 'daily_routines#skip'
  get '/users/:user_id/daily_routines/skip_all', to: 'daily_routines#skip_all'
  post '/daily_routines/:id/custom/:type/:name', to: 'daily_routines#add_custom'

  resources :custom_exercises

  resources :groups

  resources :coach_accounts

  root :to => "home#index"

end
