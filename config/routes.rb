Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show]
  get 'hello/index' => 'hello#index'
  get 'hello/link' => 'hello#link'
  resources :tweets do
    resources :likes, only: [:create, :destroy]
    
    resources :comments, only: [:create]
  end
  delete 'tweets/:id' => 'tweets#destroy'
  root 'hello#index'
end
