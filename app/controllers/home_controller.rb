class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @admins_pending = User.where(type: 'Admin', approved: false)
    @brokers_pending = User.where(type: 'Broker', approved: false)
    @buyers_pending = User.where(type: 'Buyer', approved: false)
  end
end
