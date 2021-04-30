Rails.application.routes.draw do
  devise_for :buyers
  devise_for :brokers
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"
  get 'home/transactions'
  get 'portfolio/broker' => 'home#broker_portfolio', as: 'home_broker_portfolio'
  get 'portfolio/buyer' => 'home#buyer_portfolio', as: 'home_buyer_portfolio'
  get 'portfolio/broker/stocks' => 'home#broker_show_stocks', as: 'home_broker_show_stocks'
  get 'portfolio/buyer/stocks' => 'home#buyer_show_stocks', as: 'home_buyer_show_stocks'

  post 'stocks/search' => 'stocks#create', as: 'stocks_create'
  get 'stocks/show/:id' => 'stocks#show', as: 'stocks_show'
  get 'stocks/chart' => 'stocks#chart', as: 'stocks_chart'
  put 'stocks/broker/add/:id' => 'stocks#broker_add', as: 'stocks_broker_add'
  get 'stocks/buyer/new/:id' => 'stocks#buy', as: 'stocks_buy'
  post 'stocks/buyer/create/:id' => 'stocks#buyer_create', as: 'stocks_buyer_create'

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
