Rails.application.routes.draw do


  get "api" => "api#index"
  get "api/l/:id" => "api#by_location", as: :api_by_location
  get "api/l/:id/f/:floor_id" => "api#by_floor", as: :api_by_floor


  match 'trackers/logon' => 'trackers#logon', as: :trackers_logon, via: [:get, :post]
  match 'trackers/logoff' => 'trackers#logoff', as: :trackers_logoff, via: [:get, :post]
  match 'trackers/ping' => 'trackers#ping', as: :trackers_ping, via: [:get, :post]

  resources :locations do

    resources :floors do
      post :sort, on: :collection
    end

    resources :areas do
      get :attach_computers_form, on: :member
      get :computer_list, on: :member
      patch :attach_computers, on: :member
    end
  end

  resources :images

  ## DASHBOARD
  root 'status#index'


end
