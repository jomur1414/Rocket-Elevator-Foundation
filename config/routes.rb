Rails.application.routes.draw do


  devise_for :employees
  devise_for :users
  
  #get "users/sign_out" => 'pages#index'
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'pages#index'

  resources :leads

  # get 'userinfo' => 'pages#userinfo'

  delete 'userinfo' => 'pages#destroy'

  delete 'index' => 'pages#destroy'

  post 'root' => 'root#sendInformation'

  post 'index' => 'pages#create'
  
  post 'index' => 'pages#create'
  mount Blazer::Engine, at: "blazer"

  get 'home' => 'pages#home'
 
  #get 'newintervention' => 'interventions#newintervention'

  get 'corporate'  => 'pages#corporate'
  get 'test'  => 'pages#test'

  get 'residential'  => 'pages#residential'

  get 'submission' => 'quotes#submission'

  post 'submission' => 'quotes#create'

  get 'employee' => 'pages#employee'

  get 'submission' => 'pages#submission'
  
  get 'index' => 'pages#index'

  get 'users/index' => 'pages#index'
  
  get 'users/index' => 'pages#index'
  
  get 'employee' => 'pages#employee'
  
  get 'dashboard' => 'pages#dashboard'



  get 'dashboard/building' => 'dashboard#building'

  #post '/interventions' => 'interventions#create_intervention'

  post 'interventions' => 'interventions#create'
  get 'interventions' => 'interventions#interventions'

  get 'interventions/building' => 'interventions#building'
  get 'interventions/battery' => 'interventions#battery'
  get 'interventions/column' => 'interventions#column'
  get 'interventions/elevator' => 'interventions#elevator'

  resources :geolocations

  
end
