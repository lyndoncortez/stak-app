Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"

  get 'admins/index'
  get 'admins/new/user'  => 'admins#new_user',   as: 'admins_new_user'
  post 'admins/new/user' => 'admins#create_user', as: 'admins_create_user'
  get 'admins/show/user/:id' => 'admins#show_user', as: 'admins_show_user'
  get 'admins/edit/user/:id' => 'admins#edit_user', as: 'admins_edit_user'
  put 'admins/edit/user/:id' => 'admins#update_user', as: 'admins_update_user'
  delete 'admins/edit/user/:id' => 'admins#cancel_user', as: 'admins_cancel_user'
  get 'admins/:id/approve'=> 'admins#approve_user', as: 'admins_approve_user'
  get 'admins/pending' => 'admins#pending', as: 'admins_pending'
end
