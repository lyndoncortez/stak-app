class DeleteDescriptionHeadlineSummaryFromStocks < ActiveRecord::Migration[6.1]
  def change
    remove_column :stocks, :description, :string
    remove_column :stocks, :headline, :string
    remove_column :stocks, :summary, :string
  end
end
