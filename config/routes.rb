Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"

  get 'admins/index'
  get 'admins/new/user'  => 'admins#new_user',   as: 'admins_new_user'
  post 'admins/new/user' => 'admins#create_user', as: 'admins_create_user'
  get 'admins/view/user/:id' => 'admins#view_user', as: 'admins_view_user'
  get 'admins/pending' => 'admins#pending', as: 'admins_pending'
end
