Qfit::Application.routes.draw do


  #***************** WEBSITE ******************
  get '/sign-up', to: 'pages#sign_up'
  get '/sign-up-coach', to: 'pages#sign_up_coach'
  get '/sign-in', to: 'pages#login'
  get '/forgot', to: 'pages#forgot'
  get '/more-info', to: 'pages#more_info'

  get '/setup/goal', to: 'pages#setup'
  get '/setup/quads', to: 'pages#setup'

  get '/setup/coach', to: 'pages#setup'
  get '/coach', to: 'pages#coaches'

  get '/fitness', to: 'pages#setup_redirect'
  get '/commitment', to: 'pages#setup_redirect'
  get '/program', to: 'pages#setup_redirect'
  get '/schedule', to: 'pages#schedule'

  get '/workout', to: 'pages#do_work'
  get '/quad-pod', to: 'pages#do_work'
  get '/quad-pod', to: 'pages#do_work'
  get '/progress', to: 'pages#do_work'
  get '/workout/:year/:month/:day', to: 'pages#do_work'
  get '/workout/:workout_id', to: 'pages#do_work'

  get '/', to: 'pages#home'
  get '/account', to: 'pages#account'
  get '/leaderboards', to: 'pages#leaders'

  #****************** API *********************
  post '/checkout', to: 'subscriptions#create'

  get '/schedule/program_type/:program_type_id/weight_schedule/:weight_schedule_id', to: 'workout_schedule_suggestions#retrieve_suggested_schedule'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations',
                                    passwords: 'users/passwords', omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    post 'sign_in', to: 'users/sessions#create'

    get 'sign_out', to: 'users/sessions#destroy'

    get 'sign_up', to: 'users/registrations#new'
    post 'users', to: 'users/registrations#create'

    put 'change_password', to: 'users/passwords#update'
    post 'forgot_password', to: 'users/passwords#forgot'
  end

  resources :weekly_schedule_days

  resources :warmups

  resources :user_schedules

  resources :user_goals

  resources :user_maxes

  resources :users
  post '/users/:id/fitness', to: 'users#fitness_assessment'
  get '/users/:id/calendar/year/:year_id/month/:month_id', to: 'users#get_calendar'
  get 'users/:id/progress/:chart_type/:period', to: 'users#get_progress'
  put '/users/:id/change_email', to: 'users#change_email'
  get '/username_exists/:username', to: 'users#username_exists'

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
  put '/pod_invites/:id/accept', to: 'pod_invites#accept'
  put '/pod_invites/:id/deny', to: 'pod_invites#deny'

  resources :plyometrics

  resources :phases

  resources :performed_warm_ups

  resources :performed_sprints

  resources :performed_plyometrics

  resources :performed_exercises

  resources :one_rep_maxes

  resources :messages
  get '/messages/user_id/:user_id', to: 'messages#conversation'

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
  get '/group_routines/:id/reset', to: 'group_routines#reset'

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
  put '/daily_routines/:id', to: 'daily_routines#update'
  put '/daily_routines/:id/skip', to: 'daily_routines#skip'
  put '/users/:user_id/daily_routines/skip_all', to: 'daily_routines#skip_all'
  post '/daily_routines/:id/custom/:type/:name', to: 'daily_routines#add_custom'
  get '/daily_routines/:id/reset', to: 'daily_routines#reset'
  get '/daily_routines', to: 'daily_routines#index'
  put 'daily_routines/:id/shared', to: 'daily_routines#shared'

  resources :custom_exercises

  resources :groups
  post '/groups/:id/users', to: 'groups#new_user'
  delete '/groups/:id/users/:user_id', to: 'groups#remove_user'
  get '/groups/:id/calendar/year/:year_id/month/:month_id', to: 'groups#get_calendar'
  get '/groups/:group_id/group_routines/year/:year/month/:month/day/:day', to: 'group_routines#routine_by_date'

  resources :coach_accounts
  delete '/coach_accounts/:id/users/:user_id', to: 'coach_accounts#delete_user'
  post '/coach_accounts/:id/send_invite', to: 'coach_accounts#send_invite'
  post '/view/users', to: 'coach_accounts#view_user'
  post '/view/groups', to: 'coach_accounts#view_team'

end
