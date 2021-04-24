class ChangeDecimalToInt < ActiveRecord::Migration[6.1]
  def change
    change_column :stocks, :volume, :integer
    change_column :stocks, :avg_volume, :integer
    change_column :stocks, :mkt_cap, :integer
  end
end
