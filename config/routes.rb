Rails.application.routes.draw do
  devise_for :users, controllers:{
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    unlocks: 'users/unlocks',
    invitations: 'users/invitations'
  }

  devise_scope :user do
    patch 'users/:id/resend_invitation', to: 'users/invitations#resend_invite'
  end

  get 'static_pages/landing_page'
  get 'static_pages/dashboard'

  resources :signups, only: [:edit, :update]
  resources :groups
  resources :dashboards, only: [:index]
  resources :analytics, only: [:index]

  authenticated :user do
    root :to => 'dashboards#index', as: :authenticated_root
  end
  root :to => 'static_pages#landing_page'
end
