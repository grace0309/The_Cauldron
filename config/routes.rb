Rails.application.routes.draw do
  get 'favourites/update'
  devise_for :users
  root to: 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts  do
    resources :bookings, only: [ :create, :new]
   end

  resources :bookings do
    resources :reviews, only: [ :create, :new]
  end

  resources :search, only: [:index]
  resources :bookings, only: [ :show, :edit, :update, :destroy]
  resources :reviews, only: [ :edit, :update, :destroy]
  get "/dashboard", to: "pages#dashboard", as: :dashboard
end
