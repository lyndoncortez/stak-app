class ChangeIntToBigInt < ActiveRecord::Migration[6.1]
  def change
    change_column :stocks, :volume, :bigint
    change_column :stocks, :avg_volume, :bigint
    change_column :stocks, :mkt_cap, :bigint
  end
end
