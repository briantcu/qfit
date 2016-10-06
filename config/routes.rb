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
  get '', to: 'pages#home'
  get '/account', to: 'pages#account'
  get '/leaderboards', to: 'pages#leaders'

  #****************** API *********************
  post '/checkout.json', to: 'subscriptions#create'

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

  get '/warmups', to: 'warmups#index'
  get '/warmups/:id', to: 'warmups#show'

  get '/user_schedules/:id', to: 'user_schedules#show'
  post '/user_schedules', to: 'user_schedules#create'
  put '/user_schedules/:id', to: 'user_schedules#update'

  get '/user_goals', to: 'user_goals#index'

  get '/user_maxes', to: 'user_maxes#index'

  get '/users/:id', to: 'users#show'
  put '/users/:id', to: 'users#update'
  post '/users/:id/fitness', to: 'users#fitness_assessment'
  get '/users/:id/calendar/year/:year_id/month/:month_id', to: 'users#get_calendar'
  get 'users/:id/progress/:chart_type/:period', to: 'users#get_progress'
  put '/users/:id/change_email', to: 'users#change_email'
  get '/username_exists/:username', to: 'users#username_exists'

  get '/sprints', to: 'sprints#index'
  get '/sprints/:id', to: 'sprints#show'

  get '/pod_invites', to: 'pod_invites#index'
  get '/pod_invites/:id', to: 'pod_invites#show'
  post '/pod_invites', to: 'pod_invites#create'
  put '/pod_invites/:id/accept', to: 'pod_invites#accept'
  put '/pod_invites/:id/deny', to: 'pod_invites#deny'

  get '/plyometrics', to: 'plyometrics#index'

  get '/performed_warm_ups/:id', to: 'performed_warm_ups#show'
  put '/performed_warm_ups/:id', to: 'performed_warm_ups#update'
  delete '/performed_warm_ups/:id', to: 'performed_warm_ups#destroy'


  get '/performed_plyometrics/:id', to: 'performed_plyometrics#show'
  put '/performed_plyometrics/:id', to: 'performed_plyometrics#update'
  delete '/performed_plyometrics/:id', to: 'performed_plyometrics#destroy'

  get '/performed_sprints/:id', to: 'performed_sprints#show'
  put '/performed_sprints/:id', to: 'performed_sprints#update'
  delete '/performed_sprints/:id', to: 'performed_sprints#destroy'

  get '/performed_exercises/:id', to: 'performed_exercises#show'
  put '/performed_exercises/:id', to: 'performed_exercises#update'
  delete '/performed_exercises/:id', to: 'performed_exercises#destroy'

  get '/messages/user_id/:user_id', to: 'messages#conversation'
  get '/messages', to: 'messages#index'
  get '/messages/:id', to: 'messages#show'
  post '/messages', to: 'messages#create'
  delete '/messages/:id', to: 'messages#destroy'

  post '/likes', to: 'likes#create'
  delete '/likes/:id', to: 'likes#destroy'

  get '/leaders', to: 'leaders#index'

  get '/group_schedules/:id', to: 'group_schedules#show'
  post '/group_schedules', to: 'group_schedules#create'
  put '/group_schedules', to: 'group_schedules#update'

  get '/group_routines/:id', to: 'group_routines#show'
  get '/groups/:group_id/group_routines/year/:year/month/:month/day/:day', to: 'group_routines#routine_by_date'
  post '/group_routines/:id/weights/:exercise_id', to: 'group_routines#add_weight'
  post '/group_routines/:id/sprinting/:sprint_id', to: 'group_routines#add_sprint'
  post '/group_routines/:id/warmups/:warmup_id', to: 'group_routines#add_warmup'
  post '/group_routines/:id/plyos/:plyometric_id', to: 'group_routines#add_plyo'
  post '/group_routines/:id/custom/:type/:name', to: 'group_routines#add_custom'
  get '/group_routines/:id/reset', to: 'group_routines#reset'

  delete '/group_performed_warmups/:id', to: 'group_performed_warmups#destroy'
  put '/group_performed_warmups/:id', to: 'group_performed_warmups#update'

  delete '/group_performed_sprints/:id', to: 'group_performed_sprints#destroy'
  put '/group_performed_sprints/:id', to: 'group_performed_sprints#update'

  delete '/group_performed_plyos/:id', to: 'group_performed_plyos#destroy'
  put '/group_performed_plyos/:id', to: 'group_performed_plyos#update'

  delete '/group_performed_exercises/:id', to: 'group_performed_exercises#destroy'
  put '/group_performed_exercises/:id', to: 'group_performed_exercises#update'

  delete '/group_custom_exercises/:id', to: 'group_custom_exercises#destroy'

  get '/friends', to: 'friends#index'
  get '/friends/:id', to: 'friends#show'

  get '/faqs', to: 'faqs#index'

  get '/exercise_types', to: 'exercise_types#index'
  get '/exercise_types/:id', to: 'exercise_types#show'

  get '/exercises/:id', to: 'exercises#show'

  get '/daily_routines', to: 'daily_routines#index'
  get '/daily_routines/:id', to: 'daily_routines#show'
  put '/daily_routines/:id', to: 'daily_routines#update'
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
  post '/daily_routines', to: 'daily_routines#create'

  delete '/custom_exercises/:id', to: 'custom_exercises#destroy'

  get '/groups/:id', to: 'groups#show'
  post '/groups', to: 'groups#create'
  put '/groups/:id', to: 'groups#update'
  delete '/groups/:id', to: 'groups#destroy'
  post '/groups/:id', to: 'groups#change_group'
  get '/groups/:id/calendar/year/:year_id/month/:month_id', to: 'groups#get_calendar'
  get '/groups/:group_id/group_routines/year/:year/month/:month/day/:day', to: 'group_routines#routine_by_date'

  get '/coach_accounts/:id', to: 'coach_accounts#show'
  delete '/coach_accounts/:id/users/:user_id', to: 'coach_accounts#delete_user'
  post '/coach_accounts/:id/send_invite', to: 'coach_accounts#send_invite'
  post '/view/users', to: 'coach_accounts#view_user'
  post '/view/groups', to: 'coach_accounts#view_team'
  delete '/sign_up_codes/:id', to: 'coach_accounts#delete_code'

end
