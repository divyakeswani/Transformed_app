Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    unlocks: 'users/unlocks'
  }

  get 'static_pages/landing_page'
  get 'static_pages/dashboard'
  root "static_pages#landing_page"
end
