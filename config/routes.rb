Rails.application.routes.draw do

  devise_for :users
  resources :restaurants do
    resources :reviews
  end

  get 'restaurants' => 'restaurants#index'

  get 'new' => 'restaurants#new'

  root to: 'restaurants#index'

end
