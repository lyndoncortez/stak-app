class HomeController < ApplicationController
  include StockApi

  before_action :authenticate_user!, except: [:index]
  before_action :broker?, only: [:broker_portfolio]
  before_action :buyer?, only: [:buyer_portfolio]

  def index
    @admins_pending = User.where(type: 'Admin', approved: false)
    @brokers_pending = User.where(type: 'Broker', approved: false)
    @buyers_pending = User.where(type: 'Buyer', approved: false)

    @transactions = Transaction.all

    if broker_signed_in?
      redirect_to home_broker_portfolio_path
    elsif buyer_signed_in?
      redirect_to home_buyer_portfolio_path
    end
  end

  def broker_portfolio
    @stocks = current_user.stocks
    @stock = Stock.new
    @top_list = @client.stock_market_list(:mostactive)
    @transactions = Transaction.where(broker_id: current_user.id)
  end

  def buyer_portfolio
    @buyer_stocks = current_user.user_stocks
    @buyer_total_stocks = BuyerStock.all
    @transactions = current_user.transactions
  end

  def broker_show_stocks
    @stocks = current_user.stocks
  end

  def buyer_show_stocks
    @buyer_stocks = current_user.user_stocks
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

  def buyer?
    redirect_to root_path unless current_user.type == 'Buyer'
  end
end
