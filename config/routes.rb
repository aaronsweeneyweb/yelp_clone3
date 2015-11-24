Rails.application.routes.draw do

  resources :restaurants

  get 'restaurants' => 'restaurants#index'

  get 'new' => 'restaurants#new'
end
