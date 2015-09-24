Rails.application.routes.draw do


  get "api" => "api#index"


  match 'trackers/logon' => 'trackers#logon', as: :trackers_logon, via: [:get, :post]
  match 'trackers/logoff' => 'trackers#logoff', as: :trackers_logoff, via: [:get, :post]
  match 'trackers/ping' => 'trackers#ping', as: :trackers_ping, via: [:get, :post]

  resources :locations
  resources :images

  ## DASHBOARD
  root 'status#index'


end
