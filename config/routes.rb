Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :portfolios do 
    resources :share_to_portfolios
  end
  resources :share_informations
  resources :shares
end
