Rails.application.routes.draw do

  resources :timetabled_sessions
  mount EpiCas::Engine, at: "/"
  devise_for :users
  match "/403", to: "errors#error_403", via: :all
  match "/404", to: "errors#error_404", via: :all
  match "/422", to: "errors#error_422", via: :all
  match "/500", to: "errors#error_500", via: :all

  get :ie_warning, to: 'errors#ie_warning'
  get :javascript_warning, to: 'errors#javascript_warning'

  get "student", to: "student#code"
  post "student", to: "student#success"

  root to: "dashboard#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
