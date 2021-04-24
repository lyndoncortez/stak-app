class AddsDescriptionToStocks < ActiveRecord::Migration[6.1]
  def change
    add_column :stocks, :description, :string
    add_column :stocks, :headline, :string
    add_column :stocks, :summary, :string
  end
end
