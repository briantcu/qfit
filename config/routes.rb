Qfit::Application.routes.draw do
  resources :program_types

  devise_for :users
  resources :weekly_schedule_days

  resources :warmups

  resources :user_schedules

  resources :user_maxes

  resources :users

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
