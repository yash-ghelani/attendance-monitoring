Rails.application.routes.draw do

  #Resource Controllers
  resources :session_registered_lecturers
  resources :session_attendances
  resources :timetabled_sessions

  #Devise Stuff
  mount EpiCas::Engine, at: "/"
  devise_for :users

  #Error pages
  match "/403", to: "errors#error_403", via: :all
  match "/404", to: "errors#error_404", via: :all
  match "/422", to: "errors#error_422", via: :all
  match "/500", to: "errors#error_500", via: :all
  get :ie_warning, to: 'errors#ie_warning'
  get :javascript_warning, to: 'errors#javascript_warning'

  #Dashboard Routes
  get '/lecturer', to: 'lecturer#home'
  get '/admin', to: 'admin#home'
  get '/student', to: 'student#home'
  post '/student/validate', to: 'student#validate'


  #Dev only routes TODO devOnly
  get '/set-student', to: 'home#set_student'
  get '/set-lecturer', to: 'home#set_lecturer'
  get '/set-admin', to: 'home#set_admin'
  
  #Index
  root to: "home#index"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
