class HomeController < ApplicationController
  include StockApi
  before_action :authenticate_user!, except: [:index]
  before_action :broker?, only: [:broker_portfolio]

  def index
    @admins_pending = User.where(type: 'Admin', approved: false)
    @brokers_pending = User.where(type: 'Broker', approved: false)
    @buyers_pending = User.where(type: 'Buyer', approved: false)

    case current_user.type
    when 'Broker'
      redirect_to home_broker_portfolio_path
    when 'Buyer'
      redirect_to home_buyer_portfolio_path
    end
  end

  def broker_portfolio
    @stocks = current_user.stocks
    @stock = Stock.new
    @apple = @client.quote('AAPL')
  end

  def broker_show_stocks
    @stocks = current_user.stocks
  end

  def transactions
    case current_user.type
    when 'Broker'
      @transactions = Transaction.where(broker_id: current_user.id)
      @method = 'Sell'
    when 'Buyer'
      @transactions = current_user.transactions
      @method = 'Buy'
    when 'Admin'
      @transactions = Transaction.all
      @method = 'Buy'
    end
  end

  private

  def broker?
    redirect_to root_path unless current_user.type == 'Broker'
  end
end
