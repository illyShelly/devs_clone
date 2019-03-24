Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :developers, except: [:destroy] do
    resources :bookings, only: [:create]
    collection do
      get :bookmarked
    end
  end
  resources :bookmarked_developers, only: [:create, :destroy]
end
