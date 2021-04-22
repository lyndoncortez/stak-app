class AddsOhlcToStock < ActiveRecord::Migration[6.1]
  def change
    add_column :stocks, :ohlc_close, :decimal
    add_column :stocks, :ohlc_open, :decimal
    add_column :stocks, :ohlc_high, :decimal
    add_column :stocks, :ohlc_low, :decimal
  end
end
