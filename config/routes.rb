Rails.application.routes.draw do

  resources :restaurants

  get 'restaurants' => 'restaurants#index'
end
