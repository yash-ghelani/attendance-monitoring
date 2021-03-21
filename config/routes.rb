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

  #Dashboard Routes
  get '/lecturer', to: 'lecturer#home'
  get '/admin', to: 'admin#home'
  get '/student', to: 'student#code'
  get 'student/history', to: 'student#history'
  post 'student/success', to: 'student#success'

  #Lecturer Routes
  get '/lecturer/upcoming', to: 'lecturer#upcoming'
  get '/lecturer/previous', to: 'lecturer#previous'
  get '/timetabled_sessions/new', to: 'timetabled_sessions#new'


  #Lecturer Routes
  get '/lecturer/upcoming', to: 'student#code'
  get '/lecturer/previous', to: 'student#code'
  get '/lecturer/new', to: 'student#code'





  root to: "home#index"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
