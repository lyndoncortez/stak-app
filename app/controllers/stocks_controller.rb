class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_api

  def create
    @quote = @client.quote(stock_params)
    @company = @client.company(stock_params)
    @logo = @client.logo(stock_params)
    # @news = @client.news(stock_params)
    @stock = Stock.find_or_create_by(symbol: stock_params,
                                    name: @client.company(stock_params).company_name)
    # @ohlc = @client.ohlc(stock_params)

    # if @ohlc.include?('close')
    #   @stock.ohlc_close = @ohlc.close.price
    #   @stock.ohlc_open = @ohlc.open.price
    #   @stock.ohlc_high = @ohlc.high
    #   @stock.ohlc_low = @ohlc.low
    # end

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

  private

  def fetch_api
    @client = IEX::Api::Client.new(
      publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'],
      secret_token: ENV['IEX_API_SECRET_TOKEN'],
      endpoint: 'https://cloud.iexapis.com/stable'
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
