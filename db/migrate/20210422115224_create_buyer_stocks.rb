class CreateBuyerStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :buyer_stocks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :user_stock, null: false, foreign_key: true

      t.timestamps
    end
  end
end
