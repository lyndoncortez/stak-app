class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_api

  def create
    begin
      @quote = @client.quote(stock_params)
      @stock = Stock.find_or_create_by(symbol: stock_params, name: @client.company(stock_params).company_name)
      @ohlc = @client.ohlc(stock_params)

      if @ohlc.include?("close")
        @stock.ohlc_close = @ohlc.close.price
        @stock.ohlc_open = @ohlc.open.price
        @stock.ohlc_high = @ohlc.high
        @stock.ohlc_low = @ohlc.low
      end

      @stock.latest_price = @quote.latest_price  
      @stock.change = @quote.change
      @stock.percent = @quote.change_percent_s

      if @stock.save
        redirect_to stocks_show_path(@stock)
      else
        render :search
      end

    rescue IEX::Errors::SymbolNotFoundError => e
      flash[:alert] = e.message
      redirect_to home_broker_portfolio_path
    end
  end

  def show
    @stock = Stock.find(stock_id_params)
    if @stock.percent.include?("-")
      @gain_loss = "loss"
    else
      @gain_loss = "gain"
    end
  end

  private

  def fetch_api
    @client = IEX::Api::Client.new(
      publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'],
      secret_token: ENV['IEX_API_SECRET_TOKEN'],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
  end

  def stock_params
    params[:symbol]
  end

  def stock_id_params
    params[:id]
  end

  def user_id_params
    params[:id]
  end
end
