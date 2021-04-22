class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :user_id 
      t.integer :stock_id
      t.integer :broker_id
      t.integer :quantity
      t.decimal :price
      t.decimal :total

      t.timestamps
    end
  end
end
