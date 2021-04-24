class AddsVolumeWkHighMktCapToStocks < ActiveRecord::Migration[6.1]
  def change
    add_column :stocks, :wk_high, :decimal
    add_column :stocks, :wk_low, :decimal
    add_column :stocks, :volume, :decimal
    add_column :stocks, :avg_volume, :decimal
    add_column :stocks, :mkt_cap, :decimal
    add_column :stocks, :pe_ratio, :decimal
  end
end
