Rails.application.routes.draw do




  get "api" => "api#index"
  get "api/l/:id" => "api#by_location", as: :api_by_location
  get "api/l/:id/f/:floor_id" => "api#by_floor", as: :api_by_floor
  get "api/l/:id/a/:area_id" => "api#by_area", as: :api_by_area
  get "api/preview" => "api#preview", as: :api_preview


  match 'trackers/logon' => 'trackers#logon', as: :trackers_logon, via: [:get, :post]
  match 'trackers/logoff' => 'trackers#logoff', as: :trackers_logoff, via: [:get, :post]
  match 'trackers/ping' => 'trackers#ping', as: :trackers_ping, via: [:get, :post]

  get "status/:status" => "status#by_status", as: :by_status

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

  resources :images do
    resources :software_packages, path: "software"
    patch :attach_computers_to, on: :member
  end

  ## DASHBOARD
  root 'status#index'


end
