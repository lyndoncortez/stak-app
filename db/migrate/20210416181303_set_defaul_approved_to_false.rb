class SetDefaulApprovedToFalse < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :approved, from: true, to: false
  end
end
