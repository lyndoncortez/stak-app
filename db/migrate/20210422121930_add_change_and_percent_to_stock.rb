class AddChangeAndPercentToStock < ActiveRecord::Migration[6.1]
  def change
    add_column :stocks, :change, :decimal
    add_column :stocks, :percent, :string 
  end
end
