class BuyerStock < ApplicationRecord
  belongs_to :user
  belongs_to :user_stock
end
