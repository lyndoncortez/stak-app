class StocksController < ApplicationController
  include StockApi

  before_action :authenticate_user!

  def create
    @quote = @client.quote(stock_params)
    @company = @client.company(stock_params)
    @logo = @client.logo(stock_params)
    @stock = Stock.find_or_create_by(symbol: stock_params,
                                    name: @client.company(stock_params).company_name)

    @stock.latest_price = @quote.latest_price
    @stock.change = @quote.change
    @stock.percent = @quote.change_percent_s
    @stock.wk_high = @quote.week_52_high
    @stock.wk_low = @quote.week_52_low
    @stock.volume = @quote.iex_volume
    @stock.avg_volume = @quote.avg_total_volume
    @stock.mkt_cap = @quote.market_cap
    @stock.pe_ratio = @quote.pe_ratio
    @stock.logo = @logo.url
    @stock.description = @company.description

    if @stock.save
      redirect_to stocks_show_path(@stock)
    else
      render :search
    end
  rescue IEX::Errors::SymbolNotFoundError => e
    flash[:alert] = e.message
    redirect_to home_broker_portfolio_path
  end

  def show
    @stock = Stock.find(stock_id_params)
    @news = @client.news(@stock.symbol)
    @news_list = [@news.fifth, @news.second, @news.last]
    @gain_loss = if @stock.percent.include?('-')
                   'loss'
                 else
                   'gain'
                 end
  end

  def broker_add
    @stock = Stock.find(stock_id_params)
    @stock.users << current_user
    @stock.save
    redirect_to stocks_show_path(@stock)
  end

  def buy
    @user_stock = UserStock.find(user_id_params)
    @stock = @user_stock.stock
    @broker = @user_stock.user
  end

  def buyer_create
    @user_stock = UserStock.find(user_id_params)
    @stock = @user_stock.stock
    @broker = @user_stock.user
    @buyer_stock = BuyerStock.create(buyer_stock_params)
    @buyer_stock.user_id = current_user.id
    @buyer_stock.user_stock_id = @user_stock.id
    if @buyer_stock.save
      @transaction = current_user.transactions.create(stock_id: @stock.id, broker_id: @broker.id, quantity: @buyer_stock.quantity,
                                                      price: @buyer_stock.price, total: (@buyer_stock.quantity * @buyer_stock.price))
      @transaction.save
      flash[:notice] = "You have successfully purchased #{@buyer_stock.quantity} shares of #{@stock.symbol.upcase}"
      redirect_to home_transactions_path
    else
      render :buyer_new
    end
  end

  private

  def stock_params
    params[:symbol]
  end

  def stock_id_params
    params[:id]
  end

  def user_id_params
    params[:id]
  end

  def buyer_stock_params
    params.permit(:user_id, :user_stock_id, :quantity, :price)
  end
end
